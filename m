Return-Path: <linux-kernel+bounces-386149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86E9B3FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E831F283124
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAA26289;
	Tue, 29 Oct 2024 01:24:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0822094
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165048; cv=none; b=jD1IiNuxDivuKk85NFgrZj7I5jHaWymOLozAgRBJMpd/WqVyp3rJckm6DbTVy43koysFh0axDnK9UF2qTE7NUMy83noUNj5yEGJhTAkPRnJn5Cld+gCHHQl8cPDIZwNTXyDubt75El0IkmL29ymz2IqW4F9BTDWyTKJvLxysGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165048; c=relaxed/simple;
	bh=a0/GDjqtPhwrUk0rDKjEYeYNcDM4dRyUEZKNo8CnfhI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ecHKpwyzAkyrhGIipO8KfBZsWthdJh5+V9iVmR15eMPE2P7jObyqdzVT8cMyJUU8A8QxWojscmlW8VbNtnlnEzOcPylFFz0CeUsAuLPA0gmAmZuDNdGR3q+Q8TcJMnmbA7JbxIScW2FZwiAnIRbo8p3ussYciBG56vmyHciSxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4ed20b313so25506085ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165045; x=1730769845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pza8fv03chPqDNHxEx/n7Z2S/Tob43rTHTAsxVaziRY=;
        b=YvNHtoUxCHfMeKTiYaz5fVwq/ahLk7xtnBqNwzLZ0BoSFf29g6CLf2tso1+uDINhZ3
         LjcWSt8ocfFH+WjAy6jkz//gpVQZeXItBGHW8G/GZb0P8ndclSzqy2lJyqzACLs/k7Os
         hJQJKkmxVmX+b0xbKA50+SLNvP0T1sNPeSzMGnw31XY1klbm9e/QDd8Oa5frFSujRblL
         /QokGqCh/j/kPk36WzSewuragnmanKhaHcHemCV5Bl2RI8WyWsqImgTpj1H1WvShI4K9
         celRMUx+VvWq4jqGutjMbtG4IZw1HpprCnDOru8gneX5XZWTGLlaLLSHDY+8txzVdsXN
         jvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1p1mbSruryAXTAKd+9iAWgQMx0CwcE5g0g6rEv41K2HZx7x6FIu912Ut+JOiTZ4OxFe9pRDz4GjMxabA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONp5KHl50t2UF/ezWNaYwKKnCKLaNAtjQHjPbAJi5wN2ksyY2
	HpruSNySSkEBvxET/g4JrIwJz95+2BiwvztHAZztRTWk0WbpqimcbQppFzi3GNKJWnsxK3RzqD4
	nji9w3+mMF1pmIHB/Aa1ocgjQO2cqSY/459mUQaBdfeqDfxHqFwZZu/g=
X-Google-Smtp-Source: AGHT+IFk6HngVtguoegUK7h6Gm+3fic5/2LT7SUDrHG0y8JninBG223XyHaZkrHm6toBNOXKOf7JG48QwE9EaACMyyMqn6Yh7MC1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc1:b0:3a3:c07e:e21b with SMTP id
 e9e14a558f8ab-3a4ed2649c2mr83060675ab.1.1730165045111; Mon, 28 Oct 2024
 18:24:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 18:24:05 -0700
In-Reply-To: <89abba10-6924-47c2-ba53-93e2c44e2196@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67203935.050a0220.11b624.04b9.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_evict_inode
From: syzbot <syzbot+7988d9999219aea9f2db@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7988d9999219aea9f2db@syzkaller.appspotmail.com
Tested-by: syzbot+7988d9999219aea9f2db@syzkaller.appspotmail.com

Tested on:

commit:         a7d2e35e f2fs: fix to parse temperature correctly in f..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=15eb70e7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=7988d9999219aea9f2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

