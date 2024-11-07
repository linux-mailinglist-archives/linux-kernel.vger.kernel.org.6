Return-Path: <linux-kernel+bounces-399801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC94D9C0463
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718A42817BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CEF20B203;
	Thu,  7 Nov 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3pazFZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534D20ADCE;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979841; cv=none; b=Q0tF6mjKXD6l4hUgV9wR8WSaZ9En7xqai+3Y5bIjIoHtBcxqDjg1JTGjIl4WwRxLHLHmQjpKQoCVEJhKXwTxSLx60YwqkHVBAKLuy36ArsvLdEweh1yC0LKfdCp5tu3CHQbzZlQNFZW64ROkj8TrpaNNUx2aCiJqxfBAkWyOPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979841; c=relaxed/simple;
	bh=XYYLn1zHeH3UNBGUAYyypY198vN0jFLiOM8L5eat9OE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EGBv2Ssrxtp5Asbg45kmDO2mEdiJij5c/xg1GRvssm0elZ99Q7vL6urz4UcC5VP1lymcFlXiHz8lBdar5Uk6LuRRYwnfVjQBKe/AogYaf2ufD9bWMyJqoweZTBAkYAGXvR6guJzHllXOFAmgU59E0NHR0cnAhzuu93mtAVPnB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3pazFZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88229C4CECC;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730979840;
	bh=XYYLn1zHeH3UNBGUAYyypY198vN0jFLiOM8L5eat9OE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=m3pazFZQ2JWJBwVCyfm89P4+DRJzP/gqOOYAO/NrfsTAcjf9CjBjxYHf+PRe5xaXC
	 yf1x54MVdvg/UxwclbdH001fCiSYGl107HShKzDGTxuLDdPmSLe4tvbpD71Ebbb/lG
	 Sh3FaQM72E35DsPjVsi3GVsbYZDE5IpBMhwwtaOKjS3mwvRmmlW4/hpMWbyV2lOLkM
	 7iDN4joeZF1BvI43cEbUQZaKw5wy9S9eTlsU/BXrWo8fQeQaZmkRIqg6ELeJOJKhiy
	 TGCtVSCI/+ttn6BHHqT6rn8tUqMET8WZcnwVOypgjfeClrORRQwKKJ5KODC9IFU234
	 J/8s4WgpHAs5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747DCD43350;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
From: Oliver Facklam via B4 Relay <devnull+oliver.facklam.zuehlke.com@kernel.org>
Subject: [PATCH 0/4] usb: typec: hd3ss3220: enhance driver with port type,
 power opmode, and role preference settings
Date: Thu, 07 Nov 2024 12:43:26 +0100
Message-Id: <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6nLGcC/x2NwQrCMBAFf6Xs2YUkBLX+injQ+KoLdVOyqVhK/
 73B48Aws5KhCIwu3UoFXzHJ2sAfOkrvu77A8mxMwYXovYs824PrMiFxylpLHkcUhjY34QOtxsf
 zyYfYx9APjlpnKhjk939cb9u2A+ddx6RzAAAA
X-Change-ID: 20241104-usb-typec-controller-enhancements-6871249429f0
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Facklam <oliver.facklam@zuehlke.com>, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730979838; l=1040;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=XYYLn1zHeH3UNBGUAYyypY198vN0jFLiOM8L5eat9OE=;
 b=g+uONn75YrD3FrsvESNSt4vNkomXLwmCRwNYqfOvr1YLdbjQwB4//ktoGdzuJEdejKij7vmIN
 Tr4X2aUk+CKCMzpb8TWmvyc6HhDpxf/P8HeADh/TLaMoeXnqPfH0ugq
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=
X-Endpoint-Received: by B4 Relay for oliver.facklam@zuehlke.com/20241107
 with auth_id=271
X-Original-From: Oliver Facklam <oliver.facklam@zuehlke.com>
Reply-To: oliver.facklam@zuehlke.com

The TI HD3SS3220 Type-C controller supports configuring the port type,
the advertised power operation mode, and its role preference
through its I2C register map.

This patch series adds support for configuring these registers
based on existing fwnode properties and typec_operations.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
Oliver Facklam (4):
      usb: typec: hd3ss3220: configure advertised power opmode based on fwnode property
      usb: typec: hd3ss3220: use typec_get_fw_cap() to fill typec_cap
      usb: typec: hd3ss3220: support configuring port type
      usb: typec: hd3ss3220: support configuring role preference based on fwnode property and typec_operation

 drivers/usb/typec/hd3ss3220.c | 171 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 144 insertions(+), 27 deletions(-)
---
base-commit: afb92ad8733ef0a2843cc229e4d96aead80bc429
change-id: 20241104-usb-typec-controller-enhancements-6871249429f0

Best regards,
-- 
Oliver Facklam <oliver.facklam@zuehlke.com>



