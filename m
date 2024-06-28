Return-Path: <linux-kernel+bounces-233480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B103391B7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A031C2324A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3713E8AF;
	Fri, 28 Jun 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqWRMLf/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B013DDD9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558561; cv=none; b=Bq8JB5bhlPGSDS/L5g1KVeFtSxUI/YmaimZpCBRhuvMEQPjxR4bJjCYo3GGjPCfZ0VjlVYZ02vmiOgcc13JfQgaGBJhSHVlrhb6Vdc/GVbgNIbe21wccmIiGelJ+YRVa2gPYileE94/p8QiSE9ehaDIMlZYIfP0ibDP+t7DDKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558561; c=relaxed/simple;
	bh=jmkqfXaHVKyVHT3TgRBCSqe08GGcFE1IfnnRPRkO9G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzqhr8oVHbbQTR35p99y0rbw4Y6HuXCQ9SRW9SrZsq2ahIwQFTGqj7fQujhFgW3x/m/Cm11RrwUY406uTSzSpjHQlMY16CTNxUriug/QYlNkQ7yUODKH2Z+aA+RIrRdBluQ7YvHqdpgCylu+K5N337NPNP4YgPudA7IOxhPFIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqWRMLf/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so31821766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719558557; x=1720163357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=If0iq5oLy+eiIvzlGQNRLUuZgZ1JLzU6wSKruP4/9Eg=;
        b=gqWRMLf/NX3cGZidAZx8SJUoLNhx0y0kBDeWvBt8VDQAW1FpnA2O0I7Tswihyg8EkP
         ZiEXF++PZFofLLSDMeLl/NpN7NIIOTnGziD6PrMP3RqPOlYx0yPF/OwY0RZB+0uxvyZZ
         mRGZEwOJzugdOX2fLHxmSJ35yxEGrys7SPJce7JmTJhiHlSd9C7KAiafc6zfRHaMAbaC
         Ki84cIOPjiO89LrNy2y9DT1ap+SDI7m47FOsNyQ+OMw9fCot9EI7tbWQDQLuBkTTxdTG
         yFWB8emT3atrbrVtWBMaWRR9Mx4KnmM6eR6psvCJdgaSLV9rtUjitSOhfvAn+Ch54GZT
         W8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558557; x=1720163357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If0iq5oLy+eiIvzlGQNRLUuZgZ1JLzU6wSKruP4/9Eg=;
        b=GxAvdjwXypwbWCzvi6rKlDbjsyjhYr6DDGXRtHfkFHOLydrdzN6pw/ZYMzkFkeQDTK
         Ywj4u7y7gSqgbuHdrJ63lNey9kfnTpKbi4xsgh/hRPdlgnAJh2yJ3Wi3rzE6bhPvyQ3q
         ZNHdU1mo60dML6TrfLYrmjvbPE1ttmchbPxj1CMXMc7rc//iefXUXOhKPOk7sE0zLqqq
         o0g0LkWV168azgbBVIlxapvPbYHTQhpsXmIMkjJbWtTxdfpFnVlkHwfyh33PaSWcBqiT
         FP7TwU2c4uZA1AmSymUNy5NCUOXkBrCHcYKXWXq5kCHJwkhpIWscJxBqK7Fysjcp/W71
         y/kw==
X-Forwarded-Encrypted: i=1; AJvYcCWBhgi3weblyq4zJxnkYeYcGawhHxrH3xbN5/vxd32PsiaXjgr+zR87R/m8BEOmB15nrmLBVTIUw/qK6bdtEnrQ7fAtauXg3nipQJSl
X-Gm-Message-State: AOJu0YyHhAA53SOnngNtnqAGDj9aj35Tw5lalipE5IjWOxjWz7oGsN+i
	6w8rpik4W6h0oCNjPFWuvm5agfD1AbwDsotk8r6GDRhlnnIC4rXdQtXWJVSjbBs=
X-Google-Smtp-Source: AGHT+IHI8uJ1o7wEPXjrRlqBMAxE/hZW7hfP6KthuUiDb9dgFhsbRFiAQwu4+lO0LtbeeWla+b5xVw==
X-Received: by 2002:a17:906:3383:b0:a72:438b:2dfe with SMTP id a640c23a62f3a-a7245cf26e7mr845900966b.40.1719558556886;
        Fri, 28 Jun 2024 00:09:16 -0700 (PDT)
Received: from localhost (109-81-86-16.rct.o2.cz. [109.81.86.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0651dfsm47940966b.142.2024.06.28.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:09:16 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:09:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Message-ID: <Zn5hm4HHYIUVZ3O3@tiehlicka>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>
 <Zn1LFyO_cww9W758@tiehlicka>
 <10b948cd-5fbf-78e7-c3e8-6867661fa50b@huawei.com>
 <Zn1S70yo4VQ24UNT@tiehlicka>
 <ad7cfc60-d6d5-ca16-c93a-d200febccc9b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7cfc60-d6d5-ca16-c93a-d200febccc9b@huawei.com>

On Fri 28-06-24 10:20:23, xiujianfeng wrote:
> 
> 
> On 2024/6/27 19:54, Michal Hocko wrote:
> > On Thu 27-06-24 19:43:06, xiujianfeng wrote:
> >>
> >>
> >> On 2024/6/27 19:20, Michal Hocko wrote:
> >>> On Thu 27-06-24 16:33:00, xiujianfeng wrote:
> >>>>
> >>>>
> >>>> On 2024/6/27 15:13, Michal Hocko wrote:
> >>>>> On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> >>>>>> Both the end of memory_stat_format() and memcg_stat_format() will call
> >>>>>> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> >>>>>> is the only caller of memcg_stat_format(), when memcg is on the default
> >>>>>> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> >>>>>> the reduntant one.
> >>>>>
> >>>>> Shouldn't we rather remove both? Are they giving us anything useful
> >>>>> actually? Would a simpl pr_warn be sufficient? Afterall all we care
> >>>>> about is to learn that we need to grow the buffer size because our stats
> >>>>> do not fit anymore. It is not really important whether that is an OOM or
> >>>>> cgroupfs interface path.
> >>>>
> >>>> I did a test, when I removed both of them and added a lot of prints in
> >>>> memcg_stat_format() to make the seq_buf overflow, and then cat
> >>>> memory.stat in user mode, no OOM occurred, and there were no warning
> >>>> logs in the kernel.
> >>>
> >>> The default buffer size is PAGE_SIZE.
> >>
> >> Hi Michal,
> >>
> >> I'm sorry, I didn't understand what you meant by this sentence. What I
> >> mean is that we can't remove both, otherwise, neither the kernel nor
> >> user space would be aware of a buffer overflow. From my test, there was
> >> no OOM or other exceptions when the overflow occurred; it just resulted
> >> in the displayed information being truncated. Therefore, we need to keep
> >> one.
> > 
> > I've had this in mind
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 71fe2a95b8bd..3e17b9c3a27a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1845,9 +1845,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> >  			       vm_event_name(memcg_vm_event_stat[i]),
> >  			       memcg_events(memcg, memcg_vm_event_stat[i]));
> >  	}
> > -
> > -	/* The above should easily fit into one page */
> > -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
> >  }
> >  
> >  static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
> > @@ -1858,7 +1855,8 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> >  		memcg_stat_format(memcg, s);
> >  	else
> >  		memcg1_stat_format(memcg, s);
> > -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
> > +	if (seq_buf_has_overflowed(s))
> > +		pr_warn("%s: Stat buffer insufficient please report\n", __FUNCTION__);
> 
> I found that after the change, the effect is as follows:
> 
> # dmesg
> [   51.028327] memory_stat_format: Stat buffer insufficient please report
> 
> with no keywords such as "Failed", "Warning" to draw attention to this
> printout. Should we change it to the following?
> 
> if (seq_buf_has_overflowed(s))
>       pr_warn("%s: Warning, Stat buffer overflow, please report\n",
> __FUNCTION__);

LGTM.
-- 
Michal Hocko
SUSE Labs

