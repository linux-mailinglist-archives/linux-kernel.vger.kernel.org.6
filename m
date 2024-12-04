Return-Path: <linux-kernel+bounces-431318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A769E3BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEAC166DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7A1F76AA;
	Wed,  4 Dec 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSoRvJYR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1621F7082
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320833; cv=none; b=gTTkJr4JqEu2rI0qS8Jhd7mq5Da0ooeQARpV5wLD0bCpkfBs/h0pD81K5j4cvIj1R7SLRP93gAwGOIHcA5nLxL5D3a1J2AAySHRWy+MjUw4rQTiTVvrOaPXG9xQlb/c3GT71//DerC5wZjJoWnZOTgPaZ8Y0DjFynDwZPYwx53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320833; c=relaxed/simple;
	bh=H95Tmerwf6ocgqV3ped1L/uCM+XW/SsZT8LrQqWk1rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSZ21QOB0XJo7hfFALDD+prFG35t7mygh+ezWXQYJN7LS+VYNpx0YRDzODZ93ZVn3Fncg9GpY/A2AaYDXRSt542ZhnnPf+JDfGlz7r7Zq2zBIPUxEWVsklsm9imcPDmyxMXgM9LfWd0hg+T3fq4BTSITkL3Js0ggvy7TV2sr/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LSoRvJYR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e1721716so2692786f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320830; x=1733925630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV8QY5eukfrq2lN4tsY/+E6/ZMZn3nftpYsTU/xeZxU=;
        b=LSoRvJYRJF7PbC41IAugr2/Gf7cP7HRCzm+NU50/NBjASwzsPie0Jl5LCQ8Z5m70mY
         wwL3tvjqOZ+TBp99Fb0vM51g9trrRALSnYrl3xxmiHNxZeryWgJb6384KaxM8VBIgRrh
         BG4UIBXb7T7s/jI4r/cUGqQFcRr/pWybnmtIj+FsHcfloLPqgyI9OXL2UOrAtYjMdfiS
         XiDc8FGUlW7hJoOSuIQN/lqThl4xpnfT9u+v0GNQPVukHAxllwsa9gkO7Z/elCaDj6Tt
         ahyRQDK3dPf6aF+gWyLZap6G//iRD2OZdWioCRXrsM7+zxKaEBIsyXDWcX3CXSpYeUzs
         OZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320830; x=1733925630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV8QY5eukfrq2lN4tsY/+E6/ZMZn3nftpYsTU/xeZxU=;
        b=Lbhb2qkVMfrPVTwEPhg0dRBMSzZMWYvduLbnPitvc8aF77CN3AZ8vVx1GyvyuHjSpb
         xS0raBXb0El/bUalBGGiNO7sYdOSm2lUijX9kr6NZO4JD2iDwF1AFhA5jjzEkDSZO4IT
         PKIQgTfEbK2+wVFiO7ecwVsX3AC8u0If/1R9inyzlYeznISqDk10UoGcSlQzyp9lYk51
         LI/v6wht3mY2wtP0fLVbXty3L93VZmnuAvGvdiZUM88o/lfCEFPuTUuzgreZgB136uco
         Z+AcrkRY1587z3Qn5aeiBmZuB8dI6potN3USNsVuGwDVvXv/OamPzPG52GtWDA/Ex8ws
         TLug==
X-Forwarded-Encrypted: i=1; AJvYcCWAm3jXFj2kIGrDstN9XhAO5xVSKGP81acu+fH0cHGZRl0qCUu6FkfBaiWDPhR7sROwkDBmTWm5YCppAqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLrR19lck7zwketElYM9+IH6I15x5tPe0YHI3+X4tNcg7vrLS
	HxkoM37xQr9sNYbf0ooL7/SHl0cFfNMWvkvcqOeQ1stlY0npSNac1dYQ+cRtnEA=
X-Gm-Gg: ASbGncuLzZEquEB1P260hvOxFZ7bWwj6/jTvZaMz2KOlXGhEJkGPp7WOubxWxzoVBd7
	VYrhUEHY7iIv2ArXcrjxnDh26PoCIAgHQ53Gc3JBNIQk6z8z8Rm7FBK8UC85D1cJl4rxw/Ps+Oy
	NGVRKxmHXOB19NwGyW/NGq0TCshbC6f/qJmRvPPB3bqEK5xzEcKaIhSbsB3dYJ8qRSiRsXld3qE
	mR5xxg5AM1d7u1f89OIFGeiCwXZevdibqq7EFMiP2PxOBXsO/l4kPyF3B7wT1tZcG2J8Dg=
X-Google-Smtp-Source: AGHT+IEwNi9zQ3A7BISJyLzoaI8unrHh3ncETKsF78rBfn5vGpXEDRRpfEKjoscYnK+ZRjyytNSKlA==
X-Received: by 2002:a5d:598c:0:b0:382:4110:ecb with SMTP id ffacd0b85a97d-385fd3e905amr6274200f8f.26.1733320829865;
        Wed, 04 Dec 2024 06:00:29 -0800 (PST)
Received: from localhost.localdomain ([2a00:2381:fd67:101:8e2:966d:36c4:3579])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm13689978f8f.49.2024.12.04.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:00:29 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	a39.skl@gmail.com,
	konrad.dybcio@oss.qualcomm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] qrb4210-rb2: add HDMI/I2S audio playback support
Date: Wed,  4 Dec 2024 14:00:23 +0000
Message-ID: <20241204140027.2198763-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebased, re-tested.

Changes in v6:
-- updated tags;
-- corrected dai reg number in q6afedai;
-- changed dai link name to hdmi-i2s and updated commit message to reflect
that HDMI playback can be used as i2s playback;
-- removed excessive dai-link from sound node (it should be a part of
another patchset).

URL to previous series:
https://lore.kernel.org/linux-arm-msm/20241112025306.712122-1-alexey.klimov@linaro.org/

Changes in v5:
-- drop MI2S clock in sm8250 patch (seems to be merged);
-- fix gpio-ranges in lpass_tlmm (Dmitry);
-- added reviewed-by tags from Konrad and Dmitry.

Changes in v4 (or since v3):
-- cleaned doubled spaces in the last patch as suggested by Konrad;
-- added Reviewed-by tag to patch 4.

Changes since v2:
-- added tags, updated commit messages, added Cc;
-- updated LT9611 -> LT9611UXC comment in qrb4210-rb2.dts;
-- updated addresses in DT to 8 hex digits as requested by Dmitry;
-- added lpass pinctrl to sm6115.dtsi as suggested by Dmitry;
-- added lpass pinctrl override and pins description to sm4250.dtsi,
pins are the property of sm4250;
-- verified with make dtbs_check as suggested by Krzysztof and Rob's bot.
-- dropped two patches (they seem to be merged):
[PATCH v2 1/7] ASoC: dt-bindings: qcom,sm8250: add qrb4210-rb2-sndcard
[PATCH v2 2/7] ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string
-- stopped Cc-ing out-of-date emails.

Changes since v1:
-- removed handling of MI2S clock in sm2450_snd_shutdown(): setting clock rate
   and disabling it causes audio delay on playback start;
-- removed empty sound { } node from sm6115.dtsi as suggested by Krzysztof;
-- moved lpi_i2s2_active pins description to qrb423310 board-specific file
   as suggested by Dmitry Baryshkov;
-- moved q6asmdai DAIs to apr soc node as suggested by Konrad Dybcio;
-- lpass_tlmm is not disabled;
-- lpass_tlmm node moved to sm4250.dtsi;
-- kept MultiMedia DAIs as is, without them the sound card driver doesn't initialise;
-- added some reviewed-by tags.

Alexey Klimov (4):
  arm64: dts: qcom: sm6115: add apr and its services
  arm64: dts: qcom: sm6115: add LPASS LPI pin controller
  arm64: dts: qcom: sm4250: add LPASS LPI pin controller
  arm64: dts: qcom: qrb4210-rb2: add HDMI/I2S audio playback support

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 51 ++++++++++++++
 arch/arm64/boot/dts/qcom/sm4250.dtsi     | 39 +++++++++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi     | 87 ++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

-- 
2.45.2


