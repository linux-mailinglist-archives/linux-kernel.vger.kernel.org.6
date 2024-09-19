Return-Path: <linux-kernel+bounces-333815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E997CE7B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010EC282BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0E143895;
	Thu, 19 Sep 2024 20:35:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEF36B11
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778104; cv=none; b=TSwlwY2LdMoZffyoHF7seHuMP3MgFeFu88g6ruv99s+FWuZEloKyro9ZsgdCqcRG96R+pOKiF2e5wbtG/3+Li1AIvGF/7aVcWKqRdoF4RkKRQNx1VWPd8118N3fuyqkcMlQV5iGeuGow8ReY4/BCJ7j0qqyDhlswjaQTCJJrFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778104; c=relaxed/simple;
	bh=BABU80/mnFH/GsJ0hUdKH49BxyI7IM79KbRSKeK/+KA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dG3yFXtU0XqZe35BLe2mUVrVA+eO0uNrKlHk51SeIWtztOZP+yAg/Wy/wq3JSGuXIzIP3vWctVyi2bEUgt2k9xUiWKypg3DQpWh8IcjxT+R2F6+qwm429zBJsAYwogEXnID70Y8+1WbVNNa40P1Q+yvMJLT2aDOkNh5kn7ovX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso18569925ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726778102; x=1727382902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKM6B5+ITjFSq3CzrYnH55UezEyThqXYOUxD0V8oUDY=;
        b=sYxxtAJYcS1AQndQ/RAT0CGB6FiMXPNvaIFxYKoBbBdCrrVypF31DdFlTSyKo4+671
         +TnEWLJgIBUklRRNMDxJ+fOl4a8lRRP46Mdu4Kf8jdPF6J7G1n9HWdiZvzRWjrSHVKuc
         XeF+eXuBzgvEBJPGobmI9vHKNFG4/XImw0F2BwP9LA+DOBR/B17qRHp9YoHsrKJZUmK2
         ce7C+AdiN/3PlcF8A+6OjwQUZGB5qaiEdHMwSrBLY4hibMTIn9v2Hy5rv/xsIzx8VqjA
         cGBMoktLeeeFo3YCmk7QwDj5lQGm7Y58qPT3xTDzFw1zFWMvcBKlC+rayoBWKu5EAFg/
         DRhA==
X-Gm-Message-State: AOJu0YwEDQIkVufxk2+nrfz0uTbrMEhpF3nd/NHXqY5x4eNsSOpUsIHv
	RQX6qeqHuwgLIih7YhSS+fUfYd8EkM9QhXb+Rq8hVAhocHLtuWGkh2BWK86mQSAXWVDrdio7PrQ
	vYTEFptPzk1lBKMcoTZm1QJKTmmd8CLmM+6Kb6V/I6O8MFSlZmCE5g+4=
X-Google-Smtp-Source: AGHT+IEC7ZpUbtJc05MgbhCABAeDJz/aQ/fsnTWN/5ya16/V94N4q7gYYsHsqt2W9k5C9CL+bhN9MRmTtii9bxukbmWoD2NHEHt6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a0c8d1602fmr9280495ab.17.1726778101904; Thu, 19 Sep 2024
 13:35:01 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:35:01 -0700
In-Reply-To: <CAABpPxQ-H8MjYrG3VUdR-rUFDrnVwJ5aFJaXFGJ2GpJYWD65pQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec8af5.050a0220.29194.0046.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_get_system_file_inode
From: syzbot <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com

Tested on:

commit:         2004cef1 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cd6607980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38d475ce6711b8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a13b00580000

Note: testing is done by a robot and is best-effort only.

