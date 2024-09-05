Return-Path: <linux-kernel+bounces-317458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6296DE9C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8541C21A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0B19D895;
	Thu,  5 Sep 2024 15:42:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CA19E82C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550924; cv=none; b=TCRrE3gtzq24nZKfpgXPFuYv7PUA15rCuOjx5HHcSHP1s5IhIaKhqAK41L79YJ+qcf8UELHiJWJch1cvhFS+JtFoRIO/cJkVuD/AT1SCYuvIwl/xmX6znrowMsZ72qOBfAr1HOy+yW2KijCNsQcZNv/Rg3yR6WVhP96i8n0KCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550924; c=relaxed/simple;
	bh=NUNw09G1MIXrFHY5P+ifwqkj3KgtlA8FTCb/ioYtZXg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jYa45gsaPSZ+VCZYy2fH3aKbVh98Yb2YiJEXJPg9FIui6Nfq7bS54OumwOkVIO3r9glB/l5rmmrTrzI9lrNhk/4nLIn7XWSE5f9RYBY6X5jlgiVSKNK02910bL9ERKI3wvFnm4xVgjDvHX7YajSNtQKiJn96mpcX1wFGov6OmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f510b3f81so47063005ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550922; x=1726155722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPhpbXwi/Of021f8bfFViSsy0MgHxG8zFmImLN5hOdw=;
        b=ZcZriDVewPw3PeZwt9a8u/X3nFHLl1rIxVjpWC6N8+L6to0lMPIG7B639YJpJ/tnL3
         mdIBVSvYTAQPT1A1y61dz1FjSHZkXow13l7i+Dg3x1SBnbovzptNjhaD48N7AYJeEgMm
         /R6hjGJRk9EnioAvOccqpEj1YgJtJ0F2rUuwT5cHfRMLBZVmrXYCWB2Hof5lJeYoz450
         QFXAj+cPmxtzPzpjooW4FpMfs3S9zhERfAsYMqeVuyeLfaG3Yy2M0ixU2sKXtbFR9hZm
         M7BS4pkY1CsJA7LH37uMkD0OfzNT6JVnYlA+Crw7uOVpF9Y+9Vmag4JHkqubYPfliwSN
         LJig==
X-Forwarded-Encrypted: i=1; AJvYcCU9oLeGzcXv/ttapGrA57VY2aTQiF4whAYvmmpk3V0UloQ4PChbkNVXvkzUE/vlD6gQG7siHBZdNB8N4GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56JnAngo/ewaf3Gy1YVOsFDwV5GmnkAOLqsUwX3Zexb/NTrCz
	K/qSPs5DofNF9i1THPfrkKXKDGD/4qI7j5Y4bBdZOh8VKhnrD3FqMflCRvDu/PbvoBhmAZSGCkd
	QVWSjRBkWi8xMwj6Nr3I7Ryp3MmNfHhexiJ5DlVwaowtAcic7raKfpN4=
X-Google-Smtp-Source: AGHT+IETw1P/YQQz1jItgL6TD3CLiI7HKKh1fuCoON1FET7WZsCTN3wnlQALaupAAUzWyFcXkm3nDgnKy5J8WMTXj/BtLZBgkjwa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c8:b0:4cc:d5e0:a114 with SMTP id
 8926c6da1cb9f-4d0600e56f4mr269271173.2.1725550922182; Thu, 05 Sep 2024
 08:42:02 -0700 (PDT)
Date: Thu, 05 Sep 2024 08:42:02 -0700
In-Reply-To: <tencent_0A6AED06CEFC7A8E6C402E156C009578E80A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c243160621612131@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

Tested on:

commit:         c763c433 Merge tag 'bcachefs-2024-09-04' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139f168f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cb8f33980000

Note: testing is done by a robot and is best-effort only.

