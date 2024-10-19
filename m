Return-Path: <linux-kernel+bounces-373028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A659A50CA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 22:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E581C2151D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3BA1922E3;
	Sat, 19 Oct 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="vPXF3yvG"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9713C682
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729370534; cv=none; b=TRZLJQxwRyPmu/u4rTt60Bxkg/A75rYaX42WLnFq6eA9VymXwkrBuwL8Knq0XCCcxkqaq5E09K78O04s93A20grGAXudbcRCEuRh1FW8l5K9R8i+0dJc9i18g4KJB3m0B1r9jUe0kVFXapgSRjhFNofqHEg/8MXjmYvKZDn71es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729370534; c=relaxed/simple;
	bh=ye+sQb4lcoOQCfVxdUhggBdY5bpunrH2WtgJp84HDHk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKV3S6LY65ydMEVWnYIvhqF9zOiNE+n+Jq70R3THlwzO9IBu0JKvYitLS0NyHks0NG+KsrYIVFve6ePRad3XtAS/e7G7Rzdu1Wrqj7M3b1H/KAvoS1xT66fTAQxnPcptIXze+w9/0YRIE5jQf/aa0UJXypoYeGrCDDvFYLJXeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=vPXF3yvG; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 41DC21770FF; Sat, 19 Oct 2024 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729370532; bh=ye+sQb4lcoOQCfVxdUhggBdY5bpunrH2WtgJp84HDHk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=vPXF3yvGzoTaX36QmS5Ubhia6Efa+0RX/GIDyYARchI2/uBcKRKOsk4FtFpBMD2wY
	 IzOc8D/0qAQ23xnglP3TddH0X+QomOYCRJdmA9LVJSgC3MOy0YrwL0wNaNfkv/FOh2
	 JvpDdB1ttreZCsuWf0+T7L4IWt/fAN+BkalIDP9eIFlsfjVxOWlKdftqhkfEMXs7PZ
	 hN5ZTN7OYPDkgNNRprtA43zzB/QwGJuwpBA/31T6MaHFKAKLRX/O1ykazKD/LyrpK5
	 mq8svYhEoKzqdEL3Wniw3pBTL8Vz/WvlSPGRbjw2L3r6YnLENgxdsKWylUrt17GylR
	 /ttUDrubo3cYg==
Date: Sat, 19 Oct 2024 20:42:12 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] KDB: Fix incorrect treatment of numbers in the CLI
Message-ID: <20241019204212.GA811391@lichtman.org>
References: <20241019195715.GA810861@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019195715.GA810861@lichtman.org>

Problem: In many cases, KDB treats invalid commands as numbers and
instead of printing a usage error, goes ahead and just prints the number
in hex

Example: This can be demonstrated when typing for example "aaazzz", this
confuses KDB into thinking this is the hexadecimal 0xAAA

Solution: Transition to using kstrtoul instead of simple_strtoul.
This function is more strict with what it treats as a number
and thus solves the issue.
(also better practice as stated in the definition of simple_strtoul).

v2: Removed redundant if condition I put in v1

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f5f7d7fb5936..4cbd5cd26821 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -402,18 +402,15 @@ static void kdb_printenv(void)
  */
 int kdbgetularg(const char *arg, unsigned long *value)
 {
-	char *endp;
 	unsigned long val;
 
-	val = simple_strtoul(arg, &endp, 0);
 
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

