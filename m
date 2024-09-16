Return-Path: <linux-kernel+bounces-330321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E99979C89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59608284BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F514B06A;
	Mon, 16 Sep 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svopEmIU"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DB13CFA1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474135; cv=none; b=DFBMCUVosEotFRI1u81fv3wobvYuyih9OqBU7AIh2OZ9U9gvHe/SalqMyUeCtcgwczEurnH/DiCO0kHPrVO+ayGCgVpCINc3mmBPzz7bwYw7m0+pzgj+FVPgAaZO68zLsw09UqLQ7Ee2NLp/7HVa1mH0sFBjLogfYxapFyaLEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474135; c=relaxed/simple;
	bh=cmbD9RSCCT9wTN38rVK/Aa33OtoBLzkdzuJ7yqROYWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ug+JUyCVo99bTAykG+I2O1al0gQxmOqKL9WTcYc0fHssYG6DbkJOTtNCK0Cw5QCJS0g6SWLXzqiRSAaX7Wniy81DsuTHsNOykJLfO2/1alkZA1RwchznVD+lV7c/drSbT2rOy8K1/q2SCrs5FUpu0dzPOHuGTb2Og6rdqtieigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=svopEmIU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so41043115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474132; x=1727078932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQC0+5hP/1T0Fgc+KCuQoHaqJvJj0T+EzK9HCAfjIY0=;
        b=svopEmIUkfLmwfp/Mw0MFGfs7RIwl4PLDou+HpoBO9GV2l2hjWL2WZ1Fzrvv49wLKP
         jzbpdKT05WQXIyKfeJK0flIf8ajpJHNNHHjdNl8TDW5YM2yCMAPW5K13xiS+towJ6a5p
         HY02D/qD0kaclLiiuJgoYH+OYF/1wFrtLUYWqxT/Er7/V3wN4vTHI22FcMNoOiMkmxs0
         D9sB+dF9DCfLYG9tRHXbm8mYOvjrsi7sVR6eNEXCUy341mX6B+OGioFjA9xVdkSc+ET3
         RnVuVtDsNQ+1/HclaTGTTukcg9m3s667NYa1DgFU9stXt74QAT6K1ou90JpPxo4qOl9A
         dEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474132; x=1727078932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQC0+5hP/1T0Fgc+KCuQoHaqJvJj0T+EzK9HCAfjIY0=;
        b=OzJS7WHb5DEtQn85pGXWmbfsFXTsNEeNmjGeJ/9jUuFFDl03iqHDUxZqDd41wdfahV
         sjuACmQ92UVzGHy3bc9iG5tBvYu8McCRPoGVAE5BZ6/2VNvdltl4qDE36sifjXOHo5ev
         o3ELD7/cK2VMYnYV/OLL1ZI5TR0IPQj93AvZ5BAYgZZSLLpH9uWlK3F+IiJAege+dr6X
         3VBgBakrw3xFE4+qXCL15jZe4DWt7vWclwhKAzPjYxK5c15aesf8D/yCmMy1f264eZJ5
         3djfKBkMjsSFYTWEdzs9zC+wc3nDsFDFNDXClRM/9bqMZjONRqAYEWXYU38aTFx5dvOR
         gRFw==
X-Forwarded-Encrypted: i=1; AJvYcCWbYIzE2aUdnuckkz6QwvjQEIGR3OInr9nyX65MeiuOBbzo5yvVWUTxHz40ZqZxz6QPH0d9VvwyG5nyT6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuNLk5qeTQUcQ1BVkXMjmEHN3hWcB0C72OU+/8aMfqPjyjvX/
	yqH5bX+Vc2wKhiZQrmofHZoshIcO32D7DZMxIBBBk3NId/3l3HyAqTbr4IlwkZV1RNvKGrUHs8n
	c
X-Google-Smtp-Source: AGHT+IHAmdE+C4Ny+gNfup365f+6zmP5ZLzRemJ0I5Wbbn+DfBKRgM9tmGdVnB3sx1dgY2Lw9+gcBw==
X-Received: by 2002:a05:600c:5127:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-42cdb5790c1mr112391575e9.29.1726474131902;
        Mon, 16 Sep 2024 01:08:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 10:08:39 +0200
Subject: [PATCH v2 10/11] ARM: dts: amlogic: meson8b-ec100: add missing
 clocks property in sound card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-10-0b20ed4f0571@linaro.org>
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cmbD9RSCCT9wTN38rVK/Aa33OtoBLzkdzuJ7yqROYWU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eI8cW+bUfdg4DZyNafDYP2+CdVzJJzD9efY4Xx
 j6Ng3TSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufniAAKCRB33NvayMhJ0YkdEA
 C+VZKbrOGWoZzSPCpesvMurV9hC5A7d/5PqGNfZYgJ2Xp1zaLi6ydQP5JVi3J/MFQ3luSCzFMPE+pa
 hdCiRMNAzGczpIdpmmNiChVdyLbnipVh2dqfRyaRLeJRMCIqI/O4x6w+9MLwKDYfrMxJKqUjY9EzXg
 Ik7gRPNBFwiTfmjhIMeqkQAmYgDh75L/IVZ1u5VjbRdWk/3GPEl4A7sCdUS+amOWRpCuazP8DtNSJ3
 kPDCeQxJuPSvi/mR0KpBlQNamQi33N6sdyF+AbBS4pJqLHRFzz/v/2ff49Py6WGCw6XpNqXJEWfMH6
 AkmmeJkijnsI+6ituCXln1Gl4PpQBJ9zqVXSPTvcgYqSzTsECreWxXMvIwDUPxw/a9emtW0rBFjJV6
 qzVTcT6+I6+YbE0+tmCPBLgoRVH+FXJxrPO7VbczYIAnevSBzY4I2hLf0WTgf1qK3GrgOI3GdjJHDR
 nshm3KwaXeuCBypW9wRu0eMuu26o/2TBGeU8YwvqkGDJ1OTztNvdJUSWB7RtPCgdhIQWFZhzBg5Eub
 zh23ngrpDKFv+HiJr/C/OuPs0t0B5VxJDuR7ArsY5+K29W6tIKjETaAII9hNg+zEZdeu18KruIUYeG
 mEZh7vBZ1VDxllWtj1R39RN5iaevWH8bHYbOo9Y/eyGR2tBJdyuHxF5a+dmA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Since [1], sound card must have the corresponding clocks property,
add it to the EC100 DT, and fix:
meson8b-ec100.dtb: sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#

[1] ASoC: dt-bindings: amlogic,gx-sound-card: document clocks property
      commit: f189c972f86b00318cf2547b62e461cb98374e34

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
index 36fc3e15ee9f..bf1ef07de6c1 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
@@ -98,6 +98,10 @@ sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "M8B-EC100";
 
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;

-- 
2.34.1


