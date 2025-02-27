Return-Path: <linux-kernel+bounces-535803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4616A47772
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C600116E510
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350DD22652E;
	Thu, 27 Feb 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTpUi6IG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F52192FF;
	Thu, 27 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644100; cv=none; b=q03qKx+dTrs0hBjIQqR2Vxm+5dWgWFP0CuXzxDNpTwCfeJ8FdMI0SpyfvcDxFuTVggMzHyh6Oze+aslvSa3U24wDXZhZEmUZu5XBmLxTDmdHdwhAXx66IKGhe9lG3Hxc75hIuwTuXFGby3Gnyes/dh2h5chtf0ijKPW/1vcuYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644100; c=relaxed/simple;
	bh=pBVRxF2VJ5YXgEpjEPm363C4OgCa10v6990p5e5dlOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEsdodM1xifC4uxl0EQ7kGBdxgkSTBrKj1TLKHCzyo3klIf37cpE+hperB1dmwgRmnucfSNJmq2MKPLp6alp27QbS+2ovzwwrfMkeGHLASabd4wWySQ0P9DwnIaPHgDgnX/Z2UN0CYRE4i20v9fPi03fUMdBvZW8M6hWysgn+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTpUi6IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1218EC4AF09;
	Thu, 27 Feb 2025 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644100;
	bh=pBVRxF2VJ5YXgEpjEPm363C4OgCa10v6990p5e5dlOg=;
	h=From:To:Cc:Subject:Date:From;
	b=HTpUi6IGu++OnLt11tmjVRDhhKQraYBjUqi55reBDtkq2ka123RZa4A+Ux0NenwZh
	 g033pQZlJlp/Gy1eslvGQ9OczHM6wOrrjFLX3+8ju3Kt92rC1zPYWNzS+UPdK9HcI+
	 VmjwZALJpEfQj6g+OyKwuzi0uI4zJqvNoWvsRSO+0V9031qThq4crXzjj4sYeJEsw5
	 UApJEzyCNUMiXZHshH7gI6s+6VS1fhy7DKw8YYMq02pwKpvbQS3OoHwEEzTX56ghzF
	 OUWDjRar69SL1cPiJBLDwxgiS4Fyqm9vAZiY9SkxJsSyBZ7jEQ2ZNxEXGnNusMh+1f
	 FmBG7bfW6jIUw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnZ32-000000006mQ-2utG;
	Thu, 27 Feb 2025 09:15:13 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/8] arm64: dts: qcom: x1e: mark l12b and l15b always-on
Date: Thu, 27 Feb 2025 09:13:49 +0100
Message-ID: <20250227081357.25971-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The l12b and l15b supplies are used by components that are not (fully)
described (and some never will be) and must never be disabled.

Mark the regulators as always-on to prevent them from being disabled,
for example, when consumers probe defer or suspend.

Note that there are likely votes from other processors for these rpmh
regulators (at least for l15b) but the OS should not rely on that in any
case.

Included is also a patch that adds the missing HID supplies for the
T14s. It was a corresponding change for the CRD that made me look into
this to make sure these supplies were not disabled during suspend or on
probe deferrals.

Johan


Johan Hovold (8):
  arm64: dts: qcom: x1e80100-crd: mark l12b and l15b always-on
  arm64: dts: qcom: x1e78100-t14s: mark l12b and l15b always-on
  arm64: dts: qcom: x1e001de-devkit: mark l12b and l15b always-on
  arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b and l15b
    always-on
  arm64: dts: qcom: x1e80100-hp-x14: mark l12b and l15b always-on
  arm64: dts: qcom: x1e80100-yoga-slim7x: mark l12b and l15b always-on
  arm64: dts: qcom: x1e80100-qcp: mark l12b and l15b always-on
  arm64: dts: qcom: x1e78100-t14s: fix missing HID supplies

 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts  |  2 +
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dts    | 45 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts     |  2 +
 .../dts/qcom/x1e80100-dell-xps13-9345.dts     |  2 +
 .../dts/qcom/x1e80100-hp-omnibook-x14.dts     |  2 +
 .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  3 +-
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     |  2 +
 7 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.45.3


