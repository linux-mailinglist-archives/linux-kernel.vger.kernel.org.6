Return-Path: <linux-kernel+bounces-399006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 745559BF943
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A24FB22C36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9E20E00A;
	Wed,  6 Nov 2024 22:27:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200F20D515
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932026; cv=none; b=sywmkOoXHucWz3PQR1U/faG1bvDAUDQl/SIe1jRm41U82AwNUt2Sj1mJNSMy37X9FmgPVVmBefIg/ayTsdEGR1mElu5ql6yL6VIQIaSaRo3uH9FVfXEl7+SdPP4h41Rol5tnlpKgVnABML4OermSBTlKAK9+3n8OWzqA/wBY2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932026; c=relaxed/simple;
	bh=1TaITtvy2eb/mnbYQr+EPTeoOjeFF1uMYjoYVpRQwGE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TT2XnSEJ09O4dNGyMBYam/i9suDa0gF4RJ8VbycOFFYAIcv0AWPauK0wXPfdwn93p4BKWkUYDxcj/w1XbLRmK+CzSRCvpoIoe2QUtqxHPyOXKuXTPAh9nsxpP59s6zgSxw579DTldFDjmT2DB678A/oALjk+vPSV8Yt0jtPSLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83a8c0df400so34912339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 14:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730932024; x=1731536824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCRpFjqQcBnw7Wfeg7JfgGGwO9fw3TCvqG/7Y4ODjQ0=;
        b=XrUz46i0qh2eHjSIa7zPGw5HZICH1DUsrv8bjGvNw1q6hp7Ttfpx69JVQqVB2S7oIM
         cnWcWG8v+NYOhv6RZ1Jdvg3KlkGttntGcf7JQzg4okv2DTUHLfYKuW7gqyAf7fNuleO4
         4K0dvfEMiy1MD9n+/qjGTvp7Iy0qFtU/CMqvBMDqXPD/kepU2bfVGn5yPOM3TbYSFJhc
         hRwaNCUT+VrHWE9MM5R4UhjuqSX3qWTyPmsCwMrOM2kbcxIi7lMcIuS44PrBApHArSq4
         2HPmpw99A/3CqeZU6KDb4iy1UOV+M4gsjiH5vyvt1Xd8vdG08VvNXE/YmRMA5oVumMVW
         zuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW57VykBnKXwqqfKNP4b/Jg+Z6huUcMm9mg1b19UTcgweGDBTYL5xgzFiFVshrar8QdfewF8vS5JFsY77M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR9ERHodk/N2YjJG+CirtAm9cHMr3EWHMITVGTtbpsJfScIYIX
	8jkDAmGGXgB2k1VRgXlgWoQgGJynoe/4lTh/9RC00Lid4feZwCEjO/YFnLUbXb2+CCj+G2j+ddt
	kfd27oY73Yl6uq1UlKvbqOUcQYpP1z2DQo/rdbGxAVpXRb9PMuVBAww0=
X-Google-Smtp-Source: AGHT+IEhdX4ridmhZ9oiF9pcnssnDVwNUY7BLZ7N2FwBDqpA7YdUa2crIN5H9xLsATmWaoIeeqJey1goErv0z158XO8LOjTtAHFB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:3a6:aa59:fffa with SMTP id
 e9e14a558f8ab-3a6b02b808amr206630215ab.11.1730932023791; Wed, 06 Nov 2024
 14:27:03 -0800 (PST)
Date: Wed, 06 Nov 2024 14:27:03 -0800
In-Reply-To: <20241106180706.330326-1-jchapman@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672bed37.050a0220.350062.027e.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in l2tp_exit_net
From: syzbot <syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com>
To: jchapman@katalix.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
Tested-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com

Tested on:

commit:         ccb35037 Merge branch 'net-lan969x-add-vcap-functional..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16e85f40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b68d87980000

Note: testing is done by a robot and is best-effort only.

