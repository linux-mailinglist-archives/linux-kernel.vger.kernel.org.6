Return-Path: <linux-kernel+bounces-272280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19691945996
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEA6B23ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D11C37B9;
	Fri,  2 Aug 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUAsQ+Mc"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DC1C232E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586080; cv=none; b=gxSPIcnmENLcLd+jbB9J6fg/6NcVl0q5pRUNrTRzTXcodCSftM4fBDpbui7OQ2zoOLDvPjW3mKLyFfXewgz+hu92KaT/rPGPsxBFGeKSu07HRtvRi9auRZMiZyvgoYaPoLqNbQbspGP09kMEHuJHkB1T9LgvH5iUTKbfJKr8i6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586080; c=relaxed/simple;
	bh=zr17in5873w0D7frEzn9Z1BvBNMtjb7Z9MPgUwnjjT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r09ZSka1XO7JtZSF0h09fKC00V8MVFyFbG19oXQFNjEHLngucVrLcNjmk0iRqlHVHSqrdeJi1SimfODwXqrtKO9gFADt6K4jMDH/b+8DTMJ88r0LIA7Ho08HxhPSdAI/cxNKMn63olwtU4JDlJpojoez2ezMk7nHgPTCUz0Wq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUAsQ+Mc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f01afa11cso11699076e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722586077; x=1723190877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=escxcbn6CQpzZVjl6z5VUlZK10Wql4Sh9GSQYpnvjOs=;
        b=AUAsQ+McMuzLxujWxipKKVvsbaANZuzCFHavP/5J3zHzFJvUvDkvpAaZL33cXrMu/Y
         0rTRdYLnnucYRfSjI8KSy0GKyaYNsOaZL2iaJiu51UZIHTsURE5bn2IhoUfYHDtCMcE0
         Nd4y1L7xeJjpolmoCxHzlStf7VLdme0ZLZ0YMZ5BjHOwzHseqAg3OJ2MLXuy9Cnp9bJd
         Ki4dNeKgGelrJvkn8yujKLCxzbd6gkgiu2yrl4LMsUYyLlu3EyxFlLI7fefjt0ClHIhq
         wYFWg0zNp5CywCUim4xSql+1xIdmw85KyZEiY7qtlI344XdajqfQ9af6xXmSNWf7x1yC
         dXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586077; x=1723190877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=escxcbn6CQpzZVjl6z5VUlZK10Wql4Sh9GSQYpnvjOs=;
        b=v1t17DIrczka7zFOvOsXsZh3iX+XRQJ9JHr/WvYgBNwx2rJxvhUGsa3i2NL5Q+FcsS
         Q3XFikYvzERR+GjohFS/HASeiHvTI5KmnA4Dqlei09NZuneUnMqUcv8BPhR2RRAnyg0b
         gz4KQCKD8p+BvnpOl+iieq8HJUXaQ7s+Q62TYy62xauKPsKUg5PewqKYzq89Q8hQNzQP
         tgaeXAxD1SFJG5e6njQUBK67BYP1eRi7fAg5GGBaQtL8DrUembsf1p21PoNkKmjzxGqd
         TQSSt+wm7ot65kfi2s5y4bGqMZgR8h/AO19yZyvYrqmSXmRTr0PyE9R9kw+2wG+X0C51
         25NA==
X-Gm-Message-State: AOJu0Yzy7Ji5DzWP2gAiMtOeyOte52DhEnKGYiie3veGhbmc2+r4/F+Y
	3feJzErLA7U9HZSS62CcsckfdE5Vt0zaWosQfhmdQmRQHsVO5rbxO8R8rJ5l+2sJSIJ6TtIPj5P
	km2CXKWeF9/Vuq5hgWd63bA7BX9me1Zu0wdV+9OjodB9VRzm+Fqtn
X-Google-Smtp-Source: AGHT+IG+xKO0y/MDURV7v5Ye973aEWq2ZhirgU9AGFasanOfoT8SM2QxjIQmJdkM6GFLTO/y2v5+4WlaF2T/WZYjysc=
X-Received: by 2002:a05:6512:b8d:b0:52e:f367:709b with SMTP id
 2adb3069b0e04-530bb3a34f9mr1726621e87.42.1722586076673; Fri, 02 Aug 2024
 01:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000052aa15061eaeb1fd@google.com>
In-Reply-To: <00000000000052aa15061eaeb1fd@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Aug 2024 10:07:19 +0200
Message-ID: <CANpmjNMENK5NG+gjMm67--p-4h+c89bkSngoRJ3XTpkqrH0=Gg@mail.gmail.com>
Subject: Re: [syzbot] [trace?] linux-next test error: WARNING in rcu_core
To: syzbot <syzbot+263726e59eab6b442723@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 at 09:58, syzbot
<syzbot+263726e59eab6b442723@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f524a5e4dfb7 Add linux-next specific files for 20240802
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=174c896d980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66a5509e9947c4c
> dashboard link: https://syzkaller.appspot.com/bug?extid=263726e59eab6b442723
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8c0255b9a6ad/disk-f524a5e4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/71d89466ea60/vmlinux-f524a5e4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ba8fcf059463/bzImage-f524a5e4.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at mm/slub.c:4550 slab_free_after_rcu_debug+0x18b/0x270 mm/slub.c:4550

See https://lore.kernel.org/all/ZqyThs-o85nqueaF@elver.google.com/T/#u

