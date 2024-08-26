Return-Path: <linux-kernel+bounces-301400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C8E95F00B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56CE1F22D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE0215534E;
	Mon, 26 Aug 2024 11:43:55 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486D153812
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672635; cv=none; b=om4lg34rnDokQeBmWZZhIy5ZFltOIHiYtwTSK0KcjxMWd+UPo9ihRIovLQzktTJZeDzqiwTF+f3hEpoio/ngEqJiDcpkffCexd/gUZ+Ky0VD60E+YAsMcrigzTgbwzN9sV4uXnXK5n2EGewgmiRonCC2KfZUZIfH7phlQe3eVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672635; c=relaxed/simple;
	bh=gAgLGhH0c1qS/1as8iF/YImRBgA4ftq9SxtWH9B9jVo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qdf1VuEWpPE7aD4PIL60QN/Co6uT2hXNlPjPjW63i5wmrMByxkhmKeyV22gUDeR2aRJJcQrEvtnusK6FHeGuCsAfX6i4zRQk75zJE86N5QJwKwVY1POwuvYdb+U5kPbTEE42rB5KmPxqnWZ3IWPza0fq3sNxynmsFDCA1ryU3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8252a16781eso450909339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672633; x=1725277433;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o72OovsvlTwhfLWm5kNbPKdV3i2/eOsUb9KJYvKPqdI=;
        b=IijVhonLEFF014TflwAaXteDoH17sQcOwVSqCExvoWETHXsXCDaXChg3yZIJrPmgch
         8OF3ym+jjO+tn9HrLnEfc/87upooiigiAmR8DjL6JDqMkibF4zGCaC8M55FwEwLsklqE
         qMaSMXwDqjEF9HK+g4OmvPdIZ6p0QNfmqOOA3Uukpjtqp62ydwAqvXs73cO5VfEpG8Wg
         ui6Tf/TAAaXP5PyXW5m1cIX6c9s6IzspBHy7laqMMt8MhzUYLyBjD2HSSCck4t+hcDRQ
         80nctUNwitsRkwblFyOyCoANP/fm92XCSryWfIhX0bNxaBs99l9CbuOFsO9vabfzLRhU
         45Ew==
X-Gm-Message-State: AOJu0YxeVOg7X0kk5BeAT3BBJ6a2QdsXPGzupek+TEFqjjj+LSFhVGop
	phz+91PJ02s2LCxZTzsdC93jLO4Fnfho3El5vuqUEZ9a6/mHhaSmpIE+mRo9KXuXdxMvAzWi7dd
	e7MFRNp9MgR9NmVAWUBMK94VAGcpZT4cJyfHGOQxGe3Ewqm5F3ty6q18=
X-Google-Smtp-Source: AGHT+IF0nLQM3UDyGBMAuQsNaPi7083hm0z1p9AipRpB9/MX+mH3XdjOnVKZMd+cmrulMCjzcZ3WMoT2Ks7Oya+XNF+shXUQMjQS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8909:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4ce82868885mr370115173.2.1724672632924; Mon, 26 Aug 2024
 04:43:52 -0700 (PDT)
Date: Mon, 26 Aug 2024 04:43:52 -0700
In-Reply-To: <00000000000045769206209237db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3bc54062094a3a9@google.com>
Subject: Re: [syzbot] WARNING: lock held when returning to user space in ethnl_act_cable_test
From: syzbot <syzbot+c641161e97237326ea74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING: lock held when returning to user space in ethnl_act_cable_test
Author: djahchankoike@gmail.com

#syz test

Fix an unreleased lock when taking the out_dev_put path.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
I'm not entirely sure why are there two labels
when all paths should release the lock, maybe
remove out_dev_put and out_rtnl for a simpler
out? I've kept it just in case, but I can make
the change if needed.
---
 net/ethtool/cabletest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 01db8f394869..c6ca1107c470 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -77,6 +77,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
+		rtnl_unlock();
 		goto out_dev_put;
 	}
 
-- 
2.43.0


