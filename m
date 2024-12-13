Return-Path: <linux-kernel+bounces-444425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD909F068C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F45168C82
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198781AAE0B;
	Fri, 13 Dec 2024 08:40:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180A19992D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079204; cv=none; b=FFYYCy0yRk0fNlgsHq7x4DfLbzxR7yLslA1Yr7Fp/rX7m0IFZlfdMZyduq/dUXLvZNL4DljPUl2nkHUNYanOPUtM4LVqGiN/2Vvj2bZFsXTdUYuMYNzl2Nwqn2yzmPf3tVudLK7f/GKe7vQQ893+3CxMvJyCWdwgnxBZ3O8X32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079204; c=relaxed/simple;
	bh=n8FZ4bj7YmFORZJ4h/F18SxiEw/fQMdUz9CBCWduX4g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IOfHsyvjv7FQcbU6o10jPvsrHAmBGzbeg60TmVJsib/Q+recw2HpQBwjNzV6aXTxvk1Q/fxKyUz662uiK6l1nssEdz5mMFAD1RpRWrCfLD5fPzTBvCEadV91n77kdMk5nAzMh5AwEUObq+PnwAIATedzBVvG/pgnpbHsYu4Xj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so13548365ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079202; x=1734684002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58EGlvdaiugOBQ9LCJG+wfdlsQahddhH4BozOY32Avc=;
        b=mnuxKjDPxbVeogU0sxzOVcHB0ik5J/9yaghNW2fUyFEUooHLwC/0B/yXZJhxRLpMNa
         GN6n9EJrRtlObMi5/zkTmm4KlCmiTwDqSvxuEAyrbVslpVaZL/PXoXnhPTsT8tDaHO7k
         c4E3OEzLpnZ3Tah9dYA9D8pK2aAOGNvk7xnqzK3lSbSvF02nVf1L5VfieD2RqgQJgy6M
         CA+tNCDQPWrGX/v9VskIrPOIWWQzFsuEcr7UXiCTy1AXK/kyQ0aZhRj1yoayOGy62qbz
         dGFA9tvYnPFIUg5Uqkdu+lSaZRP7PnJU/DUdHeW8RBhQ6XvUuleFw+zziHi2zlAV6d3G
         Gdmw==
X-Forwarded-Encrypted: i=1; AJvYcCVw8OJ7hErS7lyQDjj2OD6Z0fJwrW1rMaqTscMfZ7theAe95VjIPpKC2ueJ1eBsgJyqFS6XNc0bxmOQnlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwedT7olNWGIbnWeCRqEX2XRpgXpuTEYGMA9fIGeHDEsDkS9crO
	pw9EUt/qWXwNkjIXS+u5tKdcVVoDHdznKWV6esvQXBGlHAT3lCxdYArtK6OzOLfrTVAt2y9FqeK
	hYXMMUGL/s9ZEdhB9xaR/fhhd6n9qg7P+9Gr7ieF/QsYGwF1U50uDzpk=
X-Google-Smtp-Source: AGHT+IHVkq1zYKCtR79sOp99nQ/ILfc7hyG0sbt2fy5vtGcr1olGmZKQJBAFmaMZi0M4T59IjyFs8h+sn0l3VnXCLALj0UKIZM4o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a7:764c:42fc with SMTP id
 e9e14a558f8ab-3aff8b9ce4cmr20834385ab.21.1734079202428; Fri, 13 Dec 2024
 00:40:02 -0800 (PST)
Date: Fri, 13 Dec 2024 00:40:02 -0800
In-Reply-To: <20241213081711.WmGWv%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675bf2e2.050a0220.cd16f.0044.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_get_dentry_cached
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com
Tested-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com

Tested on:

commit:         f932fb9b Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=136a5be8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df9504e360281ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12204730580000

Note: testing is done by a robot and is best-effort only.

