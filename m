Return-Path: <linux-kernel+bounces-183075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355E98C942E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661DA1C20948
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC52BB10;
	Sun, 19 May 2024 09:11:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB71799F
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716109866; cv=none; b=befbHCX6xYphapeI/WK1/l2VeKOcp6grD2uWX8wVz2/lOHJmYsIymburo8kI9vN2yb028hMbODtiq6Okk+CCqP3fycj7GgspvCwHymSIHpjjT6wIQCWZBr9gmAN37UmT6YUv4ILTNc4bbZOdxQx/azw9dxm1deDpqJfvT7rn/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716109866; c=relaxed/simple;
	bh=HZofFkKYEc6fyWsMV5cT8IFWrUWtxSlG1TG9c/gl6tg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LH/tJ66nbVR6aiq/qT1X5ui/B6cz2/KvbnhSO7DGbLodSRNRPWFNiFBrZ3+wewXXtQwkpaebKBcf7KWKzDSFg0r7+bAq57OZUiDs8W/XCAdnkIZ6YcyO3HhHA5wtHj/zV9CBe9zvI+NG/O4IqZbo2CMkv0B+m1GfehyCAgXHZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1c3c98401so714405439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 02:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716109864; x=1716714664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmJHcMrpGBkfX2KL7MFrkpNa9ZVJfwG14BAogNSdHT4=;
        b=fFiY/rH6kAoJw1pH5JaCyx5GVZwACJ4WSTmrOmvtPcNS6If8L3X5pooOeEENSYQsbk
         FqIpAY26dlNW7OwVqAPIZ+ULftcnk5lJo2MxCRsZy0SZT2b+cWKiIxKEWIwaNFmuqexx
         pF6N2yQqQdM5lxkiZVH8W12LXlATzuiRVxKzih7e+AVbrFwGNnA4sT8NrTPfOQt3Aotr
         4hj7i7SiwMMZy1XLB39GDIPRAw4UaarT6ADgWr5/F7AxulZNnTKNqct3+CFdLeJ4bjyM
         kp7MYqwQVQjD0puj+ZR2qDNymqrSoocn2rdBrMlbKub8kxa2TEAtmuuRfvNSX+QfN48g
         ptDg==
X-Gm-Message-State: AOJu0Yz6BRv8LeIgUFa4CmMhZPGwL5NxnfSyXKIwL15AAm8NvQoU4eoS
	I3uyUA/iu8cIZzAODGBzDHzVIRelyy8qm0ixyj3XPuUf3k1WYejhjYLSR9jR29lFSnfnfjLiCey
	9p8xlp/7kZE431FI+rtEV9mcpeVbGyznqyZP6GXm9AFQHjTR/Aa4u3f4=
X-Google-Smtp-Source: AGHT+IHaejbP3gsdD25yZ6Rj3vih4pVLIdpn/xHgVriOHMgFDcJyEHjAt/xM+XoX3mgr8JqgaE51gAtmAS4KKGVimYaCZ6abZhSp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8625:b0:488:7bb2:c9f6 with SMTP id
 8926c6da1cb9f-48958c02450mr2413163173.3.1716109863866; Sun, 19 May 2024
 02:11:03 -0700 (PDT)
Date: Sun, 19 May 2024 02:11:03 -0700
In-Reply-To: <Zkm6qnUh6Xe2gv6-@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4e1ce0618caf6e8@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Tested on:

commit:         4db783d6 ipv6: prevent NULL dereference in ip6_output()
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=158bb442980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1372beb2980000

Note: testing is done by a robot and is best-effort only.

