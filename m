Return-Path: <linux-kernel+bounces-241183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE79277FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03961F22071
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4C1AEFF6;
	Thu,  4 Jul 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzOLzbxG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9D1AEFE8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102448; cv=none; b=W9DydK7bv+khG2msMS0wQtMhbrtnYF6F6xcIOsFX/xI8YpyH9398vq8fbsle2zvTW5WLZO6mM3fb1Xjl4y31jUlqrsCF0GYfsYnfxxGE1SlvCifoN4EFykxTc0xPCYAUTVcErnDFRM3DurTBivgZYiGuL0HAWL3wwLXrW2SLng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102448; c=relaxed/simple;
	bh=x3Dw/3JoSR6Plp0fIHlHJyzdmxfWmxmBK8E7elO5i9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfkVm3L69//8V3lpqnSmSHjgoWUpwjhVyEDYBn1ndSP/ypBwc4KlRwqKk1/bYvRh/4CmIo1l4lO3Yk8S/yLjP8R3GayoP5VZ9afUnPkx2MPXYazdrTCK5fQ34M6MFdyXgAMC0uAMnCbBd0B3Elg7XQhyAJvpfhCVgwhp36dclh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzOLzbxG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424a3cb87f1so68505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720102445; x=1720707245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Dw/3JoSR6Plp0fIHlHJyzdmxfWmxmBK8E7elO5i9k=;
        b=OzOLzbxGJq26WZ72glOYoMiwFkR2e7vHBLXH0hFE9wAv7o8S+9OoBmntlC2calkvMN
         F8Jq4N01cmBKOie/dBSNi9mA4PIZ1uVMlcdLpMfF2bQnV5iMLPYq1xekajNAWEHk2WSj
         YwXSLXHaJP+oU0dvjO/qymFug3JMAJs7JqB4hKt9RKG9tGONCMcadkb26fnVEhDbZ0Ut
         1h4qZB+k8chi+8XfR76LPcpJD4Xy2+h2RGf7AYeoD8RTJLwl7GgoAa1t/0e/kHDQVB5U
         jSRJ3CgfR3e8AijuJKes4Ias1Rm1EImnwHZi+c0RD9a6EJtyemA/TZfCCrG/EI/3PKIz
         pUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102445; x=1720707245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3Dw/3JoSR6Plp0fIHlHJyzdmxfWmxmBK8E7elO5i9k=;
        b=Z4pU+8KB69Xbf5ubA1K6PrOWcKxfMfYNDrJPHfrjOFhft0qT9xpGjz8mUPbpgATZf4
         QHMF2MRFpqWPchig54JmMLF4f3Kjq9ggBOAtmpAF+aSW72FCyDcolADcwsn4raG3s0RV
         W0mLSxEx3VpbQq29MCVcTEHJe7FAo8XtJa/pd+4Cqt/aP+8V4BSVL9Lymc20BQEv1tAu
         bbJnyZuoqOT3dgSsQd/Su/nLFPpbjpQ0H06FzSqgig9KA/psjZY6aXzwNy03/Mzlgt/g
         PUIFd8bN/UcRD1izOFtWtQGDMKg7ZM5v8iXiWB7HjZ+5PSGXQFwWSMEX1mM7pKS9yVWE
         dIRg==
X-Forwarded-Encrypted: i=1; AJvYcCUduz0uMB+WVgHllTxZiMLjkqUAmVM4U8oPJKZUzr7fXlqJ95UghKI/yHFld2tDN2xnwOiMMYdk8dTsrn3nwThopORO9YlZoU85zegp
X-Gm-Message-State: AOJu0YzuMtzOLyy5NkBlAKcFa8QUoAtbDS0NRkiZFxoZMUAG912q32sD
	EoDpj9jnMDDWT0QqcjLpRnAwwQbDr4t1WiNE82Qi3B+hh+/UgTNwPc59hEdtZvRexmtSqkQOwVK
	wk6VUN4Xvl5LotKExb8L0jsu3ZYys5Ul8mTWxe0Oaysu2SU4kbCI0
X-Google-Smtp-Source: AGHT+IEcgF3fIovho1cf009IR3WFantb6YwS9xjv1nVNsH2RPT6ipAn5QHz5AcPyOGe9DVQFNc2EK798vO0gxjk8Flo=
X-Received: by 2002:a05:600c:3b02:b0:421:6c54:3a8 with SMTP id
 5b1f17b1804b1-42649a5cb24mr1491055e9.7.1720102445000; Thu, 04 Jul 2024
 07:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023082746-antelope-drop-down-5562@gregkh> <20240704135057.1174408-1-dvyukov@google.com>
 <2024070416-hatbox-playlist-9886@gregkh> <CACT4Y+arKNML2gLvmXzqdfyJY5ydj0yjfk-NbrZpOLgTOTNH6A@mail.gmail.com>
 <2024070430-smell-cornhusk-1d6c@gregkh>
In-Reply-To: <2024070430-smell-cornhusk-1d6c@gregkh>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 16:13:52 +0200
Message-ID: <CACT4Y+az44BGCQ_DjOoCjfcQHEt6YEPi=pksFCRj=-zMrPwSQQ@mail.gmail.com>
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
To: Greg KH <gregkh@linuxfoundation.org>
Cc: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com, 
	Linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	luisbg@kernel.org, salah.triki@gmail.com, 
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 16:11, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Jul 04, 2024 at 03:50:57PM +0200, Dmitry Vyukov wrote:
> > > > Hi,
> > > >
> > > > What's the kernel policy for such cases?
> > >
> > > What "case"?
> > >
> > > There is no context here at all, and I can't find any patch on lore at
> > > all.
> > >
> > > Please always properly quote stuff...
> >
> > It's not easy with kernel lists. I used the lore suggested reply-to
> > command. Here is full thread:
> > https://lore.kernel.org/all/20240704135057.1174408-1-dvyukov@google.com/
>
> I see no patch on lore on this thread :(

Oh, it wasn't properly threaded, sorry.
Here is the patch:
https://lore.kernel.org/all/20230801155823.206985-1-ghandatmanas@gmail.com/

