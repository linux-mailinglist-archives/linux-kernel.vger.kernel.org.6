Return-Path: <linux-kernel+bounces-317018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D426D96D852
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9315128C21F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190119EED3;
	Thu,  5 Sep 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vq6DTIoj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B519D8BF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538840; cv=none; b=FOuVHDyII3IEHWm1o/eePj1zvCfk1kBJxVSTmaWV4dArXoKuUwHeEjsj0vNjMzblMGlOmzoXALiA+gzLx3lp+Mu80Gyuzo0BPgWfNQkOfFeqco0V2KpI9MD/3ZmrJpRN9cXuLLa1otgF2MMEliKgbZmHN3wi7+f4fEejUMwqlxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538840; c=relaxed/simple;
	bh=d6WJddhun4HJvMbLm+fmJ2JZlxp0djfpfRlepqwkzwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjdtULyakND7+xDVfAcG+DZ6Pqgg1pkIp1AY6eMJAtVREgpghgFr7d/bC5NEEF3DPv9whjKhkT/bKFLAbIlbT+7Pm48ElYlJXOmfYLL6DM9vJSHK4e9K0kJt2jjviV/rOJeBMLB4Kuj7JqQYiPFp/j+V7XcFzqkWUTW8QDoDv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vq6DTIoj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so6402135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725538836; x=1726143636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUTBDQ3R7lg9yjFQy51ucEUiL1cminpTXLLq8RTN/Q8=;
        b=Vq6DTIoj6sqd6/PQ3+CxcElIFUceGY8F2+08d/BPW/XeOnvU8c0nHbJr8zRFiao6X3
         t8WGCAhCRd3glVvBkMlMQRmOtR4/m3R95EtFN3g4arWb6F0oes/m0GYTpXYX0DZMav/K
         rokwDnRJmC3pfXccWu0lgOp+x2JQZCQ/JHrXAc6TvIfOpcC7nxmAEMSb2fpweIPNOIfk
         ENa0vg83d7v37S9t4zEZSdWMKaZE1zCKm173sKoDySrzFCyEmYVzU288+znYRTYmCYCi
         Ag1D6VLv2plPQMXwib++3ENVuH7emR1gpvJNuaqz115wuTVTBlSiun3F+xr2KxcajGEX
         4lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538836; x=1726143636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUTBDQ3R7lg9yjFQy51ucEUiL1cminpTXLLq8RTN/Q8=;
        b=iE5OCd0heOaaoD7ajpjiK5UKti//6/+1cHRBVjTD58S/C8uQFgihzwqJ/dOZzt2w+t
         O7xa2Bt2F0iIYJ0OAxy23/6DPYnbmpL9ZT8beHDULVQJsz7LLwbUS860wT7HKmwMlN8O
         dLdo02tToKAuchikra3ZBY9YdOS3aaHR7mYjYIDpMDQMqOlcRnU1wwJ635GVWwy00mWO
         nAv5Fcw8OgeuIahVb7YAf5jy8v0tOH0AoxkcIhlDaHgBQ8glOwWWNpAP+zFQyP9uk2sz
         dsyUGGqhxMVjffjQXEnV3oiPVVdtq6msrjW2G1xghIem5OpcQ4FW6LmMHZLqs0dAqXEv
         6nag==
X-Forwarded-Encrypted: i=1; AJvYcCXrE/PvbEl2VjAKo8UfzS4782+/2jJBdd54DYeTI8zXcP/wSn6h+RI6Ww5Skz13grTq6+wF44a+iU/3P7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNebzA5licWt6/rDDplc/p2hTlCo9HgiMcvaxTIaRRXjkHY/8
	qd2cbtbnGvci31C/hKzyH1ifZWr+ncrBkKzs9SjsVgZiBHf+h9pU0OSI7s+uKx8=
X-Google-Smtp-Source: AGHT+IGSQzjFcSPvZhlrrAcUSpzThCnyg1YJpIfCV1RMXMl3ZVM0P7DXFNMe1faorV31A2qjyVpodA==
X-Received: by 2002:a5d:4b81:0:b0:374:c2e9:28b8 with SMTP id ffacd0b85a97d-374ecc8f2bamr6939773f8f.18.1725538836244;
        Thu, 05 Sep 2024 05:20:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:cbe4:ce99:cb33:eb1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374be2edf08sm14645764f8f.6.2024.09.05.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sc8280xp-x13s: keep less regulators always-on
Date: Thu,  5 Sep 2024 14:20:22 +0200
Message-ID: <20240905122023.47251-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905122023.47251-1-brgl@bgdev.pl>
References: <20240905122023.47251-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove the regulator-always-on property from the ones that used to be
implicitly needed by the on-board WCN6855 now that its PMU is modeled in
device-tree.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 88b31550f9df..1a9dac16c952 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -479,7 +479,6 @@ vreg_s10b: smps10 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-always-on;
 		};
 
 		vreg_s11b: smps11 {
@@ -487,7 +486,6 @@ vreg_s11b: smps11 {
 			regulator-min-microvolt = <1272000>;
 			regulator-max-microvolt = <1272000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-always-on;
 		};
 
 		vreg_s12b: smps12 {
@@ -495,7 +493,6 @@ vreg_s12b: smps12 {
 			regulator-min-microvolt = <984000>;
 			regulator-max-microvolt = <984000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-always-on;
 		};
 
 		vreg_l1b: ldo1 {
@@ -545,7 +542,6 @@ vreg_s1c: smps1 {
 			regulator-min-microvolt = <1880000>;
 			regulator-max-microvolt = <1900000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-always-on;
 		};
 
 		vreg_l1c: ldo1 {
-- 
2.43.0


