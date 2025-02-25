Return-Path: <linux-kernel+bounces-532679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C261EA450D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EB53A857B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234EF2356D0;
	Tue, 25 Feb 2025 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="jVqZyn+L"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60E2054F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740525022; cv=none; b=ogIOQ7SrxoV8gwqGYxyUQpw2GQkPcVOxHrAqOl1Fl5B+mg+RRb2xmd/MRRFUtMmgftqahR2SgrifmbnnjARABS5oIZG1dM8NZH48SjZtN9tK5WoFWYs44r2RIGntr/t5YD2xsb79dWF1p5aQX9iN2CpJAyH2HwNhygCJIGAhM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740525022; c=relaxed/simple;
	bh=+kvbUQZyXSL4zamHMB07/kBb9aSkSvHGTQvnF1zvxkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atyrnHPBRJ94KFGkXUaVptWaZO2nWh2NeoGVOd3rzqFtTkK6IHaHpKimqTetooyFWqk/D4V4YoRB2dAtpf15A9xixN3L7HhhBaAIv1ZSa/I00aDq6v9iHTSOQKin9XP/i8ceJwaAX/JCiz/61Oh1GuWt9ZoFubfMQV1dRwAkO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=jVqZyn+L; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f504f087eso4805117f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740525019; x=1741129819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GR/f1XfgOyLiD0/Fzm3IhtRl2Wk8lZ2d6RNv1rFkKW8=;
        b=jVqZyn+LjftUAMnkuBCWEMK8bc7PtJ9Pvxx1AAnv9iCnqF2g6wJx71Rsbs1N6Bbs6v
         +25OF9NEdmYeqNN94QgCs60oNgq0lippQXxz7jaE/wT6xqQR/UVg+iz+WCYb7TM1psMZ
         j4tfPxnTqRY2hF3JIuXQ19wtqdRMT9g+iaWJKwQpYPlBKBv0KMojKrHTFxqs3OuM6Ewt
         kU8MK1PLdWbflF4JRxcmGq+s5hy+B7OtQjHWgaGZOIOm+DjsyZYzokkdl/9dlmoZsNKr
         unNnuU721dGA4yPZy/QEBgW9fCD6QQDyyTbxgT99GW4p1gz+0joSJc4Z6wYYHx6PNQIr
         JF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740525019; x=1741129819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR/f1XfgOyLiD0/Fzm3IhtRl2Wk8lZ2d6RNv1rFkKW8=;
        b=ZkLe8kRixwNEzwG/1welG8GGGiqAt+5+0PD1iqDTcEvUqSuECf60777AGaCPiJKlDo
         yKCDmH7wphYaBeWYpkHOz1HguM2S8rcvjCh2/shfo+7vbe5fX1/0+2l5+1fPxvl3996u
         BqTEx7V0JOdk1nDhEkDNBbwbvD23OTgLhdPKT+iteAOkXXN7YWigWuBli1oxHNI1zuSr
         x3f2rzVVPZNkySyt13rkrelRVAm8q/Rh8/llGGwNT2HAibzDBRQ7ZSA+beClBdKy1o1p
         53YDp6S2XWx3uxPx+Q2gx+qaHIdxypksUReP0hM2pX+B4vCCuzOv2zb5KECclEDfuvB7
         OIRg==
X-Forwarded-Encrypted: i=1; AJvYcCXlQipGa3jLK0i8j46t2rvvXJTP1ntArawICOJmLVjvxwmVvOiG4JJFn10QfFcnugkDwJt5MrzBIkr4qYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TJKwLMIdcdIGYh0Z7ylbSKBY/722hCG8tAKfC/Z6wgJL+aqS
	L/ubCFw9EeZ2CgjZX2KVpxk7tS/fFnmhaEOfPZd0OsqghU3ai79CQFhimQGcwko=
X-Gm-Gg: ASbGnctavvck/10DY4Wp0M7nVA5ovBCFUhfrLEIHYqBuRPvW7Kp7wnb95LKy5zb+YtC
	2LJMDCzNgyqptrKen2/QxBu8X911xCgVVHHSXpIIdg9UCHN/LpPqbrJZXpshexZtZn71UhWhiIJ
	WIvmVAX/9JRANNgfSZY//pekxFStD3uWQMfykPWcnxDCxIrXxFPdsC8kW0i+kzSM2BkNcf4ovQp
	hHyHpgqoEH4UfJXPwVYUqaAaJpCq+lR5zt5f6ty/hB1aFrh3ZMqaAwD2+gBGmKivPzkewHvhFyH
	FYjl1vjH3wp0vvoSPhgc
X-Google-Smtp-Source: AGHT+IFzKxgT+FDekkwTj58ufLFPS3qmQu4xLsL8NJ7EyApAQDJ+XquwGx750TREzyjfZG0WuyEI6A==
X-Received: by 2002:a05:6000:1546:b0:38a:87cc:fb42 with SMTP id ffacd0b85a97d-390d4f3cee1mr709890f8f.21.1740525018774;
        Tue, 25 Feb 2025 15:10:18 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58760bsm2039845e9.38.2025.02.25.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:10:18 -0800 (PST)
Date: Tue, 25 Feb 2025 23:10:14 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Chen Yu <yu.chen.surf@foxmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	zihan zhou <15645113830zzh@gmail.com>, oe-lkp@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  2ae891b826:  hackbench.throughput 6.2%
 regression
Message-ID: <20250225231014.yztrap5ihain3cd2@airbuntu>
References: <202502251026.bb927780-lkp@intel.com>
 <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
 <20250225122705.GD34233@noisy.programming.kicks-ass.net>
 <tencent_CC411B43EAD996961A06366F606C96DD0406@qq.com>
 <20250225134220.qjctfqwwhjz7bspp@airbuntu>
 <tencent_1A4C28B62DA5726C31A985601B07F664250A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_1A4C28B62DA5726C31A985601B07F664250A@qq.com>

On 02/25/25 23:35, Chen Yu wrote:
> On 2025-02-25 at 13:42:20 +0000, Qais Yousef wrote:
> > On 02/25/25 21:15, Chen Yu wrote:
> > > On 2025-02-25 at 13:27:05 +0100, Peter Zijlstra wrote:
> > > > On Tue, Feb 25, 2025 at 05:31:34PM +0800, Chen Yu wrote:
> > > > 
> > > > > 
> > > > > But consider that the 6% regression is not that high, and the user might customize
> > > > > base_slice via debugfs on-demand, we can keep an eye on this and revist it in the
> > > > > future(we have encountered some SPECjbb regression due to over-preemption).
> > > > 
> > > > You can specify a per-task slice using sched_attr::sched_runtime. Also
> > > > see commit 857b158dc5e8 ("sched/eevdf: Use sched_attr::sched_runtime to
> > > > set request/slice suggestion")
> > > > 
> > > >
> > > 
> > > Thanks, we'll have a try during the next test cycle.
> > 
> > Could you also try with HRTICK enabled?
> > 
> > 	echo HRTICK | sudo tee /sys/kernel/debug/sched/features
> 
> Sure. Is HRTICK supposed to encourage preemption? I thought
> hackbench might be sensitive to preemption(downgrading).

Yes my bad, I don't know why I read this as preemption was happening later not
earlier. Please ignore me then.

Thanks

--
Qais Yousef

