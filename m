Return-Path: <linux-kernel+bounces-525768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C2A3F4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C83422546
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8620B810;
	Fri, 21 Feb 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iixFkBel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDA20B7EA;
	Fri, 21 Feb 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141877; cv=none; b=TrHrz1KgcJ53OB0fnUuUXobzRZUUk/3m5nooSmB991t4vAXUKJ7GN0WQ7NdBOe9JoaXknTmFrU9LCDJaMYM0eb1l5wbbDzJQvrPjROFh3etN8u1uDS5piD0PHME9861tGFVMlT7m4J7+3cLrD7sDvP/tbyACx30fsRXPSTZHmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141877; c=relaxed/simple;
	bh=CC1UxfiMyuiUPNlkFGCIIH5Aw4B/3j7A6rOnbZAwm4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQhwAuOamrNo6XrG7W1lbdRYhetOd5nATnqbfg3Ihed0K2ZyTP5MOPOIDKKR7aJruYHi+GcCRDcheIh34+UoaCzHGjKqOusYvQ6toWvntkJ3aSwhmHc0qPPPzOlbnGDwaaDF1rlTVnvKMekP4smbdd9aFQMcp/Dp3K702l7D4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iixFkBel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD4C4CEDD;
	Fri, 21 Feb 2025 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740141876;
	bh=CC1UxfiMyuiUPNlkFGCIIH5Aw4B/3j7A6rOnbZAwm4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iixFkBelOAhzLwkc9lVpOlUIwa3rU9dNmYfkMZdlf1dtyd3kFnoyUF1eDq3LWJ1XV
	 UGP0T8phfi8YIQL5pf5fhGPuqt0bigZ4qltGoysy2xWXHTeeLx24/H1rxxLkj/ItFd
	 IlKtcUODNlkzKUFgPXqcIuVnx5sWneg0Fl9Fx56fpfcN+9Cy5g8nq1JTOZ9GardTXN
	 lKvDZ6y6upNv18quGq0cJh4p+Yu3D9Dff6D33C8ULjHwHm2gRdHZTvCfD0x86ue/yU
	 Qvfl+ItfaGsYA7csW+xvEphDyzlBDCXd1UuqwWjP7jK9KsMSHyE25K0I5mWCKEP0Y7
	 tmoVzXHqhqdwg==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 1/2] tty/vt: Use KVAL instead of use bit operation
Date: Fri, 21 Feb 2025 13:43:52 +0100
Message-ID: <4f199d90c7f0bc86bcaafd2f25da4cd006adcc80.1740141518.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740141518.git.legion@kernel.org>
References: <cover.1739881707.git.legion@kernel.org> <cover.1740141518.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The K_HANDLERS always gets KVAL as an argument. It is better to use the
KVAL macro itself instead of bit operation.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 804355da46f5..38d4df932f73 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1519,7 +1519,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	if ((raw_mode || kbd->kbdmode == VC_OFF) && type != KT_SPEC && type != KT_SHIFT)
 		return;
 
-	(*k_handler[type])(vc, keysym & 0xff, !down);
+	(*k_handler[type])(vc, KVAL(keysym), !down);
 
 	param.ledstate = kbd->ledflagstate;
 	atomic_notifier_call_chain(&keyboard_notifier_list, KBD_POST_KEYSYM, &param);
-- 
2.48.1


