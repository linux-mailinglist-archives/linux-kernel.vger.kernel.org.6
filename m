Return-Path: <linux-kernel+bounces-362505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1F99B5B9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F061C21569
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792D419993B;
	Sat, 12 Oct 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klysyge2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9619C554
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745386; cv=none; b=ROPl4UiN6678MPx01jteOFeLB6SGTVOy28KF6H0R6RfOlc5mHBxz4geccUrHytRt1QjgTRV25zERLvGZ6MTR593V7jnKuOxGjjJuiVcteqtO0ya1ez4+toGNissZn0PXRMo6Z76rJ+7XPb1I3Un7fNRw/ri31OQY3yz3Wzt63dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745386; c=relaxed/simple;
	bh=sQtQyYnPBIkfPu20sTvazsCGFs70YPMd3bjiAxARVAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CMjDRHeJM09pWpNwsdS4CBNWuJJViJY4fsklxAWUT3+iQnqCfMBIgejICUXHopC2idfEIc0AfBmwUVSNjiRTZYL5JaSQVu7sa1EsjWZeZxXP15rqBcBwJeNd9YozmSjnIQ5TMeLKFTpLW46m2CcdOa8VnvpLpGzIZFYOcRo3ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=klysyge2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so415071066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728745382; x=1729350182; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJRnIC60WequNGORONeiB9Hea/09Nq/hPMtXKr7cydU=;
        b=klysyge2g/bRbaW5zpLw7TdORTqqW6RuAMMFQtOlHUEWJXGSlxp7FqnaJQEECtLzob
         DILelPeyPQ5Vv37uCW/0O25AnggW/5u9VgymgfeE5n3nEXTxQIg1NuQysRE/+nZSSPw+
         Os/C/++MPf1ZthuFJQU5CH9enAUVGziPKyeR48CNBg7yo++3jt2hBnqOjkLKP+vdSgNw
         L+5IKhllRhOHbO2MGiaS03As8CklbajIGUN5F6j8GWnrMeJVY13Er8re5Hs03b/tYc+h
         miQgHU5D26ofuR/ZGZWB39kL6F2S+HIWoerPl6tEEWz181Bn8uHh5rgIV11GdoUaw9FM
         fLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728745382; x=1729350182;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJRnIC60WequNGORONeiB9Hea/09Nq/hPMtXKr7cydU=;
        b=pl1+eATRrURIOiAdl0An9pUlxlbfBrRoukqnURkZBVSJ6eRC+elzRFD3tsH8g1aDvO
         8DZqMMB2jiqMNAYSzl4CS96cAeTyxWmWr/BAbECj6oWKCTan9gDzDth4kCG1uRIgh7Op
         MJynoTEPF8zupjO8LmRo1b+qo7RU5ooja8kldzk9iEJWkLfxM9j9IRjpZpEjerOMaDKQ
         HEQg8XUxL1fwkp887kHnakjcbd+FD6SatTj48XT5Q5PyZ2RwJmGUQRlWee4x/F6Jz3m7
         rdZyGRDRWGN1g3dG6VWMPB4UTZrNwWVBY1YhPyg9xZCV+/y1T4WalaWIRS2+s2W4IVLV
         JjEA==
X-Forwarded-Encrypted: i=1; AJvYcCUaD1HyabPKYZskssgSig/wzC8mZQ1eBYyoPKHL8DstIb4n/81Gf2Qk/k1uW+u+caXtU6slfx6OOfPpvlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobMX3Er1aNumXTuKa80apUB0LYS55Q5JdCJ+uGA5dz6tW6j7l
	zHWU5AesEOi3BYAIJlM38kb4dudncv76j9baUPClKgqer3hTJkZU12VqnyRbumA=
X-Google-Smtp-Source: AGHT+IFpf/Bozl+6zhQfgFtZI3YyImp4QuJFGAdhPDRj8o5rrgKpCQZPKFycBa2lnlrw3kXptZ3U8Q==
X-Received: by 2002:a17:907:3f03:b0:a99:c9a4:a4da with SMTP id a640c23a62f3a-a99c9a4b767mr426772966b.61.1728745372622;
        Sat, 12 Oct 2024 08:02:52 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f148b224sm63730166b.50.2024.10.12.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:02:52 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] media: i2c: Cleanup assigned-clocks and endpoint:
 properties: unevaluatedProperties: false
Date: Sat, 12 Oct 2024 16:02:49 +0100
Message-Id: <20241012-b4-linux-next-202041004-i2c-media-yaml-fixes-v1-0-a2bb12a1796d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmPCmcC/x2M0QrCMAwAf2Xk2UBaOhB/RXyoaToDW5VWR2Xs3
 818vDu4DZpUlQaXYYMqqzZ9FgN3GoAfsUyCmozBkw+OaMR7wFnLp2OR/kbTdPiA6hkXSRrxG5c
 Zs3ZpmDmPTOyEzgls+aryD3a83vb9B+rDmN9+AAAA
X-Change-ID: 20241005-b4-linux-next-202041004-i2c-media-yaml-fixes-fcf5c0c1e08d
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Martin Kepplinger <martink@posteo.de>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>, 
 Tommaso Merciai <tomm.merciai@gmail.com>, 
 Martin Hecht <martin.hecht@avnet.eu>, Zhi Mao <zhi.mao@mediatek.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Mikhail Rudenko <mike.rudenko@gmail.com>, 
 Ricardo Ribalda <ribalda@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Umang Jain <umang.jain@ideasonboard.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Dongchun Zhu <dongchun.zhu@mediatek.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Todor Tomov <todor.too@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

On a recent schema submission I did what most well adjusted schema writers
do and tried to find a base file to work from to copy/paste and forget.

Confusingly/predictably I received feedback to remove or alter several of
the properties included in my devious copy/paste plan.

The first bit of feedback was that assigned-clock-* was to be dropped.
Removing assigned-clock-* as assigned-clock-* is a core property which
doesn't need to be listed in a schema.

The second bit of feedback landed on use of additionalProperties:false
along with enumeration of all required endpoint properties instead of an
implied list of valid properties from unevaluatedProperties:false.

Link: https://lore.kernel.org/linux-media/20241010-b4-master-24-11-25-ov08x40-v6-0-cf966e34e685@linaro.org

This series removes the assigned-clock-* from upstream sensor property
schemas and applies additionalProperities:false to properties: endpoint:.

A few missing properties: or required: are added to the schemas based on
output of DT checkers.

The one new DT complaint I didn't fix with the move to
additionalProperties: false is:

/home/deckard/Development/qualcomm/qlt-kernel-tools/qlt-kernel/build/x1e80100-crd_qlt_integration/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dtb: imx219@10: port:endpoint: 'remote-endpoint' is a required property

Since this appears to be some sort of temporary/commented thing upstream
which I don't know the provenance of.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (2):
      media: dt-bindings: Remove assigned-clock-* from various schema
      media: dt-bindings: Use additionalProperties: false for endpoint: properties:

 .../bindings/media/i2c/alliedvision,alvium-csi2.yaml        |  5 ++++-
 .../devicetree/bindings/media/i2c/galaxycore,gc05a2.yaml    |  4 +++-
 .../devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml    |  4 +++-
 .../devicetree/bindings/media/i2c/galaxycore,gc2145.yaml    |  6 +++++-
 .../devicetree/bindings/media/i2c/hynix,hi846.yaml          | 12 +++---------
 Documentation/devicetree/bindings/media/i2c/imx219.yaml     |  6 +++++-
 Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml   |  4 +++-
 .../devicetree/bindings/media/i2c/ovti,og01a1b.yaml         |  4 +++-
 .../devicetree/bindings/media/i2c/ovti,ov02a10.yaml         |  4 +++-
 .../devicetree/bindings/media/i2c/ovti,ov4689.yaml          |  4 +++-
 .../devicetree/bindings/media/i2c/ovti,ov5648.yaml          | 13 ++++---------
 .../devicetree/bindings/media/i2c/ovti,ov5675.yaml          |  3 ++-
 .../devicetree/bindings/media/i2c/ovti,ov7251.yaml          |  4 +++-
 .../devicetree/bindings/media/i2c/ovti,ov8865.yaml          | 13 ++++---------
 .../devicetree/bindings/media/i2c/ovti,ov9282.yaml          |  8 +++-----
 .../devicetree/bindings/media/i2c/sony,imx214.yaml          |  4 +++-
 .../devicetree/bindings/media/i2c/sony,imx258.yaml          |  8 +++-----
 .../devicetree/bindings/media/i2c/sony,imx283.yaml          |  4 +++-
 .../devicetree/bindings/media/i2c/sony,imx290.yaml          |  4 +++-
 .../devicetree/bindings/media/i2c/sony,imx334.yaml          |  8 +++-----
 .../devicetree/bindings/media/i2c/sony,imx335.yaml          |  8 +++-----
 .../devicetree/bindings/media/i2c/sony,imx412.yaml          |  8 +++-----
 .../devicetree/bindings/media/i2c/toshiba,tc358746.yaml     |  4 +++-
 23 files changed, 75 insertions(+), 67 deletions(-)
---
base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
change-id: 20241005-b4-linux-next-202041004-i2c-media-yaml-fixes-fcf5c0c1e08d

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


