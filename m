Return-Path: <linux-kernel+bounces-336966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C26984367
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D91A281D21
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAEF171671;
	Tue, 24 Sep 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="LlC9/WNG"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66ED824A1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172970; cv=none; b=LtuTHeFy7ILiPhEq2C4dOcoeUxaNtZvrS8QNtsEoIxpoc4paBNmlHeSXCzh1dz6UMOsi27xZ/Y4aCf2sVgHyyTKDSJyp+yn6CuV+KwHaBMoyEOmb3F7gBRkVTFB99Uchm1nKO9YmJh6nCE8JKt4CsTatp4mS8FfOdbagJP14Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172970; c=relaxed/simple;
	bh=0NLy0Yu5gsKQhl7kHWWGQVvmS4ZMjU0LrJm6NCx7ah4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AIS2IX4LvM3DQMVkJ5ISM/kufPMcbKehjJxYRbfR0aFktJ8E32+YqG9yEXuLIck/zlOmV1JnHm7I3QuJ2Cj047GxUViYJPAJ2gUmiUniMoZF5/4uXPgFNDK/7nhdSh5Wc3UBUuoETkSngW9fpNb8CQ6+Ft8qSMXpVf7jDuBHxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=LlC9/WNG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so3623661a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1727172968; x=1727777768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y57Ibtgt1zP23aWMDwtUVSUKvmV/IC2JcsKXN4OB9I8=;
        b=LlC9/WNG1+cSmezOHxJiO71ovI0o/0vZhJQ0w8FleF9cFlW/KlN7JQsmQeMAbYfZFw
         RQrkrYJE36rwKHptfeaTMicWmcMNl5H8+nvPEDUJjBQva2/U2LFT9m0kV6eEXT58rpOr
         yFYpgT6pWUcPCwuNV6JLd4aF2gGdxpqKfJyZWdzZABjIzjFfdLF74DL5IP7y1Rk/VfH1
         srcIH3MJ4PMTLPv+w5MKPE0W/RGWfIXC8UDSNFr1yup/lw5yKGR0pwk3fjmnPUN2x9cj
         /iJVQGIX6ojHcepj/FExniGkG8veIESKQSIld3l/RVt5Vk+ebFFCEFV3AMPm7z0Np+jz
         CSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727172968; x=1727777768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y57Ibtgt1zP23aWMDwtUVSUKvmV/IC2JcsKXN4OB9I8=;
        b=K5s29G+b3/aVyHT+hser6aFY+nA9rKBFmVEysUssYNEvneMMSTjIltZ12Sce6WmSFx
         FMVOn+yeOgh+0qQMaVBJsUUyDar17sQD7CiDusQ2PNEnql8d67b9yr2Dsl+FEU9mRle4
         C9F+1tgSGEA/SOvuJC6xYhQSNh9XavCeQq/9DmV32sG/ixoUYjIPnXPF2AylBKqwDdfj
         pJRQrZKChiNdxR1vw/3phsxhaYS3omSWhSazhm3eYdQpEzx4y1WO6oAwmr283VJAQAdG
         4WA29rRp7noRMz12Oxlzaihnl7U2xxPC2E8zYlERn45a60s4oWkCHVi6zHdVpouDmOf4
         SThg==
X-Gm-Message-State: AOJu0YzQDdchEuMwy/UhO6djZLm8EACvzvBeO0T08riVG1gIcvd+g+ef
	M0/FhFZNdPle2xRNoBLCK0IQy/9ApJGAhZ0u4OpmqkFVo37+0wiXTB7NbAvR6xUBIMmAtuhVcz4
	+
X-Google-Smtp-Source: AGHT+IHxkDIDooKDiN5trgHeA5d1FvvNdy8Qz1yU1ArIWXSbVdyscznYv2WTK7P+IqsQoLTzm8h/LA==
X-Received: by 2002:a17:90b:485:b0:2cf:c9ab:e747 with SMTP id 98e67ed59e1d1-2dd7f36cb4cmr19096154a91.1.1727172967663;
        Tue, 24 Sep 2024 03:16:07 -0700 (PDT)
Received: from maxweng-Latitude-7410.. (2001-b030-0251-0200-5beb-19f3-7d17-3d48.hinet-ip6.hinet.net. [2001:b030:251:200:5beb:19f3:7d17:3d48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e05b5c182fsm579290a91.1.2024.09.24.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 03:16:06 -0700 (PDT)
From: Max Weng <max_weng@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: max_weng@compal.corp-partner.google.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3] arm64: dts: mediatek: mt8186: add FHCTL node
Date: Tue, 24 Sep 2024 18:15:59 +0800
Message-Id: <20240924101559.879167-1-max_weng@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: max_weng <max_weng@compal.corp-partner.google.com>

add FHCTL device node for Frequency Hopping and Spread Spectrum clock function.

Signed-off-by: Max Weng <max_weng@compal.corp-partner.google.com>
---
 Change from v2 to v3
 * Remove the Change-Id tag. 
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 148c332018b0..d3c3c2a40adc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -29,6 +29,13 @@ aliases {
 		rdma1 = &rdma1;
 	};
 
+	fhctl: fhctl@1000ce00 {
+		compatible = "mediatek,mt8186-fhctl";
+		clocks = <&apmixedsys CLK_APMIXED_TVDPLL>;
+		reg = <0 0x1000ce00 0 0x200>;
+		status = "disabled";
+	};
+
 	cci: cci {
 		compatible = "mediatek,mt8186-cci";
 		clocks = <&mcusys CLK_MCU_ARMPLL_BUS_SEL>,
-- 
2.34.1


