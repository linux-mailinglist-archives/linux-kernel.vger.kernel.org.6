Return-Path: <linux-kernel+bounces-329652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D597944F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 04:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A891F21BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD2323D;
	Sun, 15 Sep 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h+TQD6nZ"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F6DDDCD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366168; cv=none; b=anyUh1rrnnsr6OglN1uFuRWA6pC50BvzmvS4MVdsUm59r+e+bLqeIemJPPaIbTze0Tp3A40UGZPNwXQ8FL9Hzyd9yFKeX+AiohL1O3YMTx413HF9WcH/MqDlH7LHf5Gob3QdvCybMFaP0AeOCB7ucoFnAuFkii+uwlx56JKnOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366168; c=relaxed/simple;
	bh=zNcUu92O+CsHsDDRBkabwIsJ5Q3n32aLPUBYPt2rvJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+lN0SSRwIl+uNooJx8Jjo5iNOy/VVAjh+4dZkNrSPoz6H7qSEF6n5p7MakZ5cS0+374A2xbJ1cJ8ra1rZScjtSc+95YWXFyi37PPk2b8xZhj338Msnq2WDifEX735h4wEzo8c3U87xV6DHxPgbOSnlNK7QrIhFs6w+ZYmt8Qtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h+TQD6nZ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726366164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IzRMxXd5ikdNUDyoBBzzoqxy/I4G7J8s+nsmc1Un8Wc=;
	b=h+TQD6nZCYzb+m2lfzzpysJMGPgiQv6Z2Ri604MFzZCHHou2/ZYBHhHlTO2d+TVwBeXvut
	vmMFiaUTluK8/6XXsCBb7xXBCZkMFA5PC30lC48s4NpHEBpyZNUN30ETyXM6n5VhM+gHR4
	MM+JRk4uWgEKSctznkizor2ODsmB87k=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 0/5] sysctl: encode the min/max values directly in the table entry
Date: Sun, 15 Sep 2024 10:08:26 +0800
Message-Id: <cover.1726365007.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Many modules use these additional static/global variables (such as
two_five_five, n_65535, ue_int_max, etc.) in the boundary checking of
sysctl, and they are read-only and never changed.

Eric points out: "by turning .extra1 and .extra2 into longs instead of
keeping them as pointers and needing constants to be pointed at somewhere
.. The only people I can see who find a significant benefit by
consolidating all of the constants into one place are people who know how
to stomp kernel memory."

This patch series achieves direct encoding values in table entries and still
maintains compatibility with existing extra1/extra2 pointers.
Afterwards, we can remove these unnecessary static variables progressively and
also gradually kill the shared const array.

Wen Yang (5):
  sysctl: add helper functions to extract table->extra1/extra2
  sysctl: support encoding values directly in the table entry
  sysctl: add KUnit test code to check for encoding  min/max in table
    entries
  sysctl: delete mmap_rnd_bits_{min/max} and
    mmap_rnd_compat_bits_{min/max} to save 16 bytes
  sysctl: delete six_hundred_forty_kb to save 4 bytes

 fs/proc/proc_sysctl.c  |  29 +-
 include/linux/mm.h     |   4 -
 include/linux/sysctl.h |  95 ++++++-
 kernel/sysctl-test.c   | 581 +++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        |  45 ++--
 mm/mmap.c              |   4 -
 6 files changed, 708 insertions(+), 50 deletions(-)

-- 
2.25.1


