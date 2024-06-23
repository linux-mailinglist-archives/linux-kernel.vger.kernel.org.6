Return-Path: <linux-kernel+bounces-226396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F8913DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADD41F21DD5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4DD18508D;
	Sun, 23 Jun 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfsM3j57"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B618412E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719171271; cv=none; b=Qzt9nEW7DpK9/lkwo0mIuM8VxZufJ8n8z+uSWPO7zF1Sw9Oh6ElKWL5MJHCgq9V1kyyA+FXqa5VQvQjzBRL9J3V8bfoI30eFmGlFFHwhsFc9No9/Q8Qm90Bso0T9/+hO4WCBKPC8+2qCYDPtxkehU/9v50Ywnme3KYaq2F52Vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719171271; c=relaxed/simple;
	bh=Tbmq0IFLnKr0bANjE49Gic1OtLpkRgBbXr/3ROpVyLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPwEzcsruHxIp6jKJTqH2EfT16UTX2+NrvG9va/O5P+WVt7dzKFZN44hG4HuGe2FRZh3dxG4GGMobKSxAnxcZuB+jcU9YovclNsnGp6snvNffsJaoPvRp/cecjY0WZkfLhknQh/anNS3FFvBRUvJMwWwuLOw4LbxCOct1Bw0z88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tfsM3j57; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdea1387eso1291572e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719171267; x=1719776067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDaFCIv9yP8iEYUX+Yf8rcMTPFjNoAdph08aEYT9HUg=;
        b=tfsM3j57KmLunAvOAye2e/9SdfYh4BRNTtCcZZ6BgBlVWcN9vvjgnkmw/EPsrj25QL
         KjlwWTOaG1aRzMHjDeE/3bbzNxlj5wImtV7mjv//jPefHCEIq+BYTo9Dcyn4JhBLq90Y
         88q44OGAIA9EDaYhUBPzvknutn+H8GP3JHAA19oZ9GlRh4R/sFxaOlgIpxRNHImC/odv
         5R81tdMbvJLzBZKNZ2idLFb9PODFb4pq5qtenoNQMEajdirqGBAwVNVlsKBNyEENTDbY
         L6q4TSRt/6xTD9NR24vCSw1/yX3oGcCCoiTZL3Ri6XQGu/qtwPXdHyoLNk8anKu2aPy/
         od9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719171267; x=1719776067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDaFCIv9yP8iEYUX+Yf8rcMTPFjNoAdph08aEYT9HUg=;
        b=u69Tckp/znmv1J3BtmEBjfGG69NF6isjC99qcDbupCkG/i4V843Ju0xFU8aBgsdVl0
         LEwF85FFY65E5vFPcDrCO9q5IRk+4/2aVRaC2kzhgtCcYEsCTGD6gjX05c7uemvbfTb0
         MIDpTVTgChq91BYAb66BkMtPP7iB+5pQEi4TyYCmFuptCY82cV1Igu3dV+3WdnFkMbdK
         CNBEXfeuZM+bay/2eCctRRWRsK1PV1EBWE0JFsFE50EjnyGlNr8wtgtQgvgryyWcGDlP
         8u0Lb1hDN2H63WoqyY4Lw6XiSu4NdHo9/cwebj99Niz6ttCVAT7z3G28iR/SZtrvzeBP
         CLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAlQ3mB1mAGp8g+GldyPTy++YidQOsAVhJdN7AmuqbBlQ2nSu4ZzJPj4ssgXng9g8JsBcEADoMuovsilnNz5Oooxpsp4Mi8H8/djmn
X-Gm-Message-State: AOJu0Yxg3Qb3hCcZYvO5Cte2gDI9Gqq/yfz6JKZZHruEFvne6a1eKf3X
	kEZ87/SAVQ0uY6lmnnr9Ru+sKruKqAVyNBY+JRmqQIcnK5fEjYn+0bbJIAkxoSI=
X-Google-Smtp-Source: AGHT+IFiF4v5vQQ8+INAB3JrDali3WgslfxwWLouELwfpZN6txtwJoppt3sxXUoF77ksqCi2N31WFw==
X-Received: by 2002:a05:6512:1151:b0:52c:e6e8:7a91 with SMTP id 2adb3069b0e04-52ce6e87b8fmr457502e87.4.1719171266809;
        Sun, 23 Jun 2024 12:34:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d1fdsm114756015e9.7.2024.06.23.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 12:34:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8150-mtp: drop incorrect amd,imageon
Date: Sun, 23 Jun 2024 21:34:20 +0200
Message-ID: <20240623193420.333735-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623193420.333735-1-krzysztof.kozlowski@linaro.org>
References: <20240623193420.333735-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SM8150 MTP board does not have magically different GPU than the
SM8150, so it cannot use amd,imageon compatible, also pointed by
dtbs_check:

  sm8150-mtp.dtb: gpu@2c00000: compatible: 'oneOf' conditional failed, one must be fixed:
    ['qcom,adreno-640.1', 'qcom,adreno', 'amd,imageon'] is too long
    'qcom,adreno-640.1' does not match '^qcom,adreno-[0-9a-f]{8}$'
    'qcom,adreno-640.1' does not match '^amd,imageon-200\\.[0-1]$'
    'amd,imageon' was expected

The incorrect amd,imageon compatible was added in commit f30ac26def18
("arm64: dts: qcom: add sm8150 GPU nodes") to the SM8150 and later moved
to the SM8150 MTP board in commit 1642ab96efa4 ("arm64: dts: qcom:
sm8150: Don't start Adreno in headless mode") with an intention to allow
headless mode.  This should be solved via proper driver quirks, not fake
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This change depends on previous driver support, unless we do not care
because MTP is a development platform, not a product.
---
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 286350ac7751..256a1ba94945 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -355,11 +355,6 @@ &gmu {
 };
 
 &gpu {
-	/*
-	 * NOTE: "amd,imageon" makes Adreno start in headless mode, remove it
-	 * after display support is added on this board.
-	 */
-	compatible = "qcom,adreno-640.1", "qcom,adreno", "amd,imageon";
 	status = "okay";
 };
 
-- 
2.43.0


