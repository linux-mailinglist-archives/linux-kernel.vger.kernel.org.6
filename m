Return-Path: <linux-kernel+bounces-423646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5CB9DAAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D00B20C89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93071FF7C6;
	Wed, 27 Nov 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP1iV/fl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAE328B6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721748; cv=none; b=k+A7pdvnF4IRvWstSSQAnTSXCoVZPvYrG0POp54jzyEvUthcQQIfSsCN3lo/tYHaj4Ezszx5T6TtjzaQkJzp4/9848ghQl5qLWjo9pU/RMEDzItXyALc0PoDV0Gvg8S6ImfQOhPUR2ruv8BmAcjd+zFr89i+ZVZimrgUXNn/t64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721748; c=relaxed/simple;
	bh=pQnsWmZyA8zvaG4xGdU2wRkt766c8givsf+3Ucu7Axw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs/lhUDLL0vI7kPxcXBiUElBZmb68E7HegqbNWk/suD6eLQWPVdL7B9Z7ouLdxZQkaDjQgM+TrMbTXe8HRKXdSExVJVFGHaIMAfuYxOzgmi+KQSC3iVd/oUpVYXqO0jR5lI9QX+0rKvUYZM41ZxYPtkuRKfE/HR5GNO2PCwhIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP1iV/fl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732721745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dloUjz4L6v5UVNmAn/jl0vDj93Z/MEiemp0Ig6UkQuo=;
	b=bP1iV/flyk1tMkY3HtV1teRdmhcDa/vzM9RvzITkhkCufKdI8H4CjnuvXq9ql8VoVeIpBi
	2jhBMw2DW6eoWMVXFTF9kPYa9eC02OWJqN6F9QwybqD+v5fOF3k+zpKs6iNBhlVjKiVQ4O
	lUB6ciV+gr8sXjTk25TCgV4ONqf0aJY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Cd-Yi-srPZeA70J6h1GglQ-1; Wed, 27 Nov 2024 10:35:43 -0500
X-MC-Unique: Cd-Yi-srPZeA70J6h1GglQ-1
X-Mimecast-MFC-AGG-ID: Cd-Yi-srPZeA70J6h1GglQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38243a4ba7cso3661794f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721742; x=1733326542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dloUjz4L6v5UVNmAn/jl0vDj93Z/MEiemp0Ig6UkQuo=;
        b=uyfGdTJU8J1HOTSJRdaAEV7JZRxQgztVDgk3JiESRt2OKK8zABd65bGVT8KjB1H4Qi
         1/AwqeCd86YA02r+XKTqVbROvTRQW8iDZebHYon5Yd2p6g8pCk31GlLUKRJyYeZJGbBG
         Ijg6AUJFT2aXADY7TTpxcjLEvVLTUsRfyORLaeizYyPkLvPRXLElsEpWp7Cs7gEcXASx
         PNskTgje8LnGRkHrwYvFB9y64XrMlxPBLkvgS++Fc0v8ro4PgXLXXb3tPX/rkYMhskzQ
         ugXM0cVbIZG+i+Av3dHC1wrbeYlbNMaY88mxUCRAlFd4Gv2/wLL4gyXjK4GTkRBaB5ch
         Id/w==
X-Forwarded-Encrypted: i=1; AJvYcCXb5/xoRPLKs7a+ZOROrZsrJwfawpy2cbxrzzjlOXssf10f09qt+9yzGek6p6cfKJATC+MFZDSR0yNhFmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxbqN1F7Rjdn7Z2FNNp10FqYkdJu4afrAA3G/qBjaZefta/XN
	rhhD7ErT6bPb6Ox+/cZQfkWz/X3d/P3KOg6oz25IgyLkzFLc0btl9cWnd/2FJfk1IQ/jiFtevS3
	RWEHA4i1k1Ur7HDQsBgsE9OKOWe6VLjCTcurvhzYzZJxan09thWUb/zYJYEQmzA==
X-Gm-Gg: ASbGncsl9CXqhF9C7xaHZg+bSico9yd5QRQWP6uL0Lj7KVwT7sXZhiCucfUPQg7t2SY
	hNlbJYPAzQlRr5ryIPkga8b+k7tXkXi1UHNwmAOH1AAizizoyOGNmXl41yaK+fCJgNPJbPxM5F1
	SGmZdSsaOHAPN4Lsx0H52uQKE9iV7yh5CF/Bzq3l1BYZ7fJvzOrWmF2iykCuzWvR+QwZOcE0ayh
	3cLkXbpo29R6easeuQR0kGKy1muMaSCxTCyVVkJlghuLSvXRYuyHkS7fPPEFDiza+JEqqPKqtnd
	D4Q=
X-Received: by 2002:a5d:64a7:0:b0:382:3285:3ed with SMTP id ffacd0b85a97d-385c6edd9d6mr3196965f8f.38.1732721742566;
        Wed, 27 Nov 2024 07:35:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAaUdkieNJs5FqTGXPAWP9F1kjDlRDmveXH0k/cQVLAcZMYHEDI+thR83XWLvTocpjNH989A==
X-Received: by 2002:a5d:64a7:0:b0:382:3285:3ed with SMTP id ffacd0b85a97d-385c6edd9d6mr3196938f8f.38.1732721742161;
        Wed, 27 Nov 2024 07:35:42 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbf2b29sm16604617f8f.107.2024.11.27.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:35:41 -0800 (PST)
Date: Wed, 27 Nov 2024 16:35:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V7 9/9] sched/rt: Remove default bandwidth control
Message-ID: <Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1716811043.git.bristot@kernel.org>
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
 <d3bllrfwji74t3ix3jcdlvdt6jdorw75wjol6kmadpeuuqal2t@io7ghgf7zkbs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3bllrfwji74t3ix3jcdlvdt6jdorw75wjol6kmadpeuuqal2t@io7ghgf7zkbs>

Hi Michal,

On 27/11/24 11:55, Michal Koutný wrote:
> Hello.
> 
> (I'm replying now as I installed v6.12 and this message has the
> context.)
> 
> On Mon, May 27, 2024 at 02:06:55PM GMT, Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 0dbb42cf7fe6..7df8179bfa08 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1554,6 +1554,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
> >  	if (dl_se == &rq->fair_server)
> >  		return;
> >  
> > +#ifdef CONFIG_RT_GROUP_SCHED
> >  	/*
> >  	 * Because -- for now -- we share the rt bandwidth, we need to
> >  	 * account our runtime there too, otherwise actual rt tasks
> > @@ -1578,6 +1579,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
> >  			rt_rq->rt_time += delta_exec;
> >  		raw_spin_unlock(&rt_rq->rt_runtime_lock);
> >  	}
> > +#endif
> >  }
> >  
> >  /*
> > @@ -1632,8 +1634,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
> >  	 * this before getting generic.
> >  	 */
> >  	if (!dl_server(dl_se)) {
> > -		/* Disabled */
> > -		u64 runtime = 0;
> > +		u64 runtime =  50 * NSEC_PER_MSEC;
> >  		u64 period = 1000 * NSEC_PER_MSEC;
> >  
> >  		dl_server_apply_params(dl_se, runtime, period, 1);
> 
> The global_rt_runtime() also applies to deadline class when CPU's DL
> bandwidth is init'd in init_dl_rq_bw_ratio().
> 
> The default DL bandwidth is thus is 95%. The fair server is given 5%.
> Is that 5% of those 95%?

Yes, it is indeed.

Best,
Juri


