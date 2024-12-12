Return-Path: <linux-kernel+bounces-443728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9289EFB34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E76128975E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BDD22914D;
	Thu, 12 Dec 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="cAgBQ7jP"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E751228C8D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028612; cv=none; b=gEFoSUqBBpNlzImA9m1RN3Uyh3BDN3MpUsUSSYuInyB3Kj1+W8JAegq4M0hsdcR6yrUjoQsnmX8LBtMMaA4x23zvAZxO7ckm4pEiLqXQXfvx2CdMdRH+v7U2MiuiDU2EOBangxyrLyJwWm1igWAND7KDDRxO40iKSW+dCqKcB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028612; c=relaxed/simple;
	bh=p0I2HVUBbWRZhBgsdTrryTL6GkY8GKKUGtVy3VSjrfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVbRsIXDXtrXSwwO/kzey8ZbvX+XJ8dsWy5RIJI4bfS29WT/6p4p+p+gXx3FNaan8yxdEjG3bGaSaEIWl0iHoenXuc9JseUflQoQRWHcxlI5DglbUDTEfM79h7tD0aQGNDus5EXLqDrJ8a7t0z0demtP+QhgCv28owux+8ZTbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=cAgBQ7jP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43622354a3eso7034605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734028607; x=1734633407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDsnxHgs8pPYbt5Sxgc7PD1JuNe9FEImA9X5O9hYyxM=;
        b=cAgBQ7jPLZW9c/hx2yATjDQqoWuJnK65lVnqng/WuEspcgF2LDmHTLqC/fkUSzsrJn
         ZGqllXgxGS432jdTbTFPhJr9zEQd5a3tIulgvaL7gkDB0cOC7SKB3H8lBnVpgjWOFSss
         aruyt9ds2vl/tvk58dd2we8Wrhejc4MuObsKbRQs/y953YFAwHMbiGC7+icX3K5JBd49
         2fXGol8wnh9YyoGRf8UMaOyHghhdjgfjYeAYv5Ur2BIR6ZJA8ww1BfJ5iKsXWom5E0fq
         bVVJkT6oM+UltVScpXHge1SjRmJPsIEwnMhQLpMgVuo0n4n2j7RyRJbNvAzAh+phd/7u
         Z4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028607; x=1734633407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDsnxHgs8pPYbt5Sxgc7PD1JuNe9FEImA9X5O9hYyxM=;
        b=TT+JmG7XbgwFk7gZELGBfzqwx0OMZq/p0Xr4h8K9vyqNQTEqcIjC7jAdKXm96fHSxd
         xyWUpi2EASPm2DAYbIUb8xBJfK9cE1q3kw0j597ZAjECd592W/W016b/KYmJcl9eh+r5
         N3GbHfYXgbhDhm/hIYSBxkwsnNkDwIZHpv5e79WFo3UhXe0WdoMW53jOnC1ttDb4UCB5
         ytCcl6EN/IZiA7WJIigVSfXqc0CJDQ3Eb5FGAZA5rHP2cd9gmKrlyhIZWoPzvcZwg4Vs
         5ITM5rUNp54cRtGKDc3zA/tPP7STCF43paH1MhgKqw6XFadPob0+9l7gM8ceIAdP3FXG
         Ukaw==
X-Forwarded-Encrypted: i=1; AJvYcCV5b4HhoL/WQBD/OkYZRjMmMxU9FMBMPFJ7kF+NY4imKS4wUhiNv6sqFZXWQc/z71JTHJJOYCSN7EdjJvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrE79RnwKrJYO0W75H2TwGXEXTdjH/fGzpu7UP3KMSWtaBdC8w
	u2+d2WsFC4bSdts1l1DCmSKDoYt38iVw0e8At/LrNKoq9vHabZXBwgV1zYY832w=
X-Gm-Gg: ASbGncvzav9CSak6rTK3QFZMWpL6kCyk2KuUgfotvcEuDjoJTOaAxLmmJhBnlPCJaw7
	/rBA7nUcYolQPnovnuj9dh68MyeUD3zc4DLt/o0zQvLNdksP9V+A9EhPJl1bJTIpEnTsyLCRMwu
	DKeIR2ygFEYFnSrWDH/gzzjSWJbPb6LiFuj7oq8BNJhYyIeLMvpKnyzIXglEupr5jE984EMz6CB
	GmnByXANgJvtq9IAk+iNAKhZKvfn9Wr+GDe32eagomcSbyh
X-Google-Smtp-Source: AGHT+IEu2xL/+FXU63UNRhzK1AOzvmFc4RtXIaDc5vdsewo82JD1gWWmf7YI8MTxRmnxwh6YKbXzGQ==
X-Received: by 2002:a05:600c:19cd:b0:434:a07d:b709 with SMTP id 5b1f17b1804b1-4361c441bcdmr59652015e9.29.1734028607573;
        Thu, 12 Dec 2024 10:36:47 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436257178e3sm24651995e9.41.2024.12.12.10.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:36:47 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 18:36:33 +0000
Subject: [PATCH v3 6/7] arm64: dts: broadcom: Correct hdmi device node
 names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v3-6-44a7f3390331@raspberrypi.com>
References: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
In-Reply-To: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

The names of the hdmi0 and hdmi1 nodes had addresses that
didn't match the reg properties for the nodes.

Fixes: f66b382affd8 ("arm64: dts: broadcom: Add display pipeline support to BCM2712")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index bd78af0211b6..f42fad2d8b37 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -352,7 +352,7 @@ main_irq: interrupt-controller@7d508400 {
 			#interrupt-cells = <1>;
 		};
 
-		hdmi0: hdmi@7ef00700 {
+		hdmi0: hdmi@7c701400 {
 			compatible = "brcm,bcm2712-hdmi0";
 			reg = <0x7c701400 0x300>,
 			      <0x7c701000 0x200>,
@@ -381,7 +381,7 @@ hdmi0: hdmi@7ef00700 {
 			ddc = <&ddc0>;
 		};
 
-		hdmi1: hdmi@7ef05700 {
+		hdmi1: hdmi@7c706400 {
 			compatible = "brcm,bcm2712-hdmi1";
 			reg = <0x7c706400 0x300>,
 			      <0x7c706000 0x200>,

-- 
2.34.1


