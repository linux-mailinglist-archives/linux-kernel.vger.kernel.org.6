Return-Path: <linux-kernel+bounces-262534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7048B93C862
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1C28258C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201E47A5C;
	Thu, 25 Jul 2024 18:33:19 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149E210F8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932398; cv=none; b=H8B2AEMehN5pJKAPE7RH1iZsvbnpDhsqHDFKuCQFcJVmsE3pi/KTYdoWe8kA0oke93/71bc1XR/vPO0/c/JcxVzfutAnqqMtXB/4J64AhIPV8ojkV0My9z62lrABta8honijizcHsr1uMDJYY6VGRdlh1Y63IM3K+nWcI15fVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932398; c=relaxed/simple;
	bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aYhTMHrT+tkMqcwcDm+dR5uGiq5DsDbFIuBvmetbtZEQzCMtVkGMk9KccC1ruvhxv1XPgrPcPlA+B6KldNLDKhBgaUruGHUNkPA9nEygvfth+ke9FBo3ze/jvvUWl9ZKLG3VEhWH+U/Hbq0Bq6kHFztzoaMbvsv115EOFmKxpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-396c41de481so12430535ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721932396; x=1722537196;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Uplq3g9tRJ63VMtyTiFluF2YqaQGF7G74yVJkKC50=;
        b=vC9W3wvmbhxeHF8RjNUjEiqk1m3jeP6vyh1gH/MoZPqtEmiIqYLM7p18xYXy1/vBia
         bFncfOsHM9+QEh2D1YraLEwZKOGYm7szElkUmJp0VsBoVd5xqzuWHwycHb/NCXvs912o
         otir6c93y4cLjFZ3HKUNgCrtIsbQn2JSjOt/X2i/Erd3qHe5AKzZ1wRsfbKzkfY+GOQV
         YFU/2lMfGx4E97uLWZy2tO1JVbG93nRHpwKpaL+XzVH3WMk13cCuAvPFG5FTcBppTeOq
         DjsDMEVIFvRTAZKPLofciKFbF9Y5NqSPt6y7Tro5dEJBDXooJGv07eNjLdP9CNl9tpYW
         ftLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVKQqnFQPPbGy7BGrYskW74k3ZJx0Ptdn7hNFuquQhF07CSV+Vjl2P+lYGCm/sG9nGdA2KUmctYAMzUgLx32zjUpQIbqnWqupZrfXb
X-Gm-Message-State: AOJu0YzW7VT8wSOTHBhkOzdlrfc2lc4bW6OX8IIPNfPGaO/62sF6qex5
	4iWFbl6O4KSc/txpQRHHoVwmkDPIizi8vcz5yAz4qBRpMH92grKjwm8GdGcui6thXTEkhIgQx1/
	3rgX2zhe9yijBFiy4Z6qJhmxEockf77ni0+2nma+4hM4C9baeLEwVx3c=
X-Google-Smtp-Source: AGHT+IH2jrqSfCw2gZLBit8Qdra7oizjuhXH36fBGkIDykjebFbU4C6K+slm8yVokO3OVjbqARCt15UY+rRic7ZwAjmAWSVEBrNa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-39a2187f30dmr2884075ab.6.1721932396538; Thu, 25 Jul 2024
 11:33:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:33:16 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2bf2d061e16a028@google.com>
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

