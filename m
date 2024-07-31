Return-Path: <linux-kernel+bounces-269124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C6942DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5253283CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C41AED20;
	Wed, 31 Jul 2024 12:18:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECE1AB53D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428314; cv=none; b=sZiyd/NttVW7q9769OjYUzO7+3b3tc8tvtclt1uVjYtZiGv35IP21nzdmsP92530ExB6x/l/LFTLKFgHGlZmwpV6i8MWZuexDe3g3DDBmkkfCeJorGG2AXLpCtEs+EUpElsqad2cCJSd1XpJ1QqEKZL60vzF7GHVp64amKMvJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428314; c=relaxed/simple;
	bh=MuYh02UKUWAIt67Nu8OH1W5gFHq2t59cnu8kJLdjg3Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QchQjkPLRkpkYLZwW2haZz8YGvCiWfTBCMFRTXBWLl5C+pmpLCy5Dqfsh99K+3C0jOIIg5nMCTr3zHKoF80wxm4CGhZjmQkvzgUDMX3Kp4/vPYm+wpzsYNkuUWsuBl32tHUOEdBiLIvG18e4ZRMzVfz12wlQGc6Yrz68qKZ49Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a29e7099dso89035665ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722428312; x=1723033112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkWezVdCNBo2q6mYfWIAOeN+XkO2T1zLq1kX/e0ExK4=;
        b=KxAAK2NfQzniou/UIIX6d1H4kTZIivMcBIs5oyUWnI58CSFiMeHIu1drXgGU0TFLVG
         fm4tgqRj9j8IARAnlhgXhSAagmFMA8K0gmxT/E0xKod+vYd2f06i9/mGG9hPTh9n9P44
         t9STt6suN94FCw5iAHNQ1JNF6pmXt8jNHniF+FDf3bfpdBANhQQDz041igidLl5yQyd1
         xnJu8orpowEZBS3nIUbtQJyewzsJhxVTWQq4Xr3DINI86y4X4mfI3L84BzfqfE5nWuy1
         KxOH41saI5KaCCyOrvjLMYYz22A/UIEqAfaMwi0NSLesYgwytgG9mEjg1uzVySoWJn2m
         TbUg==
X-Gm-Message-State: AOJu0YwhvqBTWrcUz1cYc3jhwvh/z6g456oCzQCCELTXeptWCOaGizRc
	7PEmwhIgGrEAMI5AmdtkWkHIY1BcTBwSbZRMfF2wxxniw3hk00dKBzDEOVVQAeh/awSnUts0Upu
	/LJ96Z5nKzcO8ru32mjS7jwPdGYrnBDPqjUoEKI+Km/EzHph+XRdfirk=
X-Google-Smtp-Source: AGHT+IF6rtsS0/z/pfbuRqyWFLb/Vj/iExe4XuY87vmWNvEd8mQmOgQcZ4TuoFir0DfKpnONYriT4gBHfaYwgAgdZqiFB183EdIj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:39a:ea21:1202 with SMTP id
 e9e14a558f8ab-39aec42c56fmr12308625ab.5.1722428312183; Wed, 31 Jul 2024
 05:18:32 -0700 (PDT)
Date: Wed, 31 Jul 2024 05:18:32 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2f64b061e8a1701@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in
 team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master 

---
 drivers/net/team/team_core.c | 5 ++++-
 include/linux/if_team.h      | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..963c8311694f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1621,6 +1621,7 @@ static int team_init(struct net_device *dev)
 	team->dev = dev;
 	team_set_no_mode(team);
 	team->notifier_ctx = false;
+	team->nested_depth = 1;
 
 	team->pcpu_stats = netdev_alloc_pcpu_stats(struct team_pcpu_stats);
 	if (!team->pcpu_stats)
@@ -2947,8 +2948,10 @@ static void team_port_change_check(struct team_port *port, bool linkup)
 {
 	struct team *team = port->team;
 
-	mutex_lock(&team->lock);
+	mutex_lock_nested(&team->lock, team->nested_depth);
+	team->nested_depth++;
 	__team_port_change_check(port, linkup);
+	team->nested_depth--;
 	mutex_unlock(&team->lock);
 }
 
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index cdc684e04a2f..f8b4e3ed4b44 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -225,6 +225,7 @@ struct team {
 	} mcast_rejoin;
 	struct lock_class_key team_lock_key;
 	long mode_priv[TEAM_MODE_PRIV_LONGS];
+	unsigned int nested_depth;
 };
 
 static inline int team_dev_queue_xmit(struct team *team, struct team_port *port,
--

