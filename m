Return-Path: <linux-kernel+bounces-357174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A2996CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3D5281A11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70532199FB5;
	Wed,  9 Oct 2024 13:59:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6894199FA0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482346; cv=none; b=LxkJS8rxclcekYvUemijRbODCTyPAi02+VwemPTQPYMeHpeV7gV8uiJRUbULVue/byfG2O2hqXawtF84xVYBj5MgUk111hNuU7PI1R8KmMriOskzohnuw7AhbWNq1m34KvQnlcz1dbV3wofYGub76YXXcm2QbCxJAnaps+9nyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482346; c=relaxed/simple;
	bh=UiXOYGhi09FbiLK08wnzmsQ7P0ugRtXYloj4gHvOG7c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O3CDzR/zMvd3hOKwFZqmO12cRANOvtGdgVEK6FHx3kc+Nx2FsYGZEn6SYVRmOd8R83Y3lwY2+mJa9RgzuNGj4F7TQBBFrsj+v/SDSW5pG8HWy5xaJJzSM0wj5IyyyGN6q+7R2HdI7G1dgIyLM4K/n0v+5+t2slgPR6LYC80AzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a392e9a8a4so20911895ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482344; x=1729087144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcwKS8IZf+tCbxTp2xw2zoEBy4y1bAD9E+aHpLTswNs=;
        b=KeiBfuDqxWh+g1ZMj7IucUkWVHDaYT0oaCefcNh+Xc+VrpUgtM/oRazEpOUIs9+bO0
         lJy7Q5CaORxrmmRe7WcC4YM0NyTUZm9LlHziGMBBdCGckNJoRVVTNuasC6th1Home217
         5IT22qKVxxuD88rW8rmubdcJ8KNhM/X6b8+NOfv7VX95SIvmA4+5OK2UdTxzrg0CNnMw
         hgha2nB3bJWyLYZfK/u3DLjL5g4nzVR/I/6qKaCdvzGm2yjiarHckJQhD65HXBqEZAkh
         E3+HbQEusWVdYKEpb9qwl9ZAhxI7ucagY45paxY/uOojEgo6GUd9mz7O3AgCCSwXdjDQ
         x0xg==
X-Forwarded-Encrypted: i=1; AJvYcCWtLoh03KUXfqk9/9I91k8Cg1tJ4f7iUHf7NmXeFv5xfnqEWMmbsAWEZoADUg5OQExlBAbR1tUYgPqiT44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJjq7i8Yqs6tWre0DbRUfL3RL3S+FjomRlsGFKNMKh14H4oGE
	2qhcnB6W0fvlN7oHmVu0vj9g4DqUCb0FdyvTaL/J+//f3PiO5sLvTiyXQFHQg96cllZS1XLftKt
	A0P5rRsLQ07Epp/GYrQ6CkfMj1U0vP6GhDg5XOuoarLAu7Hncx91gPpw=
X-Google-Smtp-Source: AGHT+IG2iYqwOHNqRdBl+b/ZzBo08O8Ucn0EawPGs0yDWydlzNn7igtj7Ti7oEI0KHY5WZPv+49Sn4Sy/o1liIWOlNw5Cdmq3ALq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a397cfc554mr27815995ab.9.1728482343906; Wed, 09 Oct 2024
 06:59:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 06:59:03 -0700
In-Reply-To: <tencent_3212D5C64009A62EE86ED08C8467FD46D606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67068c27.050a0220.1139e6.0000.GAE@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in chaoskey_release
From: syzbot <syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com>
To: eadavis@qq.com, gregkh@linuxfoundation.org, keithp@keithp.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com
Tested-by: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com

Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=115fbf9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=685e14d04fe35692d3bc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105e1327980000

Note: testing is done by a robot and is best-effort only.

