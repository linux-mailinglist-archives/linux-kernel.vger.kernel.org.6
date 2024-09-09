Return-Path: <linux-kernel+bounces-321249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47760971666
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70C71F23101
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEAD1B78FC;
	Mon,  9 Sep 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M1psLMmn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89A1B654B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880677; cv=none; b=DMewVw6vE+aZi+4Ot0S9n8UxX9cV2FrLnsq3JAdLln2rcs/yLZiiCRO1UillxntzQF0/D0NxpG46hkFsEmMfsC6X/R7HfMFxynHXYlv2hS4NbpLJXuBpJFkFoVRfZqFhYShwMGXXjmdN3j0kB/VqbfxGtG0uPxRyuNlWix6vAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880677; c=relaxed/simple;
	bh=rwGFuqx0LaG1XXaNmL2ycpGo94t1hv/I3mXlTrCgi1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jk6uDJuxemZGPTQLh+zggn5rAdjTcfKY0snNbt4wV366/iQZmXMTfoQ/DU7dzDrM9zILcO3FwOpPUPAmqourhMrNSaTPO0xIIL6Rx0KDiwTtXj4HogC6Ezz9lM1r0UfhndTNKSWuXKtQvGckt6RH+8pG6pmkl9H9aZGRJHQSkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M1psLMmn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2068a7c9286so37672185ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880676; x=1726485476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1Ttr2z+4sVDsV8+3XUKUGFQBqd5IhKsFwImuWWsKWQ=;
        b=M1psLMmnAxQvcBha0NRDb8vADZBIr2sqH2FB2S8CAxEEVD5yRPRHr08DVln+9iVApe
         9OkF42QEsTqhqs1YL/D1I6HEp9WNl5U03whAIOnmWkJWoisL+BEdnz8NeUBqHkrFJlms
         nPL/xSPY+Di28KcbAKv4BRuzCFqN57Jzi7axs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880676; x=1726485476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1Ttr2z+4sVDsV8+3XUKUGFQBqd5IhKsFwImuWWsKWQ=;
        b=m5QjixFvmOQ8rqRk3zg7kW2BFXikmAE1ZgCUvEuf3MADWNsCdqJwbFP/9mgSl73ll8
         ZU+bm0wtDQxXtD2/MdAoJskBE0Ent6105Yqow93or4xULeGNWaN4b4US8faInFOd97fU
         wSaSPGggFN5vJzkkoEi4ynuVxDO0/PwJgoC8rU0ZmZJohP4H9g1VPBgezYciQj5URtxx
         ZKtxN6c750USlCkUFKZBmj/rBB6+SAxkwKf83QxlqdR6CP61a2BqSJj90GLGToATQxPC
         BkiT6kPn1EYo1ewpJ9TEi60py3zLyVvR7VzqlhH7RB5uOjw96VARYjbOdqhmY7lf+yR7
         tT4g==
X-Forwarded-Encrypted: i=1; AJvYcCWW4fotIM+t2xe1p+Jq0AIuoKV/8RujUX0edrwmHg8yNChPxOXQtKB1EIBy8U1POIBoYVA6RC4NnBsUaAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRq6e5VNxy75MyxauPtVS1qn3JJrPpFzbaKAqX5QQ/Q4DnlOA
	z6q2McNihWIpSJU/OwWIBykqz1OCoEDpg2pOJ0eDlf/mupjGD1Y6LKnDiGav4Q==
X-Google-Smtp-Source: AGHT+IEjDpYo7XNu9Z1/fDj+e+7JTbEWp4nu6rsFIS8qHBK0NlIS+dKadP5GapUDsdnDfnQtg1bSHQ==
X-Received: by 2002:a17:903:2292:b0:205:5410:5738 with SMTP id d9443c01a7336-206f051ee5bmr125183735ad.27.1725880675836;
        Mon, 09 Sep 2024 04:17:55 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:17:55 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 03/13] arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
Date: Mon,  9 Sep 2024 19:14:16 +0800
Message-ID: <20240909111535.528624-4-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240909111535.528624-1-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing dma-ranges property to the soc node, similar to how it
was done for MT8195 and MT8192.

This allows the entire 16GB of iova range to be used and enables
multimedia processing usages, like vcodec and MIPI camera.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 788dfb5484bd..dfbc50c878c4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -888,6 +888,7 @@ soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
+		dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
 		ranges;
 
 		performance: performance-controller@11bc10 {
-- 
2.46.0.469.g59c65b2a67-goog


