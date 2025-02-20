Return-Path: <linux-kernel+bounces-523537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95CA3D840
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213D37ABFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782621F8EF6;
	Thu, 20 Feb 2025 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlO8jT00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0B1F8BAA;
	Thu, 20 Feb 2025 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050183; cv=none; b=kwi0/vISsMikIiCLJRyrTGnMWVkZeTVlwR3Y3AR/eK9hSS6KEWAyNSSsunijK3r1ETU7HKKGy1TbzmTrqeFPjSYO/m0Q/5XxiHePaD+1xccMY9auUB7+dqlNr81hren2dA++/awOJEt7PiFlrmIpMpW/Zz1QvVXfROBcKeixlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050183; c=relaxed/simple;
	bh=K2Db/pHk+bKaTjC1amufXYjBJpM1A4xCeqqAxJM/LNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxDnOONGpZVEtvD62/E5X+3RXvSq/f66TDekG2t8CuQ2bfN5aLULNq5akDz7FYNGxtRVnkR2ertTjyWDP1ReKyTLEjVYgNXH2uQ8Ohq5LXRW+tEFP7A5C45JzP9ze+m6YEExnJ5dqpNuhjscqVYhMjb4/m9CDFXlUcHDyqZ0W6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlO8jT00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D4AC4CED1;
	Thu, 20 Feb 2025 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050183;
	bh=K2Db/pHk+bKaTjC1amufXYjBJpM1A4xCeqqAxJM/LNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlO8jT00QstZA9Tna3hHRLgI+k2GsSSdOJjZAbzTU5Ap34skNZck9ORfB2c3JLFp8
	 0ezNEWRxaqbbxUyrb6FNimU+zZJTxoqc7qGzUh48VhV3YAwoK0Pvw9LsTMIow9ceJh
	 E8keHIVV6sK3C17W9/PQWsnyE7rkIshfupiEByOQV76MyP/0sbm4VymY28THrq2Zu0
	 CkOic8nhyWEHGM1zHuVV85cW96vrSju1E7epO8D3wjFdFXO3JbO835SITzbHrOyS8z
	 QesscyCDCxTfRKF0a5KV5/PoOV9WAHF2x1rNdt0t8pKBp/wvErYI2wHKODGotEqsOh
	 /sw5fs3cZYHpQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/29] tty: n_tty: simplify process_output()
Date: Thu, 20 Feb 2025 12:15:43 +0100
Message-ID: <20250220111606.138045-7-jirislaby@kernel.org>
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

Using guard(mutex), the function can be written in a much more efficient
way.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 765d24268d75..df52aae5f71a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -488,19 +488,13 @@ static int do_output_char(u8 c, struct tty_struct *tty, int space)
 static int process_output(u8 c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	unsigned int space;
-	int retval;
 
-	mutex_lock(&ldata->output_lock);
+	guard(mutex)(&ldata->output_lock);
 
-	space = tty_write_room(tty);
-	retval = do_output_char(c, tty, space);
-
-	mutex_unlock(&ldata->output_lock);
-	if (retval < 0)
+	if (do_output_char(c, tty, tty_write_room(tty)) < 0)
 		return -1;
-	else
-		return 0;
+
+	return 0;
 }
 
 /**
-- 
2.48.1


