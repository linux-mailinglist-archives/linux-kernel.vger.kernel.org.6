Return-Path: <linux-kernel+bounces-397144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971AC9BD74B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEAF283944
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB836215C5D;
	Tue,  5 Nov 2024 20:57:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED411D88DC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840225; cv=none; b=jZ5mUpGfE5PVT1GP9e4QwwVSIoA+gEf/NM8kS2jD5qtLzy6XlAWWQeEf/p13iSZKwqi/PjjPqO8m83Er9zxSl/8P+Ih+DYej4bM+OOqasdiSanNacpeEc/lx+o4n+m6febqhNJbBq0BIj0gAUZ2uigvZsovAQqzxb0BNBEBB9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840225; c=relaxed/simple;
	bh=Rcow9jfHqw1ol+JMfLKs4Izooc/oV+nGZ0wbSpnPls4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lSzZaad3oHUbbKPV/vLOE1ngZ8CFisapKoacgyAuOm+lSopmefSf2BJpEmDXGNxCWEPu6zx1nXMMkQ6PMvzj5g3shWwphqTqOmW/dWA5Q1hpkeVUbTIBJpPqNLt/cH31/BXslJXaqazxVsgaZcqLwij0bvoN4hek5ZhxbUDFpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so63062735ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840223; x=1731445023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWlLOkYl5RX+sK5ZKGLexNA4v/0o6VZqy4FF0r4rLPc=;
        b=ahl11xi3y6g+X6HAgEXkpEDX6bFTl1wfJ6pxgCR0+zz7PNYYoc+PE681Bvw67g08XA
         CPGz4oGnR0gFF8w3TO4Ss3mCXn5vd19Mzgd1uyR7HYo4w4PxNOUnF46bQ8Ny8gRNNOtP
         NYuPcoy3XVFTFLWZZzMrVfSqREScs/JEmX8G/c0291iMdopvZFwidcPm/9+17KJGPnl7
         xJE2ESAhZ5M94NC+F/+wxWWsAbk8dXx20xxE8FK1avoyEc8b249CUr1G76GbN7xselPU
         hqwE4ukBc+nhagzTjf0YREcWZxtJLYvehCB+qkdUKqr69ItPs34LOqMBdyy7ridtnS2m
         ROCw==
X-Forwarded-Encrypted: i=1; AJvYcCU2N73MzzDrCqxmptVMXUlAlVUzIDkGqAxT+CWouVI8RFlXIGvnXn3gJf+YtlqGr/GhcX6bG8nMQhnHw1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDS8ZoIEdXU4LxWernfXu3+TUno36egQC7Ud2U3hafazHpeuQz
	qMhbj82+kUnIFQLuuU7Y1zbu+IMgnt6HMfGrVT8HhTb9OnRsEvg+ZxiI+apg1p9dbK58NecMtPG
	YUJtwxbQm5CBKaUOql9ksGxyVbyBOtRq4O3wtPZoe48anRIRyRavH+jA=
X-Google-Smtp-Source: AGHT+IFrku8FjFWo4/WrJdVHVoimFNWxqHOqEZNHKEy/m+GRVrMLsF81bnq5qRk8ErnTJOfyxT/ChMB++wIsmYTVq+bg328HclzD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a4ed295a05mr415429575ab.13.1730840223033; Tue, 05 Nov 2024
 12:57:03 -0800 (PST)
Date: Tue, 05 Nov 2024 12:57:03 -0800
In-Reply-To: <20241105111749.vIrkA%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a869f.050a0220.2a847.170c.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] kernel BUG in free_bprm
From: syzbot <syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
Tested-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com

Tested on:

commit:         850f22c4 Add linux-next specific files for 20241105
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a58f40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa8ace328e85c186
dashboard link: https://syzkaller.appspot.com/bug?extid=03e1af5c332f7e0eb84b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a5ed5f980000

Note: testing is done by a robot and is best-effort only.

