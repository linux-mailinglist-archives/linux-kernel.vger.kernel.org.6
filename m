Return-Path: <linux-kernel+bounces-518045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0773A38910
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67D316569F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C9B2253F2;
	Mon, 17 Feb 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEFH8r/u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439B224B0C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809524; cv=none; b=rdgM932bus3FIKwol1bGyP9w3XsLVBUAdkHEv3vCCGUhQu81IInCJoD632VZVCjdrBrkRzIPAdqZQjdwABtIdo5hvtNv5GMr6m7kVfnSFpw/IJdclYmpqQFFbLHwxG+U7oOorcTIg3+aTtvWOif/c3ZchGW+noD31W7pCp+EvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809524; c=relaxed/simple;
	bh=BO4L1pRp62bAhs0LkzpLl9uOty1wa60ovjsEiCzLG7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j052e2YkZa8ePSymlNF+9di5JDmA0tAXO2o3JA2zbDrlUHKFXJK5KXxSKQy0z1Dmvn6+AZTpEEsWBi74a3AIwSAYvIuZ9WAiXahQxox/vHrD4fOCirrE3hyRox2DZle/5m2R+jCoJwoispwRnPtVrIbEmn86BFYThQXkshJwN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEFH8r/u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739809521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQDqUDWAAcTJbBVPTUGpb/vgmEjmwpVzrNnTKjOD+kw=;
	b=MEFH8r/uK0ODxux2NMpI/P29CRKfCr8JujbGixb6mf8qfKjLHkz031lHtkd21hLaMesCG7
	2his2YXYj7uHEv2m0W4Eg1PGxbjjnQwGx7brXcitbcK7vxkh7H1hyLMX6d1sHSs1vprXL+
	mRQyZYmQR/io11n9ZhKxEwXSmQvSVZM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-ssxNlXUuNM-lQC0DeHtdFg-1; Mon, 17 Feb 2025 11:25:20 -0500
X-MC-Unique: ssxNlXUuNM-lQC0DeHtdFg-1
X-Mimecast-MFC-AGG-ID: ssxNlXUuNM-lQC0DeHtdFg_1739809519
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so24194295e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809519; x=1740414319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQDqUDWAAcTJbBVPTUGpb/vgmEjmwpVzrNnTKjOD+kw=;
        b=jzvWlMw9PuyBhDXXheLgQ+UGwQ1pEd+u49f02UkAhzpkkN4+cGaAGaf5UL8Atl7Pe9
         WSBw3Nit3cyNCiT5YPrs8sC9H8Vszhl1d0/HOxWEsbM0o6nCuVgLWSCYijoHHBR5VG7e
         wI9BShBgTskyc6QxjFiCcLFIPJS/NmmCaOi6+MMIKy40P4crujsZ2RNpyrtxkOOrk2Xq
         bSK1ggjqIsGfaU+G1JxFBpQR++XbGGZtId9soWv0Ky096zxZinypszbDVjAVgR2PpEqk
         wT+KS5rqBqRZBlRSBsaMXNJhrAEvRep26Slqf9tRveZaY/1/gvBeC5cPI/21MCVv4SLq
         vQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXYVTYAJHacA685ya+x2aZS1qf4lhklAt9QckWLwXNpZvitMNHA1y9GNRSrf2mu0bUbLo4Y0dKB2XBmZ9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRMPfBbmOEuNIHExYm3hbJdi3yL5qFf4eY5RaFRW67CDWwO+W
	BoSaj2FNRU2aF0xdXrcNOb1bCr3i+1FUgRP7ias9ejnz2W5nr6uS0qmno32OdtQWnwcgqyejGj6
	AYE4xrk7h4VacYlKCZulxV1zoeNsJPJhqcr5gS3OXRNiXnR38DQ5qlr5WMKq9ag==
X-Gm-Gg: ASbGncue21gsyW92fZM0TajasEOAERqbWNyxNvqcYoA2n7QeA+QHaHWaUkKK2ipnugI
	n0bqtrKl408WyF1pvJInxQ8ifziWGcJc7Jb2RrhkGVhOupn1p0XmYa7YepWNd3Z9gAbkqcwdUC+
	1kW9WJOjjV5jvsAdpQ/DcI3DjGLueBxfhVDvn88z5EFS93JzLrybbsQv9JxHpGtHTPY0++/jfMU
	h5E6ZWa35Z9qZvk9W/q2qzjoCmNV8vdD8vTkp9RvaTF7iHII8dExAwoTQOTDAGUIO2FCztoVJ4p
	VFAGcN1Uwg7D+de5WCIOuUP8po6xYLXK8Q==
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr93371275e9.4.1739809518848;
        Mon, 17 Feb 2025 08:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdXsc4MSLBBft4Feb9QxRjqSmU4xNnKee9CG5WxjCrosP0JLNdZXOOenoA8hq2EjCjj8zu4g==
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr93370965e9.4.1739809518532;
        Mon, 17 Feb 2025 08:25:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm158655425e9.27.2025.02.17.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:25:17 -0800 (PST)
Date: Mon, 17 Feb 2025 17:25:15 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7Ni62BnlU0MX6BA@jlelli-thinkpadt14gen4.remote.csb>
References: <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <371e6b88-e7d5-4e78-9468-33e29f7fdb53@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371e6b88-e7d5-4e78-9468-33e29f7fdb53@nvidia.com>

On 17/02/25 16:10, Jon Hunter wrote:
> 
> On 17/02/2025 16:08, Juri Lelli wrote:
> > On 14/02/25 10:05, Jon Hunter wrote:
> > 
> > ...
> > 
> > > Sorry for the delay, the day got away from me. However, it is still not
> > > working :-(
> > 
> > Ouch.
> > 
> > > Console log is attached.
> > 
> > Thanks. Did you happen to also collect a corresponding trace?
> 
> Sorry, but I am not sure exactly what trace do you want?

Ah, sorry, I think I mentioned it somewhere else in this long thread.

The idea would be to boot with something like "ftrace=nop
trace_buf_size=50K" added to kernel cmdline.

I would then try to offline CPUs 'manually' in the order suspend seems
to be doing (starting from CPU5). Offlining CPU1 should still fail. At
that point collect the trace with

# cat /sys/kernel/debug/tracing/trace > trace.out

and share it together with dmesg output as you have been doing so far.

Thanks!
Juri


