Return-Path: <linux-kernel+bounces-259958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296193A07B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8601F22E31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E92152503;
	Tue, 23 Jul 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="wQb6taeN"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AA14AD17
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737529; cv=none; b=CDf7aFRqJnsrVNch8o8c9AkZkLDJE9/fF5n+t/8N7V7iSWACjv03Z/6pxP3wEom+F7sJNSS9+HwEknHSQYR+qt8DdgIM8IE537oWaXe4oXg6QlQsCCQYEILUS3ZVPS8zHJTbcFc18+1TAIO7vYRnm4LGGhWYspolwBBZJyAFi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737529; c=relaxed/simple;
	bh=o41f5Tohm6RdJTQQRltIg3Tz4FTINsoa8D2H8tZmyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja7eGWPY6ldbIoKSi3Jy57cQwcczdfwTwie5NqjtTkynwZbMo84nmgb0EshAm93v/dQN34FCCZUkIjIhUGPKW6lrI63BP5GR1dkN2z+NAZ1AR4KhGNOYCDcvk70qzTdMGnAZoeJBKYHMwXSckAMXgTBluzCLp6CvIqfIO1O7gGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=wQb6taeN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so4778897a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721737526; x=1722342326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWLWrwOfQQwvpb82Ri05DZJIfVLjHwkbuOCygTlxvVc=;
        b=wQb6taeNGhcQl++VynHTY2Z+gnUvMC8gEb/oQqaGDizGX7jOx0XZcZvgkq9Ddnigy0
         FD7OF00W5/hwG4SZNE/wzHp6Cb/1gMyo1aWyiKhLZlk6W7wyA2VIWOW4wp9Iq4FP2QVt
         /uJpIsVPmnZm9sOyfXy8yX/zBjecZjuVHET4V7WRAgAQFq3cSZXXsj2Fg/s/8EjAtj6Y
         effWQU2SvSFbFpmRW2z+DmcWYvAGZxX2V/5fwjbYqJE4Miemz5jJByk+ncm/P5w/DXtD
         2DMb0XUJrk8jTqJm6M/Bzrex+adCitqabLa+8fE4HYgQs5sBEOhVa4Z4wWcHhIR+tp+L
         Y2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721737526; x=1722342326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWLWrwOfQQwvpb82Ri05DZJIfVLjHwkbuOCygTlxvVc=;
        b=NS50ATsCM3KPLxMrJmZpOeu9RbaWJZYb5PR7cPGyb8h563U3O7R/gtcoukYfgKr1U2
         02AvFCQGWg0bGqxsZjotGERdz5p4jA3acnZnF/cwxy92VDdzkHptUJxkdbT/LzkX3/IS
         W0YqxRU/zUh910ZDES+Qgc1BYxQ+IfDF6p6Y9gPZVLDLAZ5IdtVxWqAmKiwT1mV5Pvxn
         lf4JWwfFqSmNOdsj41nos6xo7h5ktUP+lsQQDnkGOaAUM27CINLzyj+RacTnYi/JCXxF
         1bhgxVOcM4kezmb3t1gpZeh+N/lqPeYnxnnF2eDbnJ4YMg/C89sS6OZzlVTAtA8mIShz
         S1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxfyLRy/EeVLcmthAzGv0qEA+B8t8V47+aOWBtuXRAS42gTZA1o76l/vE9baMq8FwKveH91ZrFcgt6o2fpa/CTQhsal7uXjAYhDXvc
X-Gm-Message-State: AOJu0YyVKoIbRm8JcRXjvzi6j7qifv8+VOnPQEu5kiRG/pTbo9VAgNG4
	nEsQJs/oALK7ZcCsD34ZmxeEQEYtKYVCf4rotshj+08dNLJ+v3N6MCrU5LxBX9Q=
X-Google-Smtp-Source: AGHT+IHejtfZTTOCdvtSWuiN4OnUD6qZPK+5w37awVBNIdpDWvpgnPPs3yN5J6y/7WYA5nZc5yqbcw==
X-Received: by 2002:a05:6402:3507:b0:5a2:8802:8e10 with SMTP id 4fb4d7f45d1cf-5a478b64facmr5881011a12.8.1721737525753;
        Tue, 23 Jul 2024 05:25:25 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af04ba00bd1de83dc7c21243.dip0.t-ipconnect.de. [2003:f6:af04:ba00:bd1d:e83d:c7c2:1243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6c17sm7489026a12.5.2024.07.23.05.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 05:25:25 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH] eventfs: Don't return NULL in eventfs_create_dir()
Date: Tue, 23 Jul 2024 14:25:21 +0200
Message-ID: <20240723122522.2724-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722201125.3fa6314b@gandalf.local.home>
References: <20240722201125.3fa6314b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing
ei->dentry") added another check, testing if the parent was freed after
we released the mutex. If so, the function returns NULL. However, all
callers expect it to either return a valid pointer or an error pointer,
at least since commit 5264a2f4bb3b ("tracing: Fix a NULL vs IS_ERR() bug
in event_subsystem_dir()"). Returning NULL will therefore fail the error
condition check in the caller.

Fix this by substituting the NULL return value with a fitting error
pointer.

Fixes: 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing ei->dentry")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
v2: send as a separate patch, picking up review tags from Dan and Ajay

 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5d88c184f0fc..a9c28a1d5dc8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -736,7 +736,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
 		cleanup_ei(ei);
-		ei = NULL;
+		ei = ERR_PTR(-EBUSY);
 	}
 	return ei;
 }
-- 
2.43.0


