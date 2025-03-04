Return-Path: <linux-kernel+bounces-544918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FAFA4E6C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04321B4009A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4427CB23;
	Tue,  4 Mar 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HE9aV1nA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE8255235
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105106; cv=none; b=INemGo4bEOKFqUAHRoSw3r9i8uPYRpVqmSzYBqew28cZxxM3b0VCGe3Quoja2b1OZtBE/apIrkZfd61zWA11GTZGq4jFZVjqvtbIifrcqvnaCgwb+LNc1w+NUW8M8mdQ+17uSGAd881JtLqKPc1br6k/StLMiEYuKJUgV43k5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105106; c=relaxed/simple;
	bh=EUw6JN41FjtAkvEpNEZvohRqw0SNngFs3t0M/G8bodA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwM8/5dQEO9WkafY8ATeiUsl9ys2EYqTRqnNpA3TcA2qKt0M8w7tKMqw6oBEA32BiNcXnKgjtjieTvisS68TRfbkKxxldo627yMdW0UCcxCM+4tySjVCLiTsqt6uMGousISiNbXWw4bKZxGEAwazzXCFgTt0ZBeKqCQt/8T6HN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HE9aV1nA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741105103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JHbbkf59GK3BHCnXuBfd7al8ax8T3UploK3icFv3u0M=;
	b=HE9aV1nAwKWWhM4hLgVudNZCsVlmiiY1XVDwYaJ7ae6D2pFFjEZDxHhuD5e6qJ/MzGYF8J
	TwTv9LJLmDOYetptIq9ScX7TTu5fR7TKW83vf67Da2Fhaj0IsQKj1P+lvZG+GEA075ZaOm
	1IqFlGFFiIc5rYXjRgB/EqaZR4JeXFg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-BsFwLcQIPPGjEiq-YeZdVA-1; Tue, 04 Mar 2025 11:18:15 -0500
X-MC-Unique: BsFwLcQIPPGjEiq-YeZdVA-1
X-Mimecast-MFC-AGG-ID: BsFwLcQIPPGjEiq-YeZdVA_1741105095
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e89808749eso136940086d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105095; x=1741709895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHbbkf59GK3BHCnXuBfd7al8ax8T3UploK3icFv3u0M=;
        b=s4q6/XeMRSfwtQtf7T8RMRmZgybeFcssTs/LTf/pQ6wyihkw4+TcAfXGNIvWlAF9CY
         Y+ILUXp8cl19srdVipE9h0e4lqAG7geLr07FQ3andtlPYVZ65lStmTGwNcmxR5LPE3HK
         9KzqrQ3hB0WxwZ4rVnV6xYnxw0Wex8aDslydYLcNrlJq3HlRe7h/rAjht3/uHvm1FELB
         skz+gnB02jS0aZRPh5AwSspmTlDCzC5AIt0kBvt4eM2nJZGDs531S/dhVtzyYmn96KNj
         gY/Y57MWrHQn4yY+3ZSFkS3zZdaU/IyHySnPrvlZUoyXZYx2xPmUrJPrnyHJNrwZmPwo
         pT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuz3xpuL6ZNc5PmZjZ7FJUBoOlr+BQnqXCpkABjWW+WCFe2ggej6u6gNaG42P2Esd372BTE7agyBqktqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5JB0p7qJRPLbDNFxb1IkDjBUyxp1/kh97t6lr0b6M4Y5g+tw
	eXEfWy4erIg2UNIt48eyZd4VfJARob0gYrWDSgZQLszYOw6/ND7qxHmktll2VWL6xdn8NS2pnPy
	wi8NjaFRreXJxvglP3+/iYBPULEj1xS7Or0yUnZqDXIBn9Y/yRjUk0CLxvsM7lw==
X-Gm-Gg: ASbGncum8fRXL2BuXbhyynyJVU3GsxsjpBmeYkD6gwiDaqFWMXbnFk9Njh1EKG8aDOI
	uO/MAjBLERuOCsFo/5gN+o62A2nbnGaeKLwkoX02wdLdrJytK8IKk2fqD5o+5+qPvwa7Jrj5Ovc
	bgTIzcasJM+SoXBFhtvUmHtLf1Kk2AaYuhcjgvRTKlTljNbzgFFM4o21PVir9pETBl+kOs6tVwj
	1XoEL4VDF/nV9jQ3VnvmBusexIKtIQfdPtsIGjgtaFsIdF4kzm3fDndbdvOOzG/QmZNRlFVWWPf
	l3A00y3Eni4UA93JRLOMJ4cG/nCb5358IKsU3aQB+rt9GWfgCsu+mmKwRxwvcs3ZCzVn0nQcLDW
	t7zHH
X-Received: by 2002:a05:6214:1d25:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6e8a0d2843amr244067856d6.26.1741105094848;
        Tue, 04 Mar 2025 08:18:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMZBXmxWTsjkO8lCuuk5ALhI5q/JUqSiC/jW4yEUCOQvQ6zIJ44eFdx2yvZOG7FjeiCP1pFQ==
X-Received: by 2002:a05:6214:1d25:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6e8a0d2843amr244067466d6.26.1741105094501;
        Tue, 04 Mar 2025 08:18:14 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec158sm68172966d6.119.2025.03.04.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:18:13 -0800 (PST)
Date: Tue, 4 Mar 2025 16:18:09 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Harshit Agarwal <harshit@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250225180553.167995-1-harshit@nutanix.com>
 <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
 <20250304103001.0f89e953@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304103001.0f89e953@gandalf.local.home>

On 04/03/25 10:30, Steven Rostedt wrote:
> On Tue, 4 Mar 2025 09:15:55 +0000
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > As usual, we have essentially the same in deadline.c, do you think we
> > should/could implement the same fix proactively in there as well? Steve?
> > 
> 
> Probably. It would be better if we could find a way to consolidate the
> functionality so that when we fix a bug in one, the other gets fixed too.

That would be nice indeed.

Thanks,
Juri


