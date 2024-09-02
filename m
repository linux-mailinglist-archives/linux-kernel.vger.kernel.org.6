Return-Path: <linux-kernel+bounces-311343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D69687CC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4372D282703
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64A19C571;
	Mon,  2 Sep 2024 12:45:56 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556919C568
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281155; cv=none; b=bY1BajyS/0GHQChey1TIEkQJWFlSG+oSEXEL1KaElQZKUabi4qC7m9cdsl5eGbMtiw/wetkqoE6azaP10eVvYaDA6DCN56C/cvstE8BalBRCZkUg7nGrzgxI8DAtcfPzRNNS6WfZSxex3TDorQCcrzOeBEOpvKW2aq4CQpEZY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281155; c=relaxed/simple;
	bh=uYsHxLuHJZIJr56L0Vvtawi4qoB2c+phHDBrTKbc0Sc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TduSjH1UHYmQcJSzVFP8dQdknzENx0JaJeSw9ZRYQPUnqz2cxcVgfdN2CzhoSN8QMdFy0vyEjvnd/UunV0LnKWWtSVNBlS5JCqZ8opzFdh2IS8eH1jCrMVVmWo8DDnQ8LK0Ib7K1+tsbofluQ7jzaRrOW1xKgJMULreWYEe3EWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a22983440so409195939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281153; x=1725885953;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uo+4GfjsR8tsHvCztE0nGkiZJOcVLBMdCgATtyGJMj0=;
        b=QI3BrbO+IMpa5nBU5pB+tLqHU7kgBjFNzztxfI2FQd+Zw9HinyMIHeAwAvYZBxpdam
         NTAABR0wySiAxoOmgg0QwAUJhfWGgQyxdkjZh8Zv0X9+r6QUsHaUspwRUE8VMqib7Iik
         EViW9IFiZpDHpBMsKtEiwVRFgDAsjVuGi2MM4BhQaM39XgYTRVp5BD4u1XDsR1xcvhDU
         BQhszVXWrgLxj7o9neS8JAyDG/ZoWgsR/3WyXYKJH27k6b3IUkAeO86yGfTBUPylBzre
         W10aImf10S1MaeEPC6y6rg6bUN7T2Jiz2YoAS2TEh1enwgz+D5hdaThWTOx71wtpRLjJ
         bmBA==
X-Gm-Message-State: AOJu0YzHDj/CUMzML8KaeIm1jjN+tzPkCgH96c3oQio6zdRP4hC7SeXy
	Ig7n8GN85BonnUoHjs9CEE0GrIx6Xxi0VtYObBVb/7udtsqVsbQWB4gdF6RzQ23GfqMA3YwTS5n
	ZVC3Kj/CfLhP7eVeXZCv127IrG2L+VCSTJPQOJzqSgjNJ68eB0tIleas=
X-Google-Smtp-Source: AGHT+IGGKQCsC5it4jGPvOvcSEK8hyGQ+y1qWAC5ruV0DIWkq8SavWn7oVniZOfuCPWHSo/RgHMgE7CV2ayoX9AnLJge/ia0VJoZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:359f:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4d017d9e5fcmr355270173.2.1725281153668; Mon, 02 Sep 2024
 05:45:53 -0700 (PDT)
Date: Mon, 02 Sep 2024 05:45:53 -0700
In-Reply-To: <000000000000acfa76061fcca330@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d698e0621225251@google.com>
Subject: Re: [syzbot] possible fix 2 (upstream)
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix 2 (upstream)
Author: almaz.alexandrovich@paragon-software.com

#syz test: upstream master

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..c08bbacc0030 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -125,8 +125,9 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 
 		if (de) {
 			spin_lock(&de->d_lock);
-			snprintf(name, sizeof(s_name_buf), " \"%s\"",
-				 de->d_name.name);
+			if (snprintf(name, sizeof(s_name_buf), " \"%s\"",
+				     de->d_name.name) >= sizeof(s_name_buf))
+				name[sizeof(s_name_buf) - 1] = 0;
 			spin_unlock(&de->d_lock);
 		} else {
 			name[0] = 0;

