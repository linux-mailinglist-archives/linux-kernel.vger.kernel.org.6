Return-Path: <linux-kernel+bounces-309356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D40966950
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF571F2478C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312E1BD018;
	Fri, 30 Aug 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gSKuCCHE"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69D1DA22
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045074; cv=none; b=RMmYLVg5Za3matjOPOXvtqKtyWTdS8aVKa2kzgNqtngLHK6zrCWkXX2y2mnuhZrT/EvC/gQ74x9y9BfAuAy/Z+qHBSV8/tmmz5LDC7qlSme0WNBGA+fG3MAUayp/qixVaEHzH0hiD3O8RoBi3nOqgNppgYKJuR6espFZkN8qswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045074; c=relaxed/simple;
	bh=fN/gboV7mvM7orgTeMr0F/zHqUjc1KBHYhBJbJZi8u4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KvqMAwBhrZwJrO2Y3XvtWb8aaCrIZvTs7oySLWwo8tyfzDH+qn+nTBy+DyBshmfcFZXUAD0VzECSEUYqJ9gFMogrnHr5QFkis68LmhdkvydDK2gEtqiO/YSiWn/O6eeYAmax+Pi1Gpf+UFocA3J9flr7p8SaFVV08rQm2efZNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gSKuCCHE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725045070;
	bh=fN/gboV7mvM7orgTeMr0F/zHqUjc1KBHYhBJbJZi8u4=;
	h=From:To:Cc:Subject:Date:From;
	b=gSKuCCHE4gBeMZRx+oLs9ARmR2oc8omZlV+qHRV5yaono5m8lJHNtvoAP2beL+/N6
	 R0tdtPFbq9eeocXee+RlTq7qIdxEBMLRhfIfkkgkjwvp8gWGzICtA7eIHPdwDLz6qU
	 55LGtuoOpltscQROa9HiheCaWc3xq2lVnvH6MnplTKUQs8AjiVxDaIG2RwvokU3GLD
	 S0NFnkF4YYpJdCYeoVCWb2i6C9ujYVJpohAJ+3YwupVVuY7W5l9LQNIzHkXYP6XeOH
	 eKE5pGRCHzmSjC0TWMuNM8jzeyeac0SsSmZKmJkaZRKy9bPF/0NTqv2049PZTBWzWk
	 Qj3pnAlXNqOtg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwSRf5Gstz1Jjx;
	Fri, 30 Aug 2024 15:11:10 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 0/6] lib: Extend bitmap find binary operations
Date: Fri, 30 Aug 2024 15:10:37 -0400
Message-Id: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend bitmap find.h and cpumask.h with additional binary operations
such as "nor".

Also extend the testing and benchmark coverage of those bitmap find with
binary operations.

This is useful for NUMA-aware rseq concurrency IDs which depend on this
series. The series can be found at:

https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/


Mathieu Desnoyers (6):
  lib: Clarify comment on top of find_next_andnot_bit
  lib: Implement find_{first,next,nth}_nor_bit, for_each_nor_bit,
    find_first_andnot_bit
  lib: test bitmap sets binary operation iterators
  lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
  lib: benchmark bitmap sets binary operation find
  cpumask: Implement cpumask_{first,next}_{nor,andnot}

 include/linux/cpumask.h  |  60 ++++++++++++++++
 include/linux/find.h     | 124 +++++++++++++++++++++++++++++++--
 lib/find_bit.c           |  36 ++++++++++
 lib/find_bit_benchmark.c | 143 +++++++++++++++++++++++++++++++++------
 lib/test_bitmap.c        |  81 ++++++++++++++++++++++
 5 files changed, 418 insertions(+), 26 deletions(-)

-- 
2.39.2

