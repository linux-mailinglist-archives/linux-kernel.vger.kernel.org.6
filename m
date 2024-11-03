Return-Path: <linux-kernel+bounces-393995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E69BA854
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E4F1F21862
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FD1AB51F;
	Sun,  3 Nov 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMBh6YRl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E41A7AE3
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669209; cv=none; b=ZWmNeQ9lcwsfnanCo0TjvXdFWbK/yO2crUhKoA2dy35ueoOKk4T+Jr+Nw9n/ouk7g0M/R8jalqK3JlmfM1Excl3mUFhVqqIsftQVDBmWpDiGxRBt5xa7CCceCfIADmeIMz9ufpEZm9bdghXmIc4k3wm7L7HrPUd1lRpVVqeaFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669209; c=relaxed/simple;
	bh=30iOY8pk90Mkg1P3Owc8Rv0t3FI95lCg1fjDGL8TU0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfpQGni35q8pCA0bAvdNiseuUzV//dMd0FQY7Wh/r6QfsTBic5b8P1gc3/UbZnN5yjlBdab/ZHwr/5Cf9r12VuRlcMsPSef/Me8Jla6dt6S/NaPceLKRJ7b/R4bExYHncp55+O3LRrzg434xAJjNYdRNyuBbQaErku7iYUnNCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMBh6YRl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so31541495e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669206; x=1731274006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqBXKF1R/xvCMIz/yq7u82w7wzd3NP6sTl+H7HvVaBA=;
        b=QMBh6YRlw5yH9EiW8hYRgsz8HQSrzbWMI85tkRWzqHOQYCjorSu3ufKTRff4I5XIvU
         +hgB3Huu3grbp46U1Qa8eX/9w+wf++D0jcn3JU1fI3Fat65B6xg1XD3obOBELoH4SjOm
         Rdmtdf0FwiYU6soF2EG1oNynrIn9YHSjEe81ThVkaiurVQWs2Vz3I7sYrCeAu6Pvtm7X
         4PGJA5zQSxrR4PjEHMbLsYbxEwhDRtJgOHPhYPp2oBl/rQhrdGVXf802Mt50bwwKXb+G
         N01locBT/r3mC8WEk/UKtngi3Fxx+fTK7nFU4xlWyMN8eN6+Q7lhuJBxOHHVvXm6DhLo
         6hDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669206; x=1731274006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqBXKF1R/xvCMIz/yq7u82w7wzd3NP6sTl+H7HvVaBA=;
        b=m31EtuLjbyvoWpmfG1YZpx4Dh3NwKVH19/xA3Kr8hY7ORsOWhRZCFzCkWXgHz3fuzO
         KWAbzxuH93cdDP+SAcjFi+0pGDBo2rxnXnuG8e1V9ebHJZolld+04RDkfbSJA5sHwxlE
         AoLhbqt2a0xkHgPe9AJm23cbpDCPXUHfWG3HD2CclIyT03fB26cbleOiisoqDAViN3RN
         wgabTioxGm322acsb5LtUrDZqfaLEFgwGcvQWu3gU8deRK6z2vzJeiWYWsdu1wKjWYK3
         ACsGZKYyKJSGaJJ46Wv2OZxfedHMJddElSh0EO/g8/xtmD13Y+Cz/Spx8zOYrAXjAM6p
         VaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcB7J1wM6qwvMJ2hl0g9UHJTkSmAVsEVyhYc2mVq9rvnl1qJwsC9S+SunTIrZVWhISa0uc394CHf3BtEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzei3zIxUMdvOX7rcD95+zo/DVTRLvuOpjQQKRbp1bvCGrAoRDL
	X2Y7htxSm6/OaTz2OMwWbki0Ke3V7yvm7CFhGR98cXZySB/N5CHU
X-Google-Smtp-Source: AGHT+IHC3CcsBdgIYL8zNBp6LoDVitIvPZK1ghXQGkZE9j+h2UaZlRuaPPhxVjULi/irhMkxC0ZVHw==
X-Received: by 2002:a05:6000:1867:b0:37d:4d80:34ae with SMTP id ffacd0b85a97d-381be7adff4mr11841424f8f.4.1730669205634;
        Sun, 03 Nov 2024 13:26:45 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:43 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 11/11] staging: gpib: Correct check for max secondary address
Date: Sun,  3 Nov 2024 22:26:17 +0100
Message-ID: <20241103212617.13076-12-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103212617.13076-1-dpenkler@gmail.com>
References: <20241103212617.13076-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIB secondary addresses can be between 0 and 31 inclusive
unlike primary addresses where address 31 is not a valid device
address.  When 31 is used as a primary talk address it
forms the UNT (Untalk) command and when used as a listener address it
forms the UNL (Unlisten) commmand.
The library was incorrectly not allowing a secondary address
with a value of 31 to be used.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/common/gpib_os.c | 4 +---
 drivers/staging/gpib/common/iblib.c   | 6 +++---
 drivers/staging/gpib/common/ibsys.h   | 3 +++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index e84097ac8f69..0285180ae1f0 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -525,8 +525,6 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
  * SPD and UNT are sent at the completion of the poll.
  */
 
-static const int gpib_addr_max = 30;	/* max address for primary/secondary gpib addresses */
-
 int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 	  unsigned int usec_timeout, uint8_t *result)
 {
@@ -538,7 +536,7 @@ int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 		return -1;
 	}
 
-	if (pad > gpib_addr_max || sad > gpib_addr_max) {
+	if (pad > MAX_GPIB_PRIMARY_ADDRESS || sad > MAX_GPIB_SECONDARY_ADDRESS) {
 		pr_err("gpib: bad address for serial poll");
 		return -1;
 	}
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index fc57e760c144..db1911cc1b26 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -479,7 +479,7 @@ int ibsre(gpib_board_t *board, int enable)
  */
 int ibpad(gpib_board_t *board, unsigned int addr)
 {
-	if (addr > 30) {
+	if (addr > MAX_GPIB_PRIMARY_ADDRESS) {
 		pr_err("gpib: invalid primary address %u\n", addr);
 		return -1;
 	}
@@ -498,8 +498,8 @@ int ibpad(gpib_board_t *board, unsigned int addr)
  */
 int ibsad(gpib_board_t *board, int addr)
 {
-	if (addr > 30) {
-		pr_err("gpib: invalid secondary address %i, must be 0-30\n", addr);
+	if (addr > MAX_GPIB_SECONDARY_ADDRESS) {
+		pr_err("gpib: invalid secondary address %i\n", addr);
 		return -1;
 	}
 	board->sad = addr;
diff --git a/drivers/staging/gpib/common/ibsys.h b/drivers/staging/gpib/common/ibsys.h
index b78ca5ea4da1..da20971e9c7e 100644
--- a/drivers/staging/gpib/common/ibsys.h
+++ b/drivers/staging/gpib/common/ibsys.h
@@ -16,6 +16,9 @@
 #include <asm/irq.h>
 #include <asm/dma.h>
 
+#define MAX_GPIB_PRIMARY_ADDRESS 30
+#define MAX_GPIB_SECONDARY_ADDRESS 31
+
 int gpib_allocate_board(gpib_board_t *board);
 void gpib_deallocate_board(gpib_board_t *board);
 
-- 
2.46.2


