Return-Path: <linux-kernel+bounces-263941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2E93DCEF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025311F23F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07940186A;
	Sat, 27 Jul 2024 01:32:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E915BB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722043927; cv=none; b=rBeS32JfGUNcxUAvi9wlfdSIv4GULQafUD+1KZnI1bVvjBCBT2p7RbW4U0M3ioi9EoD2kX2VXsgbjWbJOV9x3SSENuGC2+NnWMRvEYSXE6LBQATqNWS0KHTVzmpT4NxGV8rc/bJT5xA3X71Rav9AvUMPqFU6hfMHoOaXyp2qt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722043927; c=relaxed/simple;
	bh=gdwkvZuWv0wzrUpycjBx7u+O8B501NXgOSSiBbkfRZQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nld8hf6srHawbYmFu3NomNRlamT26LY3Xu/JCJNoo01TiUHR4kIDEz6dTJC7PhhxhzTv2RZP/c8kjaEIgepx/qo/LjlJplBjWRL6vLlz7YnJa878Ib87EEJCh1LIN2QivD0r648kfaqMJHFp2Hbf2m8GB8BPEexLo0qFmz5SjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39696c3f2d6so26386795ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722043925; x=1722648725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYLNThMbM5/P5iCPejXnVPRGkiBwqBxl8b00WUJlvc8=;
        b=vdXcwUpTuJq6H7ys/ljANUg0rZtNXQi15qoc56MXq3L9UD0EWy60iWWDXhPuA//Gqi
         FX5+6l3QZwgMlmU9lDN1g6ZmsUw2Af5ghRGHeWkty7x+qoEuWaoGxBVFGfZH7uEmEPCP
         hSLF62KmeQfgFnPXPDQfk7MqAKmmrr8lD14HIWeiR5Pt55vmiOw1SyBdmkgX7m1YzY0W
         8rB5RcT6T5gUyt2EEIZLGZYcE8n2269ZrGwMTe54AgNcjHNQENpvKJg5ZO3XHGhtPMxw
         5eBghltfRT4scZh6w9dUGq79DU4GoZbwM6M1opM9rXF6lkmjVDQ8/0UfmavJ4tB3QXnS
         K0iA==
X-Forwarded-Encrypted: i=1; AJvYcCWeArlrg+/UDTvNMZd8Mj8MuG2u2ymnR0TmmPRdZBRyEIrtVz3eEUCGz2Tv7w6MREKrM9N7R3Fq9ZIMDlOmgYkWRvPBwGxhwYNfi7MH
X-Gm-Message-State: AOJu0YzHXid83MNbXc5uTu3bGB3xcdv/CQ+QBvQvd2+tbYukIQs1Bl8Q
	vyAAi1+33qK/v/3Py0uyWqshGVLshqcNqN9OQ7sg7bYChF0JC/v4BKDcsCHcO7GhkH2/ZhO/SPD
	OtmJ2sqFsOAm5bmJlzArSoqUtWuJVvoJEbor5qf5uJQXJhsfW3VBbno0=
X-Google-Smtp-Source: AGHT+IG5kz6iChVNK6x4klYTNfnqpHBvdr2i1ONWWtzaabOkLZqmw+Y0oJkLptuDyU5S7Q0PfwNf4WoVcjMUBkMzxniFCSKdA8eU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:381:8fa5:3d9d with SMTP id
 e9e14a558f8ab-39aec28a270mr1019495ab.1.1722043925357; Fri, 26 Jul 2024
 18:32:05 -0700 (PDT)
Date: Fri, 26 Jul 2024 18:32:05 -0700
In-Reply-To: <tencent_2D67C43CF3361A96A4367A4BA874E776DB09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007578c3061e3098f0@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbSplit
From: syzbot <syzbot+dca05492eff41f604890@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Tested-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com

Tested on:

commit:         7846b618 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1329dac9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10245ae3980000

Note: testing is done by a robot and is best-effort only.

