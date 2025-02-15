Return-Path: <linux-kernel+bounces-515998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647BA36BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6B91896B21
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD31624D7;
	Sat, 15 Feb 2025 03:51:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60DC158DC4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591464; cv=none; b=Ha32KAyrd0R2+yK/yZhFPgpgA7GNkVhZKJRFiKNyvy8OaJ/Ig0UaNr1/2Pf+05suMWOBSYd9FBMpSCkez/huBA+1I+a+cPYxMPqcCErVvrFm+s/infViDAjNyRFF7TmoW4QbpSXeAJlrFyNzUw7lFXKhyLUIeBWwLA393LI5+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591464; c=relaxed/simple;
	bh=yKfHGyml/VMNQZ7mSWtQVi/XUgZd2/Bs0BnwruYi7ZQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DeGy6Fk4jzAJ52IzYMLjS5L2tY7WIDJPhbjv6rrXgEFephf5ZUYQMi9zgfHeFWxkanmkIGN7dJGnIsxVPJT+kUg1icBBEkiaR6dBx5oc0PfU7QnZKHmiTBzkMQFaqNk31DODGaY/nL8eaP47/T3MX6g8WOejf7yO2OY8jQ+cJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-855757bd7eeso178145139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739591462; x=1740196262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLmmMcItjiW5T7D050y29bFvlKkKUdr0a1D03ZCxE6Y=;
        b=LnHLAQRo9crQJgjzqbL0AWptf++5hqY4104gnB0mg8hEiLbKPS028qq0NC5fHJEwXf
         dLYaTOj9x0AoGQm2a7Kylg3W90nx7uLBJX5OBBERvUnpDROtf6Z+rbhZLKgfIq06GNLq
         LuNteQ8QTlpLmxxielA3BRBHDhe+sYnJOYm+i5eHxDxnCdyU5dhJpZmf6hMovxlkXg1K
         UY8ivme/oT3DHyxm4pMzcGCPza8b+H3FcbNAxdEkGsPZBjGCBknSLGZB893nv5GAsFRP
         d1L16Q8FDmjY/xSPr2WPfCRHXx6JIKqTAb4zh4qyEPwm+QB8+RyGKSHyhus+OD5I40pu
         nguQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRLlS3u62VyUnlJSsvxQkL7qKCxmeGL2SJ1SR50BpAG+nwMhu6qTIsd0teQh7An9Bdqz8LCg3bYaFBdTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLABCq2Dy82fLNfeqD/JSbUdKQs6QGQtaAEIlPNOydLD8/G3n
	l6281hAwpCGD+vJwYrju210nnkmY98alhywpM7LLqouPtOefO1VKflNATyl0U8EWFFGqgB8+ogZ
	CCp2sUZ4YPOeXv9V3cOiHm4D/mwHhy1jhxMMLTh1RLAPI54bsO52RTIk=
X-Google-Smtp-Source: AGHT+IFyL7mENl9r4qKQu3JVUhZqvQBsiVKwwuM4LTW1c/0GQPW+UMLY1S+vI6YaA9t6ikkZs2f/sN6B9Klg7I1mVONC2/0kHvIo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3d0:3851:c3cc with SMTP id
 e9e14a558f8ab-3d2808f4b81mr12472445ab.16.1739591461877; Fri, 14 Feb 2025
 19:51:01 -0800 (PST)
Date: Fri, 14 Feb 2025 19:51:01 -0800
In-Reply-To: <tencent_7DDE136DA373496063A0644EF772177AE605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b00f25.050a0220.21dd3.0065.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/netfs/read_collect.c
misordered hunks! output would be garbled
Hunk #2 FAILED at 306.
1 out of 2 hunks FAILED



Tested on:

commit:         78a632a2 Merge tag 'pci-v6.14-fixes-3' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7ddf49cf33ba213
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132099a4580000


