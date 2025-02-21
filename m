Return-Path: <linux-kernel+bounces-525113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263BA3EAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B3F4229B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E31D63C7;
	Fri, 21 Feb 2025 02:57:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C82F3B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106655; cv=none; b=syLvsMtEfc+/FvNtYrG+1WgklHKe9we5fcKl39RbO0XVe3X4fiO+6wmPmYzCkJ9+CKeeCZuH/VPDZB+NWkoT7DvKxiAaSu7wTG+bK33epnHaDbVYHlF6fdocAWZCtFO2mW1H6FzL7r/n3Vfhb6s+EP32N7LiPUKZiT85YYXVDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106655; c=relaxed/simple;
	bh=CnA4HtIdYhRnvDq1132Yx1wwZQ8E0LuGNTvbfoteA9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eTbIR0frLVBr4XOL/KTCaNSrrxi7Luxob4UN5xGnxEIAAM3coNDPZywP8avuQTL7huKaT+ShbDYG+Py7WlbqsITeT7foJdVVQI30Ll5Rmk8g33Hoaj9wGMrvxUCxDzyd4YoK0DoiAsKQywlNl4gB0lVrD7fZAEx7mDnF+bbI010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2ab0fbab2so11934745ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740106653; x=1740711453;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SQ+y50EoQ41D7ljtlSYZkMt4Kp8lECJoiMeLNP95ZI=;
        b=DVpCeBjf9hMHlTbmrdpa2wJ/1UeI4uNoa8X3f68TJDvXmrH8xYyQ+iGqzsRNkft7Gq
         julSqZ2fkb6dNVo08VyFhFPowYsGQ/iYmvGPVyVvvIn7HS6W2KvKdqQYujuyafFVvd91
         mHB5DyLUACfSRpbz14ViW5di53dEGHYb/pGcIiN1DLIESdQUQc/aZ+xS4+k91Yhm0s3o
         sFXDe7zemrI4wUK1g3WgOnVux4mO6v5n+jB2T2dHutJJLqo4/8ZZjqQr2lQ1Q42tsDjw
         n+uqLgOGL/K371a1bG6ciYwaMvOmKX7TGO7dPB4mvmAQIS6y1KdREr0bWKv2RsN7gQrk
         XfiQ==
X-Gm-Message-State: AOJu0YxJn3cHylNitPLsD37QTVQBoe9tXAQnXJuaK0utDAhapaLl6Daa
	E+JKEh79CSSVjOQlMd+Pchl2FszISktf/fMkf46OHQaGJraXJHuMsqE9/eblwlRQ7Ze8flNPnFY
	Vg3AiihrDMYzPu9PjlmXnRCcV9Die6eT+jKPY3cxLO3U5hboOKo14aKw=
X-Google-Smtp-Source: AGHT+IF5N2v38WCvTn1FYN8S1v9cruwf6HTJWAfmb6etFhWIZPpUK4YAiLvbq1xGzpu2DLHKlAuJgA/RbHTBxjsIcCHDAZr0gziO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d2caf028abmr14496925ab.15.1740106652836; Thu, 20 Feb 2025
 18:57:32 -0800 (PST)
Date: Thu, 20 Feb 2025 18:57:32 -0800
In-Reply-To: <67b74749.050a0220.14d86d.02b4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7eb9c.050a0220.14d86d.0309.GAE@google.com>
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

