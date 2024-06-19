Return-Path: <linux-kernel+bounces-221587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B1990F5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D741F22349
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA6156F3C;
	Wed, 19 Jun 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="g428By9w"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37161DA24
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820626; cv=none; b=nnxnyKKubB/L5CZ2WDtVt2EnYmKeFSrLHDhnCzyF8PzIQB3Uea5L2WGUHhI0QfUcWfrFIx5p4Oo6d8rpTdrRd4x1FlhD7hYTn/zAJnc9JaDePMq7WXJDcTaoDOLFdESK/q04lsAE8NUkNEwDaXjba3oqKoKc41oKX32/h3Xf+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820626; c=relaxed/simple;
	bh=0L4VujmjvSUQ8D/8+DlcznwaTpLuE26NtOHnp5kTabY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeRk92FmjZxeVKQQjAUkY3NShrtCKj11nWeGb+u2nymVUP/+gGMDOczRF0JUsQZ9+J55tnv6RoG0auIDMzRMdavEiaysbm8YLXL6eu2/xKkwjyPpJ1AYBIloFrWhGsSAZ+MgAWj1AtPsfxZIdzxlIUWswuHLyDFRT3ZT/GPWsd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=g428By9w; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4217990f997so709735e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718820623; x=1719425423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ya2SP98G80gF4POSRdCxM06GYnHhJ1Zhxaj6yinM5hc=;
        b=g428By9wpA6Ny9ZhvIz1DiUDpLUmvHOPpEuyHkKICqZj7jcfxDD4IQy7THWiqLRtbe
         ZnJXwrqBuSroyhQIcut46tSwZ6uhVj7gpPYYQadICzkMULuN9B8u8NHI3cZRgxGaYYbN
         +eAg907RKIvVmEYXdMoE1vPiguf/R7oT7U0loYR/JDsBpjsMihuNuaSnETGUsHn+O/GV
         +Z87Z1nYfK2z2YiEFzzJmpzjpeVc986p/+Tga0jbruwKGed8QvwKB1JZS/ZfhDndLK0e
         HzkYTVPN4kXnvIZUw+OH3H49fepR3pv9YF+8GRQUn3QVp6yAMbwqFJiEV0UfqOJnrgUk
         GG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718820623; x=1719425423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya2SP98G80gF4POSRdCxM06GYnHhJ1Zhxaj6yinM5hc=;
        b=fqYMu+k7TKaGO/GB5zMNnr099UdHp4x3+bsvACNTls6a85eZTKe1K6m1o0MgXe9OAm
         7KHqKZ7aggbNKp6isNJ7eVmb6xoc25i94Ii7mNGp5Zn4+Y0/OmQQV1vyMYFsy75kBkfA
         BP2QiEalqyjOyQz4LEBg04/Dj/gWNc3czsz7K7mhhUZmAZQmAnVg+q9V4GU+CcyeOR5q
         eb9qgKDx9jIlSM/SiFechR38UCiVtL0+u86mHbRksoOvsRQ56XmBU6f5Atj7tJ1foSqx
         jHb71GUDl2srFY93BGjukKHZ6JVrBnPlV2glbYqDT3VKT60yiXMX/zXShNfd2kJaJ7uw
         zHLg==
X-Forwarded-Encrypted: i=1; AJvYcCVfAtxzBIqxNhJQpwaHFzsi5bp44rcJug7FKkmzGr1QoOMIEmZzEGgsecdM6hzLE2VTYumW53Pfdt68jgzyDUeRIUudxZJRl6/kj4TL
X-Gm-Message-State: AOJu0Yz2hzwO81RTJug+vlIOH/M3HstBg7YCY0Snhb6xmhfohk4tvi2h
	XAIFlRpuOluz2v4+y8uTweVk6vecXfaFjOM2/XNrwwUWMlI/7a0Xe6btiecMCiM=
X-Google-Smtp-Source: AGHT+IH6d5gJc8B9ja8zpNVoAjR9hxoMamP6Brf+vsuomiK1MFsd/M3qYWReZRuunW4YBbsxpejGFw==
X-Received: by 2002:a05:600c:211a:b0:416:7470:45ad with SMTP id 5b1f17b1804b1-42475182a8fmr22281335e9.17.1718820622993;
        Wed, 19 Jun 2024 11:10:22 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a5b4sm237858165e9.41.2024.06.19.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:10:22 -0700 (PDT)
Date: Wed, 19 Jun 2024 19:10:21 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240619181021.kxcjxaqe47fkve42@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
 <20240617105348.ebtony3ciwxhvj2w@airbuntu>
 <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>
 <20240618153931.ub5ezml3imd5mwu7@airbuntu>
 <CAB8ipk86jmb6xnEUnv_Vs5=A5EnNfnHTy3FXYZRhKhuEFKhzDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk86jmb6xnEUnv_Vs5=A5EnNfnHTy3FXYZRhKhuEFKhzDw@mail.gmail.com>

On 06/19/24 11:05, Xuewen Yan wrote:
> On Tue, Jun 18, 2024 at 11:39 PM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/18/24 17:23, Vincent Guittot wrote:
> > > On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 06/17/24 11:07, Vincent Guittot wrote:
> > > >
> > > > > > And should effective_cpu_util() return a value higher than
> > > > > > get_actual_cpu_capacity()?
> > > > >
> > > > > I don't think we should because we want to return the effective
> > > > > utilization not the actual compute capacity.
> > > > > Having an utilization of the cpu or group of cpus above the actual
> > > > > capacity or the original capacity mainly means that we will have to
> > > > > run longer
> > > > >
> > > > > By capping the utilization we filter this information.
> > > > >
> > > > > capacity orig = 800
> > > > > util_avg = 700
> > > > >
> > > > > if we cap the capacity to 400 the cpu is expected to run twice longer
> > > > > for the same amount of work to be done
> > > >
> > > > Okay makes sense. Wouldn't the util be 'wrong' (to what degree will depend on
> > > > min/max freq ratio) though?
> > > >
> > > > We cap with arch_scale_capacity() still, I guess we know at this stage it is
> > > > 100% wrong if we allow returning higher values?
> > >
> > > I think that capping utilization to max capacity generates some energy
> > > estimation error because it filters the fact that we run longer in
> > > some cases.
> >
> > Yes, I think so too and that was my first statement. But I think this is
> > a bigger change to do separately.
> 
> I saw the the sched_cpu_util() was used by teo.c and cpufreq_cooling.c
> If we change the arch_scale_capacity() to actual_cpu_capacity(), it may cause
> some errors?

The plan to revert this now.

> 
> For-example:
> In teo:
> 212 static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> 213 {
> 214         return sched_cpu_util(cpu) > cpu_data->util_threshold;
> 215 }
> It may cause the teo_cpu_is_utilized() to return false forever if the
> actual_cpu_capacity is smaller than util_threshold.
> However, the util_threshold is frome actual_cpu_capacity.
> 
> In cpufreq_cooling.c:
> May we should change:
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c
> b/drivers/thermal/cpufreq_cooling.c
> index 280071be30b1..a8546d69cc10 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -164,7 +164,7 @@ static u32 get_load(struct cpufreq_cooling_device
> *cpufreq_cdev, int cpu,
>  {
>         unsigned long util = sched_cpu_util(cpu);
> 
> -       return (util * 100) / arch_scale_cpu_capacity(cpu);
> +       return (util * 100) / get_actual_cpu_capacity(cpu);
>  }
>  #else /* !CONFIG_SMP */
>  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> 
> 
> Because if still use arch_scale_cpu_capacity(), the load pct may be decreased,
> It may affect the thermal-IPA-governor's power consideration.

I am not sure about this one. But looks plausible. Vincent?

