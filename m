Return-Path: <linux-kernel+bounces-514975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B731A35E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E1F7A4A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C78264A9C;
	Fri, 14 Feb 2025 12:57:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4531264A77
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537825; cv=none; b=JIAKf9tWUrHjS60RqNepkzHK3biykmdceckmV0W8ESuLonrTkwQ8Wqct59cwq8Tt3MbblkTavtb7O0+zNT/nZcgI/sCNn8Uh1L/dfyUKaNw0V36iDyXyhAWBZqNbftnxdHa3S6XK1tQ8KS3d6///KrfudD3YPeSX/tiT1ZL4Zls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537825; c=relaxed/simple;
	bh=CPHz60C8a9qX+uuRp4hw8/y8Hnmg/AmljFxibWwl6V8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qGcLGyXE90f8LNl5+5WUndHkIf7jK/JRF4Mj3oSS1Xu/e1FRhttXeuvJDXOnCCWk4WZvGeW1Z9VDgW+WH9nFNxJuH87VwE0tImze6hP3aRiw+yme7iqT8Vcz8d7V3TMYO8GUd0KTf1xuzMww9SON7guafm8AOmSrtEhUtNderqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d18fbafa4dso10448055ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537823; x=1740142623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUSbSpAevPGuG9ngWYHmIDCS8bg/Oq62kesJYc0GYvM=;
        b=dVZQPzwDDIjvkCgjDXTpaGqkRdZYWitg44Fo45pYkvJS16xTxIPBjL9AxvJOskcyl5
         aE4CC2tqG2N7e0bVw9exjpzbAx0JwgxljxdVRLs0lPP/CBvMUtZofMtGinMCEkBDZV9m
         MLZs5npppXrI1pAIOBDGNhMgT3L2qnIznQOJXLENgnHg9rdHVFo6tKVppM40iqZ1YpCg
         353iXmSYQ2fKzBRY8WVPmnfgO/u1ULB26YcZcaNOMgievsbFWs+yI9G/O6KOB/Bh6FFR
         lnWswNRtfmHrh2s5DMiiqT2hKRQvGVy8Ad44mLF9MmvM9y5Q7thMw5cqHKIF0tlLmJKT
         FR0A==
X-Forwarded-Encrypted: i=1; AJvYcCWeWpL4EjNK1T9yBx9So3VlMDyM6rAdKimpVsFsxsZkEB6nZTqxbWOP/QTsRg7gNZVnjkamSCswRO+fobw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxwwCHJrMLt6MLYOykvWgNPwK0TLUjI2erAgL0i3f7XDHwXfpV
	RPYL7qPNtFx0w0gsWuGzdF7dE9MmstVJ8dHRrX/mMYW03lEcjjTBTZaTmbegRj0QwNGoppzb43f
	ms1wqAtT6SjBRLF2AUyJVT3VRQ7BQQaidfk7Ki/iFH13M3TGrlqkzeW4=
X-Google-Smtp-Source: AGHT+IFOGuuSJVDA7wf1R71MrDyXbNgSvN3M4+j0TrePDx428e2i50E4lXDKL7085AwkL/xKY1pxOWS5QtRgh5pJrxVZ8RYhB5HQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:3a7:6566:1e8f with SMTP id
 e9e14a558f8ab-3d18c2efbf3mr42123885ab.16.1739537822634; Fri, 14 Feb 2025
 04:57:02 -0800 (PST)
Date: Fri, 14 Feb 2025 04:57:02 -0800
In-Reply-To: <tencent_C7123BDDD75DA11956CFE20D8225938DEB07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67af3d9e.050a0220.21dd3.0046.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/netfs/read_collect.c:376:66: error: 'struct kiocb' has no member named 'ki_refcnt'
fs/netfs/read_collect.c:376:33: error: too few arguments to function 'refcount_add_not_zero'


Tested on:

commit:         128c8f96 Merge tag 'drm-fixes-2025-02-14' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7ddf49cf33ba213
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c14ce4580000


