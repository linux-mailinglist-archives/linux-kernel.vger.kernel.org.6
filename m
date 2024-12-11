Return-Path: <linux-kernel+bounces-440918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A919EC66F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925EF281E09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3371D8E1D;
	Wed, 11 Dec 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dL2b2Vu+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163351D5CC1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904205; cv=none; b=o0x8Ds8fMNlfbaM7Vp5YzVELcxzD8GuN8ZPGSnw9uTqnAoiG8WOTXRkWHbzeiDIhnfe9a1lJGNwDU71ocLaF3J08DwPsSCgCOse2nb8o2fjDA9yBZYGIZt4ILUAqdooJ/C887Rf5i393nzzo/V2wKE9ZjeYWT59PRWS4rdapotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904205; c=relaxed/simple;
	bh=xNgp6TiJ0FeSJlamI0es9pE1KyaNL83wlO/q3q23SEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BiV9xIX48pEQQ9PyfURi5v332pbuIxEVtOd5O78g8ZT2ZcMnkreuSdn9er1qfZDnjkzdzrn4pMvSK28roKCC40Ten0o/kRBSwbjZTX5Q6Fyamzjc+nl5A3sRWJZeo4/QU16Q1vv9J/E1ozjYSr5QTupsvy8DYuOpti7R5f/eEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dL2b2Vu+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso1202755e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904202; x=1734509002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6XcwNZjAF5yMT6VAjG9hAZ73d3JBM4pTGdtgQ0bw5Y=;
        b=dL2b2Vu+43crvNVrTCR8XXMXOVc1KURAem8iH1mFgqd7007z5bsmATwA+N0CovOmFA
         G2IuwA0nPiM+8jM3iVNVdgKKp8+12Q1H1ojjHs6jNExyHl0agjxj8xBgfD8YD3RK08vs
         dFp0tw1a4KXAkhKGEbjs0ZPfua6nJNBhkc27NCip3NzOU+SKLbC+LmC47KWISyKBJvnq
         X6v+MuWT5IHFwY7jSUvoKCdZY766IRmWbx7xyektXosX/MOs08A5rsPHcm2ALBetM+Ct
         j8npt0B8pz0tNcFys8DE4+EY+eVGfvF+B2jW1xOooqBg3lIswfcaXbDFne3Z+0U95tQQ
         lb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904202; x=1734509002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6XcwNZjAF5yMT6VAjG9hAZ73d3JBM4pTGdtgQ0bw5Y=;
        b=DKJrROaHWxyd3heHcLtWn6klu37yuXm7hvUp1c+EvdWgU35LEk6kdxMRMnb+DEyRFx
         c9lnx3X1eDeikKqwDbi+IfqI5fvslOw1KIKHZoi4XGLsd1bGu92PWkh/tn+6/DB62wIW
         Xda55yvxKsSMh7qX6zxtWjTSVssKltTqZPBZ1dRRa9THR3f9aJcjEAHxGqMTMf6kWtr7
         UDzXnooNVsUXeuNi1yJeyuhJAaqcpgWK1oaQgm71Qa7uOmabzZc6/567QvZ3zWQebPif
         Dc0XYer89apHjvLIb5srkANRczajSDHu1M3YMLNt/6HfPXwNv1dEr78icFkfPrrazGRL
         nyDw==
X-Forwarded-Encrypted: i=1; AJvYcCUQAYpc+YzHe9crn5KS2CghqkvdQaModfJxiTPcqZOOU5rjRMVDie8VbIExOZr49Fr4QjHHtQR9sD40h2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvw7/ZcUPdhRhPrd5kU9EkahcveTEgSpHM7Ib3DUOB4Afd/mE
	+pVsDbC8fOCBLYRCbwueM6abwRT/pEHPpftAOEqjInli3o1/vIbAZetVSUL1OAY=
X-Gm-Gg: ASbGncsNJF1uGO+1fxhGBk5Ir9wWtm/yBjP0arIA/ajrosa91ewRpyOSR+x+02Py1o4
	vAjpf52WnKSH46ykwvQiUFHh9O83pnRWKgzlWYQldrM1XCyorJno+Bn+9PV+GE2C2Ssz0FDbTn8
	KmOIoQGjmOaBv9MstGYYORbCIyKgdBYjyNmNwLcGhqbgj4QvU8t5EFHMuYhb4bMajNxotR2Ucd6
	4bvlz/8cmA1RmASlCyRhgeyAc5E+Kd7XZ0UexpAjMLk42ABfCF1ljHHwC7fVt5jyBcB61oIiHY=
X-Google-Smtp-Source: AGHT+IEl0pmYaBjZWdMJv+HfY5SrfUbtxZi4Kqb+1i/s79onu04KhdgEYue6tnBszMprTRPPoG5mLQ==
X-Received: by 2002:a05:600c:4450:b0:434:f871:1bbc with SMTP id 5b1f17b1804b1-4361c35e4famr14808095e9.10.1733904202348;
        Wed, 11 Dec 2024 00:03:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm24205795e9.4.2024.12.11.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:03:21 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:03:11 +0100
Subject: [PATCH v3 3/6] arm64: dts: qcom: sc7180-trogdor-quackingstick: add
 missing avee-supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-misc-dt-fixes-v3-3-010ac10529b1@linaro.org>
References: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
In-Reply-To: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Felipe Balbi <felipe.balbi@microsoft.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xNgp6TiJ0FeSJlamI0es9pE1KyaNL83wlO/q3q23SEk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUdDEO0FeMPsgcYg9FYMhI5BrrT9Ozg/5hqypiku
 hUe1L/mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lHQwAKCRB33NvayMhJ0aLlEA
 C/GfzMfG4/xtx8G6tjmfw2fXfqv1tyQV2lRloHaz3dKboAGjEKJ/EiTQpoB7uwddUzy+mRlDTlNqBm
 uOzvYw2ZOY4qvT4WCOMMHMoG9RI4tLQhOPvTUfhEDviqMwgx8F57qbhq9Ni98dai4idhwMC6IMbFDJ
 nUNhWPHDerBX5lwArLsV9kMLLezuVNd4Ezjm7oYmYCGCwbn2pXGcvCkV1dRzAZPQQ8DHsqjvkN2ZF6
 lqLiTABrPzeFwXr2qVB0CXMuwelGk0zrFkqck8MsdL0f0/WhV49L7duRN2up9ETlpLSsG5uHYlkAZn
 Pyrgo4TrZPGOzaENqOnv3zyuiMGigyQKcC/X55rauY5rOxdHsx4zSJCF36hs74VBA/eaI1+2BQoJ4d
 9h4R7+SQvH2SU09ZLO5DLUkWgnIfzVM1fSw+jXgxua2hnfBDBFhCC2NS5J8OenEqV9VzFGpp+UJDVI
 +nbZWHnRnlpKVVo/UqJr/T3UKh0dCg7zmjcRGLlFAg1mjlyo/v5oDzirlsN1Et49VRlr6QGa6sVYUp
 P1W+g126hLnJAJYgBeHVs9VXP84aO14RiXjfgWa+LTOY3vLxTlYRPD3F4+Tl0yuCWqrqN6zfeM1Xf+
 dC/mZWbrGNqMzJ8St+AK+UO8O2GPSyoCTys7vd9+KOal1B2nh5CNohQbfGCg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The bindings requires the avee-supply, use the same regulator as
the avdd (positive voltage) which would also provide the negative
voltage by definition.

The fixes:
sc7180-trogdor-quackingstick-r0.dts: panel@0: 'avee-supply' is a required property
	from schema $id: http://devicetree.org/schemas/display/panel/boe,tv101wum-nl6.yaml#

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 00229b1515e60505f15fd58c6e7f16dcbf9c661b..ff8996b4de4e1e66a0f2aac0180233640602caf3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -78,6 +78,7 @@ panel: panel@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_rst>;
 		avdd-supply = <&ppvar_lcd>;
+		avee-supply = <&ppvar_lcd>;
 		pp1800-supply = <&v1p8_disp>;
 		pp3300-supply = <&pp3300_dx_edp>;
 		backlight = <&backlight>;

-- 
2.34.1


