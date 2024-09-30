Return-Path: <linux-kernel+bounces-343811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1E989FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2871F20FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48518CBF9;
	Mon, 30 Sep 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ALVfrWqs"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C718CBF5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693544; cv=none; b=jRbCHCudahZBv0L93wCe5sf7bFxfeEJ/0kwrWX+BIk5OhcXHz+uC7/WHi/Ge8SGIQIiNLTVRES9YpgB3dbQRoBN1Jm7cnl725EfKj6ztfOyuMzTKJSzIKOxRFkvFBh8QBb6BXD782jiTDMP7mapfOHl4DGCw1kYs/tlHPjtBLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693544; c=relaxed/simple;
	bh=qgtXNHUaMC9gvm0ihmJZWKtB+fMuAqQuoPe5R0FlK4I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qf9VUVaMHKjx2sn2bu6UtpPNwjC+SafyZiA4atl9V0fTcSdF1IzqYWoppTWTZPsU8MPC9G8+H4OWCrdAwUCF/7djfZpodNaTuo7loPCdaOtGa84zZKLmPlNAhHv/a82+fcD4X8kWTc199rQrwG+Cf1VwyolH/H+na8s8Y3FbhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ALVfrWqs; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5399041167cso1599675e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1727693540; x=1728298340; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzUsANdIoZzXorl2vv0C4CsPY69b8z7/pL6IfXOL+tw=;
        b=ALVfrWqs6Exok1jgn8uhnvMe5w0KS8YXUKfqG8/WWIsJPlNb3ymlJyYjR0JXvVt5oe
         MHP3AnkvlJza7ZymckT1i637MaotE25ra8H9S3uzV8O0sg1w//L2JK7oTDW8ByGjQsdw
         ZZX2xO9GPzQqSrZK9VrfrRKX4HK7LzB7s3bXNm7DEiNO2/3aYene12gfiImR47c7INMY
         wdor82ArZaeyyEwCMVG4KdDTHUNJqxxwLgCFz7JdFtgeRpkGAZYwunK7bj1q2maYhFJU
         K8JQ+yfu5ipllmoFBaQg6ccBpxtQgn3zhkP6DlfT3za2hRQ1U+O+1K1h6nTK/L/BbtNM
         /rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693540; x=1728298340;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EzUsANdIoZzXorl2vv0C4CsPY69b8z7/pL6IfXOL+tw=;
        b=sZZn7SnBy+rwO2v7zFNPuxPK8Rij8AQehgjIHVp2t2RfhiXa2yqiE0yu0bDzMiIeT6
         nhnpwN8/mUP4oPKRKqTQNrMsEaTC+YLQimiPho8uKZ3BypX1xnOLBhCz7F1+cNdKZdrl
         z5bt3XfgODObmf7EdrYbkmpz0BIFv0rVnjIxAiIY0DVc7L/6/shgcHy6TgXF+FdpLsTh
         K71vKRIUKxvX0r0JMr4VLMbPp9gvJ85N63vu7oruhXOxnSEfVnm77pXMrU2SFBgNo9zi
         tt8SnyZsq72zEXXdXWHLThY96dw4tJQD0/dSEKf49jqE7OwFStQ9P+BZQaNvg+g+47H4
         dZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzxWq7c95q1cQE/bCbwHiM6OmICDlza6w6S3GOGDIaYu/Y+5PO2pr/nN9DG9Zj0q+ujAA77hMUzBBByYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDqwZQ7QSWCGpko4gMZDmN1E5AggSMK2qg+blFh0jgiNk2dzf
	jbag2x9jdU/VK4kVeO763u70sS1+sqgdXvgOuvMJDeLhQJbMfEMFI0ly60en3wY=
X-Google-Smtp-Source: AGHT+IGhRweJOPkFGgAuNfktksGfPKXdF/ylFGqi9MZzfaoXda6AfoM5num/meZEhH8NA2EoHz2Tyw==
X-Received: by 2002:a05:6512:3ca0:b0:539:9767:903d with SMTP id 2adb3069b0e04-539976791e8mr1198960e87.60.1727693539700;
        Mon, 30 Sep 2024 03:52:19 -0700 (PDT)
Received: from localhost (dynamic-176-000-009-164.176.0.pool.telefonica.de. [176.0.9.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299861bsm511772866b.192.2024.09.30.03.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Sep 2024 12:52:16 +0200
Message-Id: <D4JK8TRL7XBL.3TBA1FBF32RXL@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Suresh Vankadara"
 <quic_svankada@quicinc.com>, "Trishansh Bhardwaj"
 <quic_tbhardwa@quicinc.com>, <stable@vger.kernel.org>, "Hariram
 Purushothaman" <quic_hariramp@quicinc.com>
Subject: Re: [PATCH 00/10] (no cover subject)
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Vikram Sharma" <quic_vikramsa@quicinc.com>, "Robert Foss"
 <rfoss@kernel.org>, "Todor Tomov" <todor.too@gmail.com>, "Bryan O'Donoghue"
 <bryan.odonoghue@linaro.org>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kapatrala
 Syed" <akapatra@quicinc.com>, "Hariram Purushothaman"
 <hariramp@quicinc.com>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konradybcio@kernel.org>, "Hans Verkuil"
 <hverkuil-cisco@xs4all.nl>, <cros-qcom-dts-watchers@chromium.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240904-camss_on_sc7280_rb3gen2_vision_v2_patches-v1-0-b18ddcd7d9df@quicinc.com>
In-Reply-To: <20240904-camss_on_sc7280_rb3gen2_vision_v2_patches-v1-0-b18ddcd7d9df@quicinc.com>

On Wed Sep 4, 2024 at 1:10 PM CEST, Vikram Sharma wrote:
> SC7280 is a Qualcomm SoC. This series adds support to
> bring up the CSIPHY, CSID, VFE/RDI interfaces in SC7280.
>
> SC7280 provides
>
> - 3 x VFE, 3 RDI per VFE
> - 2 x VFE Lite, 4 RDI per VFE
> - 3 x CSID
> - 2 x CSID Lite
> - 5 x CSI PHY

Hi Vikram,

I tried this on my QCM6490 Fairphone 5 smartphone.

Unfortunately I couldn't get e.g. CSID test pattern out of camss. I've
tested this patchset on v6.11.

These commands did work on an older sc7280 camss patchset (which was
never sent to the lists). Can you please take a look?

v4l2-ctl -d /dev/v4l-subdev5 -c test_pattern=3D1
media-ctl -d /dev/media0 -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
media-ctl -d /dev/media0 -V '"msm_csid0":1[fmt:UYVY8_2X8/1920x1080 field:no=
ne],"msm_vfe0_rdi0":0[fmt:UYVY8_2X8/1920x1080 field:none]'
gst-launch-1.0 v4l2src device=3D/dev/video0 num-buffers=3D1 ! 'video/x-raw,=
format=3DUYVY,width=3D1920,height=3D1080' ! jpegenc ! filesink location=3Di=
mage01.jpg

The last command just hangs instead of producing a picture in
image01.jpg. Can you please check if this works for you on your board?

Regards
Luca


>
> The changes are verified on SC7280 qcs6490-rb3gen2-vision board,
> the base dts for qcs6490-rb3gen2 is:
> https://lore.kernel.org/all/20231103184655.23555-1-quic_kbajaj@quicinc.co=
m/
>
> V1 for this series: https://lore.kernel.org/linux-arm-msm/20240629-camss_=
first_post_linux_next-v1-0-bc798edabc3a@quicinc.com/
>
> Changes in V2:
> 1)  Improved indentation/formatting.
> 2)  Removed _src clocks and misleading code comments.
> 3)  Added name fields for power domains and csid register offset in DTSI.
> 4)  Dropped minItems field from YAML file.
> 5)  Listed changes in alphabetical order.
> 6)  Updated description and commit text to reflect changes
> 7)  Changed the compatible string from imx412 to imx577.
> 8)  Added board-specific enablement changes in the newly created vision
>      board DTSI file.
> 9)  Fixed bug encountered during testing.
> 10) Moved logically independent changes to a new/seprate patch.
> 11) Removed cci0 as no sensor is on this port and MCLK2, which was a
>     copy-paste error from the RB5 board reference.
> 12) Added power rails, referencing the RB5 board.
> 13) Discarded Patch 5/6 completely (not required).
> 14) Removed unused enums.
>
> To: Robert Foss <rfoss@kernel.org>
> To: Todor Tomov <todor.too@gmail.com>
> To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Kapatrala Syed <akapatra@quicinc.com>
> To: Hariram Purushothaman <hariramp@quicinc.com>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konradybcio@kernel.org>
> To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> To: cros-qcom-dts-watchers@chromium.org
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
>
> Test-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
> Suresh Vankadara (1):
>       media: qcom: camss: Add support for camss driver on SC7280
>
> Vikram Sharma (9):
>       media: dt-bindings: media: camss: Add qcom,sc7280-camss binding
>       media: dt-bindings: media: qcs6490-rb3gen2-vision-mezzanine: Add dt=
 bindings
>       media: qcom: camss: Fix potential crash if domain attach fails
>       media: qcom: camss: Sort CAMSS version enums and compatible strings
>       media: qcom: camss: Add camss_link_entities_v2
>       arm64: dts: qcom: sc7280: Add support for camss
>       arm64: dts: qcom: qcs6490-rb3gen2-vision-mezzanine: Enable IMX577 s=
ensor
>       arm64: dts: qcom: sc7280: Add default and suspend states for GPIO
>       arm64: defconfig: Enable camcc driver for SC7280
>
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
>  .../bindings/media/qcom,sc7280-camss.yaml          | 441 +++++++++++++++=
++++++
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../dts/qcom/qcs6490-rb3gen2-vision-mezzanine.dts  |  61 +++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 208 ++++++++++
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/media/platform/qcom/camss/camss-csid.c     |   1 -
>  .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |  13 +-
>  drivers/media/platform/qcom/camss/camss-csiphy.c   |   5 +
>  drivers/media/platform/qcom/camss/camss-csiphy.h   |   1 +
>  drivers/media/platform/qcom/camss/camss-vfe.c      |   8 +-
>  drivers/media/platform/qcom/camss/camss.c          | 400 +++++++++++++++=
+++-
>  drivers/media/platform/qcom/camss/camss.h          |   1 +
>  13 files changed, 1131 insertions(+), 11 deletions(-)
> ---
> base-commit: fdadd93817f124fd0ea6ef251d4a1068b7feceba
> change-id: 20240904-camss_on_sc7280_rb3gen2_vision_v2_patches-15c195fb3f1=
2
>
> Best regards,


