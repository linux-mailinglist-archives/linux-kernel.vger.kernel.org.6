Return-Path: <linux-kernel+bounces-279991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5D94C442
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F40B2343C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D5147C86;
	Thu,  8 Aug 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFK4KLYi"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E840C03
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141500; cv=none; b=OzVXqpgMVjyp1lZaG5c/O5bfE9olVWZ12kQUY6fRwYiZ+oK+OSfUBITrm+uhHC+e6ulIQ2BftRqETR2NzIgLf7Mu1OTS3z2UwfNb/TtDhFvEJqM5ciBDbyk1Q3c7mTY7qcstxOLTP3T8mg8Wq5MHhvndNwJRwWGTSm2xf/UI7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141500; c=relaxed/simple;
	bh=CqXywmQtV1N/Hz6fBNfPJEA+rMKkxiQ4KUlR5qV+pc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIUDeqSImmCrbVXY1IcQVTxWLhgLRXPEKfM38UBJWiOdJMKZZh4Xhj43bxg6GxHwHt8461A3VGh+75PTia2xmnI9zfQ0YJGZMY6OdSPuVOdQz3S+YfRd7c93TuNpBZ850Eu3mn6Dz29UnV7+VXHcwVkYuyjA3iCJ7WvIaOWHMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFK4KLYi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so1007898a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723141498; x=1723746298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYHmBjjMlRglO+Hjj1X93mReAQTN6gcsN/TxTaZZTyk=;
        b=cFK4KLYiYytk7w0sf4kr71sd8E5Hcdefajssq0Imcy3ClwauSW8lBinjXXE0nl1mLb
         63nhCJAypvM2abmPwcAW0bs+F4oDaOlLCT+9uLtiscoPCeLTVpUREW1DGIWFrHKhO7qn
         lt6KuS1qWD6h/cMhrDNZy4mbYDJsbIxHQNF/W8qYBBGsXGPM4bYE/7zvCV8hIDhCMfvI
         rOqYmbtLIJ2ifF2mG0ySxEvWdeRSgRTM4LkSL19j5Gm+qXJgMRLlkcegWgBD/hMYM8A7
         7OOO+chuQkVorFmCSYfT8Zhtq9V7g4fOpfydicmPnXkbansRGGgITFGZWkxuFdijS1qX
         GQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141498; x=1723746298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYHmBjjMlRglO+Hjj1X93mReAQTN6gcsN/TxTaZZTyk=;
        b=uHamHzoUdH6AlRgI3VlH6rtDTW1gae7ax0/PKF9G/8GE87Ze4nBtKzNMEW2EKyT/xI
         9hGlQGCcZizFJfFSHvrx0SU4A/9f+6/WfgqYQQELKrVmr4ngSfpAu3GVoFjRyoWpuVi0
         NYz1y/VriJ4Ao14bjXvhWoM7HQXd/8AYUZq2IqOSpC0KdZebXM/3IeAIUQ5oyCSHK74F
         smVoFqJ32Lq/ynl8figq6II2FLwF9/VVRxGLunRlTg+b6qaQZQEuDiQ+X+oSg5HmzvEe
         Z88AcTyTV18rGkWQAdziC/TYK9hR47i1W/Rddn5bDs4BhULPJU2owX9pb9XM7/mLSsDg
         EUBA==
X-Gm-Message-State: AOJu0Yx46cnXh668Pr2TWoxIOUoqu58iq1QEV6zpHNqHgtOL9wckf6zY
	I4DIlIf0pFhXPVpvYmL3qkC5m6H+xmmhClKG6pwaqPO13+YGN/Au
X-Google-Smtp-Source: AGHT+IHF8J3vzjGpj/k2yeS7ePCTuEEImfesHdNNDSWq49l2vY2ipOdysrWSsAGiFRUuX5UVzUm6PQ==
X-Received: by 2002:a17:902:e747:b0:1fa:fbe1:284e with SMTP id d9443c01a7336-20095119a8emr35305665ad.0.1723141497736;
        Thu, 08 Aug 2024 11:24:57 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176cb1sm127750905ad.187.2024.08.08.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:24:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Aug 2024 08:24:55 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND sched_ext/for-6.12] sched_ext: Don't use double
 locking to migrate tasks across CPUs
Message-ID: <ZrUNdy-oQFd3TgJj@slm.duckdns.org>
References: <ZrP_zUjrTcrfdHDe@slm.duckdns.org>
 <ZrQAB_d1WSqgYQmB@slm.duckdns.org>
 <20240808181927.GE6223@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808181927.GE6223@maniforge>

Hello,

On Thu, Aug 08, 2024 at 01:19:27PM -0500, David Vernet wrote:
...
> > +	deactivate_task(src_rq, p, 0);
> > +	set_task_cpu(p, cpu_of(dst_rq));
> > +	p->scx.sticky_cpu = cpu_of(dst_rq);
> > +
> > +	raw_spin_rq_unlock(src_rq);
> > +	raw_spin_rq_lock(dst_rq);
> >  
> >  	/*
> >  	 * We want to pass scx-specific enq_flags but activate_task() will
> >  	 * truncate the upper 32 bit. As we own @rq, we can pass them through
> >  	 * @rq->scx.extra_enq_flags instead.
> >  	 */
> > -	WARN_ON_ONCE(rq->scx.extra_enq_flags);
> > -	rq->scx.extra_enq_flags = enq_flags;
> > -	activate_task(rq, p, 0);
> > -	rq->scx.extra_enq_flags = 0;
> > +	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
> 
> Hmmm, what's to stop someone from issuing a call to
> set_cpus_allowed_ptr() after we drop the src_rq lock above?  Before we
> held any relevant rq lock so everything should have been protected, but
> I'm not following how we prevent racing with the cpus_allowed logic in
> core.c here.

deactivate_task(src_rq, p, 0) sets p->on_rq to TASK_ON_RQ_MIGRATING and
task_rq_lock() can't lock p until it's cleared, so set_cpus_allowed_ptr()
is blocked till the migration is complete.

Thanks.

-- 
tejun

