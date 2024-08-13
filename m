Return-Path: <linux-kernel+bounces-285384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0309950CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29991C23133
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A731A4F0A;
	Tue, 13 Aug 2024 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FEPZD3Mp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC519D8AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576007; cv=none; b=axLb8r//enI7i/lcoC2OxLNf2CzQJjSgrvfOwC01Uc/4Swrt4+8Ih2YAnzZQ3sFFhFdo2vy16KrIsykrG31Z6VNKR6IpufnR/e2wHTZ3Af6c9EYfWDRJKbf4gH3BDGmxreiX5hN5QXzC3fFOeZWpRpYNCpvMp3sMYLsD6hc30Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576007; c=relaxed/simple;
	bh=TSEwgRwPIrPMBiArN2FuAsHrjp4n5h9ROyQjarPhdBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rn+pKvyO2xebtTSF3bdNwcRkMOppDwEZrCyhXHCtL72zfYQjFE+lgbkihr0AJtqO43xi/EkVOn2CyQ9pRmNFrt+vf4fLG84X2Z6NDW3hF5jOs0wUf+FPoTfhOR5vlCsd3FCt7JIc7s76Tql28ZSdHPXxA1GHKvDb8o1bcfjTgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FEPZD3Mp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3687fd09251so3235514f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576005; x=1724180805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=twlzRsxhGxt1Uh2mIjQirdrkh40+b4DDoB6rlCNtUik=;
        b=FEPZD3MpodLBk8luCtL4WBDHWo/c6lKbah01Ey2cYASgv5YtA0IwtC04PObhTgUqOa
         F387JOaJBQsnxzKN10b+1o4CfIeqp993D1OrhG86HuW3aIOiGRp8L1KPMfB1x5eUEirS
         DGEwfzJTDDRlvrEXCkmNkrNwnP9HDAv2eT+bySzHtP+Yucm/OvuULytiKuMDxcB7NO8v
         CG0Yn54keiGGnmJx2IrnqJVRLRMfFh2m2O4EOcqn2Jko0c2jO4UtUf69tdmWqW1pKn6t
         pOw79hMxi8HEUaoqAwEGoyNOPyVCFd2f79Hb9JA2YtrT8lgM3aOW480+0A6M0nfYKTSV
         84Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576005; x=1724180805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twlzRsxhGxt1Uh2mIjQirdrkh40+b4DDoB6rlCNtUik=;
        b=gwQjKQ+ismCIUIeq2T4b0DGXZ5EjMrmAHv1pVuTRwX3yj0uVVayy47RNZhOSnw4hug
         PrnxDhLTpdG3EoO2/fpq+o6KkYLNxga5/WOskzzdOaYerFIkVnYbbpGrmKTSh6FZJd4c
         4ee/yYxxO7k4IUZb1XzvTXa/aL29cY//f0161m8q/3WtXMrsXsabCFBiUFwmRaHw1Zjy
         GGA29VAv+1ZuLgP3zF073BmPC533muKIxjwK4em2cPnqkdqB05nfnsg33pf6aDBqAVF8
         nwA1reTXordHlqT4sVCWmFi3DQV9rmIUOQ/tdQ/GEl7MUbH8xx5Y9yr+tlUzmVQLKcvp
         Jqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUPvQQHrDDLL+9TSuDLtuv+utiZrmQdbIrCblcAkOTRtxphUZri7embwSXKfjAls/b6SPHmBCuFgg+6IBm19CiUBhenIU3aV8JQmj+i
X-Gm-Message-State: AOJu0Yx7mx28kU7aTtu6riL2EWWDNceKz1/7E02SByXqY4N52rdKLRKU
	Xz+I3Skhfw2e/xzII6mVXnRSJKxxwkwBDdPgxc9tlGCBcIbigMujffBiWP+1Zxs=
X-Google-Smtp-Source: AGHT+IGY7TCbUZP6jI0dAeG/YaIQcd1t/YiOug8W60mEYlLwrh7VrBXq5Zdhas/JQLtrOnmTUROyTw==
X-Received: by 2002:adf:e98f:0:b0:368:5b2f:67b5 with SMTP id ffacd0b85a97d-37177764830mr479002f8f.20.1723576004639;
        Tue, 13 Aug 2024 12:06:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c93708asm11119358f8f.29.2024.08.13.12.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:06:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sc8280xp: enable WLAN and Bluetooth
Date: Tue, 13 Aug 2024 21:06:35 +0200
Message-ID: <20240813190639.154983-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This enables WLAN and Bluetooth on two boards using the sc8280xp SoC.
For the sc8280xp-crd we add the PMU, wifi and bluetooth nodes with the
correctly modelled wiring between them. For the X13s, we rework existing
nodes so that they align with the new DT bindings contract.

Bartosz Golaszewski (2):
  arm64: dts: qcom: sc8280xp-crd: enable bluetooth
  arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn6855

Konrad Dybcio (1):
  arm64: dts: qcom: sc8280xp-crd: enable wifi

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 169 ++++++++++++++++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  98 ++++++++--
 2 files changed, 255 insertions(+), 12 deletions(-)

-- 
2.43.0


