Return-Path: <linux-kernel+bounces-282134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41494E004
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6EF1F21511
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8217758;
	Sun, 11 Aug 2024 05:02:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904B36B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723352525; cv=none; b=NbUzR9CqUYoQJiBKMq3iPTbHbQR3xZwRjl/fxYi6zKC1RwDWSVJBODENw7FZhnYUenNtieSoIZbi0IeY6rPJPsl2j1xOQm1vcyPTVXA722q502H8QTL0nEF/OAOElVVHJ0agRKh6CnX62ypWocLJ+Oer6j0TfgYjEn1hnodZwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723352525; c=relaxed/simple;
	bh=06TZRnbFoCAlYpxZJTmHToxibr0oxXoWxaItXtiVZOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Or5Y2NPaKsdan3AXs/Wh5KhuXyLYjMLlZAcJ+dpnYldZJw3euWnl8b1aEqX6N3hwxTlQmT1BwZbcBVICt9jcQ5LhnhbgZ+XvLD4IpncLWNRt7dC0ISvL9xz28HlZdBUmOaGJw2Kevyw1bpAo/WVuks0ErwNN/uaA0yOfL9hW8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f968e53b0so432600339f.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 22:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723352523; x=1723957323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCfyB5Mon+A6DH6K9d41pXOaaka7AXTjTFMccmVWmeU=;
        b=Iqglcc0k6081ank+7n0Bcws+rmMvOHItuRs+lTH8e7RukamixAG02QN09S+kDlBdtC
         dWbjj20p3Q/16uko+8KLdqZQlX6NPBF8+gp3s7pfa3CdD9ECQm0U3pKeC8oh859hF3Lj
         2K7Q5DhP7SiUA/DwU3ZQi45Wfdlx1agEI3qrg4wEw5agLBMweQV91//fjmWzkpJA4KY0
         jVBIsCWfihwwg+XLgVKLEzSY4QFKKglV01b9Ey95iNn/+XW6bZXs8zDHW9O6uU26mQPx
         HMminiHJR8qElW1A8lhQU9a4lSk3mlDFSlJGMl/ZloK488aSp9cpwhDuIZjkNdA/xGQc
         Oh6A==
X-Forwarded-Encrypted: i=1; AJvYcCVnG+L/P+DFPGccCEdIRZfc49o9mWkG4DEewIwuoAUCv19Id4a5RtGMETAtGylKfXKKj/pMzvuy1RalJ1EHWCP/fYiM79GHgbuy4Pwa
X-Gm-Message-State: AOJu0Yxr0QEaFYbMt1pOMJ0kMki19DbeR1s2Ks2Bo4qNWPdo8DtPxP3F
	9LCnX4EX5uS9Zb3Ws2amzFHTTC3tw2ajPo59NGWuqCWMjcVjoijH9ffi2DsTVdu8a8VhVWm2afd
	gJYECP2EzFhl1HzLdansmYaN0v0WypvUo0o68NHA6fhpRlQddu6DIyHY=
X-Google-Smtp-Source: AGHT+IEFc31hugWN/o60s2hG5RVlrslA1fX9ouSvc2dtX6sWNVe7BlfrA3R2gTHpmIJzU1HSggDOY9QzUyShLvLf9VMlDQKdOdsx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:398:8d01:9c4c with SMTP id
 e9e14a558f8ab-39b8134a47dmr4492345ab.6.1723352523470; Sat, 10 Aug 2024
 22:02:03 -0700 (PDT)
Date: Sat, 10 Aug 2024 22:02:03 -0700
In-Reply-To: <tencent_E50D86925ADD975D9F19124F878D82259407@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc285e061f6146e7@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/netfs/buffered_write.c:513:80: error: 'struct inode' has no member named 'state'; did you mean 'i_state'?


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1054666b980000


