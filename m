Return-Path: <linux-kernel+bounces-526800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B6A40378
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D0C7027CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3821FE46B;
	Fri, 21 Feb 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZtL8cRR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCC200BAA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180685; cv=none; b=R4aitJjMad9PFgvZi19awsrC2LDLihiNChRbQ3H79U9pHRB5mFYMlxd3RtqcbJLGfg17WMuqyx8xd76QCgFx4rfhm0PtH1JtMJqhmLHo4gp8k4sU+XPmzdKPwNudio6ip3cJitq/UQ3dt7vvefkS5xx8cglV1OrL+SiH2Fbf480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180685; c=relaxed/simple;
	bh=f51eqVy7xwWHEuczDtwNNkEGNpGXp5mse0YoxqxxuSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvm9Ur1SeeTMVgUA6riAL9iCGYjyx6zKBR3g1bg72bwSLRb8AXKY1wrRY6kAFPoVdzeRIz/2GybJw/kMR8THcBM2y8gvRdHlXaednRX9cK9q96sTXCiVCnlCnxRBsGXB9U586ePO5Cqh3Rykj5CKZqsvTLmVUbUDqcltMW9JsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RZtL8cRR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221206dbd7eso56434575ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180683; x=1740785483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81FA3e/JZjjDAMLf5iojUcA5/pLMU3O5i7ad+AEyuhI=;
        b=RZtL8cRRevN4bA/z4199K3c/ybJuHlTdFkv3Owb9C4PomGVsLNBL2j8Sgdbf403ZeT
         ZC2GtdKsvFGGbMiApOG5lwfkWvbSOOEWrKAyRKWAfUssSfmUorrN8xxFQ0JuSACY9CAP
         QSXFJPyF7CAj3SdSefLZbnyM2v10dz4qXBrpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180683; x=1740785483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81FA3e/JZjjDAMLf5iojUcA5/pLMU3O5i7ad+AEyuhI=;
        b=rp/iiWNYuhiOx3t2P0BHCcNxKkHGaQpMS+qed2BF393eiv+HEcyQxXzjxI3kON27tf
         xyWN1TtwFhgDiz/9BX13MfQmnnXR5NiVhqa0zGZvK+6vRVJOx/+9+LxmTN05MM5Qzy1f
         55x+rxIxP427pa2Ilvn+gNqc/g2TkKhcSFIgnncuA2pZami6LDmahA32JShHFhI2xJF0
         WzWnmmkfpoxTbr17ZKNYeh3FM7Bf7vXIdsKk3v9nJbD0Oupyyg3MVtPkJG4f18rahFQ4
         WRtON4UTdlPsUwg45w+uyTIpV/8lcQyt9gcuYbsIgZP/QnHuIQla2GpSRhI/wYWVIvae
         NuWA==
X-Gm-Message-State: AOJu0YyHODDXyyW+7rEoKpqQIuh38pSZh+7JbztZLkIYAYTDRNAgGieS
	vxszq5WAqfTkL61xkHabZoOjJlphInzJQXgwV1d2WwtEaB/Jem0brwiDBWidIFUuz+Vx7ZSIluY
	=
X-Gm-Gg: ASbGncsxBe9PRekTvV/z/cDTkOOqktQnokFGUJCOJke8g9yeNWzTXnutsZMGz5mc72f
	jPZp13L1A151HttFxEjf03AWtuqhCh7c/iL6gORTN4WXDS1TDkaqn3sKprqYQMwL5qIPRsGzpwe
	bfwBaKIUKJbETdZxP9KMgNp8T3yznqA5BPIkdlWHAbCfvZr0bB+2UAgTb8NprcRAOrBq/spJS7G
	Yltm7CTwPYpSLmbG69AskiDUeY+TFgHjjiwvN0e2hY/rtW659fNiIr7j1KvD1gSOuBI7Vpd1CZz
	zPj/zSnVMEStKMTVZsgXN7cBhG06i92Z/S19vXxMlxqwCRBnTI2w+3bvgSRg8ZL8VA==
X-Google-Smtp-Source: AGHT+IGkH7xMxeGNr82l2STxZJtAA8Gv2n4NyOTr4CeAZCvwgPvVhf6sJzdIj4GQWhVoUq34JljyhA==
X-Received: by 2002:a17:902:ce8a:b0:216:760c:3879 with SMTP id d9443c01a7336-2219ffc00c1mr74674785ad.46.1740180683043;
        Fri, 21 Feb 2025 15:31:23 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com. [34.125.246.222])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2210001ea01sm113953455ad.176.2025.02.21.15.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:31:21 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Pin-yen Lin <treapking@chromium.org>,
	cros-qcom-dts-watchers@chromium.org
Subject: [PATCH v4 0/2] arm64: dts: qcom: sc7180-trogdor: Wire up USB
Date: Fri, 21 Feb 2025 15:31:13 -0800
Message-ID: <20250221233120.3596158-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wiring up the USB hub to the connectors allows us to gain the proper
'connect_type' and 'removable' values in sysfs for the USB devices on
sc7180 trogdor devices. These two patches are split off of a larger
series[1] so they can land faster and because we've come to the
conclusion that the DisplayPort path is going to connect to the
cros-ec-typec node, not the usb-c-connector node.

The first patch adds the pogo pin binding to describe the detachable
keyboards found on some trogdor devices (actually strongbad). The second
patch is the dts changes required to wire up all the USB stuff. This is
sufficient to set the sysfs properties for USB devices so that the
builtin USB webcam is considered "fixed" or hard-wired while devices
plugged into the connectors or the keyboard are considered "removable"
or hotpluggable.

Changes from v3 https://lore.kernel.org/r/20250210225714.1073618-1-swboyd@chromium.org
 * Consistent quotes in binding
 * Drop unused labels on hub ports

Changes from v2 https://lore.kernel.org/r/20250205233016.1600517-1-swboyd@chromium.org
 * Make binding specific to keyboard and move to usb/
 * Update dts to reflect new compatible string for pogo pin keyboard

Changes from v1 https://lore.kernel.org/r/20240210070934.2549994-1-swboyd@chromium.org
 * Split out of larger series
 * Added description to DT binding
 * Removed DP part of dts changes

[1] https://lore.kernel.org/r/20240210070934.2549994-1-swboyd@chromium.org

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: <cros-qcom-dts-watchers@chromium.org>

Stephen Boyd (2):
  dt-bindings: usb: Add binding for ChromeOS Pogo pin keyboard connector
  arm64: dts: qcom: sc7180-trogdor: Wire up USB to usb-c-connectors

 .../usb/google,usb-pogo-keyboard.yaml         |  68 +++++++++++
 .../dts/qcom/sc7180-trogdor-clamshell.dtsi    |  21 ++++
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  47 ++++++++
 .../dts/qcom/sc7180-trogdor-detachable.dtsi   |  15 +++
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  47 ++++++++
 .../dts/qcom/sc7180-trogdor-kingoftown.dts    |  55 +++++++++
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  55 +++++++++
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |  55 +++++++++
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  44 +++++++
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |  31 +++++
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  56 ++++++++-
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  47 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 109 ++++++++++++++++++
 13 files changed, 648 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/google,usb-pogo-keyboard.yaml


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
https://chromeos.dev


