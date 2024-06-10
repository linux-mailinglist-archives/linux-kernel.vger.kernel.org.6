Return-Path: <linux-kernel+bounces-208175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C669021DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209C6285839
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFDC83CDE;
	Mon, 10 Jun 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ae8f6d+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdmqu4fD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40A823CE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023602; cv=none; b=Zr66wlL8crVoLb08oCYvEKSsJxpkk4fOkv0C8dmhurVNJOOVOqo+wCN24WFPhpZx3TIYjwMU8nofBO/X1BH490HdX34hbVY8C5+y+yoNFJddt3ymj0pfO4Mb+3jScC+uj/BfjExON0PCGSV79XLJ6iltBtYV5rtxn0aa6JbF+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023602; c=relaxed/simple;
	bh=DzfzfEOYrS5hRroqqM63QoncLtcbJosXf0SN2GkmGYw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HnNFMKrR4KNkhOf4vsixE8LzykmsvGtlCZ9TgEm+V7i3qlXg2yDJDPzK/l6Us3A0FKaPINywVmaRQZRKpA2ZOVT/IfCtmgxtkPiSaGNd7wo3dIhGz+ykOaKani7zVR52WzChgFrlTFFCfFzt5Vxr4JeePNPW6TE2pDl7zpzVwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ae8f6d+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdmqu4fD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610124406.548322963@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718023599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6YG0UjVZ2COICpcGaXkn7bT56v/DQnx1rLutVdszFN8=;
	b=1ae8f6d+738dLW/DcQCym/msZK5WZIsZijFafDFY4feUxd4pZuUcKa1BSXnKmDRBHjD5Tr
	GEj5hH48cj/TffXwAAO4JQZ960K9kmMyua9fASlTNhUy+ZcQDEnZriSxohCPVjLNNVh1Zh
	hUwLZQUs3aQmUqtGoxCjRkJAE+WmU53gwGgyKncnVpWCr/ThLVrwn9y+djrzytF3gOHnLA
	Z6W1S/CqE30hNkSsB+2fCEh+dThO36lyeUjll6LzStW8a9/0QIOGDQD/ude6jGuzupQgAU
	mF8h8e4bJqaqtNW8s48dwm1OEa5C7we76cMX94jSPk/azXpHgOasrN8MCZuWMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718023599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6YG0UjVZ2COICpcGaXkn7bT56v/DQnx1rLutVdszFN8=;
	b=rdmqu4fDZwdgg9hVq+KvgzLnTfjhJWIvHjiU3TN/Lvq6deQbPWM/rQ0gGTjx9XgtcBOcQN
	IT7F1TAyJYzaasAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Sam Sun <samsun1006219@gmail.com>,
 x86@kernel.org,
 syzkaller-bugs@googlegroups.com,
 xrivendell7@gmail.com
Subject: [patch 4/4] jump_label: Simplify and clarify
 static_key_fast_inc_cpus_locked()
References: <87bk49xf15.ffs@tglx>
 <20240610124258.109097511@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 14:46:39 +0200 (CEST)

Make the code more obvious and add proper comments to avoid future head
scratching.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/jump_label.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -162,22 +162,24 @@ bool static_key_slow_inc_cpuslocked(stru
 	if (static_key_fast_inc_not_disabled(key))
 		return true;
 
-	jump_label_lock();
-	if (atomic_read(&key->enabled) == 0) {
-		atomic_set(&key->enabled, -1);
+	guard(mutex)(&jump_label_mutex);
+	/* Try to mark it as 'enabling in progress. */
+	if (!atomic_cmpxchg(&key->enabled, 0, -1)) {
 		jump_label_update(key);
 		/*
-		 * Ensure that if the above cmpxchg loop observes our positive
-		 * value, it must also observe all the text changes.
+		 * Ensure that when static_key_fast_inc_not_disabled() or
+		 * static_key_slow_try_dec() observe the positive value,
+		 * they must also observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
 	} else {
-		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key))) {
-			jump_label_unlock();
+		/*
+		 * While holding the mutex this should never observe
+		 * anything else than a value >= 1 and succeed
+		 */
+		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key)))
 			return false;
-		}
 	}
-	jump_label_unlock();
 	return true;
 }
 


