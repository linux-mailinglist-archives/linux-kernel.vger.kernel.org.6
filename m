Return-Path: <linux-kernel+bounces-251788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E99309D5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9AB20A35
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C696F505;
	Sun, 14 Jul 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKASBc2d"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CA44361;
	Sun, 14 Jul 2024 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720958199; cv=none; b=bVKA/veRG1SYTtLGosTXhMvk+9cVdYBVUqG/h8t/JO4vCpUfbBXeBPJqK7VM4LrQhP6aKwHyV7mZi6wxgb6HKkhhAw804j0lHaCSQ3uBK32DGp53DQ7AKBAMxwWMmnJV3TUNQM1SfTf8hwQNQMk650yc6NoxwEZXY9jgLX5o+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720958199; c=relaxed/simple;
	bh=UJ8/PoSPpKQTDpoTTQhmI63mxCQpnB9XHDm6v6vRtkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sziseD9fWIxXDh2JdkCxXY77xY9hQ/FDJy9WHyyvz7i2ie9P9ru388URqZn3OQitnyZch28ldkpf/W+jgxrv6AweGBj7Go4LIfkOrMPtwXwlboPyxg9aZTscPBYm700O8s67ugTE1T9C9mCuvQYdmpvWakhT41U3N8dgSvVmkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKASBc2d; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so22721805e9.2;
        Sun, 14 Jul 2024 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720958196; x=1721562996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLvshrdHcGM5HfCdd7OcKFWvrKVcrEuS2SAZY90FhOc=;
        b=fKASBc2dcw1R+XXPBVJiT8p+dbsd1luDfUWinNb3EKg0qjcck9ATnHjaNg5+ZvrUr7
         rVQQ7HELkvthfx9eZfXbSU9yKcCpRQubzzLLF+ee6D+XD17csLtsXDKveMbYvX08tr0m
         Qdthq+SmHKPAzgQQ4J2hahkxv+MePE2WYH5708pLJttD1qARpHMnij4qgoXnucMMSHtl
         wiFZ2wH4BhqHXtX58fmmMbO/nG2wD/Kt607GceWsrtHVuWuAP8OjZhoH1lpovyk7NLt9
         Vh26CDDg2pp8GtANoCsstWPXXm8tRxxZU/NVY1zBi9/UlgG/oPXvDE7wLLIj/dWA5o2B
         Uhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720958196; x=1721562996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLvshrdHcGM5HfCdd7OcKFWvrKVcrEuS2SAZY90FhOc=;
        b=I/QdwFkwZ25TCrgTRmC99U9dAUPNgFY6n4pXcyyn6OLUEWslQVuM02qbl4BXb/xauR
         IflwlGbj07xFrYJf8P9Z5cGcgj5+fPhZTCwdFDMjrZc69BO04BpV+BrQCVFipW0pU+Kl
         WdrNiMZ6fOgBMqPCfSjLIJSOKqUuKpD1yt/oQaAlsX98WF9J7ZZBuQR6hcNh7gY5/jIs
         5BjqLPBn9GFKmP3MDeRgWOHaS5+b9oClT9YsOe+WXzbGia1WYcyyaI5VtEkNGKs+D0ca
         hnv4EP/5Oy+Nd4CqQulStdBZy2Y2klu3uT7kV7yy8UgrKiGTNjFZxB/4T6Rrnx7+ByLy
         3YPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUud2afyEWVJUdX9EgLR6A3zOnK4S/P5NFWu9Q0vZNGbH2hQUgXVjMWcHhoqHbueKQVtVoI06PU8T/N9+PUd/CEqfW/hg3ytxc182wF
X-Gm-Message-State: AOJu0YywsWVHjJoY6FDd2A65+n7k6pB448jAJpAirZaiS7MM1OWwn0rL
	zBmLj0+y9sxvXU0LXf0d1+RYKXCPIfJ4X/6zpHntCctIq18ZD9wR
X-Google-Smtp-Source: AGHT+IFU24Tu35lO61ckbE6rlAjnODuccohOJCnpmS+jPtyTV87uwYyzlwauWtBeDPENykVeHhJbuA==
X-Received: by 2002:a05:600c:6c59:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-426707e3295mr116180525e9.21.1720958195676;
        Sun, 14 Jul 2024 04:56:35 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25b946sm83440505e9.19.2024.07.14.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 04:56:35 -0700 (PDT)
Date: Sun, 14 Jul 2024 13:56:33 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: sprd: sc2731: correct interrupt-cells value
 to 2
Message-ID: <6ae55300b0915fea4ad6cc533b84815eb3cb8043.1720957783.git.stano.jakubek@gmail.com>
References: <cover.1720957783.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720957783.git.stano.jakubek@gmail.com>

According to the DT bindings, SC2731's #interrupt-cells should have a
value of 2. Correct it as such.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index e15409f55f43..7e55b2b31c84 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -13,7 +13,7 @@ sc2731_pmic: pmic@0 {
 		spi-max-frequency = <26000000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
-		#interrupt-cells = <1>;
+		#interrupt-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.34.1


