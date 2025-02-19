Return-Path: <linux-kernel+bounces-521558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E532A3BF47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03563B93EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3B1F03F8;
	Wed, 19 Feb 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4GVMkfWa"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943D1EFF94
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969731; cv=none; b=Bmg+3cYRaM6BVX1eshbEgmsn9M1LfcphJkXcg6X9G4hZY2qgLco/d5LgaIEvfLpni/tDyWe1KNujKXZEOcUTBkG83Px3H2urLvb1QzybEqW9Kyj1qzSixgJgzfuMHk9TiK848uWXm9OI20k7TgYBwtRkHrQtni6m21Mnb01aZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969731; c=relaxed/simple;
	bh=hTWh0S/kO+ddBssr4RWhOpg2O+uuBTdPLr4p+YMc210=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AahfPIdBBFFmvXIlUqMf7hJEQBWkx5d2GRBrRbqPXc05vXCIaKBEnVRl+ZmlZubU37AyJAY3HGv0486HL8PImxR6y6n5yPi96J8nHM5J+g0RMOfQmd6kLsB7G24HRhvGMfXabpClSD7sWjnbQr2hMeSTMEECjDRW8ZwFAOm/ygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GVMkfWa; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-471f08bd0bdso63016941cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739969728; x=1740574528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvtCJCFO4ZH16O04eSMYTdc4XJU1IA2ReSwEN4Affzo=;
        b=4GVMkfWawU4oranoshcrkaYeVag/xKU9qPSzd1dkSk7BPasGD1IGzXObt2Fo06t7hr
         EbBqimxSyVVcMCb2LyRXFgMO6ZpXhbfWZuBNqyu6ROfG1Vd+t56hYGzhB1VZj85BXbRx
         o7BBhYwbJg1+8IMYHmy+wrVg0I/WCUln/kZTQvXH9EwVtzOhheB64bnYzlbzgRAvi1cP
         I9ULEblohEiJ4WA3cWQ74kGBiHV/kY7N7daNg/zlpjpZSHwTAmUkMCZUWIrS4wTh98ho
         cSPXtTVKz7FtC/ltY81++C2W5Lwe/hofv3aRc3cRjJb2sOj+myDelpi1CRIR55r05l6s
         WAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969728; x=1740574528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvtCJCFO4ZH16O04eSMYTdc4XJU1IA2ReSwEN4Affzo=;
        b=oYr+e70QvYGLX7+SHvZlaOd4oV8yxw81JGtOBDj7UIMQtEBIs7EIG4hAJDEtA2obE8
         SCVDCXAn4MRmSdF2YiR27k7XyalOtGNyDJEl7hkXdYEa2q6zFLRzoixJbvY8qL+iDSy6
         zfsEw8Tf7aCUGBo6wb/+eLtm5+4HIUsGzLHsE+TH0jxwbIG2ZzM+QxZbWLyubd/SvkpJ
         IG9LhLhvQac/lBmZmEzHBjR2igEyYCyyqTww55pmvrhu/+cGxMAeOOiTflcbeArDH+O/
         YXOK3j0PYgSm9Lx2t8zJnv2ke+XpDkgZvHJ7TRYXhZxBK2i9UavzRDQ0rMbmKiVIFt2T
         pldw==
X-Gm-Message-State: AOJu0YyQjNwml4lHvvx9VnT4FllEayhYRRCTLbkKEFRptyOotel7ZBgl
	N7cwSiKqB7rth4bpZ/+5mDOsS+7+jqzJny9Wu7Ii46t1+884RY2bk4NARaRYrlrvfOGzcEHyiNf
	uDKZ7oJqxhQ==
X-Google-Smtp-Source: AGHT+IG698mpIVkANi3thGeaLy6YzVcvcPcUZ6wDN3EpWc5ASqq+qArjlVoau4d9wWH+HJZVkhv+y7OB6bKwzw==
X-Received: from qtbfy25.prod.google.com ([2002:a05:622a:5a19:b0:471:f25c:e47d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:740f:b0:472:1040:10b2 with SMTP id d75a77b69052e-47210401398mr7711961cf.39.1739969728679;
 Wed, 19 Feb 2025 04:55:28 -0800 (PST)
Date: Wed, 19 Feb 2025 12:55:20 +0000
In-Reply-To: <20250219125522.2535263-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219125522.2535263-3-edumazet@google.com>
Subject: [PATCH V2 2/4] posix-timers: Initialise timer->it_id in posix_timer_add()
From: Eric Dumazet <edumazet@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

A timer is visible only when both timer->signal and timer->i_id
are set to their final values.

We can initialize timer->it_id sooner.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 kernel/time/posix-timers.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 204a351a2fd3..1f73ea955756 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -114,6 +114,7 @@ static int posix_timer_add(struct k_itimer *timer)
 
 		spin_lock(&hash_lock);
 		if (!__posix_timers_find(head, sig, id)) {
+			timer->it_id = (timer_t)id;
 			hlist_add_head_rcu(&timer->t_hash, head);
 			spin_unlock(&hash_lock);
 			return id;
@@ -407,8 +408,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
-	 * because new_timer::it_signal is still NULL. The timer id is also
-	 * not yet visible to user space.
+	 * because new_timer::it_signal is still NULL.
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
@@ -416,7 +416,6 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		return new_timer_id;
 	}
 
-	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
 	new_timer->kclock = kc;
 	new_timer->it_overrun = -1LL;
-- 
2.48.1.601.g30ceb7b040-goog


