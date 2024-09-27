Return-Path: <linux-kernel+bounces-341285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A1987DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8EF1C22273
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788B515B572;
	Fri, 27 Sep 2024 05:04:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2BF9C1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413444; cv=none; b=Y5JzrcCufVJy8ptbqFS9KqwRE3V8Z7xYs0FlxuYfCS5VvpRJNcWI3U9sB/QoiQVECMNIbmYkXIThpSd71R+Yk1L9Mdvs582ygqd24h/ZIAt4/oWkeu2/tAkynGvs2OJO7qSjA8ivAGqHbL1u1+mPue07vkGmYEpMNS2GnrQuogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413444; c=relaxed/simple;
	bh=SjGBYvz7T0qkxE6kg8zLeZ7KNqVwseOD+H9h9Z901w0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SHPwD8ziMBlmHUva+x7SBSj6za641HdkM7lQlHRgnMa3Vi66MCiwAOvJ6pPiRPjQV3oZhxlJqx0pEsee3lCO1YTRCuu4aZDRYIzhDbzzjaolSTTP+3P0gZ49xKDFoTQxEAOFtshLtlIJilc6fdLqbCth9VnXWKwIqe8zNrOS77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so210121539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727413442; x=1728018242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9q+IZMEdWfJPC4uwcDTgpH54G/AY8V67uzGME3VoSs=;
        b=IznVqzgUw7/igsdb9gmQzqJHj3pOR3qOd2WeQXTankZl5tJLsBH3nsjOeS3X5JCFFu
         vjF+Q3QPXczs0EgN/oJuRwPWh4VollScs55zO/V5CdGWiCbTLopfQiilV4wwqwgo+kVD
         IbqZhCS8kdIDu5XKtSh8jiWiUOkDSDFwXp0UHVeYeSTtq3snnxGQAaR12u9/CZQ28ItR
         mSkHKE9Ubzzre7+T02qo8XR2EpQwdMJygsx7BNs3+Ux/lmXfYfeKrNPp1ls+87IaNzZD
         IEKs/+X1hoWTuP+8WXvFd0jqqbvj+VtLlLUcIkuqNL4MRaXIDXwJZcGxm6ftLGQCYqeT
         YF8w==
X-Forwarded-Encrypted: i=1; AJvYcCVGrSr0JbA5XDuOLYOnG98gvFQORG/9bp8JIXHElRDAaKpo7AhaQY/dF1wjk14yW0dyFJcPd1x8eCPGXYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSvNSyGAO5Y7gcXC4UNI5YsgKhPgGKFA71t6emxNbypZ61FYb
	m1mqyIfDncz9d7mkrac9rKa7OeWInzBPCSK87QH+jZXMqa0HTueseT5oefegOQsQxQ3kuJmnypL
	hTXVFZrW4y3ZWvSj+DGr9WcgeadIqAT3INow9LpGoSk9Rwb6ZqjhyY84=
X-Google-Smtp-Source: AGHT+IEuIThoMfjHlJmdIPHZix02yslTIlQF5/nyPzFqxMKfMlXxvSWsMpN3ijXL9qngDDvHLVpsU1YjSMkNcm8WIdZfwHbLF/CC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a3451b9f82mr17499385ab.22.1727413441951; Thu, 26 Sep 2024
 22:04:01 -0700 (PDT)
Date: Thu, 26 Sep 2024 22:04:01 -0700
In-Reply-To: <a2f49743-4617-4655-ab4e-d94928368647@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f63cc1.050a0220.46d20.000d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_stripe_to_text
From: syzbot <syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zhaomengmeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com
Tested-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com

Tested on:

commit:         1ec6d097 Merge tag 's390-6.12-1' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e94507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c98a50c323635be65d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1503f627980000

Note: testing is done by a robot and is best-effort only.

