Return-Path: <linux-kernel+bounces-546664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F198AA4FD75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD09166218
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D5230BCC;
	Wed,  5 Mar 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHp+fFzo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441C221F27
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173641; cv=none; b=ONMCPsllCIhdKOtNWFHjvXn3uxmLypO7lfyBDueAa7Un38KglQ0FNXoPQAEwB/ggPfJC0eS10TsCtAC0F1cAqUB8D2u07VV1gjWjkh+Uk+tteBD4L/zGA+73A4+7xdYLW+PEX74u0LGBPbepKm80HAKEScm07iVAsa8aBVT4ke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173641; c=relaxed/simple;
	bh=9KuRPMrgSumxM9wAGEbWI0xRLjlalFYSuV3BqkFTFfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gipZDTtbYbe7BDLUH54/ExGk7Ddb59eawWy4fcFP0mUSpkT4nKQFP7EdKa7t4QB9X8jPjtYYyi5AbKnSVpJdIuqAcRk8VWFG8jQiHGeEJpca6ovZnel15RmmaUG05znGFF8kuzHVrFK5ZTzaKwT9xdKiIkcCveTH6AlfPH+n0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHp+fFzo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741173638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bkakf8mAIpubx1gm0eZsv8Rzs6PFtDE2Ih4XhtXqzk=;
	b=EHp+fFzozbAU1l87rOpwG8o6GERj7K6DJFBqye3+jj+xuf+ddq1BghYaZIE0WIRQj22OxY
	6JOrcbl4ChS7Vj5OJoU0Ch6MWusp0ssirBj8l5jMnIxEKdZv2yQFe5TZ36CX6KWhXN8rZB
	xPbGByHn0L/my9Zj7km+uewZ9sGN6a0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-2tNez5khOfiiituVvI6bMA-1; Wed, 05 Mar 2025 06:20:37 -0500
X-MC-Unique: 2tNez5khOfiiituVvI6bMA-1
X-Mimecast-MFC-AGG-ID: 2tNez5khOfiiituVvI6bMA_1741173636
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912539665cso148402f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173636; x=1741778436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Bkakf8mAIpubx1gm0eZsv8Rzs6PFtDE2Ih4XhtXqzk=;
        b=ff7ya8DWBaSviaX1FAQ1pia+fC/twL9PvRNrrn86pR3EAOTVlgm1TS9wtGEFdWJSBG
         HxTh6/qIKoNXzCbUGX1R7nUYp/JaofDllV7OjZO4l+F0ZBphF6NZO51G3T3a7jNKwtc3
         bRJv0u/EeLGi+fBCyaStxIg0kGOqO70/61XK5yoAEf/Smqlk1OaZrqMXB817Rl9VwFds
         +N9jSo4E2V5iXbwMu6jMGWmiIBui8nA7dVxbJW/LIiBEyAgDxxqkM+zjKc+FFMkwXHbb
         nKpwxLyrbf+d6kUUt8j8RZtWVEf8iCC5ppsh9IJu/atK5mXRnmg7S7zYycFkjR+qBP5W
         +JUA==
X-Gm-Message-State: AOJu0YzC4mvx7uP3RAJQn33MhzvaIDTUJeAMjccrKPqv7y0WmFHMtpUj
	WGsPa8/VBhhrN8bHqcucIj00R6Vk/NkKO8c97omn4dKl/kWDuQ4KU/Gk5sJm/CHL0Wza0BXi0KC
	lh6WM2sLgExvcyVCSSvHu1Nqc6QQWDUYMVdr6l5F+M59rjZdnWKtkf/BGPTjILQ==
X-Gm-Gg: ASbGncsL2PdA2T0M/uHS+YhbhppU4mVsLQI33fFAzelO9ErD9KJXiLKgYfV7dL8zqS8
	lmysotO8DgnbckXCOJavyZoMFUN1tL3LBOK9MC8JO3hS3DVWPrdt9us5lRDjIlvREJDgYop+KMD
	StvP/fdWFyJsBOFz5CzYyMAmkzHDnRJ1fJWVfl+A3afBRWOpjX8tmsRc3AegFBFr1ITevtkOWt8
	lF+NO4EO6tt6PJ+4FaCdvCZ0/e9U7WFDgvjxlQc6Le2pDcPd7AQqRDt8ivLW4sDb4W1Dfmjc280
	IbI1JkwMeilk3c02/z+ueqgDDKj0vhUCJ256vP0gjflm9OM0BmSbbYpItoNEu0cEtaOc4fcf+mc
	44F0Y
X-Received: by 2002:a05:6000:4009:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3911e9df21fmr2382082f8f.8.1741173636301;
        Wed, 05 Mar 2025 03:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAJ1N42vGbNNXbqzgWkiEhUsL47Sj04Lni5aulHIgSDua9zvjpyKfNY1AIXLGlW6iWXZF7ZA==
X-Received: by 2002:a05:6000:4009:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3911e9df21fmr2382052f8f.8.1741173635956;
        Wed, 05 Mar 2025 03:20:35 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm21079334f8f.63.2025.03.05.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:20:34 -0800 (PST)
Date: Wed, 5 Mar 2025 11:20:33 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z8gzgfhBeYxvboFA@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
 <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>

On 04/03/25 10:17, Waiman Long wrote:
> On 3/4/25 3:40 AM, Juri Lelli wrote:

...

> > @@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >   {
> >   	sched_domains_mutex_lock();
> >   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > -	dl_rebuild_rd_accounting();
> >   	sched_domains_mutex_unlock();
> >   }
> 
> With this patch, partition_and_rebuild_sched_domains() is essentially the
> same as partition_sched_domains(). We can remove
> partition_and_rebuild_sched_domains() and use partition_sched_domains()
> directly. Also we don't need to expose partition_sched_domains_locked() as
> well as there is no more caller outside of topology.c.

Indeed!

Thanks,
Juri


