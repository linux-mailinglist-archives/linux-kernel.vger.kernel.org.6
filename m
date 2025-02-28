Return-Path: <linux-kernel+bounces-538767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4058A49CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E85A3B03AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38B2702B7;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUirnxra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2181EF36E;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=rCe98RED96uc+b9Vv1f6T/95DWt2Gp2PpcsiBfOydRM72E8k547iEqQuNijscFjRuYWijvvbVev1vAHZI+haEX7QyoK8VDRfRCl8EdqcrVkDgypb5KkbY/k08BAjLbTUqLI37AFFOhkjaqmCY51sow4N+VZXk3boE2C9SuuqlQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=d6jAc3qib5tSgD8hCc1ZWLfDLKrBDtNf4sx4KR6R/lE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IRK4fdtDYQtvyCVbHkLvobXb0BdS8kkQk83CCeLa646AYetA+/uU8BrunU8D/+eBKruT9LN9VBFrOnt/WbWegNuHnKkd4LgpYc2gyeruPGkO9GyXHpOjl9JL8whA0nAwKyfBYIagzskzXMPxZR+ipmnVedB6xxP/bJ1uBQVDZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUirnxra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4F19C4CED6;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755494;
	bh=d6jAc3qib5tSgD8hCc1ZWLfDLKrBDtNf4sx4KR6R/lE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aUirnxra45BPpfceFpoSZpphkANWAwG202uEbtJixI+8GSw7gP8XoAwl6CUmOX8uO
	 Gwc9u7nf/OLYuoE/+uYYw8O0t2LbLE85UkGomYmwbV3MDOruWrzQRHxQu42RsikB69
	 +m6MxvMrdTNxNQxhh5MVv/9Bjrtcy84Lb+FEoltMCE/ciH6SDJua4j6dWwlR8xGnjL
	 pTP4PylTyxOfYdG7YgWMAOi4G1/JMv+cuap5Oie11Vr2i3KaesB8m9eTF6iy2QjoH4
	 bfq/Ojx1V4SQb8/Q1c0kgYwl/zkkn5MUv4YvSpx3ssAchsozpKYNpUOGCXU8EE7vic
	 /OEOqSYr6SOJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3067C282C1;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v3 0/9] usb: storage: Mark various arrays as const
Date: Fri, 28 Feb 2025 16:11:15 +0100
Message-Id: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABPSwWcC/1WMQQ6DIBQFr2JYlwY+oLWr3qPpAvFTWRQMENLGe
 PeiK81bzUtmFpIwOkzk3iwkYnHJBV9BXBpiJu3fSN1YmQADySTj9OOSoSb4lCl2gzQW2KhsT6o
 wR7Tuu8eer8qTSznE394ufHu3jGIA6pgpnNYBt1YMt1aK7jGHlDFcPWaydQoc3fbkAmVUD61SW
 mrojTm567r+AWlKhIThAAAA
X-Change-ID: 20240401-misc-const-e7b4cf20d5f9
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=1859;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=d6jAc3qib5tSgD8hCc1ZWLfDLKrBDtNf4sx4KR6R/lE=;
 b=F1afqBPYnJvF2KHLnpWOeY0Wgv1HJz8SL1YNWW21594n+LoTJHkJbeiJqMzW0ZSYkTlZ4R4Ll
 uG0qOvsQfcmBKjWrAS8sBGv5haqqScp8LVDTjxiz8fxunnwF4BYl3Ji
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

While reading code, I noticed that some arrays in USB mass storage
drivers are declared static but not const, even though they are not
modified. This patchset marks them const.

All patches were compile-tested.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---
Changes in v3:
- Elaborate *why* const is a good idea
- Link to v2: https://lore.kernel.org/r/20250226-misc-const-v2-0-ab655a4a29cc@posteo.net

Changes in v2:
- Add new patches 2-9
- Use consistent authorship information
- Link to v1: https://lore.kernel.org/r/20250225-misc-const-v1-1-121ff3b86437@posteo.net

---
Jonathan Neuschäfer (9):
      usb: storage: jumpshot: Use const for constant arrays
      usb: storage: transport: Use const for constant array
      usb: storage: alauda: Use const for card ID array
      usb: storage: datafab: Use const for constant arrays
      usb: storage: initializers: Use const for constant array
      usb: storage: realtek_cr: Use const for constant arrays
      usb: storage: sddr09: Use const for constant arrays
      usb: storage: sddr55: Use const for constant arrays
      usb: storage: shuttle_usbat: Use const for constant array

 drivers/usb/storage/alauda.c        |  8 ++++----
 drivers/usb/storage/datafab.c       | 14 +++++++-------
 drivers/usb/storage/initializers.c  |  2 +-
 drivers/usb/storage/jumpshot.c      | 10 +++++-----
 drivers/usb/storage/realtek_cr.c    |  6 +++---
 drivers/usb/storage/sddr09.c        | 14 +++++++-------
 drivers/usb/storage/sddr55.c        |  4 ++--
 drivers/usb/storage/shuttle_usbat.c |  2 +-
 drivers/usb/storage/transport.c     |  2 +-
 9 files changed, 31 insertions(+), 31 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20240401-misc-const-e7b4cf20d5f9

Best regards,
-- 
Jonathan Neuschäfer <j.ne@posteo.net>



