Return-Path: <linux-kernel+bounces-439462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C328E9EAFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB56728EEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AAB223E97;
	Tue, 10 Dec 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKINalxr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90D19E7F7;
	Tue, 10 Dec 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829333; cv=none; b=ttj3cZRE+rPTxMvGCu2Nnf4k5QL6T+JzIMkOVaJY3TIkmC4aEgQL/drFVgbZQ/EKhpGCb+Knz7IQsmW9tw9RcYEGI8KEB+uOSetBnfvL7ebkQCEoAOJSsOCYPU0gIEPgDQQCy3RI8UdfBAhjf73kaVam6W+Pav/hHLgH12yHSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829333; c=relaxed/simple;
	bh=C/nxZoelFigpsBolaDCTXgQLK8zb6hqv3BnVAoSkfSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsfwdD1CMa0YCfLoxnH8jDSYg5UeFJkZCCkmYHKY3PtwdYYkmk4B4on6LtHo8iPYsv0uvzGh7RpPXgaxo+DPpGhBGJ0cBeMdjyqV3eo+fVIhpar+yFElksit96ELlQ7TR8FEGkHL2Chex5lYfgfJ7W3fElbJuGiv5RZOV9Clg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKINalxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E6C4CED6;
	Tue, 10 Dec 2024 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733829332;
	bh=C/nxZoelFigpsBolaDCTXgQLK8zb6hqv3BnVAoSkfSc=;
	h=From:To:Cc:Subject:Date:From;
	b=eKINalxrMHiU17W1SY8KEe7MEmFs/xaibfZr0J6zjzk893hALy6v+74L5UEXnYxrB
	 h89FXWd6wLJqJ0Dr4MxHRnPlFjPBPquFCkCPJelO9NHMWrwrfySwwGKO9nIuyRCXif
	 rLD1SAI/elRF9ovp3G3fsNpU4uquzAFntTBx1FkgLOkRB5MJbO1EJDeTCtltZrTFE9
	 MF/HnXz/gT4wWZ94i27KK9vzbGnUcSW20kyU6bfQfb2hX6ppxgiKZkJDw7UoBPDcwP
	 cTKh+gqKpO5hUT9ujqTsguSwT+U0tW5HkN0LB/cu48Iq55AuOPI2siSv++BaJYEdw/
	 nEfrpVr+8T8jQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tKyDG-000000006qj-2COV;
	Tue, 10 Dec 2024 12:15:35 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jonathan Marek <jonathan@marek.ca>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/3] arm64: dts: qcom: x1e80100: fix USB OTG regressions
Date: Tue, 10 Dec 2024 12:14:41 +0100
Message-ID: <20241210111444.26240-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change enabling OTG mode on the Lenovo ThinkPad T14s USB-C
ports can break SuperSpeed device hotplugging.

Abel noticed that the corresponding commit for the CRD also triggers a
hard reset during resume from suspend.

Dmitry had already reported that enabling role switching can break UCSI.

With retimer (and orientation detection) support not even merged yet,
let's revert at least until we have stable host mode in mainline.

Note that Stephan has also identified other problems with the offending
commits here:

	https://lore.kernel.org/all/ZxZO6Prrm2ITUZMQ@linaro.org/

Johan


Changes in v3
 - revert also the dtsi change that enable role-switching since it
   breaks UCSI (and DisplayPort alt mode) when the controllers are in
   host mode

Changes in v2
 - revert also the corresponding patch for the CRD which breaks suspend



Johan Hovold (3):
  Revert "arm64: dts: qcom: x1e78100-t14s: enable otg on usb-c ports"
  Revert "arm64: dts: qcom: x1e80100-crd: enable otg on usb ports"
  Revert "arm64: dts: qcom: x1e80100: enable OTG on USB-C controllers"

 .../boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts  |  8 ++++++++
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts            | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi               |  6 ------
 3 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.45.2


