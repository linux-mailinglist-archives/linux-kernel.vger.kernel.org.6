Return-Path: <linux-kernel+bounces-198664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D7B8D7BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595211C21679
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA0A47A57;
	Mon,  3 Jun 2024 06:40:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087303FB1C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396805; cv=none; b=siKe8jjpGH7uTQfZiulg1Ebr9B4hVz/PvdTx2ZRHTd/rGcS3Vy4+50fllFh8Nfxz2J2tPSdnf0FJQ75aXqxyG58usVq7RfajwKh7ByWq6DfJ6xLjw+xydN20GYrEODren0gm9KkO6qu9yEf7FrZUPWqzAarm3H9yoncGyK9DmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396805; c=relaxed/simple;
	bh=tCEFDNCtU4kyih6I5/tTRMmRIK4lL5BSpzOjWhYQVqY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ui3Osld573FLvNux9kc5aNEvYJ2Kacs0i6WTWMqSoIBOwhDE1T0vzkHNsnXsOSwvugQ7kirAFvrF2KdH5zUfZn2YngsC9OxAv1Qia9DGeBu3TufMtG1uQ2dB1WT0lbsYV6qTIFGA1glDD+i2RHuE7GiKhds7gBjt/G3yjW1miyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb10ca258eso188979939f.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 23:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717396803; x=1718001603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0t8wwmBsbHGb0/ZeZAIbcOtAtOvGwdxIUvrebAW9I4=;
        b=Vzx3oQWkvzcppng7OzmW6uAmIXluird1qI5IP+NKRDPQWTznLzMk6iWi+HdOgc+CP3
         x6MFF1HziVEiaQdxA5ZKQZf3KzyTQ7WyXelUnULDJp7Qn2JxD7nOaNBDeVicheJ8R73N
         3y6v5svQJT5kEFp/mRKku+sZ+py8fu6mNs7tLne+wunQsJfkCLz+75jbRLKRp8nwv0le
         SdKoHYfXvDXV10kkGBAglH/y/YPvfuscddDttN3UhC6FDDQdDAYwo8cWmgPGe374dOmw
         u+ZywBGDozSC8oFbT9Vs+KrAnf2G9VJu+xvWT1Lm17IoqwSudD55WgauKoOrkowvekNu
         g3Qg==
X-Gm-Message-State: AOJu0YwsYS3P+lyZq338MSyJqKtTTIUR1vCzHHS3K4Phwr1fxr0c+xl3
	3QWisrP4K17HeHqrhknsXYgSvAxDQgQMdN5zXe1/ZjYIWcMVU3sESIY80DqbfDLUoW50Y2lOmqh
	wuC2KEpffBMrCtU9B/A1NXqpRn3BF7kR2Yk18Ape639uQoSpMn4FDInM=
X-Google-Smtp-Source: AGHT+IHZ5bWxWmd3oHPrq0zW/nUxrCGYc/96WjbGLpuW/bQgh2XevJyqWgV0Y/sCQ4d7S6b9Tro2Z4xh6mloExHnWsXAlZq0a9MX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3406:b0:7ea:fcf7:7b2e with SMTP id
 ca18e2360f4ac-7eaffe970ebmr51329339f.1.1717396803318; Sun, 02 Jun 2024
 23:40:03 -0700 (PDT)
Date: Sun, 02 Jun 2024 23:40:03 -0700
In-Reply-To: <CAN-2BNRG3qMSVgBm=6jD3tv=nDAzByebEJF8k2UWUdo=vAEeSw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006682760619f69aa8@google.com>
Subject: Re: [syzbot] [squashfs?] VFS: Close: file count is zero (use-after-free)
From: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nightu.pwn@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/dma-buf/udmabuf.c
patch: **** unexpected end of file in patch



Tested on:

commit:         861a3cb5 Add linux-next specific files for 20240603
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=b2cfdac9ae5278d4b621
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171aa5f2980000


