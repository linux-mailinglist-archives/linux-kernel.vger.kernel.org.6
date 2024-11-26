Return-Path: <linux-kernel+bounces-422080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9349D9444
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1366F283795
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218D1D5CCC;
	Tue, 26 Nov 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m8nlkNVh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7A1D54F2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612889; cv=none; b=kWjmuwB/e8itQqGn/u024oQanxbVXlq2kuWgzkopL6exdUmdJVeNhEzIzZwyUrouFEQAyqliF2R+HEechqKZs3DIRaLNJtwZMI9nA6plsp+FxDtRn1+K2ChWveBXD8/9evJ6iUzvoXyVM6BTe0BJHgHbVILHsjpVkcKn4/xN6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612889; c=relaxed/simple;
	bh=65f39XdX+JOlbTHLjNv6Nr2gl6HREhiCkJ3xGoC26cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAUZnD1w4kU1MqqncMhhE4d74Dt7h1IucSiL8bkXbgz7v2ElnqGNdRaZVMhU3PJW/lBODIRw9RjOFRZStA/yDpfdF8rh7AONGNd2vX9b9VRGT40BiscmCj2d6pHNiPR5frzSLUFGnyz6F3/kSp0j7xc10kVOA+EKUvA/UIoL8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m8nlkNVh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a736518eso3700565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732612884; x=1733217684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4yY5kKHWBOgnydB5P9+GaDat1sMgmo5I0rPUXNWFHQ=;
        b=m8nlkNVhsaB3jK7XongGdX628G4LHMoP0RQb+Fy2eThGVVjEpYrIwzavXgidYzXjpU
         Akrc2K7sKR/89kelyfMJHdrFuLjNXnRe7qLuRhmkQL25PTdqWdrLdqfV4KJ7lKxB/Zpe
         AsBPGroAlW3ebNVbLZ96mDTSxMaeIFRj85CXXA4R0Bu6HfPNCyXQtgrk2t6HhhutSHHk
         Y4szJqEUgY19SJU1s1cXtwhWV2FIolcF7Op8oeYeKnpetH7MZTiTsWXHmQtIS9K2+2L1
         gyHrEC26t/ks/8oydQHYVQ7AmO/LpIoRpakONOsedYvRhYPxKsBRh5E0O5kgtRD89RGD
         HxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612884; x=1733217684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4yY5kKHWBOgnydB5P9+GaDat1sMgmo5I0rPUXNWFHQ=;
        b=k7hxFip4Y3nDT6QILKIP178vpvbtQorhyHPDv3Xvghpzio9bgAMTxmReoGDtLnQwZT
         YBYgl8h/6Q6Pz8z5zmgayNkGVH19GKLnfgQaixUATbn2ixpzox+RwEn6E0xd1Vmm6Caw
         NdDrz1/rDHDCFYqLA2AkTP+MN+Rq9Sq6gp4tokqIG0aE/JHNuRDLW3dHMpQu6KXONo9x
         vJL+IohUEn/LUhaYEnct/hGYTAvX/jAPqTxBeps60swuhXihbr93Ev9qmV5LqtoZhvCC
         I2QdEpwqZX3um//E8LmKQo/0bG4B1rSNxlW4MqTMzeFOlPpzp+9zXH4ko2r1N0vbuTEC
         PftA==
X-Forwarded-Encrypted: i=1; AJvYcCWmTQJ03D0iaWwosKSJDxF7tv4zBU2f/xNG7i+td2l5evQk2In1JcLdqp+6dfs5FmgJOP+K335b4NpbYmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUWuyvSJ/94cyp5kq1bwsz8067oNpz50P3k+hjNEKzCJhnVcs1
	eXEIoWR9E0AtCnjyFVRk8mXgacFXLaehAnU2ZVu9dxNMxdA/bATjqRk2Ub0mqXw=
X-Gm-Gg: ASbGncsEE6GN+Rm0dxaPeeYavUmrFcQPUzpmzRbLCZc19Ps4vnTCqvKctubWoYWRXyk
	TozNTH+Sbqq3lpLzpvviMKbQ20GusZAEX1EAWpXOkcv/hPSZpx/On+e696V6XNAU27fsgcHz7fP
	oUZU1AEiLkNYpkKTmSyKL00A47Qwq55k+rUdqdP7WrcmpTibKKrLFblw4qbZopASIJp1Jp1tifd
	sanF25QKlGj9nRy8kT4gta822pJVBoPvn8hR0W5JVRa4TEdCxkB+3ygxtnlzc3+bc20mNFM0Ytl
	BSg=
X-Google-Smtp-Source: AGHT+IECNxqnMdsMr8sIEyPl41XrbsF2Eglii8m3iIb2siIoiQVCnnx0E2A0rJ4JNGhhSHg/JoNpCw==
X-Received: by 2002:a5d:59ab:0:b0:382:450c:25e9 with SMTP id ffacd0b85a97d-38260b8ce0bmr16781285f8f.35.1732612884408;
        Tue, 26 Nov 2024 01:21:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm13027694f8f.73.2024.11.26.01.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:21:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 11/15] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
Date: Tue, 26 Nov 2024 11:20:46 +0200
Message-Id: <20241126092050.1825607-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S USB PHY control block is similar with the one found on
the Renesas RZ/G2L. Add documentation for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 .../devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
index b0b20af15313..ae59c2dcadbf 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -20,6 +20,7 @@ properties:
           - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
           - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
+          - renesas,r9a08g045-usbphy-ctrl # RZ/G3S
       - const: renesas,rzg2l-usbphy-ctrl
 
   reg:
-- 
2.39.2


