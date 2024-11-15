Return-Path: <linux-kernel+bounces-410848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5A9CEA27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C36EB33C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC841D5149;
	Fri, 15 Nov 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP3Ox5ng"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42F1CEEAA;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682737; cv=none; b=Qg1wkFUBaaI2H2dtds73mlrMRmP68ptoP8lCKP4uuSE98mwjhhlBBN4qzYU4D0BlXxQZPjuOSkThPIEDPzqUd6ZPu2QUwspCegK33DbpBZzNAQuSDN568f6H6DGIbzm5ItnrgZ9PvJEkxAqFf4wc7cB1JXOYBO5YhltH99kZscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682737; c=relaxed/simple;
	bh=i9M5fv+9635ob3cC6vzKXM4ms1fR6YAYupYhw4RUh4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dDOpDjmwbGxUc/3kBHayhVBMxGZJQA2tpq8qgZf2W8CENMA9Ilu5kNVR/fP9Mr+afu6LBPUp0MqjGIB4txSMzyJxgxnYgi4fr5gRwb4VvPfdFZ9/5yszTTsGCaJdj0ooFTY/2/qRdK+Z+gs6oMP2aldaYVMgvAIrDNoOxLPvkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP3Ox5ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7516EC4CED2;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731682736;
	bh=i9M5fv+9635ob3cC6vzKXM4ms1fR6YAYupYhw4RUh4E=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GP3Ox5ngaZH4RPkjwpbgfYjE6I3hl8bsjVhx4N2PkPdOJSwByg1T00+OU4raG+3HL
	 RV94lh7AFkuVpjHyeYqy4giij4Ql0w86dy49Oj2x4mPRxS+jFoH+YaZYDR6N8WNUnU
	 +cFsMFp5w4uZa2catoi4uiY3NciNIm+xOPEaGn/T7uvQbHCE8jAVg38EVrMBxEbcgb
	 DAlUAsfa5tFckfO0t5wxP1S4V8nW8FQEmT/Z8K8KsVGonYQ/14s6a/2pC9VmfYbVrJ
	 +IMHQmslZ43g7jttIwnC65TVgBQPfTJ3sfCTzflADC7scaRHgQB9eLo1oWQ1dKovMc
	 rsxI6t/OubZqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5524BD68BC6;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Subject: [PATCH 0/3] Add support for attaching a regulator to w1: ds2482
Date: Fri, 15 Nov 2024 15:58:03 +0100
Message-Id: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHthN2cC/x2MMQqAMAwAv1IyG2hjUfEr4lBM1CwqDYhQ/LvF2
 264K2CSVQxGVyDLrabnUSU0DpY9HZugcnUgTzFUkI3iQJiYMcuGq4SWvE/ccwc1urKs+vzDaX7
 fDxCNDJZgAAAA
X-Change-ID: 20241111-ds2482-add-reg-fe13200ad7d6
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731682735; l=959;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=i9M5fv+9635ob3cC6vzKXM4ms1fR6YAYupYhw4RUh4E=;
 b=+WV9BrdehkaUq7wCfOEIm5som3iiUHVsVkRxiOeem+Kvwiz7juuIjAVvzxtm7Tyg5o9nKhqnY
 MjmiBDgVpIsAxBPL4TU7yjFAsXv3Esu20kNFkf9NQXbGpYJeLmDe6Xg
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

This series adds a support for attaching a regulator to the ds2482 I2C to 1-Wire converter.
The device I work on has a separate regulator for this chip and using always on regulator
is not working well, so I tried to make a proper solution. This is my first kernel code
modification, so any feedback will be highly appreciated. Patch was tested on the real hw.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
Kryštof Černý (3):
      w1: ds2482: Add regulator support
      w1: ds2482: Fix datasheet URL
      dt-bindings: w1: ds2482: Add vcc-supply property

 .../devicetree/bindings/w1/maxim,ds2482.yaml       |  3 +++
 drivers/w1/masters/ds2482.c                        | 23 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-ds2482-add-reg-fe13200ad7d6

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>



