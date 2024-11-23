Return-Path: <linux-kernel+bounces-419044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160DD9D68E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D004A281DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2CD18A93F;
	Sat, 23 Nov 2024 11:32:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790A18787C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732361525; cv=none; b=VnS7XOM5MhlYtFYDM78P6Sgft5M/Ly3dbStgS6PM+xKR7/Wvt4dgBuQBWOhdIg6DAgnM5gfYpXQnzZ6KwF048GZ6UvBXjwIlPj5fJHYM8BltJm0KwqBdSQrg7X+J9ebPSS/hQKCl6mNkWLpdKzAOp0OA85Wi95+ZdiJ/kskqEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732361525; c=relaxed/simple;
	bh=VR9S+T9x6z73xCX/A+Ll7XmOsXI4DQ+M1rnDvBMIyng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NaNeaLjYSiittY4jX8q7q6w/8Aa/LpjUGWagjKCaS6H/MN/bIrM5BlAuZTjEzjLJ0BCAIs8aGEXMONvJpi4s3OUkyVidSyEYJoqpla9awQ+vyF7bRU+ffm5rMVLJYTP33B05WZmI+sCd3FJGmGQw7m+CojRaxrKCmy3COW0qTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a76690f813so33723335ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 03:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732361523; x=1732966323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUSQB/mQEeRuUVXWDbOrYsEhon4hx55di7nuoYsi+oo=;
        b=p6JWadFo7m4wl5J6dXkU05+awjcMBfEfOMFyqK7noLXKdt4N+lVTSnfgiEffbh9d7k
         6QmtXtaIfhpJmGauBq12WBnQRPlWOOcm/70j6jZFulmGIDSOyajYKZ+OLpdrbO6n3ib+
         81Wde00YB/4xfZBQPWYBnkJ3vz6FsLvVaM8Dlrm+RZmLtqVhfHrzEXlgixg3DrDHGsBP
         awyA19FTR9jfapHpDZwmMWUH6W52Hqh3ied3wYihLXp1BMBf4GQ46aBOIgu2eGCGFnLC
         kAhdb8QjxZobN3ai1Cffp/xX7Ta5EGTUYSqcCyn4AH/DJredPraQ9yuSN/oLrnlJZF6w
         wApA==
X-Forwarded-Encrypted: i=1; AJvYcCW/weAtrsSTAV8NW43CfVs4vZEYBnqnvmFQa/tyS+50P+/iH2f0Q66fkKwzrPa2IjtyBJ7dYHYrtcH67is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCed4TDVRazLhYhBsvDrxAxgz4BS+KEyyjj/QWtsMZMFKo6pRw
	EWQhOeSmE10b9oFK2zneuMe3x9qqLlNRflg3D5ecC/FN8wCyMXi8+88tcLRyfY/ZOkvYT6PbNUR
	gQKjQNXQ0Mk72CaixoPqSkdjDUfyUV9P6c8Q0KNRPHyuBtPg/PTqil1A=
X-Google-Smtp-Source: AGHT+IG6z2DCg+rBpNnSGiWA28O5+iiELMj1GHBPUJFVhA9IbHCbJKfyUq05vY9BuhNx00BDZMDiO54vlZHDbogIk6ZwMMp9Jtzb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a79ad27697mr68006295ab.6.1732361523582; Sat, 23 Nov 2024
 03:32:03 -0800 (PST)
Date: Sat, 23 Nov 2024 03:32:03 -0800
In-Reply-To: <CAHiZj8gkf+W5dt7SeK3T9ZRe0-c72=TAciiCsho6+1vL2T2Upw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741bd33.050a0220.1cc393.0008.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
Tested-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com

Tested on:

commit:         228a1157 Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102a81c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1686975f980000

Note: testing is done by a robot and is best-effort only.

