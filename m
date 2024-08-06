Return-Path: <linux-kernel+bounces-276772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A9949831
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD12283CB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F314601F;
	Tue,  6 Aug 2024 19:25:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB5142E92
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972305; cv=none; b=hb0wn5WT5RCusYqql1x81OiphTg8zIXINr/D0fyFEPHiNf1qKXEEr6ylVmoL5I+w6cUp9tndqJUpIENbPgq32WbfxjNDWH+aTzm9f0P95tsT2wtJoUe1BbfWwS0ZoYJUYk9X5f5wqitjY9el7kbANA7BPIyNz8BquaMLpYw+Fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972305; c=relaxed/simple;
	bh=e6vzUCCBCzAeLMpHHJBYSLJEtYCfRSRU6T5J1ApKzVI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kgn2dsfnyJwWM+QoiiwZLOWnbOqk0i3VB1d1MOBfF4J+JaAXXNTOlHs/IxLqXAmzy+5mJ1kS1sh+tAVS0vq3nFjLnlIyQ7/uUAXZUi/naEWuKl2e0cC0m6lkNiGasOSA4ZZIlAHiNXSEF3ge49ioIylpuvsv85em/WLLy86gQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f959826ccso132828939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972303; x=1723577103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9sSKZjPD8mPF/NCzMX9c477v59f0hcAN+CRn3JQjB4=;
        b=Yj2A1/DAJIQmwGxpSeupDEhYty4yb7DvgCaTRi4jEwIRIyZzTilAUzZYo35yd/5UzN
         +JUaoomvW+c13VW4EdTeQqLqfqDwvjPk+CnB44xtVdfAymfSAZF0lY4D6Ajn068CXgyL
         NFWq6tKHkKqUHyc4IKKFo7/d9DZkCFdz2fyYEadU18fy6H3Ztv2XORhbpodVLndYbY+r
         3SROsKgAGl/w9FVIeGSEYuGikboNBNS2zVHj6P/LYFgytkhMwnnuD96V7Esp5y3MnakI
         6QTTkirT/wommLt1Td4SlKT9tSJHw72JjCnkwaBvvBLDwkxFkQP3Bd1R4DY9Rx5Ry1PH
         iTlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIjMfCmDzbuTPiOsPLPvx7juzVzLcH1v9mfRk/m3AsfHjL/wjg00XnY+w71P8hY25jIenq73lNHJMji4VJrNga8eQY1VA3SpB65KlL
X-Gm-Message-State: AOJu0YzryIe4qyTx4oUANNiAxADCIgeflAgHy36bpbmFRjvOI6n4K1SU
	t8+DoYDDWsZLlVv1ZyDdFYcZ6PMaWgLxWj13fJHuIRJeWUyDD8f+ud5Zc9mxA9tKNfYovNEZK/Z
	H4oxpIw6MMiAVf2g1Iz9/L/T8krc2J3toiKalkD4qJDBDV3ivPCXySs0=
X-Google-Smtp-Source: AGHT+IFniyFp63YizyD+GfCO5jp359kUSL4RMJgt/+eQ+Kdr01/VA8O/tRKyVm6w9IG0kMZMTalhuflyvGHo+Ky+40Fxm8pKSk8h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2393:b0:4bf:2453:3a48 with SMTP id
 8926c6da1cb9f-4c8d5717e6fmr537798173.5.1722972303666; Tue, 06 Aug 2024
 12:25:03 -0700 (PDT)
Date: Tue, 06 Aug 2024 12:25:03 -0700
In-Reply-To: <0000000000000e082305eec34072@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e43de061f08c0d4@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in set_state_bits
From: syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
To: boris@bur.io, clm@fb.com, djwong@kernel.org, dsterba@suse.com, 
	fdmanana@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 33336c1805d3a03240afda0bfb8c8d20395fb1d3
Author: Boris Burkov <boris@bur.io>
Date:   Thu Jun 20 17:33:10 2024 +0000

    btrfs: preallocate ulist memory for qgroup rsv

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cd373980000
start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72
dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148ba274680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff46c2680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: preallocate ulist memory for qgroup rsv

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

