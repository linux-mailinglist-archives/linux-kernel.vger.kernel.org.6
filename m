Return-Path: <linux-kernel+bounces-534056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E74A4623B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3D53A715A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5A22759B;
	Wed, 26 Feb 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1TW05CY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73689221738;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=n6iZeWnIFIHQ5T4W3149Tyn2kmlPubPUgp7Ti9DsoWchZ9sOVL3xNg+6HqjieUdMAnGNfyg9UXW0wN208cNpt2zGav1KExELMAPVYFifUVCafWLnXFE3LVpplINJEoE0JOOkeUGPF5dnJCwKiEbWecyW+fz4LmA23qH5J6Zi/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=w8aMXJ+NU/5C6KBOxx5hHJUngYjg57KJkqVbAGaaDDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhTfyQTHegY5znFJbh+KIf2X6CRvvYeiB7u0UmCjCF0cG0LbojCkJeEU9zAe9Mbvs6n82Pe1rt5c9dB3gTN/1fLY8RgQqv20yMQzPUOvfw6xUlsLFk5UDybfZcSuUs+iXC3QCpdMoxTC7snLw9bipal3cGr3c6u0QHy0fSldG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1TW05CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12B20C4CEF0;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579452;
	bh=w8aMXJ+NU/5C6KBOxx5hHJUngYjg57KJkqVbAGaaDDk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P1TW05CYq18CmhYa1SsaOA0YV0Ee70Ec0EpOFGYWX+NGNf1oOL9IwrIUWiyQcSSzG
	 7rC6UXJ+qDjlmeHX/s6Pk46vxSvW0xs8lAytE7+a24WYoH2SnWfqh/ctNksy/5cuGg
	 uYMtuTheIJFUYW2v8kL8jLioNXuLoyVlumN9Mfgc0aUtJnhgrfbZD3tSPHbmySDgBJ
	 N2aW8RXUrlUtGtWpcdh9AlTzAKhWy+FxBomVU11ge6ciYdYr24N6AQ76rm5oo22M8W
	 WLmoXy4lSoO20v0WlmKFBGOQ0UrS4rkJxM6J0Rpd7k4SQ4QT9QmqMJ/4Pvi6ily1+m
	 akoyv9R60YE4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6F3C18E7C;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:31 +0100
Subject: [PATCH v2 9/9] usb: storage: shuttle_usbat: Use const for constant
 array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-9-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=924;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=v11yX1jHyBzwioDip32r3C5+SG/nGSwnzcapdw5f/+I=;
 b=yTY/YVeDIcz1oPqt/3tMNvIL+X+JBEfVSdcEGQiPavrbg/dA86vlZ53iZ8WWkrM27T2qUMCvW
 Ha2BVh4wvqKABomcpZw0heowIJEmh1Rc+/7B9NC/oZWKDzWpruJ3w6o
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

This array is only read, not modified.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V2:
- new patch
---
 drivers/usb/storage/shuttle_usbat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shuttle_usbat.c
index c33cbf177e6fcaa80e0d2639594d1314c59f4950..27faa0ead11d1b0ee9e45ba6a3ee5bade8a416e4 100644
--- a/drivers/usb/storage/shuttle_usbat.c
+++ b/drivers/usb/storage/shuttle_usbat.c
@@ -1683,7 +1683,7 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 	struct usbat_info *info = (struct usbat_info *) (us->extra);
 	unsigned long block, blocks;
 	unsigned char *ptr = us->iobuf;
-	static unsigned char inquiry_response[36] = {
+	static const unsigned char inquiry_response[36] = {
 		0x00, 0x80, 0x00, 0x01, 0x1F, 0x00, 0x00, 0x00
 	};
 

-- 
2.48.0.rc1.219.gb6b6757d772



