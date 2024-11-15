Return-Path: <linux-kernel+bounces-411516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EABA9CFB5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A6A1F2471C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5AE1AF0B5;
	Fri, 15 Nov 2024 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUXB8PkW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B11AF0A3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715079; cv=none; b=FYxIYLO/i1SEfaD4tv66y44cZf6TcNchVep6xdTKtApBXfCXgP9TEgKy/yeMa9DkPRytMxxhxzpwBF6IzHH6Pk0xsHOXGU7+VBOouAXCObWjdtznWZvLiw2DnMkqserKsunOnXOjf6jRGyuB/HDo9pHSopRw+jc9O18cb/CM9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715079; c=relaxed/simple;
	bh=U5OvCqcfqrzZtkEXj5rehLA6GV4QaIif1hwP802Uifc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QiusE1OrLJr6d9rNx9B5y18KT2tg58dMU2iDWkNRJnRsX2fwUxPPQebJL7ITTJmjZ8aWDi9TiBxagjsKxmNfbK/JnoNQUWASZnIY+Uh/F8vzVE3VlR8FCrnVBR7vtHvFvROsDLdstYZbSgcY2c6C6UglPt22fKO3eygWg9IP6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUXB8PkW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3877744e45so1195807276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731715076; x=1732319876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8v8w47B/bBInLDR9iMbQaYJ5893IHUb3TRGhZ/es2aI=;
        b=LUXB8PkWISG9v/p4/ZNWDiQn7I+5NHYAVQI3Dttgni8aLyuteeOGhTlj3WJiSVOCqp
         +Pf0+nFKLHrn9GAICHynkXhbCmnTIyp89Jyfh8ZAkH4E5A3RtynNHsr2MnI73bBDIVWy
         ivVih/ALmRItWeGVTV5JJu+7jRHNQHIssXI2FVcVCWHepgoiTxQFtNBmKLhhzoEVtVKe
         t245eEdyDgvcUJQtCiulCwX5vLcKNSTPNT7vhNwPliiwQKfarPMfD90XCC+9H23cdsom
         mccw/vnGvIepsWTn7bMSoll2+ax7yBhUS0b1L/410PxqiyMO08we9nExEhVjGrTNp1CC
         yDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715076; x=1732319876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8v8w47B/bBInLDR9iMbQaYJ5893IHUb3TRGhZ/es2aI=;
        b=Dr//S6owos5KWDpYRNE2vmsqqZ2kM1I19vNr7EZiDI+goSwdgKc1uAN1caI+GeutkJ
         vN1WspTkEeouqilk0CeZoTaLeqAlA9IskTXOz3SVLL/slNlhiu2DY91yqy6OJ58iLFbh
         b2ZJehHcvtCr1pFITc8ONLliqOuNyMzj26XGSeAJvmUQZPKh7uIyMquuWY/EuI5aGzH+
         W1Wqr6hL6/6W69eui6Dd4lHLkyKq7o4OQq0CsXY8MdLol8YX1vWpwba36wHsIUA8Scar
         nqnfKsxngO7l+XgiuKyfmXu5+KGHtcGOgX0BtS3j0jnUESHk0Q1Hafi76FknXb/YZhM3
         PMtA==
X-Forwarded-Encrypted: i=1; AJvYcCX6SezZXY31eS741U0GU7buD3bgtTA7BISR1D28qePkchRIRg9KsMm9Grqemuc6BVSfVOkMG9f/l4ooIDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEGwjBxzZLh6wS8CRWk3ePzK+Ci6CBv5oDjJ9OUJKRT/LxC5V
	vj3Z/8M7IkGOPTIzFR5SXjOu0ucAfN6gXiJYqOWEEaLEqDWCoSLhVOS1PyEAupT5+VTCIuQsC6j
	eJ/otqIg/4w==
X-Google-Smtp-Source: AGHT+IH4TgoU+sKXZ0e1vdMN9iVrwBlb5RZLub5gn85SQYiErjlQ2PRdfhYiBYV7ArscR5hQT2dD43dztdIdSA==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:f2d6:8e6c:5a90:ef1e])
 (user=kerensun job=sendgmr) by 2002:a25:bb0e:0:b0:e38:2136:9482 with SMTP id
 3f1490d57ef6-e3826614e75mr3788276.10.1731715076563; Fri, 15 Nov 2024 15:57:56
 -0800 (PST)
Date: Fri, 15 Nov 2024 15:57:42 -0800
In-Reply-To: <20241115235744.1419580-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241115235744.1419580-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115235744.1419580-2-kerensun@google.com>
Subject: [PATCH 1/3] mm: prefer 'unsigned int' to bare use of 'unsigned'
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Change the param 'mode' from type 'unsigned' to 'unsigned int' in
memcg_event_wake() and memcg_oom_wake_function(), and for the param
'nid' in VM_BUG_ON().

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 539ceefa9d2d..465201ef40b7 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -899,7 +899,7 @@ static void memcg_event_remove(struct work_struct *work)
  *
  * Called with wqh->lock held and interrupts disabled.
  */
-static int memcg_event_wake(wait_queue_entry_t *wait, unsigned mode,
+static int memcg_event_wake(wait_queue_entry_t *wait, unsigned int mode,
 			    int sync, void *key)
 {
 	struct mem_cgroup_event *event =
@@ -1216,7 +1216,7 @@ struct oom_wait_info {
 };
 
 static int memcg_oom_wake_function(wait_queue_entry_t *wait,
-	unsigned mode, int sync, void *arg)
+	unsigned int mode, int sync, void *arg)
 {
 	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
 	struct mem_cgroup *oom_wait_memcg;
@@ -1658,7 +1658,7 @@ static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 	unsigned long nr = 0;
 	enum lru_list lru;
 
-	VM_BUG_ON((unsigned)nid >= nr_node_ids);
+	VM_BUG_ON((unsigned int)nid >= nr_node_ids);
 
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
-- 
2.47.0.338.g60cca15819-goog


