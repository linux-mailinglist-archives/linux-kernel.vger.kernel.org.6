Return-Path: <linux-kernel+bounces-425596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D879DE788
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220F6B21C77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7219F48D;
	Fri, 29 Nov 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEERrIyb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBF19884C;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886923; cv=none; b=Fzxssvb/6dALI6qg73xL5R/Ex2zubAkJm4YxHnhVoldUTbNAfPASPddfeq17eX/9WBZlNV4o1PIlNePX9JFhNnos8Cb9dHtP1JXSC1oT9CZ3A2mnAwtYwDsSMHzFnLCLksn1BWxcvdrCs639wP6JzMIjQ81KYS9s05fcaYykDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886923; c=relaxed/simple;
	bh=+SW8uSY4kk9jy3nBqPD/Tm8uG6EdIVWhrds3tTcNqnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rqaWKBZnaJfDlxYbcu8A859P0qtHL+bDBpIcz7hxct1ZB4Uu6QdFkvlIaqp36dEosgixU6dbu1rBpYJ6Vbj+5kZGy9WhwqTCpwbjVhH9sCrfryMU0pxC+oGlDD2Ko6BvTf+nCgJtbGUhzIzF/dkWi84bUFL3wQnjJSm7rKaU6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEERrIyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04BB4C4CECF;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732886923;
	bh=+SW8uSY4kk9jy3nBqPD/Tm8uG6EdIVWhrds3tTcNqnU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UEERrIybuUcMtPWtTuWAvnJP5TjdwDz7uRqoV/lAtYPeMOjkeR1oOgp+c4W+gi+di
	 UnF5MQix3+YGPSM0l8ZFe2GbdQqUhG+rIuDJQaXCTy8TnUdKVC9kQRVvghGWKao6Hm
	 anxoqWD7wXFF9WjtV2QR9syQMyVIBiPWpIHX6g1odAlYIFchmZWZBj7Uo6WPtEibbs
	 +DrLSEUvmAcDllALu8e3LCsfH1JyFkkEdwe8ysLff0QJXqV1oyPI6k2Ei0HEnwZo+W
	 X+ZD8XIog7zkAdQQqW+WQemOefLLbdYuij6EdsIt9fcGM1j1YwilvxFzv8Cr+BSLqH
	 tfbD91/NBkDhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9725D6EBF9;
	Fri, 29 Nov 2024 13:28:42 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Subject: [PATCH v6 0/4] Add support for attaching a regulator to w1: ds2482
Date: Fri, 29 Nov 2024 14:25:52 +0100
Message-Id: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAODASWcC/2XO0WrEIBAF0F9ZfK5FxzGaPvU/Sh9mdcwK3U3RE
 lqW/HvNQiGNvl3h3Ll3UblkruLldBeFl1zzfGtheDqJcKHbxDLHlgUoQN2ejBXQg6QYZeFJJtY
 GlKLo4iAa+iyc8vej8O295UuuX3P5efQvevv9q7LHqkVLJUPweB7pTBqG1+lK+eM5zFexVS2w4
 wAdh8bJkjLMDiO5Izd7jh03jXs1xGTGMKLFI8c978dj4+gsOVI+prEbb/d87LjdxifP3kTUBv9
 dX9f1F8ElUrSoAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732886921; l=1667;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=+SW8uSY4kk9jy3nBqPD/Tm8uG6EdIVWhrds3tTcNqnU=;
 b=u6WXxlaO9+lR/bChs8eqEQUIUnt8Llx1BqfeG3hnrBa7hwEUYcfc6+/SdfqLXAMmJFowXzGHW
 i9YFM5f6Nl8AvqmCNG9BlE2v7GU6844qRVqt41s/sUyqpHmsWgHj/63
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

Kept the exit_w1_remove path as requested in the review.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
Changes in v6:
- Returned the exit_w1_remove path in the probe function
- Link to v5: https://lore.kernel.org/r/20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com

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
 drivers/w1/masters/ds2482.c                        | 26 ++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-ds2482-add-reg-fe13200ad7d6

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>



