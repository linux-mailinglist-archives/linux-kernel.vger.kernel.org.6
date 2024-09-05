Return-Path: <linux-kernel+bounces-317948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79496E5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8786AB20A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7691AE861;
	Thu,  5 Sep 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uSJGTGQH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6655197A9F;
	Thu,  5 Sep 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576402; cv=none; b=debU1z/DuIyt5My6UeRuQuWbkalNBI6UORBuN9sdJ2vLaTLeuiwpr2OBJ/8eZ+h1GUugGsywbg7F8McOtOzNB8t42/ieVSZCYGwxIx62nbDRiTE/M3zJ2v9B17SVNhtQ6ER6DqJ8/9syRsbsCJ9+uC4dGU+vynBlm0gQ9nry20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576402; c=relaxed/simple;
	bh=dD91Dh4EHgzPc17u4Z0m/j6eDaluADVRos9DOnh2HKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot4Y0XHJnYR6b0DlbdtVGC00x/U+Er0opVkQPr9c/DIeCfQwLZhyaHW2tulVa1crovKEdCy9QDu4uw5u5ERzHseaoPYRNwoA/yVzsp0cP74qckRSwtSurNbYd7ctz7MvO55ihPQXMRF5jaL6j6pDPkitZTLjerS9XT4X95wRT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uSJGTGQH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5te1QcV9bMTGPWXtf57Xlf2pr7w3M9wbPF0XwPSIHhc=; b=uSJGTGQHos+M+bmj9p1/ltqkie
	+MK+EkuHbcoifynj+z9mrAF9eebJHRy+YRy0z4hE5LEPRnKDN+39pEp117kgMo7BCoVrsGsI1EFB5
	yE2eSOYPXCHZoWlcqBCUyA8OG8ijrHjlIj6xdAuH7b2KyVJ0pS7MpiD5uhC611wqMV2DPrwJCQVcT
	jRAW0dGAy3GWm6SAuo25ct70l3fAubQrWimfoZwaX6d/aa+AJZC9WtzoVyXeSFmDceaLpVA+CxLcb
	o5sQSScP//0lWEPLtMQJ7oMxat2n9gEAHiaS2y921PTYUy6CCbtx3LtBmG/X1yJKURCFHIKOh0IA0
	Exflxsog==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smLFL-0005IK-W6; Fri, 06 Sep 2024 00:46:36 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: mturquette@baylibre.com, Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/5] clk: clk-gpio: add driver for gated-fixed-clocks
Date: Fri, 06 Sep 2024 00:48:35 +0200
Message-ID: <5168975.haC6HkEk0m@diego>
In-Reply-To: <9b92b5f03632e8793253ba75fc00f6e3.sboyd@kernel.org>
References:
 <20240828101503.1478491-1-heiko@sntech.de>
 <20240828101503.1478491-5-heiko@sntech.de>
 <9b92b5f03632e8793253ba75fc00f6e3.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 28. August 2024, 20:30:51 CEST schrieb Stephen Boyd:
> Quoting Heiko Stuebner (2024-08-28 03:15:02)

[leaving out all the "will fix" parts :-) ]

> > +static struct platform_driver gated_fixed_clk_driver = {
> > +       .probe          = clk_gated_fixed_probe,
> > +       .driver         = {
> > +               .name   = "gated-fixed-clk",
> > +               .of_match_table = gated_fixed_clk_match_table,
> > +       },
> > +};
> > +builtin_platform_driver(gated_fixed_clk_driver);
> 
> The comment above builtin_platform_driver says "Each driver may only use
> this macro once". Seems that we need to expand the macro.

each _driver_, not each file is the important point I think.

Looking at the code generation, it just wants to use the name of the
driver struct for generating the init functions.

So in the builtin_driver macro [0] it wants to use the
gated_fixed_clk_driver to create the init-function as
gated_fixed_clk_driver_init() hence anybody using the macro a second time
for the same driver would create that function two times.

Also as can be seen with the imx gpc driver [1], the two-drivers in the
same file is already in use.

I've also done a practical test with that and did [2], which resulted in
both drivers getting registered as expected:
[    0.132087] ----init gpio_clk_driver
[    0.132160] ----init gated_fixed_clk_driver


So not sure, if I misinterpreted your comment, but I don't think changes
are necessary for this portion.

Heiko


[0] https://elixir.bootlin.com/linux/v6.10.8/source/include/linux/device/driver.h#L284
[1]
https://elixir.bootlin.com/linux/v6.10.8/source/drivers/pmdomain/imx/gpc.c#L239
https://elixir.bootlin.com/linux/v6.10.8/source/drivers/pmdomain/imx/gpc.c#L556

[2]
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 1fc8b68786de..e306f554cd0f 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -284,6 +284,7 @@ module_exit(__driver##_exit);
 #define builtin_driver(__driver, __register, ...) \
 static int __init __driver##_init(void) \
 { \
+       printk("----init %s\n", __stringify(__driver)); \
        return __register(&(__driver) , ##__VA_ARGS__); \
 } \
 device_initcall(__driver##_init);




