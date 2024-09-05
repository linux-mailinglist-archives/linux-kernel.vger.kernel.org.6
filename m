Return-Path: <linux-kernel+bounces-317013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BDC96D840
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6371C23558
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE5F19D897;
	Thu,  5 Sep 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xTMDpbog"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CA19CCFB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538836; cv=none; b=iivnDCE67saHzGcM7XJxOK5TDubQA92j2MJ/en7LJkfVmiTCXbs/sfP0QKSCKcBfP0T2jVSFPXEEw37S+mHSL852RUtPeNkfJ2Wv9BqIA1X/IyhXI8t/BQYWUUikP1iJlzkwlKg8n4jHPhYngv4zZDOyGYRVTnJGo+exzLVfkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538836; c=relaxed/simple;
	bh=wgPIt3oGdrglQsk/daLP2PXTGy6JQOLFPbVxXj7RBJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVFr3Gqt+GUExoK2iXJ4/PeJGliYxdTxEH5CfraOXWLf4XYyi9mUUxrEhU+58ukJ8IzAr0C5kHMvnFY05QymJMCF4frw+RgavPqnlZVfildeLM+0RL6xTsLB75XVndCeFpODsftmSBpu8VXDioAnQ9rWI9JqklsslaMCP8oYCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xTMDpbog; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so390345f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725538833; x=1726143633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJMeF4U9u7YFDaBD7BHv/n2JoSc/K4mKc8ggBuLK6mo=;
        b=xTMDpbognhU+uDEkahaaOs2uhEMgWz2ePbbzArYLAd/AFd/OsymkmD614FY4vrAB2m
         zrpe6RRCLyhcFjlOoIAKnFlkr/8i/E19z7i6IfFl9cCRdojRlzmXTPlMzV4FXhqkkWvU
         LrSloob7YJr+sVSmFdwyBjPkZyZ7dogkioAUPeu+2naLkMmxFLd7QbqwV9qxFsOtjLK8
         hkSY5+srm5wO4WZ/c+srX3qP9DWNDGpsAFyEhWpK6C53TmOxJ0FOrBsqqRKm50vVmRZ6
         XHWu+nEa1GgEcF1ZQLRYMFAXCK5+1ewOCImA7rw0oemPVfOUF9ZrDBYQ/crMUJQ/uBkU
         WTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538833; x=1726143633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJMeF4U9u7YFDaBD7BHv/n2JoSc/K4mKc8ggBuLK6mo=;
        b=lGZrFAZ63R/BxClCeiJmb54GlZqQTE8ihVo+yp1QchyBhdCQjPBsxm1kImI5GfhKBp
         5WPS2+1MIJcQtWw+Db9l74yWQWKusgAWZeNFC8zs1+25J17Jt7Cp3O6dsL/z0mminw6Z
         siaCrWgZ3fpVnlp/py7Ktw7a2Z9BUnuTePMkkdWY954Z9S1aZbfvwcKX7omU8KsWyPSU
         WOX1Eiphz/99Di47Hq7W6fXekSreszaqvh/mngismiVe9qv/t/YpUTbj9jeSBJHSjAYz
         7hFCPcEKsghMC6jRZ03Jrahx+UfxXfZ5YY3biIqEiHeVuIvAGkjO7JsMnIgTAe7lF0yU
         jzeg==
X-Forwarded-Encrypted: i=1; AJvYcCU4A+3C1xdyG4iavOStOhp558RizXGjXrflmOjM4cpaaJEelZUmmHobYb18M3IEgGyaBqDuvi4HazyXHK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHajBw/lH/gvSGNl//CPCjzz5aOBp8aNGtzo3qRbiNwP33NuCB
	p/i6fF2qZJlHoPL+622dIvByIKQ4tNC4lZ/mOG7H8tiUdICcgdtcV3N2xa0YvwQ=
X-Google-Smtp-Source: AGHT+IFHmZDgUdG+ADx2aORV2a25XvnOq5NG5z5POfIwe6FUwmE75PwdrXAL8FzvGg8Clzsuhd/GJg==
X-Received: by 2002:a5d:6610:0:b0:35f:122e:bd8c with SMTP id ffacd0b85a97d-374ecc8f18fmr6982442f8f.17.1725538832026;
        Thu, 05 Sep 2024 05:20:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:cbe4:ce99:cb33:eb1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374be2edf08sm14645764f8f.6.2024.09.05.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/4] arm64: dts: qcom: sc8280xp: enable WLAN and Bluetooth
Date: Thu,  5 Sep 2024 14:20:18 +0200
Message-ID: <20240905122023.47251-1-brgl@bgdev.pl>
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

v2 -> v3:
- move adding the bt-enable-gpios to the PMU on the CRD to patch 2/4
- add a patch removing the regulator-always-on property from regulators
  on X13s that no longer need it

v1 -> v2:
- fix commit message in patch 1/3
- drop drive-strength from the wlan enable pin function
- drop the calibration variant property from the wifi node of the CRD

Bartosz Golaszewski (3):
  arm64: dts: qcom: sc8280xp-crd: enable bluetooth
  arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn6855
  arm64: dts: qcom: sc8280xp-x13s: keep less regulators always-on

Konrad Dybcio (1):
  arm64: dts: qcom: sc8280xp-crd: model the PMU of the on-board wcn6855

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 166 ++++++++++++++++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 102 +++++++++--
 2 files changed, 252 insertions(+), 16 deletions(-)

-- 
2.43.0


