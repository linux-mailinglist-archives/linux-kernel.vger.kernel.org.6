Return-Path: <linux-kernel+bounces-280007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77B94C46E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4580C1C22D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7102B14D6EB;
	Thu,  8 Aug 2024 18:34:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E513D63E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142061; cv=none; b=JkKrSkd+Z7PRBP13nWYscC0MmIh0XwMjOzq2TsIJOPgEdDN/mFAenB2AOLWyG0LkJMhTogLX4J/WsOJZzaFzoqOQ0Kih4DcQuGT7NiZl+horkO5tGiyrGe6sXLj3Dtas4411HvLbw69doPq+0pOcu7ll9meMyKF0CvPtgv378nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142061; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qH6WycJ8nfcZt8sMsAwqC4sbNyicVQWY/dgl4xPRnj3QDwZFit6davYTOcnO5G2L1wgaTVxakkztAv8OJ2rxYUpD/fdB2/3oTrYIOsJp7DZvBhpgtS8FQBi+GYmhMgsb2+P9YW8xoIl3BvcrbNWGmUibIgXxFCbrc5zKgkJ9sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f87635cc1so159368639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723142059; x=1723746859;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=QsIfRHnBmbamYeewEL0nH125S9ub6tH+MOuDOGc6th17fE6+7O/mfHexZ8+qPaHA0+
         ansBk2YyMiAPuFLUf9ii92y06SDo9LEvZe7xOfvDa6P8ARYL3WdYEqCjS7HBuVgQUjzc
         cHYBs9jwjoOu/rSho6LvB7LPJ9LVJQAlK9cREQfHxb3spNSfeo5JiggJ78fHZdkHWdND
         s8HWpstaxxja1ph0pa8IvvKe/hGmkt+as5EY6bF1vt2SPKUyc8CIPaHoRYpJEqvLoLX2
         4AkV6fPtTgiw6ONKBD+XEmEKRsvFTS0jARkcgA1Fv7tWB1eleACIDIasyJNC9lczcJ+Y
         MaVA==
X-Forwarded-Encrypted: i=1; AJvYcCW4DKMr9n7AAwjNl7cGFAbNYuLvFGSYcxxKbJh9f0eh0jsPDf/+yENwYdAMEdNEnFQUbrs0U5sHc5dqRE3EezbrXsAjBzikQtbIFrG8
X-Gm-Message-State: AOJu0YwURoH6yT2j2ZVA4i4LZViJHEF/U3UYP1JCTPP9K5yx+oOqxtWL
	DOnecQXZt+a2Jc7SGASsQwok5H9S+mjZcrKRA5yDSbEE8aZdjvZpLYJuM6I5wrqMX/WJK1Co+6e
	o8w6EL6pvSu/kVEESlk8DwROjmK+vkng087VUuA8C2POFy3mWDxXkeuk=
X-Google-Smtp-Source: AGHT+IHAVcthn4u2TYL9hCDajzn1SGYRWIlZ1iJ8RrmUyqA0kroAAagIT+VSUzy0UBJbPct5kqvmXxmuGAPeuYaVCIDisNoZSAJR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2161:b0:381:24e:7a85 with SMTP id
 e9e14a558f8ab-39b5ec6e4f5mr2414175ab.1.1723142058830; Thu, 08 Aug 2024
 11:34:18 -0700 (PDT)
Date: Thu, 08 Aug 2024 11:34:18 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000508163061f304654@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

