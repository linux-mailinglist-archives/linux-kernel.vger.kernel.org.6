Return-Path: <linux-kernel+bounces-403798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2659C3AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7161C21B25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5E143C72;
	Mon, 11 Nov 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3/w8/rP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238078289
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317882; cv=none; b=S1ReCTeLu62kJV2MM6CFeo2lhuCeTJJOi1wX5sk5KQSa5OcYnSVqSdC4PvnFewpb7sCvbVO5YHBpyNr5re+ODEJzssByqH2HkM4gpM0glLBKGSIazl7GMiWcWk7idsqbCEYk8vU2yR+kmiP0XdzjaVxm642tdD7h6e2lCMe4bZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317882; c=relaxed/simple;
	bh=WHiKLed6P0aA3mssEu2TJFufpT+8APlPPZ3Fq/+kROo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh+uNvhayYVTaWzvTV93HCBm0ZLtOF0QK8Fegbb2IF59sPYqJr0ArRkPTQCgYbV/mWMcrvO7LRPnPja50SROebopgRgYISZ8+31VxDc84R1ROwO4tdi32/SRyeIYGfb7OvXm4WrTk3HG5zToraFJA2ppQb0x4KhIjenQsvUeUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3/w8/rP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731317878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1AmqhxsL8rzzGELlDSbCXVep29gCA2uUYmEdhtBEA0k=;
	b=U3/w8/rPxWM/zqzZbOWD7d7wkJKhKUBBt2a8ahZbLxrCdTv49ehzEacDYEllDgFhNWuEob
	T3ZDUulsCCft+/TepuI8sJ9YfF5mviCEMSQOH83bJcHiDyM/AQjllUdxWdLSdGLCn0QYCR
	b8CzDismeHjssHL+CppQQMpOsSFibCs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-csG3D0GvM7GsUBo34y7Dqw-1; Mon, 11 Nov 2024 04:37:57 -0500
X-MC-Unique: csG3D0GvM7GsUBo34y7Dqw-1
X-Mimecast-MFC-AGG-ID: csG3D0GvM7GsUBo34y7Dqw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso31196245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731317876; x=1731922676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AmqhxsL8rzzGELlDSbCXVep29gCA2uUYmEdhtBEA0k=;
        b=rtn5Ue2U9Wr5kXEpvP+rvgY7ikwzMpltHze8m1544tL0nCbP7nnFqy7Ep6fSemHbq0
         P3UCML5oPiBlVPhEmNS0KEcmU7ONTVqqZ4zKistWTGBnSFSdigBZKw4jhU2nPDEfVxun
         JCby90P8TYQk6mz4z4YOpQ/oLPxk4Uv5C7UbEKcTtyZDT8GrqE3wFSktVpKcJrbJQaQc
         DKcx19OEAjmGAkj9WwmG4SdluOeis0XxOP+4nFSkZ9URZg4zVCqyStnrBnLn6LaTorQA
         j+XHtqm2BHQWJ4zvf3/GdGJOeRpJJclf+2uShQdCaZnIN675yC4B84eWVMMsplVGifyK
         UFYA==
X-Forwarded-Encrypted: i=1; AJvYcCXB2bOzjRiBtrT3y6ewFakSbacNXMfm+5YpVQDKBcAADCYrH0M+vZsOR36Xb7fItfA6MIjgCvsRQmjAtRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypXQ/24NbyCN3uzOfGRY2N0sYAm/WCnl/8CTQj2+TWkyhONtK1
	25rMcrkfIXmJxFbqYVIAPldyq61PLpIon/c5z8qyYdI/w47eagOpPfp0bot4cY4C3GxTnn7OZIT
	1ik9hYnnXqzqxcHmFjHtyqlJAPLLw8NNNGHvZ4pkxX2Em14TjxrJ9V7y8xl1Knw==
X-Received: by 2002:a05:600c:a384:b0:431:5503:43ca with SMTP id 5b1f17b1804b1-432c5d13d2dmr23591235e9.28.1731317876362;
        Mon, 11 Nov 2024 01:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2oMu3LJQQXMWQrycmnrzzPfBxLIuhF2LrgaR+bv2sBUs4isWFdYPamE8xbH6ZAPQTH7Xaqw==
X-Received: by 2002:a05:600c:a384:b0:431:5503:43ca with SMTP id 5b1f17b1804b1-432c5d13d2dmr23591045e9.28.1731317875943;
        Mon, 11 Nov 2024 01:37:55 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-250.as13285.net. [89.240.117.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a226sm210454025e9.28.2024.11.11.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:37:55 -0800 (PST)
Date: Mon, 11 Nov 2024 09:37:53 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
Message-ID: <ZzHQcQ4nBYdcbZJ_@jlelli-thinkpadt14gen4.remote.csb>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
 <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
 <20241104174109.GA1044726@google.com>
 <ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb>
 <74c126bc-911f-45fc-b024-815e134c97cf@redhat.com>
 <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>
 <5259772c-527b-4ab2-9606-2d1f0d93862a@redhat.com>
 <a8e3dfbd-0efa-4b4e-bc18-d00abaa79f14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e3dfbd-0efa-4b4e-bc18-d00abaa79f14@redhat.com>

On 09/11/24 13:18, Waiman Long wrote:
> On 11/8/24 10:30 PM, Waiman Long wrote:
> > I have the patchset to enforce that rebuild_sched_domains_locked() will
> > only be called at most once per cpuset operation.
> > 
> > By adding some debug code to further study the null total_bw issue when
> > cpuset.cpus.partition is being changed, I found that eliminating the
> > redundant rebuild_sched_domains_locked() reduced the chance of hitting
> > null total_bw, it did not eliminate it. By running my cpuset test
> > script, I hit 250 cases of null total_bw with the v6.12-rc6 kernel. With
> > my new cpuset patch applied, it reduces it to 120 cases of null
> > total_bw.
> > 
> > I will try to look further for the exact condition that triggers null
> > total_bw generation.
> 
> After further testing, the 120 cases of null total_bw can be classified into
> the following 3 categories.
> 
> 1) 51 cases when an isolated partition with isolated CPUs is created.
> Isolated CPU is not subjected to scheduling and so a total_bw of 0 is fine
> and not really a problem.
> 
> 2) 67 cases when a nested partitions are being removed (A1 - A2). There is
> probably caused by some kind of race condtion. If I insert an artifical
> delay between the removal of A2 and A1, total_bw is fine. If there is no
> delay, I can see a null total_bw. That shouldn't really a problem in
> practice, though we may still need to figure out why.
> 
> 2) Two cases where null total_bw is seen when a new partition is created by
> moving all the CPUs in the parent cgroup into its partition and the parent
> becomes a null partition with no CPU. The following example illustrates the
> steps.
> 
> #!/bin/bash
> CGRP=/sys/fs/cgroup
> cd $CGRP
> echo +cpuset > cgroup.subtree_control
> mkdir A1
> cd A1
> echo 0-1 > cpuset.cpus
> echo root > cpuset.cpus.partition
> echo "A1 partition"
> echo +cpuset > cgroup.subtree_control
> mkdir A2
> cd A2
> echo 0-1 > cpuset.cpus
> echo root > cpuset.cpus.partition
> echo "A2 partition"
> cd ..
> echo "Remove A2"
> rmdir A2
> cd ..
> echo "Remove A1"
> rmdir A1
> 
> In this corner case, there is actually no change in the set of sched
> domains. In this case, the sched domain set of CPUs 0-1 is being moved from
> partition A1 to A2 and vice versa in the removal of A2. This is similar to
> calling rebuild_sched_domains_locked() twice with the same input. I believe
> that is the condition that causes null total_bw.
> 
> Now the question is why the deadline code behaves this way. It is probably a
> bug that needs to be addressed.

Thanks for the analysis (and the patches). Will take a look, but I
suspect it might be because in case domains are not destroyed, we clear
them up (total_bw set to 0), but we don't add fair server contribution
back because rqs are not attached to domains (as there have been alredy
attached when such domains were created).

Best,
Juri


