Return-Path: <linux-kernel+bounces-351808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54916991650
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF821C22075
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6B149011;
	Sat,  5 Oct 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYj186DC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875613C8F6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728126918; cv=none; b=mOa/gFsIC6wBq7xmCxX8J04MLR5dZxYhWF8SD/wsFK90B3g2OSzb+7Dgj0zF/x8kU/sOKRsCXQ+idQR9brbd8CtGCgpze+PINskH8qsJki1tQQ9Gd3v2Zv832DoNemClvqDpI79wLVrHOFH560XPlje6tAjZbih0jnAK9n+fOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728126918; c=relaxed/simple;
	bh=R67R2d2dzcANUD4NIwMYRt0vLu7FivewYaCzENFylsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5VoQBwb4y/pQOsoSNPOARVFHX2Km5XQg8Xi+joqIA54iu/Y5ixv485g6FJg5SeoGH5XyAaVUP0Vh3btuzQoaFNy79XQCN0h2PT/T49xzu7JSRxUx9Q9fgIqhbTumaA+b9CYdcT4VHJcSkINmHkzPh4ByOLvM0Bnn/5pXa94NHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYj186DC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A808DC4CEC2;
	Sat,  5 Oct 2024 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728126918;
	bh=R67R2d2dzcANUD4NIwMYRt0vLu7FivewYaCzENFylsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYj186DCcIc+9AHiftw/6igxep4cBPXGk//KXXVQvTVh/v9A0QQe9K/hrmVoqRIs7
	 eHH+UByhLcbTCCsVY7mww/IDxQIrBjiQnma+cLBZk5DlfzODbnBpeWHgSEjlVvlqwd
	 UUjBGa4or379rn7kqOV+Yeh48X+GfoWXJSArc3yRkvkENXwrBPUnDXqKCY2gaW5Ifu
	 plqrRsQVuMir5gikCmEJ6hR4d8KjQmoY+g4XsCq91anZRIuCYaGWBdbkhUAbL0Fp/v
	 nOJDdN8EKFtNYr4XJ9iHlj7Udrn3vw47ck8kILg/82p3mpKq+ae6BtTpqytephSp+r
	 HIlNwInurBeCQ==
Date: Sat, 5 Oct 2024 13:15:15 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Leonardo Bras Soares Passos <leobras@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <ZwEfw3og4WuzXI7l@pavilion.home>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <Zv_hk59xfNvzlw3B@localhost.localdomain>
 <CAJ6HWG7UHmWp6gsci4o_=EMmdfB9T+_jSkhkSxxqKi1upwAQ1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ6HWG7UHmWp6gsci4o_=EMmdfB9T+_jSkhkSxxqKi1upwAQ1Q@mail.gmail.com>

Le Fri, Oct 04, 2024 at 07:43:34PM -0300, Leonardo Bras Soares Passos a écrit :
> Well, back when it was merged, I could see add_timer() using an
> isolated CPU, and that's why I sent this change.
> Did this change recently?

That was (and still is) not supposed to happen because get_nohz_timer_target()
forbids that. Since then we have merged tmigr that also takes care of it.

So something looks broken...unless you had kernel.timer_migration=0 ?

> 
> Also, previously add_timer() was only called if (cpu ==
> WORK_CPU_UNBOUND), and now we make sure that for any value of 'cpu'
> the timer to be put in a housekeeping cpu.

I suppose it makes the situation slightly less worse when a work is bound
to an isolated CPU. You get the workqueue without the timer. But the context
switch/workqueue is the most unwanted part :-)

Thanks.

> 
> Thanks!
> Leo
> 
> > Thanks.
> >
> > >               add_timer_on(timer, cpu);
> > > -     else
> > > -             add_timer(timer);
> > > +     } else {
> > > +             if (likely(cpu == WORK_CPU_UNBOUND))
> > > +                     add_timer(timer);
> > > +             else
> > > +                     add_timer_on(timer, cpu);
> > > +     }
> >
> > >  }
> > >
> > >  /**
> > > --
> > > 2.43.0
> > >
> > >
> >
> 

