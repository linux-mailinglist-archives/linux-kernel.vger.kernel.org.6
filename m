Return-Path: <linux-kernel+bounces-381207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E509AFBF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3897F28421E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F81D2226;
	Fri, 25 Oct 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dDgh23HO"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA31D2211
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843442; cv=none; b=lUKlXpBwbv9q6PBEkduC2ZgMh4+IZflhLDFzANL8W9Tg1MSLd1Emnp69IaUz8HuMwscXz2AIKMu7hCQgTdixshcFHVtknz5hDUMOP0UujqRKYp/nShc0lidGLEvUfiV8A6VXIUcQM34ifPYwOrt/Z+HA4qnXGGgHde6Tt6CFPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843442; c=relaxed/simple;
	bh=aMBPJ6Vd4EmVp93lIiY7OjlP1Wbwmk20lpJHlco8Uuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3UBTMf6p0yroJHxtompUb2IHHnyRt4hTv7LkHgRG6CthiBsv861reEPiuD1rmPSjcEGFtCvgifF19zHUKi8kqmNKAwAMhFx43/u72FedC3xLaCUlXppbtL+yYQI+N0b7pXUkCllV173prBx0Yy4EyFgORmoefZ7BUsFhx5e/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dDgh23HO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1198615a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729843439; x=1730448239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9978JY14w59ULMKg5mN8BKD9mGH4Z1Heuort4L6nsHM=;
        b=dDgh23HOFGYEjQv6VrsSygxL7wDTVaXreXFuNXSYXfPvUnuNz9Ccz5TeFj0lowxRfQ
         tFgfEha/8kzPZ5INb6+3InMte2qviGJ47bmuIyyGDZZFbT14iNMN5Lb+Om6xx6/z2gM2
         vQsCZ+DPgRb7MWUrUDFJOxfa8tF2H61JS9cJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843439; x=1730448239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9978JY14w59ULMKg5mN8BKD9mGH4Z1Heuort4L6nsHM=;
        b=S9fYVJXfNGv20qPppd5rUJoAH1J4SyGIMCjsTXkd0J69FrqoxthwAbcrVuoUonVRJm
         6lTYLCShvUgEyOoa493d/RulPByXta5m60FmMHA8PUe2ZVUZHlq8eCANlljThBo1PzjM
         QA4KYqJTULgzIcAtLRHDwaVixYhfWtTPody/dMbb8Z0UnZRtJ/SxoHV4aC//A0keHif2
         pqxCGg+aOQyWVSESgVetG8kepLyinXqpOn4OqP89Y4lh8NNpv9L3Fs0mYTH5HJqtjTL/
         +S8+1+nTV61cxwD3TSbGTCi5H0upLoCXgPsdvTuxL62e8YaIVti/j6OY0Xx6/4ssoGhD
         3l+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXic5ylQ7/0sqDcqY0fYAfcKR479OSP3Kdo2Y0rgWb3sBBQFhjLuMFVgqmKTcvcg7sHRKJnJXaiFFDkA5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvkq8HopPYGEaAIvzfnDGVWCoQGkoivAXXk+jy8KF3VU5pSi2q
	sS6K0GDTLEKQ6WIAuHZhk+rh6mPzu2j63Zhtv8JspRKEbUEPpqL3HYRC8yv+EQ==
X-Google-Smtp-Source: AGHT+IHGaBCdJPNmo+1SghxDLBaoYb7vIPUnB9rgksuYDIRKf/Aa/Z1cETZCG6RSrD08cs2t09cZpA==
X-Received: by 2002:a05:6a20:9f45:b0:1d9:4837:ad7c with SMTP id adf61e73a8af0-1d978b1ddcemr10997249637.12.1729843439606;
        Fri, 25 Oct 2024 01:03:59 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:5a9f:16cc:8d5a:55e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm558120b3a.101.2024.10.25.01.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:03:59 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 25 Oct 2024 16:03:49 +0800
Subject: [PATCH v2 2/4] arm64: dts: mt8183: burnet: add i2c2's
 i2c-scl-internal-delay-ns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-i2c-delay-v2-2-9be1bcaf35e0@chromium.org>
References: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
In-Reply-To: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
X-Mailer: b4 0.15-dev-2a633

From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>

Add i2c2's i2c-scl-internal-delay-ns.

Fixes: dd6e3b06214f ("arm64: dts: mt8183: Add kukui-jacuzzi-burnet board")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
index 19c1e2bee494c98c0db87308494713a26e304cd2..20b71f2e7159ade7e7d2135aabe6587c8f8d64de 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
@@ -30,3 +30,6 @@ touchscreen@2c {
 	};
 };
 
+&i2c2 {
+	i2c-scl-internal-delay-ns = <4100>;
+};

-- 
2.47.0.163.g1226f6d8fa-goog


