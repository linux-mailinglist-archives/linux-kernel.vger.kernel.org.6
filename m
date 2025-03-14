Return-Path: <linux-kernel+bounces-561103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5AFA60D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6DA880812
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC31F03CB;
	Fri, 14 Mar 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fumBZq77"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AE1EBA07
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945378; cv=none; b=SxQI3bUnnK3Q1X0W0TRjW8+7zcETa0k+gAe8As+OjgCqH+v92hr3wM4hyiimqvrnLXrfMSsx8c3EskPKb8gCSlm7cPB8+hUE7kJ+7EGV6V3esrhBmzveedBtQ9753m09/OLhUNLaRBvUgWc3cKoZq89mwEPpg0WvS+2cTG07kP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945378; c=relaxed/simple;
	bh=NHWqwcmIAPSaHvvExWsY3PmsamrROfeZKayvsRC2fig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEPLjRPGin5xx3VhxukmjUF5QzH2h1CsvrsvpY7hTEvFA7zci7XVnmyc/dOTsG37QV0Fs2/JHr5g7f027dGaMjCPLTR1Rj3aJ6OC/n96o+wJWg0wcUtsXfwc4FVau3V03wFhR0QakiTnsQUrmT0eg03KF6D0U32qHFpswayCv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fumBZq77; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225477548e1so34777555ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741945376; x=1742550176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/g4jvwbC1O4PrGsUHzAriMTeGEusyCzVstb39RoEBQ=;
        b=fumBZq772rZRBSskxtpaOXuP0R5VbbfZPTXphGBowmb7uOhiMDrMVKVPJ9HSppCt48
         z22rYkDP32XXvbkzxE5YwioBxQOPNrrm5u8MlvfXa7ooYnaR12Cpo6S3Ne+n/isnmkTO
         VTfR7QNAUH2j/xlkKhOqlCin7dBhRzhK0ExjgUzVQOTMnhJkNFomS8Umyb+fzi4netE+
         yyaujFqFdXo/KGoLQyl6y3PTgrIBQP0rQsu5g6lHetmS5jwijAhzkACpN7JOPOwN+6Mg
         MuURfGPj1hg1el7/9YOGkVCq/NfK8CcZk59XgNcrGlK695M2kHpHtDDPj5c36iEGxI+R
         UHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945376; x=1742550176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/g4jvwbC1O4PrGsUHzAriMTeGEusyCzVstb39RoEBQ=;
        b=Co+UQb1TDnCZsnKMXm7P4z38VKelJVd9biMkL9aPHtsUhqI9WWsTND6m/fqh1yLt2Z
         4gwRgUVIjO2xtZgrXZBuyYnp4JfaePxSSAUw1GqqvOoQ56lFt92pWwETNuWkHezMbqTR
         I/JMUE1ccTtdNsfBp9Mi22cQw+uNWr3AevI4sZ/cGiWM6H3xanMftQJAJ+sPg8AQqFh+
         hOvdH4+ChOeJNoBgETzChzCJHM/KpG7qxO9FblgS0p561k8u17LI5kMUJ9s42KiN1PPn
         INrUTQNeEzIFY3+EI0i8rwfifPPo+Q7pxjRqCxE/ynT7xmAAY19yaE6aHjQCKOvWEUDp
         zSXg==
X-Forwarded-Encrypted: i=1; AJvYcCVDbK73RiQO8DQ3VTuP0VR9pRIeCKigJdpFLJFch//n5Es2yQfbZ2xQW7TcTjFxVrThEVsnMYduEiQwPVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMAF9GW162AboerapbNGuDuRPctEYoSq/SPFdxptsmHASTgul
	FGDC9nYYiXvvUdbsPWQOYPEmNL1H9SVV5e7qdFS3unrFcRDAIHfAjckqzGmdBQ==
X-Gm-Gg: ASbGncuB67CA2xPUl3EAHiOIAqK3CFJAF+59R+Z3gqvzIkFDysyCU3dPGxspW9/hn1t
	FdJ++0oplMkZThM+ayL5EGde3fcTUR+Z7rmIOXnoO97CVYjZVAY1CJOVOp1ENKGSnnEb51dPcWw
	ElW5RId+hjqC8i2kuweoo/fAbS9cfEMpaPuFGSI+g7KdOKwFWpmDw14+9IoITJ6ber5puIETrx8
	yEhg2WGJ3QnRpzzKwccnt2l7Ef0yewzR32ppdc83UWTtSpiRb5Cjojpce06NV3M0+EyQRYsqhHg
	9UnaXyHSCVuX4Qk/17pBmskB2A6GgoLszp4qxn+aNCfVUg/eXl55nH0=
X-Google-Smtp-Source: AGHT+IFginwr94K2rTnjMZOsPty3WsY3qokgFbh0zQNcqDH5+oZsyBDE/AucIHSnwboCC0ZejKNxcQ==
X-Received: by 2002:a17:90b:2707:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-30151ca0e05mr2548580a91.20.1741945376055;
        Fri, 14 Mar 2025 02:42:56 -0700 (PDT)
Received: from bytedance ([115.190.40.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afee51sm648521a91.28.2025.03.14.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:42:55 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:42:49 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
Message-ID: <20250314094249.GC1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>

On Fri, Mar 14, 2025 at 04:39:41PM +0800, Chengming Zhou wrote:
> On 2025/3/13 15:21, Aaron Lu wrote:
> > From: Valentin Schneider <vschneid@redhat.com>
> > 
> > Once a cfs_rq gets throttled, for all tasks belonging to this cfs_rq,
> > add a task work to them so that when those tasks return to user, the
> > actual throttle/dequeue can happen.
> > 
> > Note that since the throttle/dequeue always happens on a task basis when
> > it returns to user, it's no longer necessary for check_cfs_rq_runtime()
> > to return a value and pick_task_fair() acts differently according to that
> > return value, so check_cfs_rq_runtime() is changed to not return a
> > value.
> 
> Previously with the per-cfs_rq throttling, we use update_curr() -> put() path
> to throttle the cfs_rq and dequeue it from the cfs_rq tree.
> 
> Now with your per-task throttling, maybe things can become simpler. That we
> can just throttle_cfs_rq() (cfs_rq subtree) when curr accouting to mark these
> throttled.

Do I understand correctly that now in throttle_cfs_rq(), we just mark
this hierarchy as throttled, but do not add any throttle work to these
tasks in this hierarchy and leave the throttle work add job to pick
time?

> Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
> for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.

If we add a check point in pick time, maybe we can also avoid the check
in enqueue time. One thing I'm thinking is, for a task, it may be picked
multiple times with only a single enqueue so if we do the check in pick,
the overhead can be larger?

> WDYT?

Thanks for your suggestion. I'll try this approach and see how it turned
out.

