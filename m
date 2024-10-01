Return-Path: <linux-kernel+bounces-345451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAAD98B678
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302821F23F22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55441BE222;
	Tue,  1 Oct 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ettfp2K1"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41961BDAB6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769730; cv=none; b=UvNcMrswSBseK3nufbMte4vskvJ1u0+m/OrMjAguzjQY7P37p2sCepdvcrSsLjwTn/D1PQdeaz6RRf2qCc03Aah6/+nQWNu8DwcnpdLmLeeClnNdL59jOXwA9ZGuz7xJKgq4aFPAlad++Od1UiCP1Ke6DY8Ue5zKSeqiQdqZUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769730; c=relaxed/simple;
	bh=0z3Q2TwjUUHm4I5+ZkLKj4ArSkSzsR94lZ+MfYGRFVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvjegPb/aWgeIGnJUGLBdgHdmmXz1p8D1MmLW1Kf+0fZAO/SCXYX1AM5nZ3Cj3F69eNKMi0wRn4v4HPhlQphfzpkjv9yvIgIGpupEanZwKChytbOqgbx3FjdW6B/vwdnIpqaT+QF3A2HkoklixlPNvUGIXsUKRgQM/PeB4APOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ettfp2K1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso969263666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727769725; x=1728374525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hk/i73WQFQP4oYfhWxBgvHCjFB4xRCgbQvPfKxMjoE=;
        b=Ettfp2K1noBnVIPW9V9RKRZqiia+aE6HqDw0C6si9wZ5+ReDZACUQqa+IPTXKBDi9d
         vNZXNC2eVHpuP11WGNP/W9ZXL9scDim+f4N8mMcK8m7Uqda4BKOm0ePldvwQqfNt+wS4
         L8K8Te6NUs5KLDAHu8/oy0RxIE4q54TfTbPCjOYZMmzPG+he46/yaeaYlpRbPUCA1f6i
         LKkiQUeTl3YbTLAvYj+RVBtDVFVzLVq60igS57PjG//LE4gXsSNVEGoZamIwTIyp7fix
         tn6UOkRXF4CQbUEUGeHo/I3L8oQtUoXDRD8348n/qDJC71Q8uInpblMwk6LwTdm/jzHu
         w5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769725; x=1728374525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hk/i73WQFQP4oYfhWxBgvHCjFB4xRCgbQvPfKxMjoE=;
        b=se7uVu/2LODHducvioVCxSkiLl3z/upmrpXsRr+/PBcW93+B+azp5MGD++JI6S4XFk
         vy6uTk7wUHxKo68l7VCiQW7Xewps6Kz6To/KH+TXk+UxGWwyxgz0vs/OSDRTK+Ogu3td
         YQfFDdmqlrk/J9yI3AXIdz3MQNOrl8blNrHCfjWnyCc3J6SJyZH2WKey4rVsp1yAL64m
         eIfHumnVmw8v8Q6PuFkeNsr9tep0GpOsfj1Bv6c5EQSVI5/9STSXXwCB2+QDH7wz02SJ
         LdEmoyJIRuwSGPdqiKCsXxdQ0HtFgtam42aPEZswwaUTaugF68ub0ySHoW3WFdbQPYnu
         rE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUWQ1qojxfJ7JRt/By+xKVF4OCsZbzI/SIBUCU5rAlqhxa31pMF+BYWvvvqNt0xjHIOLcRiPhJWoCwmTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ESJMXVf36RjtMJ2KIhcym3BsGHW+SeI35P17PGLWbFl6gBVq
	2yCRuGqGitBr176RUN6tnl9ydak4lIg9gywlU9MRt2qOIqY5SuHXpNExdyW+PPE=
X-Google-Smtp-Source: AGHT+IEZYiIGUiL3IgOx2ihu3PxW2sRHP9GNhi5eZ0Q17AVixPLaSmOq3qHZ7L4U+ujqzhG5kJ+nDw==
X-Received: by 2002:a17:907:6e9e:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a967bf67b2amr247604766b.15.1727769725172;
        Tue, 01 Oct 2024 01:02:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27770desm659099066b.32.2024.10.01.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:02:04 -0700 (PDT)
Date: Tue, 1 Oct 2024 10:02:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: CVE-2024-46839: workqueue: Improve scalability of workqueue
 watchdog touch
Message-ID: <ZvusWymx4rGO55NG@pathway.suse.cz>
References: <2024092754-CVE-2024-46839-cfab@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024092754-CVE-2024-46839-cfab@gregkh>

On Fri 2024-09-27 14:40:07, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> workqueue: Improve scalability of workqueue watchdog touch
> 
> On a ~2000 CPU powerpc system, hard lockups have been observed in the
> workqueue code when stop_machine runs (in this case due to CPU hotplug).

I believe that this does not qualify as a security vulnerability.
Any hotplug is a privileged operation.

Best Regards,
Petr

> This is due to lots of CPUs spinning in multi_cpu_stop, calling
> touch_nmi_watchdog() which ends up calling wq_watchdog_touch().
> wq_watchdog_touch() writes to the global variable wq_watchdog_touched,
> and that can find itself in the same cacheline as other important
> workqueue data, which slows down operations to the point of lockups.
>
> In the case of the following abridged trace, worker_pool_idr was in
> the hot line, causing the lockups to always appear at idr_find.
> 
>   watchdog: CPU 1125 self-detected hard LOCKUP @ idr_find
>   Call Trace:
>   get_work_pool
>   __queue_work
>   call_timer_fn
>   run_timer_softirq
>   __do_softirq
>   do_softirq_own_stack
>   irq_exit
>   timer_interrupt
>   decrementer_common_virt
>   * interrupt: 900 (timer) at multi_cpu_stop
>   multi_cpu_stop
>   cpu_stopper_thread
>   smpboot_thread_fn
>   kthread
> 
> Fix this by having wq_watchdog_touch() only write to the line if the
> last time a touch was recorded exceeds 1/4 of the watchdog threshold.
> 
> The Linux kernel CVE team has assigned CVE-2024-46839 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 5.15.167 with commit 9d08fce64dd7
> 	Fixed in 6.1.110 with commit a2abd35e7dc5
> 	Fixed in 6.6.51 with commit 241bce1c757d
> 	Fixed in 6.10.10 with commit da5f374103a1
> 	Fixed in 6.11 with commit 98f887f820c9
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-46839
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	kernel/workqueue.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/9d08fce64dd77f42e2361a4818dbc4b50f3c7dad
> 	https://git.kernel.org/stable/c/a2abd35e7dc55bf9ed01e2b3481fa78e086d3bf4
> 	https://git.kernel.org/stable/c/241bce1c757d0587721512296952e6bba69631ed
> 	https://git.kernel.org/stable/c/da5f374103a1e0881bbd35847dc57b04ac155eb0
> 	https://git.kernel.org/stable/c/98f887f820c993e05a12e8aa816c80b8661d4c87

