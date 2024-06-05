Return-Path: <linux-kernel+bounces-202604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3018FCE8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2FD1C24E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7554B194A48;
	Wed,  5 Jun 2024 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jjCKtKic"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA514D447
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590462; cv=none; b=fkWn2xqHQ54zHxL40lHlgeyYzVPL2o8ULT4e5vYN0iruj3IB7bV2t7PtfQddwFlta26HrzSmXCHQp40gHx/IWfn1+T5pB1P9OOs6+QnZ7f/6hIZcaJt8pYB88mWr9NdhilOy6mZQ7WqOLQtPJ/HApK4MLZHshfemznHkrQz0LJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590462; c=relaxed/simple;
	bh=ye7thy+/3m6Zqj7SbdLqlPoBsKgCZO4q82/NkiqrCwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJ+RApxM4E39FFRr8VOBfqvPPVsnEa1mgrOleiTXzJWthHX5pmpcw7OPg9AysfY//zphlknQ4PQYiNdzrQDQ0yvNjbRIiJFPaGa5LNe0EzClUu/QDyzsouWdLcGjW2i5/3wieTeVjMWRVloo/KRwg9wiyQjt35R2DihZ8mG+4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jjCKtKic; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35e83828738so1053704f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717590459; x=1718195259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJu4ZVYDYjYu/Y+oCiKT9LoXMtfjh5wGjAB/2kqB2wk=;
        b=jjCKtKic/idn1muC/jKl8JIbZ7/6yTzjKXxFwMRBbRwOH5iveQF/+sTAI45Sh6iynp
         36VUi/Cb90sNKPNEuTuvm0irMOqbpVJVOeo8HeoQsfS0fV4ZS3dDzEiG7ZfhEAvjxFd4
         e6MkVU8X3PIVCAIIij9bNeb0b5/a8pGWeDhScqBcpFMy3APClxrnZvjdt5jDKKM4+he+
         tx64CX8EIZ1b2yLgFrRK7Voz+7uNkuExAWBrzRtBCQtII4aiRy2mQYyZKEk4eNGi/lcv
         5QI5+8Y+cs8W+iSDtn4sHHdDYpo72Ohhv9LmMMfws0tpPyaKdyH8kUCxSgdOQEJBXCsp
         Rgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717590459; x=1718195259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJu4ZVYDYjYu/Y+oCiKT9LoXMtfjh5wGjAB/2kqB2wk=;
        b=bdwtHYhRx8pzJrIptSfCAcRQEfPy04kmdbWo6O73TWkrO2crRZ7LDNDJ4Is5sO3GHs
         gq7acMLiKIwd2J3HuLwnm/iAz9OI24NWCkZXw/ghRVZB+QT34E3e3lxeeB/1uUqc/iQb
         Ie+stgDa6qIKF+ZVz+1ss/qvRM1yfkA1eehiMY9AwUwbCcHhNeOYCpE/Yt5p3hh7ER1A
         Wbn3p4GZAEjoepDrWQfLXu9u8rqhCYSdD/idiNpXcrav/D4uaG4Pm6fScqPuCXffclMo
         1l4AwxXgs8IX1TRiuU1QwhGXr6JKIfnnCBLqeHfolYHDfCF2fCiFkxxdzWNg99xRUUAs
         OkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9gHgH9utg/decoQ54LRrFwbkn03NpmKLbY/TWCm1YU8l5mKKt3kG+cMHLpgU8oE59RwLZariyszRN2Zu878alPsP6Ub1/jGbkxorM
X-Gm-Message-State: AOJu0Yy5+wBvw80oidyqnVdRh4ZVqJv42mymasRi7ZA7FFIvMlW2CEPn
	c2fGYDAMmacfRLWNEKuUl2O5gj0WfrrJb/jvI+IjCm/7xmmPtSgPXhUOdDfQCpA=
X-Google-Smtp-Source: AGHT+IFVJVUC13ysU+7mF23cQ0ytETMFziGqtuOyTgLfDsFL1z1ZE0h27PO06RkLagYGFk1T/JjCig==
X-Received: by 2002:a5d:610f:0:b0:35d:bdb4:f623 with SMTP id ffacd0b85a97d-35e8406782emr1861012f8f.23.1717590459187;
        Wed, 05 Jun 2024 05:27:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cac3esm14383619f8f.39.2024.06.05.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:27:38 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/4] arm64: dts: qcom: add WiFi modules for several platforms
Date: Wed,  5 Jun 2024 14:27:25 +0200
Message-ID: <20240605122729.24283-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi!

Here are the DTS changes for several Qualcomm boards from the
power-sequencing series. To keep the cover-letter short, I won't repeat
all the details, they can be found in the cover-letter for v8. Please
consider picking them up into the Qualcomm tree. They have all been
thorougly tested with the pwrseq series.

Changelog:

Since v8:
- split the DTS patches out into their own series
- Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c@linaro.org

Since v7:
- added DTS changes for sm8650-hdk
- added circular dependency detection for pwrseq units
- fixed a KASAN reported use-after-free error in remove path
- improve Kconfig descriptions
- fix typos in bindings and Kconfig
- fixed issues reported by smatch
- fix the unbind path in PCI pwrctl
- lots of minor improvements to the pwrseq core

Since v6:
- kernel doc fixes
- drop myself from the DT bindings maintainers list for ath12k
- wait until the PCI bridge device is fully added before creating the
  PCI pwrctl platform devices for its sub-nodes, otherwise we may see
  sysfs and procfs attribute failures (due to duplication, we're
  basically trying to probe the same device twice at the same time)
- I kept the regulators for QCA6390's ath11k as required as they only
  apply to this specific Qualcomm package

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (3):
  arm64: dts: qcom: sm8550-qrd: add the Wifi node
  arm64: dts: qcom: sm8650-qrd: add the Wifi node
  arm64: dts: qcom: qrb5165-rb5: add the Wifi node

Neil Armstrong (1):
  arm64: dts: qcom: sm8650-hdk: add the Wifi node

 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 103 ++++++++++++++++++++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi     |   2 +-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts  |  97 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi     |   2 +-
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts  |  89 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts  |  89 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi     |   2 +-
 7 files changed, 370 insertions(+), 14 deletions(-)

-- 
2.40.1


