Return-Path: <linux-kernel+bounces-409983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D44D9C9503
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6D71F244B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC01B0F26;
	Thu, 14 Nov 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKmQs4r2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDB1B0F16
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622175; cv=none; b=lfeuQpmqX2zrbFVUlhLkNK0WP9HOddNOnNAdgLTqSiGQJvg89F7nEBrsda8RkXKWaemiQiF9ZkcS5C/pntRgca7RaJEK5LJjaWUTXYeEuJ/Z8T+e/ypRJJTjQYCsG+bgi/xUldy5mRqqSc9QOV9W/olBBqM89kn35geeCyr2Fdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622175; c=relaxed/simple;
	bh=FXF39w61mNxxA37BRFFzg13pzMbcauk0JxD5udDvbNs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=sDBhuS2nZoGahDhL5MSGHSzsz8XMDx2bUcjhhPp4a9hoRhBSPTkuUUTFdhlq27kKJIxdY0E3K+zp00gysxjGIWUE2bOiSuXUdGuonJgtGaDMjM6gDjjnNh9tcmpBl4p/S3luDBgfNoPXtHz88Kf4J4ooTt3j1BwnxD9N07CXKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKmQs4r2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e6101877abso22224887b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731622172; x=1732226972; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltTqN1vUYgDIEjeUsRotinFDZNC54N+YNek7x4otQhk=;
        b=uKmQs4r2sfC3N2Mm7T2NPt45wuhEGXkAJMkPw7WbYrUDhKq7XytcCvX+dG6PAm3ARv
         BUqfTU4MmipuMSBC4cGnYPJ3lUaoz/MQcrUeRGdogxjxPkZnoH1ywkUHPK8NjHxHLaKS
         hqURQBeQoCRKxMEEJ+edmHiMsuPMqrTuPyKLAloP1l2aEySylV6qBYlAeMXqrSM+DYAL
         8pBVh6acwfE2t+muBWyg+gwXSWeBm70ZksAY280ICgADkfwJfl4HVQ3PCeOb2o6UmgoI
         jcI0WmpsXMCs8Ka5vw50qV5ZKceb9h/j2GmBxm0SDIP+lENi4951lz9pazRNBHSxqs9d
         1s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622172; x=1732226972;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltTqN1vUYgDIEjeUsRotinFDZNC54N+YNek7x4otQhk=;
        b=c2TjlXfBeblYU0QwyDRP4bMFSYmyw5o2vm6W1EAY1Ii97fHbbz+T39s12+Jn4TpXL3
         RnmqmcQ5GqQZ8cpkf92AMIX1IvmLDcKkUH+2X7261BS2Ui2/hwYuw/FGVzXaFl46I062
         lz8q8ME5cLl/ukbVPijhxpvASBy9NGQyh1a146aJVRvHIu2F1da4FBkS0oygk8Z3Dd9J
         U1prY02aFUBDfO9TZBuN6AkWx5XIQ+q9kERBGuJKzmO3IOWiWXxzhYmR0pOPvXO6REbi
         dGEkz8Y9yXSaTL7lRAy4TXsMGJNBuu9VJ7GkujS9oE5ujVQVqUsGSlNTG8xrvt7qrkOu
         GheA==
X-Forwarded-Encrypted: i=1; AJvYcCUfv7IY7CqzKpKFhiSLoBxOdb+ANVnrjO/gGLN/TEh+bjVtKf3vd6BpeqNszEE6KKqfBL21jOKRulO+lpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjdnr2PfiVEkzhEXecgOpiLIfuGYlEabVnEMNLpKNOk1vRS6i
	QBT1br3/1KN09bkwz50AwltuaB2b+7V/5Ht/vAJBIulEWkZDkdnjCOKWzUoBz42oFsPtubKN4WP
	34CNFm63qC+myEw==
X-Google-Smtp-Source: AGHT+IGJ/4jVZ1/xg/LGCl3APYeAMNbxGDbBEvRotblohLu+ttsAW0UM3N5LDvfVv2yeayzGHKI14yjv6HYVEP4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:3e23:8355:c37:686e])
 (user=saravanak job=sendgmr) by 2002:a05:690c:6806:b0:6ea:8dad:c3b1 with SMTP
 id 00721157ae682-6ee55c9b324mr496857b3.3.1731622172602; Thu, 14 Nov 2024
 14:09:32 -0800 (PST)
Date: Thu, 14 Nov 2024 14:09:15 -0800
In-Reply-To: <20241114220921.2529905-1-saravanak@google.com>
Message-Id: <20241114220921.2529905-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marex@denx.de>, Bird@google.com, Tim <Tim.Bird@sony.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some devices might have their is_suspended flag set to false. In these
cases, dpm_resume() should skip doing anything for those devices.
However, runtime PM enable and a few others steps are done before
checking for this flag. Fix it so that we do things in the right order.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..86e51b9fefab 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	if (!dev->power.is_suspended)
+		goto Unlock;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -931,9 +934,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	 */
 	dev->power.is_prepared = false;
 
-	if (!dev->power.is_suspended)
-		goto Unlock;
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
-- 
2.47.0.338.g60cca15819-goog


