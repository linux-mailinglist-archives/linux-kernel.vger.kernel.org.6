Return-Path: <linux-kernel+bounces-561335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F0A61030
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AE71885E34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E401FDA99;
	Fri, 14 Mar 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lX/oGj2u"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DC1F4275
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952420; cv=none; b=nP/H+GWj+V/k3Ch56+WJJ+91YxEokyjSzMqkx+b+H99jCymh3BnCnTYYBHOqDJar4dIJOIZMHZOxQrCB0/2T2uZuJI4K50mCdlJf3HuI/qoVoWCASsUu2GIGOnjxFWjsXGfJeX4GEF9o+I7m5kCATSq844i4okAXFujcKT9VSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952420; c=relaxed/simple;
	bh=DRVaiOOdLPCg0pRGm0PyxO+vwNtHOHOQDrJeS2/jNZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia9n+8fuWfYQTOnUbxiL/UdDZ/DvIUFVOzOAkK1ydIwTpQKQYdNfPS9KLpPeVeBjvi2yEl1eaKt8tBOCyslI5dcuV3jPIg9fAKPRwWPOPZyo99z7tOe/uwG34TaiHIU4RpAIAZlyF55Uw/8veG+uYNOjETi+Rv6xedhELjCU05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lX/oGj2u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224100e9a5cso40523705ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741952418; x=1742557218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhgVskX4nlrC12LCIw5CF9c8Z9MMrd7ArfMvVH5w1oY=;
        b=lX/oGj2u2UXTJSmIc6UqlAy+WmTwHZxByycO+QE1EdIeSNI0M4DbuiB/ffYqr8zTFT
         sOuRBp8iCEMatAqtmj9v8tcLDOtjkzlP0nJvsGf4u4RnqTqlFDm2romMiCbdUEKoQtvu
         4e7WbPk/nSNKlQ1Ei2dOTTkJRSH3B54JVOMukbCaRIyq8OBeCu0yExSaJ6O6wKpwCosA
         uS7FR5yoabPoPC0OsgI37JmA/O/7luVcBJrZH1tr0kGJG+NqhuRovus1k33NvMMdxZod
         Pfx6ibetYIWXFE8SPjDs0xGrR3qJqwUiRlVKmFfVdTwGO92ZYWtuI0+0yp4G+E557LIt
         G7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952418; x=1742557218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhgVskX4nlrC12LCIw5CF9c8Z9MMrd7ArfMvVH5w1oY=;
        b=v29DS0fcgQtCSX340ZpVsuhrIiriV2Mca0N6R0g3D5HzmriAViHXJSnpJSPLMYJ9ao
         0oVGODMPYULtloUyIxnzxpMDXJj54RNxFHkqtMl/47tNME4STWccN9fT5bxwpZpmlobA
         qVs6+ky8tKfMV236lompL8/dpDVEx9zixlD0sJ3NBHlYRK3NOi3j49z6Jalcixr3xnHH
         lRnOzSolxQMRteZ1QUPeeszutv4+n9+sUSQKbKr01YJwXX6FFuFxEscUL6f01rCOjsDV
         YM+DO52kIO4LIjQ9B68ZfTh7QZBP6R30gzodiszgXDVzFAwyGzty2pyQsIpirE7Ch4bP
         V04Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmBIoRH8jX+mKUgpXq+3QLPK3gg08aURtpIwakXOjfxaSyuDPCHyI3jbUcyFJp1NcGEl6VJpC1e9G9H4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3Ap2uHEQPjtL0i+roworb68MxQgNWFb2L5gVXvjA8FXss9Yg
	BTpt48d6TlnKUcp4M4wg8HDdF+8pMUFtfdwLykjfOfG6P/AJdeYAtRqktN809A==
X-Gm-Gg: ASbGncteeyzvpifPazJaINtLpCXkiHl7TzuqjMgR09OL5CNZvA5dynwhJwc1ASzrt7Y
	PvNReDEeb/+QMw/SPtPqyLrcU37S8111CT8U3m/tBGdabZ+n9I7lvz7RhRrWYIfIGkAKw9oWRrt
	JiSDnjhFAJcSqZ4jqfHydFf+X7jqDdrRK/j854kvqtsfvyRABGZn2xXzMYbiRduM/womWDfHkAx
	HhMMY0nFVXuQgnTb/V/eOPJuKnlWuAF4ggcIu8E/an8BylgwGPE22/SSCV7097tlpnn9zm46YBX
	+Vp8eFPucacp7mBmcDo+1Ijs/C5uhAMyAsaJDWPxf16iwfRsAqMEkIE=
X-Google-Smtp-Source: AGHT+IG5pTZxJL5iszLK2BYZByTKRaxMqna2PXfnQHRDhfs8kfSIQZc1vfi5BFaRbbgkCxRfEBvlNQ==
X-Received: by 2002:a05:6a20:2d23:b0:1f5:8072:d7f3 with SMTP id adf61e73a8af0-1f5c12ec5ddmr3779163637.30.1741952417699;
        Fri, 14 Mar 2025 04:40:17 -0700 (PDT)
Received: from bytedance ([115.190.40.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529381sm2735025b3a.33.2025.03.14.04.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:40:17 -0700 (PDT)
Date: Fri, 14 Mar 2025 19:40:11 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH 5/7] sched/fair: Take care of
 group/affinity/sched_class change for throttled task
Message-ID: <20250314114011.GH1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0Gcm92LNtei5yLym-5dK96gb5GF2-tDoLJ+YS0fMx8jADg@mail.gmail.com>
 <360430bb-1fda-40b8-b1bb-971025d4866c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360430bb-1fda-40b8-b1bb-971025d4866c@amd.com>

On Fri, Mar 14, 2025 at 10:21:15AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/13/2025 12:51 PM, Aaron Lu wrote:
> [..snip..]
> 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5876,8 +5876,8 @@ static void throttle_cfs_rq_work(struct
> > callback_head *work)
> > 
> >   	update_rq_clock(rq);
> >   	WARN_ON_ONCE(!list_empty(&p->throttle_node));
> > -	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> >   	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
> > +	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> >   	resched_curr(rq);
> 
> nit. Perhaps this bit can be moved to Patch 2 to consolidate all
> changes in throttle_cfs_rq_work()

No problem.

I placed it here to better illustrate why list_add() has to be done
after dequeue_task_fair().

Thanks,
Aaron

> > 
> >   out_unlock:
> 
> [..snip..]
> 
> -- 
> Thanks and Regards,
> Prateek
> 

