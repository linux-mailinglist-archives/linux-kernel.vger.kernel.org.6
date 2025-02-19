Return-Path: <linux-kernel+bounces-522314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA083A3C889
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E0189BCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBAD22B8A8;
	Wed, 19 Feb 2025 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvMYyPfa"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A422AE71
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993075; cv=none; b=fq3KJitZppazov8cH6RN3pmsAJfqqIIDtDTUf30AsxMAa5zBAJIuRy4VQw6OyPLemQRhlvlrAQaFuW75cI8uQL+mOMjNe1u8EEp0OQsFYUOWUcEpxi+ZtybSB9vHHi8GEiUVyAbiyaYnWuwb4lCvMMl9ys3OODos1wBsE9ri3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993075; c=relaxed/simple;
	bh=ZYkbcZrrQGiPCooqHuRFFRoxMmtwFxrC87IqlH845AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4M682iUhqY8NZHYF4+dAnnqe4m9zAT4wtnKFF2b10hyHm0cR1YsDT5CLzwaX1wWSHeZGSsy3Ghd4Lx9XLJZ+BxC6f2JtTly5I1S+V+br2ck6PDpXaeFet5PSPTus5VWoeEwoNScGILZZyVPAAIbf+qUl+v0r/PjSnl6yH5XqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvMYyPfa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221057b6ac4so1435465ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993073; x=1740597873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imv4Fy4Ni24H9C5OwvFflIrm55rNyjL166O96KHQcLw=;
        b=TvMYyPfasomktMiXol9uIS4SWmG41AKn5dVKWXfWro2Oo3aIfuZanednNAmkumGw9e
         9XrBV/HoScLuf3VWqVOJeO8AOOsfqgTeNKMOvf1GqwIZ9V6l9dTa4Z9GtW/5TzFsueU1
         3AKsdznCR84VWqSmnD7NjR6Yov5XfWuJR+sJtV4dZkFHg6+hIy32u/P6qVCb9wZODXH1
         y0vaJbSuCtzZEX1Aa01aYF/TK3cVc5F7rIimFndS2LLejb1ZdRPsbyAtgsPGqukHjMN9
         k5vTlSW4MAMGYvODVkUmfUUFeVV3A/PhSzCicrQVEU/ToOmidvp2RZvyRLbeRBhQHl+p
         9PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993073; x=1740597873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Imv4Fy4Ni24H9C5OwvFflIrm55rNyjL166O96KHQcLw=;
        b=nVP3w9uWCR8+i926Dtizwwqrg+rlV02sIt0I1zzAYA2HUgLi+NR+iBR7qjFD7TUZUE
         Gq7ob96Im1xYuDUXRMkOd6xhlv7CYrtd0D1TE8m2zlX8Es3TaCm2h+K/qZY4MlSVpoCG
         fVpPCS/t6I2E1ymZAoG3EFvwssO5GysXpVw9bfvHmLgCOU8MbWyMdViX/H9VXnatxQgc
         g+rUlR3/FrFShT3SnZCdYQo8pPaSZw9nhFlNIHJmRRcQc4GOrWG6fOtQsU4fZ1kAr4SH
         F7mkcrut9lRJ9aLvDLmKZXjdQiPblnd5Wfn4ctiSTFNQaQTRm8pxDZATRCl9G+O9BPjo
         p3CQ==
X-Gm-Message-State: AOJu0YxN9bm4rXad21kRaAQ4Ky8h4fAjL9pqjgfWUQ9Qezo4tpR/kWLQ
	1z6amkBkv4Mmeby0ETdVo+mLl7+Z0minyH0higS20eZFOc8lEREm+DOSt7W6Fzk=
X-Gm-Gg: ASbGncspmOO/jZDVeGku/ltCxBfpXJi1eZvFgyd6Qnl4uHpXJuO33ldZwCA6Lw9WK7u
	NbRmVMVcZUkRWiIlFhAnIqiqR327pHQEsgmMt9p2XvAUVRSoqO6aLNvhuwmJywjXrsFJBTO1Lw6
	YgnUVj4rgmCjdRdlt+p95JizUhywRyDEOA7+tkk7MZbcgzdCCU3VWpqdnOqHmM0LI0TiT0F61+6
	TKISx7yxtjf89zuJCCH0GLUCXPTpuoLPZL9cnuSnnFfMkVAdMZtmTuRgXx6fxWOHvwsLboNZm47
	OF5gbtvaoxXfMuQWiZ+FDI7XTNDmHjzO3djrRUZ3UF46KTcVI+EvMpQYGa48VSSNv3+lyKKkZr1
	5lwXe6LaI
X-Google-Smtp-Source: AGHT+IH0ojEhENEJFVgmbGNRlJbASVR8ZPt9CTzqDSlVOeIL+9BEtqC4yfVXOy7I1zwWHUGmegorlw==
X-Received: by 2002:a17:902:d4d0:b0:21f:6dca:6932 with SMTP id d9443c01a7336-221040d819dmr320069425ad.43.1739993072766;
        Wed, 19 Feb 2025 11:24:32 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb58618479sm9615322a12.33.2025.02.19.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 11:24:32 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] tty: ipwireless: Fix locking in ioctl and write_room functions
Date: Wed, 19 Feb 2025 19:24:26 +0000
Message-ID: <20250219192426.164654-3-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219192426.164654-1-surajpatil522@gmail.com>
References: <20250219192426.164654-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add mutex locks around tty->ipw_tty_mutex in ioctl, tiocmget, and write_room.
- Resolve FIXME comments related to locking ambiguity.

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/tty/ipwireless/tty.c | 178 ++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 78 deletions(-)

diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index b6de40815fb9..c4befc3d09f9 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -229,21 +229,21 @@ static ssize_t ipw_write(struct tty_struct *linux_tty, const u8 *buf,
 
 static unsigned int ipw_write_room(struct tty_struct *linux_tty)
 {
-	struct ipw_tty *tty = linux_tty->driver_data;
-	int room;
+    struct ipw_tty *tty = linux_tty->driver_data;
+    int room = 0;
 
-	/* FIXME: Exactly how is the tty object locked here .. */
-	if (!tty)
-		return 0;
+    if (!tty)
+        return 0;
 
-	if (!tty->port.count)
-		return 0;
-
-	room = IPWIRELESS_TX_QUEUE_SIZE - tty->tx_bytes_queued;
-	if (room < 0)
-		room = 0;
+    mutex_lock(&tty->ipw_tty_mutex); // Lock added
+    if (!tty->port.count) {
+        mutex_unlock(&tty->ipw_tty_mutex);
+        return 0;
+    }
 
-	return room;
+    room = IPWIRELESS_TX_QUEUE_SIZE - tty->tx_bytes_queued;
+    mutex_unlock(&tty->ipw_tty_mutex); // Unlock added
+    return room < 0 ? 0 : room;
 }
 
 static int ipwireless_get_serial_info(struct tty_struct *linux_tty,
@@ -351,85 +351,107 @@ static int set_control_lines(struct ipw_tty *tty, unsigned int set,
 
 static int ipw_tiocmget(struct tty_struct *linux_tty)
 {
-	struct ipw_tty *tty = linux_tty->driver_data;
-	/* FIXME: Exactly how is the tty object locked here .. */
+    struct ipw_tty *tty = linux_tty->driver_data;
+    int ret;
 
-	if (!tty)
-		return -ENODEV;
+    if (!tty)
+        return -ENODEV;
 
-	if (!tty->port.count)
-		return -EINVAL;
+    mutex_lock(&tty->ipw_tty_mutex); // Lock added
+    if (!tty->port.count) {
+        mutex_unlock(&tty->ipw_tty_mutex);
+        return -EINVAL;
+    }
 
-	return get_control_lines(tty);
+    ret = get_control_lines(tty);
+    mutex_unlock(&tty->ipw_tty_mutex); // Unlock added
+    return ret;
 }
 
-static int
-ipw_tiocmset(struct tty_struct *linux_tty,
-	     unsigned int set, unsigned int clear)
+static int ipw_tiocmset(struct tty_struct *linux_tty,
+             unsigned int set, unsigned int clear)
 {
-	struct ipw_tty *tty = linux_tty->driver_data;
-	/* FIXME: Exactly how is the tty object locked here .. */
+    struct ipw_tty *tty = linux_tty->driver_data;
+    int ret;
 
-	if (!tty)
-		return -ENODEV;
+    if (!tty)
+        return -ENODEV;
 
-	if (!tty->port.count)
-		return -EINVAL;
+    mutex_lock(&tty->ipw_tty_mutex); // Lock added
+    if (!tty->port.count) {
+        mutex_unlock(&tty->ipw_tty_mutex);
+        return -EINVAL;
+    }
 
-	return set_control_lines(tty, set, clear);
+    ret = set_control_lines(tty, set, clear);
+    mutex_unlock(&tty->ipw_tty_mutex); // Unlock added
+    return ret;
 }
 
 static int ipw_ioctl(struct tty_struct *linux_tty,
-		     unsigned int cmd, unsigned long arg)
+                     unsigned int cmd, unsigned long arg)
 {
-	struct ipw_tty *tty = linux_tty->driver_data;
-
-	if (!tty)
-		return -ENODEV;
-
-	if (!tty->port.count)
-		return -EINVAL;
-
-	/* FIXME: Exactly how is the tty object locked here .. */
-	if (tty->tty_type == TTYTYPE_MODEM) {
-		switch (cmd) {
-		case PPPIOCGCHAN:
-			{
-				int chan = ipwireless_ppp_channel_index(
-							tty->network);
-
-				if (chan < 0)
-					return -ENODEV;
-				if (put_user(chan, (int __user *) arg))
-					return -EFAULT;
-			}
-			return 0;
-
-		case PPPIOCGUNIT:
-			{
-				int unit = ipwireless_ppp_unit_number(
-						tty->network);
-
-				if (unit < 0)
-					return -ENODEV;
-				if (put_user(unit, (int __user *) arg))
-					return -EFAULT;
-			}
-			return 0;
-
-		case FIONREAD:
-			{
-				int val = 0;
-
-				if (put_user(val, (int __user *) arg))
-					return -EFAULT;
-			}
-			return 0;
-		case TCFLSH:
-			return tty_perform_flush(linux_tty, arg);
-		}
-	}
-	return -ENOIOCTLCMD;
+        struct ipw_tty *tty = linux_tty->driver_data;
+        int ret = -ENOIOCTLCMD; // Default return value
+
+        if (!tty)
+                return -ENODEV;
+
+        if (!tty->port.count)
+                return -EINVAL;
+
+        // Acquire the mutex to lock the tty object
+        mutex_lock(&tty->ipw_tty_mutex);
+
+        if (tty->tty_type == TTYTYPE_MODEM) {
+                switch (cmd) {
+                case PPPIOCGCHAN: {
+                        int chan = ipwireless_ppp_channel_index(tty->network);
+
+                        if (chan < 0) {
+                                ret = -ENODEV;
+                                break;
+                        }
+                        if (put_user(chan, (int __user *) arg)) {
+                                ret = -EFAULT;
+                                break;
+                        }
+                        ret = 0;
+                        break;
+                }
+                case PPPIOCGUNIT: {
+                        int unit = ipwireless_ppp_unit_number(tty->network);
+
+                        if (unit < 0) {
+                                ret = -ENODEV;
+                                break;
+                        }
+                        if (put_user(unit, (int __user *) arg)) {
+                                ret = -EFAULT;
+                                break;
+                        }
+                        ret = 0;
+                        break;
+                }
+                case FIONREAD: {
+                        int val = 0;
+
+                        if (put_user(val, (int __user *) arg)) {
+                                ret = -EFAULT;
+                                break;
+                        }
+                        ret = 0;
+                        break;
+                }
+                case TCFLSH:
+                        ret = tty_perform_flush(linux_tty, arg);
+                        break;
+                }
+        }
+
+        // Release the mutex before returning
+        mutex_unlock(&tty->ipw_tty_mutex);
+        return ret;
 }
 
 static int add_tty(int j,
-- 
2.43.0


