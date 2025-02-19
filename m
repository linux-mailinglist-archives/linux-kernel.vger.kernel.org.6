Return-Path: <linux-kernel+bounces-521992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE79A3C4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386723B62B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF72D1FDA8E;
	Wed, 19 Feb 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AhWHJV4u"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36A1FECA9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981572; cv=none; b=jSeTa7P07JNGVBbdCT41x+OugeJ6SSqRCHqjM1owar0aLuxZ59Cr9QUpgzv4mQFhEl3hzcrKoulNcaXGu7orirryWXPR4JifDI9M0lgRmt+BMXip6hftKCmz90izarxxOBEcf2ksAhBh0UN7By365YYL7uSFS6nlt47QBYN1KbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981572; c=relaxed/simple;
	bh=olPIo7ondi9pZN9MKqIWTMM1H4TueaOeSXyLuuZ/SAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvJAGHQicL6AYDJHiH+/aOBMVDNQJ9ywyrEgrapLcTTcdYu0E7oB0n4zsO/AexRqRiE19ZwYTe7O+UD7YO3NF+IJc2CX7GeWqcKxteoDwetZiuWkjCVA3jP8UB42DV81aZ+A/uKsRExtz7+KqAPpFTLlXsFmoMqLhbJOf00XJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AhWHJV4u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so3113642a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981568; x=1740586368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEDW0l1uLZpkKjBmTN25YyNDkquVrBpJCv7mOsXan38=;
        b=AhWHJV4utcdkE1jDXDWT1m6MSm3+dzy0lH/HKvEjMWLpK6pRwk/KhIX0ZBTfjufK0H
         ePz3L8CzVWYEbBs5iVoJ05PRB3wl9KjVV3LpSN4T8mDxI+LDQJ1XeuHMBnjPpIcQ+hC5
         YD6VOokiUkT2ixn2kEAxEBhQELGj9mOMXeGf42NbnLtNUgm89wZcxGtqZ2uOuRvLK+wd
         Y2BrpLD1E58tCqpQ/KOE2uUgDUpWK0tDKYNJapIsmyIe2j/K+4pjVT8uhtpgQnjAlRAt
         WkSXAa1QG6G5vdCDX7TB6s6pnj7+BQjPPGV3JdTzAzG6pFQUalT5D2CyWJkHQ44Bjvdo
         IE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981568; x=1740586368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEDW0l1uLZpkKjBmTN25YyNDkquVrBpJCv7mOsXan38=;
        b=RiKNLAksG6QUejieY50xVvUltPUI5+hKzOdW40HStsChAJkCi73MySv+RQkbog3hj3
         uc0ox/DLp4ft4q5spml7afKEKK7fqJSgyhNucwpiyXU+EzdqYo3eqkUadk5A9H9dLHBM
         hot8g7xUQfbXxyoqpTMIte/h0wEzaf+/CxMGstl5KT+HJEr3mCboRt+C/yGNKZqiju3/
         walJ2Gm/zoT7M+d5AtvZPiHnbH9bBKNSqtrt88ALgLVq8OacjpfZhtx+lEfbTBXDpLic
         zk0qcRJcWl+S4XE1Zc1yTgVVNFKw2YVsrnIcnVWsdkoenB+o5QXsIWGm6pUMvPjLsL6X
         359w==
X-Forwarded-Encrypted: i=1; AJvYcCWcJmcZVeUZAptbTKOwhTimp8pDskcY3ptloVzxXVu2ilBZbmjZE0ewUTu3iz58Gtan6gwDmgDlfsR+dUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymenUaYrzh4RKGKNMVIP7s7BPYM09v4f45mWgvjd8dsxU1ZFbN
	LqOEiGHazgh3ygbjV+XJLCeDhZXdDVrkHr9lAzOhSB+Nzt5+PkcyNPQXnRuK6WY=
X-Gm-Gg: ASbGncsMs3zBqXPl0qtZVvgtmIMbnKJYmaLRwm7H60H81hqjpptLJnMvEOEXV1c+PI9
	NVzR1TMk3QR+iPeb00TeE8OyJYANhc63q9QpdWN7TF6EOU2MY5AhbnTQKQMh+0eCOn81msEtjFU
	+A54Dw3F8I/+ACrfuh4RhKuL+gYDL5+TZii017JOlrDZdtqN23e3Cyosno1vaKE0of3QbMTR0xr
	hGdqQymHW20SmVmXnZSxhmefKCl/7CVfyugQSgGjo+Ro0DckpvjX/8wot/S4MstK/eCmdt89js/
	PVt74zow6pqU9gykOO3BNhw8eDX/5t6BDflMTilxbmAT
X-Google-Smtp-Source: AGHT+IH3K7++bjaVQb708MVg6kp0Ba6iewq39EmLq++1d1VFY6n1zquEZBgNZF87Ke/PH45YqVx4tA==
X-Received: by 2002:a05:6402:a001:b0:5e0:445f:9576 with SMTP id 4fb4d7f45d1cf-5e0445f96c6mr13997168a12.18.1739981567920;
        Wed, 19 Feb 2025 08:12:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e07f390626sm2548881a12.30.2025.02.19.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:12:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	yoshihiro.shimoda.uh@renesas.com,
	laurent.pinchart@ideasonboard.com,
	phil.edworthy@renesas.com,
	balbi@ti.com,
	kuninori.morimoto.gx@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RTF 2/3] usb: renesas_usbhs: Use devm_usb_get_phy()
Date: Wed, 19 Feb 2025 18:12:38 +0200
Message-ID: <20250219161239.1751756-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
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


