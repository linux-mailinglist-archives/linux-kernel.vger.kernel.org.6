Return-Path: <linux-kernel+bounces-402553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B69C28F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E73C283DD4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD40618E1A;
	Sat,  9 Nov 2024 00:40:11 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045BC1C6B8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112811; cv=none; b=qXfFCXAQ/5RfmOMM5C0m1y7SMji5FT1QKo8OGNDrGQT6pAbsPgERyl+tNfXCULtZRfyb1P75+GoumghSCbNBtmAk5e6aIjcICXOvgW006tXMPDXjT+vO5FukOrL+/BErgO1R1LQwPaVnk7C69MUDUMtKcMN2CMQl7Pp6FJnJpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112811; c=relaxed/simple;
	bh=6DKrbPWM5WJ8rMMc2eA+Jjh6vaY8Qav8ogELZAOdMn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kfskaq/+GTDugcMBVE7E2ZL9nNPIZ6LRLmZnRWKFcHPYD3ozqL1lbSMgEAYpr7KKL2yc2Iu9jgu1jvCMgCsJ4c1ieg+reloOrg6iJhjDFPbS/qcNKrNpWnBNLdIzJA6VGV5u3DaAvkQJftROEQvlq9ePs6Z5rm1OG7wyDUBWx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1t9ZTn-000000004fJ-3UnF;
	Fri, 08 Nov 2024 19:37:31 -0500
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	kernel-team@meta.com,
	hpa@zytor.com
Subject: [PATCh 0/3] x86,tlb: context switch optimizations
Date: Fri,  8 Nov 2024 19:27:47 -0500
Message-ID: <20241109003727.3958374-1-riel@surriel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

While profiling switch_mm_irqs_off with several workloads,
it appears there are two hot spots that probably don't need
to be there.

The first is the atomic clearing and setting of the current
CPU in prev's and next's mm_cpumask. This can create a large
amount of cache line contention. On a web server, these two
together take about 17% of the CPU time spent in switch_mm_irqs_off.

We should be able to avoid much of the cache line thrashing
by only clearing bits in mm_cpumask lazily from the first
TLB flush to a process, after which the other TLB flushes can
be more narrowly targeted.

A second cause of overhead seems to be the cpumask_test_cpu
inside the WARN_ON_ONCE in the prev == next branch of
switch_mm_irqs_off.

This warning never ever seems to fire, even on a very large
fleet, so it may be best to hide that behind CONFIG_DEBUG_VM.
With the web server workload, this is also about 17% of
switch_mm_irqs_off.


