Return-Path: <linux-kernel+bounces-281718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B887D94DA40
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315E5B21AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E6130A47;
	Sat, 10 Aug 2024 03:10:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF279C4
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723259404; cv=none; b=cTJAvsoiW+wKMzKbmRZGCkcHST1+Tz95i9SuxdADORVHQelC4hUxkL5eCkcl7KH/jJ8DlDwCC7pZMTOfRK4MIT6LZDqH+/KxB8YDbEdCkskLvhaPPkeNeHdWRSayppvK5N5hgkac/4e31KNWH4fZWSwBWztjEO2693rhIlWJUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723259404; c=relaxed/simple;
	bh=g8TqIbS6c/9Hcn7IkmipPFIztagFouOcrNhzGTJVl/Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l3KPDwprMin3pFrr4dVHRYLt48fDhkPuc7KHmzSXva9vZev36f3Og+J1MGlTeG7zujHSEWDW8j5CYStK1GjBCNZbs1GtL711j+C9yynGV3FCE5ytweJ89kC0TldF8unbYiB76BgkhykfztN7xQmgwPqJ7vloVokt4IQgk+1bmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b0bee2173so35769185ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 20:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723259402; x=1723864202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTfeqEILrpcgocdudiu2Z5FaH0pXlo1biLKjKF6Uups=;
        b=valXsYOngdRLfsdR+QGA1rTvwRM6AY79CcZavXN2EhzdVDr0t1gbTL42gYAGfxRZC0
         nciB+QfI9mexv9s0a5WchxOr42JJ80d6M1q9S93Y3I4fhWlZ9LWIf2ObyA8vTQUgm/4d
         4Ckf8hYDgWMh+wzslcanW3Y2zuZxlMLqecXV+2nMErk2fAKcwVCPdeSMo+P5ofVR8CqI
         cxab3a1QGPERP95DznCouTctSZkbGJ7lfWxZp93Gg1Gmt/Fnq2qivkHR0WkqsVgdKU9d
         MXKidZLgOktGDtv8ONb0xheW2/sJHXOXykmKz+ttVm7J+2yu/jzBL3Lw6btysEJbKSFB
         Iy2A==
X-Forwarded-Encrypted: i=1; AJvYcCXzSm9/bNgxUqNug3m1sPGbj2z000nRlLkCcazhqIfvVK1Lpe1T0rGnCVRBjgCOYQ0/Mb8+ap7QwXnuBNf1ec5TOTqvUnrxGV0uOXWJ
X-Gm-Message-State: AOJu0YzSiFMtmqiJAOheVvG8qshrb9cE3KTHiKIUVr5HoVFKMbeJPcFg
	FWaO719OEGMPSLhKMkZXfFFhFMHpj/qPeN5J4uEN6M+fLjEEOeJrbRknM6KnUPZOcZQu5kv00u2
	56toY6hJRCuqIYkuGOSbvedbtXBhDJfzh5qLOtPgoKxxQIltWM2Wf5TM=
X-Google-Smtp-Source: AGHT+IHuZwn63YG5gtjj8w761aFSzgE3nIWSGBdzTfGNgcpmjrsd9KLBB2YZ2axDN07lem+XIbZvuIF7/D4XdBVC02NSuZPBtxAv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-39b8709bc57mr2454915ab.4.1723259401771; Fri, 09 Aug 2024
 20:10:01 -0700 (PDT)
Date: Fri, 09 Aug 2024 20:10:01 -0700
In-Reply-To: <tencent_F9DE2ED60CB227C5C6FB92F30665498B6E06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fb33c061f4b988a@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/9p/vfs_file.c:409:38: error: 'filp' undeclared (first use in this function); did you mean 'file'?


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13951703980000


