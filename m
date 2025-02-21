Return-Path: <linux-kernel+bounces-525233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FEEA3ECD1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07693B871D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA51FC7FD;
	Fri, 21 Feb 2025 06:27:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E271D89E4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119245; cv=none; b=sLesUN1lWZ4k6Sv3BBwj5Z3K7EaWv77SAzOycejQUVqcxeif+db7iB1JFFc3krTW8QUKkgJ1PIzNg6dLA8i/OHFUzCLKaQWRVz+SEao0miVVrsFuU2eB0FqZz/dmM6ahE3styguG/t6gln171EZA7f/4sLOLMoN7GtCw14Tu3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119245; c=relaxed/simple;
	bh=YKD/Cfl+vYsZCe3VdzJOK6mIyvsX2PUF7jrAoY5w2yM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cODv1x7qihQ7EgwiNk42H2UZT7bwka3OhBVxc1JA5u3+2xZEMbb6lB+w5uQyR3uXsqcxyyuZTHmCUl824eLWcVQTUR/H8t2GhehQSQ5XoTF2gAKo2cRttdeFVHpAmwXDAXt10NDTXbn/6G3YoVNZb7peJdaxV8xSup56ZEX1Yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a1d6747aso16667955ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119242; x=1740724042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uefWQBZ1CRw7S0yD4k0VqfPiM/jCJvnlCe0rXxx2pjM=;
        b=N25995JM8A+tMQDjjrW56Z3h7tEZe4pxx7eIJ14FYXJySKWn/Yx4pmQXyNbEUgH3He
         bhxa993zgztnidxyDGXV2GlgIdCJrg3xOZd1XifHhVVCORsgK4rCrTQIvF+2/YvpB00Z
         VMqbyeVXbZjvPHR/nUR52D5YWQfQHbuVRJz6lIWnfJOP44p+WQYi+wEuP4zLwU56Vh+2
         aOG52HxOESc2/AiBblFPzFvpX89bYod7JC4oYBZl6SJ892Orft4JOrctDonSozsw73n6
         9WtWmfdoNGnr/de2L9NDX3QaMdIddwLnsy4Ros4nEH7eyK5nmZ93Xkx+q0qG0xlspU9j
         705g==
X-Gm-Message-State: AOJu0YxRvpbqou/MsYX3V8U11pDbuDApKI4QrRmwIDP6lF5UqNa2ZQW8
	O7Srwysl5xTeDML2z0SnEbs5OojLvcHqHSZiNHTw2u2jWZLhmP1SczPNkaLA2QYKwJbyQupt3IF
	1Qj24RykxXJqAiuWwTM4Wq5mid5ULHiNu28mQUs6G3g9VQWDMqjVqCA4=
X-Google-Smtp-Source: AGHT+IEQnsmk1XsQRDYXVPZ/7Z1y74mWBSoEAdlQzFFRI6/i2uzi5YpIubNxbFttUsiRAnTvAgceEpHPzj3OOqX3qyQM8+NHqFZG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:3d0:f2ca:65aa with SMTP id
 e9e14a558f8ab-3d2cacb153cmr17288695ab.4.1740119242779; Thu, 20 Feb 2025
 22:27:22 -0800 (PST)
Date: Thu, 20 Feb 2025 22:27:22 -0800
In-Reply-To: <67b74749.050a0220.14d86d.02b4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b81cca.050a0220.14d86d.030b.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [pm?] possible deadlock in lock_system_sleep
From: syzbot <syzbot+ace60642828c074eb913@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [pm?] possible deadlock in lock_system_sleep
Author: lizhi.xu@windriver.com

#syz test

diff --git a/kernel/params.c b/kernel/params.c
index 0074d29c9b80..d19881fbb2ec 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -583,7 +583,9 @@ static ssize_t param_attr_store(const struct module_attribute *mattr,
 	if (!attribute->param->ops->set)
 		return -EPERM;
 
-	kernel_param_lock(mk->mod);
+	if (!kernel_param_trylock(mk->mod))
+		return -EPERM;
+
 	if (param_check_unsafe(attribute->param))
 		err = attribute->param->ops->set(buf, attribute->param);
 	else
@@ -607,6 +609,11 @@ void kernel_param_lock(struct module *mod)
 	mutex_lock(KPARAM_MUTEX(mod));
 }
 
+int kernel_param_trylock(struct module *mod)
+{
+	return mutex_trylock(KPARAM_MUTEX(mod));
+}
+
 void kernel_param_unlock(struct module *mod)
 {
 	mutex_unlock(KPARAM_MUTEX(mod));
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..cbcbfd8db721 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -306,11 +306,15 @@ struct kparam_array
 
 #ifdef CONFIG_SYSFS
 extern void kernel_param_lock(struct module *mod);
+extern int kernel_param_trylock(struct module *mod);
 extern void kernel_param_unlock(struct module *mod);
 #else
 static inline void kernel_param_lock(struct module *mod)
 {
 }
+static inline int kernel_param_trylock(struct module *mod)
+{
+}
 static inline void kernel_param_unlock(struct module *mod)
 {
 }
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 0d056db9f81e..aecf7ff51cd9 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -217,7 +217,9 @@ ieee80211_rate_control_ops_get(const char *name)
 	const struct rate_control_ops *ops;
 	const char *alg_name;
 
-	kernel_param_lock(THIS_MODULE);
+	if (!kernel_param_trylock(THIS_MODULE))
+		return NULL;
+
 	if (!name)
 		alg_name = ieee80211_default_rc_algo;
 	else

