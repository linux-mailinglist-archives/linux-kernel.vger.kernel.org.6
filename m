Return-Path: <linux-kernel+bounces-343779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71061989F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322A2283990
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B3180A80;
	Mon, 30 Sep 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EIvu0EJU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45005336E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692252; cv=none; b=YaAx/Un5DuCLOA6SbhoQwYLAn9ToLQ0rPgSY18at+gWbnKwL/1kMeHlwte3jcTBcu10KBH2ORS94qtinC8oIIbqJFa3sTgCmBN7PJoJF6D9ZvrHBOpmxuVYLcIb+wz7OhO8p7ap0xBMbHdyrYLMXhZqcUwV/pmBXczFC+uMAuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692252; c=relaxed/simple;
	bh=gdf8DnKizK3i3keOQASM5b9xgFXc7/ucEC6E9G2n2FM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQHnXDLYhC047fl9espspXqibsMa8l2TBGnG43OmJ7JY/cKn62p1Z106L9+q2vumO359lxwH5WArXRgmdJbxY2DtLdmbzPOekqBt08DjAD5VLP6DN8i2yuK36JkgYqd6t236ax+BXz/0qDll9/3iccMEfQr/QlaIJG7jD2Qesok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EIvu0EJU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37cc9aeb01dso2301300f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727692249; x=1728297049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu61EUWpiyAOYTeN6pZh+c4oIirG0bVHbvANbpIgvcs=;
        b=EIvu0EJUFFLtC4vhKvJOHs1/pY6Kd8OvluugfPTTHXHc09FBSq1GH1lZYYTvVQ1yeD
         k6Av2r1hX0IDXGYJbmUmezDxHiQEa30EGjVnoi0AA/uFNCBYftUVSxoH8jYic5Vn1y0s
         Hv7QWHPun9422lEcH1C1tyhGgY0i0GDSfekRKNmjS059TLS1S1oryj0BXcZ2mXKSXmRa
         wxJaUdSv5P6hXDF6+q+f0wqDUiFuZ5y0Qpgwv1GJdvwxxyTm2ODtYarrKNZkcnlZD7XG
         2XQDvwovQmrT96o49vC9pciM1ykZMzEg0FlyMLQWuYIpEYsT0DW0dOYYmUE1kfe5zzZb
         sbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692249; x=1728297049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wu61EUWpiyAOYTeN6pZh+c4oIirG0bVHbvANbpIgvcs=;
        b=Hhf+ZZ9+4jAEqQPZdJpQmbt9yozoJ2rFn3UcRd6cn0SbjSy4+T2/DK1hmWosL4GTjS
         9zV0sAXy3FWPTYhiT618H9pEQK/18EhuUomNsa0l3I4VCvGm2y0T9Fwo4H4r3z91yFcj
         saUR3YLUtTrc1noUemJwn9WXCAfAMBmiNDPVCJRrJy5REL8csGOGBDnmfiXhjiENcD85
         I0CDNZQJzDnFMfVdOV3+cWE03x/GT+wu3BitRzEKp2lKMSO96DIgoCXLd1mzVUaUoQUI
         8UNLSdTVF9FLO8yuzDJ2iRWNLmfkgamVe62EwwGZNqr4zkhIRKOjbJnBVBUDS87njbnh
         88YA==
X-Forwarded-Encrypted: i=1; AJvYcCUjfDu9QcQlTf3cxmz2oUyADl6ik/f5UvjTb8wzliS6TXtjJCBDEDBYfEn8Osm0Vhme7cWetFE24zZihPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JJmNaAAbzh5Ywdz0B6Lu1/FGa0L0AePDlx97J68OSTThgJoO
	MgLjnjT3UniNXglPjBn3d9vEn3kmwgtWs18iJRpSZQUvpfTZjqTsS18jFNbYTHU=
X-Google-Smtp-Source: AGHT+IEO6hNwxWynJqFi+Z/MefDokOBn4BXSQtP7VzFMLO+01Cav4kBQEJ6CUlg9dgf5qzvWhNUp9g==
X-Received: by 2002:a5d:60ca:0:b0:37c:ccb1:e92c with SMTP id ffacd0b85a97d-37cd5a873b9mr6164365f8f.13.1727692248804;
        Mon, 30 Sep 2024 03:30:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd55a5414sm8835051f8f.0.2024.09.30.03.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:30:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 0/3] arm64: dts: qcom: sc8280xp: enable WLAN and Bluetooth
Date: Mon, 30 Sep 2024 12:30:36 +0200
Message-ID: <20240930103041.49229-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This correctly models the WLAN and Bluetooth modules on two boards using
the sc8280xp SoC. For the sc8280xp-crd we add the PMU, wifi and bluetooth
nodes with the correctly modelled wiring between them. For the X13s, we
rework existing nodes so that they align with the new DT bindings
contract.

v3 -> v4:
- bind bluetooth pins on X13s in patch 3/3
- only drop the regulator-always-on properties for vreg_s11b and vreg_s12b
  and fold this change into patch 3/3

v2 -> v3:
- move adding the bt-enable-gpios to the PMU on the CRD to patch 2/4
- add a patch removing the regulator-always-on property from regulators
  on X13s that no longer need it

v1 -> v2:
- fix commit message in patch 1/3
- drop drive-strength from the wlan enable pin function
- drop the calibration variant property from the wifi node of the CRD

Bartosz Golaszewski (2):
  arm64: dts: qcom: sc8280xp-crd: enable bluetooth
  arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn6855

Konrad Dybcio (1):
  arm64: dts: qcom: sc8280xp-crd: model the PMU of the on-board wcn6855

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 168 ++++++++++++++++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 100 +++++++++--
 2 files changed, 254 insertions(+), 14 deletions(-)

-- 
2.30.2


