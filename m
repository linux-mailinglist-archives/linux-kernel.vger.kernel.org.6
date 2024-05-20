Return-Path: <linux-kernel+bounces-183525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C88C9A38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD80B20CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752741C6A3;
	Mon, 20 May 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uM44mjLf"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C2134B2
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196738; cv=none; b=ByPaRGzpzxg095HMw1Z4Iquiq9YhafNQSZNZiOImo5mxaziHKiiTkDbdjQLaIpbhOgtdrxkQMvorFxNVElW7WJA0XRaNFOF7rjWd7SqGnUY/vbp5MxjiIjJMwIN7hB9eHObW6s93fIiKA+0N7seL5wvBBcjnRM+bqGZgLmyHykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196738; c=relaxed/simple;
	bh=ocyhqUDe6Apnd+oKIqWNv6toBWBbxSk/XPrkqzWkycc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES6k6dn7ce414tgz3tCTyDQL6P3z7ufxzhesdy9Bt3SHSivU5zWkZX38UlnT690PE6nWvQH7e3HxlGWrZ9eyIRHkdfphs7wS62PU2619240f8UWVQJpoaH0yhPm7+e2hAjWUAsJ0Dyb3KHY4OhvIA0IAxMZbAWx4KIi8J6mDOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uM44mjLf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee42b97b32so68693905ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716196736; x=1716801536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbkhJkJ1XC7gIimFOJJxOChZ4G289d9IYRqq+r9fSXM=;
        b=uM44mjLf6HlgpskMDARfudNe3A4sUBwg3yD+3y5LsyiJVodn6tFHH/u2D6OCPUStAe
         b2hjSZ6XeyW1K0U+QWBH1IIcZhOeiFHVXJH+R6OcQWNFaonwf+xZCm/h0BXPJOX631SC
         +iLF+Gnl+NqfcRj8AsecWxJW78WIsujVwopJORsvYFzLatGoYijPPdHFuyN6i66TZwvp
         TrPURZ33pi152P2Jqf5jVSi34mhEXXr8HsIy0um6ovg85eb71cq+M+iKvj7f3GDZg8G6
         7HUATkycCR7ocdyI/pu0df4aAvUHlEev2kVo+bmvSQQgWVi3BYcsMRHEWzpujj52t3ZN
         zP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716196736; x=1716801536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbkhJkJ1XC7gIimFOJJxOChZ4G289d9IYRqq+r9fSXM=;
        b=w9qLu2K/kJQk/La9PLMiMeXc9MIk8O2cpDF30Hy5zeop8Xi779wWmITKelAMC18D3s
         /7oJtYUurGPc6GU8khLj/ds8mI/izg8g0fm3U6+Kg1ymcZyOZNwaJzmzX/sw3ETT7vXt
         LCMfOOlkKeVK6fC8pLlenIv/FpLSlN1PpuMxwY+oVwIc1P3fg9iC3TPqyTC+0A0CUSfY
         kIjSxeDWvFVfWFKcyVF6uWQdfMlWa0gbRhx8nojhzaGkBP2Q5yjjZmSF+O+wCvZFnwpo
         wtuBTEhjMXeOP1il+KH1g66MWd9Xfbdrqa3CFhTQn96SDgWHJvOFdzfeWqpS8laP7PYM
         Dkfw==
X-Forwarded-Encrypted: i=1; AJvYcCWg2TDTXDQHDHPQcEtKtWmdMs2AfOp94cMM/gGh8v9Xx7gmrqo6/xb5oIBmVPiH6tW9YG6o2SG4snHOjXxfghj00vcIAXpmo6jtCiF0
X-Gm-Message-State: AOJu0YzWxUuDw7MsktFXGzvQ96b9ydZw/LRvAoKqCySMI6pZIAgBLIwH
	n2zd68rW9yy2m2xRTXlDCF2cueic1inVqV50Rsqx3HAQXwMmk8t0+fP5Yjgk124=
X-Google-Smtp-Source: AGHT+IF13zAdM0O0asZK39mZrspFC5UwHgi4tpDWXMJe1KBtqtXW1PYn5vgvhSvLrnISOVfv7FLJbA==
X-Received: by 2002:a17:903:2349:b0:1f3:b2:e26 with SMTP id d9443c01a7336-1f300b21109mr25409725ad.28.1716196736284;
        Mon, 20 May 2024 02:18:56 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3053c34d0sm9561075ad.205.2024.05.20.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 02:18:55 -0700 (PDT)
Date: Mon, 20 May 2024 14:48:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: Re: [PATCH v4 4/4] cpufreq: Use arch specific feedback for
 cpuinfo_cur_freq
Message-ID: <20240520091853.tbxzoolqh5tgzg7t@vireshk-i7>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-5-beata.michalska@arm.com>
 <76zutrz47zs6i2cquvjo2qn7myxpq7e3c6alhper7n3wrkhf5h@22l5t5pio2cd>
 <Zh6dSrUnckoa-thV@arm.com>
 <s2bel7fzwpkyfyfkhod4xaihuklsaum75ycbcgmcanqaezxdu7@uxvqdqt3yo7l>
 <ZiuF0zgqkMlmkEZz@arm.com>
 <20240429092515.2ehk4ifcul6mbaxh@vireshk-i7>
 <Zjnm7LzrYLCbz-XX@arm.com>
 <Zjn8RGSDfn3HrYYd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjn8RGSDfn3HrYYd@arm.com>

On 07-05-24, 12:02, Beata Michalska wrote:
> On Tue, May 07, 2024 at 10:31:52AM +0200, Beata Michalska wrote:
> > On Mon, Apr 29, 2024 at 02:55:15PM +0530, Viresh Kumar wrote:
> > > Lets forget for once what X86 and ARM may have done and think about it
> > > once again. I also had a chat with Vincent today about this.
> > > 
> > > The documentation says it clearly, cpuinfo_cur_freq is the one
> > > received from hardware and scaling_cur_freq is the one requested from
> > > software.
> > > 
> > > Now, I know that X86 has made both of them quite similar and I
> > > suggested to make them all aligned (and never received a reply on my
> > > previous message).
> > > 
> > > There are few reasons why it may be worth keeping the definition (and
> > > behavior) of the sysfs files as is, at least for ARM:
> > > - First is that the documentation says so.
> > > - There is no point providing the same information via both the
> > >   interfaces, there are two interfaces here for a reason.
> > > - There maybe tools around which depend on the documented behavior.
> > > - From userspace, currently there is only one way to know the exact
> > >   frequency that the cpufreq governors have requested from a platform,
> > >   i.e. the value from scaling_cur_freq. If we make it similar to
> > >   cpuinfo_cur_freq, then userspace will never know about the requested
> > >   frequency and the eventual one and if they are same or different.
> > > 
> > > Lets keep the behavior as is and update only cpuinfo_cur_freq with
> > > arch_freq_get_on_cpu().
> > > 
> > > Makes sense ?
> > >
> > First of all - apologies for late reply.
> > 
> > It all makes sense, though to clarify things up, for my own benefit, and to
> > avoid any potential confusion ....
> > 
> > Adding arch_freq_get_on_cpu to cpuinfo_cur_freq does seem to be the right
> > approach - no argue on this one. Doing that though means we need a way to
> > skip calling arch_freq_get_on_cpu() from show_scaling_cur_freq(), to avoid
> > having both providing the same information when that should not be the case.
> > In the initial approach [1], that was handled by checking whether the cpufreq
> > driver supports 'get' callback (and thus cpuinfo_cur_freq). In case it didn't,
> > things remained unchanged for scaling_cur_freq. That does not seem to be a viable
> > option though, as there are at least few drivers, that will support both:
> > cpuinfo_cur_freq alongside scaling_cur_freq (+ APERF/MPERF) and for those,
> > we would hit the initial problem of both relying on arch_freq_get_on_cpu.
> > So I guess we need another way of avoiding calling arch_freq_get_on_cpu
> > for show_scaling_cur_freq (and most probably avoid calling that one for
> > cpuinfo_cur_freq). Quick idea on how to not bring arch specificity into
> > cpufreq generic code would be to introduce a new flag for cpufreq drivers though
> > that seems a bit stretched. Will ponder a bit about that but in the meantime
> > suggestions are more than welcomed.
> Alternatively we could add a parameter to arch_freq_get_on_cpu specifying type
> of feedback required: hw vs sw. Then the arch specific implementation could
> decide which to provide when. It will get slightly counter-intuitive, especially
> for cases when sw feedback provides hw one, as it is the case for current
> arch_freq_get_on_cpu() and scaling_cur_freq but at least the changes would be
> minimal and it will contain handling the tricky bits inside arch specific
> implementation - hiding those messy bits.

I think we should just move the call to arch_freq_get_on_cpu() from
show_scaling_cur_freq() to show_cpuinfo_cur_freq() and post it.

Lets see what X86 guys say to that. You can provide all the reasoning
we discussed here, which makes perfect sense.

-- 
viresh

