Return-Path: <linux-kernel+bounces-247826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDD92D51F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F7B2158E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F97194A5D;
	Wed, 10 Jul 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2G/q8A3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705281946B9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625807; cv=none; b=MeMnEecDSl0vzB1A3hAe2hfLmM6MRZbn7KZkHjY5tFTOeo42E1Z1XxltYXOvR6DoKiolYwg0/qwkdpLM6UM41T2VGBdmEADNZLAOFvT1juJ6lttarArRUejKf+MoJYWFqprXynnU5non6zh1JvqNTx7QK+FViC5UOQQ9TqUnPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625807; c=relaxed/simple;
	bh=veyaJdNrn/ck60gyTMzDEMhQr9lWypucnih+k9fIm9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkEcI7G4tgloghGEe7AuLLISuG64ihnHfvJjccMZAaxs5xfCEC0TTGufhnfo4DTFbSNPSgLnSGNmHN2M8C+qwIfCbaTbetupp9WWnjAO1gxvelZLLBhKqQlqk8j5bTsMPeS2U9SQcOZyNwN6OvoyZTrp9zNuUeumXV8spZz+6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2G/q8A3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720625805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxZN4ZilGqsOmvvyfDMuz3UlsBXkfVcQfIku429k/1o=;
	b=K2G/q8A3FU6oTFokJsqbRiV+ktcFWBqa0u0sfjC7lORnrb3KAGp9Rv8HWVkMGt03h/zKXN
	Tg28nscOY+Qc8OqVoQeWB/T1MU2mdUpq4Lt7J1Q8Zkxxm3nWPd6xJnrvnTJdtDVaiFjmLZ
	sU2FgMmRC1kQOKOuzfkqQSBSm3BS7FM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-RPskMySCN--7-25e3JHpog-1; Wed, 10 Jul 2024 11:36:43 -0400
X-MC-Unique: RPskMySCN--7-25e3JHpog-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-70378b5ae9dso1552139a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625802; x=1721230602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxZN4ZilGqsOmvvyfDMuz3UlsBXkfVcQfIku429k/1o=;
        b=XBQP+DF1nFQbGEKLtbllEPyfExEQpBJvsxEuVyaRc9UPFIUsF7qQCknAfuPTIGlzYU
         9R66bnk/fywFfWUK8G9Yf+GthxEQirRXFXFP0MIZdjGPORgwBHTfx0SiIKllM11p+zcg
         nbLBm83lIuF5QrFuf2LlujF4dM42N0lQ+KhQt+6PVzgUWuXRqUvwuy9z7eTwmwF0YVgU
         f0IfWV22O/G7BNp8B5pt5Y0VrRwhTIV92VrPmXsauXihJGY9x/gi+Mvuol2uUVPUDZ5I
         V8HH/cXQZCviu/opE1ljrl2lj50JYu4Plq/BCyYrrrnnQibQZ38fRC0OweGBiEyXBhFK
         aZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHeJWs4OYBYPJi32q7b0EFNFSMnhYbZVt82gsvE4b8jHYgkKaKUzXers4iVhSX08JpgU2oZUh1YqBTHI0oCIblAO8kiVN2EyYWX3AK
X-Gm-Message-State: AOJu0YzRDhsuKEKgz+N6kd13hqywjLRKaEQAESsvr4h6mnx03XY8SjkT
	bGgJpY5/FTkOHDvQ0Efuy6MeP6GxlqvKYRXrNkJj8SvDcy4M4uIZWEUeujAE6a5n+q0HgvwMj8j
	D/B2d8trzcc+5qWjbpqSobFGEsHIE98kgYHMqSVcUF9FV5EqoC12lHpoq4j2I5ThAe2ENNrjMs8
	ywpFhlUwaIA8/z8/aaJ07IE54gRsAK0pQkegL1Ne+2CUvC/A==
X-Received: by 2002:a9d:66d5:0:b0:703:5ac3:3e4e with SMTP id 46e09a7af769-70375a01c86mr6112399a34.7.1720625802044;
        Wed, 10 Jul 2024 08:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHAUqC5HU/yJwHR4Exq+UfpcBrlCUa78j51rV07MT9lcAjDtF8mxW21xRp1GXfZnXkHHW42w==
X-Received: by 2002:a9d:66d5:0:b0:703:5ac3:3e4e with SMTP id 46e09a7af769-70375a01c86mr6112372a34.7.1720625801554;
        Wed, 10 Jul 2024 08:36:41 -0700 (PDT)
Received: from [192.168.1.111] ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba74d8esm17970576d6.94.2024.07.10.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:36:40 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 10 Jul 2024 10:36:13 -0500
Subject: [PATCH 1/2] arm64: dts: ti: k3-j784s4-evm: Assign only lanes 0 and
 1 to PCIe1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-1-03850fe33922@redhat.com>
References: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
In-Reply-To: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, mranostay@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.13.0

Currently PCIe1 is setup to use SERDES0 lanes 0 thru 3, and USB0 is
setup to use SERDES0 lane 3 as well.

This overlap in lanes causes the following reset related lane splat:

    [    4.846266] WARNING: CPU: 4 PID: 308 at drivers/reset/core.c:792 __reset_control_get_internal+0x128/0x160
    ...
    [    4.846405] Call trace:
    [    4.846407]  __reset_control_get_internal+0x128/0x160
    [    4.846413]  __of_reset_control_get+0x4e0/0x528
    [    4.846418]  of_reset_control_array_get+0xa4/0x1f8
    [    4.846423]  cdns_torrent_phy_probe+0xbc8/0x1068 [phy_cadence_torrent]
    [    4.846445]  platform_probe+0xb4/0xe8
    ...
    [    4.846577] cdns-torrent-phy 5060000.serdes: phy@0: failed to get reset

Let's limit the PCIe1 SERDES0 lanes to 0 and 1 to avoid overlap here.
This works since PCIe1 operates in x2 mode and doesn't need 4 SERDES0
lanes.

Fixes: 27ce26fe52d4 ("arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode")
Suggested-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 9338d987180d7..e54ccf4f37955 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1391,11 +1391,10 @@ &serdes0 {
 
 	serdes0_pcie1_link: phy@0 {
 		reg = <0>;
-		cdns,num-lanes = <4>;
+		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_PCIE>;
-		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>,
-			 <&serdes_wiz0 3>, <&serdes_wiz0 4>;
+		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
 	};
 };
 

-- 
2.45.2


