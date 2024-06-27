Return-Path: <linux-kernel+bounces-232497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3381691A9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05381F25539
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABDC197A69;
	Thu, 27 Jun 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynzFP2RS"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0150199E98
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499500; cv=none; b=aUja8hk/RovHW60Bhfcvl1V6d4JugGjaiXPutl2JWGWWXL0MyvxiroZwYHW8Kutnb5Kbau/dD1GXI5H3tXrpaD5DcbLtJB4Bn34thzmkXmwQjBCY4JKLwzGm2+IoGs5b0pKUC0fDkRxPMnvhcOQzEbtmWoqmS44+BSoHx1WvEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499500; c=relaxed/simple;
	bh=2R23639fkPX8iIC+qUMimWznPuF4ISsfAKV3cLgsdsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzxsyFWgbZgbs8DHskT+MdHPIES5m45Tu/m7bf1b/JNZ18RzzaLYwskkLzWtgtpS9GTDBhHIaeyyfrq9LQBVvOP1lHAagT0KU6MwDcVVil3FRQgY6dTMw7l8+GQHaEC59KAdvSUKVgMM34FuUXFlreA+Y2WCJ6PDT20avY029MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynzFP2RS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424ad289949so18443855e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499495; x=1720104295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/2h0WxI0Gkdc2KmSebeNCSc6/7iWl3nnZ9U6r19RMI=;
        b=ynzFP2RSh/yIyHy6rfzKm/8U+LQA6fxd8eN8hCo5QlREfyOrrSjH6u6q++PfPbXa/n
         OmDIsVRTm75ZtrggwZX5einqOt7uaNGo0JbWzGAaGmbwdslIYfPXwmh3uc9hfdOl8gO2
         9mGDos0RPpSyd4tRv+9CX0OvRAxalE1chtAcuLxgAwrD7ogrDj7tqzizWbtZYdpFDqjs
         dg6UIAcOcC1WhTcnQHiX/b8bVF/E0fGOO/8d+8dWqDRRMBPJF0z43VgaPedCLjvJOuHl
         /3yJUpyOtTD22wUy5uIDV75gY5LaTZ6gnP55FLx8U49ncYQubI2+hzis8QGl4Bn/jAMO
         ocSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499495; x=1720104295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/2h0WxI0Gkdc2KmSebeNCSc6/7iWl3nnZ9U6r19RMI=;
        b=oV4C5P0AnAM0ovvObHp2yVXkbkO9ubpFzR2rWCW7R4AM1sFQ58tJgAu4hXIvpC0WkW
         +elkg27ayiAjFFL/k9usJCV/FuGlHlCeoLu/MrXlQRTRkstfxzSG7UpUirIDfMBfSb5H
         UOpHSmCA+s4dkziy2AI51l/3dhVy+jOsapnKoA52u4oWSUYxHL8FXDWH0IRfCz6+EQAx
         E/n4zgaKsJIr6xk6M0Ho1BUk5he5CS27EiWuZ0lA2HhV6rfQq3vKIzTKfLW4XeEUJaSi
         Z3FMdXNSK8U2JjI3CEIXgW9XC10q9t0emctFb7QdNUsMaLdkajYQj3vmcBhnBSd08tP0
         8JWg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Qu6XyOWTKkEQHq+OIwgGIuZMJD/xFwx+W5x3iItlEH2LycRbAswtrZJwzxwEeDxbXBgelbNSyboG9m1XMUhfKNxEnw09PrvGypOd
X-Gm-Message-State: AOJu0Ywie2v/4aU19c3fWndJDcYdPnssHS6VYSo6keqoD1tZeFTai04g
	tPziDqRD5DvY9Owp9b5dP0IdPnmOOdpvU0vimD2qfHGscw+nmqoY95EWpwgnnKk=
X-Google-Smtp-Source: AGHT+IFGt4B0RZSOZNczxSiz5zFHWD1XhA8KV6rhtB/C6YEJbwb2mVelgfDCWMl8+kBFTiWhCuIkDA==
X-Received: by 2002:a05:600c:6a18:b0:425:6327:f00c with SMTP id 5b1f17b1804b1-4256327f189mr21483385e9.22.1719499495427;
        Thu, 27 Jun 2024 07:44:55 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b7b7c1sm31254075e9.23.2024.06.27.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:54 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 27 Jun 2024 15:44:43 +0100
Subject: [PATCH v2 6/6] arm64: dts: x1e80100-qcp: fix wsa soundwire port
 mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-port-map-v2-6-6cc1c5608cdd@linaro.org>
References: <20240626-port-map-v2-0-6cc1c5608cdd@linaro.org>
In-Reply-To: <20240626-port-map-v2-0-6cc1c5608cdd@linaro.org>
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=2R23639fkPX8iIC+qUMimWznPuF4ISsfAKV3cLgsdsU=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfXrYZXcaDPDTEMgAamcZ9w/ZPoMFkd898cvKx
 t8+dolO7NCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn162AAKCRB6of1ZxzRV
 N9HKB/9z1cCqL0paPtQ+5UMxA9t4wauT0ugB80R2gRNhFexPvqGNB2MHSChO53+qU2/XXbq8Q0L
 W7ruCUqhn1IS7jj2n6siZMkx+2OxEFJ6KwxScKy+yo1PcvwyWpO3ec22X3VS7nAVY6fIpgBG1Ca
 sCiOlFaarg92iccVZeS9vLmadcKCG0YUAXPWgavGusQi6D1Rf/m0B/BbMYWeVAjK0JhOJsHgv3a
 6rwmbuJH+qOgRilQHW9vSzrD7q/ikcKWzLU2lfZ6xAS13MfU68UAgUiogzyA052dyuC49gooiJK
 tdm8ufp2wsZAT0gAWpxyeWBcEi2ZgbKUqdAUw+4aw3FFDjx8
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

Existing way of allocating ports dynamically is linear starting from 1 to
MAX_PORTS. This will not work for x1e80100 as the master ports are
are not mapped in the same order.

Without this fix only one speaker in a pair of speakers will function.

After this fix along with WSA codec changes both the speakers starts
working.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 4edec3212dde..79563ae34890 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -749,6 +749,7 @@ left_spkr: speaker@0,0 {
 		sound-name-prefix = "SpkrLeft";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
 		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <1 2 3 7 10 13>;
 	};
 
 	/* WSA8845, Right Speaker */
@@ -760,6 +761,7 @@ right_spkr: speaker@0,1 {
 		sound-name-prefix = "SpkrRight";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
 		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <4 5 6 7 11 13>;
 	};
 };
 

-- 
2.25.1


