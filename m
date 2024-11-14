Return-Path: <linux-kernel+bounces-410007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF49C955E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43E7B24826
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C781B0F0E;
	Thu, 14 Nov 2024 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mCpdTTVO"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF221AC8A6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624590; cv=none; b=N0Q8mmVK2GjMZNVCc2jXgvaJMwJ8yZr3dhaaaH7a/YMUtz3xNePQV1FN04vdrIBQoAH+gjHVBUstgG9D0eqwEBV6ute15EJOZGPjZgDxc3um5lZt/yDi2fqGS4Nbsrns6YkXyCaUH64MxyRBM1BGfp2rMg9+IWPQFEcdcxq9zYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624590; c=relaxed/simple;
	bh=zSthh6vL8HKAWpJY6qbIAeSh+tPxUtxlWiC3j3GbDxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvnOpFgiWR+sdKikFTs5TBHqHKDZGV3yYb9YIJbqqYHlIaHk/wLDSOiha1OxyXAfch7AwAvuuQKYINFT9zP5jPp1EGNzQCuaTjzWbSSR6u2f5NOugOTGhFH1c7HdMVal4AxeQYqpWng7nzzr1ufbba4DF97OXF9W1KyX9Wvgjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mCpdTTVO; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731624585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mE/4aODK3iFoMljHZ501eGjRz55mNrbevxVXkrAorLI=;
	b=mCpdTTVOtJ1iYMbKWu3nV3Y9hCa/SfeOiWtwlRtt5kfc/408Q5LX3zIQn1iEuicCatIC7R
	dd+uPdI5NYAf0ul+aYuDbp87J3kY4xeDMId/8S53xQZtnryN5uSQvGukCM98bu4Mm/B9UJ
	t9hRspuR9fdKWfl+sXg3PWN5WveShnA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Michal Simek <monstr@monstr.eu>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: mb: Use str_yes_no() helper in show_cpuinfo()
Date: Thu, 14 Nov 2024 23:46:49 +0100
Message-ID: <20241114224649.57946-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/microblaze/kernel/cpu/mb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/kernel/cpu/mb.c b/arch/microblaze/kernel/cpu/mb.c
index 9581d194d9e4..37cb2898216b 100644
--- a/arch/microblaze/kernel/cpu/mb.c
+++ b/arch/microblaze/kernel/cpu/mb.c
@@ -66,10 +66,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   " MSR:\t\t%s\n"
 		   " PCMP:\t\t%s\n"
 		   " DIV:\t\t%s\n",
-		   (cpuinfo.use_instr & PVR0_USE_BARREL_MASK) ? "yes" : "no",
-		   (cpuinfo.use_instr & PVR2_USE_MSR_INSTR) ? "yes" : "no",
-		   (cpuinfo.use_instr & PVR2_USE_PCMP_INSTR) ? "yes" : "no",
-		   (cpuinfo.use_instr & PVR0_USE_DIV_MASK) ? "yes" : "no");
+		   str_yes_no(cpuinfo.use_instr & PVR0_USE_BARREL_MASK),
+		   str_yes_no(cpuinfo.use_instr & PVR2_USE_MSR_INSTR),
+		   str_yes_no(cpuinfo.use_instr & PVR2_USE_PCMP_INSTR),
+		   str_yes_no(cpuinfo.use_instr & PVR0_USE_DIV_MASK));
 
 	seq_printf(m, " MMU:\t\t%x\n", cpuinfo.mmu);
 
@@ -120,7 +120,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 	seq_printf(m,
 		   "HW-Debug:\t%s\n",
-		   cpuinfo.hw_debug ? "yes" : "no");
+		   str_yes_no(cpuinfo.hw_debug));
 
 	seq_printf(m,
 		   "PVR-USR1:\t%02x\n"
-- 
2.47.0


