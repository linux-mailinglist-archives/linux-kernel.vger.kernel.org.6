Return-Path: <linux-kernel+bounces-560396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9FA60388
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D607819C4A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAF1F6664;
	Thu, 13 Mar 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2OAtKlh"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768131F4E37
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902201; cv=none; b=tBaiBPGTBZ6z+COLhuT3C+XhE6VD5TJ7/8zVN7WSUFDmfpluVylezCdhBmdibEkSXy8kqb89wkPukJMKkmqW3W8EobIOT7EGGFsae9Hvxg6WJUTkJOuNCUD/Rih+jM+mFJo4Y7Lya/NOZWR+D5Sycr5J12rWv81aF4B3oj93qtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902201; c=relaxed/simple;
	bh=NaZu91DC4T8heFZFo5XZ2syZfWhTaJWbyUNy8uixAT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWvRZyKkA/dG/P1zKwPvGBvKUmGIXy6JQbAE/AKCwLoowC9sUOuA4IvW0fxUJn8OvMUDdeB1Ubzt15Hx59+laZFRNtECiY/MPxsznXFxnFEdjmi2rJWs4p4408sTtkffopqJWaWq6l3akyUevIUjI+oaCeCX1Qq51y/EaZZjM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2OAtKlh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso2430875a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741902197; x=1742506997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+Au6V+nm5YKxU288WKh4NUBJU2SyJevP5UMvrIA5i8=;
        b=b2OAtKlhBW9xtV+GU2vRGF+mKQ5FDsaluza2OobOIxUn8H7em+qDlQiFNjU+ownvG7
         ysrZUuJANLkUTWX8MWj8EWGM6y6LH4IT+q/OdVwhaiHv/gQWyABwymqLUwpCFx+RtjOd
         FpnlSiarc7d0JKBkvDSsOLk9dJZyXZPbs9hdC4p5YbptwgkdlNcYcEPwIw0zocNrw8LW
         1C2vghifvLfBPRz7a9QWbDjx1PUsQmCjtPlgozIAbuBLeAns3ciSobTK7ibQ7qOnmpFp
         IC8uG2JDyNZfRyYLBJ6XZwxs2Ut/Fil1ZlNrsTAz9ltuoTK1OlaJXGJllZ+PX2Xs1Th9
         RSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741902197; x=1742506997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+Au6V+nm5YKxU288WKh4NUBJU2SyJevP5UMvrIA5i8=;
        b=wQNWbrtyaT9ccJwq6XYQKcDuWZ0JANXftAprjFmXnnZzCBGruB2lxrVcsC5evd4LUL
         ukyeda0T+pBHPsmUiM3a+j0jMHRz/t+LLZl5EyumyoUuZ1lsva/YFJMHgK35JNmo8BoL
         aLNUctaURahBTNSjw1p37mdnfWxtx33ULhEtVCDaiAdbbUwyVtyB98N4fG97bDR44Eb2
         sj6aBi/IvSc16/7S1NjCu/U8sRRh8Yz3xojF0nC7GKzse3YbPB1Yri1YlrjD19NSB+o8
         wGBxCB6LhBwsIP6tJAzZib/Nv1eb2LghwFPYHq0cT5fd6Y4PE10EU23TkdtLQLULreG4
         MBTg==
X-Forwarded-Encrypted: i=1; AJvYcCUFJvK6aH6cKr2jhdiYtN2v30Mtn7fexdV1oPqGN08OU8C8cGYFg/b35Z444i3601bbgq5EjhE0hbRipz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Tij+qA0zPBDOEzgGouLZLUTgXe0OI7raWxfJW3q4u/omgbLv
	t7kSQBHRV0p5Tj22eFfs1zvBNmh/7JZOF0q29UmmhJEuTm5NKbJxjRbgR27Gs0s=
X-Gm-Gg: ASbGnctiAGuqxn7GO7jUw++J+2BhjXQ1rvipk1b8QiNzdP4kTgNjJuILyf1XOezSDam
	iYIlJ0RE4gIrBNKADQwV1tevMXzpLgVRB7a/1HZF5QjiGkeddQUz9Jkolo6QDQieOeqSDGO5ock
	25fu3MkXF6+gXEQGuQcYL9dviAy+iQqfSbKaDexb7yv1J8nNpbCIaMo6f0Sp9SuJpjBgxQf2+JG
	Zt5DeyqBSWbBqI6mDjN7isWFHGf9qbz6zxy/ZCp4NKPoGi4z68sFir78Qp8jlES/KnZ77k5yC6v
	t8daochsXN8cQx/SUbAzKSRF0Pdwf8MpZaeYy6AFnarWsMuYu4VUoYLJwnkgD6SUZp2bP561U6q
	CBcCxO8uKQnsWjKsocbvCpuAbIgUb18Ak7URBuzQVrjmcBBrXNOhd0yeLoiz25yx6lSMwbyn5By
	FqStg=
X-Google-Smtp-Source: AGHT+IHvGRlUnca+L9ajzxTMQ3ZVV9sUWOvELGKMoU5iE6uqCQcPOCFhwS9U5tYCom0ODtsxVB3EIw==
X-Received: by 2002:a17:907:6ea9:b0:ab7:1012:3ccb with SMTP id a640c23a62f3a-ac330181a8amr10857666b.14.1741902196696;
        Thu, 13 Mar 2025 14:43:16 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489e0sm126938866b.151.2025.03.13.14.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:43:16 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 13 Mar 2025 21:43:13 +0000
Subject: [PATCH v5 1/5] dt-bindings: clock: qcom,x1e80100-camcc: Fix the
 list of required-opps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v5-1-846c9a6493a8@linaro.org>
References: <20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v5-0-846c9a6493a8@linaro.org>
In-Reply-To: <20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v5-0-846c9a6493a8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.14.2

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

The switch to multiple power domains implies that the required-opps
property shall be updated accordingly, a record in one property
corresponds to a record in another one.

Fixes: 7ec95ff9abf4 ("dt-bindings: clock: move qcom,x1e80100-camcc to its own file")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,x1e80100-camcc.yaml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,x1e80100-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,x1e80100-camcc.yaml
index 5bbbaa15a26090186e4ee4397ecba2f3c2541672..938a2f1ff3fca899b5708101df7f8aa07e943336 100644
--- a/Documentation/devicetree/bindings/clock/qcom,x1e80100-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,x1e80100-camcc.yaml
@@ -40,9 +40,9 @@ properties:
       - description: A phandle to the MMCX power-domain
 
   required-opps:
-    maxItems: 1
-    description:
-      A phandle to an OPP node describing MMCX performance points.
+    items:
+      - description: A phandle to an OPP node describing MXC performance points
+      - description: A phandle to an OPP node describing MMCX performance points
 
 required:
   - compatible
@@ -66,7 +66,8 @@ examples:
                <&sleep_clk>;
       power-domains = <&rpmhpd RPMHPD_MXC>,
                       <&rpmhpd RPMHPD_MMCX>;
-      required-opps = <&rpmhpd_opp_low_svs>;
+      required-opps = <&rpmhpd_opp_low_svs>,
+                      <&rpmhpd_opp_low_svs>;
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;

-- 
2.48.1


