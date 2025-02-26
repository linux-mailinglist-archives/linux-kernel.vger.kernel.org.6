Return-Path: <linux-kernel+bounces-534055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E61A46232
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7F03B3709
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202B2222A2;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtU0fFzl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D636218AC8;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=XKWm4F7/iewotrX1g+H4bk/WkxdnW2IGlJzjfPI7pLW165Vp3qD78BCVcIiz/XYjtCsHDzyxUZkwzNl3RLvhy2JMBaBp1spJ6CFv9+FefvbBWFE7T7+mYdJGPs2w8obmCeTpseb4Y10b3HPLLFHEYbnGL8RvdJOKOynSjdZgU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=fwV5Igl0YjoYekgCo39bGuXYUSU/ztIwTAkRyvKRrqw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QVisu0Zaa6ClnXi7cbtMFU4DVjSCXQ818YfG/3OxREemCL9+ZXHiCz8QWc0n6ue70NrMY9xX2ZZofARug43Hgv7m7BGqU0PElOcIDZcb24pV7BS145a8y9mMgwe8u2FeqXxYnVwjZl6vkldXReBrX0mlZoUPbbsFKKJBnOz51aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtU0fFzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE9CC4CEE4;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579451;
	bh=fwV5Igl0YjoYekgCo39bGuXYUSU/ztIwTAkRyvKRrqw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dtU0fFzlkNAnroJ8Hauv5Ufq27f20TXvDHzv3Pfe0zqZfge8c34DYUj6z7zRv7ZSL
	 8h7l0fwuTFYfz9QZ/sFhF+vXviJzRYm20jzL4uK0SuFEAGwwulqkJujtzoUI5U5R7Y
	 rN5l4Q2yWg3BfgG4PucMvYgfkHh1uxb81U87vuR+h8LsoBa9jxdFiDoohzVQ6s/FPA
	 kXGiecXjjKbA2wg753z789J2IATGfswPLPPgrC2w0wObJDOkqYZFgyeF1P33A65HKa
	 Usrv1ezqQzuhW1OuuvrZ0S3xy7v3WdFENQLn7ONH2fb/V8Vz4iaYPpMFfAmygw/Tyf
	 mcILK8rlCoKPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662EAC021B8;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/9] usb: storage: Mark various arrays as const
Date: Wed, 26 Feb 2025 15:17:22 +0100
Message-Id: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHIiv2cC/03MwQ6CMAzG8VchPTuzlSHKyfcwHGR00oMbWReiI
 by7g5Pp6d/k+60glJgEumqFRAsLx1ACTxW46RlepHgsDajRaquNerM45WKQrKgdrPOox8bfoAz
 mRJ4/B/boS08sOabvYS9m/+5MoxGbf2Yxqhwa7+vherF1e5+jZIrnQBn6bdt+jdaCTqUAAAA=
X-Change-ID: 20240401-misc-const-e7b4cf20d5f9
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=1711;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=fwV5Igl0YjoYekgCo39bGuXYUSU/ztIwTAkRyvKRrqw=;
 b=cAY4Rp6m9M3AvBzybF691EpSlg/bOe3SSQGlpgxsasvXQbedMVBuVulj6Zf+ouOBi6nKXQE0k
 QdsBdhUC+08AxBp3ev6/NJGILI74xu5IsDqO2kQcONXgyBdj8x00U9A
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



