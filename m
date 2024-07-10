Return-Path: <linux-kernel+bounces-247078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB63092CAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C8B21A13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E75EE8D;
	Wed, 10 Jul 2024 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVpwoxc5"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DB17BDA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592482; cv=none; b=Ft7ZHraAHXbTeYuEbqAx4VZOymEx45vHqXqx43nsNR/TeAKJ8hzuIcqKh2JCWLZnFUWG3jBsDoh2zMis/1MM4LHuKCDPD9+l94ysRO3q4HiZyY8y4xdP2wLORMQ7vVcLxOFCXixtCqOMqhvQp8Z6E790YdHxyA7BQ7Zm0VRYgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592482; c=relaxed/simple;
	bh=0ZoqnbEUB5Ap9hkteRABbj1Sg/92x8xwPykf9Y4550o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2mvS9S4BY/oTTp69uNjErE7TQ0l5PEklGt5mHUq64NhoXu2NsD7jGNYkV0Ucx2SDoW5jqIu5wlpOZ8xZoUdQNUhL9EyVqb3MbwG8DmUTMCv063Wg/NQs0klx3KYT8+/rYXEmwEGUFk/7cqppr0l9ehXBt6xdzn12GYNh/TnAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVpwoxc5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-70b2421471aso3144294a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720592480; x=1721197280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDfqB3vBZ3wdNf6zYO9+rUXgJFWsxTnpFjqLnoTLgGw=;
        b=GVpwoxc51jte9bIyzlAg1MRURjpiloY12uRBgPAaNbChicZeJKTVQMOF//h5jbOiEx
         BF1trjd+opYika1MeJnC7LHDkjayIHU+2BpTg95NTMIOOPkdg9hmII/ZI9ssjqSZyks3
         AHnbBH5iPKsfN5/6KHOjzL/5oBa55ibpnxU1KpWatvJpnEpkmJjoBYDQK7QUFO6W3OYk
         AHvRBu6YTczBJu3TrSfAWr8ZC0SNKn2JD2SCVGSSbfGr0+r0Z22KcyfUStCLLuUOBNhN
         O8VQZ4P4YwjK0bSvqkZt0QeKweLHJaB83Sq5z/YurJr1nzxW3WVQd39lKPhEyxmKYHnA
         QUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592480; x=1721197280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDfqB3vBZ3wdNf6zYO9+rUXgJFWsxTnpFjqLnoTLgGw=;
        b=m8wsSeQerQx7hjrEa4aTBKxVBfCj7gYhOKKtlpbPc0qrJlJ7pDTEwAJ9CDbaFQopjR
         ypClN2uKVBDBa8jUMiXZJGBHZswkWihbcNcthaJBpKDQXvm04zNeExHa+z4/sVn7dXCd
         7A2vGgq3KqUBR7LHcfnpZzVr/XVWhtsIouqQ5H0J6kUQZtLpKlirE49ePDkKNBpO1ldO
         r1V+diBXX/ccdjyvMGu4XYEJcCx6oqN+mWatrc21xyO7bHgOguEGn2V3ayIM2se14d+o
         RPW1+m4noyY7xQPBOyobdYAE/EAPUi4GCVr+T/o9SKPvK/Kh7Hys9i4xcLOliUoaJFrQ
         rKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtst5i9roeEL1zAh6pzWTp/DMQWhtY4rbqL2bGDIkipetp1zDT/HH1HVPuVUXBhtIL1r6YcGe+RsSeY2haYhE2LFXnBWrsnOJPp6Kl
X-Gm-Message-State: AOJu0Ywro0PoiMtD+1WRhiSw/WwZ7Dhx1czapPeq2uEMHMHGSqH9E+Cl
	NwWSRAAWMOdt/c4TuJSygqlTS1cetdJWjhtZe12STSimaP0LKikgnpWx+6eoiXGN/Jk9i0Xyfoy
	603BqiuLjP5M3mesPRBZ6brdQe68=
X-Google-Smtp-Source: AGHT+IFVSRdYhlRo2fU3wUndUgbALxo8r/fCvmgBgcUou0oGKzMd/WDmckS/0xJOp8csiFwHox1JZYX2RomQzamEB6E=
X-Received: by 2002:a05:6a20:3c8a:b0:1c0:f23b:d35f with SMTP id
 adf61e73a8af0-1c2982148eamr5178939637.13.1720592479926; Tue, 09 Jul 2024
 23:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704065213.13559-1-qiang.zhang1211@gmail.com> <4673661c-b6c0-4188-a98c-83dfdda48a13@paulmck-laptop>
In-Reply-To: <4673661c-b6c0-4188-a98c-83dfdda48a13@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 10 Jul 2024 14:21:08 +0800
Message-ID: <CALm+0cU_B24pHUWcM5_1N7bYPLkii5e5c_K8eTcev3YL7Y7-cQ@mail.gmail.com>
Subject: Re: [PATCH] smp: Fix missed destroy_work_on_stack() calls in smp_call_on_cpu()
To: paulmck@kernel.org
Cc: imran.f.khan@oracle.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, Jul 04, 2024 at 02:52:13PM +0800, Zqiang wrote:
> > For builts with CONFIG_DEBUG_OBJECTS_WORK=y kernels, the sscs.work
> > defined using INIT_WORK_ONSTACK() will be initialized by
> > debug_object_init_on_stack() for debug check in __init_work().
> > This commit therefore invoke destroy_work_on_stack() to free
> > sscs.work debug objects before smp_call_on_cpu() returns.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> I have queued this for testing.  My guess is that it should go to
> mainline some other way, so:
>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

Thanks Paul for testing this change ;) .

>
> > ---
> >  kernel/smp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index cc13e73a887c..61f10f982341 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -1135,6 +1135,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
> >
> >       queue_work_on(cpu, system_wq, &sscs.work);
> >       wait_for_completion(&sscs.done);
> > +     destroy_work_on_stack(&sscs.work);
> >
> >       return sscs.ret;
> >  }
> > --
> > 2.17.1
> >

