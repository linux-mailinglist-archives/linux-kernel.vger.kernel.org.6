Return-Path: <linux-kernel+bounces-172812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B38BF713
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E281F24478
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE03CF73;
	Wed,  8 May 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b="CncpDfTr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6A29417
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153428; cv=none; b=ujgl3EGiLyUQAAsjl/FYupwL3zNW/hja6rqYMJO94Aj4cWhSyju5Qq+B+CMhRA5GB/YyMy4j9HAbYmZBkBSOiH4/4vncgBkRU06dk5NUT7AxV6ag5v/0k69YftS3E8EQH4jc+ttIeJM0vWTsjMkUE0NSXJYUBbr5nLgkuJyHjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153428; c=relaxed/simple;
	bh=HkLTXlvLqPcM1G9r5TuQ/k6k+kIB8Kh6veaRJgAeLuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVpNMljSz1lZ00jDPb+/kXxdsakKTt09JyjnJOlFHMkMrvYo0sh4JhK4zfWC8oGZLSRI9YcWIP2usdsK5ym1Ur4deNn/goQGlq3I1xbAXem79WaSySotIdoilukRyAOGDe4y0FB7o+MmvAuzIbhOFiUNL+MMaKKCnsGmKHJC0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b=CncpDfTr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a86fb052so131394666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix.de; s=google; t=1715153425; x=1715758225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VYVvd11hV7rJunixQLWGyRIvzoAkWZceNjuLWyDIro=;
        b=CncpDfTrHUfZw6dPg0Q43fIfcyNbLPSpT0yl+p/WWlFiSrNf/ue+abrPSlPlJUrzNg
         bQc7RkPFAkE9tOGs2mi8fRYcCFsVZ/tLKRtMQGu/dk4h9gjbeEY6jDyQcq5C5bHiDay6
         CU4AAqg0fy9XUy6T1gvhkG0zaVapZU5ITd2nTLiiyngmPxRnfCX8KzCtBZ0L6BqAa8DB
         2qShFxanfwqwn72fVGyFlmO79FLkXGqUhrCls3/59cK1D9tzU3RFcV+cMBJYYLFC0bqQ
         AHoak4ESm1XkK5e/4bY7Jott7Dpx+zRxMJApnioSE/uB2WJeyt691VE4wgz4KfLnn+Z2
         QCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153425; x=1715758225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VYVvd11hV7rJunixQLWGyRIvzoAkWZceNjuLWyDIro=;
        b=Q4wikL/gbLhLx5jNdfwdG4sT1YxVhyAz69a5UFDB3+ytAIeWEx9wPU4bLaKAxu0JBF
         GFZZG25qap35DrvkgArCb1JuBeh7J37s7FJU5GlFG7tBuCa3jbHY0MHTMJl/tbeICJH+
         JIVcfTyUeej3kefwcvZlvhhNVLzZY/+/XCzz8LPjEb3Nz7Xn82O/LuqHxo2xLe4ThG+n
         oxiRBmvTA2b3/ZkS11AeG5NrJcDCqdBnje+4Phdi6jm5TChhQ4Us3NbsBYEcbl7ZtcNN
         BBYm2qyCmYQEQNFq+anZ6Uaq3UG2WKRLQN3PSkhmmesxoxKxY6xjrdIn0xCYVF/PuIfw
         5/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWKQ8kD20KdqJnM5qb4njAt66hG1LmRpYp0gekJEm2oSopTU7yvf0/zDJfGMBXMvd9odDaJ4fdblgIs86uflu2pEEBh93ipFx9pmZY+
X-Gm-Message-State: AOJu0YxpKMJwwW7mUJ+l5ksNyoNyHO94iJGA2QcjMbJNLIEvqtDDLfEL
	DlxeqkVsKmwe1vIN7o5pdU+5s682BByo5aqoTePw1TPgrueX0DWM/TF4qx8q3Q60Zp40JYVt88e
	sNtodup8REp0ZVsRoAkRRd/Pzr02Z3CTp0u49GtPpc+eoY2KXaP3QQiA=
X-Google-Smtp-Source: AGHT+IESY233JbBjfnq6GMLDZnMM4NG31o9T4zlVFMeCCFSjl3lZjwhguOSXqQjmzu92DOiPMrJUMA==
X-Received: by 2002:a17:906:df14:b0:a59:bce9:8454 with SMTP id a640c23a62f3a-a59fb94f6d3mr109682366b.1.1715153425329;
        Wed, 08 May 2024 00:30:25 -0700 (PDT)
Received: from localhost.localdomain ([24.134.20.169])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090648cc00b00a59a874136fsm5212358ejt.214.2024.05.08.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:30:24 -0700 (PDT)
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
Subject: [PATCH v2 net 2/2] net: dsa: mv88e6xxx: read cmode on mv88e6320/21 serdes only ports
Date: Wed,  8 May 2024 09:29:44 +0200
Message-Id: <20240508072944.54880-3-steffen@innosonix.de>
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

On the mv88e6320 and 6321 switch family, port 0/1 are serdes only ports.
Modified the mv88e6352_get_port4_serdes_cmode function to pass a port
number since the register set of the 6352 is equal on the 6320/21.

Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

Changes since v1:
- Collected Reviewed-by tags from Andrew and Fabio
---
 drivers/net/dsa/mv88e6xxx/chip.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index bd58190853c7..6780e8c36b1f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -637,12 +637,12 @@ static void mv88e6351_phylink_get_caps(struct mv88e6x=
xx_chip *chip, int port,
 				   MAC_1000FD;
 }
=20
-static int mv88e6352_get_port4_serdes_cmode(struct mv88e6xxx_chip *chip)
+static int mv88e63xx_get_port_serdes_cmode(struct mv88e6xxx_chip *chip, in=
t port)
 {
 	u16 reg, val;
 	int err;
=20
-	err =3D mv88e6xxx_port_read(chip, 4, MV88E6XXX_PORT_STS, &reg);
+	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
 	if (err)
 		return err;
=20
@@ -651,16 +651,16 @@ static int mv88e6352_get_port4_serdes_cmode(struct mv=
88e6xxx_chip *chip)
 		return 0xf;
=20
 	val =3D reg & ~MV88E6XXX_PORT_STS_PHY_DETECT;
-	err =3D mv88e6xxx_port_write(chip, 4, MV88E6XXX_PORT_STS, val);
+	err =3D mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_STS, val);
 	if (err)
 		return err;
=20
-	err =3D mv88e6xxx_port_read(chip, 4, MV88E6XXX_PORT_STS, &val);
+	err =3D mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &val);
 	if (err)
 		return err;
=20
 	/* Restore PHY_DETECT value */
-	err =3D mv88e6xxx_port_write(chip, 4, MV88E6XXX_PORT_STS, reg);
+	err =3D mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_STS, reg);
 	if (err)
 		return err;
=20
@@ -688,7 +688,7 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xxx=
_chip *chip, int port,
 		if (err <=3D 0)
 			return;
=20
-		cmode =3D mv88e6352_get_port4_serdes_cmode(chip);
+		cmode =3D mv88e63xx_get_port_serdes_cmode(chip, port);
 		if (cmode < 0)
 			dev_err(chip->dev, "p%d: failed to read serdes cmode\n",
 				port);
@@ -701,12 +701,23 @@ static void mv88e632x_phylink_get_caps(struct mv88e6x=
xx_chip *chip, int port,
 				       struct phylink_config *config)
 {
 	unsigned long *supported =3D config->supported_interfaces;
+	int cmode;
=20
 	/* Translate the default cmode */
 	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
=20
 	config->mac_capabilities =3D MAC_SYM_PAUSE | MAC_10 | MAC_100 |
 				   MAC_1000FD;
+
+	/* Port 0/1 are serdes only ports */
+	if (port =3D=3D 0 || port =3D=3D 1) {
+		cmode =3D mv88e63xx_get_port_serdes_cmode(chip, port);
+		if (cmode < 0)
+			dev_err(chip->dev, "p%d: failed to read serdes cmode\n",
+				port);
+		else
+			mv88e6xxx_translate_cmode(cmode, supported);
+	}
 }
=20
 static void mv88e6341_phylink_get_caps(struct mv88e6xxx_chip *chip, int po=
rt,
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


