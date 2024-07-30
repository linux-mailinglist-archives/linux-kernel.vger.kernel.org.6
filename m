Return-Path: <linux-kernel+bounces-267559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31C9412CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E616E283B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502CE1993BD;
	Tue, 30 Jul 2024 13:07:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84A1940B3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344826; cv=none; b=opWwQww5K6pJG14s2Uj8q11fKHRyeaicnoNFvSnYRVKCwWZs7JkpHaPuuzkdlnJsKl+vvnIjyG6S9Ug0XoWqge1o86ORzaEAFahpe2MDKtHo/5AswcBjj4M9fRfla674f29iVyevTKtcPl0NZysC+CYaM8d3+ZbPFAk4aq5Z24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344826; c=relaxed/simple;
	bh=mbqz2GjgMcqbOWsI5VG9tRrkffiOYceRs37gnofot84=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ab6zlHtcqqgirdV3+dtd90n271qV1YNu6BInjrmG0y4iGXqahHDqQH71oLGjy1k9VvpmjLxeSSubf0AvXt57pjMUuG5uEW5tGnrmIEEt4kbxY90FVtwSuAikxdqntLOqVmv5xged55J4iwbOJXcrc5Cnx3IgKw/kiTQfqOGtbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-804888d4610so547565239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344824; x=1722949624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTOuHVNMBvymd6b7Z6rmfbM3Wiz/gAwxmAwK/4EdWg4=;
        b=CIvYQUqMVCG3aXMj+VVOpBcaMwTYlE7aOQ4PBJET24faxUkPvl+sZhrSig2NlRb2qI
         9atEeNTlWHJJVXI/duJE0ejs3fcDDV8u5kw7Z+2Zoh6U1ghZu6x7WzjjVVLEP9kF0T9P
         9mipQ1FrZM4qNYN0RjXuIPQF40mgJ2IOvJSpddBBxjCTKDfjVpRxNfKikDBxVYGVyPjk
         KrHPOgavWlAj3bm536l9IxllHox5BRIQ7i3yVPEi7a2PZIMQQpYJA1+BX6pQ3PtHeCRb
         zKEDWYj+f6zynWLiBcNVzoW3zXJj++V2yHNYzHJkyiK20kVKE6s5G/t8/CKtVP1s8GlP
         RTxw==
X-Forwarded-Encrypted: i=1; AJvYcCVwp0Q54rwm2tIqjRhVSBVzsVCVpyliiHKAorJs6Oe/yd44c7QXr47a7bKVsykXiZiw9UN+s84jeDFP3grNf64D5+ujBQk+F9yAk8FI
X-Gm-Message-State: AOJu0Yx69zJff88ZnGAGmzxQxWugYWiRdcp+1+O5RabHuPUQ93eDcu4k
	V9mgdZwJ0cbpA/4GTuYNuviTfC/rEkjZkuh4ETpoMnX7lACWgra9Yc24GFI4FRd3JgQWhFAfAcO
	6gBWJXJBQf3IoM9yfszQfhEGXGl1TjhXR1eoWKLD7+aO6IXlYJgcwm9s=
X-Google-Smtp-Source: AGHT+IFI4FIM+IMen9l3NNTAnGrDlGGkhzmlqXaaGHQpggqh+KeIWLCX3i7fRibGv+YBcbuR7XRhoOam0Vxo+sAt207tWnqw1F6U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:b803:0:b0:4c2:71c0:e792 with SMTP id
 8926c6da1cb9f-4c8ac8d252amr58344173.0.1722344824476; Tue, 30 Jul 2024
 06:07:04 -0700 (PDT)
Date: Tue, 30 Jul 2024 06:07:04 -0700
In-Reply-To: <20240730124026.24187-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071a4f2061e76a779@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Tested-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com

Tested on:

commit:         94ede2a3 profiling: remove stale percpu flip buffer va..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1021ee03980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04fc17f2c61c03
dashboard link: https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13792c6d980000

Note: testing is done by a robot and is best-effort only.

