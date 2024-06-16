Return-Path: <linux-kernel+bounces-216236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4336909CF8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9FDB210FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A357186E56;
	Sun, 16 Jun 2024 10:33:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D6225CB
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718533985; cv=none; b=MdUzHgwOFLqNSJ2uf0+PdykbaoCcBtWcHdMEvzBLAnKJ85mKC+o9CZLzMu8wiULsY3B8tNuTJad1J7LUX6FSwXfa3GPFytNLXHLy8cGKrLV9Z/Fp1kqzr2KAF5vFU6uxqM374PLDmwkv7CfIgTmsLeooLj1VAbSZKCIbkH/2JYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718533985; c=relaxed/simple;
	bh=PgYZB52ckl7DBappyE22q+TUI/9bLMoL/8Tc3TlfA5E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=orhc3lc+ceyXMpALnQ3asX2yD2D9qruAp2EjhNd1Pl4WX6SX7vRrj6otvqiio+/2YR4/QIB9w2R7cuQjjM7tTWu31uGgrxXVUmRZ5Jm7PhY6aZafQEoTaT+kodPSm9D6dCvziPqnbI3LBxOatJ5oeVYpK7I8YVOB3nR5XGmourM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso415597039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 03:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718533983; x=1719138783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oBixrl3EcdcvB2lxO33QYipV6HPmG4SqyRXozubx2w=;
        b=tfAL1jSxMBfRIVe7brbZLz4q6Ua/nGSEQpcSmmcAW8f8Z4vhE3AYOg5yImkQtOUicI
         /gEAmwbdrU28U+VwtjzV7J9uW6nLmoNJ7vangXPdf/TEWYNY37IqzqJcP+Gxakw8EfSH
         lZoJHLHm1FauTftvTa0D0lAz0Kxg/vWB9q9k9Nb78iXxZJvWgF5rVijJRXctsuLxQ2QI
         3YUs6Az4Z/vYHVpaYNkPBjdpyatOxXmeiSeiJ0NsiDVfjgiT14dDiFissOK4LZDyX9kW
         nAoZKMqUtbwLhzFBkPM4A/HJr9G1BYHvW8fJVJqcBJwUStZ11W0NF3CjZB09merImDDY
         9g2A==
X-Forwarded-Encrypted: i=1; AJvYcCWuU4cEaVEan31JoWzNmVMAKHkojyv4Y6k/DQ6xvHvzbNm5bKDoZQ+HyKSpniauzvFrSbRep4nTqjXhVsn4P2SqEpghLSg3PqUrtUsf
X-Gm-Message-State: AOJu0YyWjlv0cNlXD3gvjeTQkNDXwjrUr3jvH8m6QMdJJngIBWwiw9wY
	9XBsrzvVD2Le9ypwHT53bIjUgFDd/l+faV8NLLbQ4sn++FkByvItq55WKluVopzr/JOv8E1C+Or
	njwjBI1R5/ttsOMo1k0tdZlnQTBdotWDC7FClyUzW9WG7R91ZDoKXhx8=
X-Google-Smtp-Source: AGHT+IHFQkhIjRXtWG+SmzOXxSNByReLf5ZU/ccVKCF9Eq6+GWpK9d2qS25Chp6klkWbLPbassWMgIb8K8nYv1IfD6LKMfHbaNs7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340f:b0:7eb:7e0c:d19f with SMTP id
 ca18e2360f4ac-7ebeb643855mr11303039f.3.1718533983499; Sun, 16 Jun 2024
 03:33:03 -0700 (PDT)
Date: Sun, 16 Jun 2024 03:33:03 -0700
In-Reply-To: <tencent_6816BAF4BB5133319E881BB64B071B662508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f0543061aff5f70@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
From: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/16 10:32:05 ignoring optional flag "sandboxArg"="0"
2024/06/16 10:32:05 parsed 1 programs
2024/06/16 10:32:05 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         603c04e2 Merge tag 'parisc-for-6.8-rc6' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13254bca980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=686c39ecef854022
dashboard link: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b26851980000


