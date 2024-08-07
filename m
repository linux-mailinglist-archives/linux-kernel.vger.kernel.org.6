Return-Path: <linux-kernel+bounces-277873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F5394A78A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9664CB20BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ADD1E4EFE;
	Wed,  7 Aug 2024 12:12:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719771DD3A8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032727; cv=none; b=epGZoAGvxPKIkEYS9kC4QJ5fRDdEq1uR3qjbApYG5Ol0Cv8AGls1LyGFk5lGmMhvNgiHgTLcYbI+3sEUOVGkxhe4ykrWGEYQzr0sZO+jJyhPKNeD35bWzPzs43TDCPIWI3eil2V0ZCCEgrajzVcX+fx2Ddqb8VgK6/VhYRB4+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032727; c=relaxed/simple;
	bh=JvSJVocl5RvIt6PoDWmD0hbrDICVsMmYgrEnprGyLA0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sf+0MGvaUQampl0qO60r75RwGThlg0ytW3F+ktA4FKoXc4KwKDVD7Zt9oQ0ubH9yHCUgHOZVKMR7Jj6jIHE7ZQExtwiqfA7Wunn+X2xkAyTfIHnpMl8490ZCP4BWZTKk0ui84CoejO7f2DT5CyF2UlyuGOrPm0LA62eZ5ScLWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa12a11b7so236648839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032724; x=1723637524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDzNgwBWcDzLpU99qB7hx8oirDTkQ9ASFrDNIxpBh/4=;
        b=B253ICT4H159DpQHPFjyW15XMvdbwdNCey5y0nMjvwSRL2+gD6aCfdEnvWGqr+uVmK
         N1mm3lWGdxGYWL0ohEDAOIJI3J/lx7Pd7En8ome8gKF2bLrI+BnFP33yZ1dS29QUxQfI
         NKiyFS31bLb9TYcr2jr7KWWmx1L0ndeCBr+YEiWt/DSrbAR/Si24np0iygGPczPoAXBP
         R5Y4TVHBDWplH9D0vCmfATSbnxK9u3IPVF1HbV8jg2MXuIsqPLN5UJX8r6Ctljy5CYSj
         LCNuPHnONc4OXy7vhTMInaIghpWoNdzeh6FBaNLab+z8W4fdxNzoyxdR6ct0V80Lo/PG
         90Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVPlr+tTTvNyIWyu2FMwXPNCfNZMaXKWvhdblrE5Uloa2t493VtNcHlTEoCzQMeWOmiNmThfPptKRlukBhfW/v1Ncjf/oSU6UwGz+6t
X-Gm-Message-State: AOJu0YxZIH7ioiOZ2ztMKojHptW0CkSgmjsk54eW8H5kEPH4HXWrJVEx
	Tko/Uf9OTitK1f/EJ66AHy3xsZ7IBD68QDvlFlKSyhfpFUCi7UYNWQx/9yuvVorYvbVupccPo2C
	liAW7rhADnL/4w8/VblIr1igtgr7/iB5OGXiNKoQfqkVfs9fzwpHsAG0=
X-Google-Smtp-Source: AGHT+IHhtzRZpMjztEyHbzij+7Ag8ItpOfEoGd7p6xxIWeq2mg4orbl9PyPLmaiOt7aenXHJRgdxk17Gm7yA4HnAZSzWpu01g2uj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39b1fc4cdf8mr15738045ab.4.1723032724527; Wed, 07 Aug 2024
 05:12:04 -0700 (PDT)
Date: Wed, 07 Aug 2024 05:12:04 -0700
In-Reply-To: <tencent_EAB6EEFECE8878FA6F142C596DB09568E80A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b73ef061f16d1bc@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com

Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15c1865d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d6bd73980000

Note: testing is done by a robot and is best-effort only.

