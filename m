Return-Path: <linux-kernel+bounces-443330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4629EED7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5029716A7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B22210D6;
	Thu, 12 Dec 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+YCUfnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80E218587;
	Thu, 12 Dec 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018170; cv=none; b=LNF+PikWCc3JwnvTOVzou5AVfxo6CBRZHky1PuCUto6lTT7hwV2+yhMfUEtZuZaKmIH1E4yTWik8Q539D6bFUCOFCufLb0Nk6Y1WoTmBvyBsQUPHQ9PawF26/64kNPLTcJbsq+XZoJCihA5Lwnlkli/DcjKDN9oYniCSQQfULRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018170; c=relaxed/simple;
	bh=em5IgPXWxsnSiWgbHR4fLmkzn4juNsy0t3M2A5/FkqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c0VY8wHicAbj+LctgCvlFJR4RA1iKW9Ep3HLNgxQq18W15nZLFYPO/SyjZ50DUF4DVRmsEFXNt0QjPwnoHFAAEgrVA15eZjx+983zZlVZqBg0naUDcaXVska1qmdZDBXYhwkflVkkkMRWh1Qd38Tdj//wtuBlU1klAjngK6WQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+YCUfnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA89C4CECE;
	Thu, 12 Dec 2024 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734018170;
	bh=em5IgPXWxsnSiWgbHR4fLmkzn4juNsy0t3M2A5/FkqM=;
	h=From:To:Cc:Subject:Date:From;
	b=K+YCUfnOpb/yABBw9Tuv8fjtywTJ45ZgePAXu9R+4Kre+ic06XqXhxYjU8sTNQpVI
	 uwx9QIbfUUf2v1pBb+t9DexVSaGYE8bEyBenugenZuEiOWLyjBKTIGPnM/VmSGeXPi
	 3ZZzrVtsjwWrQneblGiUO7vUxq6u1W/PRtbg89HfFvkCOEj1niB68IOj4G+mcciE5k
	 ZLZ2xtAqMhw/JJ0ST1+OFyE4k9H8wWFwjaVXBIOWiE4Kp9/2M4X8Cfs0NvrzHShfqt
	 hb/b5q5+0V/bm5h0LrSUO92URBLEb6pv3ExmqHu88Fn50TC4PrgbLaY9XBWoVDmv1Z
	 3AqBIVSjlpCcQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: gpib: make global 'usec_diff' functions static
Date: Thu, 12 Dec 2024 16:42:34 +0100
Message-Id: <20241212154245.1411411-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Trying to build both gpib_bitbang and lpvo_usb_gpib into the kernel
reveals a function that should have been static and is also duplicated:

x86_64-linux-ld: drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.o: in function `usec_diff':
lpvo_usb_gpib.c:(.text+0x23c0): multiple definition of `usec_diff'; drivers/staging/gpib/gpio/gpib_bitbang.o:gpib_bitbang.c:(.text+0x2470): first defined here

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c           | 2 +-
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index a2d562cbd65b..23550502e012 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -315,7 +315,7 @@ struct bb_priv {
 	enum listener_function_state listener_state;
 };
 
-inline long usec_diff(struct timespec64 *a, struct timespec64 *b);
+static inline long usec_diff(struct timespec64 *a, struct timespec64 *b);
 static void bb_buffer_print(unsigned char *buffer, size_t length, int cmd, int eoi);
 static void set_data_lines(u8 byte);
 static u8 get_data_lines(void);
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 22185b48e3e9..f7ba770e4707 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -208,7 +208,7 @@ static int skel_do_release(gpib_board_t *);
  *		 (unix time in sec and NANOsec)
  */
 
-inline int usec_diff(struct timespec64 *a, struct timespec64 *b)
+static inline int usec_diff(struct timespec64 *a, struct timespec64 *b)
 {
 	return ((a->tv_sec - b->tv_sec) * 1000000 +
 		(a->tv_nsec - b->tv_nsec) / 1000);
-- 
2.39.5


