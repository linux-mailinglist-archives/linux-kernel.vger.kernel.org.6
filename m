Return-Path: <linux-kernel+bounces-530870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F4A43984
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C0016F1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838D263F2F;
	Tue, 25 Feb 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZnCuW7Q8"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6026389C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475879; cv=none; b=ga1wj67qV8U2MGmrY2lxuYOaM7rcJRAhqPxT+NiCaAbWtzrbq1T+tAyWFIBfUUt7u/ReMeaB4aKwi1o7jjG+I0f9oqLUIysTUrvWf8hut5E28ihOKMyj6fHnd1/83or3u+ao6HeGgkYJ5FrDgVgrNOVAne+sFOG1Ui8Da+xMA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475879; c=relaxed/simple;
	bh=vDsEiamb3M+Mmy27y8EplwRdWCku4uyVDcOnwntuzxo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLFwXIlGA6WDNz900CyrbJCPrMPHhuusEelKEeN+tw6DU01zC0PNXfPVXXb9Joqx6kxmqyzOdrEenvUJjtkNv4CZ4FX3s9JNbqiVb3ymudgF7OY2pMiy/l40UMNzpGoULZC6BRVNQPaJXBxrLfbNRqrI14pivLgdv+KnQWVrK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZnCuW7Q8; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740475865;
	bh=aKBjUG98HQzVsVaLctKLhwcLcI10ldf6jcbX57WesZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZnCuW7Q8me5OA2Sti55jI8aKaJfgTui+bZgILV6r4ScMXo0E6MxYjGFnOM6WqDC0j
	 J3rzb0LOPCFwgV75TQdMXIo1EgCnN34FRXOJAxBuJV41k0Mee2/6OQf1jHGmD0nqt8
	 XzUvESIVGmg4AoG6mINdGpMhGB1aDINTAJTmst54=
Received: from chenyu5-mobl2 ([118.114.56.201])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 7C19BE72; Tue, 25 Feb 2025 17:31:01 +0800
X-QQ-mid: xmsmtpt1740475861thw19023d
Message-ID: <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQXEKluU0QGaNMGYtho6EYQosrSrVaIqFLw1AKg0YQHpUgmkMTwV
	 9iE7HEIWj4lAS1N6iNB+1lRmIjEHr94IYg/a1KMAqRO1jJBG1nfQMGUl3mtjHpEMgU3uuqTyx7rc
	 3fL6iHz5+0xZzWB4smmqAgwvED841vFyUBVaL5nmnIzdoQxNDs2xjLXTMiywB9GW90rGXAQUnHqt
	 rUQ0CRkuQTL4O20A7hxhmWigdb27ggVkdIzzkeI2ndjQOMwh/O4iwruiOIXr8+dNeHowQmYhZTmJ
	 1fP74ycrM3qKOFUzip5nTdBCZPro6CiF7ZuTPQbEYZ2R7WETs1UAqgUDwZxkB2d+gDRJ7ykjpvJj
	 O/rRVTN5mKlervn4zpHko+0qvvEBc9Spu8CSAxBbrgY3NWBzzu91yLa0cGBu+4SPm3DO//wm8NLF
	 5oyiwilC4k3HmfNQbm59iIHyXEvn55akde+nBjx3B8yH1pfPfufNpmouKdqowi7qoJXzwGeWWVGu
	 rI7fxnnbjd+HJFoCgMxZQcrDDHxmXJzys+sEi8WT+ZWjEjWYqbHfcKoNLslq1vWjN0Fpyaw4RQU3
	 r9dGhqoF2jGH93wEAktgi68JuUVWnq+WlychEXRj8X7yDZAFsk9Th3W+Za6ATYdp7Ay8gBjqmGZc
	 5vSJuiNmkmbzkvn0W2cUXAxejsYtDJoyCHwa70r61JbYyT7HgZW9lomzu2nZIhn/HzLv0HyI/Ukw
	 wQ+r6iq7hdms4vAcnS25hUpcQwGiabgf/SdSFVD9yNSRHzx7K6JkEtYsEr8gi2xLfB2S842s/3aK
	 0sBxhEwNvc4zSCspYpJHdnox2wHPXbQQ/7JTwnHrLL3c2nkqehjK+9lyCdk12ksK92FwvDGPbE8y
	 zK42Apsl9nDQDxK7bbv6moFgzj2WjZ4SWH41WOqymgFCd7oLDJDMYQBgSoXDIf/+79P2dlodWtxZ
	 X46acF5wwuvRlRPvep9Nnp5xdTcpDWo+3NYurvrq4=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Date: Tue, 25 Feb 2025 17:31:34 +0800
From: Chen Yu <yu.chen.surf@foxmail.com>
To: zihan zhou <15645113830zzh@gmail.com>
Cc: oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  2ae891b826:  hackbench.throughput 6.2%
 regression
X-OQ-MSGID: <Z72N9qZfX32UMrrG@chenyu5-mobl2>
References: <202502251026.bb927780-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202502251026.bb927780-lkp@intel.com>

On 2025-02-25 at 10:32:13 +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 6.2% regression of hackbench.throughput on:
> 
> 
> commit: 2ae891b826958b60919ea21c727f77bcd6ffcc2c ("sched: Reduce the default slice to avoid tasks getting an extra tick")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> [test failed on linux-next/master d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa]
> 
> testcase: hackbench
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	iterations: 4
> 	mode: process
> 	ipc: socket
> 	cpufreq_governor: performance
> 
> 
>   39754543 ±  3%     +56.8%   62349308        hackbench.time.involuntary_context_switches
>

This patch shrinks the base_slice so the deadline is reached earlier to trigger the
tick preemption IIUC. For the hackbench case, my assumption is that hackbench seems to
encounter more wakeup preemption and hurts throughtput. If more frequent tick preemption
is needed, but more frequent wakeup preemption is not, are we able to do this base_slice
shrink for tick preemption only rather than the wakeup preemption? A wild guess, can we
add smaller base_slice 0.7 in update_deadline() for tick preemption, but remains the old
value 0.75 in update_deadline() for wakeup preemption during enqueue.

But consider that the 6% regression is not that high, and the user might customize
base_slice via debugfs on-demand, we can keep an eye on this and revist it in the
future(we have encountered some SPECjbb regression due to over-preemption).

thanks,
Chenyu


