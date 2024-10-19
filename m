Return-Path: <linux-kernel+bounces-373015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFED9A509C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9CE1C20AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D01917D7;
	Sat, 19 Oct 2024 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="pHX9IpIL"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D5190688
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367844; cv=none; b=BVfL2wXVEK077nEnnFBTydpFnGbjERByFM7i7WV3RQDeDFFB0tx2FuVpigt240m7odAaV20ZSY5UUACrI1ph1TBLWwLgJNQaPpgtjzztNT3Q83neVB7ruPUHMgIDUSk0dmCAKeQPLe9IvCQaz0lV47HiDuIsFqxFbli1zPKHHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367844; c=relaxed/simple;
	bh=rbDsl3guE2D9QHGVw/TooNST7vP+mdZMY+3vCZ7AxnA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vo7fJT+AQZZ6WoOuE3sa78/PI3FNRxi2lljTDcaqHWhFGyROSGU1t9TwTMT+J+7X3FHyDRxU74xQ7VAQ4qANtdUZFckrAaLGeXGp3FNYnTM9MlaEs0qIdxbjOhIf1q8e+msM6koQ4YWdWG8ucfdLwRq5e8bQHTKmFxEpU7LtPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=pHX9IpIL; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id E32A31770FF; Sat, 19 Oct 2024 19:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729367835; bh=rbDsl3guE2D9QHGVw/TooNST7vP+mdZMY+3vCZ7AxnA=;
	h=Date:From:To:Subject:From;
	b=pHX9IpIL7cT7SgbWV9/8QbmOMJJT66AkKZkbEVhe8YtY5OTC7w6nTfMQFA++zmuKZ
	 NMiiKU0dVeC/XsTTl2Ts5x/C/IFWIBYnjtlv60oQ3p8TrHPrGjvE/plIDykY6gixkb
	 0t6dySdmkVJc0O56YQnSnpcbx0SfRKQOjr4GjsNTlx/qcIBl3DW8i5TsniT8Hj/00x
	 XzFMEP2BxaZH14IMPAN270RcdVwQ3P4S2wc2Gg5gnkHhoK7k40yJdaZICdej+J5P5P
	 E1Vu8Jj9z1tj7ZGwVRPQg7lUHdDk6F6pFuWjQWsGC9GlO58l4VHXaZ1sReu56xN9a7
	 Q5F34T/kGukqw==
Date: Sat, 19 Oct 2024 19:57:15 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KDB: Fix incorrect treatment of numbers in the CLI
Message-ID: <20241019195715.GA810861@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: In many cases, KDB treats invalid commands as numbers and
instead of printing a usage error, goes ahead and just prints the number
in hex

Example: This can be demonstrated when typing for example "aaazzz", this
confuses KDB into thinking this is the hexadecimal 0xAAA

Solution: Before assuming that the input from the user is a number,
check that it contains only characters that represent numbers.
Also, along the way, transition to using kstrtoul instead of
simple_strtoul (better practice as stated in the definition of the
function)

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f5f7d7fb5936..4efdc4d25a59 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -402,18 +402,18 @@ static void kdb_printenv(void)
  */
 int kdbgetularg(const char *arg, unsigned long *value)
 {
-	char *endp;
 	unsigned long val;
 
-	val = simple_strtoul(arg, &endp, 0);
+	if ((strpbrk(arg, hex_asc) == NULL)
+	 && (strpbrk(arg, hex_asc_upper) == NULL))
+		return KDB_BADINT;
 
-	if (endp == arg) {
+	if (kstrtoul(arg, 0, &val) != 0) {
 		/*
 		 * Also try base 16, for us folks too lazy to type the
 		 * leading 0x...
 		 */
-		val = simple_strtoul(arg, &endp, 16);
-		if (endp == arg)
+		if (kstrtoul(arg, 16, &val) != 0)
 			return KDB_BADINT;
 	}
 
-- 
2.39.2

