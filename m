Return-Path: <linux-kernel+bounces-206922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAF900FF9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10B71F22A2D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D94176ACB;
	Sat,  8 Jun 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzdvK6E8"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54530433AD
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831603; cv=none; b=QNiywXb0Ab97jIMJDntXjN1SzyYW1a8mFWWSKiDQPB7pKn2qFkarCLKxpUJ5TF9o1maOBH5/BUbYURUi0Z766mAFMphqlBX7u1gM42ln64GJaRnV4DdJtCJacwl4Db0hN5LT2+E+Bz/dyKRsJRGFYl0XHy1fXz/+IhOACtwfmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831603; c=relaxed/simple;
	bh=Oj4lS1B4upVgat/8NPIU2m9kS6m/FhPnfRYzR4Ki0yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkKciUm5r4vhpP7ezC7SIjIBd9z5DIE/YjAT0uSVVKfSDSJtAnR3eCob5P33Qre/Ac06BTljtVrgL2c25Wqq+WWqOmo6/dp116u+ETefmVfgWNJLdqV/bOuQK7siYFL+pWOQ+iZhtMNG+gapT/dwRJJ1paowsLcKap1HVmpWDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzdvK6E8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c82101407so126150e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831599; x=1718436399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni5fFFnVcG2iwTXfOd+vGNAwxVMpjNHfjKy+OgAL7Qk=;
        b=JzdvK6E8JxI7a6+P8CdjuT1G7co4gwFaeK7754cCipecaSsp93MQM9xFjyDlimjxlz
         INR2xK+7Qu6mneyvMlrv4OhF0T5XOPsTaO0ESmkQDygs/Uc4lgV2ofrrs0t6dwM24rG1
         W1329YNFWE2naNa+4UHqUhzwgKGAULp1Is8lc5p+NEF9e1I/6yjTOdTxmEMKZLuZNmFr
         9YRC9rqUMxY6gloRFnIXhTT2bLRCscH2WpYBmQE5TlSneBNooZ12GMij3eB4UYEUqVPI
         UHnBJGz6Rac7UCgEZBiGJpQrraR4K8rrFl6J4EjNX3zYhNHqo/nn48R3mhPPDB94KKxD
         A6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831599; x=1718436399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ni5fFFnVcG2iwTXfOd+vGNAwxVMpjNHfjKy+OgAL7Qk=;
        b=MCXGpay+SfLlMG2b4E/mtob3UyYO8+bIQ4UOarPjl2br9DjJvgBJ+BB3sZyM2oNK1H
         gjK+DfVB9gaZ2TrKTIjZ9vThWMRyYJnzC36heKC6z6LL0yF+vuQ/xK3dx4phZKZzyRM6
         G1e167rUpC57Dc/y7XYNcUaqZPaeA8rxBh9kpkULEJT+yTTgyZ4FQ9tRQu72E1riRwB8
         8P+8W083kA8LPFaewNy6mkRjOb5A79rysdeR3gsy1nXeMQNViB2SdlS7niywRfwaibQy
         sshx3Cvsg0hks+8rCySlIkNd1a3TjBWXAnhw2B/0y6qohftx3wOrcKZOQL2iCmSJlvQi
         YVfg==
X-Gm-Message-State: AOJu0YxlKAXNukmH39R2rPhQlyPnGEG0TkA20qHe+y0FwDoYMEptTE+j
	9oWM8O9XXAWwpxfHK4elILzknoG6cdlwHcY8NCZBYjDC8gTdG2yw
X-Google-Smtp-Source: AGHT+IFZ+gEWTl0RZmUZnqBi+qAfNr1eqgu2OebdrNpSYFXlQch9tbUkHxwpzYgm+AqYgdy5hPyItQ==
X-Received: by 2002:ac2:4102:0:b0:52b:79d6:7c08 with SMTP id 2adb3069b0e04-52bb9f78667mr3324764e87.18.1717831599191;
        Sat, 08 Jun 2024 00:26:39 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6e2e1d4cb8sm174605166b.5.2024.06.08.00.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:26:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 8 Jun 2024 09:26:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 2/3] x86/fpu: Remove the thread::fpu pointer
Message-ID: <ZmQHrHqQUVTRtjSz@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-3-mingo@kernel.org>
 <20240605133805.GB25006@redhat.com>
 <ZmF5IhYp5JiiMHgv@gmail.com>
 <ZmQAZ-REghlJmax-@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmQAZ-REghlJmax-@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Oleg Nesterov <oleg@redhat.com> wrote:
> > 
> > > On 06/05, Ingo Molnar wrote:
> > > >
> > > > @@ -591,13 +591,11 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
> > > >  	 * This is safe because task_struct size is a multiple of cacheline size.
> > > >  	 */
> > > >  	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> > > > -	struct fpu *src_fpu = current->thread.fpu;
> > > > +	struct fpu *src_fpu = x86_task_fpu(current);
> > > 
> > > I think this patch can also change
> > > 
> > > 	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> > > 
> > > above to use x86_task_fpu(dst).
> > 
> > Yeah, so I'd prefer to keep it open coded, because of the comment and the 
> > debug check makes a lot more sense if the pointer calculation is visible:
> 
> On a second thought I changed it to your suggested variant:
> 
>         struct fpu *src_fpu = x86_task_fpu(current);
>         struct fpu *dst_fpu = x86_task_fpu(dst);
> 
> because you are right, it's in fact easier to read this way.

On a third thought, while more readable, this doesn't work in practice with 
the current scheme, because x86_task_fpu() gets called on kthreads in 
fpu_clone(), which trips up the new debugging code.

We could resolve it by special-casing PF_KTHREAD here too, but that weakens 
the whole readability argument. I'll leave it as-is for now.

Thanks,

	Ingo

