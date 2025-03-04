Return-Path: <linux-kernel+bounces-544827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797EA4E67C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5899D8A6610
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E79259CA2;
	Tue,  4 Mar 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QavnOK3n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41499259C98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103636; cv=none; b=JIIknyyxGqe0GUc1rSPcuEV/Rq1OmHoi+RdyGLVCIEXqoasVjITtlQ935gM6t0yp9ZC+CUGRnqKeV1UDc8uffQqbCrvS8rxJyCT+lYaWiHHnzhyIGNAeYHEygRYalKunapiGArkJRNIEvEv0CFcwbpWB2FN/PKMMuBzsvQMxbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103636; c=relaxed/simple;
	bh=1vV7+BT4xw81qLATGwFSVB9T/BFBbp5ljRvUFKtYJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0wM2wcDZXCanzkK8bplivjeuMFrzzSoX7aB90DubHeQswF9ZVYn98oeiH5orwisKdi7sAF5wXPr78Z+OmJqYJZ9O9J3log+8GwfLeWJcL0ReLyLDCpz5Wx6oLJn27yURyHXVh3X3PsMuaVfx3uHXfGgYgvtt1CE3p7RcbcRheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QavnOK3n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri5wR93YJXv4w21IzGikMZS6QGEGNEj5q6TV1QKUdt8=;
	b=QavnOK3na/hdl4n2QtUQjk8l7nfqiWglm90RBZA+pajmC1iFBNnIY2X7mceVPOoVvH8mPl
	v1in8FMzY8bslg2+B4PXUhPJE6MTGwAe30EMVzgPKkOOZ7YaMqxLi6K1gK4/nrKV1tMptu
	JqQWN6BXKHGjeeJlKNTScehVA1L62sg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Wd75mrtEND2PLz5OVle7nQ-1; Tue, 04 Mar 2025 10:53:52 -0500
X-MC-Unique: Wd75mrtEND2PLz5OVle7nQ-1
X-Mimecast-MFC-AGG-ID: Wd75mrtEND2PLz5OVle7nQ_1741103631
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4393e89e910so31933585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103631; x=1741708431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri5wR93YJXv4w21IzGikMZS6QGEGNEj5q6TV1QKUdt8=;
        b=qKJOEtKtYJJxoI2wg1oW/9oHOoe6j23hu+jLAb/LwhlTI1x5qw5Z79pXqcCJUPpdCM
         KC0lpHm4pQcYw+vBbnW25A8haDwCqaNv3bJ9CQcDrPhc5l9m4QXGrIcn75m2KUDMfPMV
         R5dUAqgmc3xopqk1Xo5osUyqMWGzOaRAXZD/PebIc0Il3QN4VVVYGWCrFKYMByJPTyHn
         gbPHwFihBIv4Uln8ISAU2dt6keXU6SuQcEGCjzX8+6nuPMfGAYIzjRc8y2IT8xrtxrZF
         4DS5f6uOcsnK9DgkZyz/QnQfRUona+9ncMcNe+7eAv2mo4ovS5CniI1yCBNc2pfEs4bD
         Z6cQ==
X-Gm-Message-State: AOJu0Yz1SciFs2ptM3+/xphp4BrBUBTcmQ60vyirohf2Mu7C7KqWAMnO
	1eBZ6hE8d3PZ5bRRe/makRmMetm9F1GYIIm5EJbS/GHnTR6ce7PEimA6SvpF9TX9SUIgFL6eyBQ
	txJK8OX4GBAeM0MaldUdBgmkzjyxZ609DYoYvc8C2KCLJmnaxzO8aTsTZg9xSAQ==
X-Gm-Gg: ASbGncttbPfAn/riCkebXSqXm3F/rcJCzd8vZDBAu7RRxcNKCoByLlycgXAVPavB/oz
	Xr7qEtVIZNQXMejGtxBeEZFwowPiwZgWlAVLSJkyFRnTOviE85CGw1f7+Fo+ZHAKqMzvzHYWwgo
	2Jpcie9JfWemsv36NrGJqKmaDclSZuzWv898HZq4KjJnI8V33unfbfa57dwfcEjgEC/7aUNrc4u
	nGNgZVVwrvbJgrHfi0y0iV0akzp/eESW9Wi4nlZ+DBrPUeYPYJxeVX1sZhWszca94vuYoq/zaEH
	hgpiPCHmshAhh0w51piknZazOxXWofQTjQYo2Cj9KG42uIR5SDJN/PWfCOgVSdaK5TRZ2YFbxZq
	SKDX6
X-Received: by 2002:a5d:5f84:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390ec7c6a3bmr16312420f8f.3.1741103631480;
        Tue, 04 Mar 2025 07:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBhIMPB956a7ncBlyy8BOaBmL91FKiR7SKf3cdKksS88vwy8ZlkzWMX3xE90PfLivuTds0aA==
X-Received: by 2002:a5d:5f84:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390ec7c6a3bmr16312395f8f.3.1741103631142;
        Tue, 04 Mar 2025 07:53:51 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bad347823sm149763155e9.0.2025.03.04.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:53:50 -0800 (PST)
Date: Tue, 4 Mar 2025 15:53:48 +0000
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
Subject: Re: [PATCH 0/5] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z8ciDMdstzJCZoBm@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <a04845cf-c70a-4699-8260-27a3502fd01d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04845cf-c70a-4699-8260-27a3502fd01d@nvidia.com>

Hi Jon,

On 04/03/25 15:32, Jon Hunter wrote:
> Hi Juri,
> 
> On 04/03/2025 08:40, Juri Lelli wrote:
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
> > The way we currently make sure that accounting properly follows root
> > domain changes is quite convoluted and was indeed missing some corner
> > cases. So, instead of adding yet more fragile operations, I thought we
> > could simplify things by always clearing and rebuilding bandwidth
> > information on all domains after an update is complete. Also, we should
> > be ignoring DEADLINE special tasks when doing so (e.g. sugov), since we
> > ignore them already for runtime enforcement and admission control
> > anyway.
> > 
> > The following implements the approach by:
> > 
> > - 01/05: filter out DEADLINE special tasks
> > - 02/05: preparatory wrappers to be able to grab sched_domains_mutex on
> >           UP
> > - 03/05: generalize unique visiting of root domains so that we can
> >           re-use the mechanism elsewhere
> > - 04/05: the bulk of the approach, clean and rebuild after changes
> > - 05/05: clean up a now redundant call
> > 
> > Please test and review. The set is also available at
> > 
> > git@github.com:jlelli/linux.git upstream/deadline/domains-suspend
> 
> 
> I know that this is still under review, but I have tested on my side and it
> is working for me, so feel free to include my ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Great to hear this and thanks for the super quick turn around with
testing. I will be implementing the changes that Waiman (and possibly
others) is suggesting and post a new version soon.

Best,
Juri


