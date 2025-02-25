Return-Path: <linux-kernel+bounces-531157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1ACA43CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F58F443129
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BAC2676FA;
	Tue, 25 Feb 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="k14C2U6n"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E52676F8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481382; cv=none; b=s2iI4hhpUEntbl+sUmmWmzGs1OZfmt1UKFOjBa9dCK3EWsdMM51ebJAA29jI3m4Y7ByNOq5Hk59u06ciirAu29RQNak+EiMDdmUk016DqRtZs5fRhFiexbQykON209BTqScF+RyBBds9Api5emPsNXF/BfMq03SyyYTfLdfdkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481382; c=relaxed/simple;
	bh=EFoTjmBvFXfXjWb+GX1/FcvwY+PND4is0Ol1b2EMzJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfL6lGyZjxqM1wsR3P/quZtN4JXHlYjwvoJo3PKIFcdoWaczxwD6f4FKJE7hr1GmUoTWyD9SiIjyhh+WWos886UZqCBzsFMFcuuRL6D0xvNs75TH6/9Lxz69Iz2K1WdAGWdjKzbkub/46V4wRDGOCCr/AkT/uSkJ9UNkjfn5MJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=k14C2U6n; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394036c0efso34052915e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481378; x=1741086178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g90tifgQM9MVDjBzO/J2Q9Ytv3puck/TcrC4X2HffE=;
        b=k14C2U6nGMHsF8/MEKTGyx66X/GNX/AXIuxMBjthOmHyCVh3Qs3d6RCIodf3FL2KB8
         ZOEgIsQ5L9Yisrg4dL+bMYNoduIE2WpcEkyrlN3WZwoPLKL0EVjvxLWhcasXzjLWhXaH
         8Dw+UHLTblJvNiXztWWwWvP+49ExEwDcWxFvOlpPxayZkWHXyz9yTXBHo/DLHowNO5Ls
         C6A++u09CDhYP1b3aZx/MP7jurtIkfa3+p2T89o5IcUJirKjAVyYaMD7fXnDZvgH9lMS
         xmKyYNs48gjm91WmA7YsSqYrnicAaIWdRBgeJpuKXL2mWdIaZtu1kNJsZoyCPaPPvVT0
         7HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481378; x=1741086178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1g90tifgQM9MVDjBzO/J2Q9Ytv3puck/TcrC4X2HffE=;
        b=r8wAo626b5BacC/AIdjGvzizPLrDPjRBh+a27X3fY6pSdOV8TfqsoowWSi6C4/GLhK
         btFmprymuZgdvFaMrknkmWOA3L1JBAJMbP0okNLDVMEOYRg1fv3zfOU2EVMRy7KjiK9r
         22gOeke4pZyE5jbpGh5/NbEXskijlmk3ZC58M5P5g33ALRUQ1KdgT/QtArsTxQgS7GkM
         iIy1j2MvKr5pBAmKXUE6A4Xe75YknmUQwZ6rB0rKnCnK35WP+lWVou/1Tc6M3t0T4zRs
         0foMzVBHpXJ3Bb48dBE9I2SiTcd/+sdXkLYSfdgHPpLmn9KUQnP/rnZGITtaBqJAGcEr
         TXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0xY21x+xK0RHz2kvXjvHD7hzxmRUXPUirrc7K9m2UHLrAXAYfCeIZyLV5xtZ6lX/KeotrdORxcV8XDG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXE3PIkFq4FPB/MSKNM7aFPj/l1qIKb3jChp2Fez14MqUUvTnC
	iUDpukVpYQPs3MrEh9oZ+qjBFq20wT4LaaXfh+26VQGSQVgwYhWnWQBEs25lyOY=
X-Gm-Gg: ASbGncv86unHOUBe9E2Y8lt9q7rF4/JFWE9aiEROidQ3UEYqfML0RtAqFdEy3I10F4y
	2JtoEUu8WlSYdKq73g+yvPSyYHUi5pYExrk0pRiiaDQyBmMsWWvDAlU7lNAJ7oMcH/dQIWpDi/b
	DXHWQW4HCvDx9hj+VrRN/hxy8BWZhnzStUhHF8HjNHRlR3yVB9nqVSnoMMaKZtdkk6CyPzaeacf
	ERWLe2ZtzZ6mMwu7pOVpdB4j1ehEW3+db4P7jX1ApJbfZUFyNBNI90kI1ia9RQFuhax+spv/xSb
	jKCxDxBGeEqP4uB4Jbledx/N+US7nFzmNQpP8eYGqn5QmUmzJrYLXHM=
X-Google-Smtp-Source: AGHT+IH9p4vFb/WlIcpRZOBte7JgwwPLkhCZmRimhOlrCUbR7HFlC6wBkzx+vvYw/CKT/Zad3bHmmw==
X-Received: by 2002:a05:600c:4f84:b0:439:955d:7ad9 with SMTP id 5b1f17b1804b1-439ae1f145cmr171014845e9.14.1740481378537;
        Tue, 25 Feb 2025 03:02:58 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532dccsm21972385e9.7.2025.02.25.03.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:02:58 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com,
	phil.edworthy@renesas.com,
	balbi@ti.com,
	laurent.pinchart@ideasonboard.com,
	kuninori.morimoto.gx@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] usb: renesas_usbhs: Use devm_usb_get_phy()
Date: Tue, 25 Feb 2025 13:02:47 +0200
Message-ID: <20250225110248.870417-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The gpriv->transceiver is retrieved in probe() through usb_get_phy() but
never released. Use devm_usb_get_phy() to handle this scenario.

This issue was identified through code investigation. No issue was found
without this change.

Fixes: b5a2875605ca ("usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/usb/renesas_usbhs/mod_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 105132ae87ac..e8e5723f5412 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1094,7 +1094,7 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
-	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	gpriv->transceiver = devm_usb_get_phy(dev, USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
 		 !IS_ERR(gpriv->transceiver) ? "" : "no ");
 
-- 
2.43.0


