Return-Path: <linux-kernel+bounces-232339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0E91A710
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0EC1F27839
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95929155743;
	Thu, 27 Jun 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+d/ot+K"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9616DC31
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493045; cv=none; b=nchte4WBGioHL281PneSTXRrfsYC3X91aluHrM0is8C+SqUG0E3Eyv8KiLWSNR4fJHpCrmPTSRtjZ8qh6SvMlF731HAgnyjyq9rUt4U23mNR2kYZfkJixraHIIPvBpSeRecyTyDE/GcN61vTRFvxJfZKYgpzKJ6a1EPVP9poPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493045; c=relaxed/simple;
	bh=UlaiQt/tckdewB9Dnth6/MqN22rq/RNgaYLmH+MOZTY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LyPmILZ/7DLHDsc6VRlT39lYR2N+UyNUVGGus0VGjFgj9WxHHASVEl6DXkRiuwern1yjmFpCWNRnURJvqkBgFkKVzwuO+/M0anr1FF0mWjWrosXTM4qByAaumswdiZQdJJk8yJYd+ZaGpwyVxLpx3bFDR9LbKovXvBM6ri0IdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+d/ot+K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-361785bfa71so5983592f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719493042; x=1720097842; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=08iAj+Wou8s88hIzeZ3JVspWG0G5cv1NuRvlWIaJnOY=;
        b=k+d/ot+KiIqofcuHKu/1P62zEgBQ/SWo15bNfFrh1mE3Z0CQTcibhghlmuRI3QO9k9
         +aiN3hWYXi3kW20VHufktTW7lSRekxiM6d/bADcl4EhUiHFMCR3Q3wx1VUuDGrgSG3tb
         AcxRwHK7U+93LI9yRGfNgBxU72b5Uzdl8HOBKIIfZgSmbAcrdw9on+eILhZoWqBCglZC
         hasEl2/xY5K057dx/msR7hbSC9277FCVxSUM/L+pFndhuOpa5D6CFm1XzjNXurDU2Tbi
         gZwRal8LSZlB8cW1NxtL7VoQcDs6VfxbZkxU9CY0PMXNDD0H1M10vSZwefPbw78CHYZU
         3EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493042; x=1720097842;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08iAj+Wou8s88hIzeZ3JVspWG0G5cv1NuRvlWIaJnOY=;
        b=frS4EaggtJnb5JVXD+oELt2DfOVo9v8WkBw2AxLs/gBr62Nf5EllmNPngKAkfm4xkU
         d+5qzVAQ4bUyOJtg5qgU0YKKO+IFwzvLQYt33Xq9BdsNgq1zkL9iFCbMq72nUVMvLkcw
         avuxmU5Rsj644Fuygf+z3UH1sb/yw+c8KkwcjOIbev2kteLo7ofUF2R1rQAgq6TzCWdV
         KnvCZ5zriONuRSqEVbx9o4w2fNwL7Pf9iaMbR7t/fnFzTvXQcYIfEXKRK1csgolJFWLy
         APVa5pkygmLoLi3V63Exs6zhQ0xA293W14EHYZdC4YK0KK75VJB8BPPOW3bX4D4/vOuM
         amhw==
X-Forwarded-Encrypted: i=1; AJvYcCVEOl641M4tyWhIQ6BjiiV7wQ/Ei/KWmSnhu10HblE6AeEgGJcBof+g5Rh4g3swEtlzfsSen7xW76mcr0pE2D2arxs4tjtRv3NYnF/7
X-Gm-Message-State: AOJu0YxBrEtPFbqOcwVCsJEYBLg3I56WCwwXgqk/1ZVuKYyXMslVNOgs
	xOqaMFinx9Cr5+2fJDOZKSk4YIlJukcVJ3cmXTYXq0xy/xqjaW5bC9Ku6s/EH9pZgc++99jdKi3
	30YA=
X-Google-Smtp-Source: AGHT+IGMdQnKoS4bocUnDvYLnlQ5FPY4YandyfkZZbarlPaAM2z8iovplQ90x+G92AGSAg2fDNNzfg==
X-Received: by 2002:adf:e3cd:0:b0:35f:fa2:3e81 with SMTP id ffacd0b85a97d-366e7a51d1amr8833553f8f.63.1719493042114;
        Thu, 27 Jun 2024 05:57:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357fcecsm1800752f8f.26.2024.06.27.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:57:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: qcom: sm8650: add port mapping to speakers
Date: Thu, 27 Jun 2024 14:57:13 +0200
Message-Id: <20240627-topic-sm8650-upstream-was-port-mapping-v1-0-4700bcc2489a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlhfWYC/x3NPQ7DIAxA4atEnmsJaEKrXqXqQFKTegAsTH+kK
 HcP6vgt722gVJkUbsMGlT6sXHKHPQ2wvEJeCfnZDc640Xh3wVaEF9R09ZPBt2irFBJ+g6KU2jA
 FEc4r2vnsfJwnG6KBHpNKkX//0f2x7wcLq6rOeAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UlaiQt/tckdewB9Dnth6/MqN22rq/RNgaYLmH+MOZTY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmfWGv0G4YF0h6GEQgY9AJ6VbnxPYnMxPfd6MCGQPn
 Fwr8aXyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZn1hrwAKCRB33NvayMhJ0Y7uD/
 49zlvMoLGBg9lSIcAysBTPL5HZM1qIwJl0692N+6pol0Cs/6GTj9uQ0I7BAwExniItWQrxMPW1/yhr
 rL3umfYpUzrFYgixqwbv//XYqevQcUhxhAh0wHwt3Xo6uIusovKBn3qHIeYkjm/UynSPyXLEjdapXP
 cK6DrJgp7a7NOAXMxChu/75YiICt5SmlHKLHc33AYdNeqFQSMFz3g3/GLepHyTcZKi1jXtCkpwoI6h
 PF95nzIfcU+9qkvR+/bUZurHEXeBftp77TaDFlT4uDOAMiOAzicQs1JDmS9zjmCZFOvEe6dsh/NUfI
 hGRJ0E4zKCg1R2ccDbBltOI6ADnaroLEY5oF52nFASVgXnFQr8oiwuibUrKKXw/vTJY21ssvJnUQkS
 9YafwPYsOlnmDAyYlRRnBdSoRlEnchHu3lLWI37EtoSK7P0pz5OWltvz8oaghz3QfuuOpA8jdoazsx
 CpPf+Ii4NpvqlF1nc1fW971u/GGAVZd9qTRiXOm0uSuf3uMXSvDu2iYng1s3buFJRl+H7qU4toiTSD
 6GDe2snX5YreMJUuS9uYgeelGc8qO9Y8RzWePONzYqhhN28Dgx3lsmtJVUMNiyOvzBOHTDR87meUoK
 fHlu8VqC4wVUUcuSm97xPEL/a4uSF/F9fojIox8DhiA1JNoB5c8DnhwvPKIA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add appropriate mappings of Soundwire ports of WSA8845 speaker
on MTP, QRD and HDK boards to correctly map the speaker ports to
the corresponding WSA macro ports.

Runtime Dependencies:
- https://lore.kernel.org/all/20240625-qcom-audio-wsa-second-speaker-v1-0-f65ffdfc368c@linaro.org/
- https://lore.kernel.org/all/20240626-port-map-v1-2-bd8987d2b332@linaro.org/
- https://lore.kernel.org/all/20240626-port-map-v1-4-bd8987d2b332@linaro.org/

Bindings Dependencies:
- https://lore.kernel.org/all/20240626-port-map-v1-4-bd8987d2b332@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      arm64: dts: qcom: sm8650-hdk: add port mapping to speakers
      arm64: dts: qcom: sm8650-mtp: add port mapping to speakers
      arm64: dts: qcom: sm8650-qrd: add port mapping to speakers

 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 20 ++++++++++++++++++++
 3 files changed, 60 insertions(+)
---
base-commit: bc468579d65b29188123eefa2cd7f48a6ee05a21
change-id: 20240627-topic-sm8650-upstream-was-port-mapping-1b326fb51af0

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


