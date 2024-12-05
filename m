Return-Path: <linux-kernel+bounces-432906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4B9E51D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986C8167A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B01F03F6;
	Thu,  5 Dec 2024 09:55:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124DA1E00BE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392507; cv=none; b=sYDmR9+kjX72V3t+MhRXx9XqNyZckJJ/2rnIGS8syBj/nJJUpA8ye9fVmcFyfnEN4qaNCjz00/Vo90aN+upS9OW6Zq5SDA2/7Hg0dbYbVMxmT6sRaZyH7GLCRBuLW63q9MTxMHeB+wj3li3F2dlKj0eCBpg+h9RWYO3bDC3X6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392507; c=relaxed/simple;
	bh=Ufgi66RfxCi7ERNaWT+nPjiZs5AfiniZT10BVzD/xII=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uo0zprjVsrqDzDFeG9ruShzr8p+fgepUv6QPxd2DVnRw0nIYou6eK0hmupqU9ET90T+UvoQcKQl+Qc4e5WOookaY/VpY3i4Ms/jddQ3RoXbP8v3BjCiXBlFYpL6CpIinMbclKhHw0dViQ2BN4Y4mimNyZuVk6tY/DNlLRsZfZqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so8035065ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392503; x=1733997303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfggCqqBWoLO91n+D8yNyr35qeqXJzMfPlkZHv4hMvI=;
        b=HecycSw9hjdlpRBDunhG0epWpSibdm0cR+dbqXUPOMmt/DEbbqhKLOEaDk5MJ57sz/
         w+2XWshrUeF71VToq4ZUKwNDgPq9sSzRe24w1srs7LeS5i6aPizB8bKN0af4gBGf6rZs
         NbM17E9JJhvnlFYFQxgeBBfrRF1frp3HsLgv8dGacYW96VUgzlvI9DWkc28EK2fZQO9M
         YU1n3gcZDU8kVoAiVkZ3V3cdEtFjz1FIzLKmnLiuyIPY+mdiosteqioeOrzlhhx1j/YB
         3Q7dE2BAbIV3A4+SD1/Fh7kpzvE7ippe4TnVkoKEjpa7GP/gD3eHRx1almbU1J/u9JMv
         6HuA==
X-Forwarded-Encrypted: i=1; AJvYcCU9pr8raicJjiCThPbPqUXBClF7Hzu3Q2NTfLxp0U9Ge5dSX+P+Mp4DlVOwQ4aka68l0xL6nIXFl/esCuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tDCydRBhekSCN2MUR2neZ7LReaEQjrLZ22YJ8tOgrvsOHsk7
	uGMLRoGYrgzwZ6JLN4GRqhwKSY5jaF2zx99WYkGBHYUgNu4+RCvPPRFYxJbYYeW/ETicVz+rZHR
	S8xilamRwxzbTlx+M8DNUzOvUkL/oN/nHXv8+SNQllX0S7cYDlIctcXI=
X-Google-Smtp-Source: AGHT+IFSzh5k6HtmvHADu2SaEUxm1KGQfy89qowI/aFouL2G6zgG9+FYL/mBCZVlELqFH/t6cF/Y4saXXgd0Cq0JWCbub2QzuCp+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a7:87f2:b00e with SMTP id
 e9e14a558f8ab-3a7f9aa0bb6mr102276285ab.19.1733392503288; Thu, 05 Dec 2024
 01:55:03 -0800 (PST)
Date: Thu, 05 Dec 2024 01:55:03 -0800
In-Reply-To: <1ecc5960-41c1-4e20-8972-c0f46f894ebd@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67517877.050a0220.17bd51.0098.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: 6751189a.050a0220.17bd51.0084.gae@google.com, 
	6751747b.050a0220.17bd51.0097.gae@google.com, linux-kernel@vger.kernel.org, 
	mazin@getstate.dev, syzkaller-bugs@googlegroups.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/mgmt.c
patch: **** unexpected end of file in patch



Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134ca8df980000


