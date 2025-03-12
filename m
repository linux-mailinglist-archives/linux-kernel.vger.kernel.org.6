Return-Path: <linux-kernel+bounces-557510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB08A5DA30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E176175199
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D223DE80;
	Wed, 12 Mar 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU7TRk0W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC12231A51
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774177; cv=none; b=HmEueku/0dnN/iB65X/TOPfDVhovosqdposbh7K+UwQVFqLixQ22caSxPQFSe3sxL7pNSITsXHIyOSTdm3XAoNqUoIjQFk69v2XFnpjQ+I0QJ6DPiS5+kHHJhdyWeL+NVkz6aSeV0EHUhVF5rfGirPGaEFjX+/bUssPUxmn/QQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774177; c=relaxed/simple;
	bh=S743+2ahOXuPljV/reeQ/1enQbTDwpjWM1UaL2m9AeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c71GvSCzKM3sg3TTKzbOe7GhcPItOXvJRwsVJYIqK/UYgfPhyvFfQLMnSHpVQC4XPhnQs1VCMr992tCisLBkvSciJbqWaTBUIjrl351BvKmGG7md6Iik2770e7tWY1Lu1uETWXgq6TU0z41HccF+Q5j8SxgthYNHrxcEaiJom2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eU7TRk0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741774175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S743+2ahOXuPljV/reeQ/1enQbTDwpjWM1UaL2m9AeI=;
	b=eU7TRk0WVI1FxQboMjwvUi/D/vv9LFf9DTK1hVluZD1BkrjJa9etf4cJ7PkjWulDMd3W8x
	AUtK88ScmS/UkJ5xCy+OzP+BFJrljiHBrt5bgwp+qfcXi82BInM2LUegHH5CsQmkf8T2Za
	DpEvIX5o94WjJ18Eihd8FoVydeNGgGk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-a-ld3HMXPq20OaGZVIk23Q-1; Wed, 12 Mar 2025 06:09:33 -0400
X-MC-Unique: a-ld3HMXPq20OaGZVIk23Q-1
X-Mimecast-MFC-AGG-ID: a-ld3HMXPq20OaGZVIk23Q_1741774172
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39141ffa913so2202386f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741774172; x=1742378972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S743+2ahOXuPljV/reeQ/1enQbTDwpjWM1UaL2m9AeI=;
        b=qP2cVqOQYfOvzeOlVhpoDh81gg4dJ6XYlCGGPI1qM6uobEr4hMZfaCqvehADt9j+Cd
         pU+GtwvHd0EZyp2WRZajBEYXs5p6Fa8gcuj5IiQdg8R0UXNgq6yUh/gNcZKF2HCCa2LC
         GQWm6rXAt15vlOAZn0TXssLoDl8OP6jvA7yglslDChTrczdqr8a86QG16eUzCzVwKjOR
         0vH6vzUVLf71lzjgEzc6JA16vvcsAokeXSi67uSFt7k+4XvQ1ge8fWaJoi90WSaxcZus
         /0r7+CCqFeTdfljCkQ7+cUnHAPzQahAeBve0Bnuu76vO/T2KGvZngwZH7mlGM/L3fXGr
         t3YA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPFRgO37ckUrGld6pQly/7opeLk+GWbnh2zTfWrtqTQ1OtF7zxFs9k6mrQEfXOcbC4680jOfm7w4OgHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgpTsozUPS7XGvIz3+aQ7/cP8osno/NyqMYNwsm1MFyov7dMY
	gJ4iZt3/aWbuYQ5QOV5uTLwpV/NHrzoCyZ5NuvPhiSYopzyXOJtNsXHV3M99eJY5pRzpyOBkdr7
	siQQZhPMeJRdSYaxytv71Mv9qcpE2QPzuTGSyLeJzO+vXRkrfV00gDgN5Eeqrlw==
X-Gm-Gg: ASbGncsnb4DOjst6U7XkE07MXdiZOYCO2iAg3Rnx78qMuwc30oET3qk12Y+lcW/2KNc
	bJJygfJyP4NCSnPdD4ONQsS/qONfPrcYk+uxlB8DB3LuGPY3t8gP6BX6YDz5vKwfZXD6qejkjLz
	mnGyB0mlX6EP8LXFugbDf4OPnydt6WwcYO3KxqHY8gh93HuvHu9sKAPE/0/MVzAmjuz7QH2gOEK
	TN8gJKFRydZaEHe+Hw9vDK9RKDU3UcylDRtVFg8nFLDVVkZ67D6P61dCOAlFrycj2pHS6QXJ9zj
	20B/ydGQ/OEuphnku0FetNDTUBZJeCPOwHX0vWibDvY=
X-Received: by 2002:a05:6000:2ac:b0:391:1458:2233 with SMTP id ffacd0b85a97d-39132d30145mr16025042f8f.11.1741774172439;
        Wed, 12 Mar 2025 03:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC/oegylWFmX8HIfDOEmL2IfKq6J8f3RVSsBgAXMYe83/CsTxWQv7uki2xiMPLn7D1hW+oew==
X-Received: by 2002:a05:6000:2ac:b0:391:1458:2233 with SMTP id ffacd0b85a97d-39132d30145mr16025033f8f.11.1741774172078;
        Wed, 12 Mar 2025 03:09:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e34fasm20758388f8f.75.2025.03.12.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:09:31 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:09:29 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>

On 12/03/25 10:53, Dietmar Eggemann wrote:
> On 11/03/2025 15:51, Waiman Long wrote:

...

> > You are right. cpuhp_tasks_frozen will be set in the suspend/resume
> > case. In that case, we do need to add a cpuset helper to acquire the
> > cpuset_mutex. A test patch as follows (no testing done yet):

...

> This seems to work.

Thanks for testing!

Waiman, how do you like to proceed. Separate patch (in this case can you
please send me that with changelog etc.) or incorporate your changes
into my original patch and possibly, if you like, add Co-authored-by?

> But what about a !CONFIG_CPUSETS build. In this case we won't have
> this DL accounting update during suspend/resume since
> dl_rebuild_rd_accounting() is empty.

I unfortunately very much suspect !CPUSETS accounting is broken. But if
that is indeed the case, it has been broken for a while. :(

Will need to double check that, but I would probably do it later on
separated from this set that at least seems to cure the most common
cases. What do people think?

Thanks,
Juri


