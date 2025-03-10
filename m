Return-Path: <linux-kernel+bounces-553775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6154A58EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7403A4C61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971F22424D;
	Mon, 10 Mar 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrBu00qO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5261224236
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596909; cv=none; b=b0UMOSemWu4BO0UeM4DRzPOoXn7gOupgBT9UCYSWbEuX+bq7fh0FiTlp9fM774oe9Omt/25guSj/GNgh3BOUflBW6kbPc7wEjAJKmFO173+fStlpHFW2TYBDVOCQY41wQc0JkPS6puxdUtl8z1gnMR1XU7M/bn/R9zn+aHs7q9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596909; c=relaxed/simple;
	bh=Vdn0Xp45W0zY6EXvNCIpPx7m9OhRfnXKtkh1QQkRpho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKsjhh8FnCweY1AlAhkxSKrMOeKm8gA9ZacXktV6EHkwOMm7X2Kl1Uur1TuPQzTD6yviPAH3zIx5GXzwhUq235jSEk348EcBdmZ/FZ+i+HxxJ55P8cbU7PtcdNNnMTLOqpqOC2NAHd0Ggc+raTAWR1wBH9YIpCesCzzqM/sREOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrBu00qO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741596906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdmSXoVy0aw6POMq2SYkzyggnJQqhnLgSVhB7YCFo00=;
	b=RrBu00qOZgp5gcUuyKuRaZGFAW7utPYq8Ko/7Dx2x+zQ8N+pVhhTdbSz9jBtx12oASAmta
	rh9EusELq363dyIbN1MWJUUC6/2iDPuAECX9skO4B8xOskZyFf5z0QB1g8VQgF+UHL65EG
	at0ekPjksVJMud0atmLP1PhLoja7VrM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-4F-uO7cKN7aJyV0L8cQQAA-1; Mon, 10 Mar 2025 04:55:05 -0400
X-MC-Unique: 4F-uO7cKN7aJyV0L8cQQAA-1
X-Mimecast-MFC-AGG-ID: 4F-uO7cKN7aJyV0L8cQQAA_1741596904
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39123912ff0so1638052f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596904; x=1742201704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdmSXoVy0aw6POMq2SYkzyggnJQqhnLgSVhB7YCFo00=;
        b=esTzDYGxNTrdyd/jSRh09iYqQLKExM1eice3rLvRPr/+q9ki6FBZXsNPZSlT6qL0rB
         GAaEUVl1yzlrQUvEkLbbFZeGLqliv9Iilb+18NMUPfccegVgykTM7WWJppDc+N84P+Ux
         d06jauhl088c3qQRTZ/ZFKzyqcecLx2FPzsgVcg/vFiwIQ4C4VAQE0iHmhT9iE2FNnAl
         /pEzSil1nUHDQxBn+JUUGeBkuSvcjSrBFE26AVZ/5+TNMfOk6ewXQ6yYdijbga9OPFdr
         0O6w2pehudJcpRraXl5BIChcPoYLW7yW9F8MW8pvMGw3r4VAO1R5/yfA7Enp9MFcaNZx
         FqDw==
X-Gm-Message-State: AOJu0YziTCeMonOMgXdQj7UBRBtZDPL8vRIu8rWs+QXEUSubevovBFNm
	eACG2mnQa2E20PI1RQd0NUG1JS4TAGpp48wnxAiVJKJ9Rh2FRv9KjmWwnB9GO/QmjrhvHY26hHC
	Fu0YcNoWuKbPJM0axKaFjJ7RwY9keaF1q36GGYEwPAiCLLCfppcvyWfasCMR1Gw==
X-Gm-Gg: ASbGncu8CyCTROisMRGEKXgeVf3QYL2s+vVbkFFRXNP3Agtm5vZpfRQ+kKjypc07uX1
	ieabh022Wx/QlvzHpyTWQL3eLQf46fDi/4XIqnjEcrhdS8n6RPnF6ISF7oZ3BnoOuCXpclkD7xL
	9vsB1bX8+vTRZmSYxEzbfhZaGiPw83TNAEHQHIaMY1QHNhevqvDqg9Pp3GAk7NdqDbZeGoylNyH
	b6dFewjlDvHqREio+RJ80Ei7ePnmPrxyO8zREkOL9SKDxuXPDjebyuhJoV8G7V4XIKjX2wlHd9h
	iYjUo6KlsspejC2Xp+WmT8YFzXkcHCJBCX4KYtYiM80=
X-Received: by 2002:a05:6000:1867:b0:391:253b:405d with SMTP id ffacd0b85a97d-39132d98a1emr8359871f8f.41.1741596903774;
        Mon, 10 Mar 2025 01:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfdR0LZ/IejdEgtb62TmVCUDQ3vvw2ErQjEGxdgcFHhFM2pl+MvjaV81f9xdITu8Eal8mEIg==
X-Received: by 2002:a05:6000:1867:b0:391:253b:405d with SMTP id ffacd0b85a97d-39132d98a1emr8359852f8f.41.1741596903437;
        Mon, 10 Mar 2025 01:55:03 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf87a82f7sm26494435e9.14.2025.03.10.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:55:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:55:00 +0100
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
Subject: Re: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z86o5MC6nXM9W5UL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <93c3f9ac-0225-429a-807c-d11c649c819e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c3f9ac-0225-429a-807c-d11c649c819e@redhat.com>

On 07/03/25 14:00, Waiman Long wrote:
> On 3/6/25 9:10 AM, Juri Lelli wrote:
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

...

> I have run my cpuset test and it completed successfully without any issue.
> 
> Tested-by: Waiman Long <longman@redhat.com>
> 

Thanks!
Juri


