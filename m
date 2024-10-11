Return-Path: <linux-kernel+bounces-361433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B599A824
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99051C21E53
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0B198832;
	Fri, 11 Oct 2024 15:45:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991D196D9D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661505; cv=none; b=SndhlXIfnL4WObUB0Kn52mH7blfYl+qanLMNLR+mpQ2GoKgozoT5Wn8M1dRElAWoQnz3N3xPmllW/R+amdwjXJ/PfkYWeykSSsQ49zMlYlfI28ijvZFHLk6hz3vqVXS+CUDkPQLK/a6rGK23rnIoZavItlbfFKWb41Y/ifKiY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661505; c=relaxed/simple;
	bh=+uc0hhAqphTbjudPJIQn/tyiL8OZySdOBLM33j4fMFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YPCrKhaXrKHCdmmQdUKnRV3upQDrBHASjLgKVzaEv/FBDBgqj7odWR10VUzgjyk20F8oI8DvQIPCWoL47s9SeJvKqBjJE7b8I7MQnINKf6jIaVDYTUg6XOgJ3uwpbtT0YeVK7Tkx3ZdIHTseOhac1Cey+KvTCDon77UPh8K8PQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b457f6aeso10098695ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661503; x=1729266303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+M7SUVnhOnFY/CM4aPao/KOYlDmXQ1r/N4YzLoeViPQ=;
        b=hr29Uylgn3Vlj98JjBko1IQvo+Wm4U9Z1ufIvCvrjOJ/e0pn94u4y0OzxZ8i8keM3v
         4ROxw4Sns9qHSRdZ2Omv64GuWl5L5D263Dm+RQ84BRoiez8VGwm64F967w0mOZnF1GBv
         IQGUrtJe6NYo45oj7kZHIW/BsgXXD28b3JiWSGRzET1JfD4UFxuulthk3EkMFS0OuqY4
         DI2awOiUV59Jrl44taYgK5Re5Zs5jqIfcWUjvQNDaoKgavofb8+cHdIFgeWnsgCSt7y9
         rIxAOX6yEjWDhj4eZdOw/eHaujrT5ehczT3V7wAn/d6QtLpp4Du1GS2Ttrlk0nR0IfKo
         5HJw==
X-Forwarded-Encrypted: i=1; AJvYcCX/3ylvmvOWvCmaJaXjCE/e9VrrOaaTyTUVODGBaKwPkqq/7i5dyqvSlQUrC6fIOZIiuSLtRzxOOHgEjBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZc2lG3TpBQumkiiirgf+Js4oABDHpcLsQL2q4neYB3tGtqyaG
	AOsDJ3ay9CLnmc7YkVs0v28ySqlC3IJjEPC4OMt3PIcXtmHCa4l7jDBU5a97Q9tUrqiGnQrp3ZL
	gSBOg5lkVMJVzFjTJ65ec4lISdElS8nzgHdwsETcUbQyybiVwC2WXCEs=
X-Google-Smtp-Source: AGHT+IFnLIT4yn5vN+MCS2Bt0OuENQRZSOOvbTh8SHAQ3UiRVyple98Ekr6pH0usG/WrfU9qeWsmyLVrYkDwQr6qDegO6lym79Oj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a3b5844745mr24141105ab.1.1728661503096; Fri, 11 Oct 2024
 08:45:03 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:45:03 -0700
In-Reply-To: <b9ce2eb7-1770-4198-97b2-f5d7aa57c3d1@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670947ff.050a0220.3e960.0014.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15346f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1456db27980000

Note: testing is done by a robot and is best-effort only.

