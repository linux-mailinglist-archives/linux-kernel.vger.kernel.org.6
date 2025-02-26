Return-Path: <linux-kernel+bounces-533329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785F6A4587C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A31894B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9538A224223;
	Wed, 26 Feb 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBh6ZhOF"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB671E1E15
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558953; cv=none; b=CPtHFVpbRJAzxA6+Og0IoP0j9zGw/bIgJDRDNDWjjVYQENgm+fHfU0maqoqoZrHWjqm1Pj4MXG+yBl/+Iqm4Ir7teVkFTdCDcSIK57+zz2sPfNodDbjqtGqWYiL82uT/8iMOwDEUvavhptse1J/6O3uzeqUraxAwWWYUZhihrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558953; c=relaxed/simple;
	bh=8jC8GE4iiOuzSa2Zvx7LLBQ5XuHRNjDZasqAxsEZL7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Il0nTgtbG8FZfORdAq//40kWXwS60NFpYpjVBfPMYGz/tlvc2irihLZ3+f4VlMwkaEFojLFEfo6ySZ/ZTPYyuxRgidUdwTRIxYxHu5nTM138Ohl4InPu5Q9Bomfnd4sCS3Psxvu5WqXDnpM8h2SAoRhOeugjNrEDi0kfqAFi99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kBh6ZhOF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3091fecb637so52570981fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740558949; x=1741163749; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bW1fZDIVdFn95WDQdT8nnBozEwJn/hwsIeBOhLkuZbM=;
        b=kBh6ZhOFSiXipuX2+h53jGMkjbzsovYXSQj5PD/Gjd+BEtyPCTBZLjfIZ2AAJHd8Xs
         cEdC5BhdSRZA9AwvFaJW/1j1SAiJGXHJSjX4fOmvAzjAjcKEcc2RCKiadgMLS005dcl3
         Eh7+YP5VHcoQQi2oC0GtqaZJ1kPur9TwitPfZE9DXG3PWq1Ynq9a92gbcKH9uAelKhps
         SgLNs31cl9olpWdbuTxadzzK7nXcBbIm1po3vSvvPBPfsmCrcogDbC5UFXlRpKHak32t
         c3UIC/SaDOrWS4ZKzXpMqes5YiFMdQ2WT0ZwbpYvhqryIhv6OcWnvCwQoCP0LMZ173xt
         nfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740558949; x=1741163749;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW1fZDIVdFn95WDQdT8nnBozEwJn/hwsIeBOhLkuZbM=;
        b=OlqmnjDma2uLuJ7VMkZiQiMqsIRTNnovPn25MUttKBbPbn31ljxAYMDTZavjw7sq3i
         nU+nFPVgP8r8Aq1k4iLfzoTR6HuxCYU7AGrzW6q6tBGF/yY5alm72+aqn6brtIuTR+mg
         IaxoMb0PufBq1vE+nZfq3FLAtPWtxAn6n3mfKhgqDepYDf9kwTYuX470xPm+E8NQ8OkJ
         M/lOSHIRCO8LKcH/OamNkSvEGsjfxq9/nHwkW77jIm3dlfZu9ilMiUkCAsW8/iN2ku0w
         sbByX+LM2GRw56g5jRPSFnVrWsB0oluR/wrWuPBXEwln/m2VBlZDPPV2nuQrxN1jl45X
         T0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW7dp8ML80PoR1sbtwYHRLKZD+l74EsQ5XcSHc2qK9HUaNLllHAyZR1WQlE70o+4BFV51YrTtg1UsUV3fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMubmjV/VIx3Y+driIajqzwdooe0wvEGCf6ScZQILT6GC7smwj
	Dss21LT3hkpJnoNpOB2o8IVIKzYJ6q9ClKiGjrZj73N9fHzodLqOiLcMdVMCJQI=
X-Gm-Gg: ASbGncuc5Vlul/+y1DROlO36zPMn6SfFCqXf0CBzPBEMHcYu4mwGadPdzZvdyzFsp1f
	W44OVQ+27TfbZoQ+hci/pmWMF/6FT+U/kqPJy95XCNpfsDQbe06IpmTvyaEVG+8fpwiJea/dCni
	xqN+YnCOyhCiwkZOpJw+xRlI5/1Gekn2sbkQbr7VN+iFtglDRSuKvw5u+9Qz98DfXw3NDqDW7bb
	TIrsSmi8t4gAxGKoogew3PSudwJs2g7UQftc9Pz1bgFArVy8M/zcjymD/T2ilsKUR3ACDaPKeGN
	elVS8BHG6PlOlwaz1tRKmKcF4L0zyKqX5Q==
X-Google-Smtp-Source: AGHT+IFilW2vYILEBAZQ6VX4V6rTlc6qIxQwn+zrj7FCNmekcqLsTBXZ0G5XrZfa+NCP0HoIcj/A7A==
X-Received: by 2002:a2e:9013:0:b0:308:e54d:6196 with SMTP id 38308e7fff4ca-30a80c7c5bfmr35663041fa.31.1740558949099;
        Wed, 26 Feb 2025 00:35:49 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ebe44sm4532701fa.30.2025.02.26.00.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:35:47 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Feb 2025 10:35:45 +0200
Subject: [PATCH] drm/ci: extend python-artifacts timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-ci-python-timeout-v1-1-0a9092a3d6fb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGDSvmcC/x3MPQqAMAxA4atIZgMasP5cRRxKjZrBVtoqSvHuF
 sdveC9BYC8cYCgSeL4kiLMZdVmA2bRdGWXOBqqoqYgUGsHjiZuzGGVnd0Zsa9XOZKjvGg25Ozw
 vcv/PcXrfD2ZEfV1jAAAA
X-Change-ID: 20250226-ci-python-timeout-7167d2c2985a
To: Helen Koike <helen.koike@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=8jC8GE4iiOuzSa2Zvx7LLBQ5XuHRNjDZasqAxsEZL7o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnvtJidks9NJNkSDHsJ3unFLdRLFWtCnNUFyzS5
 OBgONf2hFuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ77SYgAKCRCLPIo+Aiko
 1dvrB/97AeYZX9Nm5BzkOiwf17Vo06dYUYXJx23U8aDBkskFD+/haGrGlvV0p/skwktkD/XlA2B
 vapgCO4I7Ch9KxBHLNFGO6p5sZJEaWjE9k+rHzlkGJMVV+SlB1n/eANuEZ55MQ9SjWQFf6gGWQG
 4tOgzOPxbi6br5HQbSKIw8uuBJ3Jnrvm7/lAPr3zydjzjZ1xTUpySKO7m27Kwvrjk/bJITL43hT
 0/jRarKxpWKsaO610qwBdo75oSscNgwR/WKUjspURYnQp/jN0e7iL3yIupkwqCo5c/UVz2qwDkA
 eb57SZeHwk/gZ+eFwEW4AhlQctWtKMB7eArR8cRRT3oH/3Zi
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The job has a timeout of 10 minutes, which causes a build failures as it
is even unable to clone the repo within the specified limits. Extend
the job's timeout to 1 hour.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/ci/build.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
index 274f118533a7a1a0a4b8a768298fec624bfe67c2..e8d466c319275724687b8581c086b5ab352c3cd1 100644
--- a/drivers/gpu/drm/ci/build.yml
+++ b/drivers/gpu/drm/ci/build.yml
@@ -210,3 +210,6 @@ windows-msvc:
 yaml-toml-shell-py-test:
   rules:
     - when: never
+
+python-artifacts:
+  timeout: 1h

---
base-commit: 130377304ed09e54ff35a8974372498aad7059f3
change-id: 20250226-ci-python-timeout-7167d2c2985a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


