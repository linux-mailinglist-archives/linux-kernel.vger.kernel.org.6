Return-Path: <linux-kernel+bounces-384277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED649B28E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEF0B216AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5331DACBE;
	Mon, 28 Oct 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AB7/brsO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lYCXeFyu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F519308C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100745; cv=none; b=e9PVxTKCwqEowQ+orM8Gp6jzGSBb16VgmzYHUvt++ZWKiY0sH3iyihR20dnzLzXSAcs8eZeHrFKZ/ELW0HDJTPgto3IQMuqtnBeKksLS/9H8OkWrNtnWlN8rsPMI2P/wk0/cHoSHqtcgj+KJ+xetEpzGnULla6TIxtzXInej7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100745; c=relaxed/simple;
	bh=DfHnjs0zRp77LMFhFnQjrRmXjAyDlcatya5U1zQD+z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNfV8mbdh1YLFYhsNoI/v/dFPNBF4++MDMDg8hsq3ZIbkYPijTjF02VdF71VHLRqXkzSdAv82ut9vYXzhXY3V7HDAr+E6IkJVPHo/0eI7SGVurD6QSSRHXFuXFtGhp1JTsM9Q/uGn3MlHfFdrkmAhywRZbar4lTT6D6QJElm4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AB7/brsO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lYCXeFyu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYDkJHwStlxtqgAaPv1XWIrF0br6yxUQpyGRGxVNX1A=;
	b=AB7/brsOOZashvaJvWjcHNsQi8e4ViQmrqoscqmASYO81a5sKQdplF6TaFO9rxfl6WCIcZ
	UpdXIxZ/+SzLs31ddruQzAaaKubkf2lgSXjoHD+77ajOfYTZMiNVaZ3UlWyGucLTd7C47O
	4voDyey+PNfQSkHtqkyCYC9xundMtr41FxnycFdGEw5CJlBcjqHny4Ty8OEUxuIandz4G/
	DhmwOUUKM8Yu96zi90KG0LVJBGyv/isjSe71lN8lBsiFh4/LFjdEJ4nsE/nm9WMHKGfvLt
	N9TlRBuwhRiRxzTDHemirDZUlbYRzthNdtVWkg3Br0qR/mBvYXh37qc92p7UNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYDkJHwStlxtqgAaPv1XWIrF0br6yxUQpyGRGxVNX1A=;
	b=lYCXeFyuJxV1cM6MbN5yT79IgPeG5AdOJaj4HYxxJMFBh4/b/Afa97H5xejA1bF/fHMCBy
	bK642+60bJAuiTBA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 14/31] rcu: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:47 +0100
Message-Id: <4c07452c5f64a4e44158d74d27ad0693b9f20ffe.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: "Paul E. McKenney" <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a60616e69b66..686c4bdbd62e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3701,8 +3701,8 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
-			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-			krcp->hrtimer.function =3D schedule_page_work_fn;
+			hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
+				      HRTIMER_MODE_REL);
 			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
 		}
 	}
--=20
2.39.5


