Return-Path: <linux-kernel+bounces-523553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A82A3D859
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C4A17C5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68720CCD7;
	Thu, 20 Feb 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM0Rx13S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D820F062;
	Thu, 20 Feb 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050208; cv=none; b=XxzZkHDq7Bpala8lEV/kOpC4BVFdcCv4UlJCJFVnDH+HOlzFkNuVWUXdRuaLUif4p2324Y0wnfHKYzmIHLgoHfLrm6zMzN3fphCyI1xbPJoWC5lV5nd43YmwtOWSbhgshrbiE40b5x5+qStptHxGCilvghUzVByk0c6Oxmp3z+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050208; c=relaxed/simple;
	bh=q06lJb7Uuv9M4Jo7kpt4iRsXe9J/IElgAndhhLU6hCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsA5/cztFFGpgMSRlyws0m+3MwTl8uy8DKg1qvwQEUTEtagKZtV0LLr20d1tAD4F71/O7wgU55mfWXOdZarTgn4P5YST9TY85KD8dZ4dPi2szRBHu3uP3RNP7YYyujejg95Wg9B8oDF5V1cbTpwvDfOMPASiSaXlbUJUvGbQUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM0Rx13S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D526CC4CED1;
	Thu, 20 Feb 2025 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050207;
	bh=q06lJb7Uuv9M4Jo7kpt4iRsXe9J/IElgAndhhLU6hCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FM0Rx13Sebhc81c+tBWlFkcUyYPtfPmHAmp4XIhZ/iYgkyeG00jU1KeE6mbfyMfp+
	 Km/Zr8WcQowsJzgD5se/uJwHXaOrWD5BjX+gK704D1Wj3MPdElMOxGXPW9LZsLIqUR
	 yvAKnAyBSBMxbQN9DeQJ5YalzTsqKtotdRbul3sbrHRyOAs9wBZyDa8vAUe8LQbtvu
	 94yR16gUdBQe7viUwM+29ItuLcDdL0YvdC64Td/5OI4MF0o4VfrCI66Vvqdlg8bGsB
	 TwX1dj5TwGj8tLnXx+Tg8RmldtZztA7gNGlk9gxvdztaNnn9TBya1HxsnBqNCo1Lsc
	 qikW9AZaaB3yw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	David Lin <dtwlin@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [PATCH 21/29] tty: staging/greybus: pass tty_driver flags to tty_alloc_driver()
Date: Thu, 20 Feb 2025 12:15:58 +0100
Message-ID: <20250220111606.138045-22-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_alloc_driver() is supposed to receive tty driver flags.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/greybus/uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 8eab94cb06fa..308ed1ca9947 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -948,7 +948,8 @@ static int gb_tty_init(void)
 {
 	int retval = 0;
 
-	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, 0);
+	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, TTY_DRIVER_REAL_RAW |
+					 TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(gb_tty_driver)) {
 		pr_err("Can not allocate tty driver\n");
 		retval = -ENOMEM;
@@ -961,7 +962,6 @@ static int gb_tty_init(void)
 	gb_tty_driver->minor_start = 0;
 	gb_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	gb_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	gb_tty_driver->init_termios = tty_std_termios;
 	gb_tty_driver->init_termios.c_cflag = B9600 | CS8 |
 		CREAD | HUPCL | CLOCAL;
-- 
2.48.1


