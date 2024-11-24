Return-Path: <linux-kernel+bounces-420154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536549D75CF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B6D16625D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE418B483;
	Sun, 24 Nov 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWTnO1ib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB251531E9;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732465299; cv=none; b=cVxdMQBDmm2RbFBiLduSrs/W0HM860dzgj/gWgxoF6/Syq0g6+vMeTpWKxSWutaE9YApXbszsZM+yIcgW7NUVHiQmGAU5+MgsuWRSfVmq/ZoqdAzeEaaq+r+q93EtfuavhznJYsjQ3TIeiIoIONyAS5Bs8dWhk/j1J01hzwHtIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732465299; c=relaxed/simple;
	bh=/9ijyl8GH0XD0x3k3EDuqb7k1ihuj0joBaoT2aUOF4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mlfAuSBrqACDPOp1KiUn9xPeB0dt3XWMZv7pqfYPLqeTT9+5fzCBVy7RPSyuutsaLPW+RxcgD0pgo6g8oBJSc1NhUXehWE39v4TebDiKu37F5gAz8sCFAXNFcl+o6SrQmwhlIdtSmWcW0pp2uqBulgFQI1eY+8Jrt6hbn3f21pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWTnO1ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 659C0C4CECC;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732465298;
	bh=/9ijyl8GH0XD0x3k3EDuqb7k1ihuj0joBaoT2aUOF4w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TWTnO1ibZO6ZbBR7RWtZ9ldmuQ4TQuBfU9gEyF4WdCDbcTj1k9+fXDWL8J1d7YRCB
	 n0lOQ6c/yN0fflaRC7Xt8MJxedqBRlyjHoT5FV2a0SqNj8hzt+SUsCfmS/EY5J7cb+
	 ROBJlf6j6DYvCuwdHYGsn+jeKUvbLXiBt9WPgJhN2x93pRSy733wgC2jZ1N/KYx6g4
	 nKMjsVF2IlRLC0UEb/Z/KiHW8MqdeXD7Exm22X0b0HWsjMDOFAlglJPPm2Bs9catom
	 r8QM7KAet4IKchicVVByqXwHDCzJl6vYCRknJ/QwtajFbIXFGraH29jtfL5uUXp7CS
	 fI0nKMl51jzSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0B8E668B8;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] Add support for attaching a regulator to w1: ds2482
Date: Sun, 24 Nov 2024 17:21:34 +0100
Message-Id: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI5SQ2cC/2WMywrCMBBFf6Vk7UgyTR+68j/ExTSZtgHbSiJBK
 f1304JQ9O7OhXNmEdg7DuKczcJzdMFNY4L8kAnT09gxOJtYoESt0sAG1DUCWQueO2hZ5Sgl2cq
 WIkkPz617bcHrLXHvwnPy760f1fp+U8VvKiqQYEytmxM1pLC8dAO5+9FMg1hTEXc64p+OSaeCZ
 M5caUvVXl+W5QOztA/L6wAAAA==
X-Change-ID: 20241111-ds2482-add-reg-fe13200ad7d6
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732465298; l=1048;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=/9ijyl8GH0XD0x3k3EDuqb7k1ihuj0joBaoT2aUOF4w=;
 b=T8bKNb/jV0tPhdz3tKUndiEJsHAJ0g2LD8k+h1QGp8n+8cWVyrVgo705iH02D8LTng8BzZN9N
 qivFJymlTwfDjymO/kzxYEDAnB03gHnpYQyoyApCGgSNm40cUn+zsCK
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

Implemented changes requested in review and retested them.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
Changes in v3:
- Switched from regulator_enable() to devm_regulator_get_enable()
- Removed obvious comments.
- Link to v2: https://lore.kernel.org/r/20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com

Changes in v2:
- Removed property description
- Changed commit message of binding commit
- Link to v1: https://lore.kernel.org/r/20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com

---
Kryštof Černý (3):
      w1: ds2482: Add regulator support
      w1: ds2482: Fix datasheet URL
      dt-bindings: w1: ds2482: Add vcc-supply property

 Documentation/devicetree/bindings/w1/maxim,ds2482.yaml |  2 ++
 drivers/w1/masters/ds2482.c                            | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-ds2482-add-reg-fe13200ad7d6

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>



