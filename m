Return-Path: <linux-kernel+bounces-269272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DA9430D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF7F1F241ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694931B14FF;
	Wed, 31 Jul 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI45Fh1a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61C1AD9ED;
	Wed, 31 Jul 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432538; cv=none; b=RtVDx1nRrQBBr7lY8d18CN/9MT4dMNYRNHm1JrxeIFPGUTrEbaafZYJMh10h6+Taxa6lMvxoiczgvmN7dOAU7lJcQVDPa4CRFGzSV9ekeqQHIKsFH12BBIhv+25Fy08aarH2LyrcRqSfiT1nc1Fw3cFL8FRvjjNZhHXK+nxGStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432538; c=relaxed/simple;
	bh=Jc4yNlyCmx+fesPPbfFIYEjzN4lRNXGzCniHa8TjErU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tm0jQExCB9J2io84gMoO+9QbnP0LbX/WvuEZrUaiZSnik9WaYKoWj1MPPpYkk/eaX8jkszMiXYytnkp9fJoMWZE6IFltNTu7rWxmWmxTAYo3vjBzKHDpwn3dxDEkUC5qeKgNOdZThDum78/PZzacsKg3WgvLBQDmNK7kR+KT0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI45Fh1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0B5C116B1;
	Wed, 31 Jul 2024 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722432538;
	bh=Jc4yNlyCmx+fesPPbfFIYEjzN4lRNXGzCniHa8TjErU=;
	h=From:To:Cc:Subject:Date:From;
	b=HI45Fh1agwrKY/YszCKWI/Q8iAd7U5iW7z8qddCCPF7vwbUVeEf6Pn/pnqlKkCf0P
	 ZfyO91x7b7foMOiNRJf/pisLo3rFCPA0uV75F5WVC9Hcw6rXPySnyT3kluZQnCyulU
	 jRu8TYnLYgk9M6j4K837Qr7XmyGPPDYqJb+QJXmefdkezbfbLWN2yPVmUguEuxfHH5
	 1A62S0xmD+vKDW+I2O/myZR8tpxBIgkgPgBpHgolpcspfrT10FmdqadzUVYJRUwk0/
	 U+jNXXboikDfidfl1C+UcB+IdR7MzYPtM0xADp3Oj5s766WtmlSuY5nV3VLu4EJYEE
	 tqDhakEiSjwxg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sZ9O8-0000000013Z-1nuo;
	Wed, 31 Jul 2024 15:29:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: kobil_sct: restore initial terminal settings
Date: Wed, 31 Jul 2024 15:28:48 +0200
Message-ID: <20240731132848.4022-1-johan@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6a6c8b362be3 ("usb, kobil: Sort out some bogus tty handling")
intended to fix and clean up the device-specific initial terminal
settings but instead confused the termios input and local control flags
and re-enabled ICRNL and IXON.

Drop the bogus masking of l-flags from the default i-flags (which has no
effect) and restore the original device-specific i-flags.

Fixes: 6a6c8b362be3 ("usb, kobil: Sort out some bogus tty handling")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kobil_sct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 5eb59ac3e564..464433be2034 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -155,8 +155,7 @@ static void kobil_init_termios(struct tty_struct *tty)
 {
 	/* Default to echo off and other sane device settings */
 	tty->termios.c_lflag = 0;
-	tty->termios.c_iflag &= ~(ISIG | ICANON | ECHO | IEXTEN | XCASE);
-	tty->termios.c_iflag |= IGNBRK | IGNPAR | IXOFF;
+	tty->termios.c_iflag = IGNBRK | IGNPAR | IXOFF;
 	/* do NOT translate CR to CR-NL (0x0A -> 0x0A 0x0D) */
 	tty->termios.c_oflag &= ~ONLCR;
 }
-- 
2.44.2


