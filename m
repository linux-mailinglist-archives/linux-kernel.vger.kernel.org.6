Return-Path: <linux-kernel+bounces-364396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E2D99D41A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7282B284A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090161ABEA5;
	Mon, 14 Oct 2024 15:59:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955C1AB6F8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921544; cv=none; b=LZ5U+3ACM2J84hEdBsXI0a4AgWkKVGdoeDyOWOZm8PGLe+/JHFvSlPlMzuBBgKKZwtheb1jZYToGZYeKPAExielLzf9ZNy5tUW2h2WIOlgB8Z2Db9Ij1H0Nt5RJ2u9LTauxtFj1HyuZK7Zjiohor8KWkPEjLg3kHqW5lCQePYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921544; c=relaxed/simple;
	bh=yYjCjnKyWWEhTK49Z7J9QBWqaLavJtlsumymWwDexQc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a8nBpn18nklKwqGe37urMBtb4N5Jij7HwmSJbhwBfqCEAShz6Q4a6I15bo/hubgl02k3MCj7V4aQgIgcm2HdDx0iRM26w8v5j8xN+Hd+H10LSrWiJGwmucsjGIHRvHlFH6obLANF7cMpydTnrrko2vXIRqbkjaE65FtETaUKViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ae775193so32079135ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921542; x=1729526342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2B+oHb7GsvncoATojUDsI07bjYeVlJ7EVCHHMvtLChg=;
        b=xKxRQSAxedi7IcRZxwsiDPtOT9TA2Sd9OO4nhqhZAhexYh1SU1Q73CRH0o50fj3vpS
         jzMtX26FqWmILQXc66WkXYK4eH5iIsxd1HoG/76r7qNSA+yRzp/OegYZWwRkMKIB358R
         gT8cRT4CGhVaDPej5+e90YNOCas3V9+RNh3kaH/WfgMGcArQ+r7us0bg30KJLACThT1r
         mig1oCbepQedsb0p05ImdAS40c5OQMkM6iVG+dGjMpY9WPwqqwmXDAUJFFXJv862clvf
         ktVDusH5stc8wyz15NOBk8Px6logMdwegPbwDfK2t6X9hTSbqMW64hhQ4H9wURRYxiV3
         X+YA==
X-Forwarded-Encrypted: i=1; AJvYcCUmaoszitqpXanSGD4sRMPR8EG4O9/53rpmwf+kKefi8rRnXjhZvpEMdlKgIRaZWg8b3prheWShhatCs/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5lVjx8go0ckDVFDZ+9SF4GTi5/UBdKFPb3y/ckmMKulb/6OZ
	3/vFmJ1fr/pWcjIJiT6sSSD9T2XMNPyHimbYmyVRXbKo44Rq8lMCjOWmbQBXyDhzEqiuxOJ4L6Z
	spGsODi3OCyonOk5/7c8HlKcyLD13AqYO4mYMP8yu67uIhxzLo4u+ZDY=
X-Google-Smtp-Source: AGHT+IEB1o9aRPaI5CycKDs1+XfU4SzSOYp4i6cVka7d2UQwciHA67ck89wKCzhAaiBHOR+qNO/WaHGYCOzckPXIK36LJoz2VZj+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:3a3:983a:874f with SMTP id
 e9e14a558f8ab-3a3bcdc6bfamr71677955ab.12.1728921542422; Mon, 14 Oct 2024
 08:59:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:59:02 -0700
In-Reply-To: <CAOQ4uxgbKV9q9WVwrwv28ucAEUfh1V7T+gqe6euTm+b_+TcG3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d3fc6.050a0220.4cbc0.004d.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_real_file_path
From: syzbot <syzbot+aaf95b6e8fc9d906d8a7@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+aaf95b6e8fc9d906d8a7@syzkaller.appspotmail.com
Tested-by: syzbot+aaf95b6e8fc9d906d8a7@syzkaller.appspotmail.com

Tested on:

commit:         2d66a7ce ovl: convert ovl_real_fdget() callers to ovl_..
git tree:       https://github.com/amir73il/linux ovl_real_file
console output: https://syzkaller.appspot.com/x/log.txt?x=15a3385f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=aaf95b6e8fc9d906d8a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

