Return-Path: <linux-kernel+bounces-192861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C68D2334
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D352816FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4D481DD;
	Tue, 28 May 2024 18:19:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306E2E64C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716920345; cv=none; b=eSelj5ZvatMnQDJKboEF3OeVzfwIP5bQGcA75V7d5pa7wHEp1Uv1XcCYOI9zhdTPcQAnJPreMJTOtLaLirpCapd66TJzpe6aaaRy/Kwo8/IeAE6T2nSm8kMwKLUTEBbax7c2gkp3f9j+X9NKIcRHIc+NgeiXnNHKtLeeqW9sGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716920345; c=relaxed/simple;
	bh=6hLqgyX4u4wYeO/QCDvQdVnW0iIr+dwra/UaLc0SrTA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tIxvYUyC4rwLRiHDDIxm7Y5qkUoaf0yzC2sErTdoCzTTDFGWhZMEEYaaM4OPzV6wB6geGiaEIaV8oG2RiQ3d2prQzigMDsWWkq8q7ZM8/zih5hioVgvGP1cDBUzZrLgosIIE24maF33KfPbegQSC+xa2uyMZ2MNtjx87fUe7wAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e5d55441so150594939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716920343; x=1717525143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hlpgyzYUraXB1wmXa5xAjz9hRyU1TgAL1U3O+Bptf4=;
        b=Ejplen0qJfD+h7I9KG5QlBIjYvYx26FSQE08Ovgm/gTLzYPQ5HuDZvA7NKgPMNzP3n
         w4zBmFrqLvpmUU7jlTjOOzAfY2yH+VU4iUMsWbkIDT6UHXxOk7ICD43ipCf8M/nJzab2
         +EFTBQ4sdwlJ+Pts4XMrpC068z2lB0TAYCOST8tP59qTu7OtYsbzjbpYnU/g7tck/IAI
         di6ln4b867tWE0OctME0iRWSe1GWn+6ygnCgHvqEok9KgHskWS0GYr/PI4PtjE9+6rWF
         rRKjUoXcz8u8wC7TvgstCZMV9PctQq2Vx6g51MqaPNSLf0fLprnVqc2qvL64cXLPs6z/
         msHw==
X-Gm-Message-State: AOJu0YzfGCuF34rVS3rl+Y8s+GDxdUH4k39+t1/iS5Qm8Z3k2Lb4O6TP
	OUF60oxFNxrhbKOmlGNo5z16LEa1pRMBDrNKnV8+rB6fzugPi7h0YVsiBPMPO0MpwNv8UMwIZGB
	m6izz79gGimZvuxx+CpMAI7+svxmzOzbnaOPNJbPYwu8fMLmnDmaZVHA=
X-Google-Smtp-Source: AGHT+IE+/ix/oTB29nlZ5ER8oPGWXG0G8h5nwXfsxiaKXZPTaHByyUatlXcPWj+GCB6wWt+eNukTdr+GSUmuXvopPkPBrpAmyPQD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:851b:b0:4b0:a8b5:cce0 with SMTP id
 8926c6da1cb9f-4b0a8b5cdcfmr374081173.5.1716920343517; Tue, 28 May 2024
 11:19:03 -0700 (PDT)
Date: Tue, 28 May 2024 11:19:03 -0700
In-Reply-To: <20240528175907.3525-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ef04e061987ab93@google.com>
Subject: Re: [syzbot] [usb?] WARNING in cxacru_cm/usb_submit_urb
From: syzbot <syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com

Tested on:

commit:         2bfcfd58 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1453713a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6205b72d5900b927
dashboard link: https://syzkaller.appspot.com/bug?extid=00c18ee8497dd3be6ade
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e6e572980000

Note: testing is done by a robot and is best-effort only.

