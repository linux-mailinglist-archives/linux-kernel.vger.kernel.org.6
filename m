Return-Path: <linux-kernel+bounces-388906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C69B65F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F09B23FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0E1F1301;
	Wed, 30 Oct 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vx3ilog5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA79B672
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298623; cv=none; b=J4/HnE2pZpJ79SqigXpm3Olatc9sAfj6Lbo/1GnIWYp8+BdMi6VWZOaEpjpuehR1bxSTWV/KWF5AoVBugmPpPRLvscWM1ViiLqS0i3Us7M3uPOvc1Q8XBUYP+QeVAssYumHc2+MsKp0mx5RKd7d9pW2qVE3rW8VNHZpPyVfNLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298623; c=relaxed/simple;
	bh=tCxOVAtri6SI3GLq7IRBGJhxlLkGVKJd2rKYm8ogUfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMrK/kFQmAy18EBqpLj3flMIDQwR2GwXcbkH1ed9Rtpi3kCD/VAV2S3IXQm0PLMv/b7E6glyG76GVk4tr15Y++9cfWE2nSx2Yu4y6XcQtyRaezWtqtG0XKWRGPHEqvd3FFS+MOCVGOVqJ2M3kdTNc9MeUQ++EjQOdG8da9GJ1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vx3ilog5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730298620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoMsgj5+7GMmTtrQl6iW6QZGad7SV15Glaq2I5HTvfw=;
	b=Vx3ilog5urIfItE+k5CBkob3UCm6ojilI2cft2nSoPL0mjsZKBsmPH4I8d1BDrw70jsLTG
	aKFfchuwF9KtOuGJBqcXIFr2hQxa53jpk/buUcli/SwkTVleTuqqyO6RLWUQzYYLTvKtrg
	smNlXhDVcuMfmvAKcudArdaQBTRYfEU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-fwAEvx8QMMmHvkeEBHQ8WQ-1; Wed, 30 Oct 2024 10:30:17 -0400
X-MC-Unique: fwAEvx8QMMmHvkeEBHQ8WQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d603515cfso3027712f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298616; x=1730903416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoMsgj5+7GMmTtrQl6iW6QZGad7SV15Glaq2I5HTvfw=;
        b=SCa7/DSzuNIkbUT2IsM4DhEsafDQVVHbxnvsjz0hzkR2NvZ0BpxzSxo1ZElrynaoeB
         c62fcXfdrftsiXziHxKJn6CnYGcIBChgkvI099sKlWXvgfUGntt7iVO0itaUdpQl9MKw
         GiQKsmZ/W/xjjnCLXid41RsbBByTAToWicj/SxnVi15ai5k80dmLTgdR4c0u5ZyM0fbW
         pzEkEaIk5+Nupo4unIuH4TCfEATnYKIesoLHExaM+kFXurmv/turSSZy0GWh1d/+ivW0
         b7VH6o5+/wRkrqpzwL0VFpZeMm0lVtd1E5f6xEbwaarMDT/x8k7ccDkdTOFLVYHlP04o
         zvCg==
X-Gm-Message-State: AOJu0Yyl7tpEBaGSqyQswgiUVPIYJ6wPObbGwW6wTD72OGD9eylkzwCI
	aLKZbWvfn3SA/LSWlsXmOTBK4IGY28TbqxCvgG8yO5WPM7DISRnqDAdeFh+leEG4dIeD98AgZ/+
	1ibdgdoMsCg6oUOrCAUPKYKTOyNIqwgyngBzLw03FzVAyO/DSb8E91Y8QovDrog==
X-Received: by 2002:adf:fd0a:0:b0:37d:2ceb:ef92 with SMTP id ffacd0b85a97d-38061162d5amr11170159f8f.27.1730298615997;
        Wed, 30 Oct 2024 07:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdo16YN0xMZ116nFeuY1zrzzJPjDJX5d3Xcla2/WNHCCi4GXGUA9WScud3qFUn3CYqq56xjQ==
X-Received: by 2002:adf:fd0a:0:b0:37d:2ceb:ef92 with SMTP id ffacd0b85a97d-38061162d5amr11170134f8f.27.1730298615588;
        Wed, 30 Oct 2024 07:30:15 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c4a1sm15396531f8f.16.2024.10.30.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:30:14 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:30:12 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029225116.3998487-1-joel@joelfernandes.org>

Hi Joel,

On 29/10/24 22:51, Joel Fernandes (Google) wrote:
> During boot initialization, DL server parameters are initialized using the
> default root domain before the proper scheduler domains and root domains
> are built. This results in DL server parameters being tied to the default
> root domain's bandwidth accounting instead of the actual root domain
> assigned to the CPU after scheduler topology initialization.
> 
> When secondary CPUs are brought up, the dl_bw_cpus() accounting doesn't
> properly track CPUs being added since the DL server was started too early
> with the default root domain. Specifically, dl_bw_cpus() is called before
> set_cpu_active() during secondary CPU bringup, causing it to not account
> for the CPU being brought up in its capacity calculations. This causes
> subsequent sysfs parameter updates to fail with -EBUSY due to bandwidth
> accounting using the wrong root domain with zeroed total_bw.
> 
> This issue also causes under-utilization of system capacity. With the fix,
> we see proper capacity initialization and scaling as CPUs come online - the
> total system capacity increases from CPU 0 to CPU 1 and continues scaling
> up as more CPUs are added (from cap=1024 initially to cap=8192 with 8
> CPUs). Without the fix, the capacity initialization was incomplete since
> dl_bw_cpus() runs before the CPU is marked active in set_cpu_active(),
> leading to CPUs not being properly accounted for in the capacity
> calculations.
> 
> Fix this by tracking the last root domain used for the DL server and
> resetting the server parameters when the root domain changes. This ensures
> bandwidth accounting uses the correct, fully initialized root domain after
> the scheduler topology is built.

So, I'm trying to reproduce this issue, but currenlty not really seeing
it, sorry.

I'm on a 40 CPUs box and, even if I fiddle with hotplug, the numbers I
see from debug (bw, total_bw) seem sane and consistent with the fair
server settings.

Could you please provide additional info about how you reproduce the
issue? Maybe you have a test script around you could share?

Thanks!
Juri


