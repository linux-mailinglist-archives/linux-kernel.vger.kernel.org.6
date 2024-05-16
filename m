Return-Path: <linux-kernel+bounces-181479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7278C7C88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19ABB1C20DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5D1586C4;
	Thu, 16 May 2024 18:28:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3566156C7C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715884105; cv=none; b=iWR1ApffcnulEuUt0AtLrFPhnDSTyiwHFtHUOTcyRvs0VD5HppZkEd1KiBx+7DdRcgMQxk1B4SbkU5ZVE4xS2BBhwkXQtGjEvLLKU7c9GRaVSe4/VbjkRykd1E/1HJS9u1Lx1c/BI0v4jRRFQO8jGsqwxGj+lTnLE64Obv0OMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715884105; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aIjpvi9zUJ90o5UNqV3eQ7OkHHhcUV6mFsmVP3ZIhr66ckrBvplzmqBwgczc1rg2JpmdBV3RAfFS7WBfFqaDG2fivouwvHFIKVbZVIogc9AGrOhwu6XuUXYP5YE5DxTj1xuqy7VY9+rLYB8zx5n+CSR3RX9vFjqBlq8Kem5bX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so886223239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715884103; x=1716488903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=XXw391s2NHJ06Ng711izWuzXZkxiRksu3Gj7qC2CPcjw7gqsXKdXPdHIgIsEodgcR3
         Hsy4P+JP0vkBnKzid/9OGk6N119x6AeB6wNtA145VDygWcjBCJiLU0kM3ZFF3n94TBU6
         FvfDH24PcnK8IYNK2p7pwb7a5zA5pG8SK0zZIGUPi+R6QHGMXP0QY8lz72kc5RbWSIXv
         SSeCxnm8ysrmAygwuI9lAlW9Hn4oPlE25J0UI13+K1m7erl9a+TIDvw9DxVWFhN33AeJ
         ojdfRUhXDGY5rE9YbOrCfh8pka6hsQ0kz1Zk8arzKQ6L0uU9v2s16nzAPafOOkCtXKEQ
         SApQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDu/KDkhb5s6toRaKm+FKt8OA/VghRPjaqoiEvxxFClNYYfcAh6+AnFvv/OhCNO1B+lpetkiyPMJ6l1lJ1Tp80ZKzFdrdLxrwBYmXY
X-Gm-Message-State: AOJu0YwwPiR694ZNDeK01pE5Jq+fQNxfFBHYhcCy2+Lonvu66eRT7z1y
	YTrwUOUWYJEjc3fwcXmmw+oh1aKYUsCAlow2OGDi44zRQ98ukAJ8SvySb5ko1x4VgfEQaJANtiE
	p9xDCEiyt1uYSEwICSlvfUEnDU1+H9juYFMdBGih0Hz71CrNbI5QyUrQ=
X-Google-Smtp-Source: AGHT+IGKKYnqdAHzrld9TebqrsNNwKIo/KHdQn6r+DkVA7nvsLxlcQmJjp/lh+6pTXx69W6Co6RzpGinzhw/WGufFYsVoBdG0blB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8506:b0:488:f465:f4cd with SMTP id
 8926c6da1cb9f-4895856fa08mr1523351173.1.1715884101697; Thu, 16 May 2024
 11:28:21 -0700 (PDT)
Date: Thu, 16 May 2024 11:28:21 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ba4340618966617@google.com>
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

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

