Return-Path: <linux-kernel+bounces-296694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570FA95ADEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1065B1F23250
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707E14BF98;
	Thu, 22 Aug 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LojdAPvO"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22B4963A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309231; cv=none; b=GLcRUp5ZWDyjsoov2b9h+BqXqVooAs5MKKqDTHw/z1ysBUqF3P9c9DENu9mzqvnPXP35R8mDelh9Fm8iKoSJmJf2K1fP1dxk5qwe/yoQKZmT6VZZsBjpfsXK2PgV9hZbJ/HK65wQVobj5E2GU7GpgbrzYvbtuCKc1ZzKxmcsyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309231; c=relaxed/simple;
	bh=4prlT2M7ptUqVHJcht1st+Q4i8V3iRCnND+nUDH4uSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQMUhpXlDbBE2EytvD1v4HEbjUX75reFyPv3gYqfKOdujnyQniYbem1ttFtyPQ8hHQM6NDyz41ksuG8HvyjM6a7xMoISfezGBHPypd7UM70SXFiSqPukRLfFvnjYrbX+voXL3MMlCq/ek7uovvpu+HFSlObxNtbXDiV/Ngtwd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LojdAPvO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso357707a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724309229; x=1724914029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iox3pW+t1+/mCNWqBkSwh8gOTlOVaTTolmdqxDRdGuE=;
        b=LojdAPvOJnREJxYUBfk2+10UGcePw5EjiX9YfKrimetPKWvs9gFHNZta7UBt8BZprN
         sHVtTy/8PsKu7/PNFCuZU/RmiuolcanfkZiRr+BofhmwJNKOcAxMX3w+uNCbSVqru/5i
         C9ORygHaZbnIVVjaui3qX3FfaYzNpIvI7SK+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309229; x=1724914029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iox3pW+t1+/mCNWqBkSwh8gOTlOVaTTolmdqxDRdGuE=;
        b=naT+iX7sFeVzAfYvZJh+j3pNlzsWXJLayzm/Ek7MPM2MEab1Qg8I0OsezV0qAuMEA3
         jzUuHy+i8w4q8puX1ZFJku82RGPi/AzNwFd8JnEQef/b82e3etXQdzGBHkdr/GTGVMUz
         VkZUXbbgPrT1olLKTV810+mMuch31UGsPjW/VtsHo6kgLZgpdMxYynuqdvLnJ57h/WdP
         FTcAbdkpYIGaDNmEfkn4Ijr34Jh4jMTkN7FFi4aS8K7uMlZEm+1KTJnHzKjgEIwXpR6D
         qkoARkDOm7hCMFa7JJD6gp5cE4fjDNhnS0/NaSPwQsXnrtIBNWOG7MBpMLeGsZwX6GYz
         AnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Bb+LCNgBXpAS16R3da9jo2dKt6hnCjxq63Z9XX3s4VLMGHEtXy48xgMog2QcMgxB6JmosbqPcywdNFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcArceBp4v6RuuCH/ZZj2zh3wGivvg/NtfbN0dxdjFYdZX1hXp
	3vxNVdOGEVPdfxSvmNbF4ok1fv690aTaTyasAnz3jDkO5j6KCbfh+w876RjWyQ==
X-Google-Smtp-Source: AGHT+IGDm0aYL8ExBHHTkePgeJ1dnpbTcM/gseUSEQPj47QfaHrXBDFNOT0Ci3LVj6t5wZrZxdp1CA==
X-Received: by 2002:a17:90b:4f89:b0:2d3:dca0:89b7 with SMTP id 98e67ed59e1d1-2d5e99fb6d1mr6084906a91.3.1724309229382;
        Wed, 21 Aug 2024 23:47:09 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d5eb90c542sm3166866a91.18.2024.08.21.23.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 23:47:09 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [PATCH v3 2/3] arm64: dts: mediatek: mt8186: Add power domain for DPI
Date: Thu, 22 Aug 2024 06:46:49 +0000
Message-ID: <20240822064650.1473930-3-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240822064650.1473930-1-rohiagar@chromium.org>
References: <20240822064650.1473930-1-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power domain phandle to the DPI controller in mediatek
mt8186 SoC.

Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4763ed5dc86c..e27c69ec8bdd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1824,6 +1824,7 @@ dpi: dpi@1400a000 {
 			assigned-clocks = <&topckgen CLK_TOP_DPI>;
 			assigned-clock-parents = <&topckgen CLK_TOP_TVDPLL_D2>;
 			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_LOW 0>;
+			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
 			status = "disabled";
 
 			port {
-- 
2.46.0.295.g3b9ea8a38a-goog


