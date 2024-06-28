Return-Path: <linux-kernel+bounces-233858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0891BE5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C11C231DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C483155382;
	Fri, 28 Jun 2024 12:20:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36F1DFF7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577205; cv=none; b=X77cN3Y0blIcL75gElmP8lHlHfbUgLJu8kKv9Ad7ss8NcYMwf9RQ7kKE+6RkbSK8hTKYeUqSQSwahgeaEbo3UouL4pWertpUUBBcSNttsjWBv1Q7kNE18pYpkKm7aoRugnKy+6XgN3afL1ywYCl9TlojB51zli8qXBoGqYqG9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577205; c=relaxed/simple;
	bh=FDC2dUfWO4nH9LpDf6cyTh2SdPvtJfTTD59QqRggdOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wi4jZFozv3cNbXyR2kaaR4v3/y67KpGC0HsshObcDXdxJYLMZVrXu3B22qZzPqyTpSrpawOclbJfWN+F5o8YPEZC+MZOnpqKDjYZ6dA7a7/XjndmcRTmBs1rEOfDhaQU5TYsGoIpYqUEq8E1db3+zHe994Id7GDTFN/2oXs3CGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37597adfab4so6235125ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719577203; x=1720182003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYusc0tQ3njMzJmg2sOkeDNFSQZ+MDXlKHNqZlbwyIg=;
        b=diGM6F38HJwmGdha2KhJO8MdLDdhudOkOizZDr0rzjeptARvvhq4bkCPWgRDQ3lYnj
         Eya5ggqgpA6MDbXICfe2Q9TN7BOOcZJjHKKmAwJyzz1BtAS9YXzE0laiD6hocgXLB+Cx
         zHpClth40PjpW4aQ/YiP2J6qQkZeARtFPpckxt8fDTeymFnfLtGXQ6RZ/41JjmvgtEp1
         pjXTv6sUN3PmK8HDrVNAOE5IqzQtfuEYUWSeOOlFtx28eopUQgHU+OMhUWdKTC1eIPv1
         guas5XxKljGCKWkJgy2AYqRdIapwTQsSpgr6CCt/sfvH2AF6MB8uy0fQsl60fWdcRrlU
         9Xfg==
X-Forwarded-Encrypted: i=1; AJvYcCUhPf9tFNi1ZHRLnXo+P/PLNbr+hXBUkr6g8rmW0GRk6FeiRkieOzTuJ7TDVU7DwzVvaZ3MRHcHGOFYtTTCa64/kWWy8/IDskYjet2o
X-Gm-Message-State: AOJu0YxvFbOONarSSH6EUCOD5PHvZtMGlfeRiy2T0sWbFFf4bBZhukQo
	xdscYrsglqQpizFUKzKaeAQrGcgL4g4xAJ3PL2fqyqhRcz3BduuGvsOdZj8Ib6CdyNPpFJOzq5E
	mlAwF/o7GhdgMM7Di7e2B6LPZQuLGslzhyLerYA0vMq/nRk+/P4yM9s0=
X-Google-Smtp-Source: AGHT+IFgBt3+tAZJOdE4bRf3OpqAXRVPLuWocVu9MUG1gfrSV96Sg+sF5HdHKKaLiQZDUVoEfIAf/IMPokmsymnS0BvmjgKyJIao
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8c:b0:375:dad7:a664 with SMTP id
 e9e14a558f8ab-3763f74fbc3mr13890005ab.6.1719577203442; Fri, 28 Jun 2024
 05:20:03 -0700 (PDT)
Date: Fri, 28 Jun 2024 05:20:03 -0700
In-Reply-To: <20240628102859.2379-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006017fa061bf244a3@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in l2tp_tunnel_del_work
From: syzbot <syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com

Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14609ac6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=b471b7c936301a59745b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148aa8b9980000

Note: testing is done by a robot and is best-effort only.

