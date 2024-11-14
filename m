Return-Path: <linux-kernel+bounces-409533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B89C8E26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33111F22E91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE019ADA2;
	Thu, 14 Nov 2024 15:28:15 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E4187550
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598094; cv=none; b=McDaVTRBe/MnOYh3Be20OtVCL9p2POTV08A9KornssjifgeeMY9mwj7gOVtHUo8PrGYf9hrwEQ8JVmchumEcX3sS/Uf2kwrt9TbtQndxpLai5RDdby8vgdlM9cbQdI+UNXS7MSRYU2w5QhkteOlAmrpwVNO/gIW/1RNU82byqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598094; c=relaxed/simple;
	bh=Pm/CgwBtWkxWxUZuMOFp63JZJIb7y8E8r3p76tvSFBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5zDOebY1vPgbOfD9qjAAcHpr5jPuETsntJm+54LyGZjQhpY/mI5FYtd6c5aeZ3pWvRmjaO7KS+pKa26EgeugRxWvlhuLRlfgxC1OsBlU9eDiFSMNhA5yY9pB01YagtGQpxsG/MLuhNbroJbox/uJHPzR6yVWWWdT0Gfm/9SmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tBbkp-000000008IN-1bVR;
	Thu, 14 Nov 2024 10:27:31 -0500
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
Subject: [PATCH 0/2 v2] x86,tlb: context switch optimizations
Date: Thu, 14 Nov 2024 10:26:15 -0500
Message-ID: <20241114152723.1294686-1-riel@surriel.com>
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

The patch placing the mm_cpumask test inside the prev == next
branch behind CONFIG_DEBUG_VM got merged into x86/mm already,
so here are the other two.

The approach used in v2 to ensure the call to flush_mm_tlb_range()
from __text_poke() remains a noop is to clear the CPU from the
mm_cpumask of poke_mm. Fix suggested by Peter Zijlstra.

That way the only thing flush_mm_tlb_range() really ends up
doing is increment the tlb_gen, resulting in future users of
poke_mm flushing the TLB.


