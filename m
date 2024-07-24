Return-Path: <linux-kernel+bounces-261155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DBC93B35A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0481B1F21BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFCD15B0F9;
	Wed, 24 Jul 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gdyCdoTj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13082158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833711; cv=none; b=Mj8pYmL1pfRrhlv6j4JYysqTvdeF+vL2JW1RhyK3lfBk5+gvEFIzkDHudgilFQYsyP0WgFA1f1tYCPEY+Du9yzhzj3sbVjhcXcz8/iQV/JH0ZAda8F8+SWwc+gB5rPW+a85+gRa4R8pJdxEIEHzeR4tBKMl/T2pYvDVou6/HxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833711; c=relaxed/simple;
	bh=DQ06Jsqc6k1DxZujaQRgZ0e8MM8hCxmEALi/kUl+B28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avNT+Ygd/uSEa6QAsLrnUQm1jzIeooeuqsvBGQKz1Sn3m52vo50zUobfu5Svj6WyfOGJx0lJWqKvVagjqJjaUmbe2qrLeOKkJcLcGCfZzNq9JYMH/wqWf7fkRYhjFMge6ma7SWaNEK3R6cfOrLFOOZQRNWdI/6ZeyqaRRXRYVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gdyCdoTj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so199625866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721833707; x=1722438507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFfLXV9ZSdK5QAzxIQxbI8xyzVJ7K95wQYEABFDXtbE=;
        b=gdyCdoTj8MM11qfVmuwE56OGr9vnIvJRMNb69l9tZXTuziuIGIG4fETiK5aY99HwfK
         mu/FKtz7UWp9fBIKDfFH1p0RqMdcLyMtmSDuMUnG9GLf+5VfHEPqiQkfCvMshy/0SDgN
         xEqaM9yQAKof3AYDYuUhbkHAIDh/N8mQkmiXFhegZJ1v+8zmFc8gHGEqt8c6+66YiddF
         9DrfltyR+g5ZOlk3ru0PkvzJg85bWun684KIHelSfQRntUgItqSUrn6iuB4Q5C6KAVjF
         vsONjvsYFiO/Yz4Y69q+vGNaNRz/cOb+8hcdfgvMrfFzbEudRzFfa+iSxXqvqoU5F+ia
         kmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721833707; x=1722438507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFfLXV9ZSdK5QAzxIQxbI8xyzVJ7K95wQYEABFDXtbE=;
        b=KrJvSLSTbF/0G7uM+2yn+tawe+uk6icqeVzMSs+WNLP3VFL052olXmFT15rPCkdpkk
         hqb34loVv73vAaBv7SUBXeKNmRejkXZqDI0qvBXVVSuSaHEsO0SOk9U44e7IwGQfJinh
         usP7cUzsIrHkLGKqubeeUJKLqmxbsmlsdOXA0X+owK1GNpjQMO7dUxkRG1WAYUcY9BZb
         iVxQnLWvEJ/HNGXmDPjm/0oow1FSR9RJtwUo0CA5x8DXT5bKTHCCyPolOSM6tcGOtKE2
         +qpbr3ShGEpmpioZZGo3rhd5jWaifoqOOga+j6ThLfZolY3HK9jgh+GEFcTNe54fHFus
         GPSg==
X-Forwarded-Encrypted: i=1; AJvYcCX40CyyVgq1gFiaY9aUaKIosCz9IKCM0DsHs0GKQVKXeIRHmKk4OE3kfK+JosmvdmErE8qmp05b0X8DtcAiTFPbzSOV/S823lpoEMg8
X-Gm-Message-State: AOJu0YxdodUCzExykP6c/NxVz8+AqHhpSp74H+McrKebvn87lNtIkLDA
	PG8nkRDkk2mvRsdPYSxG/bAQ2kXBpLSfqCRcvtgkmgEXH/ahJ3R/AXPcHwdtuog=
X-Google-Smtp-Source: AGHT+IEPELQLmiv7iLL1UVdkJIKtNLzaHTvw/KDltE18AJTKrFBu1NISk7Zt1wF6lMd1CTQyck5HGw==
X-Received: by 2002:a17:907:9704:b0:a7a:8522:5eec with SMTP id a640c23a62f3a-a7ab10ba1bcmr189946366b.53.1721833707352;
        Wed, 24 Jul 2024 08:08:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c951169sm650411766b.213.2024.07.24.08.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:08:27 -0700 (PDT)
Date: Wed, 24 Jul 2024 17:08:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kernel-team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
Message-ID: <ZqEY6ZIB7XThgKW3@pathway.suse.cz>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
 <87plrcqyii.fsf@jogness.linutronix.de>
 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
 <87r0brkvqd.fsf@jogness.linutronix.de>
 <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
 <877cdilrko.fsf@jogness.linutronix.de>
 <ZqD54dcZUAirxTYg@pathway.suse.cz>
 <871q3ix2zp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q3ix2zp.fsf@jogness.linutronix.de>

On Wed 2024-07-24 16:51:46, John Ogness wrote:
> On 2024-07-24, Petr Mladek <pmladek@suse.com> wrote:
> > My quess is that it looked like:
> >
> > CPU A				CPU B
> >
> > 				printk()
> > 				  console_try_lock_spinning()
> > 				  console_unlock()
> > 				    console_emit_next_record()
> > 				      console_lock_spinning_enable();
> > 					con->write()
> > 					  spin_lock(port->lock);
> >
> > printk_cpu_sync_get()
> >   printk()
> >     console_try_lock_spinning()
> >       # spinning and wating for CPU B
> >
> > 				NMI:
> >
> > 				  printk_cpu_sync_get()
> > 				    # waiting for CPU A
> >
> > => DEADLOCK
> >
> >
> > The deadlock is caused under/by printk_cpu_sync_get() but only because
> > console_try_lock_spinning() is blocked. It is not a true "try_lock"
> > operation which should never get blocked.
> >
> > => The above patch should solve the problem as well. It will cause
> >    that console_try_lock_spinning() would fail immediately on CPU A.
> >
> > Note that port->lock can't cause any deadlock in this scenario.
> > console_try_lock_spinning() will always fail on CPU A until
> > the NMI gets handled on CPU B.
> >
> > By other words, printk_cpu_sync_get() will behave as a tail lock
> > on CPU A because of the failing trylock.
> 
> But only in _this_ scenario. The port lock could be taken by CPU B for
> non-console-printing reasons. Then you still have deadlock, due to
> spinning on the port lock.

I see. I agree that deferring printk on that CPU [0] is the right solution.

> [0] https://lore.kernel.org/lkml/87plrcqyii.fsf@jogness.linutronix.de

Best Regards,
Petr

