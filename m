Return-Path: <linux-kernel+bounces-550694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A63A56302
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9717AA1B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A801E1DE8;
	Fri,  7 Mar 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAw4bUGd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165E19E971
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337615; cv=none; b=ZtMAsWMUODKprOnUMSETkZq5nSg7h8aTHAmqLF9z1DSi+mw6YmTh+9ncmvrqRoHplFS9+vBPgcSf5TPqJAc/Scks7ficoluHxUW5U47Ak7aHi5+aDEqVROg3zhisdbP5ZsiW/a5ijeffSSiRloN44KYVnS25IMD39Vmdy8abH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337615; c=relaxed/simple;
	bh=trVq+/QuImX7PggLWSPIN3coPhqb1R9Aue9P2NTVfo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkSZLCaTzl+GsmMteGgcRaQsvnkzCkqbOGHcRZG0QY7BN2adwm5J84pndWXN72GLUTzjU88MtIV5WssLvVHHQjYKoVjXh9qRv7yGocl5iBV4WjuInU4Wa9Oc6iRdOLz9gqGXKbUB4QlsUzvw0WRurOuambWzK6/TZXpFEJ+1d5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAw4bUGd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741337612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLCvL7MTjAjZGB5lfv9MT1kgTWiIaHT/S9+g0TItFt8=;
	b=BAw4bUGdBHm3tLnCBdH7udOgYXMoSMQ2v6+OpmOXdnNcCKz6Xzf9jGTS9t1qjkzvvlx0od
	KPBhyGNKrrAem+Z6cxR9vOTfB4xrYwpmICun9FJTmy+tOfV6lvUwvumCb0b3YeCy1ldoum
	aeF6CivplJ+/qcxwO4HOKeMAtb87WBg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-zjS0DzmLOHWdWOCw21O4PA-1; Fri, 07 Mar 2025 03:53:29 -0500
X-MC-Unique: zjS0DzmLOHWdWOCw21O4PA-1
X-Mimecast-MFC-AGG-ID: zjS0DzmLOHWdWOCw21O4PA_1741337609
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c24bb4f502so318329385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337609; x=1741942409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLCvL7MTjAjZGB5lfv9MT1kgTWiIaHT/S9+g0TItFt8=;
        b=Yz17/uQyCseow2o7y/FtJVYPjasvvqv2obE0SK0eUfki7qwo0vRAubCpDajBjv1m79
         /w+U+YXw+9XaBSdxhyrmRO4uWuF6zeVRItfs/vuPV0xBQ67JYOUgN7eEN6+jCNVhPqRI
         Eg38eBGd6Wcj2wG0FjCIzARBAZeOKaq+3QrRzGTs7cvE7fa5NXTHtxUrYd3NleFKoJZE
         hwvhJJhGtKzrVLq7n2Xjz8ncybG8HKoo9yjvdsruL7tz1C9tUHOUrqTcDxfhyG9vRXTe
         2nbbNpgkuWn4fRJ0sR06Tcndk2xwl0rXgRDx5QjeAJBm9+cez7Xe9MFnvkEZpaiZr4pH
         i+Kg==
X-Gm-Message-State: AOJu0YxKbtGejqhQMb4fm3p6XUORJAt7lyZracok/kW0x9rMyVeeMaVT
	QQimP+VDM7w9qvHS9FQMneG69JzjCvEIMHM4SlasIobALJyiGZHdFVki8oVE74nufo+xWe6J7y6
	QIMYNqwUKDYbhGawcJlEi7obHkSVYxYk9xJmDlHUSpdjShgw/QK2cy3tWaFbw/A==
X-Gm-Gg: ASbGncvxblYhqV6Hqd9Ii0HL3f+lRS0EH/t8U+w1RksSmVD2kzlwahyxaCyEsRAWrVY
	8vUDc7lQFzgV15waqRn/A2+7zS5X3b3+1kXp52gudEmatBMSXyD0CcSEcekH1ESNNUGtGIH5Aj7
	6LxEEoh3md8tC37McArqmz16elaMHuxYUe8kXnhBMTpDmBimMTrZrvhUdJrUATe5kKz+N6c1mxa
	uW+8/OC2h+FNJKoyruh/GHCBpGoZ/qLiFi6pmTkYtyGELAZWH9DMFrAn30NaklPlVWiWwQOxvJe
	Rv4HDXbt8b8M7NYOhVmBsM/Bu1rxW04Ryq2sHmQBfJEC9RA+xJEoLRdaJV0owj+YDTWS3mGnkUb
	/e9dY
X-Received: by 2002:a05:620a:847:b0:7c3:d86d:940 with SMTP id af79cd13be357-7c4e61aa101mr345970285a.54.1741337608801;
        Fri, 07 Mar 2025 00:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJPLd70g/e0BjM9dZ6h5h/iDHmxVQ5bPlBK/d3eOLZdc484dJRfYVIn8oWBqWpfXqk/32+PA==
X-Received: by 2002:a05:620a:847:b0:7c3:d86d:940 with SMTP id af79cd13be357-7c4e61aa101mr345967485a.54.1741337608510;
        Fri, 07 Mar 2025 00:53:28 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534c76fsm216015285a.41.2025.03.07.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:53:27 -0800 (PST)
Date: Fri, 7 Mar 2025 08:53:22 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
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
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z8q0Alpk8AXbGxgW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <6894861a-4a40-4c6d-8f48-997b999f5778@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6894861a-4a40-4c6d-8f48-997b999f5778@linux.ibm.com>

Hi,

Thanks for the overall review!

On 07/03/25 12:04, Shrikanth Hegde wrote:
> Hi Juri.
> 
> On 3/6/25 19:40, Juri Lelli wrote:
> > Create wrappers for sched_domains_mutex so that it can transparently be
> > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > do.

...

> Maybe sched_domains_mutex can be static since its only used in topology.c ?

We have a lockdep_assert in cpuset.c, don't we? We can create another
wrapper for that, but I am not sure it is going to be cleaner.

Thanks,
Juri


