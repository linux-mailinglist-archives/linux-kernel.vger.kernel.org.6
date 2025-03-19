Return-Path: <linux-kernel+bounces-567561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4AA687C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38CA16FD43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70781253B69;
	Wed, 19 Mar 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fqvb9XcT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63867252915
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375877; cv=none; b=tchY2jK5W3TRlsYYuCxO69KO2OFWWtfjgs6i4khV4QOB2mOESW6AEjhVQDJXrGAmujGeSWrSP45SVdZgOdXXl/PaPecZIecFkblAwuqPkcPyxwdIg4ekgsWhULT1OY4Wr9kv4CM6Zct1ChD3tbrD2ltc3s3/mYlO76B4uJYkXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375877; c=relaxed/simple;
	bh=G/PQgzYwrYLYsv/3Tx21aVxfqG3KRo86XzpWAbXD6Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ardAuXeUP6JRDBaQ0+o9+O9Wr7YRKHHAl2gWilp70hnzXmTzwptC+ALxPZcEe2rAgbLgpJB0A/xd/MuW0o0c3pfDMG/Hi6TQJr/wOU3JFAR4nrm9BW3iIp5DPSfQXjASqBf/IvHptnnqyc2p328a7dZg+NBrCQuzZytwE7kCeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fqvb9XcT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so4242077f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742375874; x=1742980674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MatIsPF8IuzJGTj4rqzD5SEaynR7KV/+RlpqBdYnhsQ=;
        b=Fqvb9XcTfRzkbiNj7uB2sd1ZrN6eRfgSSOON3qcypf101Ons81bD8YEM8P7fFkJ+vv
         Dr/inQ4V6bcHc/bSBZ84L6lDcyYqdv7jXDQ4VNN2Unn/YQpaOEmATo+DBH9+RNPFz8bU
         ZteylGpRguI1b/1xiBL12YoM5SIOaRL51uVqkLKvjpeaAdK6aRnb7rHBQ6LsNUHAooAs
         PQHmecUOutNRbF4Z9SPLBbhnCSvp1NT2KXA4ob7emNTSb45kvhdkasbKok0PDU6Djk5G
         Svb52qxVJf2rjyXt/kCqdz8amF6Bq5k9EqrUBhxUFH6k9OEIHy/nE79/Vd50GqyvBp4e
         MYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375874; x=1742980674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MatIsPF8IuzJGTj4rqzD5SEaynR7KV/+RlpqBdYnhsQ=;
        b=PJrwCRD1GF3iAZ7LBNzT/XSqTwEfPIoB2ytwRt54DdLab0InikfuEWpiGCpx4Atg0s
         RgvnDiQNdLiLUHPzG7+IznuYlCJmOISxE3GyZRAwS8VZj6XHzAmDgFUbh14iPflTfTi6
         cNjMtl6sa7L1G6P+QRo0ZQK66eJTO6kiCwZGp3hoPdA3JDElzQvbfTHRIJH3N/zZcMuP
         SIK/udSYjIZm7nyR2YHk/rsYZ2Tdlyz4uAsXRuOThI5Zlr2CgxpQDeUmAuVNChKAf3GZ
         uTaWAS6WnoI7VaHDTtzcRaxppZcR1owSVwRkzCiNCftJyhUiWqxkEVuILBokI5sfNt4t
         ltbg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Mhm66Qox0qGqmOy1ygBMEIdynvlQN6u9O2dxoNW3uBv1ILoBE8KOkkDtQQQaoRjeFJsxIN3jIy5ttik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmWz373VqT0Lqjts0lEivqQV9IAz/Vc3gL+SokEACedZZYSm4
	H72YWEJW/iIGwEWrQb4IpJapRCWmcSRL9zm2Jz5coR0V1LgJlDZ2rSSHDJZnJyY=
X-Gm-Gg: ASbGncs37fmcbNMy9yCA+hF9lEEuz+I6l96lnFXGoTk86pxPC0q5fWxFuSSv7csQy+R
	YIOwuFFlvxiF0Z/0IFoa5RzYRMuPuxV4Uk7Wml2CUWDE3Ss5QmZDfJIaudnnlAdw0sS+uVAYuW6
	ewjrY9jGNsB1dX+iS/HXOrZtFM2CrKF9TZJgpe/O2wBAjUD11LZ+RcTb1pXwmGk+sYHRvkOlgfx
	kEKCPq33U/iAXQDPXj/IXLQfHeNcWfC2DAFqpLrymRSKQLC5bjh2phFHnRi/D8H4ZA89rQP/v/n
	VEVSUuXd3M7TNypH1AihnZFAt0OsR7pCEvNkINhnPPc1NRd/EbAYr91gPxS0GDef+XYVIQ==
X-Google-Smtp-Source: AGHT+IF2OI4R8vpQRvrvPUiz9MYuf6mjmby8aJEe+xnR6Wn2dDxTXW6xtohznPik5sEd2lnjFnvXNQ==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1231112f8f.36.1742375873640;
        Wed, 19 Mar 2025 02:17:53 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm20023810f8f.23.2025.03.19.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:17:52 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org,
	andersson@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: x1e78100-t14s: Enable audio headset support
Date: Wed, 19 Mar 2025 09:16:37 +0000
Message-Id: <20250319091637.4505-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
References: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Lenovo ThinkPad T14s, the headset is connected via a HiFi Switch to
support CTIA and OMTP headsets. This switch is used to minimise pop and
click during headset type switching.

Enable the regulator required to power this switch along with wiring up
gpio that control the headset switching.

Without this, headset audio will be very noisy and might see headset
detection errors.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index b2c2347f54fa..f39c51c809e8 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -22,7 +22,7 @@ / {
 	wcd938x: audio-codec {
 		compatible = "qcom,wcd9385-codec";
 
-		pinctrl-0 = <&wcd_default>;
+		pinctrl-0 = <&wcd_default>, <&us_euro_hs_sel>;
 		pinctrl-names = "default";
 
 		qcom,micbias1-microvolt = <1800000>;
@@ -36,11 +36,13 @@ wcd938x: audio-codec {
 		qcom,tx-device = <&wcd_tx>;
 
 		reset-gpios = <&tlmm 191 GPIO_ACTIVE_LOW>;
+		us-euro-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
 
 		vdd-buck-supply = <&vreg_l15b_1p8>;
 		vdd-rxtx-supply = <&vreg_l15b_1p8>;
 		vdd-io-supply = <&vreg_l15b_1p8>;
 		vdd-mic-bias-supply = <&vreg_bob1>;
+		vdd-hp-switch-supply = <&vreg_l16b_2p5>;
 
 		#sound-dai-cells = <1>;
 	};
@@ -367,6 +369,13 @@ vreg_l15b_1p8: ldo15 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l16b_2p5: ldo16 {
+			regulator-name = "vreg_l6b_2p5";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l17b_2p5: ldo17 {
 			regulator-name = "vreg_l17b_2p5";
 			regulator-min-microvolt = <2504000>;
@@ -942,6 +951,13 @@ int-n-pins {
 		};
 	};
 
+	us_euro_hs_sel: us-euro-hs-sel-state {
+		pins = "gpio68";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
 	kybd_default: kybd-default-state {
 		pins = "gpio67";
 		function = "gpio";
-- 
2.39.5


