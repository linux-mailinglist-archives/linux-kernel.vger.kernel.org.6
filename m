Return-Path: <linux-kernel+bounces-447432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324C9F3239
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C327D1887CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661F205E00;
	Mon, 16 Dec 2024 14:06:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955EF205AA4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357966; cv=none; b=LYsoM18+0qMZUDLLRJ5HjrXYrPMeTJa9IMlLdLafusjvHbrciRdxDvYzfuZ5onUG8IR+Rp6IE4wYRQeSlzN9JIRg991wtbtBwlhGGJ3Hx7gfvK5ndWeMom584oIK8OipY1djrIaPDSwQUgZ8NpDHjK4Ycl6v8RgSVgG4dWu4Jt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357966; c=relaxed/simple;
	bh=suyVl3bOYmINCJkMIB1VeSF66Pk88H/s/xO0gYEOGRI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gEd0KJLGV+Ybh9CMNDT9gb0MCOLX7sGiSbTNXAruosCUEzcWEWfgbBSVrk9qyKfktkNggV8Ej/L1cDlRahbaGvntuq/R3jMOJFaABw9mk9X5F8DGV1nSWheCwTyjNA6ieOvPBEVLoP8mupi6pJ46PdazIuSz6Af50VKU2MzRYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844d5c4a27fso811129639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734357963; x=1734962763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nPsDvmGKodXuv1uFoU8mBvrLWQj3ARA/ptF52uOQjQ=;
        b=AkYuSA5bdY3DIulDrudTXpr2aMOhETycHVXT9iHm+s4D+SsaeB7zleUdhVcgozhEgo
         IjeMusdIpU/U641p6Z086nwuAUr8OE36MUhOME2YqhLK4qRjonXYUVWjxyTGZWDATeS2
         13NOLjZdJcA8z2GULSy77uDP8fe2IiOtYknSC5JFtgQX2cQ7Nzn+GuAmrIBPBqfmqa/Q
         grKIQLwsD1IS6pJoF4b2b6gJdTRv0VPHyFS4v0UOgnDC0KuxzfAH6Zf8GNZaU90HNiAF
         y0JeZxLgOA7WBxRgRtQRnyPTlI7Hpwyy0kMjwvVsrz/tnQX9RMqipDqQOBWIpc14FUKP
         GHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXQRVo0lzoO0DKxYbHbAraG8UQrb6sBrkmzY9G/YciMesrijzOb1A6xACtSYkPwSQFgpF4C7T119HXN22Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqVW6qInPDRAz189TFieTv0mfRh8nnSXnwo1EWHM5LBufhwmV
	qVuyHRlFvJgBG/NjjmOWtsNvihVRp4bezzCtxMJQXdgEPRXuOYPHjyPc3tFWDXIXChpAMb12lz8
	ESCcqPMEJQ1gTGV+vgDuP2l0k+eEqSR9u3ob01OV+EL/CugXd+bS90pU=
X-Google-Smtp-Source: AGHT+IHWXAzO+gCEEm6249LnaKArOUQINHIQSGOC5gc6d0Qt78HhlJEfKhquf9A5msntWLabenLGPiR+3ZTLSA79BGKS+iOXZZ2s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:3a7:4674:d637 with SMTP id
 e9e14a558f8ab-3afeda2ebadmr127955865ab.3.1734357963612; Mon, 16 Dec 2024
 06:06:03 -0800 (PST)
Date: Mon, 16 Dec 2024 06:06:03 -0800
In-Reply-To: <tencent_2A63576BA6DFB370836C496EE3B4C4505705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676033cb.050a0220.37aaf.0131.GAE@google.com>
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Read in ring_buffer_map
From: syzbot <syzbot+345e4443a21200874b18@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
Tested-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com

Tested on:

commit:         f5f643b6 ring-buffer: Fix oob in __rb_map_vma
git tree:       https://github.com/ea1davis/linux kt/syz
console output: https://syzkaller.appspot.com/x/log.txt?x=147bfcdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8d97faf7b870c89
dashboard link: https://syzkaller.appspot.com/bug?extid=345e4443a21200874b18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

