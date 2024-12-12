Return-Path: <linux-kernel+bounces-442612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F029EDF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A67C188AAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247B1F669F;
	Thu, 12 Dec 2024 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="qihCQYDk"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622201E5738
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984476; cv=none; b=OTNios6m+0NJkccnHGgl5GghP96ZDEseylZ0xSkMxlfFrxH85SLgdEzsyQds09StMM87Igxx24yPUEihcbIEasVEicuBUBj2VuS+d080GgQepnfEh5a573H88t28ZfO4QfGS+U9CX+7+EG/g4t2ewaxlt7InyLZKYFGsDLQTlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984476; c=relaxed/simple;
	bh=7wpNKaFrd5c/IzJtMd4SFd4xvNmYlDw84oGN8fRDTCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pHsluMIhqfBns3bMAaD59RTkl0VjgvjZAil0DaCbnctUkh8pXE2VUiWW3e8CDlBn3E/CPC/UUl/0ymN++ZHM8RquQnnzh8ihO8Q9cKQlIdGej62ou/uCWBtJ6rHSrBEBk5cnxmCz3LzdsfpbY9Pd9x+CiNawlFKYL+L1tPXuTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=qihCQYDk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215e2f17dfcso471815ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1733984469; x=1734589269; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LfBkU5xN0WacDydGlClNsMc9BslSTszE5PxuLZUJYg8=;
        b=qihCQYDkam7MfJ9J2Y/b7LwzqNOSCH/Rf7nmaJriW93uTidkes+ZLf7eUPDM04uU8M
         9um3Fn25GOh5WUjl/Y6n59rUUknjMUwKdFPgXZSNy6HOGVHgFpIWPlqI9sSUm7Ul7RO7
         AhRR304uiwiA4pQxkaBE5Haz71zncYpe6xXmIoRrfVMDXw+UUO1vUEy/W1TzAb96dfMY
         zEbPnUgtFRpN1453ywm0LqbZFx25cz8UOOMOo87IoJnZmz+y3gN9wZAfuknzCBBrc8kp
         WTmvzm+XNnXRKZlSifcOBSyvmHC76M/Tm24vOmBvtTk96eZoayI0uLFbuZI4NdWbXZuJ
         LSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733984469; x=1734589269;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfBkU5xN0WacDydGlClNsMc9BslSTszE5PxuLZUJYg8=;
        b=DioKXSCrESLbHiocOusSMSdv5rhtsy9ewWeQPudO5rotk3e57Bl3Kf7vB7uiwFkfY1
         J73sJ+B77rB2N+Sag73jONV0PgW+7U0Ta2SPgkT+HCe3oZpCsICejnXdqwG+oEq/gBSL
         WlgJje4FQ2+g7cW9IV+acIfR2yhbyOCg/KzY4bsyhcBCCJr/nqvmhpawzrWyAwRqVAFF
         wOaFQvf2X0DvnFRDPSqH+tOQFmZ47sB+F4jZKvyWQKWcJjDlXLM1t9RBxFoidmSBJMfY
         jD2rideDwHB7vmOrpq8m4ePhFsu+e8nZ0U6waNSB1TLkQ8V5ZtDVTVkm2btLR2bonPLk
         J3RA==
X-Forwarded-Encrypted: i=1; AJvYcCVHrbI7SY676DKIbeUc0U4o6GbYWqKPdS2j4iZQoqw2uUR+wW2ORlIA/zXmfzZiqSdED2vCnvYmk7LZ2ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKOIDDnH9SRUAfUeRoshHWFFkGz+d99OaSmOI5KGEO1ud9y7M
	8KmCz1wxCW1RwyJMJgWVi4KHGBa7bvPObKMBYIBOkoejw7aY4kIR28qjTxlmPiQ=
X-Gm-Gg: ASbGncvnQO0BpjFA14qDUFQ5h4RHG4f8XT9f+UEqg9esbPhVV0LJ+jEJjx8Mnx2BJjq
	Xdd7NlWzSQqb89SdtnAdfGt8vBH4pPZ4yk6UBsnfmNFdknTJhvRHl7+OaiKs5hQKCsbgajWdnUi
	2t7av7Cwdilbc5miRBTtmIEvQe3EdHAVmzz+nKBpO2T/ytx9zmi2K2dhduEzyznsa5Dds3kd7Jh
	hKr8xePiSSHFSBhADh5hQJqHoC+Eec7GLTxmjvxVLQQlTvIPHAcgB5+8ll4pEjQWHJmMKDrT7In
	J8xWNA949Wkl3VFZltmz
X-Google-Smtp-Source: AGHT+IG1aykVIJ7KK1nMnneAqk9zPBfBBGEs0+epeO3ZGiz6cJuzU7kmR5k6vnbujqI2WNuSBpIchQ==
X-Received: by 2002:a17:902:d482:b0:216:42fd:79d8 with SMTP id d9443c01a7336-217785929d6mr36812415ad.12.1733984468684;
        Wed, 11 Dec 2024 22:21:08 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162c278668sm83579165ad.81.2024.12.11.22.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:21:08 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	dianders@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v5 4/4] arm64: dts: mediatek: Modify audio codec name for pmic
Date: Thu, 12 Dec 2024 14:20:46 +0800
Message-Id: <20241212062046.22509-5-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

change `codec` in pmic (in mt8186-corsola.dtsi) to `audio-codec`

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index e324e3fd347e..cebb134331fb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -1276,7 +1276,7 @@
 		interrupts-extended = <&pio 201 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 
-		mt6366codec: codec {
+		mt6366codec: audio-codec {
 			compatible = "mediatek,mt6366-sound", "mediatek,mt6358-sound";
 			Avdd-supply = <&mt6366_vaud28_reg>;
 			mediatek,dmic-mode = <1>; /* one-wire */
-- 
2.17.1


