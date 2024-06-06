Return-Path: <linux-kernel+bounces-203894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80068FE1B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769FE1F2386F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C213F42E;
	Thu,  6 Jun 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zznoi+ZN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595913E8B6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664041; cv=none; b=MzQO/k18v6c8cpNk2xxqtvczSmc9AZobu80SMEgEyEPLjA14aQrspSnhtjxIv3P/oHHLZCDq1AFI2a7tNuBQdmLiMefs2cC9KPTiay4kaxLXUnLBY+O0F+6LiDH1oED9fK/gFIk9YJtrLB+/Btgjg3g0T0snEAnN3Z1EnRjwzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664041; c=relaxed/simple;
	bh=C+s8Cf+xn4NSLnGuVo6MezQKUoye6EY3hIobHSOxoyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6DkuuDTpsQL9SLPSIHoQ9K7RF13T+fkPKjR8lDhS5bHB/kdazU0es7nT4ui64O4V9eYEEEM0peexKq1TZMMCBn8JlJERMxfeZyDBLlS8NrlLAJbsVo+EXNJX0+IEPWlE5W0XVpxTkALgXGFdBCivQMW3/BrFPoIAXdgxT9z7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zznoi+ZN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42155143cb0so9935785e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717664038; x=1718268838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhG8EPeH9MSySabYFfPbTg9X9y+fL2rjWWg8DWpXBx4=;
        b=Zznoi+ZNHsp4w8plkdmq8j5w/zCvfKWl98dtmFjbS209Y7WLXAWwnIv8rt2BQWJx4e
         KzF+CsSULxM4pKPmmr031MLQpPonwCSkgnWYHfw49fmHhrV2Jy6/MlgFOnYlUhWFn709
         qFm47LFwI1VBH448QQbl5CqxEysxsQCqvvFR5hR6m/lR4X6LmTPna4wbhVBZ6FP1Gsch
         ceXdSyyh/4gqIDm4R9gHrEzEYWHs7Ci8+RvYAL13INYXxp898+UeIVAYBczegNLOqVQt
         axod4IBmRA1A9tBIiLlXjJL0mvzeW+DNImKhOo/9buukLAcqfvCoPZBM9Laml1w/vr8w
         cuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664038; x=1718268838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhG8EPeH9MSySabYFfPbTg9X9y+fL2rjWWg8DWpXBx4=;
        b=t2L30HWOeftcQ0Hv1jiosG4wkdjRhFTmT/t62WQHg1xc0T/MfA3zb6lIOvEKHFsxqt
         MW6kvlcW/7kj/Uu/R6bbOaB2Tp21yZIU/E1+zQx90rVBMQWQApQ2wvzLCsC2h2HGyakr
         Xi6nOW77afoW84ytabmT2UwE0wCo1J4qJ5nDAdvt85XMDcT8NF6cdzKnqyHxCSn1mXtW
         n2hwYaKsylpVfnozzsauiw9172/RAwcy1MwYJK6w8YJBZOnCfk32lJAb5MfKh0FbycRB
         iMrcxJIUmZ7KSFpw9NFCZqffer+p7pfpc6jKYRuXPAin5XFrcZyuOigHCB+owvJerU7C
         Wwlw==
X-Gm-Message-State: AOJu0YxzZa6ZAthbj+ghbHlHcjYijIZOgXW0tn+E2e6pUvfCeX+j4yQ2
	Uo39aISNHOST1SeMiVYvK1yZmbTZaKLG4nQgR/BswVAAfrs3DUL/
X-Google-Smtp-Source: AGHT+IHLiHFnxNhYyRHS5x47Zv9iLorrjVjFlK9xjsUyywIatfwwURBJXom75ZjGj7hYYNZ+eBEvEw==
X-Received: by 2002:a05:600c:3d95:b0:41b:f116:8868 with SMTP id 5b1f17b1804b1-421562cd313mr45737105e9.12.1717664037232;
        Thu, 06 Jun 2024 01:53:57 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e96c34sm974746f8f.82.2024.06.06.01.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:53:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Jun 2024 10:53:54 +0200
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
Message-ID: <ZmF5IhYp5JiiMHgv@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-3-mingo@kernel.org>
 <20240605133805.GB25006@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605133805.GB25006@redhat.com>


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 06/05, Ingo Molnar wrote:
> >
> > @@ -591,13 +591,11 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
> >  	 * This is safe because task_struct size is a multiple of cacheline size.
> >  	 */
> >  	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> > -	struct fpu *src_fpu = current->thread.fpu;
> > +	struct fpu *src_fpu = x86_task_fpu(current);
> 
> I think this patch can also change
> 
> 	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> 
> above to use x86_task_fpu(dst).

Yeah, so I'd prefer to keep it open coded, because of the comment and the 
debug check makes a lot more sense if the pointer calculation is visible:

        /*
         * We allocate the new FPU structure right after the end of the task struct.
         * task allocation size already took this into account.
         *
         * This is safe because task_struct size is a multiple of cacheline size.
         */
        struct fpu *dst_fpu = (void *)dst + sizeof(*dst);

        BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);

But yes, you are right, this is technically an open-coded x86_task_fpu().

Thanks,

	Ingo

