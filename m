Return-Path: <linux-kernel+bounces-180247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D78C6BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863F1284AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F0158DBE;
	Wed, 15 May 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+A4LU6E"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51188158DA8;
	Wed, 15 May 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796791; cv=none; b=YzkwEubIyN3bQnQq3SsuZS1oLBHpzYl3BizUOeIX0nPxjFz76pnVQVKSwjpZGSgGnbKelLVHiI0gSvVIh08qhBg86Y7FfDNp+F+E+Y1QMsAkrNsF24GplCCYlDqJdME9E8VpnfJfWRoPVQIqmUyQn9L/4FB5DdJPaeqZi5FRPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796791; c=relaxed/simple;
	bh=TfdF1bpqrHkn9OnfHOleyGznVY48Y0qsPHzXN5hBulw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsF1z7Jn5rU+XO31PcLufL8Yu8WZqbAUdFefx6pNRZT6QCiqf65QhHA/hHiJawaspsA8y7EdbHjCMM3/0A25BzWbPu2zzxauQMD8pfLDsTOBFStTGMefczzJoX2XEoKsebS/6x7GYh+SoUJmHNnUFXxmZWvWXSQmNWXvbc6vtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+A4LU6E; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5727dc6d3edso2302905a12.0;
        Wed, 15 May 2024 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715796787; x=1716401587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pch3Ih7LaL+PpkBrCQxVPogM1fubUEsmwW5xj0Btblo=;
        b=J+A4LU6EhELacsZbVent+FxL8uFOd9YfNsF05ybr1lGFFzGRjBoOamPFz4OzxU598v
         qwOg/e0coXwv6fPqwiTJ3BFro/BPUkig63tR8JfOTBln0qWiDwxZrNuXuulkcqWuRBAs
         8Q0r262rSMTQdE8aeoqDASSXwt/ppxXPyfd1ln9824Z5kfovaDXKvsJRM2ZF9oJiLcZa
         uOlakDIz9deH4VAKFmwoO4Cnwgtnz1gmkzSBPnTe3zOigGIOcBJ2u3ESBATOF/Dme0UF
         hTNeIBmwNCzUVN3D/8jwLxB1IIaCVQmE0wbyvk/dqC6zb6RvPfsP40PvOjhnc45HxxNy
         TZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715796788; x=1716401588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pch3Ih7LaL+PpkBrCQxVPogM1fubUEsmwW5xj0Btblo=;
        b=Z1E8araKWrTO8F9wDOOI8oEkbfGW1efqGa3IyoenVAI57hMUoP4kBvYv2Tdsusefjp
         cwF1aXY4SDW9cQHI6SAFY8Y6pCHjYpv6kWIpQxgaG22LZQVSeWzrpNQRrFZdj5AbDGVq
         GoVb8FyyYglOaEQ1DxqAuymeSdcoICi3DgKbSfafe7A615gTsb8h+px4A/Y2CgfA6moI
         rt0folOR7OuwjJo6asF4Y+c+tDBurA9pdMBjpJyGC5aFaKTrU5c8DhSyvuwdimi2p9va
         TVa0Di8hbOvY+DFDYuArdYwVqMDt2gkJzVn6zbhn+snmWyHi1hCwc8UmbgtUfQaHeKIy
         XfHA==
X-Forwarded-Encrypted: i=1; AJvYcCUjhVNqZnSEIqGzxxrL+4nUQqxHI6rzPQ7IcUb2yjOcnKkk1YZOL32bvMrW6RRg7oZmWjRNhh+9sjON5+FAbCAGK+Thz0974hULNmDryTA19k3up+JSwmEqLBy4aMkf/CN+h9ZmrkLGeg==
X-Gm-Message-State: AOJu0YxzJm+03ZiVQdiJNA9cKR9nmXovx1TUhwpz1HTpssUG7gENndUR
	yksisWSxjZ7Dgx/h0Df/mLy9sMp0Wc8NMOTxqPzMyHjQ4T8TfSJd
X-Google-Smtp-Source: AGHT+IHgPNyYK5FYIjTE7nmsJggKHf4atXCrV0muQ+BI4PZ2Ak2naECuuuyZfglhJRj+gtpVN5yqIQ==
X-Received: by 2002:a50:d710:0:b0:572:1589:eb98 with SMTP id 4fb4d7f45d1cf-5734d5b9098mr11072869a12.12.1715796787300;
        Wed, 15 May 2024 11:13:07 -0700 (PDT)
Received: from yohan.gigerstyle.selfhost.ch (84-72-24-4.dclient.hispeed.ch. [84.72.24.4])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-574ffe6d3f6sm321658a12.0.2024.05.15.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:13:07 -0700 (PDT)
Received: from mgi.gigerstyle.ch (mgi.gigerstyle.ch [192.168.0.5])
	by yohan.gigerstyle.selfhost.ch (Postfix) with ESMTPSA id 6087A58E;
	Wed, 15 May 2024 20:13:06 +0200 (CEST)
Date: Wed, 15 May 2024 20:12:58 +0200
From: Marc Giger <gigerstyle@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jianfeng Liu
 <liujianfeng1994@gmail.com>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de,
 sfr@canb.auug.org.au, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove startup-delay-us from
 vcc3v3_pcie2x1l0 on rock-5b
Message-ID: <20240515201258.090f754f@mgi.gigerstyle.ch>
In-Reply-To: <273slx5qkz6ja5qlfjgcaukuzifzsxkdabsld3qodvxaekbzet@ipir56a6afj3>
References: <20240401081302.942742-1-liujianfeng1994@gmail.com>
	<432000a6-1de9-4452-beb7-6954677e34c8@rock-chips.com>
	<273slx5qkz6ja5qlfjgcaukuzifzsxkdabsld3qodvxaekbzet@ipir56a6afj3>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 12 Apr 2024 18:09:13 +0200
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
> 
> On Wed, Apr 10, 2024 at 02:30:16PM +0800, Shawn Lin wrote:
> > Hi Jianfeng,
> > 
> > On 2024/4/1 16:13, Jianfeng Liu wrote:
> > > Property startup-delay-us is copied from vendor dts and it will
> > > make kernel not detect pcie wifi device. If I run command:
> > > "echo 1 > /sys/bus/pci/rescan", pcie wifi device is detected, but
> > > my wifi device RTL8822CE failed to load driver. Another device
> > > RTL8723BE can load driver but no wifi signal is detected.
> > > 
> > > Removing this property will fix issues above.
> > > 
> > > Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> > 
> > startup-delay-us just make sure the power rail is stable before
> > any action is taken to start the link, preventing the device from
> > unable to work stably. So it shouldn't be the root cause I think.
> > 
> > Could you help try this patch to checkout if it works for you?
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index d684214..df30127 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -167,7 +167,7 @@ static int rockchip_pcie_start_link(struct
> > dw_pcie *pci) struct rockchip_pcie *rockchip =
> > to_rockchip_pcie(pci);
> > 
> >         /* Reset device */
> > -       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> > +       //gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> 
> Is this removal actually needed?
> 
> > 
> >         rockchip_pcie_enable_ltssm(rockchip);
> > 
> > @@ -180,7 +180,7 @@ static int rockchip_pcie_start_link(struct
> > dw_pcie *pci)
> >          * We need more extra time as before, rather than setting
> > just
> >          * 100us as we don't know how long should the device need
> > to reset. */
> > -       msleep(100);
> > +       msleep(300);
> >         gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> > 
> >         return 0;
> > @@ -311,6 +311,8 @@ static int rockchip_pcie_probe(struct
> > platform_device *pdev)
> >         if (ret)
> >                 return ret;
> > 
> > +       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> 
> I suppose it makes sense to use GPIOD_OUT_LOW in
> rockchip_pcie_resource_get(), so that the GPIO is requested low from
> the start instead of being high for a very short amount of time.
> 

I see the very same issue as the original reporter on a Orange Pi 5
(rk3588s) and a Orange Pi 5 plus (rk3588). In my case the onboard
ethernet interfaces and/or the nvme drive are randomly not
initialized properly. This is with Linux 6.8.9. Funny enough it seemed
to work all the time on 6.8.4 without any issued (having the bifurcation
patches applied).

After applying the following patch (with the incorporated suggestions
from Sebastian) everything seems to work on the Opi5 plus but on the
Opi5 the nvme drive still wan't to properly initialize.

In dmesg the only difference in repect to pcie/nvme I can see is that on
a working system the following to lines are shown whereby they are
missing when the nvme was not initialized properly:

nvme nvme0: Shutdown timeout set to 10 seconds
nvme nvme0: 8/0/0 default/read/poll queues



---
debian-linux.orig/drivers/pci/controller/dwc/pcie-dw-rockchip.c
2024-05-02 14:35:35.000000000 +0000 +++
debian-linux/drivers/pci/controller/dwc/pcie-dw-rockchip.c
2024-05-14 19:25:18.519434456 +0000 @@ -180,7 +180,7 @@
 	 * We need more extra time as before, rather than setting just
 	 * 100us as we don't know how long should the device need to
reset. */
-	msleep(100);
+	msleep(300);
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
 
 	return 0;
@@ -240,7 +240,7 @@
 		return PTR_ERR(rockchip->apb_base);
 
 	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev,
"reset",
-						     GPIOD_OUT_HIGH);
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(rockchip->rst_gpio))
 		return PTR_ERR(rockchip->rst_gpio);
 
@@ -311,6 +311,8 @@
 	if (ret)
 		return ret;
 
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+
 	/* DON'T MOVE ME: must be enable before PHY init */
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev,
"vpcie3v3"); if (IS_ERR(rockchip->vpcie3v3)) {


Thanks,

Marc

