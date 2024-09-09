Return-Path: <linux-kernel+bounces-320756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ACD970FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08841C20404
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346E1B29B9;
	Mon,  9 Sep 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YWjxYXcV"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90D1B253A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866961; cv=none; b=jacdNw7XDTvxS7NvpOFRZusRmmM6bnCr4kk3A3jnFbtajeyWDcGPhjmWnLHI7mM1TIx/cmOYWClAHI/65B53h5ocMvYBoSPgyWZMrESSPvmoaDtljjelmvXRLFLg9LCHI1BBU8VHG5jvOicQ6JuUXdc0KPMsQzxEnEvldcTqvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866961; c=relaxed/simple;
	bh=YHpKzUFRJUw72aDIYJEwTsqzT95XdHz6W84tySFtxCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOv4qVCJNGSFb839Tv4q0ZdiGNVeod3UrncjS3+x+3gn0InQtEDXyFjNqXEA9RYgHkQFLDfpEEfDqpf8Fv4NxM3Kzp8Rc5lbnO78qC2qhJhx8RE4dY503mPUD/d3q0zzM81Q29h4dIlETlQMVR9EolEtrINezC7QgwJCZWMB1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YWjxYXcV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso3106386a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725866959; x=1726471759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAga99RtDUol5nztZ6d/wilK6vSssHP6o4Rh71ltfyY=;
        b=YWjxYXcVAgTVoq0lxsQfKl2lzbOUZhGk2PNMEO6lPUjkRxmw12nL6aTE3Zj/a6dS7b
         Mo0HM9u3hKwrZNpben0gTlqbPpJNk5HeognAoZz1HRyOZQDJtFM5PWI+cQ4vWu60U/MT
         32bucqeSwBlwOIHQP8WyZAzczJ54KIUlYTwm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866959; x=1726471759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAga99RtDUol5nztZ6d/wilK6vSssHP6o4Rh71ltfyY=;
        b=hQSmksVjwVYT+RCCvQ0udbSb5atCPGRVrSi8vsITGCM1EQpz9c7sJxVa3tN9Z8b3e9
         kudkhnS4708YOWJvJ+L5RYgwJGAR4YMLAQDq67oDrjr/NasanA5fHb/NN/8h6208GMVS
         uG8yiEY/JIbsC24i8LGyLVWbE2iSt5JJnfj8zvSv57E941Ybse3LU4OYXEsVXBdPZDAd
         N5eqagAKPC44oBc2OiHjDZ3fW34mVL4xV4m4tckp8JA9bPuJ4jpmTaBT1FIjrWbJ36l2
         CzFubN/M+qqjuTFd2hjSDXMfRQHsCTkLqKj7QlgDnUrQNO8KmrKSpY5OMlZtfmSMU1G7
         FDgA==
X-Forwarded-Encrypted: i=1; AJvYcCVx9CWXayqLEynIo4TBzv72KcFTy89Ik3RYRy4W61PAxWn68B/qKwmmy/p9sH/mvcM1ihMEwPvZSTy9lLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywihvp20TD7Y0gK9hXj+Aw9UMCpM5C+wOmhC8doFMWgbst4dRxO
	V83WZqbzB18IoviCWd++kyk7WtnGWg8W+QQjxIUsm2RTOEGPft5Mo2D98q9ERg==
X-Google-Smtp-Source: AGHT+IFOFn7KFliMFXZhJS+1DjD3nGceHUQ+MLINIRmfOOKFMkSweXelfVQlmNIhzSyLnEOORZxjhw==
X-Received: by 2002:a17:90b:180e:b0:2c5:10a6:e989 with SMTP id 98e67ed59e1d1-2dad51182a5mr8700853a91.35.1725866959336;
        Mon, 09 Sep 2024 00:29:19 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c3c51sm3841065a91.21.2024.09.09.00.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:29:19 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 09 Sep 2024 07:29:06 +0000
Subject: [PATCH 4/4] arm64: dts: mt8183: Damu: add i2c2's
 i2c-scl-internal-delay-ns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-i2c-delay-v1-4-4b406617a5f5@chromium.org>
References: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
In-Reply-To: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
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
X-Mailer: b4 0.15-dev-7be4f

From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>

Add i2c2's i2c-scl-internal-delay-ns.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 0b45aee2e29953b6117b462034a00dff2596b9ff..65860b33c01fe832f3a4b2e21d24ea6b4f0cba2b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -30,3 +30,6 @@ &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_DAMU";
 };
 
+&i2c2 {
+	i2c-scl-internal-delay-ns = <20000>;
+};

-- 
2.46.0.469.g59c65b2a67-goog


