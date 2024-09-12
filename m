Return-Path: <linux-kernel+bounces-326767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2D2976CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90256284A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93D1B9B58;
	Thu, 12 Sep 2024 14:51:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896314293
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152665; cv=none; b=Htie3GfRvjjQJBV1q41G8R/3NJUaEto5u5iY8yR4kDpXNJLF7Y9fsgBEr8U8Yz/LWvCITx+WBtYh9GrgEUvP020S+Vy5/F0p/4QS3cUlCXFxaf2cV6q3F/aRwp+5Wa8nMOzE6Oj5+wdMMpdzFS11Hri8Q1ZnEJqhkRBGnGw54q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152665; c=relaxed/simple;
	bh=HXXdEIMqLhZi8LHbLHcD3kxrE6NcCXYlhltVXGCVykE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iz1J8SeIZYx/9N3aGamyPfjMxMfB0X1WDQtggFGxcBBSI5Szk8jMxL5r5077x1ZENQSMkeb1PrbIDo6RU4qQQgvkvm8qsRZS5V/aTQZ/sEtz2YolRiW5D2r5DedVdVJLxNzz1n7waUmn60/psvEpxIcwHPd2fla+XkLQUWIuQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f5605c674so16004145ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152663; x=1726757463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qhpf704nuQlNkzZgq66cGv8k+QLKPRjR0dCErcis8s=;
        b=Fo7KXGKKhMkBNAaRZ0kHCTkwsuWw0EMWFdBVYT013cICzBU8CS+NUwZ5j9bpm+Xa8a
         igGDJ0WFqSOSG4gcgPhx9QWQAbMFTrQhje0kjXBYhMUMtATWh6ugApkUELpe+QedM9w+
         yZddHbMoiKEXhXycemrW2zbbPrMFKW1ah7h5U6HsNiaHLgvVKXZ8eyq8XvJF2yuK1YGo
         t+M8Kb/ISOzpIDEFy0SuLBNNvKF1SgtFq+xLP2mB5iUHnQoRHT63DQGkRscRABG509G1
         IwYq3vzFrSraA96lTLggzYSgIGK7TusW0DLDJ2Qgx9OZ1k9Pfl6wTfJ5ZRP57mUEkiEr
         vynA==
X-Forwarded-Encrypted: i=1; AJvYcCUje6bhzdr5X9UvoNmyQdnWWsaW1qaOb3GG8iIfTvbOOri6UrgIhPT+upb7V5VMxAcDMv1G1DHAfNcpU4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cbkgBvGjMqCrPE7f06proRvw4vSpTgS7Im+wW3Mb6Eo94ooV
	0izMb7YRyOheUFeVAxOiAfH425qAVH6mMU2JEjn95UZO7sovhSyKZzOFAkj6VzuwAq1jP7sGNz9
	fYVWPPXdAAmCyXmFvDQjgaajq1w2k/UzYkBdJaO0zQxm6fYF8L806PtA=
X-Google-Smtp-Source: AGHT+IE0oaBxIQ5T5HIhqoR8qm/FutfxdEeb+PbAKJ7dO4oVTSGg0nNjaZnN+V36KlS+ZJ56F/20IzgtipCiyZvP36M0wy4+A2Gl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e6:b0:377:14a7:fc99 with SMTP id
 e9e14a558f8ab-3a08495e0d7mr30809445ab.24.1726152663059; Thu, 12 Sep 2024
 07:51:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:51:03 -0700
In-Reply-To: <20240912114908.2976-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f672f0621ed3c3d@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com

Tested on:

commit:         77f58789 Merge tag 'arm-fixes-6.11-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1190149f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c2d807980000

Note: testing is done by a robot and is best-effort only.

