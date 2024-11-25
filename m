Return-Path: <linux-kernel+bounces-421702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864729D8EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B32CB2ACC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9481CEE8C;
	Mon, 25 Nov 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWlU2svr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A11B85C2;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574913; cv=none; b=EzhN4EVL7R7+OpYx50dp66lS6ehl4RO2upJk472Q+3/DNyVdGtiP1vYg6KtZKgp1dl3B1VoVBo17J666FmPxZKxQw3JbOnxKh/q8hGC5aWsF+jF2NkPk2Kg3SVMOvaRKW5IlGs7m5F9VJIXQa7XCn0W7dvs+D4cB6Gi+Vwq8UfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574913; c=relaxed/simple;
	bh=pO2keMzXgEkbE5sL9Kcr9lbyFhjffvi7oTNNc+i1d8U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qLG3L8Bo1n2eEZeiAM0la7bFRVLRrHiUy6V/bpDDqZTGNl3NA+hQKfWZNeqP0W/puEnhDLiSG9s+FnBo4Uxbn2eS4Zg+wUEP6qRjpmqltBlqpekiE3euWz3hF9ncYaA1TQKIAzcILxg+guYu+VRxl7HI669FZf0EYmZzDI8M8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWlU2svr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 620F2C4CECE;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732574913;
	bh=pO2keMzXgEkbE5sL9Kcr9lbyFhjffvi7oTNNc+i1d8U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uWlU2svrkA0gP17Fj+qR441QKlVGFTug/EmP5Q53ovh3mMwKG5JXlyyN0ynik3JwJ
	 4Wrj8jCLKnDLVjPwD3jmPOTRsdSOI4FwpeH8a38V4OwqWvGw3CsWV05bH1kVAvPoXp
	 ulW2dHMxIqiJuH7/lL2lI0Ie0lFtg5J40vY6lva1WRzWklnn+PT/d4tfUu1mqsFoSl
	 rbsXC7hTK5G5DJxmYV6HyXZYVsB0Y08mpiR+hGaj3F3wDFq746vfocO5+OqIGFloP+
	 MzYgvRRC9VHC9cNU4HvswbRqJmvGMAXIExCa9SHkCxw0xU6Dshjn2EBZDvUkdAeT+c
	 bu5ch+Ggr4wWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47836D59D64;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Subject: [PATCH v4 0/3] Add support for attaching a regulator to w1: ds2482
Date: Mon, 25 Nov 2024 23:47:17 +0100
Message-Id: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHX+RGcC/2XMTQqDMBCG4auUrJuSTOJfV71H6WJMRg1ULUkJL
 eLdG4WC6Oy+geedWCDvKLDraWKeogtuHNLQ5xMzHQ4tcWfTZiBAy3TcBtAlcLSWe2p5Q1KBEGg
 Lm7OEXp4a91mD90fanQvv0X/XfpTL95/K9qkoueDGlLqusEYJ+a3t0T0vZuzZkoqw4QAHDoljh
 kIRFdpisedqy/WBq8RLkdtGVabSmd7yeZ5/2IyqqyoBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732574911; l=1233;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=pO2keMzXgEkbE5sL9Kcr9lbyFhjffvi7oTNNc+i1d8U=;
 b=2BAjBzvZaE3p6IhXIFmvoeZgH2Lo++Q7MUTZrCKoKD26uHvwyBEbrdmoKzoXmtmklWjMGdfNr
 lDpOmyEpjDIDnJxSEJz1r9eiphUc+3oXPil3iYOB59i+lozQfSt9LJk
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

Implemented changes requested in review.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
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
Kryštof Černý (3):
      dt-bindings: w1: ds2482: Add vcc-supply property
      w1: ds2482: Add regulator support
      w1: ds2482: Fix datasheet URL

 Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 2 ++
 drivers/w1/masters/ds2482.c                            | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-ds2482-add-reg-fe13200ad7d6

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>



