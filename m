Return-Path: <linux-kernel+bounces-563465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DBA64276
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC20716F3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F85921B9F3;
	Mon, 17 Mar 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL/n5AUP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE921B8F2;
	Mon, 17 Mar 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194860; cv=none; b=RNHagxMT/S+anhiQq1f2YCzhRJrVhPxG5OzV+CKwb2Ef/cAtYwwEQvufaWT1vRsriKuraLkT6O6gS2FrObzX84I7NrZ8FT85t14e0RSEq9zI/mg9u6Mq3kfo1FJ6YMh0rThAENurUQdMUtMC0r3oj77Iwyzy7MDugJeDbMJK5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194860; c=relaxed/simple;
	bh=oMwXwvcyJF3+0cugA5/hh39oVHV+CqhbfuVfEziwmAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuEl7Zbw2D/yJugfbDwh5G8UJELTKZXVN8RHe1+CtxHDtIZfWEbRHAr5ZoTECEzcZTvcSgWtnIQlqyhDFIOErn5+2iygPk4HtwBoCvOfpR9Tv6h5+4vPW0ldV6egAivDDdp/zVO1vIyvNxh9xfgld1XWwGQaegL3g9cFf6PdTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL/n5AUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE70FC4CEEC;
	Mon, 17 Mar 2025 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194859;
	bh=oMwXwvcyJF3+0cugA5/hh39oVHV+CqhbfuVfEziwmAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NL/n5AUPun4QKbI0/Tj1AcGrkbxcxx8Ea/Sb8YkPgKeHvMZSjQ5bAT+E6nLUCXcqG
	 krBysS0Dv/r7kDSq8lPs5QzNl/bUJO/IkRN4vpe/lkM22zqq8mGIUWn/eScymj6hp3
	 1iixw69qZi8lfkI2DwyPFvTqPQJGBQlkwwVT3GTi5KM6IxJgvN2HM910MwRV2NdBma
	 XuMqcFqtno2h2ojtCZX+pZu1NgD4yIk/57MmIgn6h31AKrIwMmc77fZ8A5hqofNG+p
	 ygc53VlKT7TWCQwbi1OLpQoo+l1SPjInixxvXph/iIGtPY7fT8L87w10g8cIoAiRaM
	 tbA6OPQOE8EyA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 06/31] tty: n_tty: simplify process_output()
Date: Mon, 17 Mar 2025 08:00:21 +0100
Message-ID: <20250317070046.24386-7-jirislaby@kernel.org>
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
2.49.0


