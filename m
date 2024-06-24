Return-Path: <linux-kernel+bounces-227919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD90915815
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324EE289401
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EAE1A0701;
	Mon, 24 Jun 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxT7x1qs"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99572233B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261339; cv=none; b=caR1NYa2iKF29Ch46xlfOVhU7RjWTSB+h+6E+OBPYtSR81YFYLfRysOvF6Yzc82sWuDcFnnyS104US+2IRI5z3ROR6Je3VXpclkPzaCdFO87AEPa7aEvQnnEcYIhhyYn3hNMxWZuRTHmqwtshYerl5J9juuuLD161rcIgPr5Nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261339; c=relaxed/simple;
	bh=t2WHFftN9rlHIJhD5JJVCsz500XsaF72JpBt/WyhP6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AwvoVxwGPnAgwZ1N/XqPJCDPb1hyc2ImRIAu2Pbg+XdWCfGCQQC80zSMPrOKgG+SP+DGGmZbqhJF9Xipw56GACi1TEVn8sE+Db4dPerYPxZ4QjPa23hG0cHCf7WXsSgEzwT8k4aChtHZgUN7yu2I1R27gWBP7T4kIrSJ89swgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxT7x1qs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cd717ec07so3799286e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719261336; x=1719866136; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fcNbsOWCwJr2/5W99IL/3KzZfqHaHDr9PLIvOms/0Y=;
        b=KxT7x1qstHHj670nqrRQphQgv82ktPyP8gNkj5nZhUj+fO+iT2NGyetXmTNw4pqzB1
         RqN5Wlhs5dHJL2OVPG2uFLrVkAWS6euAYBj6RofSgHyqBJ3hfCgmrPAJBVNAihEL2jBA
         SxEf+gQshKYyOEwudank/G6gfXnVpJKhIIX3yWdaXcFCGLwNpY4rG+/fPjbE2DoTaEgG
         DlCOYJUh5SdnSZt01zpa6FVFqRKeevjOKq289lPQTe8SOfKtdeBoZMQRTBxJLHynkr7+
         ISa8Gt/RGxQTMw6hnykiaJY5PwKcAkapH7lgNbHhziQxvZEHnD2P64KpCtiyuRJnef6l
         zB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261336; x=1719866136;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fcNbsOWCwJr2/5W99IL/3KzZfqHaHDr9PLIvOms/0Y=;
        b=P+3U/36hKFdQ/G17qf3eA9E+APGaLo8YwfhfhkUyhRv+eUWxG7wYOFOLzdDmRma+Hm
         Wjv0dIcl4pZ8rVn66blaRnc/uj50sMMbR5xLRGBFE2t8QAlJq54zvPtTabcS18rOrVAf
         00vi7973obP7D9oY7UqN9kT1+EJMmrmMkMjaZ0PvBWauozXww5rjWZKad8HC7RmkAZ2D
         8sC8lGHXIyjFMt7g1mT2pVY6xUlbU2yhhiqq25hoTsEPOmDH5R2ctL766ENwJT33v4X+
         vzAWMv40nhxWsUD4RdR3LP1aegCMV0t3E5VEW97yzobgUn1TI1MEmHB5203uc7oz0u9X
         vIag==
X-Gm-Message-State: AOJu0YwyBc41upTYdNqRcg0rwNi+lJ7kniq0571sWZ1cR2ZB1ZpqerPM
	OVfxDIAED8IJc98oumKvcTkr7jkWqxHMgpLZYAQunRrGJAVni1Y=
X-Google-Smtp-Source: AGHT+IE6XzjXMIhT6w8TZ7D1mQybX6Cu4fGEdINFShC3xQedSZGwyOn1jziUJh8Bip7LB5PdXt9dug==
X-Received: by 2002:a05:6512:3a8b:b0:52c:e1d4:8ecd with SMTP id 2adb3069b0e04-52ce1d49146mr4071645e87.8.1719261335734;
        Mon, 24 Jun 2024 13:35:35 -0700 (PDT)
Received: from p183 ([46.53.250.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72546ac874sm143893766b.103.2024.06.24.13.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:35:35 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:35:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mutex: fix comma placement in mutex initializers
Message-ID: <0773b142-4928-401b-a510-462afee0924f@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Move the commas in initializer macros _after_ initializer itself,
so they become disentagled from each other.

C99 initializer clause starts with .identifier and ends
with optional comma.

Trailing comma in ifdeffed initializers should be mandatory,
so that following snippet works:

	__DEP_MAP_MUTEX_INITIALIZER(lockname)
	.bar = 2,

Leading comma should not exist, so that following snippet works:

	.foo = 1,
	__DEP_MAP_MUTEX_INITIALIZER(lockname)
	.bar = 2,

In other words, conditional initializers should be written as

	#ifdef CONFIG_FOO
		#define INIT_X(val)	.x = val,
	#else
		#define INIT_X(val)
	#endif

otherwise it is possible to construct an example which won't compile.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/mutex.h |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -26,10 +26,10 @@ struct device;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
-		, .dep_map = {					\
+		.dep_map = {					\
 			.name = #lockname,			\
 			.wait_type_inner = LD_WAIT_SLEEP,	\
-		}
+		},
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
 #endif
@@ -37,7 +37,7 @@ struct device;
 #ifdef CONFIG_DEBUG_MUTEXES
 
 # define __DEBUG_MUTEX_INITIALIZER(lockname)				\
-	, .magic = &lockname
+	.magic = &lockname,
 
 extern void mutex_destroy(struct mutex *lock);
 
@@ -65,12 +65,14 @@ do {									\
 	__mutex_init((mutex), #mutex, &__key);				\
 } while (0)
 
-#define __MUTEX_INITIALIZER(lockname) \
-		{ .owner = ATOMIC_LONG_INIT(0) \
-		, .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
-		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
-		__DEBUG_MUTEX_INITIALIZER(lockname) \
-		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
+#define __MUTEX_INITIALIZER(lockname)					\
+{									\
+	.owner = ATOMIC_LONG_INIT(0),					\
+	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock),	\
+	.wait_list = LIST_HEAD_INIT(lockname.wait_list),		\
+	__DEBUG_MUTEX_INITIALIZER(lockname)				\
+	__DEP_MAP_MUTEX_INITIALIZER(lockname)				\
+}
 
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
@@ -93,7 +95,7 @@ extern bool mutex_is_locked(struct mutex *lock);
 
 #define __MUTEX_INITIALIZER(mutexname)					\
 {									\
-	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex)	\
+	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex),	\
 	__DEP_MAP_MUTEX_INITIALIZER(mutexname)				\
 }
 

