Return-Path: <linux-kernel+bounces-232232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C276191A582
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3263CB21FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBEE14E2CF;
	Thu, 27 Jun 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FicONVYf"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7CD13F441
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488547; cv=none; b=dTrA/uAo2h3Koj3WDpsKyPIQAvm3+4l0l9U1Lgo0mc7CzM/xeXBNt/s+tLT+i79uCfbZiS8nyKHO3JQT00CQXr07LPRVQuF0oee5XJ9F9kj6IkwioL/kpgXNpYg+ebUC9XohTpYQS7t5ae7D5WkvIqK3VzRrWUTg816xfFAbChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488547; c=relaxed/simple;
	bh=NHca19c/l4kAA3IjwkGK6+rAojDFVkD/A5ds19ZX/fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DItqmDJXL4na0OdkVxC5RlUj1TKnTrbwJBVEzx1IyTbQUbGm2Jvxk6hfqB7YleufVuwo5bK2712t1FfFgfe0Pw4RsjbA2bA6RORMDzniEnsicbWbBgqtzxQbnOvg/YMvd515sTJqx2jJkJ94VGim1xYhhtgO6AcmYuGOs2Ff02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FicONVYf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-363826fbcdeso5692879f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719488543; x=1720093343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kXXfXEFDzUC64T17Ry+QFiathD8Dc3ObuiaeMGthVI=;
        b=FicONVYfaWxls0Y4kVHl9m6c0e0TV558K8xRKvx97HqDc4zgw326iXjMvPY7R1x368
         4rsuphylhbwO8uiFty2SM0ps68tD5wRcxDdiHH8GXFFFZp+62XyLlju5FoGzG1n2v+Wy
         kNe509sPZXpnIkowWTPxxRX0tgOy+cewpPZIy6Tz0c9HQRVLt9/0vBIkmLvEAwaFxg8r
         cKVkuqbJvlr3hIa214tc5Mt7JBshRGvpe2rL7ykemiV4S8Vc4eJZk4EqLWzHgtjViMrF
         XUpoDbRNS0jIoy8gkFLu+wKt74/AXK4POteyy+UVhFX1WsIU5j6tnHke8Yy79n9wfq/o
         HkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719488543; x=1720093343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kXXfXEFDzUC64T17Ry+QFiathD8Dc3ObuiaeMGthVI=;
        b=wtYTiOk7ItXcISpOM2cFo00Z+uEDvYfYme3ir32wG7sWt5FM2JC5QMbLPVQBoZUkgF
         oeNVwrfKx/VrVeZsEj9albcI10G63966rUdOWWcgMapLRKaPFnR5iyCtjV3VoBmbAKi6
         cox0GpdEV1ehx4DuJxLtwFitSFeqJWLSFgqKylx1VDTp/KYN7T2UkJ18+ozH7hgW6txp
         SMMRlfitu1DEMu4Y93sk6xlxLPGjxf1e6AzK8l83hbzOVvsZ8uZ1sAtV60CtBQtfgKgG
         XY6d/VAvNglsnXbf582OAUY4ZcG/tcKhgJYVsxMpTNvfZHYDKu+MVaBxUOpVfkTk+TtN
         2fFA==
X-Forwarded-Encrypted: i=1; AJvYcCXoDiT6Ulocsd9UsOIL2kMGbI7VBoKNoqiuVPqv4IPvMsxjPzIQtKVarVoQI+hJRBOFf3+kecDsKzEKknN35xYTbEViHbf94sDh/D+w
X-Gm-Message-State: AOJu0Yy8XprDrlpNMwFs4oS+dAdOrcfMWKDYkN9+K61ZSLR+RvRhjl1W
	VwbFKMiRCWG5woDOx3GUeT9OqndzLnCCjPh85eOuoDdYsAGmfmiSyamHIg6ILlc=
X-Google-Smtp-Source: AGHT+IHoxJdWlrADArRdG8DgzgAL9SZ6fx2OLKkXTk/rwvrre1ojW9RJIRkT5DyqzJfpREwn7bCXqg==
X-Received: by 2002:a5d:694c:0:b0:366:f323:f59b with SMTP id ffacd0b85a97d-366f323f70fmr6752481f8f.1.1719488542663;
        Thu, 27 Jun 2024 04:42:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743585276sm1554749f8f.62.2024.06.27.04.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:42:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/3] arm64: dts: qcom: sa8775p-ride: support both board variants
Date: Thu, 27 Jun 2024 13:42:09 +0200
Message-ID: <20240627114212.25400-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Split the current .dts into two: the existing one keeps the name and
supports revision 2 of the board while patch 2 adds a .dts for revision 3.

Changes since v2:
- use correct phy-mode for Rev3

Changes since v1:
- add a new compatible for Rev3

Bartosz Golaszewski (3):
  dt-bindings: arm: qcom: add sa8775p-ride Rev 3
  arm64: dts: qcom: move common parts for sa8775p-ride variants into a
    .dtsi
  arm64: dts: qcom: sa8775p-ride-r3: add new board file

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts  |  47 +
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     | 836 +-----------------
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi    | 814 +++++++++++++++++
 5 files changed, 885 insertions(+), 814 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi

-- 
2.43.0


