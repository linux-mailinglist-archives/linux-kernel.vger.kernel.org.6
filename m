Return-Path: <linux-kernel+bounces-342802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4298931F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A3C1C2258B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA747EEFD;
	Sun, 29 Sep 2024 05:09:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DF225D9
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727586546; cv=none; b=W9f2WJl5kCRJFUBFBtvs1se9bpqHS+lWHtKqqL3eSiz+VPbV/l+bcx2+0dqwBwjlD2V1pAqXdDGnoeRWiEeIQwXRs2bbxeLsNnc3RM2vuoF+9H7q/vYVNidWc649YhAG2bRTr33Y5HAxdF00Gilw0N3ieLzECxhT5zhrZLct/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727586546; c=relaxed/simple;
	bh=1fqDQMUO1L6aOZIZYZVWskI2QvY0oNjEVXmhWq6+8Sc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bq8is3Jp/qCcjJTceUfDClv9tr+qiczX8O8mSi7M/4WkDiJhn/sBX3t6Ak2cTd29mhIB3fS2ZNIKEQIzjOxuIT0+LPENE1sv8JcwlwnVOXFX4caP7OZgdKuWd6jM1XPvEGQOdgxqfZ122ehCZDKYfy8+GDEwhOGidYR2VA6QPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cf261659bso500150739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 22:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727586544; x=1728191344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ixz4PnwE432RBX+FcXTgYnYvlP3v9+OVI1Dv2yGJdE=;
        b=GK944ElPY6hf+0InKovjNx+axhMLglIcy/7CjgVZdpge2LzZC0vP8ojQRn3QLlMKMC
         4HwARw9Z8/soie3nSiPvgDXpZF1wgXSaHqsSoU2AuQFXAJHPxwzyabl5dp15gaheXeWK
         F88uNlXEvmSkkyGauJALs+OiFXRLyQvQOXV5wibXrirV2Amc2vRx0lNZY1cLcMSPzQFP
         8MYWFH458FpWyToH7VRWUohe0VJeRNrYppc3svfQm8Drc5PrqLpGBo9aoSntj9RVtuJw
         VGGOrpm85yiOv072+8GYSUtB4ixLyTVPfWF8tln+r1T1DnTMbyArFPPso3pZBjLe9Xo3
         FBYg==
X-Forwarded-Encrypted: i=1; AJvYcCXI0htc4DTBsT3X00J6+D5fjpJYfCl+L3C3Xlo7Ru16KRqwITcIB4aLMsx09OnCkut8dKG/0dvKf4R/lEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAAuBOjB+qIOs0I38cyHlA+NG3QL2zFkX5u/rvzcErj+B4lLu
	8fHrSzUtpJcPFe/798OGBFXVr0hilYZSkoVZ4SFx62jcE2LivVFP9hucYLQi/FX3lWJ39IuZ7NP
	CRkjZWn/ZCnoPNkgTy2j1dULWH0E71tf4DY1/y2kiNrA0x5lGhGsLAxY=
X-Google-Smtp-Source: AGHT+IGE3xOEAYgej5Zskaz7mVfx5jsGS58Pis1Wkt6tlKBnbX2HPT/8treLWMJSZZNGUecPfLe++/aAAV7xuwzG6Y6qZAgbt9Id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a344fc8e06mr84891645ab.0.1727586544164; Sat, 28 Sep 2024
 22:09:04 -0700 (PDT)
Date: Sat, 28 Sep 2024 22:09:04 -0700
In-Reply-To: <20240929044749.135112-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f8e0f0.050a0220.4a974.0015.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         3efc5736 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12edfe27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7782ef71990b6dba
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fb4d9f980000

Note: testing is done by a robot and is best-effort only.

