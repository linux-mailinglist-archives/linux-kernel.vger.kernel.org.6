Return-Path: <linux-kernel+bounces-513443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA449A34A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE1716D832
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E92045B5;
	Thu, 13 Feb 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4n9kB3a"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F25266B6C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464086; cv=none; b=n02HJAft6yoRJaobzt4hIfw0LyC4I0b0Ds2K3fGjoLdK9E2BqlXxyKDOmI8sEc/2BRlJj7c08illnKWd+2y3Ozcxaa8ElcA3oLiUovfPLudcDtfUS9PIiDgtVEOGd0YL7sbPfsuFUJkUxmqT7T+uo1KIL0PkJ507zsFTDV0VGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464086; c=relaxed/simple;
	bh=gMZo41txLQ2LRSXK3xEGNTFi8pIy6bB83Mk20Dl9K7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SJD71GwEwtjhrG3HWzarmJlfYNYbKGHTZc5V8uziXowL9RjRF9So6vD+RyalStZ6m/MzLiKTJd64KW2qblJU447GozuLow7nJAyX8vvpoougH64J6Ht57NxJ9r+NK+eke0tOjbtdHZrYKgXMAO2bNgSQt8S9FM9MVOi4JqQzLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4n9kB3a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso7124715e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464082; x=1740068882; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZgcTL04UsGlOqXOt4Yj1EXMw6sYk8iPbvcFY4qxB5g=;
        b=Y4n9kB3ayggEqWStrtNNfj4OeQG+9rKsD+r0PD6IEHzcdCLtFvI2TiHPs3axThPROo
         ciBj6ZzZ4IUllFSUTT91s1zsgFxoEF9LHLqczp/lTkWvXB+EaKsTbJWbRdo6sO+ZKIbK
         P4maVXuqIzOdeDiX70ln4+suuAxe/mb4Vpg1Vjb2KKr303AW4+CmvUp/YX4kRKu1nwUO
         vTH0PoUj8O1cc3I+0ncMfqOIWGZEcV4nH/YLqI/YRYRoN0EHOSn6dJGSnQNot7Sqki8O
         A7FZP6o59UzFGHNLnKtKsfGjQGwyqXeghcRUeNkDCccFvd7uXQyD9f/2s+m3bSw0RB4Q
         /xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464082; x=1740068882;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZgcTL04UsGlOqXOt4Yj1EXMw6sYk8iPbvcFY4qxB5g=;
        b=rtAkv9vOBhH+4EsE6S3xqwpzWMAhfhKbLHN1o6i12tKOD+aRBPcd1ulwxMLFa+1/p9
         K92ydxAHXB1nJJq7E1DBszt1slVrjt1NjGha2s9wxN2cf5Z/EeXfF0XQo287U1tqGHr6
         T07sPsURiHoO+nO8jXoBEtbQXWDLU6xZlkdCES2+rL45MSqati4o7tf4fJj5+wn89s25
         WnmTBhKNVoH3BFSzy0mtSwcJZCdKjO6H3DdotxIVpVYdpqZYqY10ZkMw0Y82GyVbixm9
         XZtECOGbX6aoCwwMncD6pQ8LaEr13iMbbQSGiWwyOIRTJPIzSmyv/ty7L05qeiIO+jQu
         Rwbw==
X-Forwarded-Encrypted: i=1; AJvYcCWsA/4IvfpA/LpHZBtguKmEIYldMco2zCIMQj3KcVYiv83kAux9ujXfnMUKmUI+kKyWCmH5lNsraxaNGcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAPjzr5DOEPqw+/o/wLcA96Ypnc2E7TOy1iH20TocrL+eMnEt
	R7tapTmWVV6XthPuU+luwna5OphJ26KQHdguVCTs8Rs/Efi8zOwHEbCpxPHIw2U=
X-Gm-Gg: ASbGncuyFC/BFSZkJsGz5jZp+TjLTJeLcowqlaOjxCd1fdJImkqMMSmVORofagHeplT
	blzUAyxB+kPoH/V6ILJZpahMg3xktrBBigxJOBNxeHmVXKSMEDGK+/25oKUgCB9rtadXf7F95w6
	gIQ0mjORtr8YMDwNJhDXQmkS29in40LWTBxym1PVw4XzAfVPDgnhSPdZ6ugTSQ8Q7CNcqYitkkn
	Ixsc0INQTDpurjGVC/AT5zc2iJ1vMKp6zIAw49w980kQPQIvEicLwlf/X+YXHudfn1fzIxFZDFl
	lGLkZFQnLjwPPEy3WOlISP+5j58Yx0E6GDfR
X-Google-Smtp-Source: AGHT+IFOtFbDuuT0dXtvs2HjX0F6ZZv8xueD/rK6AvPuNnLvj7eMkl7RAS5ZXsjZpe5AKtriTmXMJg==
X-Received: by 2002:a05:600c:2943:b0:439:33ac:ba49 with SMTP id 5b1f17b1804b1-43960bc0035mr39735875e9.1.1739464082420;
        Thu, 13 Feb 2025 08:28:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm2274382f8f.1.2025.02.13.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:28:02 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/4] dt-bindings: display: qcom,sm8[56]50-mdss: properly
 document the interconnect paths
Date: Thu, 13 Feb 2025 17:27:55 +0100
Message-Id: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIsdrmcC/6WRwW6DMBBEfwX53I1sg4Ggqup/VD0YeyErFZvaD
 koV5d9r4JKop7bHWWnfjGauLGIgjKwrrizgQpG8y6J6Kpg5aTcikM2aSS4Vl7yB5GcyEKf2ojh
 MNkYglzAY7xyaBD05S26MMNAFrD02apCytFyxTJwD5vPm9vae9Yli8uFrM1/Eev2bzyKAQ6tkL
 2ytEav69YOcDv7gw8hWo0X+Ay4zfGiE7Fs71Pn9B7y8gwv+O3iZ4aoyx1ofreyb4QF+2zsL+Hn
 Ow6S9ONbriGD8NFHqiqU+iAqCEWu/E8aot8m64nnLI4R6zHOeYwqoJ7AJyJisrU64N4hat73gK
 PXQ3OV4yUFu342VboopAgAA
X-Change-ID: 20250207-topic-sm8x50-mdss-interconnect-bindings-fix-dd975f223d05
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3087;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gMZo41txLQ2LRSXK3xEGNTFi8pIy6bB83Mk20Dl9K7Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnrh2Pu6dtWaNqc1Rn1LUsSidCEO7sl84kQMbrvVp1
 z4BvaRyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ64djwAKCRB33NvayMhJ0W0HEA
 DJcyryE1hO7AAcCT5VctwGT1ZLpnKponVGiNjale2zYMJSA4JJLFt4SmNC9DDugfp752PmzhjzbzsS
 E/fDbawiRvo95ndSPBEYAaQUqrlMz6+/7G+BpLvWLc9CsxJr5vt6xqklzoaJUTCrcyxHHb8u2gsvQi
 zit4IE96TBpYaBMbeso69y5FexeOcFFAw4YVEQPxYypmBFSTO3zlWwVXUqiaT7oL7+75aT3sp6RbWF
 zn8VqPnjV/yLfK1GvJtLmM299eQrtNBkr//b4281UOfRtlg98D+kpMVsI6mvRymY3S8VNrUB3ofV0y
 M7Z1Ff+y/OKQMR2UDz7bu/eqBuD/yY/aGUJM8z8xbFrDpWf04brpfWwT/lftXE6vt54qiYoSYkh133
 ELKcjJVvh0gl8kLoF6vRRzH+HAK4Kx2Rv8U0xw9CahYg14iJ9P5LUxAK9XAIl21cBmaabveTn/JNZM
 3HCn7LCcCRPL6DdgtxUSH70GXDQQ40evIrjoKKsr06waQAL6ZaATw2zghffbggQP4asSHAe+/3fMzC
 4D23YvYv/Om3hBNk2uQj1nEVSQLZgwL9OECmqoXARrJ4C+0J85VMO6gfEbPf2+nAtYc+WYRUwUMH6f
 PcG7QoLkzO6aYT5slm+OFPGAnw6+tuE8/dTBpUYEpv1m2TVuJwRlF1OWe9Qg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The mdp1-mem is not supported on the SM8550 & SM8650 SoCs, so properly document
the mdp0-mem and cpu-cfg interconnect entries.

This fixes the following errors:
display-subsystem@ae00000: interconnects: [[200, 3, 7, 32, 1, 7]] is too short
        from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#
display-subsystem@ae00000: interconnect-names: ['mdp0-mem'] is too short
        from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#

Depends on:
- https://lore.kernel.org/all/20250115-topic-sm8x50-upstream-dt-icc-update-v1-0-eaa8b10e2af7@linaro.org/#t

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Add review tags
- Rebased on top of https://lore.kernel.org/all/20250115-topic-sm8x50-upstream-dt-icc-update-v1-0-eaa8b10e2af7@linaro.org/#t
- Use ICC tags
- Link to v3: https://lore.kernel.org/r/20250210-topic-sm8x50-mdss-interconnect-bindings-fix-v3-0-54c96a9d2b7f@linaro.org

Changes in v3:
- make sure we use cpu-cfg instead
- Link to v2: https://lore.kernel.org/r/20250207-topic-sm8x50-mdss-interconnect-bindings-fix-v2-0-f712b8df6020@linaro.org

Changes in v2:
- fixed example in qcom,sm8550-mdss.yaml
- Link to v1: https://lore.kernel.org/r/20250207-topic-sm8x50-mdss-interconnect-bindings-fix-v1-0-852b1d6aee46@linaro.org

---
Neil Armstrong (4):
      dt-bindings: display: qcom,sm8550-mdss: explicitly document mdp0-mem and cpu-cfg interconnect paths
      dt-bindings: display: qcom,sm8650-mdss: explicitly document mdp0-mem and cpu-cfg interconnect paths
      arm64: dts: qcom: sm8550: add missing cpu-cfg interconnect path in the mdss node
      arm64: dts: qcom: sm8650: add missing cpu-cfg interconnect path in the mdss node

 .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml  | 14 +++++++++-----
 .../devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml  | 13 +++++++++++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi                       |  6 ++++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi                       |  7 +++++--
 4 files changed, 29 insertions(+), 11 deletions(-)
---
base-commit: 379487e17ca406b47392e7ab6cf35d1c3bacb371
change-id: 20250207-topic-sm8x50-mdss-interconnect-bindings-fix-dd975f223d05
prerequisite-message-id: <20250115-topic-sm8x50-upstream-dt-icc-update-v1-0-eaa8b10e2af7@linaro.org>
prerequisite-patch-id: b2052194cecb6796ba6f1e58e0aaa9a7267f3d0b
prerequisite-patch-id: a3def6c1e27e43153ae1f63343a092021926af8f
prerequisite-patch-id: 7daf103007dc6f7ed97ce26c67799766197e0cfd
prerequisite-patch-id: 68b4f5c2bce33ce6034716cfe4f7b9e2cd2d0f98
prerequisite-patch-id: 8b4cfaa99eb145b533a6ca63f4813e38649d6c8f
prerequisite-patch-id: a0d5112490c42e1c7752371d6b3818fda5c06bbf
prerequisite-patch-id: 7b72193dd00f7a2e8fef3f36e6e53fab4691a65b
prerequisite-patch-id: 8e3be7c0aae177f77e42570c28a1ad22aef25768
prerequisite-patch-id: 8a641540de8fd86787102b3e682fa8baca295d66
prerequisite-patch-id: 8b31e6775ccb7811557ece74172dda96f368f0c5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


