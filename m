Return-Path: <linux-kernel+bounces-343282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EB989917
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB6E1F219F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1055684;
	Mon, 30 Sep 2024 02:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pTn12ARc"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E684383
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661968; cv=none; b=KlejoZYc2zkOI7yMnBliC2gogR2VsVkEWNQ5wz2cVWVoKoU89fId+MwzCiLYGpa6O0ORQZtgMJogVClWPxCGnxjzXVYa62J1rieNL67EnaCb3AxMzNDlBIs0KKYugLU/111A5twKEPLQPCLoopuQCBUD0AjASxxvot9MaPOG0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661968; c=relaxed/simple;
	bh=hpOfa8DStMVtQqGW8V+cFvKuEnqjqn7Kvu3WnAflS8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSWlFBNkrOJja1DVIHq7YDIu1so/q+bilIlsvHj7QoArIYQLmJP5tCy23e0WqlL0x2hF6zpA2SFyU+ZqaMjStBhx4d5sDAvwllpFQieJZQXMwuw9glX0CuQoCQpFfSWqvWQQjveH2KlHAevUjYJRMBcP+nib/GVQLVSfeb9ZVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pTn12ARc; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=F2QxLtozImvGkW3fiM1SMzKGvlcxtTG0xNUPIfhzfms=;
	b=pTn12ARc3wzjW/3ogW+2iq5Xrc8wm+8KgR5S3VRMcYbwGDpxA9ASi9gmxBkIn6
	OK+yPayIO9cKT4oPoYS3z57GsYnwt51HqZ+uvvfL4tC9H44nB82IlNJdANfjAXew
	y7Bk7yRStzxaawLWvlLKSqbN9liJVI9sMb9CriISSRzmE=
Received: from [172.24.140.9] (unknown [111.204.182.99])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v58dB_pmI9gxAA--.26133S2;
	Mon, 30 Sep 2024 10:04:14 +0800 (CST)
Message-ID: <8282e4e8-6d71-4402-9eed-38865a3fc6f3@126.com>
Date: Mon, 30 Sep 2024 10:04:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
To: Oliver Sang <oliver.sang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Chunxin Zang <zangchunxin@lixiang.com>, linux-kernel@vger.kernel.org,
 Chen Yu <yu.chen.surf@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
 <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
 <ZvZXEqNLcJxq+8Aw@chenyu5-mobl2>
 <c15e2f07-5a0d-4e48-b7f4-83e4689f9299@126.com>
 <ZveiDh2/ztZTP/fH@chenyu5-mobl2> <ZvlbZYQE5Slf2YEb@xsang-OptiPlex-9020>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <ZvlbZYQE5Slf2YEb@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v58dB_pmI9gxAA--.26133S2
X-Coremail-Antispam: 1Uf129KBjvAXoWDAr13tr45XF1xKr1rGFyxAFb_yoWxJr43uo
	ZIgay5uF1Utr90qan8Ca4UJ3y7Jrs8Z3s7u34q93s5GFsYqrWxKr1UXw4FgFZ3Gay0kFWx
	Zr48W3Z8AryxZFy7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwoGQDUUUU
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiJAdqrWb5-NVbiQABsB

Hi Oliver,

On 2024/9/29 21:51, Oliver Sang wrote:
> hi, Chenyu and Honglei,
> 
> On Sat, Sep 28, 2024 at 02:28:30PM +0800, Chen Yu wrote:
>> Hi Honglei,
>>
>> On 2024-09-27 at 21:38:53 +0800, Honglei Wang wrote:
>>> Hi Yu,
>>>
>>> Yep, I understand the preemption should happen in the same cfs level. Just
>>> not sure the purpose of the 'nr_running check' stuff. Perhaps its role is
>>> just to judge whether it’s necessary to do the preemption check. If there is
>>> at least one more ready (cfs) task in the rq and current is not eligible, we
>>> take care of the waiting tasks. Thoughts?
>>
>> I got your point and it makes sense. Whether the preemption check should be triggered
>> seems to be a heuristic trade-off to me. I'm ok with using more aggressive preemption
>> strategy as it depends on whether that workload prefers latency or throughput, and as
>> long as it did not introduce regression :-)
>>
>> Oliver, may I know if you happen to have time for a test if the following change
>> suggested by Honglei would make the regression go away? Thanks.
> 
> I applied the patch directly upon 85e511df3cec, the test found it can reduce the
> regression but not totally reovered
> 
> =========================================================================================
> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
>   gcc-12/performance/socket/4/x86_64-rhel-8.3/process/50%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/hackbench
> 
> commit:
>   82e9d0456e06 ("sched/fair: Avoid re-setting virtual deadline on 'migrations'")
>   85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
>   8079496d311b  <--- patch from Honglei
> 
> 82e9d0456e06cebe 85e511df3cec46021024176672a 8079496d311b6b0d4dae973f4df
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     623219           -13.1%     541887            -3.2%     603080        hackbench.throughput
> 

Thanks a lot for running the test. The result is as expectation, as the
strategy of short slices tends to favor more frequent scheduling to help
delay-sensitive tasks acquire CPU as early as possible.

I suspect that the current test environment does not have any special
configurations for slices. In this case, a 3.2% regression is still
somewhat significant. As Yu mentioned, this is a heuristic adjustment.
In this particular case, it seems that Yu's patch is more effective in
solving the problem. Let's delegate the preemption opportunity to the
higher-level update_curr() function.

Thanks,
Honglei

>>
>> thanks,
>> Chenyu
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fd2f3831c74e..290e5fdfc267 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>  
>>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
>>  
>> -	if (rq->nr_running == 1)
>> +	if (rq->cfs.nr_running == 1)
>>  		return;
>>  
>>  	if (resched || did_preempt_short(cfs_rq, curr)) {
>> -- 
>> 2.25.1
> 
> 
> below is full comparison FYI.
> 
> 
> =========================================================================================
> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
>   gcc-12/performance/socket/4/x86_64-rhel-8.3/process/50%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/hackbench
> 
> commit:
>   82e9d0456e06 ("sched/fair: Avoid re-setting virtual deadline on 'migrations'")
>   85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
>   8079496d311b  <--- patch from Honglei
> 
> 82e9d0456e06cebe 85e511df3cec46021024176672a 8079496d311b6b0d4dae973f4df
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     150791 ±  3%      -3.9%     144868 ±  2%      -8.4%     138189 ±  3%  perf-c2c.HITM.local
>     217.40           +13.5%     246.74            +1.9%     221.55        uptime.boot
>    4679401           -15.8%    3938145           +35.5%    6342833        vmstat.system.cs
>     854648           -15.2%     724774           +35.0%    1153448        vmstat.system.in
>       0.46 ±  2%      -0.1        0.40            +0.1        0.51 ±  2%  mpstat.cpu.all.irq%
>       0.03 ±  3%      -0.0        0.03            +0.0        0.04        mpstat.cpu.all.soft%
>       3.35            -0.6        2.75            +0.3        3.65        mpstat.cpu.all.usr%
>     922628 ± 16%     +17.2%    1080933 ± 14%     +87.9%    1733278 ± 14%  numa-numastat.node0.local_node
>    1027104 ± 13%     +17.6%    1207529 ± 15%     +82.3%    1872582 ± 14%  numa-numastat.node0.numa_hit
>    2553206 ± 16%      +0.4%    2563309 ± 10%     +46.3%    3735450 ±  4%  numa-numastat.node1.local_node
>    2684151 ± 16%      -0.4%    2672834 ±  8%     +43.2%    3843864 ±  5%  numa-numastat.node1.numa_hit
>     174.58           +16.3%     203.09            +2.1%     178.28        time.elapsed_time
>     174.58           +16.3%     203.09            +2.1%     178.28        time.elapsed_time.max
>  1.654e+08            +2.2%   1.69e+08           +50.7%  2.492e+08        time.involuntary_context_switches
>      36869           +17.6%      43340            +1.6%      37461        time.system_time
>       1172            -5.5%       1107            +8.9%       1276        time.user_time
>  6.478e+08            -3.5%  6.255e+08           +36.2%  8.824e+08 ±  2%  time.voluntary_context_switches
>    8177075 ± 14%      +8.6%    8880848 ± 13%     +47.8%   12086160 ±  2%  meminfo.Cached
>    7771720 ± 15%      +9.5%    8506289 ± 13%     +50.8%   11720513 ±  2%  meminfo.Committed_AS
>    4992416 ± 31%     +17.9%    5883734 ± 19%     +83.6%    9165655 ±  2%  meminfo.Inactive
>    4992203 ± 31%     +17.9%    5883521 ± 19%     +83.6%    9165427 ±  2%  meminfo.Inactive(anon)
>    2281337 ± 19%     +17.2%    2673418 ±  4%     +38.0%    3147813 ±  3%  meminfo.Mapped
>   12824178 ± 10%      +5.9%   13577581 ±  8%     +30.4%   16717964        meminfo.Memused
>    5084291 ± 22%     +13.8%    5788029 ± 20%     +76.9%    8993338 ±  2%  meminfo.Shmem
>   13135346 ±  9%      +5.2%   13824666 ±  8%     +29.2%   16968485        meminfo.max_used_kB
>    3089827 ± 31%     +15.4%    3565461 ±  7%     +49.8%    4628448 ± 10%  numa-meminfo.node0.FilePages
>    5391461 ± 19%     +16.5%    6281524 ±  6%     +31.1%    7067023 ± 10%  numa-meminfo.node0.MemUsed
>     352581 ± 13%     +24.6%     439472 ± 16%     +11.3%     392488 ± 14%  numa-meminfo.node0.SUnreclaim
>    5090008 ± 22%      +4.5%    5317103 ± 18%     +46.6%    7462041 ±  3%  numa-meminfo.node1.FilePages
>    4237429 ± 32%     +13.8%    4822257 ± 21%     +66.3%    7045772 ±  7%  numa-meminfo.node1.Inactive
>    4237311 ± 32%     +13.8%    4822122 ± 21%     +66.3%    7045629 ±  7%  numa-meminfo.node1.Inactive(anon)
>    1875959 ± 20%     +18.1%    2215441 ±  5%     +44.6%    2711735 ±  3%  numa-meminfo.node1.Mapped
>    7434746 ± 16%      -1.8%    7298189 ± 12%     +29.9%    9655790 ±  5%  numa-meminfo.node1.MemUsed
>    4692017 ± 22%     +10.5%    5186768 ± 18%     +55.8%    7310040 ±  4%  numa-meminfo.node1.Shmem
>     623219           -13.1%     541887            -3.2%     603080        hackbench.throughput
>     606251           -14.1%     520789            -2.1%     593622        hackbench.throughput_avg
>     623219           -13.1%     541887            -3.2%     603080        hackbench.throughput_best
>     580034           -14.8%     494354            +0.4%     582377        hackbench.throughput_worst
>     174.58           +16.3%     203.09            +2.1%     178.28        hackbench.time.elapsed_time
>     174.58           +16.3%     203.09            +2.1%     178.28        hackbench.time.elapsed_time.max
>  1.654e+08            +2.2%   1.69e+08           +50.7%  2.492e+08        hackbench.time.involuntary_context_switches
>      36869           +17.6%      43340            +1.6%      37461        hackbench.time.system_time
>       1172            -5.5%       1107            +8.9%       1276        hackbench.time.user_time
>  6.478e+08            -3.5%  6.255e+08           +36.2%  8.824e+08 ±  2%  hackbench.time.voluntary_context_switches
>     772255 ± 31%     +15.4%     891384 ±  7%     +49.8%    1156899 ± 10%  numa-vmstat.node0.nr_file_pages
>    1025412 ± 13%     +17.7%    1206842 ± 15%     +82.6%    1871921 ± 14%  numa-vmstat.node0.numa_hit
>     920942 ± 16%     +17.3%    1080247 ± 14%     +88.1%    1732619 ± 14%  numa-vmstat.node0.numa_local
>    1271682 ± 22%      +4.5%    1328902 ± 18%     +46.6%    1863679 ±  3%  numa-vmstat.node1.nr_file_pages
>    1059760 ± 32%     +13.7%    1205295 ± 21%     +66.1%    1759754 ±  7%  numa-vmstat.node1.nr_inactive_anon
>     469078 ± 20%     +18.0%     553505 ±  5%     +44.2%     676623 ±  3%  numa-vmstat.node1.nr_mapped
>    1172184 ± 22%     +10.6%    1296319 ± 18%     +55.8%    1825678 ±  4%  numa-vmstat.node1.nr_shmem
>    1059759 ± 32%     +13.7%    1205294 ± 21%     +66.1%    1759752 ±  7%  numa-vmstat.node1.nr_zone_inactive_anon
>    2682254 ± 16%      -0.4%    2671316 ±  8%     +43.3%    3842866 ±  5%  numa-vmstat.node1.numa_hit
>    2551311 ± 16%      +0.4%    2561794 ± 10%     +46.4%    3734454 ±  4%  numa-vmstat.node1.numa_local
>    6233000            -0.3%    6214123            -1.6%    6135664        proc-vmstat.nr_dirty_background_threshold
>   12481241            -0.3%   12443440            -1.6%   12286330        proc-vmstat.nr_dirty_threshold
>    2044616 ± 14%      +8.6%    2220456 ± 13%     +47.8%    3022899 ±  2%  proc-vmstat.nr_file_pages
>   62706078            -0.3%   62517035            -1.6%   61731279        proc-vmstat.nr_free_pages
>    1247557 ± 31%     +17.9%    1471046 ± 19%     +83.8%    2292396 ±  2%  proc-vmstat.nr_inactive_anon
>     570709 ± 19%     +17.2%     668608 ±  4%     +38.0%     787666 ±  3%  proc-vmstat.nr_mapped
>    1271419 ± 23%     +13.8%    1447250 ± 20%     +76.9%    2249692 ±  2%  proc-vmstat.nr_shmem
>      44542            +2.7%      45755            +5.1%      46796        proc-vmstat.nr_slab_reclaimable
>     188881            -0.7%     187493            +1.4%     191440        proc-vmstat.nr_slab_unreclaimable
>    1247557 ± 31%     +17.9%    1471046 ± 19%     +83.8%    2292396 ±  2%  proc-vmstat.nr_zone_inactive_anon
>    3714588 ±  9%      +6.5%    3954189 ± 12%     +54.0%    5719994        proc-vmstat.numa_hit
>    3479163 ± 10%      +4.8%    3645729 ±  9%     +57.3%    5472276        proc-vmstat.numa_local
>     642130 ± 68%     -71.2%     184909 ± 11%     -73.9%     167609 ± 14%  proc-vmstat.pgactivate
>    4593887 ±  7%      +1.2%    4650141 ±  7%    +131.4%   10629624        proc-vmstat.pgalloc_normal
>    2170433 ±  2%      +6.8%    2318318 ±  2%      +6.4%    2308275 ±  5%  proc-vmstat.pgfault
>    2631626 ±  7%      -8.8%    2400780          +177.3%    7298788        proc-vmstat.pgfree
>     138302 ±  4%      +6.7%     147631 ±  3%      -0.7%     137382 ±  4%  proc-vmstat.pgreuse
>       0.30 ±  3%      -4.9%       0.28 ±  2%     +20.7%       0.36        perf-stat.i.MPKI
>  6.354e+10           -11.4%   5.63e+10            +2.2%  6.497e+10        perf-stat.i.branch-instructions
>       0.53            -0.0        0.52            +0.0        0.57        perf-stat.i.branch-miss-rate%
>  3.226e+08           -12.5%  2.822e+08            +9.2%  3.523e+08        perf-stat.i.branch-misses
>       3.91 ±  3%      -0.2        3.74 ±  2%      +0.9        4.80 ±  2%  perf-stat.i.cache-miss-rate%
>   94557935 ±  3%     -15.2%   80197744 ±  2%     +25.1%  1.183e+08        perf-stat.i.cache-misses
>  2.563e+09           -13.7%  2.212e+09            +1.3%  2.596e+09        perf-stat.i.cache-references
>    4710895           -15.9%    3959720           +36.7%    6439647        perf-stat.i.context-switches
>       1.86           +14.3%       2.13            -0.8%       1.85        perf-stat.i.cpi
>     224291            +0.0%     224353            +1.4%     227521        perf-stat.i.cpu-clock
>  6.345e+11            +0.4%  6.368e+11            +1.3%  6.424e+11        perf-stat.i.cpu-cycles
>     601598           -15.0%     511540           +13.7%     683759 ±  2%  perf-stat.i.cpu-migrations
>       7390 ±  5%     +28.4%       9492 ±  2%     -23.5%       5655        perf-stat.i.cycles-between-cache-misses
>  3.408e+11           -12.1%  2.997e+11            +2.1%  3.478e+11        perf-stat.i.instructions
>       0.54           -12.2%       0.47            +0.8%       0.55        perf-stat.i.ipc
>      23.73           -15.9%      19.95           +32.3%      31.39        perf-stat.i.metric.K/sec
>     224291            +0.0%     224353            +1.4%     227521        perf-stat.i.task-clock
>       0.25 ± 35%      +8.1%       0.27 ±  2%     +38.0%       0.34        perf-stat.overall.MPKI
>       0.45 ± 35%      +0.1        0.50            +0.1        0.54        perf-stat.overall.branch-miss-rate%
>       3.26 ± 35%      +0.3        3.60            +1.3        4.54        perf-stat.overall.cache-miss-rate%
>       1.66 ± 35%     +28.5%       2.13           +11.6%       1.85        perf-stat.overall.cpi
>       6006 ± 35%     +33.5%       8020 ±  2%      -9.1%       5458        perf-stat.overall.cycles-between-cache-misses
>       0.48 ± 35%      -1.5%       0.47           +13.4%       0.54        perf-stat.overall.ipc
>  2.847e+08 ± 35%      -1.6%  2.802e+08           +21.1%  3.448e+08        perf-stat.ps.branch-misses
>   83193631 ± 35%      -5.0%   79040711 ±  2%     +38.7%  1.154e+08        perf-stat.ps.cache-misses
>    4153465 ± 35%      -5.4%    3930147           +52.2%    6323104        perf-stat.ps.context-switches
>     531469 ± 35%      -4.7%     506531           +26.2%     670740 ±  2%  perf-stat.ps.cpu-migrations
>  5.287e+13 ± 35%     +15.1%  6.083e+13           +15.6%  6.114e+13        perf-stat.total.instructions
>   13829361           +51.8%   20989754            +6.0%   14655040 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.avg
>   18756074 ±  5%     +44.2%   27055241 ±  3%      +3.8%   19470555 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.max
>   12499623 ±  2%     +52.4%   19043277 ±  2%      +8.0%   13493604 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.min
>       8.93 ±  2%     +14.1%      10.19            -5.2%       8.47 ±  7%  sched_debug.cfs_rq:/.h_nr_running.avg
>       4.68 ±  3%     +10.0%       5.15 ±  2%      -1.5%       4.62 ±  8%  sched_debug.cfs_rq:/.h_nr_running.stddev
>       0.44 ± 35%     +75.8%       0.78 ± 19%      -1.6%       0.44 ± 50%  sched_debug.cfs_rq:/.load_avg.min
>   13829361           +51.8%   20989754            +6.0%   14655040 ± 15%  sched_debug.cfs_rq:/.min_vruntime.avg
>   18756074 ±  5%     +44.2%   27055241 ±  3%      +3.8%   19470555 ± 13%  sched_debug.cfs_rq:/.min_vruntime.max
>   12499623 ±  2%     +52.4%   19043277 ±  2%      +8.0%   13493604 ± 14%  sched_debug.cfs_rq:/.min_vruntime.min
>       0.68           +11.7%       0.76            -1.3%       0.67 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
>     176.30 ±  3%     -22.8%     136.16 ±  4%      -2.9%     171.17 ± 10%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>     176.30 ±  3%     -22.8%     136.16 ±  4%      -2.9%     171.17 ± 10%  sched_debug.cfs_rq:/.removed.util_avg.max
>       8995           +16.0%      10437            -5.7%       8484 ±  7%  sched_debug.cfs_rq:/.runnable_avg.avg
>      18978 ±  6%     +13.7%      21579 ±  6%     -10.1%      17066 ± 11%  sched_debug.cfs_rq:/.runnable_avg.max
>       2890 ±  4%     +13.9%       3292 ±  3%      -1.5%       2848 ±  9%  sched_debug.cfs_rq:/.runnable_avg.stddev
>       1094 ±  3%      +2.9%       1125 ±  3%     +72.4%       1886 ±  5%  sched_debug.cfs_rq:/.util_est.avg
>       4561 ± 14%     +19.8%       5464 ± 19%     +50.2%       6850 ±  7%  sched_debug.cfs_rq:/.util_est.max
>     816.44 ±  6%      +7.4%     877.16 ±  4%     +78.4%       1456 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
>     415209 ± 22%     -23.3%     318311 ±  3%      -8.8%     378602 ±  6%  sched_debug.cpu.avg_idle.avg
>     102333 ±  2%     +30.5%     133496 ±  2%      +4.0%     106415 ±  9%  sched_debug.cpu.clock.avg
>     102519 ±  2%     +30.4%     133722 ±  2%      +4.0%     106590 ±  8%  sched_debug.cpu.clock.max
>     102127 ±  2%     +30.5%     133254 ±  2%      +4.0%     106199 ±  9%  sched_debug.cpu.clock.min
>     101839 ±  2%     +30.5%     132880 ±  2%      +4.0%     105862 ±  8%  sched_debug.cpu.clock_task.avg
>     102169 ±  2%     +30.4%     133268 ±  2%      +3.9%     106186 ±  8%  sched_debug.cpu.clock_task.max
>      87129 ±  2%     +35.6%     118117 ±  2%      +4.6%      91152 ± 10%  sched_debug.cpu.clock_task.min
>      11573           +32.4%      15327            -0.3%      11534        sched_debug.cpu.curr->pid.avg
>      14704           +23.9%      18214            +3.2%      15178 ±  7%  sched_debug.cpu.curr->pid.max
>       1516 ±  9%     +16.4%       1765 ± 10%     +33.3%       2021 ± 44%  sched_debug.cpu.curr->pid.stddev
>       8.92 ±  2%     +14.1%      10.18            -5.2%       8.46 ±  7%  sched_debug.cpu.nr_running.avg
>       4.69 ±  2%     +10.0%       5.16 ±  2%      -1.7%       4.61 ±  8%  sched_debug.cpu.nr_running.stddev
>    1232815 ±  2%     +27.3%    1569099           +45.1%    1789014 ± 17%  sched_debug.cpu.nr_switches.avg
>    1411362 ±  5%     +26.8%    1789325 ±  3%     +48.6%    2097828 ± 20%  sched_debug.cpu.nr_switches.max
>    1045767 ±  2%     +27.3%    1331341 ±  3%     +42.5%    1489877 ± 17%  sched_debug.cpu.nr_switches.min
>     102127 ±  2%     +30.5%     133250 ±  2%      +4.0%     106198 ±  9%  sched_debug.cpu_clk
>     101071 ±  2%     +30.8%     132194 ±  2%      +4.0%     105143 ±  9%  sched_debug.ktime
>       0.00           -25.0%       0.00            -3.1%       0.00 ±  8%  sched_debug.rt_rq:.rt_nr_running.avg
>       0.33           -25.0%       0.25            -3.1%       0.32 ±  8%  sched_debug.rt_rq:.rt_nr_running.max
>       0.02           -25.0%       0.02            -3.1%       0.02 ±  8%  sched_debug.rt_rq:.rt_nr_running.stddev
>     102997 ±  2%     +30.2%     134142 ±  2%      +4.0%     107069 ±  9%  sched_debug.sched_clk
>   16347631          +100.0%   32695263          +100.0%   32695263        sched_debug.sysctl_sched.sysctl_sched_features
>       3.31 ±123%     -42.6%       1.90 ± 86%     -89.1%       0.36 ± 88%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
>       8.46 ± 38%    +100.8%      16.98 ± 82%     -85.1%       1.26 ±134%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof
>       5.72 ± 38%     +21.2%       6.93 ± 80%     -85.6%       0.83 ± 85%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
>       7.88 ± 21%     +11.3%       8.77 ± 59%     -89.0%       0.87 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>       7.16 ± 36%     -24.4%       5.42 ± 73%     -70.7%       2.10 ± 66%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      28.76 ±142%     -62.8%      10.70 ±198%     -99.4%       0.18 ±233%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>       3.75 ± 24%      +0.6%       3.77 ± 59%     -62.1%       1.42 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
>      10.26 ± 19%      -9.5%       9.29 ± 62%     -74.3%       2.64 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
>       2.82 ± 43%     -22.6%       2.18 ± 73%     -83.9%       0.45 ± 59%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>       2.30 ± 29%      -4.8%       2.19 ± 61%     -72.3%       0.64 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>       1.75 ± 49%      -5.1%       1.66 ± 65%     -61.1%       0.68 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
>       4.13 ± 87%      +0.3%       4.15 ± 88%     -86.0%       0.58 ±133%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
>       2.81 ± 59%     -20.7%       2.23 ± 61%     -72.8%       0.76 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.13 ± 30%      +0.5%       9.17 ± 67%     -87.4%       1.15 ± 53%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>       9.94 ± 32%     -38.3%       6.13 ± 62%     -56.9%       4.28 ± 37%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
>      11.06 ± 57%     -45.0%       6.08 ± 75%     -90.4%       1.06 ± 60%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      16.36 ± 24%     -23.9%      12.45 ± 59%     -53.7%       7.57 ± 38%  perf-sched.sch_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
>       1.77 ± 23%     -28.5%       1.26 ± 60%     -66.1%       0.60 ± 38%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
>       2.66 ± 21%     -15.5%       2.25 ± 58%     -63.8%       0.96 ± 37%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>     226.74 ±108%     -40.0%     136.06 ±120%     -95.1%      11.09 ± 91%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       1412 ± 25%      -7.0%       1313 ± 66%     -83.6%     231.23 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>       1221 ±  4%     -23.0%     940.87 ± 58%     -51.1%     596.88 ± 89%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>     262.66 ±176%     -72.1%      73.22 ±239%     -99.9%       0.35 ±248%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>     779.32 ± 29%     -15.9%     655.34 ± 72%     -80.4%     152.55 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
>       1042 ± 23%      -8.4%     954.56 ± 63%     -81.8%     190.25 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
>     463.55 ± 83%      -3.7%     446.18 ± 87%     -85.8%      65.73 ± 93%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>       1128 ± 17%     -17.7%     928.10 ± 62%     -81.0%     214.51 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>     500.79 ± 50%     -25.9%     370.90 ± 79%     -76.0%     120.40 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
>     744.38 ± 27%      +0.4%     747.54 ± 78%     -86.3%     102.18 ± 71%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>     579.24 ± 43%     -10.1%     520.76 ± 62%     -65.3%     201.13 ± 62%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       1945 ± 16%     -15.9%       1635 ± 61%     -73.4%     516.65 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
>       1530 ± 22%      -7.2%       1420 ± 63%     -75.5%     375.37 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
>       3.03 ± 23%     -26.5%       2.23 ± 59%     -65.2%       1.05 ± 38%  perf-sched.total_sch_delay.average.ms
>       8.72 ± 23%     -28.5%       6.23 ± 59%     -64.2%       3.12 ± 38%  perf-sched.total_wait_and_delay.average.ms
>       8284 ± 27%     -38.2%       5118 ± 60%     -41.6%       4839 ± 44%  perf-sched.total_wait_and_delay.max.ms
>       5.68 ± 23%     -29.6%       4.00 ± 59%     -63.7%       2.06 ± 38%  perf-sched.total_wait_time.average.ms
>       5811 ±  8%     -28.5%       4155 ± 59%     -27.8%       4194 ± 38%  perf-sched.total_wait_time.max.ms
>      37.25 ± 91%     +17.8%      43.88 ± 72%     -90.7%       3.45 ±136%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof
>      44.86 ± 74%     +10.0%      49.33 ±117%     -95.6%       1.99 ±132%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
>      22.30 ± 21%      +6.1%      23.66 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>      17.29 ± 21%     -28.7%      12.33 ± 66%     -60.1%       6.90 ± 45%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      28.98 ± 21%     -13.8%      24.98 ± 61%     -74.3%       7.45 ± 39%  perf-sched.wait_and_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
>      27.08 ± 28%     -10.4%      24.27 ± 64%     -93.8%       1.69 ±129%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>      27.52 ± 28%     -37.8%      17.11 ± 61%     -54.9%      12.40 ± 37%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
>      38.19 ± 43%     -40.4%      22.76 ± 65%     -80.4%       7.50 ± 40%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      45.63 ± 24%     -25.8%      33.84 ± 59%     -53.4%      21.28 ± 38%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
>       5.06 ± 24%     -30.6%       3.51 ± 60%     -65.6%       1.74 ± 38%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
>       7.23 ± 22%     -18.4%       5.90 ± 59%     -64.2%       2.59 ± 38%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>      17219 ± 26%     +18.6%      20422 ± 60%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>     287.02 ± 72%     -56.9%     123.78 ± 90%     -90.0%      28.73 ±130%  perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
>       2851 ± 25%      -5.3%       2699 ± 64%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>       2443 ±  4%     -23.0%       1881 ± 58%     -37.8%       1519 ± 53%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       2132 ± 23%      -9.7%       1925 ± 63%     -82.0%     384.48 ± 45%  perf-sched.wait_and_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
>       3449 ± 45%     -35.6%       2220 ± 71%     -59.1%       1410 ± 49%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       1507 ± 27%      +0.2%       1510 ± 79%     -93.3%     101.36 ±137%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>       1312 ± 35%     -16.4%       1097 ± 61%     -65.2%     456.55 ± 64%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       3951 ± 16%     -17.0%       3278 ± 61%     -73.7%       1038 ± 40%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
>       3088 ± 22%      -7.9%       2844 ± 62%     -75.1%     768.96 ± 41%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
>       3.31 ±123%     -42.6%       1.90 ± 86%     -89.1%       0.36 ± 88%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
>      28.79 ±114%      -6.6%      26.89 ± 70%     -90.2%       2.82 ± 96%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof
>      39.14 ± 89%      +8.3%      42.40 ±140%     -95.1%       1.92 ± 78%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
>      14.42 ± 21%      +3.3%      14.89 ± 59%     -88.8%       1.61 ± 37%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>      10.13 ± 17%     -31.7%       6.92 ± 63%     -52.6%       4.80 ± 41%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>      40.86 ±110%     -46.6%      21.80 ±152%     -99.1%       0.35 ±248%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>       6.56 ± 23%      -5.6%       6.20 ± 59%     -61.9%       2.50 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
>      18.72 ± 22%     -16.2%      15.69 ± 61%     -74.3%       4.81 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
>       2.82 ± 43%     -22.6%       2.18 ± 73%     -83.9%       0.45 ± 59%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>       5.03 ± 24%      -6.1%       4.72 ± 59%     -63.4%       1.84 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>       3.16 ± 33%     -19.7%       2.54 ± 65%     -60.4%       1.25 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
>       4.13 ± 87%      +0.3%       4.15 ± 88%     -86.0%       0.58 ±133%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
>       4.42 ± 44%     -21.0%       3.49 ± 65%     -71.3%       1.27 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>     224.55 ± 53%     -20.5%     178.59 ± 71%     -71.8%      63.25 ± 68%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>      17.95 ± 30%     -15.9%      15.10 ± 63%     -89.3%       1.91 ± 46%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>      17.58 ± 26%     -37.5%      10.98 ± 61%     -53.8%       8.12 ± 38%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
>      27.13 ± 39%     -38.5%      16.68 ± 63%     -76.3%       6.43 ± 38%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      29.27 ± 24%     -26.9%      21.39 ± 59%     -53.2%      13.71 ± 38%  perf-sched.wait_time.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
>       3.29 ± 24%     -31.7%       2.25 ± 60%     -65.3%       1.14 ± 38%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
>       4.57 ± 22%     -20.1%       3.66 ± 59%     -64.4%       1.63 ± 38%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       1446 ± 25%      -3.4%       1396 ± 63%     -80.6%     280.50 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>     292.35 ±159%     -68.1%      93.21 ±217%     -99.8%       0.69 ±256%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>     932.87 ± 20%     -20.6%     740.44 ± 65%     -81.7%     170.42 ± 45%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
>       1110 ± 24%     -11.8%     979.30 ± 62%     -81.7%     203.13 ± 43%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
>     463.55 ± 83%      -3.7%     446.18 ± 87%     -85.8%      65.73 ± 93%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>       1203 ± 20%     -19.5%     969.24 ± 62%     -80.5%     234.88 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>     614.81 ± 41%     -27.8%     443.79 ± 79%     -79.3%     127.43 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
>     822.39 ± 32%     -24.1%     624.54 ± 74%     -82.9%     140.70 ± 43%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>     817.75 ± 28%      -6.8%     762.54 ± 79%     -85.7%     117.26 ± 58%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>     774.10 ± 27%     -22.5%     600.11 ± 61%     -63.0%     286.19 ± 57%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       2023 ± 16%     -18.8%       1643 ± 60%     -74.2%     521.59 ± 40%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
>       1624 ± 25%     -12.1%       1428 ± 62%     -75.0%     405.54 ± 42%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
>       2801 ± 45%     -40.4%       1669 ± 81%     -54.5%       1273 ± 52%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>      55.19            -0.7       54.46            -0.6       54.55        perf-profile.calltrace.cycles-pp.read
>      53.91            -0.6       53.30            -0.8       53.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>      53.76            -0.6       53.16            -0.8       52.98        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      52.41            -0.5       51.92            -1.1       51.32        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      52.02            -0.5       51.56            -1.1       50.92        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      50.82            -0.4       50.46            -1.2       49.67        perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      50.29            -0.3       49.98            -1.2       49.12        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
>      49.61            -0.3       49.36            -1.2       48.42        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
>      49.37            -0.2       49.13            -1.2       48.17        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
>      24.50            -0.2       24.29 ±  4%      -1.1       23.39        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
>       5.54 ±  2%      -0.2        5.34 ±  6%      -0.3        5.25 ±  2%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
>       5.49 ±  2%      -0.2        5.29 ±  6%      -0.3        5.20 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
>       5.40 ±  2%      -0.2        5.21 ±  6%      -0.3        5.11 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
>      24.31            -0.2       24.12 ±  4%      -1.1       23.20        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
>       2.86 ±  2%      -0.2        2.68 ±  5%      -0.2        2.65 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
>       1.60 ±  2%      -0.1        1.45 ±  5%      -0.0        1.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
>       1.50 ±  2%      -0.1        1.36 ±  6%      -0.0        1.50        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
>       0.62 ±  2%      -0.1        0.50 ± 38%      +0.3        0.95        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
>       2.76 ±  2%      -0.1        2.66 ±  6%      -0.3        2.45 ±  2%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
>       2.65 ±  2%      -0.1        2.55 ±  6%      -0.3        2.34 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
>       0.97 ±  2%      -0.1        0.89 ±  5%      +0.3        1.26        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.78 ±  2%      -0.1        0.71 ±  7%      +0.4        1.18        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
>       1.24 ±  2%      -0.1        1.16 ±  5%      +0.1        1.31 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>       2.20 ±  2%      -0.1        2.14 ±  6%      -0.3        1.90 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
>      26.13            -0.0       26.09 ±  3%      -1.0       25.11        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
>       0.53 ±  2%      -0.0        0.49 ± 38%      +0.3        0.79 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_stream_data_wait
>       1.03 ±  3%      -0.0        1.02 ±  9%      +0.1        1.12        perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
>       0.66 ±  2%      -0.0        0.65 ±  6%      +0.1        0.79        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.00            +0.0        0.00            +0.6        0.61        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
>       1.83 ±  2%      +0.1        1.88 ±  6%      +0.8        2.61        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
>       1.87 ±  2%      +0.1        1.93 ±  6%      +0.8        2.68        perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
>       1.79 ±  2%      +0.1        1.85 ±  6%      +0.8        2.56        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic
>       2.30 ±  2%      +0.1        2.37 ±  6%      +1.0        3.30        perf-profile.calltrace.cycles-pp.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
>       0.40 ± 53%      +0.1        0.48 ± 38%      +0.4        0.77 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__schedule.schedule.schedule_timeout
>       0.00            +0.3        0.26 ±100%      +0.6        0.61        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_stream_data_wait
>       1.62 ±  3%      +0.3        1.93 ± 24%      +0.9        2.48        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable
>       1.63 ±  3%      +0.3        1.94 ± 24%      +0.9        2.50        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg
>       1.71 ±  3%      +0.3        2.03 ± 23%      +0.9        2.61        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter
>      39.00            +0.5       39.50            +0.1       39.13        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      37.56            +0.6       38.15            +0.1       37.67        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
>       1.96 ±  3%      +0.7        2.63 ± 24%      +1.1        3.08        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write
>       3.52 ±  2%      +0.7        4.23 ± 15%      +1.1        4.62 ±  2%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
>      55.93            -0.8       55.12            -0.7       55.27        perf-profile.children.cycles-pp.read
>      52.45            -0.5       51.95            -1.1       51.36        perf-profile.children.cycles-pp.ksys_read
>      52.06            -0.5       51.60            -1.1       50.96        perf-profile.children.cycles-pp.vfs_read
>      50.85            -0.4       50.48            -1.2       49.69        perf-profile.children.cycles-pp.sock_read_iter
>      50.34            -0.3       50.03            -1.2       49.17        perf-profile.children.cycles-pp.sock_recvmsg
>       4.68 ±  2%      -0.3        4.38 ±  5%      -0.2        4.49        perf-profile.children.cycles-pp.__memcg_slab_free_hook
>      49.64            -0.3       49.38            -1.2       48.45        perf-profile.children.cycles-pp.unix_stream_recvmsg
>      49.50            -0.2       49.25            -1.2       48.30        perf-profile.children.cycles-pp.unix_stream_read_generic
>      24.52            -0.2       24.32 ±  4%      -1.1       23.41        perf-profile.children.cycles-pp.alloc_skb_with_frags
>       5.57 ±  2%      -0.2        5.36 ±  6%      -0.3        5.27 ±  2%  perf-profile.children.cycles-pp.unix_stream_read_actor
>       5.52 ±  2%      -0.2        5.31 ±  6%      -0.3        5.22 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
>      24.38            -0.2       24.18 ±  4%      -1.1       23.27        perf-profile.children.cycles-pp.__alloc_skb
>       5.43 ±  2%      -0.2        5.24 ±  6%      -0.3        5.14 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
>      95.87            -0.2       95.70            -0.5       95.42        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       3.46 ±  2%      -0.2        3.29 ±  6%      -0.3        3.16        perf-profile.children.cycles-pp.__check_object_size
>       1.77 ±  2%      -0.2        1.61 ±  5%      -0.0        1.76        perf-profile.children.cycles-pp.entry_SYSCALL_64
>       1.87 ±  2%      -0.2        1.72 ±  5%      +0.0        1.87 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
>      95.57            -0.1       95.43            -0.5       95.11        perf-profile.children.cycles-pp.do_syscall_64
>       2.79 ±  2%      -0.1        2.68 ±  6%      -0.3        2.48        perf-profile.children.cycles-pp.simple_copy_to_iter
>       2.62 ±  2%      -0.1        2.53 ±  6%      -0.3        2.33 ±  2%  perf-profile.children.cycles-pp.check_heap_object
>       1.69 ±  2%      -0.1        1.60 ±  5%      +0.4        2.12        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.90 ±  2%      -0.1        0.83 ±  5%      -0.0        0.90        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.85 ±  2%      -0.1        0.78 ±  5%      +0.0        0.86 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
>       0.10 ±  4%      -0.1        0.04 ±104%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__handle_mm_fault
>       0.10 ±  4%      -0.1        0.04 ±104%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.handle_mm_fault
>       0.10 ±  4%      -0.1        0.04 ±102%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.do_user_addr_fault
>       0.10 ±  4%      -0.1        0.04 ±102%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.exc_page_fault
>       0.63 ±  2%      -0.1        0.57 ±  5%      +0.0        0.64        perf-profile.children.cycles-pp.__cond_resched
>      26.17            -0.0       26.13 ±  3%      -1.0       25.15        perf-profile.children.cycles-pp.sock_alloc_send_pskb
>       0.10 ±  4%      -0.0        0.05 ± 63%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.asm_exc_page_fault
>       0.32 ±  2%      -0.0        0.28 ±  3%      +0.0        0.33        perf-profile.children.cycles-pp.task_mm_cid_work
>       0.32 ±  2%      -0.0        0.28 ±  3%      +0.0        0.33        perf-profile.children.cycles-pp.task_work_run
>       0.34 ±  2%      -0.0        0.30 ±  5%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
>       0.32 ±  3%      -0.0        0.29 ±  6%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
>       0.32 ±  3%      -0.0        0.29 ±  5%      +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       0.05            -0.0        0.02 ±129%      +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.avg_vruntime
>       0.18 ±  4%      -0.0        0.16 ±  7%      +0.1        0.27        perf-profile.children.cycles-pp.__enqueue_entity
>       0.47 ±  2%      -0.0        0.44 ±  5%      +0.0        0.50        perf-profile.children.cycles-pp.mutex_lock
>       0.23 ±  3%      -0.0        0.21 ±  6%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.set_next_entity
>       0.14 ±  4%      -0.0        0.12 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__dequeue_entity
>       1.05 ±  3%      -0.0        1.04 ±  9%      +0.1        1.14        perf-profile.children.cycles-pp.skb_set_owner_w
>       0.28 ±  2%      -0.0        0.26 ±  7%      +0.1        0.38        perf-profile.children.cycles-pp.switch_fpu_return
>       0.48 ±  2%      -0.0        0.47 ±  6%      +0.2        0.70        perf-profile.children.cycles-pp.enqueue_entity
>       0.08 ±  3%      -0.0        0.07 ±  9%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
>       0.24 ±  4%      -0.0        0.22 ±  6%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
>       0.06            -0.0        0.05            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.cpuacct_charge
>       0.29 ±  3%      -0.0        0.28 ±  7%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>       0.16 ±  2%      -0.0        0.15 ±  4%      +0.0        0.18        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.12 ±  3%      -0.0        0.12 ±  6%      +0.1        0.18        perf-profile.children.cycles-pp.update_rq_clock_task
>       0.18 ±  3%      -0.0        0.17 ±  6%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
>       0.18 ±  4%      -0.0        0.17 ±  6%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.rseq_ip_fixup
>       0.05 ±  6%      -0.0        0.04 ± 37%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
>       0.05            -0.0        0.04 ± 37%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.sched_clock
>       0.07 ±  7%      -0.0        0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.os_xsave
>       0.13 ±  6%      -0.0        0.12 ±  6%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
>       0.12 ±  6%      -0.0        0.12 ±  7%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__get_user_8
>       0.14 ±  3%      -0.0        0.13 ±  7%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.wakeup_preempt
>       0.09 ±  5%      -0.0        0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
>       0.14 ±  3%      -0.0        0.13 ±  4%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.18 ±  2%      -0.0        0.17 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.put_cpu_partial
>       0.13 ±  3%      -0.0        0.13 ±  7%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.pick_eevdf
>       0.07 ±  4%      -0.0        0.07 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
>       0.08 ±  5%      -0.0        0.08 ±  8%      +0.0        0.13        perf-profile.children.cycles-pp.update_curr_se
>       0.06 ±  5%      -0.0        0.06 ±  5%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.07            +0.0        0.07 ±  7%      +0.0        0.11        perf-profile.children.cycles-pp.put_prev_entity
>       0.00            +0.0        0.00            +0.1        0.05        perf-profile.children.cycles-pp.__put_user_8
>       0.06 ± 10%      +0.0        0.06 ± 21%      +0.4        0.43 ±  4%  perf-profile.children.cycles-pp.get_any_partial
>       0.22 ±  3%      +0.0        0.22 ±  7%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
>       0.06 ±  6%      +0.0        0.06 ± 10%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.12 ±  2%      +0.0        0.12 ±  7%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.wake_affine
>       0.07            +0.0        0.07 ± 11%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_min_vruntime
>       0.10 ±  4%      +0.0        0.11 ±  7%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.05 ± 35%      +0.0        0.06 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_tp_event
>       0.09 ± 35%      +0.0        0.10 ±  7%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       0.05 ± 36%      +0.0        0.05 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.place_entity
>       0.07 ±  4%      +0.0        0.08 ±  9%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.task_h_load
>       0.00            +0.0        0.01 ±264%      +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.12 ±  4%      +0.0        0.12 ±  8%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.__switch_to
>       0.12 ±  3%      +0.0        0.13 ±  6%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.75 ±  2%      +0.0        0.76 ±  7%      +0.3        1.08        perf-profile.children.cycles-pp.enqueue_task_fair
>       0.16 ±  5%      +0.0        0.17 ±  7%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
>       0.47 ±  2%      +0.0        0.49 ±  6%      +0.2        0.64        perf-profile.children.cycles-pp.update_load_avg
>       0.64 ±  2%      +0.0        0.65 ±  6%      +0.3        0.90        perf-profile.children.cycles-pp.dequeue_task_fair
>       0.76 ±  2%      +0.0        0.78 ±  4%      +0.2        0.98        perf-profile.children.cycles-pp.pick_next_task_fair
>       0.22 ±  3%      +0.0        0.23 ±  7%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.pick_task_fair
>       0.12 ±  4%      +0.0        0.13 ± 14%      +0.1        0.17        perf-profile.children.cycles-pp.reweight_entity
>       0.20 ±  3%      +0.0        0.22 ±  6%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.sched_tick
>       0.88 ±  2%      +0.0        0.90 ±  7%      +0.4        1.29        perf-profile.children.cycles-pp.ttwu_do_activate
>       0.30 ±  4%      +0.0        0.32 ±  7%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
>       0.35 ±  2%      +0.0        0.37 ±  5%      +0.1        0.49        perf-profile.children.cycles-pp.dequeue_entity
>       0.31 ±  4%      +0.0        0.33 ±  6%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.29 ±  4%      +0.0        0.31 ±  6%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.update_process_times
>       0.13 ±  2%      +0.0        0.15 ± 11%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
>       0.18 ±  2%      +0.0        0.21 ±  8%      +0.1        0.26        perf-profile.children.cycles-pp.prepare_task_switch
>       0.35 ±  3%      +0.0        0.37 ±  5%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.35 ±  3%      +0.0        0.37 ±  6%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.63 ±  2%      +0.0        0.65 ±  7%      +0.3        0.89 ±  2%  perf-profile.children.cycles-pp.dequeue_entities
>       0.09 ±  8%      +0.0        0.12 ±  7%      +0.0        0.11 ± 11%  perf-profile.children.cycles-pp.generic_perform_write
>       2.21 ±  2%      +0.0        2.23 ±  6%      +0.8        3.04        perf-profile.children.cycles-pp.schedule_timeout
>       0.07 ± 10%      +0.0        0.10 ± 11%      +0.0        0.08 ± 20%  perf-profile.children.cycles-pp.sched_balance_find_src_group
>       0.06 ± 10%      +0.0        0.09 ± 11%      +0.0        0.06 ± 40%  perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.07 ± 10%      +0.0        0.10 ± 11%      +0.0        0.07 ± 19%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.10 ±  3%      +0.0        0.13 ± 14%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
>       0.01 ±282%      +0.0        0.04 ± 57%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
>       0.43 ±  3%      +0.0        0.47 ±  7%      +0.2        0.64        perf-profile.children.cycles-pp.update_curr
>       0.13 ±  8%      +0.0        0.16 ±  8%      +0.0        0.16 ± 12%  perf-profile.children.cycles-pp.writen
>       0.39 ±  3%      +0.0        0.42 ±  6%      +0.1        0.48 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.42 ±  3%      +0.0        0.46 ±  6%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.02 ±111%      +0.0        0.06 ± 13%      +0.0        0.04 ± 38%  perf-profile.children.cycles-pp.set_task_cpu
>       0.02 ±141%      +0.0        0.06 ± 11%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.ring_buffer_read_head
>       2.45 ±  2%      +0.0        2.50 ±  6%      +1.0        3.43        perf-profile.children.cycles-pp.schedule
>       0.00            +0.1        0.06 ±  8%      +0.0        0.03 ± 77%  perf-profile.children.cycles-pp.vruntime_eligible
>       0.22 ±  8%      +0.1        0.28 ±  9%      +0.1        0.27 ± 12%  perf-profile.children.cycles-pp.perf_mmap__push
>       0.23 ±  8%      +0.1        0.29 ±  9%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.record__mmap_read_evlist
>       0.23 ±  7%      +0.1        0.29 ±  9%      +0.1        0.28 ± 11%  perf-profile.children.cycles-pp.cmd_record
>       0.23 ±  7%      +0.1        0.30 ±  9%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.handle_internal_command
>       0.23 ±  7%      +0.1        0.30 ±  9%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.main
>       0.23 ±  7%      +0.1        0.30 ±  9%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.run_builtin
>       2.31 ±  2%      +0.1        2.38 ±  7%      +1.0        3.32        perf-profile.children.cycles-pp.unix_stream_data_wait
>       0.18 ± 38%      +0.1        0.26 ± 17%      +0.2        0.41 ±  3%  perf-profile.children.cycles-pp.ordered_events__queue
>       0.18 ± 38%      +0.1        0.26 ± 17%      +0.2        0.41 ±  3%  perf-profile.children.cycles-pp.queue_event
>       0.19 ± 37%      +0.1        0.26 ± 16%      +0.2        0.41 ±  3%  perf-profile.children.cycles-pp.process_simple
>       0.00            +0.1        0.07 ± 19%      +0.0        0.00        perf-profile.children.cycles-pp.schedule_idle
>       0.19 ± 37%      +0.1        0.29 ± 17%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.perf_session__process_events
>       0.19 ± 37%      +0.1        0.29 ± 17%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.reader__read_event
>       0.19 ± 37%      +0.1        0.29 ± 17%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.record__finish_output
>       2.45 ±  2%      +0.1        2.56 ±  6%      +1.0        3.43        perf-profile.children.cycles-pp.__schedule
>       0.00            +0.1        0.12 ± 19%      +0.0        0.00        perf-profile.children.cycles-pp.flush_smp_call_function_queue
>       0.42 ± 18%      +0.1        0.54 ± 23%      +0.3        0.70 ±  4%  perf-profile.children.cycles-pp.__cmd_record
>       0.00            +0.1        0.14 ± 20%      +0.0        0.00        perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.00            +0.2        0.15 ± 17%      +0.0        0.00        perf-profile.children.cycles-pp.intel_idle
>       0.00            +0.2        0.17 ± 18%      +0.0        0.00        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       0.01 ±282%      +0.2        0.18 ± 70%      +0.1        0.06        perf-profile.children.cycles-pp.available_idle_cpu
>       0.23 ±  3%      +0.2        0.43 ± 16%      +0.1        0.31        perf-profile.children.cycles-pp.prepare_to_wait
>       0.00            +0.2        0.20 ± 18%      +0.0        0.03 ±104%  perf-profile.children.cycles-pp.cpuidle_enter
>       0.00            +0.2        0.20 ± 18%      +0.0        0.03 ±104%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.01 ±282%      +0.2        0.22 ± 16%      +0.0        0.04 ± 81%  perf-profile.children.cycles-pp.cpuidle_idle_call
>       3.50 ±  2%      +0.2        3.73 ±  8%      +0.4        3.87 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
>       1.81 ±  3%      +0.3        2.12 ± 22%      +0.9        2.68        perf-profile.children.cycles-pp.autoremove_wake_function
>       1.80 ±  3%      +0.3        2.12 ± 22%      +0.9        2.66        perf-profile.children.cycles-pp.try_to_wake_up
>       1.89 ±  3%      +0.3        2.22 ± 21%      +0.9        2.80        perf-profile.children.cycles-pp.__wake_up_common
>       0.00            +0.3        0.35 ±110%      +0.0        0.00        perf-profile.children.cycles-pp.select_idle_cpu
>       0.06 ±  6%      +0.4        0.41 ± 95%      +0.0        0.09 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
>       0.22 ±  2%      +0.4        0.57 ± 70%      +0.1        0.31        perf-profile.children.cycles-pp.select_task_rq_fair
>       0.26 ±  5%      +0.4        0.62 ± 65%      +0.1        0.38        perf-profile.children.cycles-pp.select_task_rq
>       0.04 ± 77%      +0.4        0.43 ± 18%      +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.start_secondary
>       0.04 ± 77%      +0.4        0.43 ± 18%      +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.do_idle
>       0.04 ± 77%      +0.4        0.43 ± 17%      +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.common_startup_64
>       0.04 ± 77%      +0.4        0.43 ± 17%      +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.cpu_startup_entry
>      40.28            +0.4       40.71            +0.2       40.46        perf-profile.children.cycles-pp.vfs_write
>      39.04            +0.5       39.54            +0.1       39.18        perf-profile.children.cycles-pp.sock_write_iter
>      37.73            +0.6       38.31            +0.1       37.84        perf-profile.children.cycles-pp.unix_stream_sendmsg
>       2.15 ±  3%      +0.7        2.82 ± 23%      +1.1        3.27        perf-profile.children.cycles-pp.__wake_up_sync_key
>       3.55 ±  2%      +0.7        4.25 ± 15%      +1.1        4.65 ±  2%  perf-profile.children.cycles-pp.sock_def_readable
>       2.90 ±  2%      -0.2        2.74 ±  5%      -0.2        2.69 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
>       1.50 ±  2%      -0.1        1.37 ±  5%      +0.0        1.51 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
>       1.41 ±  2%      -0.1        1.30 ±  5%      -0.2        1.20 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.83 ±  3%      -0.1        0.74 ±  5%      -0.0        0.81        perf-profile.self.cycles-pp.read
>       0.88 ±  2%      -0.1        0.80 ±  5%      -0.0        0.88        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.74 ±  2%      -0.1        0.67 ±  5%      +0.0        0.75 ±  2%  perf-profile.self.cycles-pp.write
>       0.70 ±  2%      -0.1        0.64 ±  6%      +0.0        0.73 ±  2%  perf-profile.self.cycles-pp.vfs_read
>       0.67 ±  2%      -0.1        0.61 ±  5%      +0.0        0.68        perf-profile.self.cycles-pp.vfs_write
>       2.19 ±  2%      -0.1        2.13 ±  6%      -0.3        1.88 ±  2%  perf-profile.self.cycles-pp.check_heap_object
>       0.67 ±  2%      -0.1        0.62 ±  4%      -0.0        0.65        perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
>       0.52 ±  3%      -0.1        0.47 ±  4%      -0.0        0.52        perf-profile.self.cycles-pp.obj_cgroup_charge
>       0.51 ±  2%      -0.0        0.46 ±  5%      -0.0        0.51 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
>       0.29 ±  2%      -0.0        0.25 ±  3%      +0.0        0.31        perf-profile.self.cycles-pp.task_mm_cid_work
>       0.43 ±  2%      -0.0        0.40 ±  4%      +0.0        0.44        perf-profile.self.cycles-pp.do_syscall_64
>       0.34 ±  3%      -0.0        0.31 ±  6%      +0.0        0.35 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
>       0.29 ±  2%      -0.0        0.26 ±  6%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
>       0.33 ±  2%      -0.0        0.30 ±  6%      +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.__cond_resched
>       0.28 ±  3%      -0.0        0.25 ±  5%      +0.0        0.31 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.37 ±  2%      -0.0        0.34 ±  6%      -0.0        0.36        perf-profile.self.cycles-pp.__check_object_size
>       0.18 ±  5%      -0.0        0.15 ±  6%      +0.1        0.27        perf-profile.self.cycles-pp.__enqueue_entity
>       0.70            -0.0        0.67 ±  2%      -0.1        0.60        perf-profile.self.cycles-pp.get_partial_node
>       0.21 ±  3%      -0.0        0.18 ±  6%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
>       0.22 ±  3%      -0.0        0.20 ±  6%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
>       0.34 ±  2%      -0.0        0.32 ±  5%      +0.0        0.37        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>       1.75 ±  2%      -0.0        1.72 ±  5%      -0.1        1.63 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
>       0.95            -0.0        0.93            -0.1        0.87        perf-profile.self.cycles-pp.___slab_alloc
>       0.42 ±  2%      -0.0        0.40 ±  7%      +0.0        0.45 ±  2%  perf-profile.self.cycles-pp.skb_release_data
>       0.19 ±  2%      -0.0        0.17 ±  6%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.rw_verify_area
>       1.03 ±  3%      -0.0        1.02 ±  9%      +0.1        1.12        perf-profile.self.cycles-pp.skb_set_owner_w
>       0.03 ± 89%      -0.0        0.01 ±173%      +0.0        0.06        perf-profile.self.cycles-pp.avg_vruntime
>       0.06 ±  5%      -0.0        0.04 ± 37%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.cpuacct_charge
>       0.32 ±  2%      -0.0        0.30 ±  5%      +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.mutex_lock
>       0.11 ±  4%      -0.0        0.10 ±  7%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__dequeue_entity
>       0.06 ±  8%      -0.0        0.05 ± 38%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.prepare_to_wait
>       0.18 ±  3%      -0.0        0.17 ±  7%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
>       0.11 ±  4%      -0.0        0.10 ±  6%      +0.1        0.17        perf-profile.self.cycles-pp.update_rq_clock_task
>       0.29 ±  3%      -0.0        0.28 ±  7%      +0.1        0.40 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>       0.12 ±  3%      -0.0        0.11 ±  7%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__get_user_8
>       0.05            -0.0        0.04 ± 37%      +0.0        0.07 ±  4%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
>       0.01 ±282%      -0.0        0.00            +0.1        0.06        perf-profile.self.cycles-pp.place_entity
>       0.09 ±  3%      -0.0        0.08 ±  8%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.unix_stream_data_wait
>       0.22 ±  3%      -0.0        0.22 ±  7%      +0.1        0.31 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
>       0.05 ±  8%      -0.0        0.05 ± 40%      +0.0        0.07        perf-profile.self.cycles-pp.dequeue_entities
>       0.10 ±  5%      -0.0        0.10 ±  7%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
>       0.05            -0.0        0.05 ± 38%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.05            -0.0        0.05 ± 38%      +0.0        0.07 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
>       0.13 ±  3%      -0.0        0.12 ±  5%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.10 ±  3%      -0.0        0.10 ±  7%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
>       0.17            -0.0        0.17            -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.put_cpu_partial
>       0.06 ±  7%      -0.0        0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.os_xsave
>       0.32            -0.0        0.32 ±  2%      -0.0        0.28        perf-profile.self.cycles-pp.__put_partials
>       0.08 ±  3%      -0.0        0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.update_curr_se
>       0.09 ±  5%      -0.0        0.09 ±  7%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.schedule_timeout
>       0.11 ±  4%      -0.0        0.11 ±  6%      +0.0        0.13        perf-profile.self.cycles-pp.pick_eevdf
>       0.06 ±  5%      -0.0        0.06 ±  5%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.dequeue_entity
>       0.06            -0.0        0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.pick_task_fair
>       0.00            +0.0        0.00            +0.1        0.05 ±  6%  perf-profile.self.cycles-pp.select_task_rq_fair
>       0.00            +0.0        0.00            +0.1        0.06        perf-profile.self.cycles-pp.reweight_entity
>       0.09 ±  3%      +0.0        0.09 ±  5%      +0.0        0.13        perf-profile.self.cycles-pp.finish_task_switch
>       0.07 ±  7%      +0.0        0.07 ±  8%      +0.0        0.10        perf-profile.self.cycles-pp.update_min_vruntime
>       0.23 ±  2%      +0.0        0.23 ±  7%      +0.1        0.30        perf-profile.self.cycles-pp.update_load_avg
>       0.07 ±  9%      +0.0        0.07 ±  9%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.task_h_load
>       0.10 ±  3%      +0.0        0.10 ±  6%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.04 ± 53%      +0.0        0.04 ± 38%      +0.0        0.07 ±  4%  perf-profile.self.cycles-pp.select_task_rq
>       0.00            +0.0        0.01 ±264%      +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.12 ±  2%      +0.0        0.13 ±  6%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.01 ±187%      +0.0        0.02 ±129%      +0.0        0.06        perf-profile.self.cycles-pp.perf_tp_event
>       0.11 ±  3%      +0.0        0.12 ±  8%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__switch_to
>       0.08 ±  5%      +0.0        0.09 ±  7%      +0.0        0.12 ±  2%  perf-profile.self.cycles-pp.__wake_up_common
>       0.24 ±  2%      +0.0        0.26 ±  7%      +0.1        0.35        perf-profile.self.cycles-pp.__schedule
>       0.12 ±  5%      +0.0        0.14 ± 11%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.update_curr
>       0.00            +0.0        0.02 ±129%      +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
>       0.13 ±  3%      +0.0        0.15 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.prepare_task_switch
>       0.05            +0.0        0.08 ± 23%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
>       0.00            +0.0        0.04 ± 38%      +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
>       0.00            +0.1        0.06 ± 11%      +0.0        0.05 ± 38%  perf-profile.self.cycles-pp.ring_buffer_read_head
>       0.18 ± 37%      +0.1        0.25 ± 17%      +0.2        0.40 ±  3%  perf-profile.self.cycles-pp.queue_event
>       0.00            +0.2        0.15 ± 17%      +0.0        0.00        perf-profile.self.cycles-pp.intel_idle
>       0.01 ±282%      +0.2        0.18 ± 70%      +0.0        0.05 ±  8%  perf-profile.self.cycles-pp.available_idle_cpu


