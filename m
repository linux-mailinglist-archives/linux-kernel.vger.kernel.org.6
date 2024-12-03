Return-Path: <linux-kernel+bounces-429965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83299E29C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8C71606AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9241FDE14;
	Tue,  3 Dec 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbzJ2JFW"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69E1FBEA9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247862; cv=none; b=gbkJW48wxmDulaifQ6ZOz7gQfCriLnMDZOfD2QUnzX9v+ib1YtF5M5mat5tKhhJC4G6R01RgtXGX2r8j9H+yHqpJIpMHHI+9JysNfonUcSPYPzm5ffVy3iM4rW1+cWbMxRhclQcPSL6MwBcsOc6RqSvBOEeY2VG6Zm9VbgL+W1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247862; c=relaxed/simple;
	bh=bXf/te9VFRBRe5PRM7DWDcYGUns6cx/3ajaFp1ywx0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P3NMt+mQCbEfSlgC2TbzRaoG6fBtlMcD1Osv8hcTWI1rymTnly6+1auf2iH49dpi3/C9rAbQI3yaNyyjINDc4YhleYVWAAh683U2leRPrAZA4Cpi8l3ccwdbMKIdoWwjoMAdobKifB7L9bwDj/YPxB/juv9oRAcvWO2M4w3OeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UbzJ2JFW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so305075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733247858; x=1733852658; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fVBRQkH8PWec7dz2yBm01osQMyK0T0Vy920HgPS7D0=;
        b=UbzJ2JFWRS3BHY08OnOGZh1sk3F0/sfjDVkTma5K/X31L9JItx9GbB32tTZ1OvHkdD
         nG5sHABk+cq3gTBCATlIX2FlDCcprjDgKrSO91G9P67sb7KLi05YAkgoE5i+74ftVxmZ
         ZJ00LA4cIWW3DmnnOaYTM/310Li115N1WXpmXpbzyg9CmP7yXrFuG0icBU8w8X87Yk2M
         MwCfDycNc+YrDZiLgFMoXfJ92T//gcyEN0RJUVhc38uyyBf4gpWawCsu2kGRjxkoD4Fj
         QpOeUInqWKU+6qTjyA2JIX7BUP6BUtQwz5rxSPQdYf8pPpQAS98a/RvXZMEj9oeiapBu
         GlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733247858; x=1733852658;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fVBRQkH8PWec7dz2yBm01osQMyK0T0Vy920HgPS7D0=;
        b=ZUyBJpoyqPBideqrRBk5vc2VqlTn73Pds3CJTn9dGlLQm47n5JFyB1ySz6ZqIii/Nr
         twibcVf5Zy0xKULl9QQ5hV6DTWGh2umjx4S9b8OlgBynltxOUgP6fB55HrWCoJsYee2e
         BizvzoT/GeueNOfWDkys2CZfkjGLzmY4FpruoGRok7kBWRT9TzW63X4zcy2pi25mYPwu
         q5hl19dcNdXZle6rmFUglZIRE3J2lCabyn9SI62DDuwSpnzw5EHZ99jU51hMRyxLyq4L
         zS2MBvS+rhfPen5C84JmHKqWK1UmqKNb2PIqVnXtC99eaNMU7o/So9NTjIexTxxZeXjX
         QhDw==
X-Forwarded-Encrypted: i=1; AJvYcCUiTDGQR6kFl4Md/jkqNNKl1yDBUapDz5x+Lrnrq0URMjT+3FlU3zaNVyJl5Qfzt+WBPKhOP3Qcgj54M3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIwkcam5FePVz6YrMen8x5PzRcf31lqfueD29+EeUlBazExxKj
	ZxHiz6uKOs3ZmrsPlU/ogkkz21oZbrxscwNYzVdOw711mZSzVdwgsjQ7t6toxZ8=
X-Gm-Gg: ASbGncvGThitAjbHYfy+AoIjGAfUQQOFFMWuWV/80uJBPI6z11AaJR5o5xAh3D+lMlg
	L3+FxTKKOuDhNqHs1cgtQpKDskMB1DASe5knm8lX5G6Yt0Cc5Ndb7XEmRyuO03zonqoFqyJvcdN
	4Rytns9p5H3r0JslUu3U3cIA9JAOQoyWImWh7enucLrO8GJAjMO+W+uHTb+0NtzsaKc5ELn0Vfy
	RWHVJ2QHoLRAQ+8wwUMI292KwQW++uuVMg5BJA5LBgAexbJALtUYETTy6cuuB8=
X-Google-Smtp-Source: AGHT+IEs4LeO99eCaIOoE9rg/x5K0sS885yURJsnOJqPCzOSieWlVxKgUXgYFoQwze9hgWuJ2e2ndw==
X-Received: by 2002:a05:600c:190e:b0:434:9f77:e1dd with SMTP id 5b1f17b1804b1-434d0d204e7mr28633775e9.5.1733247857854;
        Tue, 03 Dec 2024 09:44:17 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:9f9f:834f:9008:1528])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d05b4909sm17648055e9.2.2024.12.03.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:44:17 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: Drop duplicate DMIC supplies for
 X13S/CRD
Date: Tue, 03 Dec 2024 18:44:01 +0100
Message-Id: <20241203-x1e80100-va-mic-bias-v1-0-0dfd4d9b492c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFDT2cC/x3MPQqAMAxA4atIZgNptVS8ijikNWoGf2hBBPHuF
 sdveO+BLEklQ189kOTSrMdeYOoK4sr7IqhTMViyrbHU4G2kI0OEF+OmEYNyxsChCZNjH52Hkp5
 JZr3/7TC+7we24Uf2ZgAAAA==
X-Change-ID: 20241203-x1e80100-va-mic-bias-bab3bd5a7c57
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

Drop the duplicated MIC BIAS supplies in "audio-routing" for the ThinkPad
X13S and the X1E80100. "MIC BIASn" and "VA MIC BIASn" are mutually
exclusive, only one of them can be active at the same time.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (2):
      arm64: dts: qcom: sc8280xp-x13s: Drop duplicate DMIC supplies
      arm64: dts: qcom: x1e80100-crd: Drop duplicate DMIC supplies

 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 3 ---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                  | 4 ----
 2 files changed, 7 deletions(-)
---
base-commit: 12b080aaf4275c579c91106ed926044b4d5df0af
change-id: 20241203-x1e80100-va-mic-bias-bab3bd5a7c57

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


