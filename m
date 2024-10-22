Return-Path: <linux-kernel+bounces-377134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847F9ABA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09731F24344
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530381CEEA7;
	Tue, 22 Oct 2024 23:54:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F981CEEA2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641245; cv=none; b=hgcqBhtMBCr8AzLGURLTwElrbEFctUcd+odOTsRZ9kZdIkykBJgz7dmGOqWxu3B2zPQz0M77OmfVsJBH5OW7mYCr/Y5rpqL9P7lc9YOte75GbguHMKK6i8MNE/IUO3x4aHF7r3Z6tPb9XzlBp9RDSMaP+5oRaRRQxaMJ0UxREYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641245; c=relaxed/simple;
	bh=w6dFWm5RFl1qVrcNqTHmJXFLmpmsqtnvNtV3JaUtXW0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hoLCrgZ+qxWEDA8vXbq8RW+KNH8JXOD9Irqgcyk2sLk82FBVWRdRUqrrEzA534SXnjXP5AoLksv2nIw2cUMzM7awP3oWXnvvoj4UV7FfyMGqh/gKmZk9qnkT6yutvBqbf8B+IMwlAmq8oQoxPqqryGFJaiyGeQdUt2cMq8crE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ae0af926dso231296639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729641242; x=1730246042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxd9axTxFl42+LiBFWYZjB3Ipmm1xW5viZAHR/B3do8=;
        b=T8Vtw3N/ZVW9UTU3fAtLprhT91B/SrVfkcj+qb9dmft0h5HlInU3S6ZsLhueqJ/tG4
         spvMNM8C3r5CUsrZAVKqT/Ud7QsZev2x58DNTpTW76YKpKM/kRsmNuEfDN+6Hve1vTVW
         7XHnViHEjEufnpXE7WQwWchgT4clHD8NPHHpGP2PfZDKr0lR9brD5OlrC7f+Ct8GaPb+
         GXionNrFury+YW5fI0z+8g4WDXzSyDirA+4t7HE151gn//Fuv/SiG0PgZa7aAVeB45K2
         k9KOOonmxuB9maQ6IHDCg8Ay5nZWPUE6muwSuLsK6Aev5cF4QDYIvF89OK7PP6Fh8ZMr
         4f1A==
X-Forwarded-Encrypted: i=1; AJvYcCUkvUl71sRQ+0QqmvnoX+k/Zr3Adz779MkwcK1s467CGihpM2h4txkrGXM+TvLUA0GM/rB+Q0kpicp1bvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62VjSDVuqapjvRACB7n5s8xkzuDQyMe1dqTwzc4O7YmPuViVG
	zyMDBQNAxjXDv9yu5Y88954J/wBJfHbrc2X2IL6K037e2B/knh/gIOOODnbXerL26+8sS7Lyoct
	9R1r3T15rlZcQz38aU1yLGdSaYwak3jX6mAJAzVa99Q4CB1V6RTVtWqY=
X-Google-Smtp-Source: AGHT+IHJQFW9N63r2wNjck1q/b5wE+bV8tzL/RldOQHzeRI5l/Ri1fsSEe+ypqOp63WDT8SJstMq+IZu1+vfWlsH6xf7m/nMljOg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:3a3:b254:ca2c with SMTP id
 e9e14a558f8ab-3a4d59ff52dmr7700265ab.25.1729641242683; Tue, 22 Oct 2024
 16:54:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 16:54:02 -0700
In-Reply-To: <0000000000004a3a2e061d54e592@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67183b1a.050a0220.1e4b4d.007e.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in bch2_opts_apply
From: syzbot <syzbot+c55b814203b2ecab10bb@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit bf4baaa087e2be0279991f1dbf9acaa7a4c9148c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 5 21:37:02 2024 +0000

    bcachefs: Fix lockdep splat in bch2_accounting_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f2d0a7980000
start commit:   5e0497553643 Merge branch 'link_path_walk'
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=283288d3d08ee56f
dashboard link: https://syzkaller.appspot.com/bug?extid=c55b814203b2ecab10bb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bd24b5980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix lockdep splat in bch2_accounting_read

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

