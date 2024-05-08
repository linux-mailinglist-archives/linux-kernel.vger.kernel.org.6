Return-Path: <linux-kernel+bounces-172811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1888BF711
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8133B212FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB752C69C;
	Wed,  8 May 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b="L3YDX+aD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435123770
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153426; cv=none; b=UJT3c2uaijx58zorXackIg57QeMjLjib80u6LfjdkFVWGVu/qYi0HHeoS2ZR2lE75HBk24ZR3R3rpi371D9O214bsyHUaKSGnRVvpGD9WD7own+ILwBFYZzHNkuQO6VuEwRjrsSgFvjhuSX7LaQSNFuZVWgoMhNF/8PiqHAZMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153426; c=relaxed/simple;
	bh=ryub+2DBPj8dygA3ixSZEPzzf62nwP7aubV60BBTVrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dnmc/lcRbvnHRCL9c5MOLv9luboooUkkH5qdsItHVx8dLI3NVXNGfXVBiXImxaLFwo119YiYjn/o7ndI5o9uWf93lhxivqrcC0SScT1YlddKhKhUqNbMrPNH1x7u98NqMbbzbocz6l9clIGmm1MYKWCB6dOTw2vWaC3bWtMW4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b=L3YDX+aD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ad24baa2so133429366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix.de; s=google; t=1715153424; x=1715758224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=754+1zrqtoCOba8ne7LLZxtOMyJ9BY4rqXthCHDzDCA=;
        b=L3YDX+aDDb+yf+dwS95FbJ+vti8GeqhVrdhJmZHNMwjrG6tc7PAchgn2er8TKgRwhP
         HSEvUlBwn2L3k6sT97ohMXmske9KfxlLn4eQH2FZSYrmVC+QjHTc/z+IP02vDUdXYmnO
         OPkxxHalLCiC1cTuhlC46hZ4CPaBwQLgd0nj/1LNlRx4Y2abRPCtYnPIVxU5dL5ErQI6
         8/jaeeVxFMm/p9i7DRa0uwpJhZNOadWXSVEQFimMWgASqHBtT3UqZKHfZ45KSWzPeSVx
         oqquJItfWJmeXlna0nR/Q2WdIHaQJaXlC1kj1UEhRcyOs2M2HbR7AbYUDeAAovoCD3SG
         ZD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153424; x=1715758224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=754+1zrqtoCOba8ne7LLZxtOMyJ9BY4rqXthCHDzDCA=;
        b=hf+M+DpEmPF1a2vEjMbQB5yp/JoOime+bghQB2Rj7KnSx7KUVBw5450uDTC6njeGwa
         ZdYnQmbdP4alewfcRHEvRoYdYWEAZf6ZGsiitPhRcFKJWyYkrI/zI9Y7qyc77SoI247Y
         xI7wc2n/PKfz88yIDS/3opGCoM89SnTMnkWEeuT2K0kZMaw6nUjNtjb68tpZ8eoAGfC+
         +qH8Ty7Z/jk6p/R/BiPWvkBMYtrX35gsae02RewJUzMEIE/o+60IVnkGwXwXXbgu2fuW
         H81vQWTpXr7MPwRc2As7mo2MJm/KlRpgr/LEF+7ErNPIO6OrH42Rq+MNLOzje5hI2EJo
         H5NA==
X-Forwarded-Encrypted: i=1; AJvYcCWf9Sw7H13m0TcSt+UNdgEEX1gIQC5cX0nNWUqdLkMbbpXQEC/P+aaBk43dIeUXF6oKR5w7SUWVmT3CcLzusRuZ25Rk83C8PEPekcgm
X-Gm-Message-State: AOJu0Yxw7+TP96C97psEACGb5TgTvb9BydUKvC4udj1J0gzQAj0V3xQW
	xAxATOmeMN0uHdZkiq5qjrRRRkUOxYMD5VghwaZR95xkcSRFyhirupK4FD4NFFwNCdJRX8HAgtM
	F6xFMovkw2s0+AAVxDdF9hRgd/SgxfpmRl0KNuy9SYGcsI0HThLVBTnw=
X-Google-Smtp-Source: AGHT+IFJl0Hd+7ds8Gsfg4fK6Yko9ghN0efVIKYWnlVqJ4Ohl30Swm4Unehgo2M448T11Ubrq1tenA==
X-Received: by 2002:a17:907:9545:b0:a59:da00:5acf with SMTP id a640c23a62f3a-a59fb942291mr83147266b.2.1715153423661;
        Wed, 08 May 2024 00:30:23 -0700 (PDT)
Received: from localhost.localdomain ([24.134.20.169])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090648cc00b00a59a874136fsm5212358ejt.214.2024.05.08.00.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:30:23 -0700 (PDT)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Fabio Estevam <festevam@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 1/2] net: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family
Date: Wed,  8 May 2024 09:29:43 +0200
Message-Id: <20240508072944.54880-2-steffen@innosonix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508072944.54880-1-steffen@innosonix.de>
References: <20240508072944.54880-1-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
be filled")
Marvell 88e6320/21 switches fail to be probed:

..
mv88e6085 30be0000.ethernet-1:00: phylink: error: empty supported_interface=
s
error creating PHYLINK: -22
..

The problem stems from the use of mv88e6185_phylink_get_caps() to get
the device capabilities.=20
Since there are serdes only ports 0/1 included, create a new dedicated=20
phylink_get_caps for the 6320 and 6321 to properly support their=20
set of capabilities.

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be fill=
ed")

Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

Changes since v1:
- Removed unused variables.
- Collected Reviewed-by tags from Andrew and Fabio
---
 drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index 32416d8802ca..bd58190853c7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -697,6 +697,18 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xx=
x_chip *chip, int port,
 	}
 }
=20
+static void mv88e632x_phylink_get_caps(struct mv88e6xxx_chip *chip, int po=
rt,
+				       struct phylink_config *config)
+{
+	unsigned long *supported =3D config->supported_interfaces;
+
+	/* Translate the default cmode */
+	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+
+	config->mac_capabilities =3D MAC_SYM_PAUSE | MAC_10 | MAC_100 |
+				   MAC_1000FD;
+}
+
 static void mv88e6341_phylink_get_caps(struct mv88e6xxx_chip *chip, int po=
rt,
 				       struct phylink_config *config)
 {
@@ -5090,7 +5102,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops =3D {
 	.gpio_ops =3D &mv88e6352_gpio_ops,
 	.avb_ops =3D &mv88e6352_avb_ops,
 	.ptp_ops =3D &mv88e6352_ptp_ops,
-	.phylink_get_caps =3D mv88e6185_phylink_get_caps,
+	.phylink_get_caps =3D mv88e632x_phylink_get_caps,
 };
=20
 static const struct mv88e6xxx_ops mv88e6321_ops =3D {
@@ -5136,7 +5148,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops =3D {
 	.gpio_ops =3D &mv88e6352_gpio_ops,
 	.avb_ops =3D &mv88e6352_avb_ops,
 	.ptp_ops =3D &mv88e6352_ptp_ops,
-	.phylink_get_caps =3D mv88e6185_phylink_get_caps,
+	.phylink_get_caps =3D mv88e632x_phylink_get_caps,
 };
=20
 static const struct mv88e6xxx_ops mv88e6341_ops =3D {
--=20
2.34.1


--=20


*innosonix GmbH*
Hauptstr. 35
96482 Ahorn
central: +49 9561 7459980
www.innosonix.de <http://www.innosonix.de>

innosonix GmbH
Gesch=C3=A4ftsf=C3=BChrer:=20
Markus B=C3=A4tz, Steffen B=C3=A4tz
USt.-IdNr / VAT-Nr.: DE266020313
EORI-Nr.:=20
DE240121536680271
HRB 5192 Coburg
WEEE-Reg.-Nr. DE88021242

--=20


