Return-Path: <linux-kernel+bounces-391258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E099B8481
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BE4282FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96B1CC8A8;
	Thu, 31 Oct 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="DEkEJASl"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F91AD3E0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407245; cv=none; b=rYVp7b3gdKT8Z5auya9iLtppUG18tE2XL+fioSkGEGTn069B9JsWwnv29Ht/9HXwYD7Y+DoQxZSk76yriI4emyXbaBQ9ZfoCrLkGPkJF1Azls8mGaVXYVWBxCT5LwNcr1DcPbhOngiBSy5WqGQcsx+hkoPF28E/uHofqdtUPOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407245; c=relaxed/simple;
	bh=FbdtIwomJFtpT0I4c7WLT+JfrZuaiJ+KreP/YHHYY6M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TCllt/vstE0aVhGwq0JniuBhcFaOxqEgwyrzQJ/cQ5BRd9pCoYpeB2debF5bzrt+n99QnNXRNXq5bm7UI3Icna/ZV4gVICnlSNVqSVhoDFPmozVIrOfdrGys9pCTyY5G7xitSnG5DHiHWUNpMxBmHqewE5it7ks7FCsPa4te9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=DEkEJASl; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id DE402176E4A; Thu, 31 Oct 2024 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730407241; bh=FbdtIwomJFtpT0I4c7WLT+JfrZuaiJ+KreP/YHHYY6M=;
	h=Date:From:To:Subject:From;
	b=DEkEJASlsjlPzhuw1tgV4mOlRNU1vvEofIk1gj2uMNSq5w7gIEueaC80UibtzlVIK
	 vtX6O/x0QC5wW0r62Dn3mZS6AX/ZVCl6XLyGa2PHinL/lrqgUu8k6GXBy/Z7Z20Dil
	 2tZnmni3iXc6IWhR90Uf+9FXgboVjtm/0LgRGDfRn/u2d415KgH8TbbOXO1LVxxQv9
	 G75MdSpmh3/C2O9mrpih1ZPjwmkEJXvKss4h/svNn5dZv14yq9Ztd2F4wW0wcOWWZT
	 RD1HkCtLIq2ruP/75pDt+p4pPyeQMIIWtE41w+a9AyQsicLU2a7Uw1Q1TEe/4G2Iqd
	 UswnpePog2vpg==
Date: Thu, 31 Oct 2024 20:40:41 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Fix incomplete usage help of md, mds and btc commands
Message-ID: <20241031204041.GA27585@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix kdb usage help to document some currently missing CLI commands options

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f5f7d7fb5936..0bdffb17b163 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2667,7 +2667,7 @@ EXPORT_SYMBOL_GPL(kdb_unregister);
 static kdbtab_t maintab[] = {
 	{	.name = "md",
 		.func = kdb_md,
-		.usage = "<vaddr>",
+		.usage = "<vaddr> [lines] [radix]",
 		.help = "Display Memory Contents, also mdWcN, e.g. md8c1",
 		.minlen = 1,
 		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
@@ -2686,7 +2686,7 @@ static kdbtab_t maintab[] = {
 	},
 	{	.name = "mds",
 		.func = kdb_md,
-		.usage = "<vaddr>",
+		.usage = "<vaddr> [lines] [radix]",
 		.help = "Display Memory Symbolically",
 		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
@@ -2743,8 +2743,8 @@ static kdbtab_t maintab[] = {
 	},
 	{	.name = "btc",
 		.func = kdb_bt,
-		.usage = "",
-		.help = "Backtrace current process on each cpu",
+		.usage = "[<cpu>]",
+		.help = "Backtrace current process on each cpu, or a specific one if cpu is passed",
 		.flags = KDB_ENABLE_INSPECT,
 	},
 	{	.name = "btt",
-- 
2.39.2

