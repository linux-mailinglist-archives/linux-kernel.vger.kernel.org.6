Return-Path: <linux-kernel+bounces-446265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B69F2200
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A4C16630F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721498F40;
	Sun, 15 Dec 2024 03:09:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996258479
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734232145; cv=none; b=gzX0ERQqbf0eCTLZpjnOyicFepXEF/v39cWRAheJypDMsTJI+1eqvSwSTRls4ZokiHvj203/w+RDmdM8iFCQMyPs6yu1y64mNC6qhrK9MEaeecyanBzQot3JMdwTYF1x74rvUj8NB8vBJUGFT0PbZ1dMpJzclvGcog/pmDvgPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734232145; c=relaxed/simple;
	bh=fqtBdXCFWXubnREpOgJb+ScNkEEA4xYbdzVT8FesPi0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HFBuTiyQEcyF/v9J+TJ8wxq+IN831rJiDttUbeQEhNYXQ5KQpIN1dkoZ+oYejmBWCZksru1HyTJzMvuBX8Lpcc92b73VWTqIjenOYNh7Nw6jfvhzFQbucm/n2vex9i/KJb0SYTsTCO8wzdb5Kq8XENSsX/vtwV6RZgt1rVpkeN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a812f562bbso60167425ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 19:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734232142; x=1734836942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNCWFZL2vMT3iM7JxWTRAmfaTTjnhOUKtMcTvFgickc=;
        b=pu5Vp1PWsmAk3gqbXmUxyVsEwElLqum00wh/Es5oQM3LHBF8l+odCKr6cnHuOQ9lHc
         l+nLSk9OSGRVRCHtGtEH2NA5QmOygy05tMoiv42vBp3IW+W7EVRa5rArfVJ1ZQwon9B2
         oDLaKip3szawG2Vuj1VIoLa4wJTg+CC+9CkEMJWN7ligPIwEthGJ+rDYUjgARFRzHX+Q
         Fy4J88SFXl0zTix634JklP1zp3bSEEFIAwgNHwVEPqFKzOZsONYeUIBkut3hm1TUcfah
         QCtDH8F7O3EAhv0Iy1jd2M1T2wtoeSGd6qhbd3qMoAAtnsMvPmbp5hB0d54yFByVaroH
         TXmA==
X-Forwarded-Encrypted: i=1; AJvYcCWWaCLRoKTvd9QkMNpl4Kx/CI9pVFKkmY/JW498WUeCIrAkFs6GhID7D8RSB1N/H/szjYNBI7A1RzkKpWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybsZpAQyzwrCYH584mCQ1ZqXYEZtIsO+42fUeYMLxSVl48E9K4
	KC5gX+w3tygNY7PzJK8C5o2X4XrZXIq6cjWBwMhJcCAwomqPRBdoibxsMvdm5mtue9au9C8rv7R
	5UG3YTB8bFTI+PhYIp0oxHE2uE1/GGVOnetpqB7U0AZA1zSHqrZdxWv4=
X-Google-Smtp-Source: AGHT+IG4LitOGiiVyPyjLYB7ac4SAc+wVCbAnkWUUXgEv1uiMhTIm46tsv65WxchnbWVZWrq2TSaWG2Kn6UVH7KNosbJfTwXJMfh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156e:b0:3a7:9860:d7e5 with SMTP id
 e9e14a558f8ab-3aff8aa31c7mr88573325ab.23.1734232142789; Sat, 14 Dec 2024
 19:09:02 -0800 (PST)
Date: Sat, 14 Dec 2024 19:09:02 -0800
In-Reply-To: <20241215023601.99201-3-dennis.lamerice@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e484e.050a0220.37aaf.00e8.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_lock_global_qf
From: syzbot <syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com>
To: dennis.lamerice@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com
Tested-by: syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com

Tested on:

commit:         2d8308bf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13226730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=d173bf8a5a7faeede34c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c2fbe8580000

Note: testing is done by a robot and is best-effort only.

