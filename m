Return-Path: <linux-kernel+bounces-375292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95269A943E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7172F283A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB61FF5E8;
	Mon, 21 Oct 2024 23:37:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7501FF5FD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553826; cv=none; b=XnPN6mJSPOC9UohRn3YvqIPGCf/qnFsDGl+mpxKXyQnF86Kz3KaBs7rfX2BnCNCxQNoJR1shD7zM5riW7jvJE6hDUUiSbxlyHE+Dfiu7Gx+1IO3jr6O42UEQViSOiWDx8xSNvtTV3uv+XbHUO4BR3g/NRWh4EbOTjrNUOn2eltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553826; c=relaxed/simple;
	bh=NL1X+hft2ruIZIMQYmjK5ShYEQWaMI2P10qy48QjC4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EyFrYMuX06RF3XuRZPz+bm4HPoDZn903kAU196E4GtNysFhtTnEN9awU8CSpHg1bHT/ggLIY3OjZJLN1jt0gmhWd/u7XiGFxQTkykHPgGEoIf5cVuu0dVJmCzCIsU1fA9dK7ItJBGNFjoiMeNwe47VcBCNDzqmt0SaaA8t2fGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso41228695ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553824; x=1730158624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVFqvyN4Q/iFEFo+V00ETjOsELtiq4FSU+8ti5coBUg=;
        b=nK7sMpnVVf9eBmuX/Q/EqGBo8Q9P4LLjOs+Hm4qXi16jbUnHELjLItDPb5cLR7KXLs
         zbXM/Vp7RKOgPE4QiRCTmcEDosC2Fbg62MAyPCfeh0J5fqSpCC9PTvbkCA7SBbmOUU2E
         dF0h/H3AWdFOmOul7uFOKZ2QHu6pwtz2Ii6FpMUmMyR9AKeD6pqyOs+DXrw3i/tCu7FH
         lSDXO1c9iWikL8KZInDL4TB5HsZjqD0Ze76KwGZeEh+90A1lyU+L5DRyrmcTFkYdJIjh
         Oxt9LhzFspNNbaEL3abyHGFyquPvyuZUkgKOAiUrp7wF3/sNbD/JdDlnyP07P1RCSanJ
         dR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ubi6VbXBN6sQSD7gYwP9lJcAwBlgWnufvgODuvk3WQI97gR3NdTfes57fXqrjYMMSAPHI5emTP3A+A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bnDIKMbodSHV4TTsBWbgNBZjX8oXMXcAb27Ekdl5yzez+yX6
	aNQiD/Y9fDcDk3OEgCZ7hKx7KONpzo/67pZnZgyzPGj8wDNaKc06kx7hpLx8PPitLF3yC/cotQO
	QsghI+DAF7D+h4OCzeXLSLWI1SmcVTtaKdnfj469aTlfM++AFOz63F9o=
X-Google-Smtp-Source: AGHT+IE0c0321kUM7kl4x3L7VjvrmYLXBEyNuBBR7zrzqRYflgEPoOW2FF3tQQVOY/6lcuFX5csUTbRz2Wr/gLiN3H39YtSA54tJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a3f409feb5mr98836145ab.17.1729553824034; Mon, 21 Oct 2024
 16:37:04 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:37:04 -0700
In-Reply-To: <000000000000690606061ce1fe7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716e5a0.050a0220.10f4f4.00d2.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_stop_mmpd
From: syzbot <syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, brauner@kernel.org, 
	clang-built-linux@googlegroups.com, harshadshirwadkar@gmail.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8
Author: Jan Kara <jack@suse.cz>
Date:   Mon Aug 5 20:12:41 2024 +0000

    ext4: don't set SB_RDONLY after filesystem errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d04640580000
start commit:   4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbd177980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea607980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: don't set SB_RDONLY after filesystem errors

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

