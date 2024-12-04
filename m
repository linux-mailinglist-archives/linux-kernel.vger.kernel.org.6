Return-Path: <linux-kernel+bounces-431376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4949E3C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81C3163F3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F81F8ADF;
	Wed,  4 Dec 2024 14:20:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45C1F7548
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322004; cv=none; b=nwagc/4YGdgPmbS/R1B+lQiHPFOnKk6rc9Ss16aNO2IFBiPeNO6Fh4vHUM3eiAZO8Mu9CuwFxdGq4d6QCSPvXK19V3MxdhDxxdxP/j1YzrvHsAhJ4ObZhbWmzQUU8603VYFkfaRuqJd3GNZeBOW0/JvVpHVDt8qLt0VONIhE8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322004; c=relaxed/simple;
	bh=tO+SORHpKmrWTcl93DOLCo0umt8XdOBYvIMpAvA3wgg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uENh4+yIauMhvBzVDuJbnALiJ/X9aiEUgf27b7tyoki+RYbiL4MPjNmDJboXb0P7tu/O3vV94zsIWu2u/djWKPDjy3FyC9SCQ/I4NAjFb4wYUj31E1lHj/t7N7N52fOIuFF1GMzNGcq5yaMN+o/93L4qvlMx327oezUUl8QxvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7c729bfbaso74907765ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322002; x=1733926802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KVEhwAjHAH6DwhUQICA5+2FgGfgLP5QSHauX9xaRkI=;
        b=YN+DY68K2Zu5PZ/b6P3fYZwAElXQncwtK+j9fBEYLaPuiS6ypAZ2h47m+fAAZB9RvE
         8sArjE1K/Ms7DRc2C1OJkjDSW/GVHse1HeiO/2hb8TQvGYuJeQKRt7wUEavRVVFaQiwG
         0lcu1hOGt07xBfpTF+q680RVGvtj/4wyQngyQZdmGJK42dmvXFTgZULIlw85ZaqXL/VG
         sG9+8ME4wFYQDg7d5loMpknXaQfP/Hr0gN75knIsv94MywRvEsCT2O4KhKXjbvEAcstR
         Mqh0UTFroCvCGHHDjzS3xXaNPn9OajVZr5QvtUiCp/Kf+mHSOFJKI5B32W0/55RKMEkw
         LVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6TM44czGFjqy40ToQpZEdOKP0VE/iamTE2hbqVOgssDtWwApPK94BmOWhkXEip7bjhDnQtgGfQsI/Jq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFS8b6YzrqdlXK4MTwxwVvOkvQelUCKGuUlWNKE2N2eyU62hx
	BWnetdrgxR0SS6QigxhjDXe6TfKnC+tSKd78JeZz5qnpmHfPbyhfrH57xXlZgH9EgFhsQ0Owh0a
	esqRgyea+bAaVA6+qQqcHktBYIHulBLvjcIpxcngESkG2ngu7omjyBI0=
X-Google-Smtp-Source: AGHT+IFCfKe19gEn2IpmATv9IPOuQmAwJeYIZY35tvobgYCj4YIwz7jBav1nR/Rzgpfp/T5bdc8Tcp8RRuHIAae0Yhb0GSO7H9tV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3a7f9a4e005mr86299875ab.13.1733322002409; Wed, 04 Dec 2024
 06:20:02 -0800 (PST)
Date: Wed, 04 Dec 2024 06:20:02 -0800
In-Reply-To: <1128092.1733320787@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506512.050a0220.17bd51.006d.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         40384c84 Linux 6.13-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.13-rc1
console output: https://syzkaller.appspot.com/x/log.txt?x=11f960f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1249a330580000

Note: testing is done by a robot and is best-effort only.

