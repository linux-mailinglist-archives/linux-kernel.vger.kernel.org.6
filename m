Return-Path: <linux-kernel+bounces-353879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889F9933F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398A7283BCF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC61DD898;
	Mon,  7 Oct 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wVSVv/bj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wmAidJn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506B1DD526
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319806; cv=none; b=l17SrgdIYTKDUiGTWrkiNKZeemqAFtqnhWCUFAI2j69UkKsIQ+m69XhyOpgLqBGKDAPFnhiKuhBc5rL/GyUCXYbz02xKfJXkw7MSYazegg4B4pfd13GRg+egokE0LNUlzIwc1jwvWqQ0avyB0ytJ18ZQi/PMPH0Nu0tBRPJLxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319806; c=relaxed/simple;
	bh=BDvn3gp1vcsg9Kvk8ehmQgzJPA6KnCVv5EqekyqqmB4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lwgzyuqlZG0tJWgvTUfvV9ir7YLR4NDMiwjKH/4Aae3+QUTNZTrB/sG8Nvgb2R8GuBtwEKHvxqTPQzaxEpTTrnsZKL03OWHYP13Zk8WVjuDmOmlIACUxz4sEYv/R3/vnlQ0EzvKFUPOkLTvCQBDfyitDdjV3m0MgO6j/rDANasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wVSVv/bj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wmAidJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.518175013@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=x8QWV5IHGvnzH9KgJaFacufBWJ4RoY7ciLDJXLETEmU=;
	b=wVSVv/bjsHzP9tZ9Q7UJF/pdjpOhP2wJJvsjKZY1S89z3CtsDCpy4dhEZPp9p0tVvifJqk
	QqQHD/w/+d8lMWFw+QV6a2xqWAkrABbdSLydRvZk8eHPcoqgDM68f24r7/dj8kboPE/uiX
	IO0z/ttIcVibuIVH58MWIuxOs8LLiq79PAeJqpKLZ0kXbrOTHlpliI3T7nwJYnB6CBKrfW
	ubhenrSbOPC37IZaGOrKCnJVsosPKC/yvtWhcSzJWgGNks7e2HcION2ap8+GwUMhC+b8aa
	4efS40jenayvbp6VGTlnMWEYfwtzTF/sMebjAGAaqWVE+/ivFCdsHxIq7cEtqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=x8QWV5IHGvnzH9KgJaFacufBWJ4RoY7ciLDJXLETEmU=;
	b=0wmAidJnoNM6mUoIxLAcMsUZMH+B+2H8tnlWuHD2/rwmM0B8X5fa/MMlqO32wnbEr9yLsH
	q2DLRrNAfuFSWRCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 09/25] debugobjects: Make debug_objects_enabled bool
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:02 +0200 (CEST)

Make it what it is.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -82,7 +82,7 @@ static int __data_racy			debug_objects_m
 static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
 static int __data_racy			debug_objects_fixups __read_mostly;
 static int __data_racy			debug_objects_warnings __read_mostly;
-static int __data_racy			debug_objects_enabled __read_mostly
+static bool __data_racy			debug_objects_enabled __read_mostly
 					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
 static int				debug_objects_pool_size __ro_after_init
 					= ODEBUG_POOL_SIZE;
@@ -103,17 +103,16 @@ static DECLARE_DELAYED_WORK(debug_obj_wo
 
 static int __init enable_object_debug(char *str)
 {
-	debug_objects_enabled = 1;
+	debug_objects_enabled = true;
 	return 0;
 }
+early_param("debug_objects", enable_object_debug);
 
 static int __init disable_object_debug(char *str)
 {
-	debug_objects_enabled = 0;
+	debug_objects_enabled = false;
 	return 0;
 }
-
-early_param("debug_objects", enable_object_debug);
 early_param("no_debug_objects", disable_object_debug);
 
 static const char *obj_states[ODEBUG_STATE_MAX] = {
@@ -592,7 +591,7 @@ static struct debug_obj *lookup_object_o
 	}
 
 	/* Out of memory. Do the cleanup outside of the locked region */
-	debug_objects_enabled = 0;
+	debug_objects_enabled = false;
 	return NULL;
 }
 
@@ -1194,7 +1193,7 @@ check_results(void *addr, enum debug_obj
 out:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 	if (res)
-		debug_objects_enabled = 0;
+		debug_objects_enabled = false;
 	return res;
 }
 
@@ -1278,7 +1277,7 @@ static bool __init debug_objects_selftes
 	descr_test = NULL;
 
 	local_irq_restore(flags);
-	return !!debug_objects_enabled;
+	return debug_objects_enabled;
 }
 #else
 static inline bool debug_objects_selftest(void) { return true; }
@@ -1372,7 +1371,7 @@ void __init debug_objects_mem_init(void)
 				  SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE, NULL);
 
 	if (!cache || !debug_objects_replace_static_objects(cache)) {
-		debug_objects_enabled = 0;
+		debug_objects_enabled = false;
 		pr_warn("Out of memory.\n");
 		return;
 	}


