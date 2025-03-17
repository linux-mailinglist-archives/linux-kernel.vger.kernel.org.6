Return-Path: <linux-kernel+bounces-563470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45517A64281
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9D416F671
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911DF21CC7B;
	Mon, 17 Mar 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujYvSyjZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012A21ABB7;
	Mon, 17 Mar 2025 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194868; cv=none; b=BGA+WsHl/OrWQqdhQ0nnJ4nVs1obbDV7BzpG8BWJLJdt56Mv5SIx7cYc1f4kQkEzvHsgxiKJPtRnvfJe4nLALh2qIjjT5btFxkL5D84qI8s2bizhjbopcYozhNrW6qH7yg3ssqYCVV/JgFWFJKBPpnyoh0uMZgFKl08yP9OVII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194868; c=relaxed/simple;
	bh=OCRjQPfORu1jFCTk4sWvvQt3O/fs8afQ659O4ETP8QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dih6Q8LNRvZ5reaIUCETwpWUMGv8GiAyTCivPWEGfm1k+2mHwShEmIUZxckRF0SmgcHYksSkzm5GxsRA7PAX9jear3Q9Di5wNDrJH1DyY6ecvN7JrCaWzUqBazOBc4fsjx2fDpVJCmiP9OD3yLoMLmqlGjcw+J30N2QfWyOUrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujYvSyjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A9CC4CEEC;
	Mon, 17 Mar 2025 07:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194867;
	bh=OCRjQPfORu1jFCTk4sWvvQt3O/fs8afQ659O4ETP8QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujYvSyjZc4z8Ud75Rc6FZCsmekXHF3sAb72Xl0Aqd4dOW34HJ5pw75SBUPTXV7wIP
	 y4z1tQlL30xtJXKbewqezaLzbPNYX42PMs1Do4s0U+jMKaMH0FSZ6A0NzjyXYHc6jk
	 A211+0shszF3KRWolV9KATAJOix8vdrPpIadXmMa0de6w9JxjXLpK+Knx4kkKwI/51
	 RQy6x2iCl/HEXvoS9BBT+UV82dbWc5xDdySonpQKcyDRplGu99BOqihpAhukp1XRfY
	 UXbINEoem27TCxDfnHYa08umDKowmDtucE/heghNcDdolbjV2gA4JhmFHDQQ4ecD1U
	 l6I2KGklfY7tw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 11/31] tty: n_tty: move more_to_be_read to the end of n_tty_read()
Date: Mon, 17 Mar 2025 08:00:26 +0100
Message-ID: <20250317070046.24386-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_tty_read() contains "we need more data" handling deep in that
function. And there is also a label (more_to_be_read) as we handle this
situation from two places.

It makes more sense to have all "return"s accumulated at the end of
functions. And "goto" from multiple places there. Therefore, do this
with the "more_to_be_read" label in n_tty_read().

After this and the previous changes, n_tty_read() is now much more
easier to follow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0e3eb18490f0..6af3f3a0b531 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2281,21 +2281,8 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 				nr--;
 			}
 
-			/*
-			 * Copy data, and if there is more to be had
-			 * and we have nothing more to wait for, then
-			 * let's mark us for retries.
-			 *
-			 * NOTE! We return here with both the termios_sem
-			 * and atomic_read_lock still held, the retries
-			 * will release them when done.
-			 */
-			if (copy_from_read_buf(tty, &kb, &nr) && kb - kbuf >= minimum) {
-more_to_be_read:
-				remove_wait_queue(&tty->read_wait, &wait);
-				*cookie = cookie;
-				return kb - kbuf;
-			}
+			if (copy_from_read_buf(tty, &kb, &nr) && kb - kbuf >= minimum)
+				goto more_to_be_read;
 		}
 
 		n_tty_check_unthrottle(tty);
@@ -2322,6 +2309,18 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 		retval = kb - kbuf;
 
 	return retval;
+more_to_be_read:
+	/*
+	 * There is more to be had and we have nothing more to wait for, so
+	 * let's mark us for retries.
+	 *
+	 * NOTE! We return here with both the termios_sem and atomic_read_lock
+	 * still held, the retries will release them when done.
+	 */
+	remove_wait_queue(&tty->read_wait, &wait);
+	*cookie = cookie;
+
+	return kb - kbuf;
 }
 
 /**
-- 
2.49.0


