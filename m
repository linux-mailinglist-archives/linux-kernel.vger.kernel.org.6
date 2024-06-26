Return-Path: <linux-kernel+bounces-230078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6591781D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250B91F21EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3D1465A5;
	Wed, 26 Jun 2024 05:29:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01114036F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379745; cv=none; b=Wpyx1p/N25GfSBEGdQmKlqCiVAgfvBd1NpvfcTam5wZEoosMS1nP5NYDx4VROn5QqdTyobAqp21hTy5NvK5T+FzvS/dpEg8FjKGHC74iZ0ligeVlQdwLFAQltjox7QdweLv9Jx2aHrYrVEkwhzg7t57YAc5BaVCv2zRpHPL0f8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379745; c=relaxed/simple;
	bh=z46Img2M9tES2OAFsmy0WpYkrZexbG4QVHz5Vc5X7Zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SlSSFNeoq5+jzHyM1Orz2V/+l1RFdfbEJS4dRj9aIsWlWdDfB1gFG7x3YxZPACmxXf8HPLHjbM4KmFrSKdU0yU6zCgqQO9/At18Ye5xLqEmqf1W3YXCWCG/hZkLDxJLtUBqRi9z1WlsvZm208DwD85zC+zLuzclBGuHjWU9drbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375d2ddeffbso90587925ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719379742; x=1719984542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7jLFVxsran+Hxnl2Rjm/F6ukvXu6ukvDYfTlI6b4gg=;
        b=Ag11HWHkPQhZz7H86J2HM2d8JFlgWtJosj5sXdrT1U4p6kLHY1MJJb+IwNTfwA1K8N
         q3Fjv99+hISwLd9rUKmsE9G+/NYJ4koOz8hH4Xb6u9cUaknQc7SwXF5z/CUFW+EXe3sb
         kj1it4NQOzdgIZqNmhIZEi7vehqdD0ihTHXeCZn22S33LqvDmEIfvYpsEdW5wBcwAA8q
         olGP4MJuR+DQUczduUJd/F2vSU63MQUno2T9pkyCf90b6OtdVBFuQ99EI8C2mH3Q/Pqq
         UYnjBMfh7P2WQPYYleZl8nIB2qlE0B9HeKrg8D9ITgRH9xacp4e0deHeyPKNdjeXvvMf
         /Scg==
X-Forwarded-Encrypted: i=1; AJvYcCWZsFI1MQ7S805j/PCrp8LPHc5aPcoqEngCTHQ2gfNU/R1KMKM5KhtT/ZOeTYiqGJ2lVc3WN2qQLhUTLIGTTvSWSzqGwbkKlelubWS9
X-Gm-Message-State: AOJu0YzDMZNC0ey2GJL1/M5gNiS1eXEmTvz0Cxp+bH2x4VVk/5loVpDI
	ZaQDL849lKVGAjKJGu6x6lXaGFrxr6K0gH0biwN8YUOAjmxvqhRVk81et3xNZ/OKN81x/Q8QbG1
	l+zUyGdcPQkxI4EBkMi+APJrL4MmEc/WR4rtveCwsX/eiWlV7kqPxHVw=
X-Google-Smtp-Source: AGHT+IFlgf0qW4V2vp2uiO2LtpRA9jZ0J28yl5GlbXreZyyCGWbyKG3jnTZuA0un7Ca8uwcdDb/1n51YlQ8U33kMNYg94mF7vofE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:375:e698:d0f3 with SMTP id
 e9e14a558f8ab-3763f49d3dfmr7074855ab.0.1719379742684; Tue, 25 Jun 2024
 22:29:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 22:29:02 -0700
In-Reply-To: <0000000000009ce262061963e5e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc087d061bc44a72@google.com>
Subject: Re: [syzbot] [hams?] WARNING: refcount bug in ax25_release (3)
From: syzbot <syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com>
To: davem@davemloft.net, duoming@zju.edu.cn, edumazet@google.com, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9fd75b66b8f68498454d685dc4ba13192ae069b0
Author: Duoming Zhou <duoming@zju.edu.cn>
Date:   Fri Mar 18 00:54:04 2022 +0000

    ax25: Fix refcount leaks caused by ax25_cb_del()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f83301980000
start commit:   568ebdaba637 MAINTAINERS: adjust file entry in FREESCALE Q..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f83301980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f83301980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121324ae980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1607cdda980000

Reported-by: syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com
Fixes: 9fd75b66b8f6 ("ax25: Fix refcount leaks caused by ax25_cb_del()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

