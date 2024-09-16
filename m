Return-Path: <linux-kernel+bounces-330102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F779799BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319A0283939
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 01:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196FF7483;
	Mon, 16 Sep 2024 01:07:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76A2F32
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726448825; cv=none; b=mYsXpAMzdsoh/y35QlHSNNxjWIZiglR+nfo/iqaqjNe2UvxWYF+Ct8tbLiF65DaJVTwf1X7pxKhMv2GiYT7u21lJQ5umyuoE0otZdhcmFihTdYN3ppyp4iEGbx2bQvihencB7E8Uh+s03Xb+FObDfPFMKKL2cg//MGcJl2j/Klg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726448825; c=relaxed/simple;
	bh=p5nvkdkGT5y5UB37vxXTjcQRv7DqcPt9YGfs71y7KcQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WIGJlSMUzSJO61rniDwzBcM/hvRqkNGKFihUhGAVsQbtBJpewUuZXCHJFCuFWFpLMDOVnz4ZUwyBpMhIE6LyktxLOeTPX5IwTDxDNKCk5S8SjILC6bn3Lv03TVze3Vh1v0JNKAoKCUphWqBN2qwYpTUVXG0w0ZNohqkPUcSKtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a09e96b72eso17437915ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726448823; x=1727053623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K09Tra3E/hJDku0IB8+NUKRch0wNFu+R/T0Dq0Bc2I=;
        b=HkDEstQlH5AaaawWgrNDWU96aH1O2AEzEg/tyuAVBF4VR+Ptwt66Rfe3GWijiErcIw
         HFMHeJCNaWIs9SlkSV/yqvTwnxL8EblyE6mP/h3o9DZDsDVZZKIB7w+GgW2vNpPIkGL7
         Fl9B4Q5L/wLnu7dZBl16p7x9vsrjTwdrkCDF3+lEU0zlNckYYjHMqMCKy/wOqNf2YRux
         qZ5lKsLhenhPsfXnSvH/NNFJ8+oV7fGCUAteCYTglQPdKp9G9gASIub7G8H+q0AZ5UYu
         tKYCT2o+8XQsWLiW7b8vZ0ZHA8Jy5LjPr6o6KDrZHf6k5hnUMeMBL8SKxN6/5XM+ZS42
         5KEg==
X-Gm-Message-State: AOJu0YwQn54aX3xFxyYxDLAyDxrrvhvUxk61QNceCo5HZDXCABq8QE4b
	tbfEPp52u1Dr6JajnKI1JYESHPD3ljFyZ1G1SUwysnVDBRbHP3L6lni2fAlj5vW3snYnhYLAwzW
	zQZE8YyOHhQhMi/pTXWs/aT8joaMHo/hPx/veIu1z974okidZ6wBu4Dw=
X-Google-Smtp-Source: AGHT+IHvmEs4G6D29+XnlbrYZ9pPwuOtAAJ8We5wCAgzvnX7eg7aEXEKa215B9s8NlROsiETjc6JwRq4NTf2sN9duHfSexItcjEM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:3a0:98ab:793e with SMTP id
 e9e14a558f8ab-3a098ab7cccmr44521735ab.23.1726448823546; Sun, 15 Sep 2024
 18:07:03 -0700 (PDT)
Date: Sun, 15 Sep 2024 18:07:03 -0700
In-Reply-To: <Zud_7s__fu1aVw_u@debian.debian.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9c6880622323052@google.com>
Subject: Re: [syzbot] [btrfs?] [fbdev?] BUG: unable to handle kernel NULL
 pointer dereference in fbcon_putcs (3)
From: syzbot <syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, qianqiang.liu@163.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Tested-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com

Tested on:

commit:         98f7e32f Linux 6.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1003e797980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb52fa3eae0757f1
dashboard link: https://syzkaller.appspot.com/bug?extid=3d613ae53c031502687a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1596f407980000

Note: testing is done by a robot and is best-effort only.

