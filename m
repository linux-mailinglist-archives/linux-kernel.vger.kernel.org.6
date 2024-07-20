Return-Path: <linux-kernel+bounces-257923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1109380E2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75717B20C17
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95AF84E15;
	Sat, 20 Jul 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Z+fE3p0z"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077FB67D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721473605; cv=none; b=e+iJM4VivquxiidzKK/Wboe2B1tiDyNzokWmdt+FYM/o4vnGFnyV9oOHoRJynqIC4Y5sGVBBVNQzsWb/udF3MXBkvw/XFogFjL4V3rdzI+m9uqHbeBvZFCXxkgZIsjpUL0GoMq3Mm0Lq6OK4zuylFa8RJ0IMIpTPKhosspf9kY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721473605; c=relaxed/simple;
	bh=4SBmS9evqfYjiWS/SZw+MfSEUXtdnqi2gYqBCz8u3Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLbmmUOhUyfahavR81LFpN4eRxWPnsF7ge33AmAz0Ycwz6AYxJShoTergyh/bm8H4CWi0LF2ni2r6I/uXVntKBB4VehgVtTMDZiCkaDhGR1I1HwNcvH+yFpCitln8oE6munwiQHPjWKClQyUDRTlF/18QIpfBBa+6uGgsgo4B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Z+fE3p0z; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id V7v7sCz5IfWRDV7v8s20pG; Sat, 20 Jul 2024 13:06:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721473595;
	bh=wFTIT8qzpra09si3kluN1/RyiA4I3T3TkYlaiPe5Ics=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Z+fE3p0zIPbhmkwyKqb8oMAlqUW7wcyoXvWntCXSTP99WhxHLT00vfWj1/PRPWVrl
	 zzFDo/GON7xZ/5NKDvLx/W4ATsyKK3y6XGyb3TFExuu1z69B4zK3eTUQ9VYiSKIIeP
	 TaZ7iqAlcDhAUi9MKQNPh51FcKXrbXQZXVHIYDlMTO59DVwgDdc71buxeZwmTyjUFQ
	 Gujs3S+Hn9LVj3RIHTlv4tugqtmG9+O1YBPMW7LFtPvVRigR0yjvxv8BLqwyKUPNHX
	 OVabgI+AS6cHGIX80fz6Hbfe92w1UClvVLblmSFszZqtQDjx8BQMtjkFlwADV3PCSr
	 bS4xe5wpJNCgw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jul 2024 13:06:35 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] intel_th: Constify struct bus_type
Date: Sat, 20 Jul 2024 13:06:31 +0200
Message-ID: <2f08b4003f35f1174a5bd32ef09731910a252d34.1721473575.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct bus_type' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  19925	   2493	     16	  22434	   57a2	drivers/hwtracing/intel_th/core.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  20101	   2333	     16	  22450	   57b2	drivers/hwtracing/intel_th/core.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index d72993355473..4ffefab7ef4b 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -166,7 +166,7 @@ static void intel_th_remove(struct device *dev)
 	pm_runtime_enable(dev);
 }
 
-static struct bus_type intel_th_bus = {
+static const struct bus_type intel_th_bus = {
 	.name		= "intel_th",
 	.match		= intel_th_match,
 	.probe		= intel_th_probe,
-- 
2.45.2


