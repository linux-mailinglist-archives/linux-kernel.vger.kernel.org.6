Return-Path: <linux-kernel+bounces-332458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12797BA02
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5447D285482
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E191791EB;
	Wed, 18 Sep 2024 09:15:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19017838F
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650904; cv=none; b=SuJoiI3/th6stPlYzwcYMZYL7NS20msBdOPp79zUhBjuPodME4LGQs1s78OF5KDgWeWvgLQZhdgkhu+FobPUEZlZ8mMd3tqKrO8AEgsJkM/6NqkLc6AX61+GKPhs8Ote/aD+XlVqCqzynbsLYN6XMTRUMrbdwtFrHKeEIQWAoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650904; c=relaxed/simple;
	bh=nIojU1t+NBdFWxtcZpCRIgQnxP78MURWCOgIBsCYfsE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nWvwJnbKQe59/1zVjB4mxs4tqOwVT+huc1JZ2W4INTi4D5xeB4eYLYUto0KKA0G0+mWqmtcjATwa5VHncB4ZfH79MxH8HAx1E0pX2TGRr/Zurk7fCD5yOSBSR7YwQSGVefdY0mkX7J2RaTlBet+VjiUOPLIKZzJ1J7zbnzhHGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-831e873e4e4so134248339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726650902; x=1727255702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ups9qKYymLs3+em1q1yNNMOB7Ag82cb8z4/3SgbyKgQ=;
        b=bSMUEL2ZjiJnUc28JvJA3+TBBHsBo/FBILqJfghy4uJ6Dx5ow9l0d4DZWVYkxfoxcM
         R6hiIjGxc0w9dbjCEpqUP4GGPxv3MzZLmpUzoNeRmF3LnibN0QyX2E5/aC0EmaluOa8j
         m/XR8RhUjr8U1iNzK22UuZhU/vPvD4gySCkOOGmfRTdLBhaxvlQwg4k/YH6b90ipIsGK
         Sks477v0K8m3b73Blv6pSEYSDtKmrjha/3n1nroQpqD8YEnlKFbA42V1517wWRI9L6GB
         vaCyqQPfziX4Ygd6AeKNxQJM7vhwCUQi+oXyZb3Zs3+D6L8+F06GebXiJ2kF2+OYFPks
         7iGw==
X-Forwarded-Encrypted: i=1; AJvYcCXdAWsS4KneDa0vH+3rjz/VzDuSi9WdJ2u6Glm8wMP2rDaV1Yr+vu5jqbO5Bf9LjSfYGdsp2KNpL+IBSX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA9/1Mskff1SiSTmJapoSRrYcNq9wClGu3hz85i7rhKPxSezvI
	i5hPEqzSlsMrH+QOogJLY6gCLFNAzRvqygIfm/yizvg9PBqw+uc7dRDoEI79u03YWC1CrkYZgU9
	0GO9OJvp3czHSoGEWVQcEfMb4IP8ZhJblytaeugBgegGf2k+ZNnShy0I=
X-Google-Smtp-Source: AGHT+IGrUUZQGwOZ9Q2kTOV729y/sUElsaukhEFTJGFE7CTE7Scd55ktVw9Fel6qP3z++8lvWtukd6dVirpuhKz/whqy8v/r0ZbK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c10:b0:82a:a489:ed93 with SMTP id
 ca18e2360f4ac-82d1f94a7f1mr2160714239f.10.1726650902210; Wed, 18 Sep 2024
 02:15:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 02:15:02 -0700
In-Reply-To: <d99c7072-3790-4a87-964a-787b6e37c59d@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad7e090622613d7d@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Read in
 udf_get_filelongad (2)
From: syzbot <syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zhaomengmeng@kylinos.cn, zhaomzhao@126.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13a7bfc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12939207980000

Note: testing is done by a robot and is best-effort only.

