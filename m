Return-Path: <linux-kernel+bounces-425672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1E9DE8DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03F9282D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD41448E0;
	Fri, 29 Nov 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5hWYv1m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB284D3E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891505; cv=none; b=HMZex1XE5pqXb7+dI0qXB/CMgnCp4eN77JwHehA+i/gFMKzuID0eSIQ5e6F5kFSfRNu/vx05Qbxjd27rG5oRYwIjTDit0Q9eR3dPr/h6DfUTX7Jx52CglbbJ3+ehNKynobwfTCjDZwWpaaCfbCGyQDomM8GhIy8FqVG9OXtpHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891505; c=relaxed/simple;
	bh=L7gwidp26nVgyFhrYv06puEPI8/tExyUP1V8hCEscnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr3euQUMZhcfvwCT1gyXkxPz1OhEtlTWzwX1cwvwNTTesxh7xcUp1KrkjqZDdzQ1iJjkQoUoTPmaEhL/pCifhNfA5uYTETflk8hrOQB44/lB5nlUDmjMsuW7XTS3T4o9tHpGqRRb6iwqMtNAJ27Wmp/hX+hA1wftNca3f00CoZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5hWYv1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732891502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjg4MUuhzdXRT3Uv4ig93e6KSuECA/RIgomlgIgm41E=;
	b=I5hWYv1m2aeZ8s7kIbymIDBfy8yUHH04sn21rHFDM++IbeV7DH43M6JLiPBNcXQU+ioWfJ
	DykLMDkJwimOBRi7POd3KefUDoKXwsjqKRwbT8/eC257pY4fa54AuH3a4hScZirQFVzzZp
	hq+otT0EMxApS564oxRobzQHkvI5Ijo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-ho-VXegJNAi8CbwHCWCRSQ-1; Fri, 29 Nov 2024 09:45:01 -0500
X-MC-Unique: ho-VXegJNAi8CbwHCWCRSQ-1
X-Mimecast-MFC-AGG-ID: ho-VXegJNAi8CbwHCWCRSQ
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d3a07b63e6so26963836d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891500; x=1733496300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjg4MUuhzdXRT3Uv4ig93e6KSuECA/RIgomlgIgm41E=;
        b=jLQfuHNcJVmTco3VJ/GgzFP6x5A914ZFVCsANvdy6DIz5Sxr3I23WmiCOO5LNAGVdn
         UBgSwVxeEebfZl++K55hayVIzA1ffNUFMnoR7LaHIJ1yO/rkkR0y8iHjStlhr4YEtNov
         EFqvYj7aFORxYDmEpbZezpBJ6N4CstEqxcdrr3tfT7hQft/BrgOruPODaUslBwsLxI5Z
         9HmtlIUUCiJniJWdRXZ3vIt8CON2bNq9h/bbYr5r4OvdhQYcQ4JbS77WWwZEsT77E2GB
         fa18f2Ymx5c6RQugWB3kIdmfHZrVi8rLymJQekw0FsXyJM1wSCYRCNW7xb1FWe3dBV2y
         2wtA==
X-Forwarded-Encrypted: i=1; AJvYcCWFJ0zzQogbGwk8H1U5V0ppii/8AWo/Tz8z5kv8KnLnq9kAdmAXbjOrcXuw8Ye+82VCeoaQOTQe7X6aIyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnm8/61EM7CSRsNqrvq8kswhxj2uxkWpj8Y3UoJrx+1aKutL+D
	F607iClph9aRwjMHRy1GMg0M6KsCesxM1uuzwk6fkWVA5GpiuaNJ10wNcn1wz5ureJLGq66Pn+4
	N0JToV9KUG6Dvvz3q9YjqEyisaTvt4e5gSnqp1O+rT3kihBjvwamJ1DP7h/P/jkpwmgj2GQ==
X-Gm-Gg: ASbGnctKCvhUi3I6zPzSRdDB9OKdSf7Hy44jOoJudBrYRzvKf5tH1OaSP5zj53Yj5lQ
	dhSV7roOI7DTRHL7w0BS7T031Dwzi/6cGQKNlgjqe2OO3dfEWFH94ncN3kn4r9ly/H756xuByjs
	2OCaOm0lZydvKulokuMNxfNOijSpS2nGEke35AZqpwTXMMiRFl93u0ndClPY1I8BLTtHQeKTrn9
	u3FGfBWGLPPZ7+bEc9ezV80RSmDckqWNAetGNVxBS2IqnBvdtijNFJOqFAwQDa9Q510HnZknRE/
	HoA=
X-Received: by 2002:a05:6214:2489:b0:6d4:1e43:f3a3 with SMTP id 6a1803df08f44-6d864d2094emr158930766d6.13.1732891499990;
        Fri, 29 Nov 2024 06:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1aWHyuoj7GndsmzSMvg/xzPIFTOsQpK+Hj97TLrzyhWc/YBW0neOGRM6ymhgqq1PQGCRxQw==
X-Received: by 2002:a05:6214:2489:b0:6d4:1e43:f3a3 with SMTP id 6a1803df08f44-6d864d2094emr158930366d6.13.1732891499659;
        Fri, 29 Nov 2024 06:44:59 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d887b7a98csm5155396d6.36.2024.11.29.06.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 06:44:58 -0800 (PST)
Date: Fri, 29 Nov 2024 15:44:53 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH V7 9/9] sched/rt: Remove default bandwidth control
Message-ID: <Z0nTZXHDggHD8raj@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1716811043.git.bristot@kernel.org>
 <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
 <d3bllrfwji74t3ix3jcdlvdt6jdorw75wjol6kmadpeuuqal2t@io7ghgf7zkbs>
 <Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.remote.csb>
 <tjsas6vkv3xegcgmranxmnkrt46xuitp553caz6vvtgpfrbwl3@252nbydvxaqt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tjsas6vkv3xegcgmranxmnkrt46xuitp553caz6vvtgpfrbwl3@252nbydvxaqt>

On 29/11/24 11:02, Michal Koutný wrote:
> On Wed, Nov 27, 2024 at 04:35:39PM GMT, Juri Lelli <juri.lelli@redhat.com> wrote:
> > > The default DL bandwidth is thus is 95%. The fair server is given 5%.
> > > Is that 5% of those 95%?
> > 
> > Yes, it is indeed.
> 
> Thanks for navigating me. I have followup questions about
> /proc/sys/kernel/sched_rt_runtime_us / /proc/sys/kernel/sched_rt_period_us
> (a ratio, without CONGIG_RT_GROUP_SCHED)
> 
> - 0
>   - disables DL, (not RT, so they can monopolize a CPU)
> - 1
>   - DL tasks can monopolize CPU, SCHED_NORMAL have 5% thanks to
>     fair_server
> - 1-Δ
>   - SCHED_NORMAL tasks have
>     - (1-Δ)*5% on behalf of DL (above RT)
>     - Δ regularly (below RT)
> 
> Is this breakdown correct?

So, sched_rt_runtime_us/sched_rt_period_us only applies to admission
control (for DEADLINE tasks, including dl_servers). The actual
parameters controlling the dl_server for SCHED_NORMAL are under sched/
debug as per-cpu values, e.g.:

# grep . /sys/kernel/debug/sched/fair_server/cpu*/*
/sys/kernel/debug/sched/fair_server/cpu0/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu0/runtime:50000000
/sys/kernel/debug/sched/fair_server/cpu1/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu1/runtime:50000000
/sys/kernel/debug/sched/fair_server/cpu2/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu2/runtime:50000000
/sys/kernel/debug/sched/fair_server/cpu3/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu3/runtime:50000000
/sys/kernel/debug/sched/fair_server/cpu4/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu4/runtime:50000000
/sys/kernel/debug/sched/fair_server/cpu5/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu5/runtime:50000000
/sys/kernel/debug/sched/fair_server/cpu6/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu6/runtime:50000000
/sys/kernel/debug/sched/fair_server/cpu7/period:1000000000
/sys/kernel/debug/sched/fair_server/cpu7/runtime:50000000

You can disable admission control by echoing -1 in sched_rt_runtime_us,
but still have the dl_server working for SCHED_NORMAL tasks. By
disabling admission control SCHED_DEADLINE can indeed monopolize CPU
(over subscription).

Best,
Juri


