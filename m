Return-Path: <linux-kernel+bounces-551378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC00A56BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0021798EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E0221DA0;
	Fri,  7 Mar 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6V8k7bu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1821CFEC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360591; cv=none; b=AaQsjnZ7Eo+KBz+Od0bXyxgQX3tjS7YsTAfA4333eKIJaKSdii8WSK0WoK+Qew5nn9btM1K7aidmMOdJVlmZJyzgJMmZcU7u8adcy+RGNctmAEo2N7PvI1el3p9Vu31xAlpe+MEmXMKmebh8RQo2dsUIpcqFPo3LfgV2MLFzzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360591; c=relaxed/simple;
	bh=bBxbz03qAUVHviMss484CFNq9Oq7Zp1E6pkNgNBfDkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJQjQo8PYt73TI3RdPJYi9h62Jx8YmInMjOMiujI7/S2y5+4zAnLt6Tzlq53quwJB6Le7uIOi4kCywA3LCR5y8ICeeUNsvMPIEfTvzX73f2TIh/+8FeYpdK95cNsBFnoK0t6jlG/p2bpMRhJ2XtD1C9ctnSCQi1rW5OF7VKnZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6V8k7bu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UPoCF2TV9wNGlnVaBCwxXKKLjXm2csIIhfyrHtuFdo=;
	b=H6V8k7buZ5Ax9BnQnQlRNr/c/5bxgP2/nUBH8YiPWQN8ml2E/a9RL6DkGUsWu81u3O7H7N
	F5ntakkA37WmggU+FcvOJaYW4LhWPTJj+xSwanJNUZM8A4QwLmcfNcyrsPVkTP+eBiaNS2
	47Ampnh05iVsnSDRK4lRVHgT0GTPLqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-ZKmOOoqgPYimYjTXX_HO1Q-1; Fri, 07 Mar 2025 10:16:26 -0500
X-MC-Unique: ZKmOOoqgPYimYjTXX_HO1Q-1
X-Mimecast-MFC-AGG-ID: ZKmOOoqgPYimYjTXX_HO1Q_1741360585
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bd0257945so9400815e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360585; x=1741965385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UPoCF2TV9wNGlnVaBCwxXKKLjXm2csIIhfyrHtuFdo=;
        b=TYGV0L4PvBjyl6zL9o74mLlkWhVO78g5YKdRcR1Aa9eZr3nChnIWeLgbmdwytIU+VV
         89zypsj9t6EVo6UchxyQ7hxiN/sAkpoAOIhxYwvlJKPgQwy1eNOA0wh0DiHN7geShMd6
         FHHpj79bkFwPnhkPDffz5owkBCj1bDhsS4TaRMHUP5vqRLI6SU1KFWT9rohmkH5pznlJ
         7hDGDULkF6RqJg3luypyFqmRp9yiv7RAtUNd+Mkqhv4WJ0N1AsbL3qkoxkVg+zi/Yt9V
         1L6TdvAPTe0YNzrcUfddNYlEYVkV5Uy20nJNjSkOdVdNOfW5nyBRInzfoV1BB/lZoAW0
         quRA==
X-Gm-Message-State: AOJu0Yz1qbLNeiGcrEB7eFWKfAOLJD4mAu+fntofoROXbYptcy+MhUaz
	v/Gjhzp7IbCDI3/EYPE2vpJ2jHRwVExCqJESCT/HMaPxdMpDOyZTHGXXSAdY1Jz820WVu8Wmn+I
	3zN/2NUgrr74ZmKDfjoxAdghiUlTQ/cXygH9r4WoQ8hhGI8Nk+BaQDb6Vx7BEJw==
X-Gm-Gg: ASbGncs3jjIPESo0rxK5tCo5lteevCwb6KptbhoCyCxQbMXXexS1LBT5DzVfK88JRCi
	rcQpXE35HCsPdqlLiLBSfwEu4ZVdIQcCHHuVZBzUSbQiRIi6KTXFgjuM8brwWL1AACxVcap8YHc
	P8Rk63d4zG9RPi2nzpq9bmfVS2TjAlbGkyGoQNJzGpe7uM/fqAtjg1UPdChgfPhjRGKCwZMTjng
	BivNswmYSEIQxKD8RpSk1dGq6XymzDCjdLBN5KqviTF96r1/eM+wGkuGw/SvYNzkaoMlRMswzft
	fOHUhl//a+dGIiYOmaL1nEKN5IZDhmxDPwk9qICKzRt2kvSiN1JncxzlCwwNJXA1CF1MZVsPp64
	AD6DJ
X-Received: by 2002:a05:600c:154a:b0:43b:d040:3e08 with SMTP id 5b1f17b1804b1-43c601d888emr26835945e9.8.1741360585499;
        Fri, 07 Mar 2025 07:16:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbqdZopBPMKZX+Hcxaxbbjod5fJk6RsUqCj4tqlz0tE6ncD07MAJKcZmWETr1ADUNAGiMoKw==
X-Received: by 2002:a05:600c:154a:b0:43b:d040:3e08 with SMTP id 5b1f17b1804b1-43c601d888emr26835525e9.8.1741360585038;
        Fri, 07 Mar 2025 07:16:25 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195bfsm5574660f8f.48.2025.03.07.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:16:24 -0800 (PST)
Date: Fri, 7 Mar 2025 15:16:22 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z8sNxll-9_VZptWB@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <5cffdf8b-2670-4b46-9434-8024e18e4750@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cffdf8b-2670-4b46-9434-8024e18e4750@nvidia.com>

Hi Jon,

On 07/03/25 11:40, Jon Hunter wrote:
> Hi Juri,
> 
> On 06/03/2025 14:10, Juri Lelli wrote:
> > Hello!
> > 
> > Jon reported [1] a suspend regression on a Tegra board configured to
> > boot with isolcpus and bisected it to commit 53916d5fd3c0
> > ("sched/deadline: Check bandwidth overflow earlier for hotplug").
> > 
> > Root cause analysis pointed out that we are currently failing to
> > correctly clear and restore bandwidth accounting on root domains after
> > changes that initiate from partition_sched_domains(), as it is the case
> > for suspend operations on that board.
> > 
> > This is v2 [2] of the proposed approach to fix the issue. With respect
> > to v1, the following implements the approach by:
> > 
> > - 01: filter out DEADLINE special tasks
> > - 02: preparatory wrappers to be able to grab sched_domains_mutex on
> >        UP (remove !SMP wrappers - Waiman)
> > - 03: generalize unique visiting of root domains so that we can
> >        re-use the mechanism elsewhere
> > - 04: the bulk of the approach, clean and rebuild after changes
> > - 05: clean up a now redundant call
> > - 06: remove partition_and_rebuild_sched_domains() (Waiman)
> > - 07: stop exposing partition_sched_domains_locked (Waiman)
> > 
> > Please test and review. The set is also available at
> 
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!

Best,
Juri


