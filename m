Return-Path: <linux-kernel+bounces-233242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24691B4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A11C2132C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2381D12B72;
	Fri, 28 Jun 2024 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="w+LthBNe"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE21F9F5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538803; cv=none; b=s6X1FYHvLBn2kA5B+BGWNPnUynDCmtMcQEmhX3KaitB4N39eYlSVqtjCwdtTk/uFIicWtA+z5EoEnsof6eR2ktQJYCoYayhg5u5bT+2fV8nYGYtHhn6uCSo5oHrXqRzs7cwbdbfBNfLevDNbQzmKPIncMXqrCoD7DsI/GICF00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538803; c=relaxed/simple;
	bh=nuzBnK6u0gOR1Y/5fr+lqnZyDYNnlgKv1Usen658WFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2idYpeProScYG4Is535Iuc0aNXT1M34vCSYMJowwyn03uijajNkxN9jXc7cavGqYPNvcNFvecpiLnV2OLSpIm+Yz7rFzuwaDB9BipT3DPFNzIMnZQ7yHR5NZvAOOPqH66ONbhZ1U048NHHCPV5sRjDg5bulwwonskqRBzwrCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=w+LthBNe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3626c29d3f0so25536f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1719538799; x=1720143599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DloQEiwrEccgpDXWzKbcfvlYoNF25kWonkWu7VDpFI4=;
        b=w+LthBNeDCeoPsU74pxrI6jTsLcEXx8LA6DRRosyPvzfgy1DzeoBJYD8JGLy4+6s98
         J3HEp+TBzXd1TRBo+UYxijdKOpaKQr/EAlIcoue2ZI3DeZvjlm4Vkrjpsf0dJUPW72DG
         S4gfTcn4ZQ3y51XaiQUqop8l2pDL75nWJZw3ubJpQADjMRSHNFON3utC3/rlku/IFHsA
         wVeG+zLgmS0OdSpxxtjX3sFHGH7YDFX3GLCH9PH9tqZusufKdFCSp2GKJus+rrCYTE9m
         RdQmZ/cmxAHmQssXihh//rZzqBDxmghMqOwTe9eNreED04kbiOz/jEA/6IpcUT28CQ0c
         jN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719538799; x=1720143599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DloQEiwrEccgpDXWzKbcfvlYoNF25kWonkWu7VDpFI4=;
        b=S64tahn3yoH+HMA/e9hs2UGVPxpymmrj9ltVR8o+3z3v5+rqCKrjvqZT9BwyX+UCcW
         TVqVG4gMqWIrLeNz1TH1qt6lIu8+9q6m7NZruYxzJkCwhareHKjv6ocMUUXnGDBoAB63
         0QnyU1zxSedlp6mIn6xadSmEQyggQVPhALRUnirVGPBYX1CBqRM6Pbol5TcT/RpYPn8M
         oRHZyAzJGDGZCu95RNAl72+7bTFIHcvVV+wB03+BdX9u4Pc/WJeIqu6Zgd4C43uImY4n
         KmDYOZ8C0Bma5IHGbdJKtKayT+OCDgWD5W1z6aLbDjez1oh3mNLzpq6Q3UHeo8EDX5uH
         uZyw==
X-Forwarded-Encrypted: i=1; AJvYcCWNvi7XHUV4HKopjlTTd9EWEm4B8PEMarsoiYD4CSF9MUsCr7D52ZDuSwIdsHPoiI0e06WKWwhjJzvu1lFh4h5bpI9BxppZiv7bWRay
X-Gm-Message-State: AOJu0Yxij8LgpEiDGe/pFMDpJyUe8CkGboYUAG1YvTcftwMtTmzokX8K
	yO5iKIx4ZSOtdPECqjvMJER+rxxEST101tWJr3IpSpEITAPmnuUF86djhc9QD/M=
X-Google-Smtp-Source: AGHT+IEppKX2WnxqOz/LEoFTGfLFKwT3XHefFCeOSZCWAWsVtgMkl7c0dwxPJn6T8/j4Pmjevh4OWA==
X-Received: by 2002:a05:6000:1212:b0:362:3730:8762 with SMTP id ffacd0b85a97d-366e948fa69mr10567742f8f.24.1719538799267;
        Thu, 27 Jun 2024 18:39:59 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e1345sm746157f8f.54.2024.06.27.18.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:39:58 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:39:57 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
	dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	christian.loehle@arm.com, vincent.donnefort@arm.com,
	ke.wang@unisoc.com, di.shen@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240628013957.ocqatra72fxlon4u@airbuntu>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-2-xuewen.yan@unisoc.com>
 <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com>
 <CAB8ipk-yAoX5EJ975ZVKfgZP7rP-vzuc3bLVr6yiLtMv26Lxjw@mail.gmail.com>
 <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>

On 06/27/24 18:15, Vincent Guittot wrote:
> On Thu, 27 Jun 2024 at 04:02, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 9:05 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Mon, 24 Jun 2024 at 10:22, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> > > >
> > > > Commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
> > > > changed the PD's util from per-CPU to per-PD capping. But because
> > > > the effective_cpu_util() would return a util which maybe bigger
> > > > than the actual_cpu_capacity, this could cause the pd_busy_time
> > > > calculation errors.
> > >
> > > I'm still not convinced that this is an error. Your example used for v1 is :
> > >
> > > The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> > > of cpufreq-limit, the cpu_actual_cap = 512.
> > >
> > > Then the eenv->cpu_cap = 512, the eenv->pd_cap = 2048;
> > > effective_cpu_util(4) = 1024;
> > > effective_cpu_util(5) = 1024;
> > > effective_cpu_util(6) = 256;
> > > effective_cpu_util(7) = 0;
> > >
> > > so env->pd_busy_time = 2304
> > >
> > > Even if effective_cpu_util(4) = 1024; is above the current max compute
> > > capacity of 512, this also means that activity of cpu4 will run twice
> > > longer . If you cap effective_cpu_util(4) to 512 you miss the
> > > information that it will run twice longer at the selected OPP. The
> > > extreme case being:
> > > effective_cpu_util(4) = 1024;
> > > effective_cpu_util(5) = 1024;
> > > effective_cpu_util(6) = 1024;
> > > effective_cpu_util(7) = 1024;
> > >
> > > in this case env->pd_busy_time = 4096
> > >
> > > If we cap, we can't make any difference between the 2 cases
> > >
> > > Do you have more details about the problem you are facing ?
> >
> > Because of the cpufreq-limit, the opp was also limited, and when compute_energy:
> >
> > energy =  ps->cost * sum_util =  ps->cost * eenv->pd_busy_time;
> >
> > Because of the cpufreq-limit, the ps->cost is the limited-freq's opp's
> > cost instead of the max freq's cost.
> > So the energy is determined by pd_busy_time.
> >
> > Still the example above:
> >
> > The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> > of cpufreq-limit, the cpu_actual_cap = 512.
> >
> > Then the eenv->cpu_cap = 512, the eenv->pd_cap = 2048;
> > effective_cpu_util(4) = 1024;
> > effective_cpu_util(5) = 1024;
> > effective_cpu_util(6) = 256;
> > effective_cpu_util(7) = 0;
> >
> > Before the patch:
> > env->pd_busy_time = min(1024+1024+256, eenv->pd_cap) = 2048.
> > However, because the effective_cpu_util(7) = 0, indeed, the 2048 is bigger than
> > the actual_cpu_cap.
> >
> > After the patch:
> > cpu_util(4) = min(1024, eenv->cpu_cap) = 512;
> > cpu_util(5) = min(1024, eenv->cpu_cap) = 512;
> > cpu_util(6) = min(256, eenv->cpu_cap) = 256;
> > cpu_util(7) = 0;
> > env->pd_busy_time = min(512+512+256, eenv->pd_cap) = 1280.
> >
> > As a result, without this patch, the energy is bigger than actual_energy.
> >
> > And even if cpu4 would run twice longer, the energy may not be equal.
> > Because:
> >  *             ps->power * cpu_max_freq
> > *   cpu_nrg = ------------------------ * cpu_util           (3)
> > *               ps->freq * scale_cpu
> >
> > the ps->power = cfv2, and then:
> >
> > *                  cv2 * cpu_max_freq
> > *   cpu_nrg = ------------------------ * cpu_util           (3)
> > *                    scale_cpu
> >
> > because the limited-freq's voltage is not equal to the max-freq's voltage.
> 
> I'm still struggling to understand why it's wrong. If the frequency is
> capped, we will never go above this limited frequency and its
> associated voltage so there is no reason to consider max-freq's
> voltage. If there is more things to do than the actual capacity can do
> per unit of time then we will run more than 1 unit of time.
> 
> nrg of PD = /Sum(cpu) ps->power * cpu-running-time
> 
> ps->power is fixed because of the limited frequency constraint
> 
> we estimate cpu-running-time = utilization / ps->performance
> with
> - utilization = util_avg
> - performance = ps->freq / cpu_max_freq * arch_scale_cpu_capacity() =
> ps->performance
> 
> Up to now we were assuming that utilization was always lower than
> performance otherwise the system was overutilized andwe fallback in
> performance mode. But when the frequency of a cpu is limited by
> userspace or thermal mitigation, the utilization can become higher
> than the limited capacity which can be translated by cpu will run
> longer.

I might have contributed a bit to this confusion. So my apologies.

We certainly want to remove this limit and I thought to be consistent with
current code behavior it might be good to have this patch. But as Vincent
pointed out it actually moves us backward.

So I think this is no longer needed too. We want to actually make the pd
capping removed too - but I haven't looked at the detail if this can be done
without side effects. We need to be more accurate in estimating the runtime and
capping in general hides information about how long the cpu/pd will be busy
for.

