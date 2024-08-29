Return-Path: <linux-kernel+bounces-307120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175696488F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D53280F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D911AF4E3;
	Thu, 29 Aug 2024 14:34:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56F433B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942044; cv=none; b=TGIKOs7g5wikJvxHDzkvzkEBH91kNn2QT/WLUHfG8z+E8gU64jNZGJMslGVaGcwFETbcOdi/JW+X9WIEPgkX59sXbFEuiLdNI8S63edHOP73e1isc4TVekzcyI6hT18OmWi9WtOASv1eN6UscE3ZnxnNYNtOzo4sayiC6BvlXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942044; c=relaxed/simple;
	bh=lsJ1y1Xc0wrp5dOLqGK1+jAkADB4UC0+J57rr689Cmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YcG/XNGmMWuckLF5y7M3RhCH2BkSQMz/imohw3q6JdgtKPQVS3/abqMWI3eGauX00zqIzn3UsRXjkgBobPRRk7xPCpoh86wKYV73NPHzD7+x7aWxswQ/w39ag+6AhqeFaVi+2h7NqtRoVavl+eyMiNrlemp/1m6+LLP0rkB9Vog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d465cd64bso7994075ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942042; x=1725546842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSTFbpquW3VDc6S8jA/e0eRDNuh0lnOOa4QhrOi7oNo=;
        b=jo/0s8yL+ZDFl879eozN0oMZq2e85F1X5HRTvIODQx7b7uuuhwhk1zf6flWRwbXzhb
         Kz+vp1JoXx0sO0k286X9gZ5eYsaG0Pv+qwfXMQbjPw28sX41j+X/oyfQ4lF4kRyphVWA
         R8A6mwScAiKKGAtaeyRNOgss+v6bNqsvS3jHgNSLg3lUqMXilCP9g4RKwhxCbHSLJgtk
         xXrNpDQeOYPZ/2kyy6bH58d/TFDYAXQPJCheR8HvYkI2brDNRuDYFPt1mMBu5/IckmmV
         NJNLTa6X7YUIoUrkECk9BgSQP9IUPxOu0ENQ5zgPR1YUidkRBWoSk38kCZhK21uEpqyp
         9u+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcA8LoCVbSvD4qVzMRET8UrFKKIR6c2PY3aMGjHhOmBgQtfW3I4HFj2mUkNQ0MDXDq654WYdhTUYI9KXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywznqj6d0QkMg80zL3pZken2fj077/mBQAXdiWrDtc/FfFOdT9I
	1nF/in/yV1ZACQgAa1EpYhRBMBOMvPM6CngCcegmH4KXW9DkHH0tUoolw28vfOB9KV3qSdb5o2w
	uYz6xvFo/M5qk+RcfI4kClngoDWdaVBTtlCZiaAv+J4Yq0I4ig9tJ3Ds=
X-Google-Smtp-Source: AGHT+IHoJlQnP9kcIsALbaXTiqvMvQSm7KHFYE9fmn/JhwLhquoYgvLCXgmZFx0/aVOP/ldVtWuyqrf5ZT663fLN1phw/fsBFdl/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1547:b0:39b:2133:8ee5 with SMTP id
 e9e14a558f8ab-39f377cefdbmr1611755ab.1.1724942042665; Thu, 29 Aug 2024
 07:34:02 -0700 (PDT)
Date: Thu, 29 Aug 2024 07:34:02 -0700
In-Reply-To: <tencent_82C82F756FE496A0E9E2EE16CC747ADE6C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6276c0620d35d34@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
From: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com
Tested-by: syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com

Tested on:

commit:         d5d547aa Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167ccf8d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=ba3c0273042a898c230e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10dcde33980000

Note: testing is done by a robot and is best-effort only.

