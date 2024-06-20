Return-Path: <linux-kernel+bounces-222519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE39891032D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C5B21C92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3D51AC220;
	Thu, 20 Jun 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1YW52pZM"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A51AB348
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883481; cv=none; b=lUuJPpuXdBSqBbwsjWp8AR23bc1oEDv8PREGez2PAmShtXnKIuOqaQNDFc8dIx2E1iKNK6h1nsCJuMaMJieY0IMcLOSfEOWV0wShL8RtEaSnoEaMexyzacyMcxj1XUf6SX5S6TZGQbLRWShruh/8Fb9XGmKISSnm6CtvfIksem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883481; c=relaxed/simple;
	bh=uEJhvu8fzPC4PSoe/E8zz4EUUT2P+BK8BnrCyfWBU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buo3uF/rDaQ3p+WnFeHtYoK8h7wHgEpPu4/3fSSyokCCk/Nxbqf8ukU4/0dsxiZIVGLar3FpW/hSEKVcM1rLBJz2zyR/0Hi2ubOrrY36ju7VqAn2hVtlWvrSiDQXt0x1P7NlMXfltx/OCE890Lb5Th9ZlRWlgHlafrHbbRU4i7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=1YW52pZM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so463259f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718883477; x=1719488277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCnjWEyD9WBkYq7artgdPMIA5NoMclz8P8IrmGj5qf4=;
        b=1YW52pZMyCg4phmW+6g44mXsMbhUhKFiwRK/KVYVTxt8I+C3K/+OL+AWE45495rUn1
         kv/oLUEs8GVP6XvK9D8QCGR9Zj2/r+mZoKtfbZVRPwfsvLjqeIqy18r19DsT1K7n0Qgh
         fjS8aFMF0yMIM16o4zOeyNVv8sJfwxAjXw5Fz/EUnITkkjHWT9LIO5Ttgf6xHFKrf4SZ
         on8SWJOqw2mqvTKMD+9KOMKL+owEtLBGS9M9zIql3l5bMdjNqvBZF5kyYTsyx86Wd4Qv
         +4x3KN6mj++omH7NSGTohMF3ycrWJiih2DxE4IFGFlu4u9H5AiLzykMlkclFsoN/PCi8
         XYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718883477; x=1719488277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCnjWEyD9WBkYq7artgdPMIA5NoMclz8P8IrmGj5qf4=;
        b=e/EfMTHgqnuQ9neCk3PRkdZ6IQmN6NuImkd7dNno/xqr0DipCaJFdCUJtjhhMZU7Qx
         bMMWOZbrMNuFre7YMO1YeHHc5EjiU9uBCSMKXrV0V1qktsoEaiFEq5fTTfPspWvTSztI
         X1y2kXAs5PoUh1M2kKFrDlYtJNg+08xnUQo1DK0v2zuijsLnpRU518Czbp9YS3T2kLjb
         qYp71UyXCWKXj6tQ9Fxr2gjPcYBgaPfGwdMavn89dZM+a3GOWoKOe05XNdSn492X2cGt
         9YusYO/o7bw4w6Wti65FCau5uhJ0jyQsIuHZ9km44JBRdN0w+H1+Eu4kYiWcybA2X5Uw
         odIA==
X-Forwarded-Encrypted: i=1; AJvYcCWV7+/7Lc0IcBM+Mrs9fV5f/vWlkBdy/A6i1iSdkH6YzZeSwdET3qGqd6gw2osa67snPXuxwbO1+BYvK4XsmOE+cizFbWnYT4DTlbL8
X-Gm-Message-State: AOJu0YzhSA9+lBe1JyIvoxL+AyqjednBcyQrxGriP+exiMiX7t4MPWlh
	IttgDEahuHaSCys0xJALe2km5JyAe5rFEcip3sNlUHqqCgkzccEOGNTkg+Vb8jM=
X-Google-Smtp-Source: AGHT+IEuKefN6nv7mpYin/L6Hi/6H1uD+shMsb2txPqF1Z+Ax9sBrqjFuW/BZV1/TT17yM/fh360ig==
X-Received: by 2002:a5d:6e8b:0:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-3609ea612f5mr9158060f8f.13.1718883477367;
        Thu, 20 Jun 2024 04:37:57 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54c9sm23252335e9.27.2024.06.20.04.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:37:57 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:37:56 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240620113756.hivzk7sj4uj4sm6j@airbuntu>
References: <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
 <20240617105348.ebtony3ciwxhvj2w@airbuntu>
 <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>
 <20240618153931.ub5ezml3imd5mwu7@airbuntu>
 <CAB8ipk86jmb6xnEUnv_Vs5=A5EnNfnHTy3FXYZRhKhuEFKhzDw@mail.gmail.com>
 <20240619181021.kxcjxaqe47fkve42@airbuntu>
 <CAKfTPtA1cKiB=mv-QUAYOLtiwOE+Rcg+HkAirkVW=irTQtqNVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtA1cKiB=mv-QUAYOLtiwOE+Rcg+HkAirkVW=irTQtqNVw@mail.gmail.com>

On 06/20/24 09:45, Vincent Guittot wrote:
> On Wed, 19 Jun 2024 at 20:10, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/19/24 11:05, Xuewen Yan wrote:
> > > On Tue, Jun 18, 2024 at 11:39 PM Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 06/18/24 17:23, Vincent Guittot wrote:
> > > > > On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wrote:
> > > > > >
> > > > > > On 06/17/24 11:07, Vincent Guittot wrote:
> > > > > >
> > > > > > > > And should effective_cpu_util() return a value higher than
> > > > > > > > get_actual_cpu_capacity()?
> > > > > > >
> > > > > > > I don't think we should because we want to return the effective
> > > > > > > utilization not the actual compute capacity.
> > > > > > > Having an utilization of the cpu or group of cpus above the actual
> > > > > > > capacity or the original capacity mainly means that we will have to
> > > > > > > run longer
> > > > > > >
> > > > > > > By capping the utilization we filter this information.
> > > > > > >
> > > > > > > capacity orig = 800
> > > > > > > util_avg = 700
> > > > > > >
> > > > > > > if we cap the capacity to 400 the cpu is expected to run twice longer
> > > > > > > for the same amount of work to be done
> > > > > >
> > > > > > Okay makes sense. Wouldn't the util be 'wrong' (to what degree will depend on
> > > > > > min/max freq ratio) though?
> > > > > >
> > > > > > We cap with arch_scale_capacity() still, I guess we know at this stage it is
> > > > > > 100% wrong if we allow returning higher values?
> > > > >
> > > > > I think that capping utilization to max capacity generates some energy
> > > > > estimation error because it filters the fact that we run longer in
> > > > > some cases.
> > > >
> > > > Yes, I think so too and that was my first statement. But I think this is
> > > > a bigger change to do separately.
> > >
> > > I saw the the sched_cpu_util() was used by teo.c and cpufreq_cooling.c
> > > If we change the arch_scale_capacity() to actual_cpu_capacity(), it may cause
> > > some errors?
> >
> > The plan to revert this now.
> >
> > >
> > > For-example:
> > > In teo:
> > > 212 static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> > > 213 {
> > > 214         return sched_cpu_util(cpu) > cpu_data->util_threshold;
> > > 215 }
> > > It may cause the teo_cpu_is_utilized() to return false forever if the
> > > actual_cpu_capacity is smaller than util_threshold.
> > > However, the util_threshold is frome actual_cpu_capacity.
> > >
> > > In cpufreq_cooling.c:
> > > May we should change:
> > >
> > > diff --git a/drivers/thermal/cpufreq_cooling.c
> > > b/drivers/thermal/cpufreq_cooling.c
> > > index 280071be30b1..a8546d69cc10 100644
> > > --- a/drivers/thermal/cpufreq_cooling.c
> > > +++ b/drivers/thermal/cpufreq_cooling.c
> > > @@ -164,7 +164,7 @@ static u32 get_load(struct cpufreq_cooling_device
> > > *cpufreq_cdev, int cpu,
> > >  {
> > >         unsigned long util = sched_cpu_util(cpu);
> > >
> > > -       return (util * 100) / arch_scale_cpu_capacity(cpu);
> > > +       return (util * 100) / get_actual_cpu_capacity(cpu);
> > >  }
> > >  #else /* !CONFIG_SMP */
> > >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> > >
> > >
> > > Because if still use arch_scale_cpu_capacity(), the load pct may be decreased,
> > > It may affect the thermal-IPA-governor's power consideration.
> >
> > I am not sure about this one. But looks plausible. Vincent?
> 
> I don't see why we should change them ? We don't want to change
> sched_cpu_util() as well
> AFAICT, the only outcome of this thread is that we should use
> get_actual_cpu_capacity() instead of arch_scale_cpu_capacity() in
> util_fits_cpu(). capping the utilization only make the estimation
> worse

Yes my bad. Only util_fits_cpu() is needed now

