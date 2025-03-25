Return-Path: <linux-kernel+bounces-575683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD9A705C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4863A6838
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32CD253B41;
	Tue, 25 Mar 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrlJkonk"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784918A6AB;
	Tue, 25 Mar 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918340; cv=none; b=pkkUIAmB/xiWFT/1IC/8k9N5N+T1kfW+C0lH9ncvILHqBGImXhRrNMkfSZm/XFqGH8/U69G36xHUjoYfsrsjMzBz3+MnyqWKRfz+vHl02eFckcZdsD5EdRDdx2UcF7rFx7cANBocxFjBlFPgVMyuDxVm57/Ji2WGu0yU8EDDqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918340; c=relaxed/simple;
	bh=mtwsqA8PakWZMH413YQKjvGljPxyyNqwwyQFCNzvbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiZaURXFRK0UVPkDwQthTin/IAyqC3KIaFiwzBk92ygKvXT5FQK+drW/yTI3f0GsHKvUbXzGdTjSuXErVq2oEPIEIvFu+dP79P4m3kTXrM9FXXw8rYiotizkh1GRBwqnoK/Y+QLsCh59X8yYpMtEFMWraNUfh1W8JnsA4K8U/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrlJkonk; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-549967c72bcso6710609e87.3;
        Tue, 25 Mar 2025 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742918337; x=1743523137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxXlB3Q2YL2Ilad6LW0JN/V9aTo4Xt5BBRqQjvL+Sk4=;
        b=QrlJkonkl/DwPcnC8t2hLA7IUZQTtP9zaDUYDKctoNnXl4d+idNxbPtzfoaPGeE0ta
         T+cz+yFFi2uDiQhWDUWXXDJeHKvcI+QaRoeIVWHrddxqJuY+rLtwiHnkQ5EUm8NAzdL7
         mf1gXXVqyblcctUpg3/KQB/kCXpOvLhXBUwqYEnJCmXSutztnEjT+Uf6Vrd8YX1/zOww
         J/DH2eGxXfI3tf4OOBH/xtuTSo741fvxvK1ywEtcMDo13x0tmKHcigHyeMKRgjZAcTJV
         KDGZO1euHRs7zCXdgwOeTiYwwrDDqt7fvB3KkG4uokDSa56CdBliZXOHnG1OzjfG6vAv
         1ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918337; x=1743523137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxXlB3Q2YL2Ilad6LW0JN/V9aTo4Xt5BBRqQjvL+Sk4=;
        b=kswIFEPWk31bPhLbPd3bsrGEvrUu7kQYkIp76GAkREF6VHSWdnd8DtwuErbGXTOFdY
         IQep1f7bvcyRCASJsyaFjGWb/LbxBdmAh86kwXCEzf+orwBNKdfu7f9e+rQDZQvFYyKF
         L7LTjTk++8xrjw7dO21z2NJtEezVhVWmZb1d+9v+C9yXSNjrEk99zT12v/EAi+T8NzZh
         on336NAlX7rG4Nvmm1xVWMwaCixamIcwNbx5JiBCHhZd9MXL9YiLukcMIPLqvxhtE2zr
         ZXFfrxxkFZ3t+Hrl1InHetdSqRNFAxrLidKLfyHjEEqMjh/pc7TBRtFtzryGLT+g93yV
         dLmw==
X-Forwarded-Encrypted: i=1; AJvYcCUcbwPjNWPmFH8/Mhr9dwi4lAF0znMZ4FTeG99bKPZIEtA2DRDmnMFcwEcpiTaMnLJJdiPJQooAn91t@vger.kernel.org, AJvYcCXSHAd3QiJtQ6wYj7kQofG2ba1wUXNcRx3AwT/mTXUAir641qD/b/JZWXXn7pZaaodvVowPUP6wBFHdYQjm@vger.kernel.org
X-Gm-Message-State: AOJu0YytQxTqaIaoazk/5AsgddLFfEQw+hYeRwF73IP+cwx461EZQ+hK
	+1nEXJqgdiVUR18EHmuIIAdOVxeqGjaffF+MvPTX9pyPhEb5H4u5
X-Gm-Gg: ASbGncvxTqnwPHBQcymoAWtP85jDfRQ3C/DIoiwieyvwvmCqpWplqHAuv7jtWT3fv5e
	A5iZKSfrquJyzWFEEo3RYFRDWoOSq/kxihXCw3J3QU126dZopsizfwDMo4AJ6RVHZvD+nX3zNl6
	NpNjt2NocXxqU8/s0eRc/GpA7ozu+U8S0cu10XSAkU4+QTvIwLn8Zs26cgrgjM5Bxw0w0bXMfAs
	CQuSps3dBpDMEkidiLu2Uw72QchtugSyH1eCGAePiMggUyF8qW6QTV2c/M6HlH5n6Z4ZxFChm26
	uzoBBkag2AxWHSWI5nAZQoE/A9MqdeyXGDuh8Sn6ibo5jajK10i8UEgMLA==
X-Google-Smtp-Source: AGHT+IHrbmRJ4XKU9ftZ0EjXOQDmgfR01iKjUAzH+4vTrN7X920Ls+acQM0brH8Yhs+E5/llV1y8wA==
X-Received: by 2002:a05:6512:3e23:b0:545:22ec:8b6c with SMTP id 2adb3069b0e04-54ad64b311cmr6540631e87.35.1742918336460;
        Tue, 25 Mar 2025 08:58:56 -0700 (PDT)
Received: from pilotmaintrash.lan ([178.34.180.83])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646cedfsm1544573e87.2.2025.03.25.08.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:58:56 -0700 (PDT)
From: Alexander Baransky <sanyapilot496@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Alexander Baransky <sanyapilot496@gmail.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add Visionox G2647FB105 panel support
Date: Tue, 25 Mar 2025 18:57:47 +0300
Message-ID: <20250325155756.703907-1-sanyapilot496@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Visionox G2647FB105 panel, used in:
- Xiaomi Mi Note 10 / CC9 Pro (sm7150-xiaomi-tucana)
- Xiaomi Mi Note 10 Lite (sm7150-xiaomi-toco)

Testing has been done by me on sm7150-xiaomi-tucana. According to the
downstream DTS, this driver should be fully compatible with the
sm7150-xiaomi-toco (unfortunately not tested) without requiring any
modifications.

Signed-off-by: Alexander Baransky <sanyapilot496@gmail.com>

Alexander Baransky (2):
  dt-bindings: display: panel: Add Visionox G2647FB105
  drm/panel: Add Visionox G2647FB105 panel driver

 .../display/panel/visionox,g2647fb105.yaml    |  79 +++++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-visionox-g2647fb105.c | 277 ++++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-visionox-g2647fb105.c

-- 
2.49.0


