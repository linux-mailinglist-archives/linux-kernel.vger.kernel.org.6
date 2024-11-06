Return-Path: <linux-kernel+bounces-397947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B99BE2CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C211F26F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362611DA633;
	Wed,  6 Nov 2024 09:39:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504F1D27BA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885944; cv=none; b=FBKhSTdo2Vh95AqG7noX19q5V7mqLm6uGIbZrc2ZKTOgQkAQSENRgY9H2n+JRcOKhd02gFEStlgI0Ores1bOoI74ILtIfefZ9WDBnl0ShbvdLdOjqbag4kiYexi3Ez4ygdAyX0r7Xk2iYOQc0gKWRn793nU3E2Xbu5Gy390m6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885944; c=relaxed/simple;
	bh=jY1MyyQ6CBg/d7B1++LcX40duebZ3GfatJWLh6QK22Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dgj+YRUJuZxwT2mdEGhRuFOf3j50ca9LCXhUeLQ52sVVhfbxw4D5MMmi4ncS0Ler8tIkv/AEbKvwFGZMqnv1t62ZMW3mdKRJDLHB5PjPHnwxy6/d7ri6qGBcO4KqQHiNJHnQtZ6QDhGFcbjfNg4xGFyj01T0oE951Kt5Cw0tJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so74754945ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885942; x=1731490742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggduSk2H7lz1GLlAbI7VY3J3qCqRKz2N+b+WCUpGlws=;
        b=H4j9bKhv6nxEY/GtsPJzQIlAEl2kQ8VPslt1FCf33fHXvjSn4MrMUU38TGIfPwq/ST
         shGrilvr1WJjTR6vHlqWrllnlCN0IMOqv1dE6yb3ZDXWZs1DaTBsNxounX9PWPrLx79m
         ZJeHHbS9wvLSLVU+8L6fkiqW6FQ8DFTJ45jdtJin6BI+A/ivRaylcTLhQ5Qdkfo2uHVL
         vZtpGzsD4m4h2lX8TiTVt+Ry+2zWUdsw9H032i9fH4boGZkLeTxlE3FeBOA76VLIYSFI
         jfjSHdAu5bS9ePcvNBWU1waakqKe6gtBniKmvyQLbFlUvTFZzTbEHKgLPILmqNHnL+br
         XiKw==
X-Forwarded-Encrypted: i=1; AJvYcCV+mRBYZpmrORrymhv7QemCTGFeEK0IWFD1YvW7q6/ua/2g1C4ys5ZShyKSJ8/79b38UOzNhUknZmK+VtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOVAiiYQz7H2CBSfgOHqtLpHF2TVGctNXSaxgwgaqA2B4SQww
	rxGJcgWKkGi5GqIeFo2mDK/p1Z5gbJCbrMPYRnOc7R0oyftCspaWv1/BWFbPVu/VZ7m30Z6bjwM
	BjHFpiuNNyepHRyWfaIcHdRMKDsdYu0gUAZna0/Mw6J6BKQlLQpMNesk=
X-Google-Smtp-Source: AGHT+IFocSTtVZsydWbv/7AnXMugilw0SsT0pPAXS1AZGxg1inErNOhFtUhS3cdY2SKEJKWy7Araxix/wKCQ4XVHqNDAQn0KjzbN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1645:b0:3a5:e250:bba1 with SMTP id
 e9e14a558f8ab-3a61752ae86mr225559535ab.18.1730885942507; Wed, 06 Nov 2024
 01:39:02 -0800 (PST)
Date: Wed, 06 Nov 2024 01:39:02 -0800
In-Reply-To: <CAFj5m9LSOvbaOdM8Gvgt8HVprB_DAxiFDOW3Qou8bfAtEz_e8g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b3936.050a0220.2a847.1ba6.GAE@google.com>
Subject: Re: [syzbot] [usb?] [scsi?] WARNING: bad unlock balance in sd_revalidate_disk
From: syzbot <syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com>
To: james.bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com
Tested-by: syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a15d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=331e232a5d7a69fa7c81
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

