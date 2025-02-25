Return-Path: <linux-kernel+bounces-531039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B1A43B81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4749216528D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4D9267F64;
	Tue, 25 Feb 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="uPiS2Qb7"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89CA2676F3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478821; cv=none; b=NUZJyZL7fPZuMZLEH5AIvMyExbg1XsD5NgQQ2D5x75+Q7KgL/mrISzHxdM1aGaSyHfYsB/YIBvU+u1nJ9SSTElO/aKmmmFVC1aMsG3eaoWnqeRrPQrj4jNimmBHEChLo7n6nQngB+OxxIrdImkkIWIFm6voARLFj59oUWSQ9P8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478821; c=relaxed/simple;
	bh=HXYMQk6Q5qjstW8AzPZaBN/NxihEkseKJVA6tCZYbR8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAdqke32KDFtkkzHWBaGsaeyacumRf91l1TBJZvTVuc5VXi1FKZ8Y3dLJ/tnK59PkJcry69pIwmioFfHtqx0cztZw5VRKcPFdrRiYmelVA3aaGW21sG/CaGF4acf04EazwHiaLV/ucBKefIw8bQsisWVTWFTHq8PCwUcAvUzIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=uPiS2Qb7; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740478505;
	bh=WHk30TQCK6fHKAx9chiiU56jqg5Tx3OtjBK/RushLTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uPiS2Qb7sxppwHHjyP3VQmFdP+FLKw9fMK5Rwp6mzwUDJrq7jKf4rl1YT4JtZOkMP
	 XzUQtZTQjej4Py5hNQVKIRFHyFzktoiIpaL24FbEwq6mwKp0SqhE0NImrFJLxfPVO2
	 oJ1TyMQwkqxjxxwAzHKyJWlAZVKWfi7ap86tMchc=
Received: from chenyu5-mobl2 ([118.114.56.201])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 3C22FE25; Tue, 25 Feb 2025 18:15:02 +0800
X-QQ-mid: xmsmtpt1740478502t2skedu9q
Message-ID: <tencent_0B09A23682D4B42D38B522ECD8C0A0ACE507@qq.com>
X-QQ-XMAILINFO: N8gUu3qZAm+43Tl3BVaECV5cnZ+uhRKH1wbR/N5ptOEz086/eWjLWnkEGyJvm1
	 9KqYqzNJZQYh/Q8WrY5tlnq+yrms5um+7O1Pt756lW9TjwIcM8d+mTnlq5icOpbc6pANDBBxmEXb
	 8pi/+/szoKVf8oX7TLcm+nl/fLnIgQlGKyXmfCh6po2XYlHccw2HrW75Gaf9yPPE2qE5PR6U4Njj
	 NpyOEFzoX8ziNG6szzHeA6S1VMWiKzHKPS/c9g94uakv5stHstcmdVik9JahHQJHxpTlp58yGKgc
	 DS3nPc+QbrP/k3kHIsQ9AK8xURVB+hK9jwyYipNTBFiIDCjGE7Oy5R8AtT/arCX10yrc3i1+7epM
	 2V+DRj+7DDUNUAbTm21BYTZPoIWD5J52Px8UIisvSJfvz1L2WHyH7hJUqmMfwnstP5wnFaDJobW2
	 aVfXrVYLkKfbuPTQwhOm7wKTtCtiga67iUzoq6JDpK6QVR9lb4GbrYf9zYh82sFDgIXUUy3Mcosq
	 fQnCFGDrdOwdhn71OjB528RXYrWB64SOvxH/JDseCG+R2Uxh3NDq4VK65WXQSpksZJwdINJWeBes
	 7KaRNLfdvsKkmOvkrleQIuVoYqWpI2TudGW/fXgQSRSCysbEqBvDq8VjMZ/0mExV9nndLvZC3AEb
	 jeihqkR7SG+t9sSdMecRqtS3MkUhag2D4Omrr7zYyDlwT8e2EVIn/Q32d7XosPG5GkYl0TNHq9c/
	 rNp1xgVAcIX3iqnWEc/LZn8hkZbn65f3aoowZaj3yJau1t6YtFkLkVcaUgVgbt4Rgwm4XAqPHP43
	 fFCugrdwTIKY0iWPuRcVOZkWdl8OVo6qApgPlc4Fruea7cZjurrD7CkrvgE+sdTTYYJKSHlS4szu
	 8xmu+7hSQoZvxo4is2q4mIPEbzvdINaaLflX2lZIhReMd3/X+xOCGYqqztyNi6IjNEqoQCbQJCDM
	 1UVZpz7IN/KlyHlHIpjLuUp+K69JfakkJ5UnHgLaSAQ1UZHHLNuC/dW3BoVXwMVsdMua9e45E=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Date: Tue, 25 Feb 2025 18:15:35 +0800
From: Chen Yu <yu.chen.surf@foxmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: zihan zhou <15645113830zzh@gmail.com>, oe-lkp@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
	yu.c.chen@intel.com, yu.chen.surf@gmail.com
Subject: Re: [tip:sched/core] [sched] 2ae891b826: hackbench.throughput 6.2%
 regression
X-OQ-MSGID: <Z72YRwXvIm6C5uUq@chenyu5-mobl2>
References: <202502251026.bb927780-lkp@intel.com>
 <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
 <CAKfTPtBWDFSj8E53i=qSK7kR1qsT68xLvVp4+HGr5FXrna-xRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtBWDFSj8E53i=qSK7kR1qsT68xLvVp4+HGr5FXrna-xRg@mail.gmail.com>

On 2025-02-25 at 10:45:35 +0100, Vincent Guittot wrote:
> On Tue, 25 Feb 2025 at 10:31, Chen Yu <yu.chen.surf@foxmail.com> wrote:
> >
> > On 2025-02-25 at 10:32:13 +0800, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a 6.2% regression of hackbench.throughput on:
> > >
> > >
> > > commit: 2ae891b826958b60919ea21c727f77bcd6ffcc2c ("sched: Reduce the default slice to avoid tasks getting an extra tick")
> > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> > >
> > > [test failed on linux-next/master d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa]
> > >
> > > testcase: hackbench
> > > config: x86_64-rhel-9.4
> > > compiler: gcc-12
> > > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> > > parameters:
> > >
> > >       nr_threads: 100%
> > >       iterations: 4
> > >       mode: process
> > >       ipc: socket
> > >       cpufreq_governor: performance
> > >
> > >
> > >   39754543 ą  3%     +56.8%   62349308        hackbench.time.involuntary_context_switches
> > >
> >
> > This patch shrinks the base_slice so the deadline is reached earlier to trigger the
> > tick preemption IIUC. For the hackbench case, my assumption is that hackbench seems to
> 
> For systems with more than 8 CPUs, the base slice was
> 0.75*(1+ilog2(8)) = 3ms which is exactly 3 tick periods at 1000hz but
> because the tick period is almost never fully accounted to the task,
> the task was running 4 tick periods instead of 3. The normalized
> base_slice has been reduced from 0.75 to 0.70ms so the base slice
> becomes 2.8ms for 8 CPUs and more and the main result is that tasks
> will run 3 tick periods instead of 4.
>

Thanks for the detailed explanation; I now understand the background.
It is a correct fix for tick preemption and slightly affects wakeup
preemption (smaller deadline in place_entity())

thanks,
Chenyu
 
> > encounter more wakeup preemption and hurts throughtput. If more frequent tick preemption
> > is needed, but more frequent wakeup preemption is not, are we able to do this base_slice
> > shrink for tick preemption only rather than the wakeup preemption? A wild guess, can we
> > add smaller base_slice 0.7 in update_deadline() for tick preemption, but remains the old
> > value 0.75 in update_deadline() for wakeup preemption during enqueue.
> >
> > But consider that the 6% regression is not that high, and the user might customize
> > base_slice via debugfs on-demand, we can keep an eye on this and revist it in the
> > future(we have encountered some SPECjbb regression due to over-preemption).
> >
> > thanks,
> > Chenyu
> >


