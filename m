Return-Path: <linux-kernel+bounces-179782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AEA8C653D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E5F1C21919
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACE5EE8D;
	Wed, 15 May 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd3h8nt0"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCB6D1B2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770515; cv=none; b=s6UNNa1skMzNREEB4rwHqUO1epEax+69/SB7ohoI29cZ8vCP9QSzhLEIJa7TWLV64H2OdW8lD17AOPI+hSALfJAAPSHG8FVHZXtqSdfRHalIOy5bCa5Z2++r7xD9mydXKj2u8A65W0f/eGCfI5N/PtZKYXYHUdW6d9kwumCV20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770515; c=relaxed/simple;
	bh=QbcBc4JXtP8FNrsiFhXtIJGTYDJA6oPqiQ8+qe0RZWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQjzDW7QlXxJcRf7YM4L9Fl7n6AXqb60XLONLE7Q0dDEXVI0ta9xB3jtMVIjEa1l8OrCw7aw8yRcuIjU132e8o1Js9vYk9qmJNf9BtZdI8zCZu8rGn3eqgY51GgV4gdvNKoYZsEVtULH7GX2TrxJ/wUYWigHoC6XI3f83s/ONc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jd3h8nt0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee0132a6f3so51267915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715770513; x=1716375313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=jd3h8nt0XppmrXScJAhUdLiukYGTQ43d7P2W23c7ofo5Cc1R70eopZI3kB0ogVx8Fa
         xMV9w179pW7o9zKpwOjQyM0W80HEZKIl52UZkZjK70bXgDy/bGG9vyZJyhD2n9HD1IU8
         3cfzXYISQ/4b9gvUThWyewa66Cmv71FCxbj5Lf62RQRpy/U3wWdWZRSAu2aQbuse6UVT
         UK7sT9N3UJ/E8U99ZoLIbY2S2DEIdHSB8lGAu21lZYmgsgvwbchKnXORf4+dZqJDRxRH
         oxMMCtYKhDlxJJuIEa9Zc0W+tR706gq4Q+3IX4tRCQYj43APVaqjNHVlnrvFFn1S4epu
         felg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715770513; x=1716375313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=ZN4PfmpzmFi83wozpbwA0NdjLl0t7AGi3IWv4VWPGiseO/jZsf2e5HAo36USro9ZiI
         jTAPIQXBLfHWTbTpg0xU/cy8hwlpkLpdEqvc2/Nd2dmywkV9EK2Bho6BCjK+3Ipssfwq
         l0JwHDiE6IWIXTi1Oa0eyApUiXwz4sbHfaFgSBy9A0QJHIOHo6bH0lZiYISnomQxugjq
         kHWGiaND9kiEPk4ctHcemJc/7dlYDEypr7hSLHpGtUShrqAj2L8XWeORHO7AVKcAQ3tS
         kQGruE/lOvIoJXxDAJJu3Ezv5xLWXW+iZ7XRcVNXVnfWHeGdbHfsEJu/aHqjaW5uH55/
         Qutw==
X-Forwarded-Encrypted: i=1; AJvYcCW6EiMzTteEfNJ6S9Ab3kajDSe91ECUTDeYqM6mAKeija6+7weAweuv0iu80NjMtu2u/sPwuDn3TvUCtTRvMzj/g5o27JJtMjHo70Yo
X-Gm-Message-State: AOJu0YzlSJn0/IntsTPrcfAEyH9+GZDYvRdxhWT9+BWGmw6pJyXd5r+Q
	JQh7IXDjYhYmG1J0MpUMSiaMQEEQXqNloLsfuAGbnZgSbC9axObd/kP5kxlr70U=
X-Google-Smtp-Source: AGHT+IH3mNU35IB47PehPnXri4pYDWkVZdgckxVixxq7JW6/3gVm5MMHnWavXQkmo22cC7342rvq3w==
X-Received: by 2002:a17:902:ec85:b0:1e4:b1eb:7dee with SMTP id d9443c01a7336-1ef43f4d05amr182739515ad.47.1715770512933;
        Wed, 15 May 2024 03:55:12 -0700 (PDT)
Received: from sumit-X1.. ([223.178.209.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30bb9sm115092425ad.135.2024.05.15.03.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:55:12 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v5 2/3] dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
Date: Wed, 15 May 2024 16:24:45 +0530
Message-Id: <20240515105446.3944629-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515105446.3944629-1-sumit.garg@linaro.org>
References: <20240515105446.3944629-1-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the Schneider Electric HMIBSC IIoT edge box
core board based on the Qualcomm APQ8016E SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..c8c91754fe04 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -137,6 +137,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8016-sbc
+              - schneider,apq8016-hmibsc
           - const: qcom,apq8016
 
       - items:
-- 
2.34.1


