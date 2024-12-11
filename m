Return-Path: <linux-kernel+bounces-441674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154309ED23E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9EF165194
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3501DE2A2;
	Wed, 11 Dec 2024 16:39:41 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A724635B;
	Wed, 11 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935180; cv=none; b=umXfpRxULRdxEGP5WMNGgfuyUOr8gD4I9CuyZrbnpoVcdzzxfHqvLGK41aiVbDzElfvGs0936Hw6EE8Az+eBCvRgWiRD7TTAg/WicJQHXzYa5LLmlAh/g5UwTNzJpujoFM3INXBGM9E4dsemVnVOw4NLGD8DV3ghow8+893UQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935180; c=relaxed/simple;
	bh=eBVMF9KKaCTuPJwYSYTzpRoFRPJG6hmrgAglBk+tkI8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ji9oGY/jHcx92KxZIvu5pvEY+etbUaSG057WwoLT11+QurF2DCjYKzWiDDs+RVUfToc+tC9cSS5XFerxrsFV4qqFxD7Y9Jf/vd/joEy77ODUc9My7zL4EXzpeUcNGVXuUzdWd7ZumgKnWFWEvGl1KCpHMfmxJR2B/YWJEbECLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.195.248.60])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id B46062B5;
	Wed, 11 Dec 2024 17:32:57 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Subject: [PATCH v3 0/3] usb: typec: hd3ss3220: enhance driver with port
 type, power opmode, and role preference settings
Date: Wed, 11 Dec 2024 17:32:44 +0100
Message-Id: <20241211-usb-typec-controller-enhancements-v3-0-e4bc1b6e1441@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKy+WWcC/43O0Q6CIBQG4FdxXEcDNMSueo/WBeExWQoOkGXOd
 w/d2urOy//f2fefGXlwGjw6ZzNyELXX1qSQHzKkWmkegHWdMmKEFZSSAo/+jsM0gMLKmuBs14H
 DYNKtgh5M8JiLkrKiKljVEJScwUGjX9vG9ZZyq32wbtomI13br17u0CPFBOdCcEWlUlCzy3uEt
 nvCUdkerX5kPybd83Fkq8lZXnJx4hLkv7ksywcH7Ih4KAEAAA==
X-Change-ID: 20241104-usb-typec-controller-enhancements-6871249429f0
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>, 
 Oliver Facklam <oliver.facklam@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733934778; l=1736;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=eBVMF9KKaCTuPJwYSYTzpRoFRPJG6hmrgAglBk+tkI8=;
 b=6K0HC1cOhKnLaJOrGQHAktrsQzYlzVnZQN3qj9M1HOwBRY+V4399aHr3+sblBtbNsDz6qSmz1
 wqAYCzAFnSJDVl/2JrP2xHEOoSORjW+m301CtQej3dxNDI1NB0pMiLT
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The TI HD3SS3220 Type-C controller supports configuring the port type,
the advertised power operation mode, and its role preference
through its I2C register map.

This patch series adds support for configuring these registers
based on existing fwnode properties and typec_operations.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
Changes in v3:
- Drop PATCH 2/4 from v2 (using typec_get_fw_cap() for capability
  parsing)
- Implement parsing manually to have better control over
  each property being present / absent.
- If the "power-role"/"try-power-role" property is absent, we don't
  set the corresponding register during probe anymore, but let the
  chip use its default.
- Link to v2: https://lore.kernel.org/r/20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com

Changes in v2:
- Better support optional fwnode properties being absent by setting
  defaults in struct typec_capability and checking return code of
  typec_get_fw_cap()
- Link to v1: https://lore.kernel.org/r/20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com

---
Oliver Facklam (3):
      usb: typec: hd3ss3220: configure advertised power opmode based on fwnode property
      usb: typec: hd3ss3220: support configuring port type
      usb: typec: hd3ss3220: support configuring role preference based on fwnode property and typec_operation

 drivers/usb/typec/hd3ss3220.c | 207 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 184 insertions(+), 23 deletions(-)
---
base-commit: 237d4e0f41130a5ff0e1c7dc1cb41ee2fe21cd2a
change-id: 20241104-usb-typec-controller-enhancements-6871249429f0

Best regards,
-- 
Oliver Facklam <oliver.facklam@zuehlke.com>


