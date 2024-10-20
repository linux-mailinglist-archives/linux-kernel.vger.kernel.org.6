Return-Path: <linux-kernel+bounces-373112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C49A525D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216301F20F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8088831;
	Sun, 20 Oct 2024 04:12:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F65228
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729397526; cv=none; b=nbj9wzaDsMn3VchZ9RA7k/AYuNsR/4dGk9kfTRC+IM+Tijk128PGfH7KYmiR7u+WnCgWp8XssN7h/PopcSuDH8+RjRo60pTYUPdhsOlFKUiwFArVBWV1aXbXG+OYFSPTOokd6zK2xsX6nKnprEKyw0BWVO6q3PD+iNzuFg8hwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729397526; c=relaxed/simple;
	bh=n6e5OLfA30Y77wKUuvH1NfQ/N6cw/UJG6McJWmPAykY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LkcMGEk9VOilJbAmGMtdUt5EE5CoR1z725OI2wFh9dd2M5QHScI05r89bdIBT1H2up6XGbqwdpmOcLPKieNyAqHxPukbxVCBzODthwasVVzf6X1TNlmTZ/RBBnDULfwWq0oVYA/q/isYbqieXmRJk9LVEr267op89JsedlcF80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so38860945ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 21:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729397523; x=1730002323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+l513TjvvSqGn/uaI0hrTBprWQ6x1SGinq9rddr2xrk=;
        b=Vf5nzX/qqmM7EYosjDRH8HnKDTmUb/XVhuCUKzGZz5kunVHbrFs/Nh7Qz/HXoU3EvX
         n+jT31xhPSQ85FJ8TZ53xoUFViN8fBAGBhl/M2vg6csmbl6g2DW7Yn1NtXaKm8b3mMyX
         yl4KsRLkHhGkJrb9BnIhN9MKVglnk0p5uhmty67N8edQwEmP6bcug9JAxq0mTpFBmvLu
         PxBnT8zJNQaTbjK1f8efJl51W+7MYGyf/WVOzuv4SkMDhTfUEfCDuwLYSui1t02Fzkpf
         X3lTzO6cP14SVaAsX4712QCyNGSeeyCT+KB/Qs9Iy4gwSyAc4sCD5TR6OF5YNMweiQXO
         myPw==
X-Forwarded-Encrypted: i=1; AJvYcCWhfeqqNhM5ZpjWuefb6L6PRUiHwYwvHD6IriOxoiUz6EIHaV32RIsq+0x9lz+a32y4pMU+T+g9bgSfqGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ay9jnT9RtpiTDE2j0UMy0URLhOnILfGZacF5B1X5VkKuE/JE
	BTpoD21hWu3NeuaI9ExePOGIHNrR/b7e0QIDKSNAV6xKiQ4Wh9KekMG5va5H6KR8qh7FEir57yO
	/GFHSwLI8d2AqC0sAXyOyrcs9BCthHDCRbhlJa0Ri1vw9Cjmy65/AFj8=
X-Google-Smtp-Source: AGHT+IGy9sAWx23S/+61w49FbYOOkbh6XdVL335JdtJaZ01vhVoIpDgNsj7u1C8R11yPPJ+9I0RMSEyRQMmTsB08HBGEJv69xeaV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:3a1:a619:203c with SMTP id
 e9e14a558f8ab-3a3f40b731bmr67787855ab.23.1729397523287; Sat, 19 Oct 2024
 21:12:03 -0700 (PDT)
Date: Sat, 19 Oct 2024 21:12:03 -0700
In-Reply-To: <tencent_97F875737633662A3CB3362E968E37E44A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67148313.050a0220.10f4f4.0026.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (4)
From: syzbot <syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com
Tested-by: syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com

Tested on:

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1759b240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e543edc81a3008
dashboard link: https://syzkaller.appspot.com/bug?extid=9ef37ac20608f4836256
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e1b240580000

Note: testing is done by a robot and is best-effort only.

