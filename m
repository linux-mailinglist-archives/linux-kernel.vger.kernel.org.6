Return-Path: <linux-kernel+bounces-234942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C822A91CD15
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84880283697
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B1811FE;
	Sat, 29 Jun 2024 13:26:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAED51016
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719667565; cv=none; b=VcIB7njYWax8ASvkO9Cid2R54KOGj5EmyQ0W29wFpHXdpydlmPc45GGLD7sIK1xE/xb7DuqsV+hJuGBBB+JaqOQXm0Dzx0bxoix3AngGbUmIyOSzWpz7Hs/VhWHaRQEYZ2OvwBiNbTnllRRqD9jqBvoZijeOtw63amsxPQu23yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719667565; c=relaxed/simple;
	bh=5P1CH6GzkyY5pai/w1CHGsZFKMPSk7wJa8u8CrsVCkA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HMUbhFOHKCMI4Bn/F8uatEw+DdD3KpfLJaLoA177IYUj7rfZjfzlcVMb3zfW0owspH84cvToZfpzu7GlDdsUtAHiewpQJSkWPPz5UzX+6+20p4i/p90f4gRpBtU24Qo7RIhoErpKiwPcP/kqXcwbC1hJwlNHapyTScN2DwntWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f6200ad270so157490539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 06:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719667562; x=1720272362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qah6vO2D/nZwZPdmC8w9RAPYgV68NoVHKtszw7TUcBw=;
        b=J9jcrHXoJANm8qsasOE7vI0ecM051ijn0Cn2WJ+lu7XlHyoNNLiloWqP64RFV1R372
         WbEQhhJu/nIVFBG3OUhwzdHTN6+mfddxuIhW271KMPHqFPobMS7uhVaz/3SuruPDkrz3
         ufqETSS/KMwP0sr6SfLR/OvfgdELJA5x8C70ZXWq0jtzYrXXbN+fT4J4s0AJrHQvy771
         Wi/A9j26NmYDhHvElB/YpFUAzo6wXmVkEubBs0vNvayE2aOUwRr9zz5BwoyxqSkCJAuK
         UFjZ3Q+MbV1X10nxtqgjp4r0EYhEhXnF20IoJN4NBDzCQYX+VOQA2n0m4Dv6lf/jdU0C
         rAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZJek+SNmCcUtU9OjTDKaSw7jKbO4FimsT24vivApJVUYXzO1ke2p6/63Ae7y9xiaVyH4MVdfBtpYLiZVWoESSmdHTvg9pH7efUE0H
X-Gm-Message-State: AOJu0YznVvLQaN45R1OmD6cemqNpL9MzKCDxSIT+96oGnDfIG7Yo9Qed
	p9Y43ZBzckAbR5FzVFbT0HUa9DG3sYGjuxgV29gciAX6nCEQ3vpq9i+QNZoUqSFtIfalMTjGQli
	B00JrUD8QduMvnCdw2tCShlQ2mbh/OwQ8bekR5pJowyj9idR96XSIgLw=
X-Google-Smtp-Source: AGHT+IFvo/+Zh25Hlb4S4jnxsxsMdE8n+QhhHxJL1k6gbMASjaZsbiH4N6iV+DSRs7O9yCyRd+qiUupIawkj9vqT49t5m8i+ngNB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:890f:b0:4b9:ad96:2adc with SMTP id
 8926c6da1cb9f-4bbb707534emr83180173.4.1719667562759; Sat, 29 Jun 2024
 06:26:02 -0700 (PDT)
Date: Sat, 29 Jun 2024 06:26:02 -0700
In-Reply-To: <20240629113329.2452-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035d35b061c074ebd@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in lock_sock_nested (3)
From: syzbot <syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com

Tested on:

commit:         6c0483db Merge tag 'nfsd-6.10-3' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16abd699980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67463c0717b8d4ca
dashboard link: https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144ae3a9980000

Note: testing is done by a robot and is best-effort only.

