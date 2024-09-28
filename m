Return-Path: <linux-kernel+bounces-342338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B412988DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3361C21291
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34278165F0F;
	Sat, 28 Sep 2024 03:15:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D115B54F
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727493305; cv=none; b=nxTZB3sSuQ7ct6fcxlGf5kV3ZvJkPiFfhzw2eMokkWyQDQyYt+kfCOAVw6OQOoncPWk2TwTiG4ejE3YQ9Iis6tVJsnuYl3z5tTZrCXOzKb7/hdgRlLPhFPmpVl2z23s2WGG7+0B0OH2j1Qzgh8XfVV0oKvx66ZR/V+6HK2p7/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727493305; c=relaxed/simple;
	bh=GI5PlcA7k1T0SPN11Js8TGmiwDLVxJmVmNY0LpQ2u+U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xc3DXD7QjrglrJ5QnWeM9myPxqYAnKtUdnHUqzAVyEEHnpgpCnK0ZyZ4PYzCVC2ea//xoLM9E6MC2x0Ow5b0aVzAnXs2t0Xb97eI2oWit7JgPANeT2K93CZW+WaYWdx0g56j6RHh2DtuM1fxWj1oYWbZqO3BU5ttYyA4rwmgCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cf30e0092so251238739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727493303; x=1728098103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=of15A6+c6OVOnBSyfpHxoxeIJmFo7yniresxfuX6ydM=;
        b=DlqO8kylYFLicdCDE34aQCtlhaW3gnKVPTybZbm6xyxX0d8L2s3dYhFVdKYkwhy6f/
         KjN64iy9B1PDt5qlrDbl0mDmi4mPJFzizV7+7dR/IY3c87OIBeA1MQ10WfiL/Axpb3UI
         pHyAzVMyttIO0Rxro7In1x/tZDvqwMMRtOkg5m/zMrdDdBHsm6FEMaoIsJSbXau2Q0FE
         DY28ww1Ta0F5XYov7M25cxz+ypE6RoFNTuTZZWuf1BVgTrBB5hs56qilxDOsV8nFmZC3
         xlnBu6/Ns43ICsFRgMf8J4tLqEecMXPvloDjT+92KFMgabNrleCzEuFw8ODJxhikEaj9
         AYZw==
X-Forwarded-Encrypted: i=1; AJvYcCU3QLEpkN+CqM23fzmQPstnb5nfAJ+wFV/3IfzO8koxqm3s2RczQ0zK7B0pWAiyU6JakN8uTonXnLGIsW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnIqn8ewbLACe9suOAaEtNaPCsQk2dA8DX3KBZDXqQPms9b6G
	zHXeWRE1Go5bfaTKWs0/qUb52zD129949aHfypOUnr/2olg7UJhEa6o7cnDsDbMiuTfzrBqIvOx
	gUEYGk+rhN0iL5QS4hLsO/j96Q5yGbG9IgZ1F1CR+PsCTxrUkZlGzJwE=
X-Google-Smtp-Source: AGHT+IHu8aR870tmrsFMAh7OqP99syBX1HGq/p1JiP29OwoRwxJ4K6Doqd4JttMGza8m5LGwv+PabDf3IkTBzM6HF66aIQu76fpN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:92a4:a462 with SMTP id
 e9e14a558f8ab-3a345161df1mr54434605ab.10.1727493303471; Fri, 27 Sep 2024
 20:15:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 20:15:03 -0700
In-Reply-To: <0000000000002dabd805ee5b222e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f774b7.050a0220.46d20.002d.GAE@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend
From: syzbot <syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com>
To: aha310510@gmail.com, akpm@linux-foundation.org, brauner@kernel.org, 
	chao@kernel.org, jack@suse.cz, jlayton@kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit be4edd1642ee205ed7bbf66edc0453b1be1fb8d7
Author: Chao Yu <chao@kernel.org>
Date:   Fri Jun 7 14:23:04 2024 +0000

    hfsplus: fix to avoid false alarm of circular locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c5f59f980000
start commit:   90d35da658da Linux 6.8-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159253ee180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11afd4fe180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfsplus: fix to avoid false alarm of circular locking

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

