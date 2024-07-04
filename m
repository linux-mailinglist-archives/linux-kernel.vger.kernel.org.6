Return-Path: <linux-kernel+bounces-241303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE092798A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D50B26AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD51AEFF5;
	Thu,  4 Jul 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRDW/slf"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD81AE84C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105482; cv=none; b=kBRiKc9UXELKyAvdqc7yepa6fIHmU+Q6tfemV84S/muEyDCeBWD9AKEreaYtpCUmREr2f/EjiM880/NdFMfqGS2DXfCMcgESRxaYYLa+28XvAQyQzMn1Ve9/IIpX61DT8bpVcNjBHDB7v1/ujouZLAxkXFHWLY9RSX3oDSwaue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105482; c=relaxed/simple;
	bh=nVQ5WJN4fk8XmK0MfllwsbUQxxLWjlsoAHgsH+vZJ60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AK1kw+5aRzzxXo+0HSJMnp1JN7UbkshFhUCbjLuYecVKOuRg64FEy4Q/Nhuk+YSygrLX53lq6TU3Qsat9HkHDMS01gEI5IN4Uu07VtA3VcvkqP3+vkWiRDNRj1+T3+UcF7EsLsDo6qXvZjVrhP4/+s77d1BZkwksmzISd4fGDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRDW/slf; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-380dacc983eso197305ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720105480; x=1720710280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nVQ5WJN4fk8XmK0MfllwsbUQxxLWjlsoAHgsH+vZJ60=;
        b=CRDW/slfPSUjxauMM8uHizU3aqULyFCSEGcjUrZbSf7Mbp33BRKbDKssub16V31eZH
         unnS5uJlHafwkQIKrR90vU7Ru1T/C1o0ZBzZhpR+YeTONfbJlhXFer9DuOTVrFt1sv1+
         Aa5wksn4N3q/PMP7NAsoJVUPVSn5ZN6U7Ng8i39D4ijr2JLJ8PG5wkOgJTjIS+UgT/qb
         jYM41l9SeoF1vG0u3UnqhK5F29kaSvtXoveTP+pBh7TtnSSCsMDDjwaM7fMpbKh04Izk
         OAqdSsoPkmifmejD8vE+IUfcQGn3F0ITt6UWPmqFDVPPxNXkR6w4OIJvq6zmgEK27KSn
         t/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105480; x=1720710280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVQ5WJN4fk8XmK0MfllwsbUQxxLWjlsoAHgsH+vZJ60=;
        b=iO5Q7NVYiG24uzpUg76bHsim1jgGMCLbYWH11blL2npudOvehDGa5B6RvZJk45s/Yt
         5pdr57ugInj1G758RywYxN4P/bPrCDv66CBn0mosyHvkv1eyjxxSEUy/FZhIYaQw9wUR
         jrQv4k5hulqf8utaYcrLyDEF1uWV+NCIf4mTXUCxmCuDag7xE4abXImuXQoOopAxd/3b
         +p8Rru4N6CCSWkakrMWWSxTDJR68wrhWsA3zE+QFuXKrl9f1dVqfpnXC2fwZxJx+xcOH
         SyH9MOv9hXBrosEluLTYjax/1NH+pXdDyhJdfptvqsu8alKUbBtOl+nKFPIDppmbV0LA
         GMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBIlVGGn/Ff+MJtEOp0qwH/CCmgn9doRauFGR6A5w7f5Xky5FlVu/M2DNPJfOorlaXy2kSXokI49ahP2D9wb4ZHjzC41ToqBSgk9uB
X-Gm-Message-State: AOJu0Yw7T4vnywqjUlpI9jSom3ouNzmMfclHJdNvnmB6Ria4p404kQ9+
	U6BE+zolp3cUAlT7k/y5FJOyp4i5Z4UGQp54q10Ih4tXgWbvTglhDgT418zDdRoTUfUtsutP+dL
	/P8jV2w85yDhNi/qfZIyTjBT8RYD0Md/44ZJ/
X-Google-Smtp-Source: AGHT+IHS4wVl7BK95b+qtiofP2pvB71Mm2j0xjjS7ClvF3mfyTcnGuwYfg6w/iwp7+LC45vznDA9DofYKh37frM4bAI=
X-Received: by 2002:a05:6e02:18cb:b0:375:9558:2b8c with SMTP id
 e9e14a558f8ab-3834e6e04d1mr2914815ab.4.1720105479909; Thu, 04 Jul 2024
 08:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023082746-antelope-drop-down-5562@gregkh> <20240704135057.1174408-1-dvyukov@google.com>
 <2024070416-hatbox-playlist-9886@gregkh> <CACT4Y+arKNML2gLvmXzqdfyJY5ydj0yjfk-NbrZpOLgTOTNH6A@mail.gmail.com>
 <2024070430-smell-cornhusk-1d6c@gregkh> <CACT4Y+az44BGCQ_DjOoCjfcQHEt6YEPi=pksFCRj=-zMrPwSQQ@mail.gmail.com>
 <2024070419-calamity-blade-02fb@gregkh>
In-Reply-To: <2024070419-calamity-blade-02fb@gregkh>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 17:04:18 +0200
Message-ID: <CACT4Y+ZwQGPEGwFc0Pq6pJyHLeYwbQP7xyoO6xtnh0ZAY1PTOQ@mail.gmail.com>
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
To: Greg KH <gregkh@linuxfoundation.org>
Cc: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com, 
	Linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	luisbg@kernel.org, salah.triki@gmail.com, 
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 16:58, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > Hi,
> > > > > >
> > > > > > What's the kernel policy for such cases?
> > > > >
> > > > > What "case"?
> > > > >
> > > > > There is no context here at all, and I can't find any patch on lore at
> > > > > all.
> > > > >
> > > > > Please always properly quote stuff...
> > > >
> > > > It's not easy with kernel lists. I used the lore suggested reply-to
> > > > command. Here is full thread:
> > > > https://lore.kernel.org/all/20240704135057.1174408-1-dvyukov@google.com/
> > >
> > > I see no patch on lore on this thread :(
> >
> > Oh, it wasn't properly threaded, sorry.
> > Here is the patch:
> > https://lore.kernel.org/all/20230801155823.206985-1-ghandatmanas@gmail.com/
>
> Ah, ok, resend it and cc: the vfs maintainer, it should probably go
> through their tree for other abandoned filesystems.

Ack, thanks!
Manas, are you still interested in pursuing this fix?

