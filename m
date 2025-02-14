Return-Path: <linux-kernel+bounces-515719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD5A36820
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE587A39F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4381FC0E7;
	Fri, 14 Feb 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zww4VEQR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC471FBEAF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571145; cv=none; b=sruLrQJ9dGllIHaU48l4JD4YlkSepsvLVQ2suSS3BKrNju9bCBoP+wMEi967JW1NCEvILhgehgtvP6AhleyWJmKJNI7F1yV4ZoFrBvbGtVmUwwBknRaJtpmL/vksJi7fmdUYYnE1RDJ38uXKT8znWYNgPJDjdoNImWU35tusoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571145; c=relaxed/simple;
	bh=q2owWyPoWsIKtUCbyM2y0u++DqG8LhIcy9fWzr8dvAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m98bkiI1Xuo3ZY1EsTipemG5eVU6EmApi2O5ap4LslAVUwjxdeVHIAvH+LsGwEWe0C3zjk2m+zH+8hd/LLIdTQlGX7krxDZXmdt0lXHn3sACQ/Nq0IJOz+wUEy9B7mE8aRpZH2vT9Wt0SpdwsbBFSZSagyXH05etEbDXtgycY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zww4VEQR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f78b1fb7dso44937525ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739571143; x=1740175943; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lScjnaVql87BCc5KbYHZKv7cwTVkkzG/eari/JxcOQQ=;
        b=zww4VEQRaJCvChJMpSfFrY2VeNh1hEdMIHYTZKuyPKHWM2bRaEl6DeK0xRUVGMA7GQ
         atzUngtOzyVIGZBaRRj5sgXgzj+SdW2pRh70ZKTTPAAYLCit+1Z9ZQmqZ7PRaQLrmm6k
         ZS81MPcj+TlQxlICSevqcqz17DDK+5WQA/KK3xJD3tJCJYWzEERxVUunO6YCjxwYEbXv
         GIADJgTS3bxSUw9w/YC+s5ro8jfieGwGFLRYwMdPXy7mg+qQoVs8Jvu28eN7NrqGHy+g
         v3d6O3CQ9nxDHag1yCxYMqBFtZ4DzoPOlNeYVpYUBuNzqwmQWjo91N61+RW9DxGN72kv
         3QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739571143; x=1740175943;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lScjnaVql87BCc5KbYHZKv7cwTVkkzG/eari/JxcOQQ=;
        b=SEv4aFUi7N/pwqCfg6XcDTfZdt/KIattmafkIm3+Ww5pCey6Hspc3frEiULAbuTheY
         i7eF0LR4gXayOTosYmduRAQg+FqyEkaMF2WKAyjJdIMK5kAnTJEJ6Bac09l2GlcHd1C4
         ijm9b44i8TRGWx3jUh+KV2VdG39A1Bqq1h+U4S99gqO7FJQt0iFW6hRQyVlMW1L/wlPk
         r0U38YraKb+6Vhw03U9vwA15LoHcZ3DzLFLVyBNdV1D3v3EDx9XGqXmVYUFA/UEhNp3D
         WJX5UYjrFNRed0rnGN/c46Z7cjXRvHTbUSJkEwBDu5e5s2RgKTFmztrp//Jem3zWTpm0
         dD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWhFR5S80jMcVYE23Y1rArwY6+zlfUtFnVMupyIB9bP/OwoPPCLnCrHDWPF7KJXHzNtHyxVLBOXOfWkt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVNAJ1xpSXvtHIAo7FlRPLp1vg8CujjrDSOkkyXbGaM1okDMT
	9jgfEFyMOsjdlsydN3iAbzvpSDi3CbM0H27YBhrnEBydATa8QVqn9LTGxorc9w==
X-Gm-Gg: ASbGnctGHRBGtnUvSTRj/3OOotCCOkwCrqea6skAiuB9r7NgnoApOvK2Ua/IvM5t8OM
	yocg+Dt620d0uu+p8yv+vjT15EQqaef1xNpGnsEtEwvFmsceHwcLbkj9tkCk9fUeretzygSXfeR
	FVmFgEkjpojymY3W/TL5fI5xFuUhm25L3+8oU4JIkqtH5BPaqCxTYZ1dB4C3HpOdGKB0dIsrTHW
	Hi5DtnKlSSzurrzvExTXJX69teY07JifuomQvXZSBQJDsiUA7UPIHX/j9+bdqRaQwb3ZlnsureH
	WZN7F9Olhl2JrwqYRTTETXTPpSph7cKJgB+uegB005uDxSTaps1EexrUgCBzSfLvve1fSQ==
X-Google-Smtp-Source: AGHT+IF67gcvkUhxalhA0rGnQafYsSbnzpwQo0eJ2VPe6LYLSnv6boQUy/ypxfItcDFX1gM1IkUhVA==
X-Received: by 2002:a05:6a00:3d06:b0:730:9204:f0c6 with SMTP id d2e1a72fcca58-732618c2a69mr1593129b3a.16.1739571143291;
        Fri, 14 Feb 2025 14:12:23 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324fb3a761sm2031460b3a.178.2025.02.14.14.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:12:22 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>,Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>
Subject: [PATCH] posix-timers: cond_resched() during exit_itimers()
Date: Fri, 14 Feb 2025 14:12:20 -0800
Message-ID: <xm2634gg2n23.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

exit_itimers() loops through every timer in the process to delete it.
This requires taking the system-wide hash_lock for each of these locks,
and contends with other processes trying to create or delete timers.
When a process creates hundreds of thousands of timers, and then exits
while other processes contend with it, this can trigger softlockups on
CONFIG_PREEMPT=n.

Ideally this will some day be better solved by eliminating the global
hashtable, but until that point mitigate the issue by doing
cond_resched in that loop.

Signed-off-by: Ben Segall <bsegall@google.com>
---
 kernel/time/posix-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1b675aee99a98..44ba7db07e900 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1097,12 +1097,14 @@ void exit_itimers(struct task_struct *tsk)
 	spin_lock_irq(&tsk->sighand->siglock);
 	hlist_move_list(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!hlist_empty(&timers))
+	while (!hlist_empty(&timers)) {
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+		cond_resched();
+	}
 
 	/*
 	 * There should be no timers on the ignored list. itimer_delete() has
 	 * mopped them up.
 	 */
-- 
2.48.1.601.g30ceb7b040-goog

