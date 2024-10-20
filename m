Return-Path: <linux-kernel+bounces-373397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5089A5644
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEED1F21D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEC5199953;
	Sun, 20 Oct 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SguN6/Jn"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EB19596F;
	Sun, 20 Oct 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453245; cv=none; b=pBXJdbX2A9CrNOZQTUWA3rz6E9bP03T8OhXKVaqDsy2SFcymuOLdosGWlusBGgfX5GYcZO8b6GoSzlyWMrJhSgPkZNw0v3xB8ghs+ZL2Ksxet7FmkN4oJjeEUhXneDg2APvZDO37ydOgNRhKRuRCBiFShGUVp58tqZsriRlGaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453245; c=relaxed/simple;
	bh=1KzJp/fai6aB837Tp2XCYOTjK4FVSS8lCtpXFfw4Wj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mP8p8R/T/alMePru76sOc6/xiJm5C7m9fRZ+RHaDB/INu1pU6W6bg030MNldNqBeRPwGvw69cbvm4+xl+kxYRfDgy7fghi8/EIMqZC25VLZyGCmwjimEvNCxvTwx4Y46bekhj8d0zpxX35UimvjZ1pFk//KORHdxs9Ibqp2Vdr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SguN6/Jn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9ff17eddbso529882a12.3;
        Sun, 20 Oct 2024 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453242; x=1730058042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syqLQEEuQIy2cda968KqPmvPAkdMXpl9TyM7P/fgr+8=;
        b=SguN6/JnhUiuRvzM7L44VdjdKbV45x0Uzu1Y1udU4jNnIsgGAn+mMy7+/5yxX7hv6j
         jcUO6C//SfIEjaxxd0hKLPV8paBh3Gw3CxKluFbEB1mArfCPh4z/HhOJAJN1MqJVp5RN
         CJXXa2Cg/MjDPkfYIBDkz85bjkH5LW0nlM5nQNvW1z1oNrIvcGc+FRvNg6lwsaj8YHKn
         gDAhlYLHR6z92Jv3mo0RFnsHScqBpRbXorYkyXQfn9RN3PAAv8wJAlTwdA54UfdX9keS
         h0/lmz+Za5KyNk0zEHZGFhZTXzWv52/aeK2HDbAN+RNE0+rD3VkSP9vRi8NcrK0EdjGU
         9QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453242; x=1730058042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syqLQEEuQIy2cda968KqPmvPAkdMXpl9TyM7P/fgr+8=;
        b=tXD2WmahrIIrCDTcw+oCLk7Ng5/Jrp6lFpWhMICnAHZeNDb/wh2zM/2r7SJWfU0AK0
         xeLAE13I8XtNbLsdSJiUpiUZOR2kPYMJrrJxR7e+Ea8J4Xl4xaXIUVCD7dbS8zu/DSDg
         6aCIMmDVL7un0GJ99OcdJ1QrfSMdN2/jl8AdDoyGhoAHMWm+4paV0EAi6LPK8Q1tF5k5
         NU/aY0lwxGtWD5MadN6fMZJ8IoljdfiakPylbKrqAp9SCO/u/WnBeWCgRYjypQJgqBm8
         zAanuoydvTRqC5Zvd7A5MJxIWETf6KYyQCmMLZZQTSGTUTaxqdmcqXsxrsLIu08mTwFp
         YVMg==
X-Forwarded-Encrypted: i=1; AJvYcCUSyLVLHjRrTtR7jJu/lRiwo4fabKIFmqdfb7AgK82sM9OOWf4AbVBT348xV2oNH4kTWWEhpAPo0g8j@vger.kernel.org, AJvYcCVVt+/G/VW59egNFxtHCOcZmg946w6SZn53njzwty1DHlh7qX3t8euiPZXnmJguKx+lITEhoWhjbdLv4NA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdj4voc4TFvdsIimVTWR0J26AGLo69U/WutfhbmfWzESIMDwaJ
	kApFv3vnimtmUD9X8J5b3ZbZCvf8W7JwgC/V44/8j6N4Xdans8uZ
X-Google-Smtp-Source: AGHT+IH/gdlMGESSvhtbl14hZFRa0X7jzE5onhuD7JHXpbkJXMaKFnK9KJJ3aTbOEPUj4bpYXM9T0g==
X-Received: by 2002:a17:906:a28a:b0:a9a:8216:2f4d with SMTP id a640c23a62f3a-a9a8216326fmr231028566b.3.1729453241634;
        Sun, 20 Oct 2024 12:40:41 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:40 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 07/23] ARM: dts: socfpga: fix missing ranges
Date: Sun, 20 Oct 2024 19:40:12 +0000
Message-Id: <20241020194028.2272371-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reanges, since by dtschema 'ranges' is a required property here.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 4b19fad1e..65d04339f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -81,10 +81,10 @@ pdma: dma-controller@ffda1000 {
 		};
 
 		fpga-region {
+			compatible = "fpga-region";
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
-
-			compatible = "fpga-region";
+			ranges;
 			fpga-mgr = <&fpga_mgr>;
 		};
 
-- 
2.25.1


