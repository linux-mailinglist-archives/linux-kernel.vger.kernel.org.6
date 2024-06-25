Return-Path: <linux-kernel+bounces-228177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA662915BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222C81C214FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37421D54F;
	Tue, 25 Jun 2024 01:54:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DA1BC2F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280445; cv=none; b=k2hnW60SeYNCDFxNyvFLVR2dxQ5YCQQ5rirqJQ/YmJrak2TG0W8cnObo/v7wkvUFxBhzpG9Z/vkq8tBnga6DG0n4hEDLk8RjQOYdh3e3D7ovXAuEZoXvaCnxX6feXvbizkXiBMlhNoYBiA8Noh6BXtOV/J2rRito7A+FLIEEZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280445; c=relaxed/simple;
	bh=B3cTI03E83giNkhPzE8JU3Wu9pw6OTt+bv5Zxzi290E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ptwzTjj0kunJyYOjB6e5J4tyQDc2V8LMvSzA6TYEbZ21j5lA6oEVOHN29LKOwwu4xQSeQ/CHL125TOeVxsSuQhqKTgQGcjTI9dz9S4mzr64VWmyTWZHiCdfEqPmV2gMbswWX/pJwL7rc62bw2EZP8wVXJXCni2VnH27c5JiKX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so298342939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719280443; x=1719885243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WH3oatX4L/Z/LJOY8UOhXU2iv8F6YHqV5JpcSbW4rM=;
        b=NOblQTnV3TCSBCLwsVqpJMoBZyDKGnr1ME5MODMcOutVucROL81TBn8R1rbsFzniZw
         IrCEnWJ4GoNFxKrMiQH9f+enN3h8l6EzA+phb/7AfOvGGSYY7OkQf3ubU8QNZGkJNJ/F
         nfxdMuZ8IcXDjftr0I229aj+MNP6TMR9zVJYqDodQk4Xsqgo8y35swu5ZzsQ/Bd1LuAb
         P5V/Mq4zKK4vnGduGQZFXY5iBA/oZNCDMZglxTyoUpaYQ5auH7JrQYS7rjIq+D62s0dl
         Pzeuy5WGzPr2oJO+thY7fQBjNEqEHYDjKb8gzQrmqscZHykuolO3ERwml+z6PAJBv4dw
         4g6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZfiAdqk5GH7pTZG7Pw96TEYsxkoJ5HaXCktIc61xR4I1guvzqBwDhxVPnEYFmslSb6s7hjHNMsAqnqvQmlXhT4/4Evm1g8zmcgAQV
X-Gm-Message-State: AOJu0YwLttD2cwBM/st/YqllXVSnKpbft4C7bTudt6lr1RW6xa8xuUaA
	NM1kjHo7lL5FFxA4AHynU0Kd7kCtd2BFnc71zYruMzujK3gOY51eB3vfXx4bZeTMYp2NdA5GpSG
	pJx7WeyDNT4HGIK+wDbZI7LRzYgKmLmm7jY/Wv+8hvMH8Dags1HVWLJc=
X-Google-Smtp-Source: AGHT+IEL4OECKwMI0ZgbgkcTjG4wnE4zH434Rtbum4HY8hAuuICt/X2tMpZdmsg9Zt8otVLGFiC67u6Y+gM0YcSSk6h7X2+ZQuqJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:375:9e20:bee3 with SMTP id
 e9e14a558f8ab-3763f493866mr5817375ab.0.1719280442961; Mon, 24 Jun 2024
 18:54:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 18:54:02 -0700
In-Reply-To: <tencent_76254CBA77BBB533DB9E261BD64BF01BF008@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012847c061bad2c74@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sk_skb_reason_drop
From: syzbot <syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com

Tested on:

commit:         84562f99 Merge branch '100GbE' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17f0202a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=f115fcf7e49b2ebc902d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12de383e980000

Note: testing is done by a robot and is best-effort only.

