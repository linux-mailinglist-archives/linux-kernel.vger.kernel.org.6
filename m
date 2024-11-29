Return-Path: <linux-kernel+bounces-425418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C049DC1D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60D5B20DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56F197A8B;
	Fri, 29 Nov 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgfptolI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651018A93E;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874182; cv=none; b=IVeUmDKizboncH9GM1YeGrFpibfcNil+mKGA+ZkekbK67AyHCXGMRI+1/hpbqlv5i+hRWKropTbnXIfTxc5Nb1Cjn+NH9KDRuiMN7nzrs1hwO3kLMD+05deP2rgT4RR6YJxKI8yX7mVZjvhciUSSlGiB2OTb5yWj6Oe2Uk+5+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874182; c=relaxed/simple;
	bh=8CnoVT8fTCQCswWGRbR8RsjjauHvsbJEF0XuFWSNCDA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BfIIq0zptRirI7vpN9chttxAL4PkVg416u57dTSMtzW7hpIe3kmfrGx+YNiAxPjSM+CUTT2n6rtVuHxR5L/r7/J+5FL3+gbLnFKb/X9TX7O5zCVKWdbdMwUd9A9keCAB6sDf3u8Zh7YTbAHZQKlEhLgxMzt1g7s5ClLb7ie6/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgfptolI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66078C4CED2;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732874181;
	bh=8CnoVT8fTCQCswWGRbR8RsjjauHvsbJEF0XuFWSNCDA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sgfptolIQbw9FGml+e+zgvdYQv3Rku1NsVt9PfvY+r8FWjzwXZJBq7lEVGXfF3Rjl
	 OfXbPX4FKWrhHTGdjM+z/cMcmYvowuGJ9FLlxp8RbP2pWsX2PDRwH2/xsH4P+7/3FJ
	 8gCADJcFEMHQhFbTinSIUDH0IHXZ7Xk9cUW94QrEK/eexBowztnPyuIDshq7F0oY4Q
	 K6+R49e2+mXisSMFBukdbQIt0RD6q2//Sf9+rWYUqtJJIHrS7k3JSwyQjVXpXLXWOX
	 vWRoxNXa+GC6TA7tr7up/C+SbSf0CAWubrQCZnvINa5u6nY/sxtmQ6CBa0VXmrycy9
	 /F3bFDvsJUarg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0DD6EBF5;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Subject: [PATCH v5 0/4] Add support for attaching a regulator to w1: ds2482
Date: Fri, 29 Nov 2024 10:53:15 +0100
Message-Id: <20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAuPSWcC/2XOQWrDMBCF4asErasgjUaW3VXuEbqYaMaOoImLF
 ExK8N2rBAqOrd0TfD/zUEVykqI+dw+VZUoljdc6/MdOxTNdB9GJ61ZgAG19mgtgC5qYdZZB92I
 dGEMcuFEV/WTp0/0VPH7VfU7lNubfV3+yz9//lF+nJquNjrHFU0cnstAchgul730cL+qZmmDBA
 TYcKidPxokEZApr7pYcN9xV3pqGe9fFDj2uOS759nisHIOnQKblvns7fp7nP3Hv/dBpAQAA
X-Change-ID: 20241111-ds2482-add-reg-fe13200ad7d6
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732874180; l=1532;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=8CnoVT8fTCQCswWGRbR8RsjjauHvsbJEF0XuFWSNCDA=;
 b=WS1GFauJAHSTrmcFVgV3jccjWxo2Fekg6h+F/E00ZdcM7C8D8v9Z2zOPXYx5ntTh8fU2fVFFE
 GyKxWzz13P2BEg3UjQUXeEyyBm9yiw3DDIXoPo5oyUeEWHUKge3xYr+
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

This version fixes the introduced memory leak by changing
the memory allocation function.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
Changes in v5:
- Refactored the driver to use devm_kzalloc() instead of kzalloc()
- Link to v4: https://lore.kernel.org/r/20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com

Changes in v4:
- Using dev_err_probe() instead of dev_err() for the regulator error.
- Corrected patch order.
- Link to v3: https://lore.kernel.org/r/20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com

Changes in v3:
- Switched from regulator_enable() to devm_regulator_get_enable()
- Removed obvious comments.
- Link to v2: https://lore.kernel.org/r/20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com

Changes in v2:
- Removed property description
- Changed commit message of binding commit
- Link to v1: https://lore.kernel.org/r/20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com

---
Kryštof Černý (4):
      dt-bindings: w1: ds2482: Add vcc-supply property
      w1: ds2482: switch to devm_kzalloc() from kzalloc()
      w1: ds2482: Add regulator support
      w1: ds2482: Fix datasheet URL

 .../devicetree/bindings/w1/maxim,ds2482.yaml       |  2 ++
 drivers/w1/masters/ds2482.c                        | 39 ++++++++++------------
 2 files changed, 19 insertions(+), 22 deletions(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-ds2482-add-reg-fe13200ad7d6

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>



