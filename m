Return-Path: <linux-kernel+bounces-361357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD0C99A72B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869DFB22F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A97188CB1;
	Fri, 11 Oct 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNXlUD4i"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346F196D8F;
	Fri, 11 Oct 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659161; cv=none; b=YLj1DVLwskaS3+rqEHYVRIFMFLdwSZfANF5vzmGpcU6x2kPO2anpo/sYxf0acC1HKBTzrMyFIk/dG0aj3mgcheCg8B0mWbu6Vp6FW0yljMMsNXGE/NXBwaSVpqKfRY2UTnEvvg4jRfjsS+ZirG3J7FeM6yklV9kxR4MsreTNSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659161; c=relaxed/simple;
	bh=c2sS4xoizsm3otwYaedSca7IFiwsMvhp6CH09ev/rfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNxqE6fEWeWvYGxpJX34/qFLPiGXZ8RkYaa3+UOixHo7oSOkt4EszHHWOM2Hqmifia/Yk1gJeXFRsMSvYg3IlfLdFpTKndHOhVn5ALdyFxI0khhV1w+jMKDrgudy5jMM0dATNP/PKqq5Y9nQXLDHencaK93PVQV45idutqA+OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNXlUD4i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a993f6916daso366353366b.1;
        Fri, 11 Oct 2024 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728659158; x=1729263958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXmHQiif1/lZ9e9bTSFxlQYjcfk8NDtEcw/e34eAG2I=;
        b=gNXlUD4iMMVuZlnZhV71G9MFCEgbLYiAGFEvo5eUeb57OgGxVr5UuQmwMpwR68un+6
         NkQ2yHwVdwr4coROTEhhJ5j4+LSQl1zk4AZdnVzdXluY5XIQXnHwsYt8bNx4Cy5IUlwp
         8TRC9x1+VD8gz/KLDXrmuPsKT/UCeVjQ9Fp5C9DDMvNoynM4mBM58gtnWhilIPAC9oLG
         AxEUkyA+42W+Gr6L3AKadzSMmVvQobuyvI3WNBDJcKjmkuOArRR4/ob3WRmFQu+lSIK1
         i0SdlzvhaeFtyR1iTq8QDL/tyvt560RueIz40yISposKFr0axYcmg+UpkPQuyKmhmpfE
         Wgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659158; x=1729263958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXmHQiif1/lZ9e9bTSFxlQYjcfk8NDtEcw/e34eAG2I=;
        b=g+XjqJMzKxsfRbYMWXlC5tmzBghr4KePJBUxnnTZkcYvzj/kuM1+8xByUfksS32vnL
         WoUrlRoreYHBJR92vBDCPo45vXgGKHH9+HP34ZB+i4216Sg7iPzN+lUGoIAgsPyEu3Qh
         9/poPTCIGbY7W0JR9J8O3tVpYRpIaaxbovyFKnoy1pvfqnDGFNNGKLX14y5k5jhkwXZ4
         RBSbRw9LhKpo4R9hXNAgOPYclFXJhZ99cMDsqSEIqa9VnOWRb+QSnPF9draT8ya0hF2y
         bQck4Us2Xx9NSPh/yt9v3XKfmvh+wx+xLhTlbVd3pJU5H0j1K+2hlcbDdtgD7QAo1mFr
         2KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMKSwgraQgdbFZE8yQafeEiqwSEuLTWmwQ1Kwgg/btaS+UIj5qBx2HeO8GMQ9JjxH+/o5RqIX77FtECoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrv7kNW8neV2VZyC+8Cbw2Br8ODLrwevHN+ehI5vhcmomg18Xj
	8vbnBqvlNxpBLE1ulDCerkK5iYrG/imsIHjE5kua0Fj4p6+xxRQ2
X-Google-Smtp-Source: AGHT+IE8XXFizK2sYPaN1979Tdw2qPZdoWcRjlcOePrjnUpkAGWIvpzDhatpjh6L+W1+ZGUR6lY0Og==
X-Received: by 2002:a17:907:6e8b:b0:a99:a48d:4470 with SMTP id a640c23a62f3a-a99b95af2ffmr202294866b.54.1728659158136;
        Fri, 11 Oct 2024 08:05:58 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0b5sm220879366b.94.2024.10.11.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:05:57 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/6] arm64: dts: imx8qm: drop dsp node from audio_subsys bus
Date: Fri, 11 Oct 2024 11:04:37 -0400
Message-Id: <20241011150439.4027-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

On i.MX8QM, the DSP is in the VPU subsystem, which means that using the
'dsp' node from 'imx8-ss-audio.dtsi' is wrong as it's placed under the
wrong bus. As such, drop it.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 3ee6e2869e3c..f8b577ebdbef 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -603,3 +603,5 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
 #include "imx8qm-ss-mipi.dtsi"
+
+/delete-node/ &dsp;
-- 
2.34.1


