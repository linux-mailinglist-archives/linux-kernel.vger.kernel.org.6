Return-Path: <linux-kernel+bounces-231848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E58919F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D351F21AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257929CA;
	Thu, 27 Jun 2024 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNxb0kOo"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065920B33
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719469560; cv=none; b=W2HZ08bA6CN/L9jGZRZmRsAQ1Vg5a+0+c4j2y5/7gGWsw4TC9Y/qxgbSF0KUwCrc0e4O7fsKNlANwGNc5UzbphSd14ihcD1x08NL1HExQi/VqwTf/WjWDlDJPQxv432O7D7etVwRO2rF5LT/GzXDChfswCd06kjCdtv4c760KEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719469560; c=relaxed/simple;
	bh=vG+SzmdS8P0cUKnB4zRhUxGmJiPPUeNp5rrLMK8VhRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwWisaU4fXJDk9pN0DdpqV8u0CHLaLg+cCSPfxTAG2be4FLv5K0xahvuglRLgd9APMLMfaUfDn7+czooyCacssU4WMcNL+9/dK2BjdVDp0+uL0nWtZ0DsjmtF8/T0OzEs6loIaCSV0HljhBQqQgi0+BzyXZ+/1if1l1H4Llmf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNxb0kOo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec5779b423so54407551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719469550; x=1720074350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iALBCKDo512J8eIe3REq2aAF8DBC4yqdBdR//DEXio=;
        b=DNxb0kOoX5Ut1BRpFHGd9z22FiuoHobRnrB4ePKIergiCUdVA3GJSZI4UjI6IcI8j+
         B3an9W01j64KhN5RfcPmPmQLsnHYDG49kGmZ6QZEsIoJwtLsLhfebDl5t13yd2n+ZeEz
         484uRXW5wF2ipqG+g8vhMCAngBjNJt7JZB6BAjxwnvNRYqduIjAGBA8fa+TKIvJ1W7ah
         w8Wb+CTm3U1YWmVFQXTY4grAFuC9KHjxDBFxN1yCcPeR4u31jpwePQrXTJf0X6MZIoXL
         8vSPMvq1WboGS7qhaQiLiguQVzZ36Z/K35YQhAdDT15ic0hjxKFrU32yeAAn9ISMflrO
         NeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719469550; x=1720074350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iALBCKDo512J8eIe3REq2aAF8DBC4yqdBdR//DEXio=;
        b=B/23TlUdUXU0+npju8TcH7BZ5OtuEd2qSMPOS8Ekud+uXlL0+ui+VV15Z//aNoMy8A
         27MeDU5GLfucVe97980jBRHE+/t+ySNZT6Xc6O8hHYapJwNQTo9X459r+e9GsVui+uT5
         E6CLu8xIYhY/StyliXA9sctzYFhbhxpjcxjWBv223Lur1i/ANbthg1QNBzG1UY3UnLOa
         IsRGypOfAwN6y57rKeRicDjqopdvtPgZoZe8H0LeC7AzBiRUJ3minp1As3DYiNn+xxLG
         umCaWWFf0EFWdpKwXWFARunnSieMvEU/Q+FAZ/77Xqa9Dc9T3YjonDfO8XGRoLiTgD/w
         N2kw==
X-Forwarded-Encrypted: i=1; AJvYcCW29Az4R0901gtj1rvuld64OlJmcOCdQCJoe1yS8FJvBx8ei96njZiaVgCCRTVItdDDwmbm1bzEyO5LZZMEz41W5VX433e5oDzGqFVH
X-Gm-Message-State: AOJu0YxyPHXmbYKLmnbvypq4XQm99RL/LeBHqiU3u4WpHGM794bnzdts
	R5lFpYvdHh71YbQ/zQVeP45oWMu/8p+/sCiSJgKNF4b3bkePc1ucGVOm4RehS5P0GECl8N3f0nL
	VckgfjZpM5akV7gfmR5usZyoqeIE=
X-Google-Smtp-Source: AGHT+IFmOxKoLxfscVwz11YUdhcoUEmmrEjMfk5cP40SYksxbrOsVgxcDOlxxNPXtvLi++IPW2BpyRZbe02d3x3x2Pg=
X-Received: by 2002:a2e:a7d6:0:b0:2ec:6ee2:b628 with SMTP id
 38308e7fff4ca-2ec6ee2b811mr59071961fa.12.1719469549419; Wed, 26 Jun 2024
 23:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com>
In-Reply-To: <202406270912.633e6c61-oliver.sang@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Jun 2024 08:25:35 +0200
Message-ID: <CAGudoHF7ys8bTCE0G6vLzEbo+_NyQXmAEEGPJ4hx1yoYmBsoUA@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:41=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -33.7% regression of unixbench.throughput on:
>
>
> commit: d042dae6ad74df8a00ee8a3c6b77b53bc9e32f64 ("lockref: speculatively=
 spin waiting for the lock to be released")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> testcase: unixbench
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> parameters:
>
>         runtime: 300s
>         nr_task: 100%
>         test: shell1
>         cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
--------------------------------------+
> | testcase: change | stress-ng: stress-ng.getdent.ops_per_sec -56.5% regr=
ession                                |
> | test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU =
@ 3.10GHz (Ice Lake) with 256G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                        |
> |                  | disk=3D1HDD                                         =
                                        |
> |                  | fs=3Dext4                                           =
                                        |
> |                  | nr_threads=3D100%                                   =
                                        |
> |                  | test=3Dgetdent                                      =
                                        |
> |                  | testtime=3D60s                                      =
                                        |
> +------------------+-----------------------------------------------------=
--------------------------------------+

I don't know what about that blogbench thing yet.

As far as this one goes I booted my 24-way vm and ran stress-ng --getdent 2=
4.

Even at that scale there is plenty of off cpu time:
%Cpu(s):  3.2 us, 50.3 sy,  0.0 ni, 34.5 id,  0.0 wa,  0.0 hi,  0.0 si, 12.=
0 st

As in threads keep being put off cpu.

Turns out this benchmark uses fs/eventfs, not a normal filesystem.

Top spinning spots:

@[
    osq_lock+5
    __mutex_lock.constprop.0+138
    eventfs_iterate+121
    iterate_dir+286
    __x64_sys_getdents+136
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
]: 234292
@[
    osq_lock+5
    __mutex_lock.constprop.0+138
    eventfs_iterate+121
    iterate_dir+286
    __x64_sys_getdents64+136
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
]: 234705
@[
    osq_lock+5
    __mutex_lock.constprop.0+138
    eventfs_iterate+356
    iterate_dir+286
    __x64_sys_getdents+136
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
]: 530114
@[
    osq_lock+5
    __mutex_lock.constprop.0+138
    eventfs_iterate+356
    iterate_dir+286
    __x64_sys_getdents64+136
    do_syscall_64+82
    entry_SYSCALL_64_after_hwframe+118
]: 530231

eventfs_iterate has the following goodies:
       mutex_lock(&eventfs_mutex);
        ei =3D READ_ONCE(ti->private);
        if (ei && ei->is_freed)
                ei =3D NULL;
        mutex_unlock(&eventfs_mutex);

        if (!ei)
                goto out;

        /*
         * Need to create the dentries and inodes to have a consistent
         * inode number.
         */
        ret =3D 0;

        /* Start at 'c' to jump over already read entries */
        for (i =3D c; i < ei->nr_entries; i++, ctx->pos++) {
                void *cdata =3D ei->data;

                entry =3D &ei->entries[i];
                name =3D entry->name;

                mutex_lock(&eventfs_mutex);
                /* If ei->is_freed then just bail here, nothing more to do =
*/
                if (ei->is_freed) {
                        mutex_unlock(&eventfs_mutex);
                        goto out;
                }
                r =3D entry->callback(name, &mode, &cdata, &fops);
                mutex_unlock(&eventfs_mutex);

That is to say takes mutex on entry and then relocks it for every
emitted element.

less spinning on locks must have put more pressure here resulting in
more off cpu time.

This is basically a typical sad case of enough speed up to cause a
slowdown because a more degrading component got more work.

However, arguably even with the mutex thing it should have stayed
consistnely on cpu. I can't get an offcpu backtrace at the moment,
I'll poke around and get back to you over the weekend.

> | testcase: change | stress-ng: stress-ng.getdent.ops_per_sec -54.6% regr=
ession                                |
> | test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU =
@ 3.10GHz (Ice Lake) with 256G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                        |
> |                  | disk=3D1HDD                                         =
                                        |
> |                  | fs=3Dxfs                                            =
                                        |
> |                  | nr_threads=3D100%                                   =
                                        |
> |                  | test=3Dgetdent                                      =
                                        |
> |                  | testtime=3D60s                                      =
                                        |
> +------------------+-----------------------------------------------------=
--------------------------------------+
> | testcase: change | stress-ng: stress-ng.handle.ops_per_sec -60.2% regre=
ssion                                 |
> | test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU =
@ 3.10GHz (Ice Lake) with 256G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                        |
> |                  | disk=3D1HDD                                         =
                                        |
> |                  | fs=3Dbtrfs                                          =
                                        |
> |                  | nr_threads=3D100%                                   =
                                        |
> |                  | test=3Dhandle                                       =
                                        |
> |                  | testtime=3D60s                                      =
                                        |
> +------------------+-----------------------------------------------------=
--------------------------------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406270912.633e6c61-oliver.san=
g@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240627/202406270912.633e6c61-ol=
iver.sang@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/=
testcase:
>   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/3=
00s/lkp-icl-2sp9/shell1/unixbench
>
> commit:
>   267574dee6 ("bcachefs: remove now spurious i_state initialization")
>   d042dae6ad ("lockref: speculatively spin waiting for the lock to be rel=
eased")
>
> 267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      66668 =C4=85 21%     -42.2%      38533 =C4=85 38%  numa-meminfo.node=
1.Mapped
>      18895           -16.6%      15755        uptime.idle
>  1.694e+10           -19.3%  1.368e+10        cpuidle..time
>   1.73e+08           -34.6%  1.131e+08        cpuidle..usage
>    2519063           -10.4%    2257044        meminfo.Active
>    2518692           -10.4%    2256964        meminfo.Active(anon)
>      98218 =C4=85  3%     -14.3%      84210        meminfo.Mapped
>    2632805           -10.8%    2348382        meminfo.Shmem
>  4.637e+08           -33.5%  3.083e+08        numa-numastat.node0.local_n=
ode
>  4.638e+08           -33.5%  3.083e+08        numa-numastat.node0.numa_hi=
t
>  4.623e+08           -33.4%  3.078e+08        numa-numastat.node1.local_n=
ode
>  4.624e+08           -33.4%  3.078e+08        numa-numastat.node1.numa_hi=
t
>      42.33           -19.7%      33.98        vmstat.cpu.id
>      38.88 =C4=85  2%     +19.5%      46.46 =C4=85  2%  vmstat.procs.r
>     598112           -31.3%     410958        vmstat.system.cs
>     339581           -24.9%     255122        vmstat.system.in
>  4.637e+08           -33.5%  3.083e+08        numa-vmstat.node0.numa_hit
>  4.637e+08           -33.5%  3.083e+08        numa-vmstat.node0.numa_loca=
l
>      16902 =C4=85 22%     -41.4%       9904 =C4=85 38%  numa-vmstat.node1=
.nr_mapped
>  4.623e+08           -33.4%  3.078e+08        numa-vmstat.node1.numa_hit
>  4.623e+08           -33.4%  3.078e+08        numa-vmstat.node1.numa_loca=
l
>       3589 =C4=85  2%     -21.5%       2817        perf-c2c.DRAM.local
>      23348           -13.7%      20144        perf-c2c.DRAM.remote
>      21000           -12.5%      18378        perf-c2c.HITM.local
>      15566           -15.1%      13213        perf-c2c.HITM.remote
>      36567           -13.6%      31591        perf-c2c.HITM.total
>      42.20            -8.4       33.82        mpstat.cpu.all.idle%
>       0.00 =C4=85 40%      -0.0        0.00 =C4=85 46%  mpstat.cpu.all.io=
wait%
>       0.94            -0.2        0.72        mpstat.cpu.all.irq%
>       0.58            -0.1        0.44        mpstat.cpu.all.soft%
>      48.63           +11.3       59.91        mpstat.cpu.all.sys%
>       7.66            -2.5        5.11        mpstat.cpu.all.usr%
>      63.66           +12.8%      71.79        mpstat.max_utilization_pct
>      32070           -33.7%      21253        unixbench.score
>     135979           -33.7%      90114        unixbench.throughput
>    8158942           -25.3%    6093181        unixbench.time.involuntary_=
context_switches
>     290307 =C4=85  3%     -45.0%     159813 =C4=85  3%  unixbench.time.ma=
jor_page_faults
>  1.151e+09           -33.6%  7.644e+08        unixbench.time.minor_page_f=
aults
>       3513           +16.5%       4092        unixbench.time.percent_of_c=
pu_this_job_got
>      17556           +34.0%      23525        unixbench.time.system_time
>       4600           -50.2%       2290        unixbench.time.user_time
>   1.87e+08           -26.4%  1.377e+08        unixbench.time.voluntary_co=
ntext_switches
>   85735355           -33.7%   56816908        unixbench.workload
>     629615           -10.4%     564266        proc-vmstat.nr_active_anon
>    1444170            -5.0%    1372570        proc-vmstat.nr_file_pages
>     208895            -2.6%     203360        proc-vmstat.nr_inactive_ano=
n
>      24755 =C4=85  3%     -14.4%      21183        proc-vmstat.nr_mapped
>     658148           -10.8%     587129        proc-vmstat.nr_shmem
>      26716            -1.3%      26369        proc-vmstat.nr_slab_reclaim=
able
>      47823            -2.1%      46838        proc-vmstat.nr_slab_unrecla=
imable
>     629615           -10.4%     564266        proc-vmstat.nr_zone_active_=
anon
>     208896            -2.7%     203360        proc-vmstat.nr_zone_inactiv=
e_anon
>  9.261e+08           -33.5%  6.161e+08        proc-vmstat.numa_hit
>   9.26e+08           -33.5%  6.161e+08        proc-vmstat.numa_local
>     637452            -8.6%     582748        proc-vmstat.pgactivate
>  1.644e+09           -33.5%  1.093e+09        proc-vmstat.pgalloc_normal
>  1.154e+09           -33.5%  7.669e+08        proc-vmstat.pgfault
>  1.643e+09           -33.5%  1.092e+09        proc-vmstat.pgfree
>   56834055           -33.4%   37832459        proc-vmstat.pgreuse
>    1352648           -33.5%     898973        proc-vmstat.thp_fault_alloc
>   18937408           -33.5%   12585970        proc-vmstat.unevictable_pgs=
_culled
>       3.37            -3.3%       3.26        perf-stat.i.MPKI
>  1.367e+10           -26.4%  1.006e+10        perf-stat.i.branch-instruct=
ions
>       1.65            -0.1        1.54        perf-stat.i.branch-miss-rat=
e%
>  2.225e+08           -31.8%  1.517e+08        perf-stat.i.branch-misses
>      22.57            +0.6       23.19        perf-stat.i.cache-miss-rate=
%
>  2.309e+08           -30.4%  1.607e+08        perf-stat.i.cache-misses
>   1.01e+09           -32.4%  6.832e+08        perf-stat.i.cache-reference=
s
>     600019           -31.3%     412413        perf-stat.i.context-switche=
s
>       2.03           +54.9%       3.14        perf-stat.i.cpi
>  1.388e+11           +12.2%  1.558e+11        perf-stat.i.cpu-cycles
>     149359           -41.6%      87198        perf-stat.i.cpu-migrations
>     607.93           +58.6%     964.42        perf-stat.i.cycles-between-=
cache-misses
>  6.741e+10           -28.0%  4.856e+10        perf-stat.i.instructions
>       0.50           -33.4%       0.33        perf-stat.i.ipc
>     459.84 =C4=85  3%     -45.0%     252.95 =C4=85  3%  perf-stat.i.major=
-faults
>      67.57           -33.6%      44.90        perf-stat.i.metric.K/sec
>    1788636           -33.6%    1187710        perf-stat.i.minor-faults
>    1789096           -33.6%    1187963        perf-stat.i.page-faults
>       3.42           -19.4%       2.76 =C4=85 44%  perf-stat.overall.MPKI
>       1.63            -0.4        1.26 =C4=85 44%  perf-stat.overall.bran=
ch-miss-rate%
>       0.49           -46.3%       0.26 =C4=85 44%  perf-stat.overall.ipc
>  1.365e+10           -38.5%  8.401e+09 =C4=85 44%  perf-stat.ps.branch-in=
structions
>  2.221e+08           -42.9%  1.268e+08 =C4=85 44%  perf-stat.ps.branch-mi=
sses
>  2.305e+08           -41.7%  1.343e+08 =C4=85 44%  perf-stat.ps.cache-mis=
ses
>  1.009e+09           -43.3%  5.714e+08 =C4=85 44%  perf-stat.ps.cache-ref=
erences
>     598981           -42.5%     344546 =C4=85 44%  perf-stat.ps.context-s=
witches
>     149116           -51.1%      72968 =C4=85 44%  perf-stat.ps.cpu-migra=
tions
>  6.731e+10           -39.8%  4.055e+10 =C4=85 44%  perf-stat.ps.instructi=
ons
>     459.54 =C4=85  3%     -54.1%     211.13 =C4=85 44%  perf-stat.ps.majo=
r-faults
>    1785795           -44.4%     992658 =C4=85 44%  perf-stat.ps.minor-fau=
lts
>    1786254           -44.4%     992869 =C4=85 44%  perf-stat.ps.page-faul=
ts
>  4.252e+13           -39.7%  2.562e+13 =C4=85 44%  perf-stat.total.instru=
ctions
>   12248217           +18.2%   14471390        sched_debug.cfs_rq:/.avg_vr=
untime.avg
>   13350177 =C4=85  2%     +15.0%   15350925        sched_debug.cfs_rq:/.a=
vg_vruntime.max
>   11977215           +18.2%   14153258        sched_debug.cfs_rq:/.avg_vr=
untime.min
>       0.60 =C4=85  4%     +23.0%       0.74 =C4=85  3%  sched_debug.cfs_r=
q:/.h_nr_running.avg
>    1255909 =C4=85 22%     -41.9%     730155 =C4=85 49%  sched_debug.cfs_r=
q:/.left_deadline.stddev
>    1255900 =C4=85 22%     -41.9%     730149 =C4=85 49%  sched_debug.cfs_r=
q:/.left_vruntime.stddev
>      25775 =C4=85 14%     -31.9%      17541 =C4=85 24%  sched_debug.cfs_r=
q:/.load.avg
>     111073 =C4=85 20%     -48.6%      57125 =C4=85 57%  sched_debug.cfs_r=
q:/.load.stddev
>      72.86 =C4=85  4%     -23.0%      56.07 =C4=85 11%  sched_debug.cfs_r=
q:/.load_avg.avg
>      13.98 =C4=85  4%     -17.7%      11.52 =C4=85  5%  sched_debug.cfs_r=
q:/.load_avg.min
>     167.77 =C4=85  7%     -20.9%     132.67 =C4=85 19%  sched_debug.cfs_r=
q:/.load_avg.stddev
>   12248217           +18.2%   14471390        sched_debug.cfs_rq:/.min_vr=
untime.avg
>   13350177 =C4=85  2%     +15.0%   15350925        sched_debug.cfs_rq:/.m=
in_vruntime.max
>   11977215           +18.2%   14153258        sched_debug.cfs_rq:/.min_vr=
untime.min
>       0.56 =C4=85  4%     +13.3%       0.63 =C4=85  2%  sched_debug.cfs_r=
q:/.nr_running.avg
>      33.64 =C4=85  9%     -31.9%      22.91 =C4=85 25%  sched_debug.cfs_r=
q:/.removed.load_avg.avg
>     152.13 =C4=85  9%     -22.1%     118.47 =C4=85 23%  sched_debug.cfs_r=
q:/.removed.load_avg.stddev
>    1255900 =C4=85 22%     -41.9%     730149 =C4=85 49%  sched_debug.cfs_r=
q:/.right_vruntime.stddev
>      95.73 =C4=85  4%     +38.2%     132.32 =C4=85  3%  sched_debug.cfs_r=
q:/.util_est.avg
>     514.30 =C4=85  4%     +21.0%     622.26 =C4=85  9%  sched_debug.cfs_r=
q:/.util_est.max
>     126.26 =C4=85  3%     +14.4%     144.47 =C4=85  5%  sched_debug.cfs_r=
q:/.util_est.stddev
>     157210 =C4=85  2%     +19.3%     187543        sched_debug.cpu.avg_id=
le.avg
>      38689 =C4=85 11%     +45.3%      56231 =C4=85  4%  sched_debug.cpu.a=
vg_idle.min
>    1131966 =C4=85  3%     +13.6%    1285770        sched_debug.cpu.curr->=
pid.avg
>       0.61 =C4=85  4%     +23.0%       0.75 =C4=85  3%  sched_debug.cpu.n=
r_running.avg
>    2807835           -31.2%    1931685        sched_debug.cpu.nr_switches=
.avg
>    2868532           -31.3%    1970626        sched_debug.cpu.nr_switches=
.max
>    2711163           -31.1%    1866782        sched_debug.cpu.nr_switches=
.min
>      31518 =C4=85 11%     -36.8%      19934 =C4=85 21%  sched_debug.cpu.n=
r_switches.stddev
>       0.88 =C4=85 14%     -29.6%       0.62 =C4=85 14%  sched_debug.cpu.n=
r_uninterruptible.avg
>      50293 =C4=85 22%     -71.2%      14501 =C4=85 18%  sched_debug.cpu.n=
r_uninterruptible.max
>     -43562           -52.2%     -20815        sched_debug.cpu.nr_uninterr=
uptible.min
>      19392 =C4=85 13%     -63.2%       7134 =C4=85  9%  sched_debug.cpu.n=
r_uninterruptible.stddev
>       7.02 =C4=85  4%      -4.1        2.92 =C4=85  7%  perf-profile.call=
trace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e
>       7.00 =C4=85  4%      -4.1        2.91 =C4=85  7%  perf-profile.call=
trace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>       6.96 =C4=85  4%      -4.1        2.88 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>       6.89 =C4=85  4%      -4.0        2.84 =C4=85  7%  perf-profile.call=
trace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscal=
l_64
>       7.34            -3.7        3.64 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.en=
try_SYSCALL_64_after_hwframe
>       6.86            -3.5        3.31        perf-profile.calltrace.cycl=
es-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscal=
l_64
>       6.84            -3.5        3.30        perf-profile.calltrace.cycl=
es-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x6=
4_sys_execve
>       7.94            -3.5        4.44        perf-profile.calltrace.cycl=
es-pp.execve
>       7.93            -3.5        4.44        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>       7.93            -3.5        4.44        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.execve
>       7.92            -3.5        4.44        perf-profile.calltrace.cycl=
es-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>       7.92            -3.5        4.43        perf-profile.calltrace.cycl=
es-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.execve
>       6.72            -3.5        3.26        perf-profile.calltrace.cycl=
es-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_exec=
veat_common
>       4.60 =C4=85  8%      -2.8        1.84 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mm=
ap_pgoff
>       6.78            -2.7        4.03        perf-profile.calltrace.cycl=
es-pp.asm_exc_page_fault
>       4.56 =C4=85  4%      -2.7        1.86 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_p=
goff
>       5.32            -2.7        2.63 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
>       5.32            -2.7        2.64 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       5.30            -2.7        2.62 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
>       6.54            -2.6        3.92        perf-profile.calltrace.cycl=
es-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.54            -2.6        3.92        perf-profile.calltrace.cycl=
es-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>       6.54            -2.6        3.92        perf-profile.calltrace.cycl=
es-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_aft=
er_hwframe
>       6.24            -2.5        3.71        perf-profile.calltrace.cycl=
es-pp.exc_page_fault.asm_exc_page_fault
>       6.21            -2.5        3.70        perf-profile.calltrace.cycl=
es-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       5.68            -2.3        3.38        perf-profile.calltrace.cycl=
es-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       5.47            -2.2        3.26        perf-profile.calltrace.cycl=
es-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.a=
sm_exc_page_fault
>       4.84            -2.0        2.80 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.common_startup_64
>       4.77            -2.0        2.76 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.start_secondary.common_startup_64
>       4.76            -2.0        2.75 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
>       4.76            -2.0        2.75 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
>       2.92 =C4=85  4%      -1.7        1.20 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.d=
o_mmap
>       4.09            -1.7        2.38 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.comm=
on_startup_64
>       3.80            -1.6        2.22 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_=
secondary
>       3.79            -1.6        2.21 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_=
startup_entry
>       3.76            -1.6        2.19 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.c=
puidle_enter_state.cpuidle_enter
>       3.37 =C4=85  6%      -1.6        1.80 =C4=85  2%  perf-profile.call=
trace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entr=
y_SYSCALL_64_after_hwframe
>       3.65            -1.5        2.12 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_c=
all.do_idle
>       2.49 =C4=85  5%      -1.5        0.96 =C4=85  8%  perf-profile.call=
trace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.m=
map_region
>       3.04            -1.4        1.60 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm=
.bprm_execve
>       3.61            -1.4        2.19        perf-profile.calltrace.cycl=
es-pp._Fork
>       2.18 =C4=85  5%      -1.4        0.78 =C4=85 10%  perf-profile.call=
trace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_v=
mi_munmap
>       2.15 =C4=85  5%      -1.4        0.77 =C4=85 10%  perf-profile.call=
trace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vm=
a.do_vmi_align_munmap
>       2.88            -1.4        1.51        perf-profile.calltrace.cycl=
es-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_b=
inprm
>       2.13 =C4=85  5%      -1.4        0.76 =C4=85 10%  perf-profile.call=
trace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.=
vma_prepare.__split_vma
>       2.25            -1.4        0.88 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
>       2.21            -1.3        0.87 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mma=
p
>       2.15 =C4=85  4%      -1.3        0.84 =C4=85  4%  perf-profile.call=
trace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
>       1.91 =C4=85  5%      -1.3        0.64 =C4=85 11%  perf-profile.call=
trace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.do=
wn_write.vma_prepare
>       2.62            -1.3        1.36 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_h=
andler
>       3.22            -1.3        1.96        perf-profile.calltrace.cycl=
es-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
>       3.22            -1.3        1.96 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after=
_hwframe._Fork
>       3.22            -1.3        1.96 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
>       3.22            -1.3        1.96 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
>       2.61            -1.3        1.35 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
>       1.60 =C4=85  4%      -1.2        0.36 =C4=85 70%  perf-profile.call=
trace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
>       1.90            -1.1        0.75 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.un=
map_vmas
>       2.25 =C4=85  2%      -1.1        1.11 =C4=85  3%  perf-profile.call=
trace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_=
64
>       1.40 =C4=85  4%      -1.1        0.28 =C4=85100%  perf-profile.call=
trace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munma=
p.mmap_region
>       1.37 =C4=85  4%      -1.1        0.27 =C4=85100%  perf-profile.call=
trace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_mun=
map.do_vmi_munmap
>       1.35 =C4=85  4%      -1.1        0.26 =C4=85100%  perf-profile.call=
trace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vm=
i_align_munmap
>       1.99 =C4=85  2%      -1.0        0.96 =C4=85  3%  perf-profile.call=
trace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
>       3.48 =C4=85  3%      -1.0        2.45 =C4=85  2%  perf-profile.call=
trace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.link_pat=
h_walk
>       2.44            -1.0        1.43 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.ex=
c_page_fault
>       3.45 =C4=85  3%      -1.0        2.44 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_comp=
onent
>       1.54 =C4=85  4%      -1.0        0.59 =C4=85  8%  perf-profile.call=
trace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.=
do_mmap
>       3.19 =C4=85 12%      -0.9        2.24 =C4=85 11%  perf-profile.call=
trace.cycles-pp.rwsem_down_read_slowpath.down_read.walk_component.link_path=
_walk.path_openat
>       3.34 =C4=85  3%      -0.9        2.42 =C4=85  2%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup=
_slow
>       3.33 =C4=85 11%      -0.9        2.42 =C4=85 10%  perf-profile.call=
trace.cycles-pp.down_read.walk_component.link_path_walk.path_openat.do_filp=
_open
>       2.14            -0.9        1.25        perf-profile.calltrace.cycl=
es-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr=
_fault
>       2.02            -0.9        1.16 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter=
.cpuidle_idle_call
>       3.22 =C4=85  3%      -0.9        2.36 =C4=85  2%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_ki=
ll.dput.d_alloc_parallel
>       2.04            -0.8        1.19 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handl=
e_mm_fault
>       1.00 =C4=85  2%      -0.7        0.25 =C4=85100%  perf-profile.call=
trace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x6=
4_sys_mprotect
>       1.66            -0.7        0.95 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
>       0.94            -0.7        0.26 =C4=85100%  perf-profile.calltrace=
.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.=
exit_mm
>       1.02 =C4=85  2%      -0.7        0.35 =C4=85 70%  perf-profile.call=
trace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprote=
ct.do_syscall_64
>       1.57            -0.7        0.90 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
>       2.68 =C4=85 13%      -0.6        2.04 =C4=85 12%  perf-profile.call=
trace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_rea=
d.walk_component.link_path_walk
>       2.68 =C4=85 13%      -0.6        2.03 =C4=85 12%  perf-profile.call=
trace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath=
.down_read.walk_component
>       2.66 =C4=85 13%      -0.6        2.02 =C4=85 12%  perf-profile.call=
trace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_re=
ad_slowpath.down_read
>       1.29            -0.6        0.67 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
>       1.29            -0.6        0.67 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.06            -0.6        1.46 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filena=
me_lookup
>       1.43            -0.6        0.87        perf-profile.calltrace.cycl=
es-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_use=
r_addr_fault.exc_page_fault
>       1.97            -0.6        1.41 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.pat=
h_lookupat
>       1.14            -0.6        0.58 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64=
.entry_SYSCALL_64_after_hwframe
>       1.40            -0.6        0.85        perf-profile.calltrace.cycl=
es-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle=
_mm_fault.do_user_addr_fault
>       1.11 =C4=85  2%      -0.5        0.58 =C4=85  2%  perf-profile.call=
trace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_=
binprm.bprm_execve
>       0.96            -0.5        0.43 =C4=85 44%  perf-profile.calltrace=
.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
>       1.11 =C4=85  2%      -0.5        0.58 =C4=85  2%  perf-profile.call=
trace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_hand=
ler.exec_binprm
>       1.29            -0.5        0.78        perf-profile.calltrace.cycl=
es-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle=
_mm_fault.handle_mm_fault
>       1.18 =C4=85  2%      -0.5        0.69 =C4=85  2%  perf-profile.call=
trace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_faul=
t.__handle_mm_fault
>       1.12            -0.5        0.62        perf-profile.calltrace.cycl=
es-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.11            -0.5        0.62 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
>       1.07 =C4=85  2%      -0.5        0.62 =C4=85  2%  perf-profile.call=
trace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single=
.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
>       0.90 =C4=85  2%      -0.4        0.52        perf-profile.calltrace=
.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sy=
svec_call_function_single.acpi_safe_halt.acpi_idle_enter
>       1.16            -0.2        1.01        perf-profile.calltrace.cycl=
es-pp.open64
>       1.14            -0.1        0.99        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.open64
>       1.12            -0.1        0.98        perf-profile.calltrace.cycl=
es-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.open64
>       1.13            -0.1        0.99        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       1.12            -0.1        0.98        perf-profile.calltrace.cycl=
es-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       0.91            -0.1        0.78 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.unlinkat
>       0.90            -0.1        0.78        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
>       0.90            -0.1        0.78        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.unlinkat
>       0.90            -0.1        0.78        perf-profile.calltrace.cycl=
es-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlin=
kat
>       0.89            -0.1        0.78 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.unlinkat
>       0.88            -0.1        0.79 =C4=85  5%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_w=
alk.path_lookupat
>       3.18            +0.1        3.30 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_=
statx
>       0.53 =C4=85  3%      +0.2        0.68 =C4=85  3%  perf-profile.call=
trace.cycles-pp.fstatat64
>       0.70 =C4=85  3%      +0.2        0.88        perf-profile.calltrace=
.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_op=
enat2
>       0.54 =C4=85  3%      +0.2        0.73        perf-profile.calltrace=
.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_open=
at
>       0.68 =C4=85  3%      +0.2        0.87        perf-profile.calltrace=
.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_fi=
lp_open
>       0.44 =C4=85 44%      +0.3        0.71        perf-profile.calltrace=
.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lo=
okups
>       0.54 =C4=85  3%      +0.3        0.87 =C4=85  2%  perf-profile.call=
trace.cycles-pp.dput.step_into.open_last_lookups.path_openat.do_filp_open
>       0.54 =C4=85  2%      +0.3        0.88 =C4=85  2%  perf-profile.call=
trace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys=
_openat2
>       0.54 =C4=85  2%      +0.3        0.87 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__dentry_kill.dput.step_into.open_last_lookups.path_openat
>       0.35 =C4=85 70%      +0.3        0.70 =C4=85  2%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_a=
lloc_parallel.lookup_open
>       0.44 =C4=85 44%      +0.4        0.86 =C4=85  2%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.open_last_looku=
ps
>       0.77 =C4=85  4%      +0.4        1.20 =C4=85  2%  perf-profile.call=
trace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_s=
ys_openat2
>       0.75 =C4=85  4%      +0.4        1.18 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_looku=
ps.path_openat
>       0.75 =C4=85  4%      +0.4        1.18 =C4=85  2%  perf-profile.call=
trace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup=
_fast.open_last_lookups
>       0.75 =C4=85  4%      +0.4        1.18 =C4=85  2%  perf-profile.call=
trace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_=
filp_open
>       3.69            +0.5        4.16 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstat=
at
>       0.17 =C4=85141%      +0.5        0.66 =C4=85  3%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
>       0.17 =C4=85141%      +0.5        0.66 =C4=85  3%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
>       0.08 =C4=85223%      +0.6        0.65 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.fstatat64
>       0.00            +0.6        0.62 =C4=85  7%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.path_put.ex=
it_fs
>       0.00            +0.6        0.62 =C4=85  7%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.dput.path_put.exit_fs.do_exit
>       0.00            +0.6        0.63 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe.fstatat64
>       1.06            +0.7        1.80 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename=
_lookup
>       3.28            +0.8        4.03        perf-profile.calltrace.cycl=
es-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_o=
penat
>       0.00            +0.8        0.76 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.dput.path_put.exit_fs.do_exit.do_group_exit
>       0.00            +0.8        0.76 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.path_put.exit_fs.do_exit.do_group_exit.__x64_sys_exit_group
>       0.00            +0.8        0.77 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.exit_fs.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       1.04            +0.8        1.82 =C4=85  4%  perf-profile.calltrace=
.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstat=
at
>       1.04            +0.8        1.81 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
>       0.00            +0.8        0.79 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_lookupat
>       0.84            +0.8        1.65 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_loo=
kupat
>       0.00            +0.8        0.81 =C4=85  4%  perf-profile.calltrace=
.cycles-pp.dput.step_into.link_path_walk.path_lookupat.filename_lookup
>       0.00            +0.8        0.82 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.step_into.link_path_walk.path_lookupat.filename_lookup.vfs_statx
>       0.00            +1.0        0.97 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.lockref_put_return.dput.terminate_walk.path_lookupat.filename_lo=
okup
>       5.11            +1.2        6.29 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.07            +1.2        6.26 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe
>       4.94            +1.2        6.19 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_sys=
call_64
>       4.92            +1.3        6.18 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_new=
fstatat
>       4.95            +1.8        6.80 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
>      11.82 =C4=85  3%      +2.2       14.02        perf-profile.calltrace=
.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_=
open
>      11.60 =C4=85  3%      +2.3       13.89        perf-profile.calltrace=
.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.pat=
h_openat
>       9.03 =C4=85  3%      +2.8       11.86        perf-profile.calltrace=
.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_=
walk
>       8.52 =C4=85  3%      +2.9       11.40        perf-profile.calltrace=
.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_compo=
nent
>       8.19 =C4=85  3%      +2.9       11.08        perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_=
parallel.__lookup_slow
>       0.00            +3.7        3.71        perf-profile.calltrace.cycl=
es-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
>       7.87 =C4=85  3%      +3.9       11.77 =C4=85  2%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get=
_not_dead.__legitimize_path.try_to_unlazy
>       8.00 =C4=85  3%      +4.0       11.98        perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unl=
azy.lookup_fast
>       8.44 =C4=85  3%      +4.8       13.24 =C4=85  2%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.termin=
ate_walk.path_openat
>       5.43 =C4=85  2%      +4.9       10.36        perf-profile.calltrace=
.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
>       8.48 =C4=85  3%      +4.9       13.42 =C4=85  2%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
>       5.40 =C4=85  2%      +4.9       10.34        perf-profile.calltrace=
.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
>       5.29 =C4=85  2%      +5.0       10.31 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
>       5.08 =C4=85  2%      +5.8       10.88        perf-profile.calltrace=
.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
>       5.34 =C4=85  5%      +6.0       11.34        perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dp=
ut.step_into
>       7.11 =C4=85  3%      +6.7       13.85        perf-profile.calltrace=
.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_op=
en
>       6.81 =C4=85  3%      +6.8       13.65        perf-profile.calltrace=
.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_ope=
nat
>       7.64 =C4=85  2%      +7.6       15.29        perf-profile.calltrace=
.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_=
path_walk
>       7.52 =C4=85  2%      +7.7       15.17        perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast=
.walk_component
>      22.42            +8.0       30.41        perf-profile.calltrace.cycl=
es-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
>       8.72 =C4=85  3%      +8.5       17.21        perf-profile.calltrace=
.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys=
_openat
>       8.70 =C4=85  3%      +8.5       17.19        perf-profile.calltrace=
.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
>      27.98           +12.9       40.85        perf-profile.calltrace.cycl=
es-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_open=
at
>      64.52           +13.7       78.21        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe
>      64.49           +13.7       78.19        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      41.14           +21.4       62.52        perf-profile.calltrace.cycl=
es-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      41.12           +21.4       62.50        perf-profile.calltrace.cycl=
es-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>      41.64           +21.5       63.13        perf-profile.calltrace.cycl=
es-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
>      41.58           +21.5       63.10        perf-profile.calltrace.cycl=
es-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_6=
4
>       9.86 =C4=85  4%      -6.4        3.51 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.down_write
>       9.25 =C4=85  5%      -6.1        3.17 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.rwsem_down_write_slowpath
>       8.92 =C4=85  5%      -5.9        2.98 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.rwsem_optimistic_spin
>       7.58 =C4=85  5%      -5.3        2.33 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.osq_lock
>       9.01 =C4=85  3%      -5.1        3.95 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.vm_mmap_pgoff
>       8.89 =C4=85  3%      -5.0        3.89 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.do_mmap
>       8.73 =C4=85  3%      -4.9        3.79 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mmap_region
>       8.30            -4.1        4.16 =C4=85  2%  perf-profile.children.=
cycles-pp.__mmput
>       8.26            -4.1        4.14 =C4=85  2%  perf-profile.children.=
cycles-pp.exit_mmap
>       7.02 =C4=85  4%      -4.1        2.92 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.ksys_mmap_pgoff
>       9.04            -4.0        5.06        perf-profile.children.cycle=
s-pp.__x64_sys_execve
>       9.77            -4.0        5.79        perf-profile.children.cycle=
s-pp.asm_exc_page_fault
>       9.03            -4.0        5.05        perf-profile.children.cycle=
s-pp.do_execveat_common
>       8.85            -3.6        5.24        perf-profile.children.cycle=
s-pp.exc_page_fault
>       8.81            -3.6        5.21        perf-profile.children.cycle=
s-pp.do_user_addr_fault
>       7.94            -3.5        4.44        perf-profile.children.cycle=
s-pp.execve
>       6.04 =C4=85  3%      -3.4        2.62 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.do_vmi_munmap
>       5.92 =C4=85  3%      -3.4        2.54 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.do_vmi_align_munmap
>       8.29            -3.4        4.91        perf-profile.children.cycle=
s-pp.handle_mm_fault
>       7.40            -3.3        4.07        perf-profile.children.cycle=
s-pp.bprm_execve
>       7.96            -3.2        4.71        perf-profile.children.cycle=
s-pp.__handle_mm_fault
>       5.30 =C4=85  3%      -3.2        2.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.free_pgtables
>       6.85            -3.1        3.76        perf-profile.children.cycle=
s-pp.exec_binprm
>       6.84            -3.1        3.75        perf-profile.children.cycle=
s-pp.search_binary_handler
>       6.72            -3.0        3.68        perf-profile.children.cycle=
s-pp.load_elf_binary
>       4.22 =C4=85  4%      -2.8        1.45 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.unlink_file_vma
>       5.34            -2.7        2.65 =C4=85  2%  perf-profile.children.=
cycles-pp.exit_mm
>       6.67            -2.7        4.00        perf-profile.children.cycle=
s-pp.__x64_sys_exit_group
>       6.67            -2.7        4.00        perf-profile.children.cycle=
s-pp.do_group_exit
>       6.66            -2.7        3.99        perf-profile.children.cycle=
s-pp.do_exit
>       4.22 =C4=85  3%      -2.3        1.87 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__split_vma
>       3.63 =C4=85  4%      -2.2        1.43 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.vma_prepare
>       4.84            -2.0        2.80 =C4=85  2%  perf-profile.children.=
cycles-pp.do_idle
>       4.84            -2.0        2.80 =C4=85  2%  perf-profile.children.=
cycles-pp.common_startup_64
>       4.84            -2.0        2.80 =C4=85  2%  perf-profile.children.=
cycles-pp.cpu_startup_entry
>       4.77            -2.0        2.76 =C4=85  2%  perf-profile.children.=
cycles-pp.start_secondary
>       4.16            -1.7        2.42 =C4=85  2%  perf-profile.children.=
cycles-pp.cpuidle_idle_call
>       3.94            -1.6        2.30 =C4=85  2%  perf-profile.children.=
cycles-pp.do_fault
>       3.44            -1.6        1.80        perf-profile.children.cycle=
s-pp.begin_new_exec
>       3.86            -1.6        2.26 =C4=85  2%  perf-profile.children.=
cycles-pp.cpuidle_enter
>       3.85            -1.6        2.24 =C4=85  2%  perf-profile.children.=
cycles-pp.cpuidle_enter_state
>       3.28            -1.6        1.71        perf-profile.children.cycle=
s-pp.exec_mmap
>       4.14            -1.6        2.58        perf-profile.children.cycle=
s-pp.kernel_clone
>       3.71            -1.6        2.16 =C4=85  2%  perf-profile.children.=
cycles-pp.acpi_idle_enter
>       3.70            -1.5        2.15 =C4=85  2%  perf-profile.children.=
cycles-pp.acpi_safe_halt
>       3.78            -1.5        2.30        perf-profile.children.cycle=
s-pp.__do_sys_clone
>       2.49 =C4=85  3%      -1.5        1.04 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.unmap_region
>       3.64            -1.4        2.21        perf-profile.children.cycle=
s-pp._Fork
>       3.43            -1.4        2.00        perf-profile.children.cycle=
s-pp.do_read_fault
>       3.34            -1.4        1.95        perf-profile.children.cycle=
s-pp.filemap_map_pages
>       3.67            -1.4        2.30        perf-profile.children.cycle=
s-pp.copy_process
>       2.65 =C4=85  2%      -1.4        1.29 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.dup_mm
>       4.43 =C4=85 12%      -1.3        3.16 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__schedule
>       2.34 =C4=85  2%      -1.2        1.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.dup_mmap
>       2.74            -1.2        1.59        perf-profile.children.cycle=
s-pp.unmap_vmas
>       2.54            -1.1        1.47        perf-profile.children.cycle=
s-pp.unmap_page_range
>       2.48            -1.0        1.43        perf-profile.children.cycle=
s-pp.zap_pmd_range
>       3.46 =C4=85 12%      -1.0        2.42 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.rwsem_down_read_slowpath
>       2.43            -1.0        1.41        perf-profile.children.cycle=
s-pp.zap_pte_range
>       2.59            -1.0        1.57        perf-profile.children.cycle=
s-pp.asm_sysvec_call_function_single
>       3.64 =C4=85 11%      -1.0        2.63 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.down_read
>       3.67 =C4=85 13%      -1.0        2.71 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.schedule
>       2.29            -1.0        1.33        perf-profile.children.cycle=
s-pp.kmem_cache_free
>       2.15            -0.9        1.20 =C4=85  2%  perf-profile.children.=
cycles-pp.elf_load
>       2.10            -0.9        1.21 =C4=85  2%  perf-profile.children.=
cycles-pp.zap_present_ptes
>       1.95 =C4=85  2%      -0.8        1.13        perf-profile.children.=
cycles-pp.next_uptodate_folio
>       3.10 =C4=85 13%      -0.8        2.31 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.schedule_preempt_disabled
>       1.66            -0.7        0.91        perf-profile.children.cycle=
s-pp.tlb_finish_mmu
>       1.76            -0.7        1.08        perf-profile.children.cycle=
s-pp.clear_page_erms
>       1.48            -0.7        0.80        perf-profile.children.cycle=
s-pp.__tlb_batch_free_encoded_pages
>       1.47            -0.7        0.80 =C4=85  2%  perf-profile.children.=
cycles-pp.free_pages_and_swap_cache
>       1.54            -0.6        0.92 =C4=85  2%  perf-profile.children.=
cycles-pp.up_write
>       1.29            -0.6        0.67 =C4=85  3%  perf-profile.children.=
cycles-pp.__x64_sys_mprotect
>       1.29            -0.6        0.67 =C4=85  3%  perf-profile.children.=
cycles-pp.do_mprotect_pkey
>       1.11 =C4=85  3%      -0.6        0.52 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.rwsem_spin_on_owner
>       1.50            -0.6        0.91        perf-profile.children.cycle=
s-pp.handle_softirqs
>       1.24 =C4=85  2%      -0.6        0.66 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.load_elf_interp
>       1.43            -0.6        0.87        perf-profile.children.cycle=
s-pp.__do_huge_pmd_anonymous_page
>       1.15            -0.6        0.58 =C4=85  3%  perf-profile.children.=
cycles-pp.mprotect_fixup
>       1.20 =C4=85  3%      -0.6        0.65 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ret_from_fork_asm
>       1.41            -0.6        0.86        perf-profile.children.cycle=
s-pp.clear_huge_page
>       1.32            -0.6        0.77 =C4=85  2%  perf-profile.children.=
cycles-pp.rcu_core
>       1.28            -0.5        0.74 =C4=85  2%  perf-profile.children.=
cycles-pp.rcu_do_batch
>       1.18            -0.5        0.64        perf-profile.children.cycle=
s-pp.folios_put_refs
>       1.35            -0.5        0.81        perf-profile.children.cycle=
s-pp.kmem_cache_alloc_noprof
>       1.02 =C4=85  2%      -0.5        0.51 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.vma_modify
>       1.32            -0.5        0.80        perf-profile.children.cycle=
s-pp.alloc_pages_mpol_noprof
>       1.08 =C4=85  3%      -0.5        0.57 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ret_from_fork
>       1.26            -0.5        0.77 =C4=85  2%  perf-profile.children.=
cycles-pp.__alloc_pages_noprof
>       1.80 =C4=85  2%      -0.5        1.32 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.asm_sysvec_apic_timer_interrupt
>       1.19            -0.4        0.74        perf-profile.children.cycle=
s-pp.sysvec_call_function_single
>       0.88 =C4=85  4%      -0.4        0.46 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.kthread
>       1.00 =C4=85  2%      -0.4        0.58 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.vma_interval_tree_insert
>       0.92            -0.4        0.51 =C4=85  2%  perf-profile.children.=
cycles-pp.__slab_free
>       0.96            -0.4        0.54 =C4=85  2%  perf-profile.children.=
cycles-pp.__vm_munmap
>       1.02            -0.4        0.61        perf-profile.children.cycle=
s-pp.select_task_rq_fair
>       1.61            -0.4        1.19 =C4=85  2%  perf-profile.children.=
cycles-pp.sysvec_apic_timer_interrupt
>       0.98            -0.4        0.59        perf-profile.children.cycle=
s-pp.wp_page_copy
>       0.73 =C4=85  4%      -0.4        0.36 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.smpboot_thread_fn
>       1.01            -0.4        0.64        perf-profile.children.cycle=
s-pp.__sysvec_call_function_single
>       0.99            -0.4        0.62        perf-profile.children.cycle=
s-pp.__flush_smp_call_function_queue
>       0.92            -0.4        0.56 =C4=85  2%  perf-profile.children.=
cycles-pp.do_anonymous_page
>       0.98            -0.4        0.62 =C4=85  2%  perf-profile.children.=
cycles-pp.try_to_wake_up
>       0.92            -0.4        0.56        perf-profile.children.cycle=
s-pp.__memcg_slab_free_hook
>       0.82            -0.4        0.46        perf-profile.children.cycle=
s-pp.folio_remove_rmap_ptes
>       0.79            -0.4        0.43        perf-profile.children.cycle=
s-pp.alloc_empty_file
>       0.94            -0.3        0.59 =C4=85  2%  perf-profile.children.=
cycles-pp.rwsem_wake
>       0.90            -0.3        0.56        perf-profile.children.cycle=
s-pp.__memcg_slab_post_alloc_hook
>       0.55 =C4=85  4%      -0.3        0.22 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.vma_expand
>       0.82            -0.3        0.50 =C4=85  2%  perf-profile.children.=
cycles-pp.get_page_from_freelist
>       1.02            -0.3        0.71        perf-profile.children.cycle=
s-pp.irq_exit_rcu
>       0.82 =C4=85  2%      -0.3        0.52        perf-profile.children.=
cycles-pp.sched_ttwu_pending
>       0.83            -0.3        0.52 =C4=85  2%  perf-profile.children.=
cycles-pp.wake_up_q
>       0.77            -0.3        0.47        perf-profile.children.cycle=
s-pp.__d_lookup_rcu
>       0.74            -0.3        0.44        perf-profile.children.cycle=
s-pp.copy_strings
>       0.69            -0.3        0.40 =C4=85  2%  perf-profile.children.=
cycles-pp.vma_complete
>       0.51 =C4=85  2%      -0.3        0.22 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.run_ksoftirqd
>       0.79 =C4=85  2%      -0.3        0.51 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.activate_task
>       0.61            -0.3        0.34 =C4=85  3%  perf-profile.children.=
cycles-pp._compound_head
>       0.76 =C4=85  2%      -0.3        0.49        perf-profile.children.=
cycles-pp.ttwu_do_activate
>       0.64            -0.3        0.37 =C4=85  3%  perf-profile.children.=
cycles-pp.mm_init
>       0.62            -0.3        0.36 =C4=85  2%  perf-profile.children.=
cycles-pp.sched_balance_find_dst_cpu
>       0.39 =C4=85 17%      -0.3        0.14 =C4=85 10%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irq
>       0.52 =C4=85  2%      -0.3        0.27 =C4=85  3%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irqsave
>       0.53 =C4=85  2%      -0.2        0.28        perf-profile.children.=
cycles-pp.init_file
>       0.54 =C4=85  3%      -0.2        0.29 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.schedule_idle
>       0.56            -0.2        0.31 =C4=85  2%  perf-profile.children.=
cycles-pp.finish_task_switch
>       0.55            -0.2        0.31 =C4=85  2%  perf-profile.children.=
cycles-pp.__mmdrop
>       0.57            -0.2        0.33 =C4=85  2%  perf-profile.children.=
cycles-pp.copy_page_range
>       0.70 =C4=85  4%      -0.2        0.47 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.dequeue_task_fair
>       0.68 =C4=85  3%      -0.2        0.45        perf-profile.children.=
cycles-pp.enqueue_task_fair
>       0.58            -0.2        0.34        perf-profile.children.cycle=
s-pp.syscall_exit_to_user_mode
>       0.55            -0.2        0.32 =C4=85  2%  perf-profile.children.=
cycles-pp.copy_p4d_range
>       0.56            -0.2        0.34        perf-profile.children.cycle=
s-pp.mod_objcg_state
>       0.54            -0.2        0.32 =C4=85  2%  perf-profile.children.=
cycles-pp.sched_balance_find_dst_group
>       0.66 =C4=85  3%      -0.2        0.44 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.update_load_avg
>       0.54            -0.2        0.32 =C4=85  2%  perf-profile.children.=
cycles-pp.unlink_anon_vmas
>       0.51 =C4=85  2%      -0.2        0.30        perf-profile.children.=
cycles-pp.update_sg_wakeup_stats
>       0.56 =C4=85  4%      -0.2        0.34 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.wait4
>       0.52            -0.2        0.31 =C4=85  3%  perf-profile.children.=
cycles-pp.alloc_bprm
>       0.44 =C4=85  2%      -0.2        0.23        perf-profile.children.=
cycles-pp.security_file_alloc
>       0.56            -0.2        0.35 =C4=85  2%  perf-profile.children.=
cycles-pp._IO_default_xsputn
>       0.52            -0.2        0.31        perf-profile.children.cycle=
s-pp.mas_store_prealloc
>       0.54            -0.2        0.33 =C4=85  2%  perf-profile.children.=
cycles-pp.perf_event_mmap
>       0.51            -0.2        0.30 =C4=85  2%  perf-profile.children.=
cycles-pp.set_pte_range
>       0.52 =C4=85  2%      -0.2        0.32 =C4=85  3%  perf-profile.chil=
dren.cycles-pp._IO_fwrite
>       0.52            -0.2        0.32        perf-profile.children.cycle=
s-pp.perf_event_mmap_event
>       0.55 =C4=85  3%      -0.2        0.34 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.dequeue_entity
>       0.45            -0.2        0.25 =C4=85  2%  perf-profile.children.=
cycles-pp.__pte_offset_map_lock
>       0.54 =C4=85  3%      -0.2        0.34 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.enqueue_entity
>       0.52            -0.2        0.32        perf-profile.children.cycle=
s-pp.native_irq_return_iret
>       0.52 =C4=85  5%      -0.2        0.32 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.vfs_read
>       0.48            -0.2        0.29        perf-profile.children.cycle=
s-pp.sync_regs
>       0.51            -0.2        0.32 =C4=85  3%  perf-profile.children.=
cycles-pp.alloc_anon_folio
>       0.38            -0.2        0.19        perf-profile.children.cycle=
s-pp.apparmor_file_alloc_security
>       0.46 =C4=85  2%      -0.2        0.27 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__x64_sys_munmap
>       0.49 =C4=85  2%      -0.2        0.31 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.vma_alloc_folio_noprof
>       0.50 =C4=85  5%      -0.2        0.32 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.read
>       0.46            -0.2        0.28        perf-profile.children.cycle=
s-pp.__cond_resched
>       0.48 =C4=85  6%      -0.2        0.30 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.kernel_wait4
>       0.48 =C4=85  6%      -0.2        0.30 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__do_sys_wait4
>       0.49 =C4=85  5%      -0.2        0.31 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ksys_read
>       0.42            -0.2        0.25        perf-profile.children.cycle=
s-pp.lock_vma_under_rcu
>       0.44            -0.2        0.27        perf-profile.children.cycle=
s-pp.strnlen_user
>       0.41            -0.2        0.24 =C4=85  2%  perf-profile.children.=
cycles-pp.__libc_early_init
>       0.46 =C4=85  6%      -0.2        0.29 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.do_wait
>       0.40            -0.2        0.23 =C4=85  2%  perf-profile.children.=
cycles-pp.wake_up_new_task
>       0.42 =C4=85  2%      -0.2        0.25        perf-profile.children.=
cycles-pp.vma_interval_tree_remove
>       0.41            -0.2        0.24 =C4=85  2%  perf-profile.children.=
cycles-pp.__libc_fork
>       0.41            -0.2        0.24 =C4=85  2%  perf-profile.children.=
cycles-pp.mas_wr_store_entry
>       0.39 =C4=85  2%      -0.2        0.22 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.getname_flags
>       0.41 =C4=85  2%      -0.2        0.25        perf-profile.children.=
cycles-pp.get_arg_page
>       0.39 =C4=85  2%      -0.2        0.22 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.sched_exec
>       0.40            -0.2        0.23 =C4=85  2%  perf-profile.children.=
cycles-pp.rep_stos_alternative
>       0.40            -0.2        0.24 =C4=85  2%  perf-profile.children.=
cycles-pp.vm_area_dup
>       0.40            -0.2        0.24 =C4=85  2%  perf-profile.children.=
cycles-pp.perf_iterate_sb
>       0.41            -0.2        0.26        perf-profile.children.cycle=
s-pp.select_task_rq
>       0.37            -0.2        0.22        perf-profile.children.cycle=
s-pp.pcpu_alloc_noprof
>       1.16            -0.2        1.01        perf-profile.children.cycle=
s-pp.open64
>       0.36 =C4=85  2%      -0.1        0.22 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__memcg_kmem_charge_page
>       0.35            -0.1        0.20 =C4=85  2%  perf-profile.children.=
cycles-pp.pte_alloc_one
>       0.35 =C4=85  2%      -0.1        0.21 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.setup_arg_pages
>       0.35            -0.1        0.21        perf-profile.children.cycle=
s-pp.get_user_pages_remote
>       0.36            -0.1        0.22 =C4=85  2%  perf-profile.children.=
cycles-pp.create_elf_tables
>       0.32            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.copy_pte_range
>       0.34            -0.1        0.20 =C4=85  2%  perf-profile.children.=
cycles-pp.__d_alloc
>       0.34 =C4=85  2%      -0.1        0.20 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__get_user_pages
>       0.31            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.folio_batch_move_lru
>       0.31            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.lru_add_drain
>       0.25 =C4=85  4%      -0.1        0.12 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.security_file_free
>       0.33            -0.1        0.20 =C4=85  2%  perf-profile.children.=
cycles-pp.dup_task_struct
>       0.31            -0.1        0.18        perf-profile.children.cycle=
s-pp.lru_add_drain_cpu
>       0.34            -0.1        0.21 =C4=85  3%  perf-profile.children.=
cycles-pp.__mem_cgroup_charge
>       0.31            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.folio_add_file_rmap_ptes
>       0.30 =C4=85  2%      -0.1        0.17 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.rmqueue
>       0.29 =C4=85  3%      -0.1        0.16 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__call_rcu_common
>       0.33 =C4=85  2%      -0.1        0.20 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.___perf_sw_event
>       0.31 =C4=85  2%      -0.1        0.18 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__vm_area_free
>       0.91            -0.1        0.79 =C4=85  2%  perf-profile.children.=
cycles-pp.unlinkat
>       0.24 =C4=85  3%      -0.1        0.11 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.apparmor_file_free_security
>       0.31            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.__mod_memcg_lruvec_state
>       0.29 =C4=85  2%      -0.1        0.17 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.mas_wr_node_store
>       0.28            -0.1        0.16 =C4=85  2%  perf-profile.children.=
cycles-pp.__lruvec_stat_mod_folio
>       0.30            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.clear_bhb_loop
>       0.34 =C4=85  2%      -0.1        0.22        perf-profile.children.=
cycles-pp.write
>       0.30 =C4=85  2%      -0.1        0.18 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.shift_arg_pages
>       0.31 =C4=85  2%      -0.1        0.19 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.mas_find
>       0.28 =C4=85  2%      -0.1        0.16 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__pte_alloc
>       0.90            -0.1        0.78 =C4=85  2%  perf-profile.children.=
cycles-pp.__x64_sys_unlinkat
>       0.89            -0.1        0.78 =C4=85  2%  perf-profile.children.=
cycles-pp.do_unlinkat
>       0.26            -0.1        0.15 =C4=85  2%  perf-profile.children.=
cycles-pp.__do_wait
>       0.29            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.mas_walk
>       0.50 =C4=85  2%      -0.1        0.38        perf-profile.children.=
cycles-pp.fput
>       0.28 =C4=85  2%      -0.1        0.17 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__percpu_counter_sum
>       0.28 =C4=85  2%      -0.1        0.16 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__perf_sw_event
>       0.27 =C4=85  2%      -0.1        0.16 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.strncpy_from_user
>       0.29 =C4=85  2%      -0.1        0.18 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__wp_page_copy_user
>       0.29 =C4=85  2%      -0.1        0.18 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.copy_mc_enhanced_fast_string
>       0.29 =C4=85  3%      -0.1        0.18 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__d_add
>       0.28            -0.1        0.17 =C4=85  2%  perf-profile.children.=
cycles-pp.kmem_cache_alloc_lru_noprof
>       0.32            -0.1        0.20 =C4=85  2%  perf-profile.children.=
cycles-pp.ksys_write
>       0.27            -0.1        0.16 =C4=85  4%  perf-profile.children.=
cycles-pp.memset_orig
>       0.28 =C4=85  2%      -0.1        0.17 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.vm_area_alloc
>       0.27 =C4=85  2%      -0.1        0.16        perf-profile.children.=
cycles-pp.copy_string_kernel
>       0.27 =C4=85  2%      -0.1        0.16 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.flush_tlb_mm_range
>       0.58 =C4=85  3%      -0.1        0.48 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__sysvec_apic_timer_interrupt
>       0.30 =C4=85  2%      -0.1        0.19 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.simple_lookup
>       0.26            -0.1        0.16 =C4=85  3%  perf-profile.children.=
cycles-pp.anon_vma_fork
>       0.30            -0.1        0.20        perf-profile.children.cycle=
s-pp.vfs_write
>       0.26            -0.1        0.15 =C4=85  3%  perf-profile.children.=
cycles-pp.perf_event_mmap_output
>       0.26 =C4=85  2%      -0.1        0.15 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__close
>       0.24 =C4=85  2%      -0.1        0.14 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.free_unref_page_commit
>       0.25 =C4=85  3%      -0.1        0.14 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__fput
>       0.57 =C4=85  4%      -0.1        0.47 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.hrtimer_interrupt
>       0.28            -0.1        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp._IO_padn
>       0.41 =C4=85  2%      -0.1        0.31 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__vfork
>       0.22 =C4=85  3%      -0.1        0.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__rmqueue_pcplist
>       0.23 =C4=85  3%      -0.1        0.13 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__rb_insert_augmented
>       0.24 =C4=85  3%      -0.1        0.14 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.filemap_read
>       0.24            -0.1        0.14        perf-profile.children.cycle=
s-pp.vmf_anon_prepare
>       0.20 =C4=85  2%      -0.1        0.10        perf-profile.children.=
cycles-pp.__page_cache_release
>       0.23            -0.1        0.14 =C4=85  3%  perf-profile.children.=
cycles-pp.select_idle_sibling
>       0.23 =C4=85  2%      -0.1        0.14 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__pmd_alloc
>       0.23 =C4=85  2%      -0.1        0.14 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__check_object_size
>       0.23 =C4=85  2%      -0.1        0.14 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.free_unref_folios
>       0.26            -0.1        0.16 =C4=85  2%  perf-profile.children.=
cycles-pp.cgroup_rstat_updated
>       0.22 =C4=85  2%      -0.1        0.13 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.mas_preallocate
>       0.20 =C4=85  3%      -0.1        0.11        perf-profile.children.=
cycles-pp.___slab_alloc
>       0.22            -0.1        0.13        perf-profile.children.cycle=
s-pp.__anon_vma_prepare
>       0.21 =C4=85  4%      -0.1        0.12        perf-profile.children.=
cycles-pp.task_work_run
>       0.20 =C4=85  3%      -0.1        0.11 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.rcu_segcblist_enqueue
>       0.25            -0.1        0.16 =C4=85  3%  perf-profile.children.=
cycles-pp.up_read
>       0.20            -0.1        0.12 =C4=85  4%  perf-profile.children.=
cycles-pp.free_pcppages_bulk
>       0.21 =C4=85  2%      -0.1        0.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.do_open_execat
>       0.16 =C4=85  3%      -0.1        0.07 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.folio_lruvec_lock_irqsave
>       0.20 =C4=85  2%      -0.1        0.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.wait_task_zombie
>       0.37 =C4=85  2%      -0.1        0.28 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__x64_sys_vfork
>       0.19 =C4=85  2%      -0.1        0.11 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__percpu_counter_init_many
>       0.20            -0.1        0.12 =C4=85  3%  perf-profile.children.=
cycles-pp.percpu_counter_add_batch
>       0.20 =C4=85  3%      -0.1        0.12 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.try_charge_memcg
>       0.20 =C4=85  2%      -0.1        0.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.alloc_thread_stack_node
>       0.19 =C4=85  2%      -0.1        0.11 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.menu_select
>       0.19 =C4=85  2%      -0.1        0.11 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.schedule_tail
>       0.22            -0.1        0.14 =C4=85  2%  perf-profile.children.=
cycles-pp.ttwu_queue_wakelist
>       0.18 =C4=85  2%      -0.1        0.10 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.rmqueue_bulk
>       0.17 =C4=85 15%      -0.1        0.09 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.exit_notify
>       0.18 =C4=85  2%      -0.1        0.10 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.free_unref_page
>       0.19 =C4=85  2%      -0.1        0.12 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.flush_tlb_func
>       0.20 =C4=85  3%      -0.1        0.12 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__memcpy
>       0.21            -0.1        0.13 =C4=85  3%  perf-profile.children.=
cycles-pp.memcg_account_kmem
>       0.20 =C4=85  2%      -0.1        0.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__count_memcg_events
>       0.45 =C4=85  3%      -0.1        0.38 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__hrtimer_run_queues
>       0.19            -0.1        0.12 =C4=85  4%  perf-profile.children.=
cycles-pp.anon_vma_clone
>       0.18 =C4=85  2%      -0.1        0.10        perf-profile.children.=
cycles-pp.rcu_cblist_dequeue
>       0.18 =C4=85  2%      -0.1        0.11        perf-profile.children.=
cycles-pp.select_idle_cpu
>       0.19            -0.1        0.12 =C4=85  4%  perf-profile.children.=
cycles-pp.__put_user_8
>       0.18            -0.1        0.11 =C4=85  4%  perf-profile.children.=
cycles-pp.__pud_alloc
>       0.18 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__x64_sys_close
>       0.19 =C4=85  2%      -0.1        0.11 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.switch_mm_irqs_off
>       0.16 =C4=85  3%      -0.1        0.09 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__do_fault
>       0.22 =C4=85 10%      -0.1        0.15 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.pipe_read
>       0.17 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.available_idle_cpu
>       0.20 =C4=85  4%      -0.1        0.13 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.sched_balance_update_blocked_averages
>       0.23 =C4=85  3%      -0.1        0.16 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.update_curr
>       0.18 =C4=85  2%      -0.1        0.11        perf-profile.children.=
cycles-pp.__munmap
>       0.16 =C4=85  2%      -0.1        0.09 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__switch_to_asm
>       0.16 =C4=85  2%      -0.1        0.09 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.asm_sysvec_reschedule_ipi
>       0.17 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.do_open
>       0.42 =C4=85  3%      -0.1        0.36 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.tick_nohz_handler
>       0.17 =C4=85  3%      -0.1        0.10 =C4=85  3%  perf-profile.chil=
dren.cycles-pp._IO_file_xsputn
>       0.17 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__get_user_8
>       0.17 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__getrlimit
>       0.17 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__rseq_handle_notify_resume
>       0.17 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.release_task
>       0.18 =C4=85  2%      -0.1        0.11 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__mod_memcg_state
>       0.16 =C4=85  3%      -0.1        0.09        perf-profile.children.=
cycles-pp.free_pgd_range
>       0.16 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.mas_wr_bnode
>       0.15 =C4=85  2%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.free_p4d_range
>       0.17            -0.1        0.11 =C4=85  4%  perf-profile.children.=
cycles-pp.mem_cgroup_commit_charge
>       0.19            -0.1        0.13 =C4=85  2%  perf-profile.children.=
cycles-pp.obj_cgroup_charge
>       0.16 =C4=85  3%      -0.1        0.09 =C4=85  5%  perf-profile.chil=
dren.cycles-pp._find_next_bit
>       0.16 =C4=85  3%      -0.1        0.09 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.get_free_pages_noprof
>       0.16 =C4=85  2%      -0.1        0.10        perf-profile.children.=
cycles-pp.native_flush_tlb_one_user
>       0.16 =C4=85  2%      -0.1        0.10 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.rseq_ip_fixup
>       0.38 =C4=85  4%      -0.1        0.32 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.update_process_times
>       0.14 =C4=85  4%      -0.1        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__ctype_init
>       0.14            -0.1        0.08        perf-profile.children.cycle=
s-pp.arch_do_signal_or_restart
>       0.15 =C4=85  2%      -0.1        0.09 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.pgd_alloc
>       0.16 =C4=85  2%      -0.1        0.10 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.move_page_tables
>       0.17 =C4=85  4%      -0.1        0.11 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.prepare_task_switch
>       0.14 =C4=85  2%      -0.1        0.08        perf-profile.children.=
cycles-pp.free_pud_range
>       0.13 =C4=85  2%      -0.1        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__rb_erase_color
>       0.14 =C4=85  3%      -0.1        0.08        perf-profile.children.=
cycles-pp._exit
>       0.14 =C4=85  4%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.check_heap_object
>       0.14 =C4=85  4%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.rwsem_mark_wake
>       0.14 =C4=85  2%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.switch_fpu_return
>       0.14 =C4=85 10%      -0.1        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.inode_permission
>       0.14 =C4=85  4%      -0.1        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.mas_split
>       0.15 =C4=85  3%      -0.1        0.09 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_next_slot
>       0.15 =C4=85  3%      -0.1        0.09        perf-profile.children.=
cycles-pp.strnlen
>       0.14 =C4=85  3%      -0.1        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.generic_file_write_iter
>       0.17 =C4=85  6%      -0.1        0.12 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.update_rq_clock
>       0.13            -0.1        0.08 =C4=85  6%  perf-profile.children.=
cycles-pp.__filemap_get_folio
>       0.13 =C4=85  3%      -0.1        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__mem_cgroup_uncharge_folios
>       0.13 =C4=85  4%      -0.1        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__put_anon_vma
>       0.14 =C4=85  2%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__put_user_4
>       0.17 =C4=85  5%      -0.1        0.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__update_load_avg_cfs_rq
>       0.12 =C4=85  3%      -0.1        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.vm_area_free_rcu_cb
>       0.14 =C4=85  2%      -0.1        0.09 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.wake_affine
>       0.14 =C4=85  3%      -0.1        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp._copy_from_user
>       0.12 =C4=85  4%      -0.1        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__switch_to
>       0.14 =C4=85  3%      -0.1        0.09        perf-profile.children.=
cycles-pp.getenv
>       0.13 =C4=85  2%      -0.1        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_alloc_nodes
>       0.08 =C4=85  4%      -0.1        0.02 =C4=85 99%  perf-profile.chil=
dren.cycles-pp.remove_vma
>       0.14 =C4=85  2%      -0.1        0.09        perf-profile.children.=
cycles-pp.__get_unmapped_area
>       0.13 =C4=85  3%      -0.1        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.down_read_trylock
>       0.14 =C4=85  2%      -0.1        0.09        perf-profile.children.=
cycles-pp.rcu_all_qs
>       0.09 =C4=85  5%      -0.1        0.04 =C4=85 44%  perf-profile.chil=
dren.cycles-pp.select_idle_core
>       0.13            -0.1        0.08 =C4=85  4%  perf-profile.children.=
cycles-pp.do_notify_parent
>       0.16 =C4=85  3%      -0.1        0.10 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.generic_perform_write
>       0.13 =C4=85  3%      -0.1        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ptep_clear_flush
>       0.12            -0.1        0.07 =C4=85  5%  perf-profile.children.=
cycles-pp.do_wp_page
>       0.13 =C4=85  2%      -0.1        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.map_vdso
>       0.14 =C4=85  3%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__free_one_page
>       0.12            -0.0        0.07        perf-profile.children.cycle=
s-pp.copy_page_to_iter
>       0.12 =C4=85  3%      -0.0        0.07 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_store_gfp
>       0.11 =C4=85  4%      -0.0        0.06 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.free_percpu
>       0.13 =C4=85  3%      -0.0        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp._copy_to_iter
>       0.11 =C4=85  3%      -0.0        0.06        perf-profile.children.=
cycles-pp.restore_fpregs_from_fpstate
>       0.07 =C4=85  6%      -0.0        0.02 =C4=85 99%  perf-profile.chil=
dren.cycles-pp.syscall_return_via_sysret
>       0.11 =C4=85  5%      -0.0        0.06 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.sched_move_task
>       0.11            -0.0        0.06 =C4=85  6%  perf-profile.children.=
cycles-pp.set_next_entity
>       0.11            -0.0        0.06 =C4=85  6%  perf-profile.children.=
cycles-pp.setlocale
>       0.12 =C4=85  4%      -0.0        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.lru_add_fn
>       0.14 =C4=85 10%      -0.0        0.10 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.worker_thread
>       0.13 =C4=85  8%      -0.0        0.08 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.xas_load
>       0.11 =C4=85  3%      -0.0        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__tunable_get_val@plt
>       0.11 =C4=85  4%      -0.0        0.06        perf-profile.children.=
cycles-pp.copy_present_ptes
>       0.10 =C4=85  4%      -0.0        0.06 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.finish_fault
>       0.13 =C4=85  2%      -0.0        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__smp_call_single_queue
>       0.12 =C4=85  4%      -0.0        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.open_exec
>       0.07 =C4=85  5%      -0.0        0.02 =C4=85 99%  perf-profile.chil=
dren.cycles-pp.prepend_path
>       0.10 =C4=85  3%      -0.0        0.05 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.sched_mm_cid_migrate_to
>       0.12 =C4=85  3%      -0.0        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.llist_add_batch
>       0.11 =C4=85  4%      -0.0        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__install_special_mapping
>       0.10            -0.0        0.06 =C4=85  8%  perf-profile.children.=
cycles-pp.do_dentry_open
>       0.10 =C4=85  4%      -0.0        0.05 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.put_cred_rcu
>       0.08 =C4=85  6%      -0.0        0.03 =C4=85 70%  perf-profile.chil=
dren.cycles-pp.vm_normal_page
>       0.10 =C4=85  4%      -0.0        0.06        perf-profile.children.=
cycles-pp.cfree
>       0.10 =C4=85  4%      -0.0        0.06        perf-profile.children.=
cycles-pp.getopt_long
>       0.10 =C4=85  4%      -0.0        0.06 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__exit_signal
>       0.09 =C4=85  5%      -0.0        0.05        perf-profile.children.=
cycles-pp.filemap_fault
>       0.09 =C4=85  5%      -0.0        0.05        perf-profile.children.=
cycles-pp.uncharge_batch
>       0.11 =C4=85  4%      -0.0        0.07        perf-profile.children.=
cycles-pp.arch_get_unmapped_area_topdown_vmflags
>       0.15 =C4=85  3%      -0.0        0.11 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.update_rq_clock_task
>       0.12 =C4=85  6%      -0.0        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.x64_sys_call
>       0.12 =C4=85  6%      -0.0        0.07 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.path_init
>       0.10 =C4=85  4%      -0.0        0.06 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.__vmalloc_node_range_noprof
>       0.10 =C4=85  3%      -0.0        0.06        perf-profile.children.=
cycles-pp.__kernel_read
>       0.11 =C4=85  4%      -0.0        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__tlb_remove_folio_pages_size
>       0.10 =C4=85  3%      -0.0        0.06        perf-profile.children.=
cycles-pp.__vsnprintf_chk
>       0.10 =C4=85  3%      -0.0        0.06        perf-profile.children.=
cycles-pp.handle_signal
>       0.11 =C4=85 11%      -0.0        0.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.xas_find
>       0.09 =C4=85  4%      -0.0        0.05        perf-profile.children.=
cycles-pp.prepare_creds
>       0.09 =C4=85  4%      -0.0        0.05        perf-profile.children.=
cycles-pp.strchrnul@plt
>       0.10            -0.0        0.06        perf-profile.children.cycle=
s-pp.__mod_lruvec_state
>       0.10            -0.0        0.06        perf-profile.children.cycle=
s-pp.d_path
>       0.10            -0.0        0.06        perf-profile.children.cycle=
s-pp.do_faccessat
>       0.10 =C4=85  5%      -0.0        0.06 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.__close_nocancel
>       0.07 =C4=85  6%      -0.0        0.03 =C4=85 70%  perf-profile.chil=
dren.cycles-pp.__sigsuspend
>       0.11 =C4=85  3%      -0.0        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.wakeup_preempt
>       0.09 =C4=85  6%      -0.0        0.05        perf-profile.children.=
cycles-pp.vma_interval_tree_augment_rotate
>       0.12 =C4=85  3%      -0.0        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.native_sched_clock
>       0.12 =C4=85  3%      -0.0        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.sched_clock_cpu
>       0.10            -0.0        0.06 =C4=85  6%  perf-profile.children.=
cycles-pp.handle_pte_fault
>       0.10 =C4=85  4%      -0.0        0.06 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.user_path_at_empty
>       0.11 =C4=85 13%      -0.0        0.08 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.process_one_work
>       0.08            -0.0        0.04 =C4=85 44%  perf-profile.children.=
cycles-pp.entry_SYSCALL_64
>       0.10 =C4=85  6%      -0.0        0.06        perf-profile.children.=
cycles-pp.brk
>       0.10 =C4=85  3%      -0.0        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.pipe_write
>       0.09 =C4=85  4%      -0.0        0.05        perf-profile.children.=
cycles-pp.evict
>       0.09 =C4=85  4%      -0.0        0.05        perf-profile.children.=
cycles-pp.malloc
>       0.10 =C4=85  5%      -0.0        0.06 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.alloc_fd
>       0.09            -0.0        0.05 =C4=85  8%  perf-profile.children.=
cycles-pp.count
>       0.09            -0.0        0.05 =C4=85  8%  perf-profile.children.=
cycles-pp.expand_downwards
>       0.09 =C4=85  4%      -0.0        0.06 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.vm_unmapped_area
>       0.09 =C4=85  5%      -0.0        0.05        perf-profile.children.=
cycles-pp.__p4d_alloc
>       0.10 =C4=85  5%      -0.0        0.06        perf-profile.children.=
cycles-pp.kfree
>       0.10            -0.0        0.06 =C4=85  7%  perf-profile.children.=
cycles-pp.task_h_load
>       0.09            -0.0        0.06 =C4=85  9%  perf-profile.children.=
cycles-pp.__snprintf_chk
>       0.08 =C4=85  6%      -0.0        0.04 =C4=85 44%  perf-profile.chil=
dren.cycles-pp.__wake_up
>       0.09            -0.0        0.06 =C4=85  9%  perf-profile.children.=
cycles-pp.irqentry_enter
>       0.09 =C4=85  5%      -0.0        0.05 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.seq_read_iter
>       0.09 =C4=85  4%      -0.0        0.05 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.08 =C4=85  5%      -0.0        0.05        perf-profile.children.=
cycles-pp.seq_read
>       0.08 =C4=85  6%      -0.0        0.04 =C4=85 44%  perf-profile.chil=
dren.cycles-pp._IO_setb
>       0.10 =C4=85  4%      -0.0        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.sched_clock
>       0.08 =C4=85  5%      -0.0        0.05        perf-profile.children.=
cycles-pp.__do_sys_brk
>       0.08 =C4=85  5%      -0.0        0.05        perf-profile.children.=
cycles-pp.can_modify_mm
>       0.08 =C4=85  5%      -0.0        0.05        perf-profile.children.=
cycles-pp.refill_obj_stock
>       0.08 =C4=85  5%      -0.0        0.05 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__update_blocked_fair
>       0.08 =C4=85  5%      -0.0        0.05 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__wake_up_common
>       0.08 =C4=85  4%      -0.0        0.05        perf-profile.children.=
cycles-pp.do_brk_flags
>       0.09            -0.0        0.06        perf-profile.children.cycle=
s-pp.__d_rehash
>       0.08 =C4=85  4%      -0.0        0.05 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.mas_wr_walk
>       0.08            -0.0        0.05        perf-profile.children.cycle=
s-pp.__send_signal_locked
>       0.08            -0.0        0.05        perf-profile.children.cycle=
s-pp.arch_dup_task_struct
>       0.08            -0.0        0.05        perf-profile.children.cycle=
s-pp.copy_page
>       0.08            -0.0        0.05        perf-profile.children.cycle=
s-pp.folio_mark_accessed
>       0.08 =C4=85  4%      -0.0        0.05        perf-profile.children.=
cycles-pp.llist_reverse_order
>       0.11 =C4=85  4%      -0.0        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__update_load_avg_se
>       0.10 =C4=85  8%      -0.0        0.07 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.ktime_get
>       0.08 =C4=85  6%      -0.0        0.05        perf-profile.children.=
cycles-pp.__wake_up_sync_key
>       0.08 =C4=85  6%      -0.0        0.05        perf-profile.children.=
cycles-pp.update_min_vruntime
>       0.20 =C4=85  2%      -0.0        0.18        perf-profile.children.=
cycles-pp.sched_tick
>       0.09 =C4=85  5%      -0.0        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.update_cfs_group
>       0.09 =C4=85  5%      -0.0        0.07        perf-profile.children.=
cycles-pp.sched_balance_domains
>       0.08 =C4=85  6%      -0.0        0.06        perf-profile.children.=
cycles-pp.main
>       0.08 =C4=85  6%      -0.0        0.06        perf-profile.children.=
cycles-pp.run_builtin
>       0.07            -0.0        0.06        perf-profile.children.cycle=
s-pp.__cmd_record
>       0.07            -0.0        0.06        perf-profile.children.cycle=
s-pp.cmd_record
>       0.06            -0.0        0.05        perf-profile.children.cycle=
s-pp.record__mmap_read_evlist
>       0.08 =C4=85 13%      +0.1        0.17 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__filename_parentat
>       0.08 =C4=85 10%      +0.1        0.17 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.path_parentat
>       0.78 =C4=85  2%      +0.1        0.92        perf-profile.children.=
cycles-pp.lookup_open
>       0.54 =C4=85  3%      +0.2        0.69 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.fstatat64
>       0.23 =C4=85 10%      +0.2        0.46 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.complete_walk
>       0.24 =C4=85  6%      +0.3        0.55 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.copy_fs_struct
>       0.24 =C4=85  6%      +0.3        0.55 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.lockref_get
>       0.39 =C4=85 18%      +0.4        0.77 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.exit_fs
>       0.48 =C4=85 16%      +0.5        0.98 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.path_put
>       3.33            +0.7        4.06        perf-profile.children.cycle=
s-pp.open_last_lookups
>       5.32            +1.3        6.61 =C4=85  3%  perf-profile.children.=
cycles-pp.filename_lookup
>       5.30            +1.3        6.60 =C4=85  3%  perf-profile.children.=
cycles-pp.path_lookupat
>       5.59            +1.3        6.94 =C4=85  2%  perf-profile.children.=
cycles-pp.__do_sys_newfstatat
>       5.51            +1.4        6.89 =C4=85  2%  perf-profile.children.=
cycles-pp.vfs_fstatat
>       5.36            +1.4        6.80 =C4=85  2%  perf-profile.children.=
cycles-pp.vfs_statx
>      14.06 =C4=85  2%      +1.5       15.61        perf-profile.children.=
cycles-pp.__lookup_slow
>      14.44 =C4=85  2%      +1.8       16.29        perf-profile.children.=
cycles-pp.d_alloc_parallel
>       9.68 =C4=85  3%      +3.0       12.68        perf-profile.children.=
cycles-pp.d_alloc
>       0.46            +4.5        4.96        perf-profile.children.cycle=
s-pp.lockref_put_return
>       9.84 =C4=85  2%      +5.0       14.85        perf-profile.children.=
cycles-pp.__dentry_kill
>       6.51 =C4=85  2%      +5.6       12.14        perf-profile.children.=
cycles-pp.step_into
>      80.87            +7.9       88.76        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>       9.08 =C4=85  2%      +7.9       16.98        perf-profile.children.=
cycles-pp.lookup_fast
>      80.82            +7.9       88.73        perf-profile.children.cycle=
s-pp.do_syscall_64
>      25.94            +8.0       33.97        perf-profile.children.cycle=
s-pp.walk_component
>       9.11 =C4=85  3%      +8.2       17.31        perf-profile.children.=
cycles-pp.lockref_get_not_dead
>       8.84 =C4=85  3%      +8.5       17.29        perf-profile.children.=
cycles-pp.try_to_unlazy
>       8.82 =C4=85  3%      +8.5       17.28        perf-profile.children.=
cycles-pp.__legitimize_path
>       9.80 =C4=85  2%      +9.2       19.05        perf-profile.children.=
cycles-pp.terminate_walk
>      31.80           +13.3       45.09        perf-profile.children.cycle=
s-pp.link_path_walk
>      20.49 =C4=85  2%     +14.7       35.22        perf-profile.children.=
cycles-pp.dput
>      36.99 =C4=85  3%     +16.9       53.91        perf-profile.children.=
cycles-pp.native_queued_spin_lock_slowpath
>      38.51 =C4=85  3%     +17.1       55.62        perf-profile.children.=
cycles-pp._raw_spin_lock
>      42.28           +21.2       63.51        perf-profile.children.cycle=
s-pp.__x64_sys_openat
>      42.26           +21.2       63.50        perf-profile.children.cycle=
s-pp.do_sys_openat2
>      41.86           +21.4       63.26        perf-profile.children.cycle=
s-pp.do_filp_open
>      41.79           +21.4       63.22        perf-profile.children.cycle=
s-pp.path_openat
>       7.51 =C4=85  5%      -5.2        2.30 =C4=85 11%  perf-profile.self=
.cycles-pp.osq_lock
>       1.82 =C4=85  2%      -0.8        1.05        perf-profile.self.cycl=
es-pp.next_uptodate_folio
>       1.82            -0.7        1.08 =C4=85  2%  perf-profile.self.cycl=
es-pp.acpi_safe_halt
>       1.74            -0.7        1.07        perf-profile.self.cycles-pp=
.clear_page_erms
>       1.08 =C4=85  2%      -0.6        0.49 =C4=85  4%  perf-profile.self=
.cycles-pp.rwsem_spin_on_owner
>       0.99 =C4=85  2%      -0.4        0.58 =C4=85  3%  perf-profile.self=
.cycles-pp.vma_interval_tree_insert
>       0.90            -0.4        0.50 =C4=85  2%  perf-profile.self.cycl=
es-pp.__slab_free
>       0.82            -0.3        0.48 =C4=85  2%  perf-profile.self.cycl=
es-pp.filemap_map_pages
>       0.75 =C4=85  2%      -0.3        0.42        perf-profile.self.cycl=
es-pp.folio_remove_rmap_ptes
>       0.62            -0.3        0.32 =C4=85  2%  perf-profile.self.cycl=
es-pp.folios_put_refs
>       0.75            -0.3        0.46 =C4=85  2%  perf-profile.self.cycl=
es-pp.__d_lookup_rcu
>       0.62            -0.3        0.34 =C4=85  3%  perf-profile.self.cycl=
es-pp.up_write
>       0.59 =C4=85  2%      -0.3        0.33 =C4=85  3%  perf-profile.self=
.cycles-pp._compound_head
>       0.56 =C4=85  2%      -0.3        0.31 =C4=85  2%  perf-profile.self=
.cycles-pp.down_write
>       0.58            -0.2        0.34 =C4=85  2%  perf-profile.self.cycl=
es-pp.zap_present_ptes
>       0.52            -0.2        0.31        perf-profile.self.cycles-pp=
.__memcg_slab_free_hook
>       0.53            -0.2        0.33        perf-profile.self.cycles-pp=
._IO_default_xsputn
>       0.50 =C4=85  2%      -0.2        0.30        perf-profile.self.cycl=
es-pp._IO_fwrite
>       0.52            -0.2        0.32        perf-profile.self.cycles-pp=
.native_irq_return_iret
>       0.48            -0.2        0.29        perf-profile.self.cycles-pp=
.sync_regs
>       0.46 =C4=85  2%      -0.2        0.26 =C4=85  2%  perf-profile.self=
.cycles-pp.update_sg_wakeup_stats
>       0.37 =C4=85  2%      -0.2        0.18 =C4=85  2%  perf-profile.self=
.cycles-pp.apparmor_file_alloc_security
>       0.44            -0.2        0.26        perf-profile.self.cycles-pp=
.strnlen_user
>       0.42            -0.2        0.24        perf-profile.self.cycles-pp=
.vma_interval_tree_remove
>       0.40            -0.2        0.24 =C4=85  2%  perf-profile.self.cycl=
es-pp.kmem_cache_alloc_noprof
>       0.39            -0.2        0.23 =C4=85  2%  perf-profile.self.cycl=
es-pp.mod_objcg_state
>       0.42            -0.2        0.26 =C4=85  2%  perf-profile.self.cycl=
es-pp.__memcg_slab_post_alloc_hook
>       0.40            -0.2        0.24        perf-profile.self.cycles-pp=
.kmem_cache_free
>       0.34            -0.1        0.20 =C4=85  2%  perf-profile.self.cycl=
es-pp._raw_spin_lock_irqsave
>       0.32            -0.1        0.18 =C4=85  3%  perf-profile.self.cycl=
es-pp.free_pages_and_swap_cache
>       0.36 =C4=85  4%      -0.1        0.24 =C4=85  3%  perf-profile.self=
.cycles-pp.update_load_avg
>       0.24 =C4=85  3%      -0.1        0.11 =C4=85  4%  perf-profile.self=
.cycles-pp.apparmor_file_free_security
>       0.28 =C4=85  2%      -0.1        0.16 =C4=85  3%  perf-profile.self=
.cycles-pp.folio_add_file_rmap_ptes
>       0.30            -0.1        0.18 =C4=85  3%  perf-profile.self.cycl=
es-pp.clear_bhb_loop
>       1.96            -0.1        1.84        perf-profile.self.cycles-pp=
._raw_spin_lock
>       0.28            -0.1        0.18 =C4=85  2%  perf-profile.self.cycl=
es-pp.mas_walk
>       0.29            -0.1        0.18        perf-profile.self.cycles-pp=
.copy_mc_enhanced_fast_string
>       0.26            -0.1        0.16 =C4=85  3%  perf-profile.self.cycl=
es-pp.memset_orig
>       0.27 =C4=85  2%      -0.1        0.17 =C4=85  2%  perf-profile.self=
.cycles-pp.___perf_sw_event
>       0.26 =C4=85  4%      -0.1        0.16 =C4=85  4%  perf-profile.self=
.cycles-pp.__schedule
>       0.24 =C4=85  2%      -0.1        0.15 =C4=85  2%  perf-profile.self=
.cycles-pp.__mod_memcg_lruvec_state
>       0.24 =C4=85  2%      -0.1        0.15        perf-profile.self.cycl=
es-pp.__cond_resched
>       0.25            -0.1        0.16 =C4=85  3%  perf-profile.self.cycl=
es-pp._IO_padn
>       0.21 =C4=85  2%      -0.1        0.12 =C4=85  4%  perf-profile.self=
.cycles-pp.__rb_insert_augmented
>       0.24 =C4=85  2%      -0.1        0.15 =C4=85  3%  perf-profile.self=
.cycles-pp.zap_pte_range
>       0.20 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.self=
.cycles-pp.rcu_segcblist_enqueue
>       0.22 =C4=85 11%      -0.1        0.13 =C4=85  8%  perf-profile.self=
.cycles-pp.rwsem_down_read_slowpath
>       0.24            -0.1        0.15 =C4=85  3%  perf-profile.self.cycl=
es-pp.cgroup_rstat_updated
>       0.20 =C4=85  4%      -0.1        0.12 =C4=85  3%  perf-profile.self=
.cycles-pp.__handle_mm_fault
>       0.21 =C4=85  4%      -0.1        0.12 =C4=85  4%  perf-profile.self=
.cycles-pp.__percpu_counter_sum
>       0.19            -0.1        0.11 =C4=85  5%  perf-profile.self.cycl=
es-pp.percpu_counter_add_batch
>       0.18 =C4=85  2%      -0.1        0.10 =C4=85  3%  perf-profile.self=
.cycles-pp.rcu_cblist_dequeue
>       0.21 =C4=85  2%      -0.1        0.14 =C4=85  2%  perf-profile.self=
.cycles-pp.up_read
>       0.19 =C4=85  3%      -0.1        0.12 =C4=85  3%  perf-profile.self=
.cycles-pp.__memcpy
>       0.18 =C4=85  2%      -0.1        0.11 =C4=85  3%  perf-profile.self=
.cycles-pp.switch_mm_irqs_off
>       0.13 =C4=85  2%      -0.1        0.06 =C4=85  6%  perf-profile.self=
.cycles-pp.rwsem_down_write_slowpath
>       0.16 =C4=85  2%      -0.1        0.09 =C4=85  5%  perf-profile.self=
.cycles-pp.try_charge_memcg
>       0.17            -0.1        0.10 =C4=85  3%  perf-profile.self.cycl=
es-pp.__get_user_8
>       0.16 =C4=85  3%      -0.1        0.09 =C4=85  4%  perf-profile.self=
.cycles-pp.__switch_to_asm
>       0.15 =C4=85  4%      -0.1        0.08 =C4=85  4%  perf-profile.self=
.cycles-pp.___slab_alloc
>       0.16            -0.1        0.09 =C4=85  5%  perf-profile.self.cycl=
es-pp.available_idle_cpu
>       0.17 =C4=85  2%      -0.1        0.10 =C4=85  4%  perf-profile.self=
.cycles-pp.set_pte_range
>       0.16 =C4=85  2%      -0.1        0.10        perf-profile.self.cycl=
es-pp.native_flush_tlb_one_user
>       0.14 =C4=85  2%      -0.1        0.08        perf-profile.self.cycl=
es-pp.lock_vma_under_rcu
>       0.15 =C4=85  4%      -0.1        0.09 =C4=85  4%  perf-profile.self=
.cycles-pp.enqueue_entity
>       0.14 =C4=85  3%      -0.1        0.09        perf-profile.self.cycl=
es-pp._IO_file_xsputn
>       0.12 =C4=85 14%      -0.1        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp._raw_spin_lock_irq
>       0.17 =C4=85  5%      -0.1        0.11 =C4=85  4%  perf-profile.self=
.cycles-pp.__update_load_avg_cfs_rq
>       0.12 =C4=85  4%      -0.1        0.07 =C4=85  5%  perf-profile.self=
.cycles-pp.down_read_trylock
>       0.13 =C4=85  2%      -0.1        0.08        perf-profile.self.cycl=
es-pp.mas_wr_node_store
>       0.12 =C4=85  3%      -0.1        0.07 =C4=85  5%  perf-profile.self=
.cycles-pp.__switch_to
>       0.13 =C4=85  2%      -0.1        0.08 =C4=85  4%  perf-profile.self=
.cycles-pp._copy_from_user
>       0.13            -0.1        0.08        perf-profile.self.cycles-pp=
.__free_one_page
>       0.12 =C4=85  4%      -0.0        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp.__rb_erase_color
>       0.12 =C4=85  3%      -0.0        0.07 =C4=85  6%  perf-profile.self=
.cycles-pp.mas_next_slot
>       0.12 =C4=85  3%      -0.0        0.07 =C4=85  5%  perf-profile.self=
.cycles-pp.menu_select
>       0.12            -0.0        0.07        perf-profile.self.cycles-pp=
.mmap_region
>       0.12            -0.0        0.07        perf-profile.self.cycles-pp=
.strncpy_from_user
>       0.10            -0.0        0.05 =C4=85  7%  perf-profile.self.cycl=
es-pp.__lruvec_stat_mod_folio
>       0.12 =C4=85  3%      -0.0        0.08 =C4=85  6%  perf-profile.self=
.cycles-pp.perf_event_mmap_output
>       0.11 =C4=85  3%      -0.0        0.06        perf-profile.self.cycl=
es-pp.restore_fpregs_from_fpstate
>       0.12 =C4=85  3%      -0.0        0.07 =C4=85  6%  perf-profile.self=
.cycles-pp.rmqueue_bulk
>       0.11            -0.0        0.06 =C4=85  7%  perf-profile.self.cycl=
es-pp._find_next_bit
>       0.12 =C4=85  3%      -0.0        0.08 =C4=85  6%  perf-profile.self=
.cycles-pp.llist_add_batch
>       0.14 =C4=85  2%      -0.0        0.09 =C4=85  4%  perf-profile.self=
.cycles-pp.obj_cgroup_charge
>       0.12 =C4=85  4%      -0.0        0.07        perf-profile.self.cycl=
es-pp.link_path_walk
>       0.11 =C4=85  4%      -0.0        0.06 =C4=85  6%  perf-profile.self=
.cycles-pp.__count_memcg_events
>       0.10 =C4=85  3%      -0.0        0.05 =C4=85  8%  perf-profile.self=
.cycles-pp.sched_mm_cid_migrate_to
>       0.13 =C4=85  8%      -0.0        0.09 =C4=85  5%  perf-profile.self=
.cycles-pp.update_rq_clock
>       0.11 =C4=85  6%      -0.0        0.07        perf-profile.self.cycl=
es-pp.rwsem_mark_wake
>       0.11 =C4=85  3%      -0.0        0.07        perf-profile.self.cycl=
es-pp.x64_sys_call
>       0.10 =C4=85  4%      -0.0        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp.rcu_all_qs
>       0.09 =C4=85  5%      -0.0        0.05 =C4=85  8%  perf-profile.self=
.cycles-pp.do_user_addr_fault
>       0.10 =C4=85  3%      -0.0        0.06 =C4=85  6%  perf-profile.self=
.cycles-pp.handle_mm_fault
>       0.09 =C4=85  5%      -0.0        0.05 =C4=85  8%  perf-profile.self=
.cycles-pp.pcpu_alloc_noprof
>       0.12            -0.0        0.08        perf-profile.self.cycles-pp=
.native_sched_clock
>       0.08            -0.0        0.04 =C4=85 44%  perf-profile.self.cycl=
es-pp.prepare_task_switch
>       0.11 =C4=85  3%      -0.0        0.07        perf-profile.self.cycl=
es-pp.getenv
>       0.08 =C4=85  4%      -0.0        0.04 =C4=85 44%  perf-profile.self=
.cycles-pp.refill_obj_stock
>       0.09 =C4=85  5%      -0.0        0.05        perf-profile.self.cycl=
es-pp.entry_SYSRETQ_unsafe_stack
>       0.09 =C4=85  5%      -0.0        0.05        perf-profile.self.cycl=
es-pp.vma_interval_tree_augment_rotate
>       0.10            -0.0        0.06 =C4=85  7%  perf-profile.self.cycl=
es-pp.task_h_load
>       0.10 =C4=85  3%      -0.0        0.07 =C4=85  7%  perf-profile.self=
.cycles-pp.update_curr
>       0.08 =C4=85  5%      -0.0        0.05        perf-profile.self.cycl=
es-pp.__memcg_kmem_charge_page
>       0.09 =C4=85  4%      -0.0        0.06 =C4=85  6%  perf-profile.self=
.cycles-pp.try_to_wake_up
>       0.09 =C4=85  4%      -0.0        0.06 =C4=85  6%  perf-profile.self=
.cycles-pp.unmap_vmas
>       0.08 =C4=85  5%      -0.0        0.05        perf-profile.self.cycl=
es-pp.vm_area_dup
>       0.07 =C4=85  6%      -0.0        0.04 =C4=85 44%  perf-profile.self=
.cycles-pp._IO_setb
>       0.10 =C4=85  3%      -0.0        0.07 =C4=85  7%  perf-profile.self=
.cycles-pp.dequeue_task_fair
>       0.09 =C4=85  5%      -0.0        0.06 =C4=85  9%  perf-profile.self=
.cycles-pp.__call_rcu_common
>       0.08 =C4=85  4%      -0.0        0.05        perf-profile.self.cycl=
es-pp.__flush_smp_call_function_queue
>       0.17 =C4=85  2%      -0.0        0.14        perf-profile.self.cycl=
es-pp.__dentry_kill
>       0.08 =C4=85  4%      -0.0        0.05 =C4=85  7%  perf-profile.self=
.cycles-pp.__mod_memcg_state
>       0.08            -0.0        0.05        perf-profile.self.cycles-pp=
.__alloc_pages_noprof
>       0.08            -0.0        0.05        perf-profile.self.cycles-pp=
.__put_user_8
>       0.08            -0.0        0.05        perf-profile.self.cycles-pp=
.__snprintf_chk
>       0.08            -0.0        0.05        perf-profile.self.cycles-pp=
.mas_wr_walk
>       0.08            -0.0        0.05        perf-profile.self.cycles-pp=
.unlink_anon_vmas
>       0.12 =C4=85  4%      -0.0        0.09 =C4=85  5%  perf-profile.self=
.cycles-pp.update_rq_clock_task
>       0.07 =C4=85  8%      -0.0        0.04 =C4=85 44%  perf-profile.self=
.cycles-pp.update_min_vruntime
>       0.09 =C4=85  5%      -0.0        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp.enqueue_task_fair
>       0.08 =C4=85  4%      -0.0        0.05        perf-profile.self.cycl=
es-pp.llist_reverse_order
>       0.09 =C4=85  5%      -0.0        0.06        perf-profile.self.cycl=
es-pp.__d_rehash
>       0.09 =C4=85 14%      -0.0        0.06 =C4=85 11%  perf-profile.self=
.cycles-pp.update_sd_lb_stats
>       0.08 =C4=85  6%      -0.0        0.05        perf-profile.self.cycl=
es-pp.copy_page
>       0.09 =C4=85  4%      -0.0        0.07        perf-profile.self.cycl=
es-pp.update_cfs_group
>       0.10 =C4=85  4%      -0.0        0.08 =C4=85  6%  perf-profile.self=
.cycles-pp.__update_load_avg_se
>       0.17 =C4=85  4%      +0.0        0.20 =C4=85  2%  perf-profile.self=
.cycles-pp.down_read
>       0.05            +0.0        0.08 =C4=85  4%  perf-profile.self.cycl=
es-pp.dput
>       0.20            +0.0        0.23 =C4=85  2%  perf-profile.self.cycl=
es-pp.fput
>       0.51 =C4=85  2%      +0.1        0.56        perf-profile.self.cycl=
es-pp.d_alloc_parallel
>       0.25 =C4=85  2%      +0.1        0.31 =C4=85  2%  perf-profile.self=
.cycles-pp.d_alloc
>       0.00            +0.1        0.12 =C4=85  4%  perf-profile.self.cycl=
es-pp.lockref_get
>       0.46 =C4=85  2%      +4.2        4.69        perf-profile.self.cycl=
es-pp.lockref_get_not_dead
>       0.45            +4.5        4.91        perf-profile.self.cycles-pp=
.lockref_put_return
>      36.60 =C4=85  3%     +16.8       53.40        perf-profile.self.cycl=
es-pp.native_queued_spin_lock_slowpath
>
>
> *************************************************************************=
**************************
> lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/te=
st/testcase/testtime:
>   gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-2024=
0206.cgz/lkp-icl-2sp8/getdent/stress-ng/60s
>
> commit:
>   267574dee6 ("bcachefs: remove now spurious i_state initialization")
>   d042dae6ad ("lockref: speculatively spin waiting for the lock to be rel=
eased")
>
> 267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     177309            -4.8%     168834        vmstat.system.in
>       5.76 =C4=85  8%     -10.4%       5.17 =C4=85  2%  iostat.cpu.idle
>      91.68            +2.0%      93.54        iostat.cpu.system
>       2.54           -49.7%       1.28 =C4=85  2%  iostat.cpu.user
>       2.77 =C4=85 18%      -0.6        2.13 =C4=85  6%  mpstat.cpu.all.id=
le%
>       1.14            -0.8        0.34 =C4=85  5%  mpstat.cpu.all.soft%
>       2.60            -1.3        1.30        mpstat.cpu.all.usr%
>     131.58 =C4=85 11%     -33.8%      87.05 =C4=85 22%  sched_debug.cfs_r=
q:/.load_avg.avg
>     358.52 =C4=85 13%     -33.9%     237.11 =C4=85 20%  sched_debug.cfs_r=
q:/.load_avg.stddev
>       3732 =C4=85  7%     -16.7%       3109 =C4=85 11%  sched_debug.cpu.a=
vg_idle.min
>   54365179 =C4=85  2%     -61.2%   21094696 =C4=85  4%  numa-numastat.nod=
e0.local_node
>   54402060 =C4=85  2%     -61.2%   21116369 =C4=85  4%  numa-numastat.nod=
e0.numa_hit
>   40309428 =C4=85  2%     -49.6%   20297594 =C4=85  4%  numa-numastat.nod=
e1.local_node
>   40351498 =C4=85  2%     -49.6%   20336354 =C4=85  4%  numa-numastat.nod=
e1.numa_hit
>   54513582 =C4=85  2%     -61.3%   21104676 =C4=85  4%  numa-vmstat.node0=
.numa_hit
>   54476717 =C4=85  2%     -61.3%   21083003 =C4=85  4%  numa-vmstat.node0=
.numa_local
>   40446773 =C4=85  2%     -49.7%   20327089 =C4=85  4%  numa-vmstat.node1=
.numa_hit
>   40404702 =C4=85  2%     -49.8%   20288329 =C4=85  4%  numa-vmstat.node1=
.numa_local
>      13178 =C4=85 17%     -47.2%       6951 =C4=85 19%  perf-c2c.DRAM.loc=
al
>      31311 =C4=85 13%     -32.5%      21125 =C4=85 18%  perf-c2c.DRAM.rem=
ote
>      29199 =C4=85 10%     -21.6%      22897 =C4=85 13%  perf-c2c.HITM.loc=
al
>      13565 =C4=85 13%     -26.8%       9931 =C4=85 19%  perf-c2c.HITM.rem=
ote
>      42764 =C4=85 11%     -23.2%      32828 =C4=85 15%  perf-c2c.HITM.tot=
al
>       9550           -59.0%       3911 =C4=85  7%  stress-ng.getdent.nano=
secs_per_getdents_call
>  1.179e+08           -56.5%   51297497 =C4=85  2%  stress-ng.getdent.ops
>    1964229           -56.5%     854956 =C4=85  2%  stress-ng.getdent.ops_=
per_sec
>   86114063           -56.4%   37516313 =C4=85  2%  stress-ng.time.minor_p=
age_faults
>       3636            +2.3%       3718        stress-ng.time.system_time
>      84.67           -57.2%      36.24 =C4=85  2%  stress-ng.time.user_ti=
me
>      57605 =C4=85  3%      -6.3%      53991 =C4=85  3%  proc-vmstat.nr_ac=
tive_anon
>       1814            -4.3%       1736 =C4=85  4%  proc-vmstat.nr_active_=
file
>     199146            +2.3%     203812        proc-vmstat.nr_inactive_ano=
n
>      37599            +4.4%      39262 =C4=85  2%  proc-vmstat.nr_mapped
>      81422            -4.2%      78023        proc-vmstat.nr_slab_reclaim=
able
>      49630            -1.9%      48672        proc-vmstat.nr_slab_unrecla=
imable
>      57605 =C4=85  3%      -6.3%      53991 =C4=85  3%  proc-vmstat.nr_zo=
ne_active_anon
>       1814            -4.3%       1736 =C4=85  4%  proc-vmstat.nr_zone_ac=
tive_file
>     199146            +2.3%     203812        proc-vmstat.nr_zone_inactiv=
e_anon
>      15605 =C4=85 19%     -41.3%       9164 =C4=85 22%  proc-vmstat.numa_=
hint_faults
>       8927 =C4=85 36%     -38.8%       5463 =C4=85 11%  proc-vmstat.numa_=
hint_faults_local
>   94830413 =C4=85  2%     -56.3%   41449377 =C4=85  3%  proc-vmstat.numa_=
hit
>   94751461 =C4=85  2%     -56.3%   41388944 =C4=85  3%  proc-vmstat.numa_=
local
>     119660 =C4=85  8%     +26.4%     151293 =C4=85  7%  proc-vmstat.pgact=
ivate
>   99784640 =C4=85  2%     -57.0%   42943559 =C4=85  3%  proc-vmstat.pgall=
oc_normal
>   86284666           -56.2%   37781294 =C4=85  2%  proc-vmstat.pgfault
>   99496632 =C4=85  2%     -57.1%   42682486 =C4=85  3%  proc-vmstat.pgfre=
e
>       3.32 =C4=85  3%     -28.6%       2.37        perf-stat.i.MPKI
>  1.114e+10           -32.5%  7.517e+09        perf-stat.i.branch-instruct=
ions
>       0.66            -0.1        0.53        perf-stat.i.branch-miss-rat=
e%
>   70296622           -44.4%   39108658        perf-stat.i.branch-misses
>      45.76            -5.5       40.29        perf-stat.i.cache-miss-rate=
%
>  1.696e+08 =C4=85  2%     -54.1%   77750955        perf-stat.i.cache-miss=
es
>   3.68e+08 =C4=85  2%     -47.8%  1.921e+08        perf-stat.i.cache-refe=
rences
>       4.43           +58.7%       7.03        perf-stat.i.cpi
>     271.12 =C4=85  3%     -24.9%     203.71 =C4=85  7%  perf-stat.i.cpu-m=
igrations
>       1364 =C4=85  2%    +120.5%       3008        perf-stat.i.cycles-bet=
ween-cache-misses
>  5.101e+10           -36.2%  3.255e+10        perf-stat.i.instructions
>       0.23           -35.7%       0.15        perf-stat.i.ipc
>      44.34           -56.2%      19.42        perf-stat.i.metric.K/sec
>    1416143           -56.4%     617728 =C4=85  2%  perf-stat.i.minor-faul=
ts
>    1416143           -56.4%     617728 =C4=85  2%  perf-stat.i.page-fault=
s
>       3.33 =C4=85  2%     -28.1%       2.39        perf-stat.overall.MPKI
>       0.63            -0.1        0.52        perf-stat.overall.branch-mi=
ss-rate%
>      46.07            -5.6       40.47        perf-stat.overall.cache-mis=
s-rate%
>       4.39           +57.2%       6.91        perf-stat.overall.cpi
>       1321 =C4=85  2%    +118.5%       2887 =C4=85  2%  perf-stat.overall=
.cycles-between-cache-misses
>       0.23           -36.4%       0.14        perf-stat.overall.ipc
>  1.096e+10           -32.5%  7.405e+09        perf-stat.ps.branch-instruc=
tions
>   69044394           -44.4%   38415093        perf-stat.ps.branch-misses
>  1.669e+08 =C4=85  2%     -54.0%   76744131 =C4=85  2%  perf-stat.ps.cach=
e-misses
>  3.623e+08 =C4=85  2%     -47.6%  1.897e+08 =C4=85  2%  perf-stat.ps.cach=
e-references
>     268.10 =C4=85  3%     -24.8%     201.67 =C4=85  7%  perf-stat.ps.cpu-=
migrations
>  5.019e+10           -36.1%  3.207e+10        perf-stat.ps.instructions
>    1393551           -56.3%     609646 =C4=85  2%  perf-stat.ps.minor-fau=
lts
>    1393551           -56.3%     609646 =C4=85  2%  perf-stat.ps.page-faul=
ts
>  3.071e+12           -36.3%  1.957e+12        perf-stat.total.instruction=
s
>      58.94           -52.6        6.32 =C4=85 33%  perf-profile.calltrace=
.cycles-pp.syscall
>      58.03           -52.0        5.99 =C4=85 35%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>      57.96           -52.0        5.96 =C4=85 35%  perf-profile.calltrace=
.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      29.21           -26.2        2.99 =C4=85 35%  perf-profile.calltrace=
.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
syscall
>      28.52           -25.6        2.90 =C4=85 36%  perf-profile.calltrace=
.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.syscall
>      28.40           -25.5        2.88 =C4=85 36%  perf-profile.calltrace=
.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.syscall
>      27.98           -25.2        2.82 =C4=85 37%  perf-profile.calltrace=
.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_=
after_hwframe.syscall
>       8.70 =C4=85  4%      -8.3        0.36 =C4=85102%  perf-profile.call=
trace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_sys=
call_64.entry_SYSCALL_64_after_hwframe
>       8.66 =C4=85  4%      -8.3        0.35 =C4=85102%  perf-profile.call=
trace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_s=
yscall_64.entry_SYSCALL_64_after_hwframe
>       8.62 =C4=85  4%      -8.3        0.35 =C4=85102%  perf-profile.call=
trace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys=
_getdents.do_syscall_64
>       8.61 =C4=85  4%      -8.3        0.35 =C4=85102%  perf-profile.call=
trace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys=
_getdents64.do_syscall_64
>       5.90 =C4=85  5%      -5.2        0.69 =C4=85 14%  perf-profile.call=
trace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_s=
ys_openat2
>       5.49 =C4=85 18%      -5.1        0.37 =C4=85223%  perf-profile.call=
trace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents64.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
>       5.47 =C4=85 18%      -5.1        0.36 =C4=85223%  perf-profile.call=
trace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents.do_syscall_6=
4.entry_SYSCALL_64_after_hwframe
>       5.09 =C4=85  4%      -5.1        0.00        perf-profile.calltrace=
.cycles-pp.proc_readdir_de.iterate_dir.__x64_sys_getdents.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
>       5.09 =C4=85  4%      -5.1        0.00        perf-profile.calltrace=
.cycles-pp.proc_readdir_de.iterate_dir.__x64_sys_getdents64.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe
>       5.93 =C4=85  3%      -5.0        0.90 =C4=85 10%  perf-profile.call=
trace.cycles-pp.__close
>       5.64 =C4=85  3%      -4.8        0.80 =C4=85 11%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
>       5.63 =C4=85  3%      -4.8        0.80 =C4=85 11%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       5.55 =C4=85  3%      -4.8        0.77 =C4=85 11%  perf-profile.call=
trace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.__close
>       4.94 =C4=85 20%      -4.6        0.35 =C4=85223%  perf-profile.call=
trace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents=
64.do_syscall_64
>       4.92 =C4=85 20%      -4.6        0.34 =C4=85223%  perf-profile.call=
trace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents=
.do_syscall_64
>       4.34 =C4=85  4%      -3.9        0.40 =C4=85 71%  perf-profile.call=
trace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.__close
>       4.28 =C4=85  4%      -3.6        0.64 =C4=85 18%  perf-profile.call=
trace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do=
_sys_openat2
>       3.28 =C4=85  2%      -2.6        0.65 =C4=85  7%  perf-profile.call=
trace.cycles-pp.brk
>       3.20 =C4=85  2%      -2.6        0.62 =C4=85  7%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
>       3.20 =C4=85  2%      -2.6        0.62 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       3.16 =C4=85  2%      -2.6        0.61 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.b=
rk
>       2.79 =C4=85  2%      -2.1        0.66 =C4=85  8%  perf-profile.call=
trace.cycles-pp.asm_exc_page_fault
>       2.52 =C4=85  3%      -2.0        0.48 =C4=85 45%  perf-profile.call=
trace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       2.54 =C4=85  2%      -2.0        0.57 =C4=85  8%  perf-profile.call=
trace.cycles-pp.exc_page_fault.asm_exc_page_fault
>       2.51            -1.9        0.60 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64=
.entry_SYSCALL_64_after_hwframe
>       2.49            -1.9        0.59        perf-profile.calltrace.cycl=
es-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.en=
try_SYSCALL_64_after_hwframe
>       2.39            -1.8        0.57 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getden=
ts64.do_syscall_64
>       2.39            -1.8        0.58        perf-profile.calltrace.cycl=
es-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getdents.do=
_syscall_64
>       5.01 =C4=85  3%      +1.8        6.76        perf-profile.calltrace=
.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_op=
enat2
>       0.00            +2.2        2.20 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast=
.walk_component
>       0.00            +2.2        2.20 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_=
path_walk
>       0.00            +2.2        2.20 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_ope=
nat
>       3.39 =C4=85  4%      +3.2        6.54 =C4=85  2%  perf-profile.call=
trace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_fi=
lp_open
>       0.00            +3.5        3.45 =C4=85 12%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_=
dead.__legitimize_path.try_to_unlazy_next
>       0.00            +3.5        3.48 =C4=85 12%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unl=
azy_next.lookup_fast
>       0.00            +3.9        3.91 =C4=85  4%  perf-profile.calltrace=
.cycles-pp.__legitimize_path.try_to_unlazy_next.lookup_fast.walk_component.=
link_path_walk
>       0.00            +3.9        3.91 =C4=85  4%  perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup=
_fast.walk_component
>       0.00            +3.9        3.92 =C4=85  4%  perf-profile.calltrace=
.cycles-pp.try_to_unlazy_next.lookup_fast.walk_component.link_path_walk.pat=
h_openat
>       0.90 =C4=85  4%      +5.7        6.62 =C4=85  9%  perf-profile.call=
trace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_=
open
>       7.79 =C4=85  4%      +9.7       17.50 =C4=85  2%  perf-profile.call=
trace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2._=
_x64_sys_openat
>       1.53 =C4=85  4%     +15.1       16.61 =C4=85  3%  perf-profile.call=
trace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_s=
ys_openat2
>       0.00           +15.3       15.34 =C4=85  3%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unl=
azy.lookup_fast
>       0.18 =C4=85141%     +15.7       15.91 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_looku=
ps.path_openat
>       0.18 =C4=85141%     +15.7       15.92 =C4=85  3%  perf-profile.call=
trace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_=
filp_open
>       0.00           +15.9       15.90 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast=
.open_last_lookups
>      11.06 =C4=85  2%     +17.1       28.20 =C4=85  2%  perf-profile.call=
trace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x6=
4_sys_openat
>       0.00           +17.4       17.40 =C4=85  3%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unl=
azy.link_path_walk
>       0.66 =C4=85  9%     +19.9       20.56 =C4=85  3%  perf-profile.call=
trace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sy=
s_openat2
>       0.65 =C4=85 10%     +19.9       20.55 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.=
do_filp_open
>       0.38 =C4=85 71%     +20.2       20.54 =C4=85  3%  perf-profile.call=
trace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_p=
ath_walk.path_openat
>       0.00           +32.4       32.45 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_=
dead.__legitimize_path.try_to_unlazy
>       0.00           +35.8       35.76 =C4=85  3%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_w=
alk.path_openat
>       0.00           +36.1       36.09 =C4=85  3%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
>       1.19 =C4=85 10%     +41.6       42.82 =C4=85  3%  perf-profile.call=
trace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x6=
4_sys_openat
>       1.15 =C4=85 10%     +41.6       42.80 =C4=85  3%  perf-profile.call=
trace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
>      26.89 =C4=85  2%     +63.4       90.25 =C4=85  2%  perf-profile.call=
trace.cycles-pp.open64
>      26.57 =C4=85  2%     +63.6       90.13 =C4=85  2%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>      26.55 =C4=85  2%     +63.6       90.12 =C4=85  2%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>      26.46 =C4=85  2%     +63.6       90.09 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.open64
>      26.43 =C4=85  2%     +63.6       90.08 =C4=85  2%  perf-profile.call=
trace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL=
_64_after_hwframe.open64
>      25.37 =C4=85  2%     +64.0       89.41 =C4=85  2%  perf-profile.call=
trace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
>      25.30 =C4=85  2%     +64.1       89.39 =C4=85  2%  perf-profile.call=
trace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do=
_syscall_64
>      59.11           -52.7        6.38 =C4=85 33%  perf-profile.children.=
cycles-pp.syscall
>      56.40           -50.7        5.70 =C4=85 36%  perf-profile.children.=
cycles-pp.iterate_dir
>      29.22           -26.2        2.99 =C4=85 35%  perf-profile.children.=
cycles-pp.__x64_sys_getdents
>      27.45 =C4=85  4%     -25.7        1.71 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.proc_readdir_de
>      28.53           -25.6        2.90 =C4=85 36%  perf-profile.children.=
cycles-pp.__x64_sys_getdents64
>      17.36 =C4=85  4%     -16.2        1.18 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.proc_tgid_net_readdir
>      14.38 =C4=85  4%     -13.7        0.65 =C4=85 38%  perf-profile.chil=
dren.cycles-pp._raw_read_lock
>      10.97 =C4=85 18%     -10.1        0.85 =C4=85186%  perf-profile.chil=
dren.cycles-pp.eventfs_iterate
>       9.85 =C4=85 20%      -9.2        0.70 =C4=85223%  perf-profile.chil=
dren.cycles-pp.__mutex_lock
>       9.14 =C4=85 22%      -8.5        0.68 =C4=85223%  perf-profile.chil=
dren.cycles-pp.osq_lock
>       6.78 =C4=85  6%      -6.0        0.75 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.kernfs_fop_readdir
>       6.54 =C4=85  7%      -5.7        0.87 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.down_read
>       5.94 =C4=85  6%      -5.5        0.40 =C4=85 39%  perf-profile.chil=
dren.cycles-pp.up_read
>       5.90 =C4=85  5%      -5.2        0.70 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.lookup_open
>       5.68 =C4=85  6%      -5.1        0.55 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.proc_lookup_de
>       5.98 =C4=85  3%      -5.1        0.92 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.__close
>       6.65            -5.0        1.63        perf-profile.children.cycle=
s-pp.proc_fill_cache
>       5.57 =C4=85  6%      -5.0        0.55 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.proc_tgid_net_lookup
>       5.56 =C4=85  3%      -4.8        0.78 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__x64_sys_close
>       5.06 =C4=85  4%      -4.3        0.73 =C4=85 18%  perf-profile.chil=
dren.cycles-pp.inode_permission
>       5.01            -3.8        1.19        perf-profile.children.cycle=
s-pp.proc_pident_readdir
>       4.36 =C4=85  4%      -3.8        0.56 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.__fput
>       4.70            -3.6        1.14 =C4=85  4%  perf-profile.children.=
cycles-pp.__d_lookup
>       3.85 =C4=85  6%      -3.3        0.51 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.kernfs_iop_permission
>       3.54            -3.1        0.48 =C4=85  9%  perf-profile.children.=
cycles-pp.do_open
>       3.58            -2.6        0.93        perf-profile.children.cycle=
s-pp.d_hash_and_lookup
>       3.29 =C4=85  2%      -2.6        0.65 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.brk
>       3.16 =C4=85  2%      -2.6        0.61 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__do_sys_brk
>       2.70 =C4=85  7%      -2.5        0.20 =C4=85 32%  perf-profile.chil=
dren.cycles-pp.kernfs_dop_revalidate
>       2.76 =C4=85  6%      -2.4        0.35 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.__dentry_kill
>       2.67 =C4=85 11%      -2.3        0.35 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.proc_get_inode
>       3.01 =C4=85  2%      -2.3        0.72 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.asm_exc_page_fault
>       2.60 =C4=85 11%      -2.3        0.33 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.new_inode
>       2.70 =C4=85  2%      -2.1        0.60 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.exc_page_fault
>       2.69 =C4=85  3%      -2.1        0.60 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.do_user_addr_fault
>       2.48 =C4=85  2%      -2.0        0.44 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.do_vmi_align_munmap
>       2.32 =C4=85  2%      -2.0        0.29 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.do_dentry_open
>       1.88 =C4=85  8%      -1.7        0.16 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.evict
>       2.16 =C4=85  3%      -1.7        0.50 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.handle_mm_fault
>       1.98 =C4=85  2%      -1.7        0.31 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.unmap_region
>       2.01 =C4=85  3%      -1.6        0.45 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.__handle_mm_fault
>       1.86 =C4=85  3%      -1.5        0.40 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.do_anonymous_page
>       1.53 =C4=85  6%      -1.3        0.22 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__lookup_slow
>       1.35 =C4=85  4%      -1.2        0.14 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.security_file_open
>       1.35 =C4=85  4%      -1.2        0.14 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.apparmor_file_open
>       1.42 =C4=85  3%      -1.1        0.31 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.alloc_empty_file
>       1.37 =C4=85  3%      -0.9        0.42 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.handle_softirqs
>       1.36 =C4=85  3%      -0.9        0.41 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.rcu_core
>       1.35 =C4=85  2%      -0.9        0.41 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.rcu_do_batch
>       1.08 =C4=85  4%      -0.9        0.20 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.init_file
>       1.21 =C4=85  3%      -0.8        0.36 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.kmem_cache_free
>       0.92 =C4=85  2%      -0.8        0.07 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.mutex_lock
>       1.04 =C4=85  2%      -0.8        0.23 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.step_into
>       0.87 =C4=85  2%      -0.8        0.10 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.pde_put
>       0.92 =C4=85  4%      -0.7        0.17 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.security_file_alloc
>       1.00            -0.7        0.27 =C4=85  2%  perf-profile.children.=
cycles-pp.proc_map_files_readdir
>       0.83 =C4=85  4%      -0.7        0.11 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.may_open
>       0.82 =C4=85  2%      -0.7        0.13 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.tlb_finish_mmu
>       0.96 =C4=85  3%      -0.7        0.27 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.alloc_anon_folio
>       1.16 =C4=85  2%      -0.7        0.47 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.82 =C4=85  4%      -0.7        0.14 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.apparmor_file_alloc_security
>       0.80 =C4=85  2%      -0.7        0.11 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.folios_put_refs
>       1.13 =C4=85  3%      -0.7        0.45 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.sysvec_apic_timer_interrupt
>       0.86 =C4=85  5%      -0.7        0.18 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.irq_exit_rcu
>       0.87 =C4=85  2%      -0.7        0.20 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.proc_readfd_common
>       0.75 =C4=85  2%      -0.6        0.11 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.__fdget_pos
>       0.84            -0.6        0.20 =C4=85  2%  perf-profile.children.=
cycles-pp.proc_ns_dir_readdir
>       0.74            -0.6        0.12 =C4=85 10%  perf-profile.children.=
cycles-pp.__tlb_batch_free_encoded_pages
>       0.69 =C4=85  3%      -0.6        0.06 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.d_splice_alias
>       0.74 =C4=85  2%      -0.6        0.12 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.free_pages_and_swap_cache
>       0.63 =C4=85  2%      -0.6        0.08 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.folio_batch_move_lru
>       0.67 =C4=85  5%      -0.5        0.13 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.security_file_free
>       0.61 =C4=85  2%      -0.5        0.07 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.fsnotify_grab_connector
>       0.66 =C4=85  5%      -0.5        0.13 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.apparmor_file_free_security
>       0.61 =C4=85  2%      -0.5        0.08 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.down_read_killable
>       0.60 =C4=85  2%      -0.5        0.07 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.lru_add_drain
>       0.60 =C4=85  2%      -0.5        0.07 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.lru_add_drain_cpu
>       0.69 =C4=85  4%      -0.5        0.17 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__slab_free
>       0.58 =C4=85  4%      -0.5        0.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.kernfs_dir_pos
>       0.78 =C4=85  2%      -0.5        0.27 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.filldir
>       0.76            -0.5        0.26 =C4=85  6%  perf-profile.children.=
cycles-pp.filldir64
>       0.77 =C4=85  3%      -0.5        0.28 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.clear_bhb_loop
>       0.60 =C4=85  2%      -0.5        0.11 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.filp_flush
>       0.75 =C4=85  2%      -0.5        0.26 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc_noprof
>       0.73 =C4=85  2%      -0.5        0.25 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.alloc_inode
>       0.62 =C4=85  6%      -0.5        0.14 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.security_file_permission
>       0.59 =C4=85  6%      -0.5        0.13 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.apparmor_file_permission
>       0.48 =C4=85  3%      -0.5        0.03 =C4=85100%  perf-profile.chil=
dren.cycles-pp.__d_add
>       0.52 =C4=85  2%      -0.4        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.dnotify_flush
>       0.60 =C4=85  3%      -0.4        0.16 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.vma_alloc_folio_noprof
>       0.59 =C4=85  4%      -0.4        0.16 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.alloc_pages_mpol_noprof
>       0.50 =C4=85  2%      -0.4        0.07 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.fsnotify_find_mark
>       0.66 =C4=85  2%      -0.4        0.24 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.d_alloc_parallel
>       0.56 =C4=85  3%      -0.4        0.15 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.__alloc_pages_noprof
>       0.56 =C4=85  4%      -0.4        0.17 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc_lru_noprof
>       0.48 =C4=85  2%      -0.4        0.10 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.unmap_vmas
>       0.48 =C4=85  3%      -0.4        0.09 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.unmap_page_range
>       0.47 =C4=85  2%      -0.4        0.09 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.zap_pmd_range
>       0.46 =C4=85  3%      -0.4        0.09 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.zap_pte_range
>       0.49 =C4=85  2%      -0.4        0.12 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.do_brk_flags
>       0.47 =C4=85  3%      -0.4        0.12 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.get_page_from_freelist
>       0.38            -0.3        0.06 =C4=85  7%  perf-profile.children.=
cycles-pp.zap_present_ptes
>       0.48 =C4=85  2%      -0.3        0.18 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__memcg_slab_post_alloc_hook
>       0.36 =C4=85  3%      -0.3        0.06 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.__call_rcu_common
>       0.49 =C4=85  3%      -0.3        0.19 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.d_alloc
>       0.32 =C4=85  2%      -0.3        0.02 =C4=85 99%  perf-profile.chil=
dren.cycles-pp.alloc_fd
>       0.36 =C4=85  2%      -0.3        0.07 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.inode_wait_for_writeback
>       0.53 =C4=85  7%      -0.3        0.26 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.kthread
>       0.53 =C4=85  7%      -0.3        0.26 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.ret_from_fork
>       0.53 =C4=85  7%      -0.3        0.26 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.ret_from_fork_asm
>       0.51 =C4=85  8%      -0.3        0.24 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.run_ksoftirqd
>       0.51 =C4=85  8%      -0.3        0.24 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.smpboot_thread_fn
>       0.37 =C4=85  5%      -0.3        0.10 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.proc_alloc_inode
>       0.32 =C4=85  6%      -0.3        0.07 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.___slab_alloc
>       0.38 =C4=85  2%      -0.2        0.14 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.__cond_resched
>       0.32 =C4=85  2%      -0.2        0.08 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.__split_vma
>       0.38 =C4=85  2%      -0.2        0.14 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64
>       0.28 =C4=85  2%      -0.2        0.05        perf-profile.children.=
cycles-pp.lockref_get
>       0.32 =C4=85  2%      -0.2        0.09 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__d_lookup_rcu
>       0.32 =C4=85  3%      -0.2        0.09 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__mem_cgroup_charge
>       0.42 =C4=85 21%      -0.2        0.20 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.rb_next
>       0.34 =C4=85  3%      -0.2        0.13 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.getname_flags
>       0.36 =C4=85  2%      -0.2        0.15 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.inode_init_always
>       0.23 =C4=85  2%      -0.2        0.03 =C4=85 70%  perf-profile.chil=
dren.cycles-pp.task_lookup_next_fdget_rcu
>       0.23 =C4=85  5%      -0.2        0.04 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.security_file_post_open
>       0.30 =C4=85  2%      -0.2        0.11 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__memcg_slab_free_hook
>       0.22 =C4=85  5%      -0.2        0.04 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.ima_file_check
>       0.27 =C4=85  2%      -0.2        0.10 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.24 =C4=85  2%      -0.2        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.pid_delete_dentry
>       0.22 =C4=85  3%      -0.2        0.06 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.path_init
>       0.25 =C4=85  3%      -0.2        0.09 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.sync_regs
>       0.21 =C4=85  3%      -0.2        0.06 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.proc_free_inode
>       0.24 =C4=85  3%      -0.1        0.09 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.__d_alloc
>       0.23 =C4=85  4%      -0.1        0.09 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.strncpy_from_user
>       0.22 =C4=85  2%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.native_irq_return_iret
>       0.19 =C4=85  2%      -0.1        0.06 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_wr_store_entry
>       0.22 =C4=85  2%      -0.1        0.08 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.verify_dirent_name
>       0.20 =C4=85  2%      -0.1        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.stress_getdents_dir
>       0.20 =C4=85  5%      -0.1        0.08 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.pid_revalidate
>       0.20 =C4=85  3%      -0.1        0.08 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.mod_objcg_state
>       0.19            -0.1        0.07 =C4=85  8%  perf-profile.children.=
cycles-pp.stress_getdents64_dir
>       0.18 =C4=85  4%      -0.1        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.strlcat
>       0.15 =C4=85  3%      -0.1        0.03 =C4=85100%  perf-profile.chil=
dren.cycles-pp.nd_jump_root
>       0.17 =C4=85  4%      -0.1        0.06 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.perf_event_mmap
>       0.18 =C4=85  2%      -0.1        0.07 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.snprintf
>       0.19 =C4=85  2%      -0.1        0.07 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.security_inode_alloc
>       0.17 =C4=85  4%      -0.1        0.06 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.__lruvec_stat_mod_folio
>       0.16 =C4=85  4%      -0.1        0.05 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.perf_event_mmap_event
>       0.18 =C4=85  2%      -0.1        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.vsnprintf
>       0.18 =C4=85  2%      -0.1        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.memchr
>       0.17 =C4=85  4%      -0.1        0.06 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.clear_page_erms
>       0.18 =C4=85  2%      -0.1        0.07 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.generic_permission
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__mod_memcg_lruvec_state
>       0.16 =C4=85  2%      -0.1        0.06 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode
>       0.18 =C4=85  2%      -0.1        0.08 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.rcu_cblist_dequeue
>       0.15            -0.1        0.05 =C4=85  7%  perf-profile.children.=
cycles-pp.__perf_sw_event
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.rcu_all_qs
>       0.13            -0.1        0.03 =C4=85 70%  perf-profile.children.=
cycles-pp.___perf_sw_event
>       0.13 =C4=85  6%      -0.1        0.04 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.__check_object_size
>       0.11            -0.1        0.02 =C4=85 99%  perf-profile.children.=
cycles-pp.errseq_sample
>       0.00            +0.1        0.05 =C4=85  7%  perf-profile.children.=
cycles-pp.get_jiffies_update
>       0.00            +0.1        0.05 =C4=85  7%  perf-profile.children.=
cycles-pp.tmigr_requires_handle_remote
>       0.00            +0.1        0.06 =C4=85  6%  perf-profile.children.=
cycles-pp.vfs_fstatat
>       0.00            +0.1        0.06 =C4=85  6%  perf-profile.children.=
cycles-pp.vfs_statx
>       0.00            +0.1        0.06        perf-profile.children.cycle=
s-pp.__do_sys_newfstatat
>       0.00            +0.1        0.06 =C4=85  6%  perf-profile.children.=
cycles-pp.filename_lookup
>       0.00            +0.1        0.06 =C4=85  6%  perf-profile.children.=
cycles-pp.path_lookupat
>       0.24 =C4=85  3%      +0.2        0.44 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.putname
>       5.03 =C4=85  3%      +1.9        6.93        perf-profile.children.=
cycles-pp.walk_component
>       2.70 =C4=85  2%      +4.1        6.80 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.lockref_put_return
>       0.12 =C4=85 12%      +4.3        4.38 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.try_to_unlazy_next
>      93.59            +4.4       97.98        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      93.49            +4.4       97.94        perf-profile.children.cycle=
s-pp.do_syscall_64
>       7.80 =C4=85  4%      +9.7       17.52 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.open_last_lookups
>      11.09 =C4=85  2%     +17.3       28.42 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.link_path_walk
>       4.95 =C4=85  4%     +18.3       23.29 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.lookup_fast
>       6.89 =C4=85  4%     +36.7       43.64 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.dput
>       1.37 =C4=85  9%     +37.4       38.81 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.try_to_unlazy
>       1.20 =C4=85 10%     +41.7       42.95 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.terminate_walk
>       1.42 =C4=85 10%     +41.8       43.18 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.__legitimize_path
>       1.11 =C4=85 12%     +42.0       43.16 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.lockref_get_not_dead
>      26.94 =C4=85  2%     +63.3       90.27 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.open64
>      26.49 =C4=85  2%     +63.9       90.38 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__x64_sys_openat
>      26.46 =C4=85  2%     +63.9       90.38 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.do_sys_openat2
>       9.73 =C4=85  7%     +64.0       73.74 =C4=85  3%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock
>      25.39 =C4=85  2%     +64.3       89.71 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.do_filp_open
>      25.33 =C4=85  2%     +64.4       89.69 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.path_openat
>       4.21 =C4=85 14%     +68.2       72.38 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.native_queued_spin_lock_slowpath
>      14.22 =C4=85  4%     -13.6        0.64 =C4=85 37%  perf-profile.self=
.cycles-pp._raw_read_lock
>      12.62 =C4=85  4%     -11.9        0.73 =C4=85 28%  perf-profile.self=
.cycles-pp.proc_readdir_de
>       9.07 =C4=85 22%      -8.4        0.68 =C4=85223%  perf-profile.self=
.cycles-pp.osq_lock
>       6.45 =C4=85  7%      -5.6        0.84 =C4=85 19%  perf-profile.self=
.cycles-pp.down_read
>       5.89 =C4=85  6%      -5.5        0.39 =C4=85 39%  perf-profile.self=
.cycles-pp.up_read
>       5.72 =C4=85  2%      -4.4        1.36 =C4=85  6%  perf-profile.self=
.cycles-pp._raw_spin_lock
>       2.20            -1.4        0.78 =C4=85  3%  perf-profile.self.cycl=
es-pp.__d_lookup
>       1.50 =C4=85  4%      -1.4        0.09 =C4=85 30%  perf-profile.self=
.cycles-pp.proc_lookup_de
>       1.33 =C4=85  4%      -1.2        0.14 =C4=85 15%  perf-profile.self=
.cycles-pp.apparmor_file_open
>       0.86 =C4=85  2%      -0.8        0.04 =C4=85 77%  perf-profile.self=
.cycles-pp.mutex_lock
>       0.86 =C4=85  2%      -0.8        0.09 =C4=85 16%  perf-profile.self=
.cycles-pp.pde_put
>       0.80 =C4=85  4%      -0.7        0.14 =C4=85 10%  perf-profile.self=
.cycles-pp.apparmor_file_alloc_security
>       0.60 =C4=85  2%      -0.5        0.07 =C4=85 11%  perf-profile.self=
.cycles-pp.do_dentry_open
>       0.65 =C4=85  5%      -0.5        0.13 =C4=85 12%  perf-profile.self=
.cycles-pp.apparmor_file_free_security
>       0.68 =C4=85  4%      -0.5        0.16 =C4=85  5%  perf-profile.self=
.cycles-pp.__slab_free
>       0.58 =C4=85  3%      -0.5        0.07 =C4=85  9%  perf-profile.self=
.cycles-pp.down_read_killable
>       0.76 =C4=85  3%      -0.5        0.28 =C4=85  5%  perf-profile.self=
.cycles-pp.clear_bhb_loop
>       0.50 =C4=85  2%      -0.5        0.04 =C4=85 71%  perf-profile.self=
.cycles-pp.__fput
>       0.77 =C4=85  3%      -0.5        0.31 =C4=85  5%  perf-profile.self=
.cycles-pp.proc_fill_cache
>       0.55 =C4=85  6%      -0.4        0.12 =C4=85 10%  perf-profile.self=
.cycles-pp.apparmor_file_permission
>       0.50 =C4=85  2%      -0.4        0.11 =C4=85  6%  perf-profile.self=
.cycles-pp.kernfs_fop_readdir
>       0.56 =C4=85  2%      -0.4        0.20 =C4=85  5%  perf-profile.self=
.cycles-pp.filldir
>       0.56 =C4=85  2%      -0.4        0.20 =C4=85  6%  perf-profile.self=
.cycles-pp.filldir64
>       0.38 =C4=85  3%      -0.3        0.12 =C4=85 11%  perf-profile.self=
.cycles-pp.inode_permission
>       0.31 =C4=85  2%      -0.2        0.09 =C4=85  7%  perf-profile.self=
.cycles-pp.__d_lookup_rcu
>       0.40 =C4=85 21%      -0.2        0.20 =C4=85  7%  perf-profile.self=
.cycles-pp.rb_next
>       0.31 =C4=85  2%      -0.2        0.12 =C4=85  9%  perf-profile.self=
.cycles-pp.kmem_cache_alloc_noprof
>       0.26            -0.2        0.10 =C4=85  4%  perf-profile.self.cycl=
es-pp.entry_SYSRETQ_unsafe_stack
>       0.23 =C4=85  2%      -0.2        0.07 =C4=85  5%  perf-profile.self=
.cycles-pp.pid_delete_dentry
>       0.24 =C4=85  3%      -0.2        0.08 =C4=85  8%  perf-profile.self=
.cycles-pp.__memcg_slab_post_alloc_hook
>       0.24 =C4=85  3%      -0.2        0.09 =C4=85  7%  perf-profile.self=
.cycles-pp.sync_regs
>       0.23 =C4=85  2%      -0.1        0.08 =C4=85  5%  perf-profile.self=
.cycles-pp.syscall
>       0.22 =C4=85  2%      -0.1        0.08 =C4=85  5%  perf-profile.self=
.cycles-pp.native_irq_return_iret
>       0.21 =C4=85  2%      -0.1        0.07 =C4=85 10%  perf-profile.self=
.cycles-pp.link_path_walk
>       0.21 =C4=85  2%      -0.1        0.08 =C4=85  4%  perf-profile.self=
.cycles-pp.__cond_resched
>       0.16 =C4=85  3%      -0.1        0.03 =C4=85 70%  perf-profile.self=
.cycles-pp.d_alloc_parallel
>       0.18 =C4=85  4%      -0.1        0.07 =C4=85  7%  perf-profile.self=
.cycles-pp.__fdget_pos
>       0.18 =C4=85  3%      -0.1        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp.stress_getdents_dir
>       0.18 =C4=85  3%      -0.1        0.07 =C4=85  7%  perf-profile.self=
.cycles-pp.kmem_cache_free
>       0.17 =C4=85  2%      -0.1        0.06 =C4=85  6%  perf-profile.self=
.cycles-pp.stress_getdents64_dir
>       0.17 =C4=85  4%      -0.1        0.06 =C4=85  6%  perf-profile.self=
.cycles-pp.strlcat
>       0.14 =C4=85  5%      -0.1        0.03 =C4=85 70%  perf-profile.self=
.cycles-pp.step_into
>       0.17 =C4=85  4%      -0.1        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp.clear_page_erms
>       0.16 =C4=85  2%      -0.1        0.06 =C4=85  8%  perf-profile.self=
.cycles-pp.memchr
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85  7%  perf-profile.self=
.cycles-pp.mod_objcg_state
>       0.15 =C4=85  2%      -0.1        0.05 =C4=85  7%  perf-profile.self=
.cycles-pp.do_syscall_64
>       0.17 =C4=85  2%      -0.1        0.08 =C4=85  6%  perf-profile.self=
.cycles-pp.rcu_cblist_dequeue
>       0.12 =C4=85  3%      -0.1        0.04 =C4=85 71%  perf-profile.self=
.cycles-pp.inode_init_always
>       0.14 =C4=85  3%      -0.1        0.06 =C4=85 11%  perf-profile.self=
.cycles-pp.generic_permission
>       0.00            +0.1        0.05 =C4=85  7%  perf-profile.self.cycl=
es-pp.get_jiffies_update
>       0.24 =C4=85  3%      +0.2        0.44 =C4=85  4%  perf-profile.self=
.cycles-pp.putname
>       2.66 =C4=85  3%      +4.1        6.77 =C4=85  9%  perf-profile.self=
.cycles-pp.lockref_put_return
>       0.85 =C4=85  5%      +5.7        6.58 =C4=85  8%  perf-profile.self=
.cycles-pp.lockref_get_not_dead
>       4.08 =C4=85 14%     +68.0       72.04 =C4=85  3%  perf-profile.self=
.cycles-pp.native_queued_spin_lock_slowpath
>
>
>
> *************************************************************************=
**************************
> lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/te=
st/testcase/testtime:
>   gcc-13/performance/1HDD/xfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240=
206.cgz/lkp-icl-2sp8/getdent/stress-ng/60s
>
> commit:
>   267574dee6 ("bcachefs: remove now spurious i_state initialization")
>   d042dae6ad ("lockref: speculatively spin waiting for the lock to be rel=
eased")
>
> 267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       2.64 =C4=85  5%     -38.8%       1.61 =C4=85  9%  iostat.cpu.user
>     259963 =C4=85 10%     -15.4%     219891 =C4=85  9%  meminfo.Active
>     259835 =C4=85 10%     -15.4%     219763 =C4=85  9%  meminfo.Active(an=
on)
>       0.96 =C4=85  4%      -0.6        0.38 =C4=85 15%  mpstat.cpu.all.so=
ft%
>       2.70 =C4=85  5%      -1.1        1.65 =C4=85  9%  mpstat.cpu.all.us=
r%
>     211.08 =C4=85  9%     -41.0%     124.64 =C4=85 31%  sched_debug.cfs_r=
q:/.load_avg.avg
>       3860 =C4=85 24%     -34.1%       2545 =C4=85  4%  sched_debug.cpu.a=
vg_idle.min
>   49162966           -57.6%   20842987 =C4=85 11%  numa-numastat.node0.lo=
cal_node
>   49203248           -57.6%   20885029 =C4=85 11%  numa-numastat.node0.nu=
ma_hit
>   39549538           -50.2%   19693291 =C4=85  9%  numa-numastat.node1.lo=
cal_node
>   39591591           -50.2%   19718716 =C4=85  8%  numa-numastat.node1.nu=
ma_hit
>   49261289           -57.6%   20866465 =C4=85 11%  numa-vmstat.node0.numa=
_hit
>   49221006           -57.7%   20824423 =C4=85 11%  numa-vmstat.node0.numa=
_local
>   39661116           -50.3%   19702525 =C4=85  9%  numa-vmstat.node1.numa=
_hit
>   39619062           -50.3%   19677100 =C4=85  9%  numa-vmstat.node1.numa=
_local
>      12372 =C4=85  3%     -45.1%       6789 =C4=85 12%  perf-c2c.DRAM.loc=
al
>      36077 =C4=85  2%     -45.0%      19825 =C4=85  9%  perf-c2c.DRAM.rem=
ote
>      32989 =C4=85  2%     -30.5%      22935 =C4=85 11%  perf-c2c.HITM.loc=
al
>      17205 =C4=85  2%     -46.6%       9182 =C4=85 10%  perf-c2c.HITM.rem=
ote
>      50194 =C4=85  2%     -36.0%      32118 =C4=85 10%  perf-c2c.HITM.tot=
al
>   88807242           -54.3%   40604534 =C4=85 10%  proc-vmstat.numa_hit
>   88724762           -54.3%   40537067 =C4=85 10%  proc-vmstat.numa_local
>     130416 =C4=85  7%     +21.3%     158188 =C4=85  3%  proc-vmstat.pgact=
ivate
>   92701259           -54.7%   41954988 =C4=85 11%  proc-vmstat.pgalloc_no=
rmal
>   80544858           -54.2%   36859393 =C4=85 10%  proc-vmstat.pgfault
>   92449287           -54.9%   41735344 =C4=85 11%  proc-vmstat.pgfree
>      11060           -58.7%       4569 =C4=85 22%  stress-ng.getdent.nano=
secs_per_getdents_call
>  1.135e+08           -54.6%   51568726 =C4=85 10%  stress-ng.getdent.ops
>    1891648           -54.6%     859477 =C4=85 10%  stress-ng.getdent.ops_=
per_sec
>   80355832           -54.5%   36564567 =C4=85 10%  stress-ng.time.minor_p=
age_faults
>       3626            +2.1%       3702        stress-ng.time.system_time
>      80.35           -54.4%      36.65 =C4=85 10%  stress-ng.time.user_ti=
me
>       2.88 =C4=85  2%     -21.6%       2.25 =C4=85  3%  perf-stat.i.MPKI
>  1.202e+10 =C4=85  5%     -35.3%  7.773e+09 =C4=85  7%  perf-stat.i.branc=
h-instructions
>   78049914 =C4=85  4%     -33.0%   52278904 =C4=85  9%  perf-stat.i.branc=
h-misses
>      44.35 =C4=85  3%      -4.4       39.94 =C4=85  4%  perf-stat.i.cache=
-miss-rate%
>  1.629e+08 =C4=85  5%     -52.0%   78236809 =C4=85 11%  perf-stat.i.cache=
-misses
>  3.527e+08 =C4=85  5%     -45.8%   1.91e+08 =C4=85  9%  perf-stat.i.cache=
-references
>       3.78 =C4=85  3%     +75.9%       6.64 =C4=85  3%  perf-stat.i.cpi
>     299.98 =C4=85  8%     -28.2%     215.47 =C4=85 15%  perf-stat.i.cpu-m=
igrations
>       1341 =C4=85  2%    +122.2%       2981 =C4=85  3%  perf-stat.i.cycle=
s-between-cache-misses
>  5.574e+10 =C4=85  5%     -39.1%  3.397e+10 =C4=85  8%  perf-stat.i.instr=
uctions
>       0.29 =C4=85 10%     -39.7%       0.18 =C4=85 16%  perf-stat.i.ipc
>      39.56 =C4=85  5%     -52.9%      18.63 =C4=85 12%  perf-stat.i.metri=
c.K/sec
>    1264058 =C4=85  5%     -53.0%     593585 =C4=85 13%  perf-stat.i.minor=
-faults
>    1264058 =C4=85  5%     -53.0%     593585 =C4=85 13%  perf-stat.i.page-=
faults
>       2.93           -21.4%       2.30 =C4=85  2%  perf-stat.overall.MPKI
>      46.18            -5.3       40.88        perf-stat.overall.cache-mis=
s-rate%
>       3.85           +69.7%       6.53 =C4=85  5%  perf-stat.overall.cpi
>       1313          +116.3%       2842 =C4=85  7%  perf-stat.overall.cycl=
es-between-cache-misses
>       0.26           -40.9%       0.15 =C4=85  5%  perf-stat.overall.ipc
>  1.184e+10 =C4=85  5%     -35.4%  7.645e+09 =C4=85  7%  perf-stat.ps.bran=
ch-instructions
>   76385602 =C4=85  4%     -33.2%   51045849 =C4=85  9%  perf-stat.ps.bran=
ch-misses
>  1.606e+08 =C4=85  5%     -52.0%   77029112 =C4=85 10%  perf-stat.ps.cach=
e-misses
>  3.478e+08 =C4=85  5%     -45.9%  1.882e+08 =C4=85  9%  perf-stat.ps.cach=
e-references
>     294.68 =C4=85  8%     -28.1%     211.78 =C4=85 15%  perf-stat.ps.cpu-=
migrations
>  5.487e+10 =C4=85  5%     -39.1%   3.34e+10 =C4=85  8%  perf-stat.ps.inst=
ructions
>    1246246 =C4=85  5%     -53.1%     584418 =C4=85 12%  perf-stat.ps.mino=
r-faults
>    1246246 =C4=85  5%     -53.1%     584418 =C4=85 12%  perf-stat.ps.page=
-faults
>  3.532e+12           -40.9%  2.088e+12 =C4=85  5%  perf-stat.total.instru=
ctions
>      65.80           -56.9        8.86 =C4=85 55%  perf-profile.calltrace=
.cycles-pp.syscall
>      64.94           -56.4        8.52 =C4=85 56%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>      64.88           -56.4        8.50 =C4=85 56%  perf-profile.calltrace=
.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      32.57           -28.3        4.27 =C4=85 57%  perf-profile.calltrace=
.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
syscall
>      32.08           -27.9        4.15 =C4=85 57%  perf-profile.calltrace=
.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.syscall
>      31.94           -27.8        4.14 =C4=85 57%  perf-profile.calltrace=
.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.syscall
>      31.65           -27.6        4.06 =C4=85 57%  perf-profile.calltrace=
.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_=
after_hwframe.syscall
>      14.11 =C4=85  5%     -13.0        1.12 =C4=85122%  perf-profile.call=
trace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents64.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
>      14.06 =C4=85  5%     -12.9        1.13 =C4=85122%  perf-profile.call=
trace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents.do_syscall_6=
4.entry_SYSCALL_64_after_hwframe
>      13.38 =C4=85  5%     -12.3        1.04 =C4=85124%  perf-profile.call=
trace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents=
64.do_syscall_64
>      13.34 =C4=85  5%     -12.3        1.05 =C4=85124%  perf-profile.call=
trace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents=
.do_syscall_64
>      12.89 =C4=85  5%     -12.0        0.92 =C4=85141%  perf-profile.call=
trace.cycles-pp.osq_lock.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys=
_getdents64
>      12.84 =C4=85  5%     -11.9        0.93 =C4=85141%  perf-profile.call=
trace.cycles-pp.osq_lock.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys=
_getdents
>       6.49 =C4=85  2%      -5.9        0.57 =C4=85117%  perf-profile.call=
trace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_sys=
call_64.entry_SYSCALL_64_after_hwframe
>       6.48 =C4=85  2%      -5.9        0.57 =C4=85117%  perf-profile.call=
trace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_s=
yscall_64.entry_SYSCALL_64_after_hwframe
>       6.43 =C4=85  2%      -5.9        0.56 =C4=85117%  perf-profile.call=
trace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys=
_getdents64.do_syscall_64
>       6.43 =C4=85  2%      -5.9        0.56 =C4=85117%  perf-profile.call=
trace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys=
_getdents.do_syscall_64
>       4.62 =C4=85  3%      -3.8        0.82 =C4=85 44%  perf-profile.call=
trace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_s=
ys_openat2
>       4.80 =C4=85  2%      -3.8        1.03 =C4=85 33%  perf-profile.call=
trace.cycles-pp.__close
>       4.54 =C4=85  2%      -3.6        0.93 =C4=85 36%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
>       4.52 =C4=85  2%      -3.6        0.92 =C4=85 36%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       4.45 =C4=85  2%      -3.6        0.90 =C4=85 36%  perf-profile.call=
trace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.__close
>       3.47 =C4=85  3%      -3.0        0.42 =C4=85108%  perf-profile.call=
trace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.__close
>       3.78 =C4=85  8%      -2.9        0.84 =C4=85 36%  perf-profile.call=
trace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do=
_sys_openat2
>       3.00 =C4=85  4%      -2.6        0.40 =C4=85108%  perf-profile.call=
trace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_o=
penat
>       3.00 =C4=85 10%      -2.6        0.42 =C4=85105%  perf-profile.call=
trace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_=
openat.do_filp_open
>       2.65 =C4=85  2%      -2.0        0.70 =C4=85 25%  perf-profile.call=
trace.cycles-pp.brk
>       2.57 =C4=85  2%      -1.9        0.66 =C4=85 26%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       2.58 =C4=85  2%      -1.9        0.66 =C4=85 26%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
>       2.54 =C4=85  2%      -1.9        0.65 =C4=85 26%  perf-profile.call=
trace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.b=
rk
>       2.04            -1.7        0.35 =C4=85104%  perf-profile.calltrace=
.cycles-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getden=
ts.do_syscall_64
>       2.04            -1.7        0.35 =C4=85104%  perf-profile.calltrace=
.cycles-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getden=
ts64.do_syscall_64
>       2.05 =C4=85  2%      -1.6        0.44 =C4=85 75%  perf-profile.call=
trace.cycles-pp.exc_page_fault.asm_exc_page_fault
>       2.04 =C4=85  2%      -1.6        0.43 =C4=85 75%  perf-profile.call=
trace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       2.13            -1.6        0.53 =C4=85 52%  perf-profile.calltrace=
.cycles-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_=
64.entry_SYSCALL_64_after_hwframe
>       2.28 =C4=85  2%      -1.6        0.68 =C4=85 23%  perf-profile.call=
trace.cycles-pp.asm_exc_page_fault
>       2.14            -1.5        0.62 =C4=85 24%  perf-profile.calltrace=
.cycles-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64=
.entry_SYSCALL_64_after_hwframe
>       0.00            +1.8        1.78 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast=
.walk_component
>       0.00            +1.8        1.78 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_=
path_walk
>       0.00            +1.8        1.78 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_ope=
nat
>       4.32 =C4=85  3%      +2.0        6.30 =C4=85  3%  perf-profile.call=
trace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_s=
ys_openat2
>       3.04 =C4=85  5%      +3.0        6.06 =C4=85  3%  perf-profile.call=
trace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_fi=
lp_open
>       0.00            +3.2        3.20 =C4=85 13%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_=
dead.__legitimize_path.try_to_unlazy_next
>       0.00            +3.2        3.23 =C4=85 13%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unl=
azy_next.lookup_fast
>       0.00            +3.7        3.69 =C4=85  9%  perf-profile.calltrace=
.cycles-pp.__legitimize_path.try_to_unlazy_next.lookup_fast.walk_component.=
link_path_walk
>       0.00            +3.7        3.69 =C4=85  9%  perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup=
_fast.walk_component
>       0.00            +3.7        3.70 =C4=85  9%  perf-profile.calltrace=
.cycles-pp.try_to_unlazy_next.lookup_fast.walk_component.link_path_walk.pat=
h_openat
>       0.69 =C4=85  4%      +5.3        6.01 =C4=85  8%  perf-profile.call=
trace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_=
open
>       6.20 =C4=85  2%      +9.8       16.04 =C4=85  4%  perf-profile.call=
trace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2._=
_x64_sys_openat
>       1.29 =C4=85  3%     +13.7       15.03 =C4=85  6%  perf-profile.call=
trace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_s=
ys_openat2
>       0.00           +13.8       13.76 =C4=85  6%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unl=
azy.lookup_fast
>       0.00           +14.3       14.31 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast=
.open_last_lookups
>       0.00           +14.3       14.32 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.pa=
th_openat
>       0.00           +14.3       14.32 =C4=85  6%  perf-profile.calltrace=
.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_=
open
>       0.00           +18.0       18.04 =C4=85 11%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unl=
azy.link_path_walk
>       9.60 =C4=85  4%     +19.0       28.56 =C4=85  6%  perf-profile.call=
trace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x6=
4_sys_openat
>       0.28 =C4=85100%     +20.8       21.12 =C4=85 10%  perf-profile.call=
trace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.=
do_filp_open
>       0.28 =C4=85100%     +20.8       21.13 =C4=85 10%  perf-profile.call=
trace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sy=
s_openat2
>       0.00           +21.1       21.11 =C4=85 10%  perf-profile.calltrace=
.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_w=
alk.path_openat
>       0.00           +31.5       31.52 =C4=85  8%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_=
dead.__legitimize_path.try_to_unlazy
>       0.00           +34.7       34.71 =C4=85  8%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_w=
alk.path_openat
>       0.00           +35.0       35.01 =C4=85  8%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
>       0.88 =C4=85  9%     +40.2       41.12 =C4=85  8%  perf-profile.call=
trace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x6=
4_sys_openat
>       0.84 =C4=85  9%     +40.3       41.10 =C4=85  8%  perf-profile.call=
trace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
>      22.55 =C4=85  2%     +65.0       87.59 =C4=85  6%  perf-profile.call=
trace.cycles-pp.open64
>      22.25 =C4=85  2%     +65.2       87.48 =C4=85  6%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>      22.23 =C4=85  2%     +65.2       87.47 =C4=85  6%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>      22.15 =C4=85  2%     +65.3       87.43 =C4=85  6%  perf-profile.call=
trace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.open64
>      22.12 =C4=85  2%     +65.3       87.42 =C4=85  6%  perf-profile.call=
trace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL=
_64_after_hwframe.open64
>      21.24 =C4=85  2%     +65.5       86.76 =C4=85  6%  perf-profile.call=
trace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
>      21.18 =C4=85  2%     +65.6       86.74 =C4=85  6%  perf-profile.call=
trace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do=
_syscall_64
>      65.96           -57.0        8.93 =C4=85 54%  perf-profile.children.=
cycles-pp.syscall
>      63.61           -55.4        8.21 =C4=85 57%  perf-profile.children.=
cycles-pp.iterate_dir
>      32.58           -28.3        4.27 =C4=85 57%  perf-profile.children.=
cycles-pp.__x64_sys_getdents
>      32.09           -27.9        4.15 =C4=85 57%  perf-profile.children.=
cycles-pp.__x64_sys_getdents64
>      28.19 =C4=85  5%     -25.8        2.34 =C4=85114%  perf-profile.chil=
dren.cycles-pp.eventfs_iterate
>      26.72 =C4=85  5%     -24.6        2.08 =C4=85124%  perf-profile.chil=
dren.cycles-pp.__mutex_lock
>      25.74 =C4=85  5%     -23.7        2.00 =C4=85125%  perf-profile.chil=
dren.cycles-pp.osq_lock
>      20.36 =C4=85  2%     -18.0        2.37 =C4=85 66%  perf-profile.chil=
dren.cycles-pp.proc_readdir_de
>      12.96 =C4=85  2%     -11.4        1.60 =C4=85 61%  perf-profile.chil=
dren.cycles-pp.proc_tgid_net_readdir
>      10.60 =C4=85  3%      -9.6        1.02 =C4=85 80%  perf-profile.chil=
dren.cycles-pp._raw_read_lock
>       5.88 =C4=85  6%      -4.9        1.02 =C4=85 48%  perf-profile.chil=
dren.cycles-pp.kernfs_fop_readdir
>       5.85 =C4=85  7%      -4.7        1.16 =C4=85 42%  perf-profile.chil=
dren.cycles-pp.down_read
>       5.15 =C4=85  5%      -4.5        0.68 =C4=85 67%  perf-profile.chil=
dren.cycles-pp.up_read
>       5.68            -4.0        1.68 =C4=85 24%  perf-profile.children.=
cycles-pp.proc_fill_cache
>       4.62 =C4=85  3%      -3.8        0.82 =C4=85 44%  perf-profile.chil=
dren.cycles-pp.lookup_open
>       4.85 =C4=85  2%      -3.8        1.05 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.__close
>       4.42 =C4=85  4%      -3.7        0.68 =C4=85 52%  perf-profile.chil=
dren.cycles-pp.proc_lookup_de
>       4.32 =C4=85  3%      -3.6        0.68 =C4=85 51%  perf-profile.chil=
dren.cycles-pp.proc_tgid_net_lookup
>       4.46 =C4=85  2%      -3.6        0.90 =C4=85 36%  perf-profile.chil=
dren.cycles-pp.__x64_sys_close
>       4.43 =C4=85  8%      -3.5        0.96 =C4=85 37%  perf-profile.chil=
dren.cycles-pp.inode_permission
>       4.28            -3.0        1.23 =C4=85 25%  perf-profile.children.=
cycles-pp.proc_pident_readdir
>       3.48 =C4=85  3%      -2.8        0.66 =C4=85 39%  perf-profile.chil=
dren.cycles-pp.__fput
>       3.98 =C4=85  2%      -2.8        1.18 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.__d_lookup
>       3.44 =C4=85 10%      -2.7        0.70 =C4=85 41%  perf-profile.chil=
dren.cycles-pp.kernfs_iop_permission
>       3.01 =C4=85  4%      -2.4        0.60 =C4=85 40%  perf-profile.chil=
dren.cycles-pp.do_open
>       3.09            -2.1        0.95 =C4=85 23%  perf-profile.children.=
cycles-pp.d_hash_and_lookup
>       2.46 =C4=85  7%      -2.1        0.33 =C4=85 64%  perf-profile.chil=
dren.cycles-pp.kernfs_dop_revalidate
>       2.66 =C4=85  2%      -2.0        0.70 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.brk
>       2.55 =C4=85  2%      -1.9        0.65 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.__do_sys_brk
>       2.18 =C4=85  4%      -1.8        0.40 =C4=85 40%  perf-profile.chil=
dren.cycles-pp.__dentry_kill
>       2.18 =C4=85  6%      -1.8        0.41 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.proc_get_inode
>       2.47 =C4=85  2%      -1.7        0.74 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.asm_exc_page_fault
>       2.12 =C4=85  6%      -1.7        0.40 =C4=85 46%  perf-profile.chil=
dren.cycles-pp.new_inode
>       1.94 =C4=85  4%      -1.6        0.37 =C4=85 44%  perf-profile.chil=
dren.cycles-pp.do_dentry_open
>       2.19 =C4=85  2%      -1.6        0.63 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.exc_page_fault
>       2.18 =C4=85  2%      -1.6        0.62 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.do_user_addr_fault
>       1.98 =C4=85  2%      -1.5        0.48 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.do_vmi_align_munmap
>       1.49 =C4=85  6%      -1.3        0.21 =C4=85 58%  perf-profile.chil=
dren.cycles-pp.evict
>       1.76 =C4=85  2%      -1.2        0.52 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.handle_mm_fault
>       1.56 =C4=85  3%      -1.2        0.35 =C4=85 31%  perf-profile.chil=
dren.cycles-pp.unmap_region
>       1.63 =C4=85  2%      -1.2        0.47 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.__handle_mm_fault
>       1.50 =C4=85  2%      -1.1        0.42 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.do_anonymous_page
>       1.16 =C4=85  7%      -1.0        0.20 =C4=85 53%  perf-profile.chil=
dren.cycles-pp.security_file_open
>       1.16 =C4=85  7%      -1.0        0.20 =C4=85 57%  perf-profile.chil=
dren.cycles-pp.apparmor_file_open
>       1.21 =C4=85  3%      -1.0        0.25 =C4=85 35%  perf-profile.chil=
dren.cycles-pp.__lookup_slow
>       1.26 =C4=85  3%      -0.9        0.35 =C4=85 28%  perf-profile.chil=
dren.cycles-pp.alloc_empty_file
>       1.20            -0.8        0.42 =C4=85 20%  perf-profile.children.=
cycles-pp.handle_softirqs
>       1.20            -0.8        0.41 =C4=85 21%  perf-profile.children.=
cycles-pp.rcu_core
>       1.19            -0.8        0.41 =C4=85 21%  perf-profile.children.=
cycles-pp.rcu_do_batch
>       0.85 =C4=85  2%      -0.8        0.07 =C4=85112%  perf-profile.chil=
dren.cycles-pp.mutex_unlock
>       0.86 =C4=85  2%      -0.7        0.12 =C4=85 55%  perf-profile.chil=
dren.cycles-pp.mutex_lock
>       0.96 =C4=85  5%      -0.7        0.23 =C4=85 34%  perf-profile.chil=
dren.cycles-pp.init_file
>       1.07            -0.7        0.36 =C4=85 20%  perf-profile.children.=
cycles-pp.kmem_cache_free
>       0.90 =C4=85  3%      -0.6        0.28 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.step_into
>       0.83 =C4=85  6%      -0.6        0.21 =C4=85 34%  perf-profile.chil=
dren.cycles-pp.security_file_alloc
>       0.75 =C4=85  6%      -0.6        0.17 =C4=85 38%  perf-profile.chil=
dren.cycles-pp.apparmor_file_alloc_security
>       0.85 =C4=85  2%      -0.6        0.28 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.proc_map_files_readdir
>       1.12 =C4=85  2%      -0.6        0.55 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.asm_sysvec_apic_timer_interrupt
>       1.10 =C4=85  2%      -0.6        0.54 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.sysvec_apic_timer_interrupt
>       0.68 =C4=85  2%      -0.6        0.12 =C4=85 51%  perf-profile.chil=
dren.cycles-pp.pde_put
>       0.83 =C4=85  3%      -0.6        0.27 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.irq_exit_rcu
>       0.70 =C4=85  7%      -0.6        0.14 =C4=85 41%  perf-profile.chil=
dren.cycles-pp.may_open
>       0.79 =C4=85  3%      -0.5        0.26 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.alloc_anon_folio
>       0.72 =C4=85  2%      -0.5        0.21 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.proc_ns_dir_readdir
>       0.71 =C4=85  2%      -0.5        0.21 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.proc_readfd_common
>       0.65 =C4=85  2%      -0.5        0.15 =C4=85 32%  perf-profile.chil=
dren.cycles-pp.tlb_finish_mmu
>       0.62 =C4=85  3%      -0.5        0.13 =C4=85 35%  perf-profile.chil=
dren.cycles-pp.folios_put_refs
>       0.65 =C4=85  9%      -0.5        0.16 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.security_file_permission
>       0.63 =C4=85  9%      -0.5        0.15 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.apparmor_file_permission
>       0.60            -0.5        0.12 =C4=85 36%  perf-profile.children.=
cycles-pp.__fdget_pos
>       0.58 =C4=85  2%      -0.5        0.13 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.__tlb_batch_free_encoded_pages
>       0.58 =C4=85  3%      -0.5        0.13 =C4=85 34%  perf-profile.chil=
dren.cycles-pp.free_pages_and_swap_cache
>       0.72            -0.4        0.28 =C4=85 16%  perf-profile.children.=
cycles-pp.filldir
>       0.52 =C4=85  2%      -0.4        0.08 =C4=85 49%  perf-profile.chil=
dren.cycles-pp.d_splice_alias
>       0.70 =C4=85  2%      -0.4        0.27 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.filldir64
>       0.71 =C4=85  2%      -0.4        0.29 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.clear_bhb_loop
>       0.57 =C4=85  5%      -0.4        0.15 =C4=85 31%  perf-profile.chil=
dren.cycles-pp.security_file_free
>       0.59            -0.4        0.17 =C4=85 26%  perf-profile.children.=
cycles-pp.__slab_free
>       0.56 =C4=85  5%      -0.4        0.15 =C4=85 31%  perf-profile.chil=
dren.cycles-pp.apparmor_file_free_security
>       0.68            -0.4        0.27 =C4=85 16%  perf-profile.children.=
cycles-pp.kmem_cache_alloc_noprof
>       0.66 =C4=85  2%      -0.4        0.25 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.alloc_inode
>       0.48 =C4=85  2%      -0.4        0.09 =C4=85 36%  perf-profile.chil=
dren.cycles-pp.folio_batch_move_lru
>       0.48            -0.4        0.10 =C4=85 38%  perf-profile.children.=
cycles-pp.down_read_killable
>       0.47 =C4=85  3%      -0.4        0.09 =C4=85 40%  perf-profile.chil=
dren.cycles-pp.fsnotify_grab_connector
>       0.46 =C4=85  3%      -0.4        0.08 =C4=85 35%  perf-profile.chil=
dren.cycles-pp.lru_add_drain
>       0.46 =C4=85  3%      -0.4        0.08 =C4=85 35%  perf-profile.chil=
dren.cycles-pp.lru_add_drain_cpu
>       0.48 =C4=85  3%      -0.4        0.12 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.filp_flush
>       0.44 =C4=85  2%      -0.4        0.08 =C4=85 46%  perf-profile.chil=
dren.cycles-pp.kernfs_dir_pos
>       0.50 =C4=85  2%      -0.3        0.16 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.vma_alloc_folio_noprof
>       0.49 =C4=85  3%      -0.3        0.16 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.alloc_pages_mpol_noprof
>       0.58            -0.3        0.25 =C4=85 15%  perf-profile.children.=
cycles-pp.d_alloc_parallel
>       0.41 =C4=85  3%      -0.3        0.09 =C4=85 32%  perf-profile.chil=
dren.cycles-pp.dnotify_flush
>       0.46 =C4=85  3%      -0.3        0.15 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.__alloc_pages_noprof
>       0.48 =C4=85  3%      -0.3        0.16 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc_lru_noprof
>       0.39 =C4=85  3%      -0.3        0.08 =C4=85 36%  perf-profile.chil=
dren.cycles-pp.fsnotify_find_mark
>       0.39 =C4=85  2%      -0.3        0.10 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.unmap_vmas
>       0.38 =C4=85  2%      -0.3        0.10 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.unmap_page_range
>       0.38 =C4=85  2%      -0.3        0.10 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.zap_pmd_range
>       0.40 =C4=85  3%      -0.3        0.12 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.do_brk_flags
>       0.37 =C4=85  2%      -0.3        0.10 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.zap_pte_range
>       0.38 =C4=85  2%      -0.3        0.12 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.get_page_from_freelist
>       0.43            -0.3        0.17 =C4=85 15%  perf-profile.children.=
cycles-pp.__memcg_slab_post_alloc_hook
>       0.41 =C4=85  6%      -0.2        0.16 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.kthread
>       0.41 =C4=85  6%      -0.2        0.16 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.ret_from_fork
>       0.41 =C4=85  6%      -0.2        0.16 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.ret_from_fork_asm
>       0.38 =C4=85  7%      -0.2        0.14 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.run_ksoftirqd
>       0.42 =C4=85  2%      -0.2        0.19 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.d_alloc
>       0.38 =C4=85  7%      -0.2        0.15 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.smpboot_thread_fn
>       0.30 =C4=85  2%      -0.2        0.07 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.zap_present_ptes
>       0.38 =C4=85  2%      -0.2        0.15 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.__cond_resched
>       0.30 =C4=85  3%      -0.2        0.08 =C4=85 31%  perf-profile.chil=
dren.cycles-pp.inode_wait_for_writeback
>       0.37 =C4=85  2%      -0.2        0.14 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64
>       0.28 =C4=85  2%      -0.2        0.06 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.__call_rcu_common
>       0.30 =C4=85  5%      -0.2        0.10 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.proc_alloc_inode
>       0.35 =C4=85  4%      -0.2        0.15 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.inode_init_always
>       0.26 =C4=85  8%      -0.2        0.05 =C4=85 76%  perf-profile.chil=
dren.cycles-pp.___slab_alloc
>       0.28 =C4=85  2%      -0.2        0.09 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.__d_lookup_rcu
>       0.27            -0.2        0.08 =C4=85 20%  perf-profile.children.=
cycles-pp.__split_vma
>       0.24 =C4=85  2%      -0.2        0.06 =C4=85 27%  perf-profile.chil=
dren.cycles-pp.lockref_get
>       0.31 =C4=85  3%      -0.2        0.13 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.getname_flags
>       0.23 =C4=85  7%      -0.2        0.06 =C4=85 54%  perf-profile.chil=
dren.cycles-pp.security_file_post_open
>       0.26 =C4=85  4%      -0.2        0.09 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.__mem_cgroup_charge
>       0.37 =C4=85  2%      -0.2        0.20 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.rb_next
>       0.22 =C4=85  7%      -0.2        0.05 =C4=85 51%  perf-profile.chil=
dren.cycles-pp.ima_file_check
>       0.28 =C4=85  2%      -0.2        0.12 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.__memcg_slab_free_hook
>       0.26 =C4=85  3%      -0.2        0.10 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.22 =C4=85  3%      -0.1        0.07 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.pid_delete_dentry
>       0.18 =C4=85  2%      -0.1        0.04 =C4=85 75%  perf-profile.chil=
dren.cycles-pp.proc_free_inode
>       0.18 =C4=85  2%      -0.1        0.04 =C4=85 72%  perf-profile.chil=
dren.cycles-pp.task_lookup_next_fdget_rcu
>       0.22 =C4=85  3%      -0.1        0.09 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.sync_regs
>       0.17 =C4=85  2%      -0.1        0.04 =C4=85 73%  perf-profile.chil=
dren.cycles-pp.path_init
>       0.21 =C4=85  2%      -0.1        0.08 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.__d_alloc
>       0.22 =C4=85  5%      -0.1        0.09 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.strncpy_from_user
>       0.20 =C4=85  3%      -0.1        0.08 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.verify_dirent_name
>       0.20 =C4=85  2%      -0.1        0.09 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.native_irq_return_iret
>       0.19 =C4=85  3%      -0.1        0.08 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.mod_objcg_state
>       0.19 =C4=85  5%      -0.1        0.08 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.pid_revalidate
>       0.18 =C4=85  4%      -0.1        0.07 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.stress_getdents_dir
>       0.18 =C4=85  2%      -0.1        0.07 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.stress_getdents64_dir
>       0.17 =C4=85  4%      -0.1        0.06 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.mas_wr_store_entry
>       0.15 =C4=85  3%      -0.1        0.05 =C4=85 47%  perf-profile.chil=
dren.cycles-pp.perf_event_mmap
>       0.17 =C4=85  2%      -0.1        0.07 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.strlcat
>       0.18 =C4=85  4%      -0.1        0.07 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.security_inode_alloc
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.snprintf
>       0.14 =C4=85  3%      -0.1        0.05 =C4=85 47%  perf-profile.chil=
dren.cycles-pp.perf_event_mmap_event
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.rcu_all_qs
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.vsnprintf
>       0.17 =C4=85  2%      -0.1        0.08 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.rcu_cblist_dequeue
>       0.15 =C4=85  3%      -0.1        0.06 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode
>       0.16 =C4=85  3%      -0.1        0.07 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.memchr
>       0.15 =C4=85  4%      -0.1        0.06 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.__lruvec_stat_mod_folio
>       0.15 =C4=85  3%      -0.1        0.06 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.clear_page_erms
>       0.14 =C4=85  3%      -0.1        0.05 =C4=85 47%  perf-profile.chil=
dren.cycles-pp.__perf_sw_event
>       0.14 =C4=85  3%      -0.1        0.06 =C4=85 19%  perf-profile.chil=
dren.cycles-pp.__mod_memcg_lruvec_state
>       0.16 =C4=85  5%      -0.1        0.08 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.generic_permission
>       0.12 =C4=85  4%      -0.1        0.05 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__check_object_size
>       0.00            +0.1        0.06 =C4=85  8%  perf-profile.children.=
cycles-pp.__do_sys_newfstatat
>       0.00            +0.1        0.06 =C4=85  8%  perf-profile.children.=
cycles-pp.filename_lookup
>       0.00            +0.1        0.06 =C4=85  8%  perf-profile.children.=
cycles-pp.path_lookupat
>       0.00            +0.1        0.06 =C4=85  8%  perf-profile.children.=
cycles-pp.vfs_fstatat
>       0.00            +0.1        0.06 =C4=85  8%  perf-profile.children.=
cycles-pp.vfs_statx
>       0.18 =C4=85  3%      +0.2        0.42 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.putname
>       4.34 =C4=85  2%      +2.1        6.47 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.walk_component
>      94.42            +3.6       98.01        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      94.33            +3.6       97.98        perf-profile.children.cycle=
s-pp.do_syscall_64
>       0.09 =C4=85 11%      +4.1        4.16 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.try_to_unlazy_next
>       2.07 =C4=85  2%      +4.2        6.25 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.lockref_put_return
>       6.21 =C4=85  2%      +9.8       16.05 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.open_last_lookups
>       4.35 =C4=85  4%     +16.9       21.22 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.lookup_fast
>       9.63 =C4=85  4%     +19.1       28.76 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.link_path_walk
>       1.03 =C4=85  8%     +36.3       37.38 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.try_to_unlazy
>       5.34 =C4=85  2%     +36.7       42.07 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.dput
>       0.89 =C4=85  9%     +40.4       41.25 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.terminate_walk
>       1.06 =C4=85  9%     +40.5       41.52 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__legitimize_path
>       0.83 =C4=85 12%     +40.7       41.48 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.lockref_get_not_dead
>       7.22 =C4=85  2%     +64.5       71.72 =C4=85  8%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock
>      22.60 =C4=85  2%     +65.0       87.62 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.open64
>      22.17 =C4=85  2%     +65.5       87.72 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__x64_sys_openat
>      22.15 =C4=85  2%     +65.6       87.71 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.do_sys_openat2
>      21.26 =C4=85  2%     +65.8       87.05 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.do_filp_open
>      21.20 =C4=85  2%     +65.8       87.03 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.path_openat
>       2.92 =C4=85  5%     +67.4       70.29 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.native_queued_spin_lock_slowpath
>      25.58 =C4=85  5%     -23.6        1.99 =C4=85125%  perf-profile.self=
.cycles-pp.osq_lock
>      10.46 =C4=85  3%      -9.5        1.00 =C4=85 80%  perf-profile.self=
.cycles-pp._raw_read_lock
>       9.26 =C4=85  2%      -8.2        1.03 =C4=85 68%  perf-profile.self=
.cycles-pp.proc_readdir_de
>       5.77 =C4=85  7%      -4.6        1.13 =C4=85 43%  perf-profile.self=
.cycles-pp.down_read
>       5.11 =C4=85  6%      -4.4        0.67 =C4=85 68%  perf-profile.self=
.cycles-pp.up_read
>       4.42            -3.0        1.43 =C4=85 18%  perf-profile.self.cycl=
es-pp._raw_spin_lock
>       2.05 =C4=85  2%      -1.3        0.78 =C4=85 20%  perf-profile.self=
.cycles-pp.__d_lookup
>       1.11 =C4=85  2%      -1.0        0.12 =C4=85 65%  perf-profile.self=
.cycles-pp.proc_lookup_de
>       1.14 =C4=85  7%      -0.9        0.19 =C4=85 56%  perf-profile.self=
.cycles-pp.apparmor_file_open
>       0.84 =C4=85  2%      -0.8        0.07 =C4=85115%  perf-profile.self=
.cycles-pp.mutex_unlock
>       0.80 =C4=85  2%      -0.7        0.10 =C4=85 60%  perf-profile.self=
.cycles-pp.mutex_lock
>       0.73 =C4=85  6%      -0.6        0.17 =C4=85 38%  perf-profile.self=
.cycles-pp.apparmor_file_alloc_security
>       0.66 =C4=85  2%      -0.5        0.12 =C4=85 48%  perf-profile.self=
.cycles-pp.pde_put
>       0.76 =C4=85  5%      -0.5        0.31 =C4=85 19%  perf-profile.self=
.cycles-pp.proc_fill_cache
>       0.59 =C4=85 10%      -0.4        0.14 =C4=85 35%  perf-profile.self=
.cycles-pp.apparmor_file_permission
>       0.70 =C4=85  2%      -0.4        0.29 =C4=85 15%  perf-profile.self=
.cycles-pp.clear_bhb_loop
>       0.58            -0.4        0.17 =C4=85 25%  perf-profile.self.cycl=
es-pp.__slab_free
>       0.55 =C4=85  5%      -0.4        0.15 =C4=85 31%  perf-profile.self=
.cycles-pp.apparmor_file_free_security
>       0.47            -0.4        0.08 =C4=85 38%  perf-profile.self.cycl=
es-pp.do_dentry_open
>       0.45            -0.4        0.08 =C4=85 41%  perf-profile.self.cycl=
es-pp.down_read_killable
>       0.39 =C4=85  2%      -0.3        0.06 =C4=85 60%  perf-profile.self=
.cycles-pp.__fput
>       0.53            -0.3        0.21 =C4=85 16%  perf-profile.self.cycl=
es-pp.filldir
>       0.52 =C4=85  2%      -0.3        0.21 =C4=85 16%  perf-profile.self=
.cycles-pp.filldir64
>       0.38 =C4=85  4%      -0.3        0.12 =C4=85 22%  perf-profile.self=
.cycles-pp.kernfs_fop_readdir
>       0.37 =C4=85  3%      -0.2        0.14 =C4=85 17%  perf-profile.self=
.cycles-pp.inode_permission
>       0.27 =C4=85  2%      -0.2        0.09 =C4=85 20%  perf-profile.self=
.cycles-pp.__d_lookup_rcu
>       0.29 =C4=85  2%      -0.2        0.12 =C4=85 16%  perf-profile.self=
.cycles-pp.kmem_cache_alloc_noprof
>       0.35 =C4=85  3%      -0.2        0.20 =C4=85 15%  perf-profile.self=
.cycles-pp.rb_next
>       0.25 =C4=85  2%      -0.2        0.10 =C4=85 16%  perf-profile.self=
.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.21 =C4=85  3%      -0.1        0.07 =C4=85 24%  perf-profile.self=
.cycles-pp.pid_delete_dentry
>       0.22 =C4=85  2%      -0.1        0.08 =C4=85 16%  perf-profile.self=
.cycles-pp.syscall
>       0.22 =C4=85  3%      -0.1        0.09 =C4=85 15%  perf-profile.self=
.cycles-pp.sync_regs
>       0.21 =C4=85  3%      -0.1        0.08 =C4=85 17%  perf-profile.self=
.cycles-pp.__memcg_slab_post_alloc_hook
>       0.20            -0.1        0.08 =C4=85 14%  perf-profile.self.cycl=
es-pp.__cond_resched
>       0.20 =C4=85  2%      -0.1        0.09 =C4=85 15%  perf-profile.self=
.cycles-pp.native_irq_return_iret
>       0.19 =C4=85  3%      -0.1        0.08 =C4=85 16%  perf-profile.self=
.cycles-pp.link_path_walk
>       0.17 =C4=85  2%      -0.1        0.07 =C4=85 17%  perf-profile.self=
.cycles-pp.__fdget_pos
>       0.14 =C4=85  4%      -0.1        0.04 =C4=85 72%  perf-profile.self=
.cycles-pp.do_syscall_64
>       0.17 =C4=85  5%      -0.1        0.07 =C4=85 16%  perf-profile.self=
.cycles-pp.kmem_cache_free
>       0.13 =C4=85  5%      -0.1        0.03 =C4=85100%  perf-profile.self=
.cycles-pp.step_into
>       0.16 =C4=85  4%      -0.1        0.06 =C4=85 14%  perf-profile.self=
.cycles-pp.stress_getdents_dir
>       0.16 =C4=85  2%      -0.1        0.06 =C4=85 11%  perf-profile.self=
.cycles-pp.strlcat
>       0.16 =C4=85  2%      -0.1        0.06 =C4=85 14%  perf-profile.self=
.cycles-pp.stress_getdents64_dir
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85 14%  perf-profile.self=
.cycles-pp.mod_objcg_state
>       0.17 =C4=85  4%      -0.1        0.08 =C4=85 16%  perf-profile.self=
.cycles-pp.rcu_cblist_dequeue
>       0.12 =C4=85  4%      -0.1        0.03 =C4=85100%  perf-profile.self=
.cycles-pp.rcu_all_qs
>       0.15 =C4=85  3%      -0.1        0.06 =C4=85 19%  perf-profile.self=
.cycles-pp.memchr
>       0.12 =C4=85  4%      -0.1        0.03 =C4=85102%  perf-profile.self=
.cycles-pp.inode_init_always
>       0.14 =C4=85  3%      -0.1        0.06 =C4=85 17%  perf-profile.self=
.cycles-pp.clear_page_erms
>       0.09 =C4=85  7%      -0.1        0.02 =C4=85 99%  perf-profile.self=
.cycles-pp.pid_revalidate
>       0.13 =C4=85  5%      -0.1        0.06 =C4=85 14%  perf-profile.self=
.cycles-pp.generic_permission
>       0.11 =C4=85  3%      +0.0        0.12 =C4=85  3%  perf-profile.self=
.cycles-pp.dput
>       0.18 =C4=85  2%      +0.2        0.42 =C4=85  5%  perf-profile.self=
.cycles-pp.putname
>       2.04 =C4=85  2%      +4.2        6.21 =C4=85  7%  perf-profile.self=
.cycles-pp.lockref_put_return
>       0.66 =C4=85  4%      +5.4        6.01 =C4=85  8%  perf-profile.self=
.cycles-pp.lockref_get_not_dead
>       2.81 =C4=85  5%     +67.1       69.92 =C4=85  8%  perf-profile.self=
.cycles-pp.native_queued_spin_lock_slowpath
>
>
>
> *************************************************************************=
**************************
> lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/te=
st/testcase/testtime:
>   gcc-13/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-202=
40206.cgz/lkp-icl-2sp8/handle/stress-ng/60s
>
> commit:
>   267574dee6 ("bcachefs: remove now spurious i_state initialization")
>   d042dae6ad ("lockref: speculatively spin waiting for the lock to be rel=
eased")
>
> 267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       1.08 =C4=85  4%     -10.1%       0.97 =C4=85  2%  iostat.cpu.user
>       1.10 =C4=85  4%      -0.1        0.99 =C4=85  2%  mpstat.cpu.all.us=
r%
>     286411 =C4=85  7%     -12.1%     251734 =C4=85  4%  numa-numastat.nod=
e1.local_node
>     285093 =C4=85  6%     -12.0%     250827 =C4=85  4%  numa-vmstat.node1=
.numa_local
>       2980 =C4=85  7%     -19.8%       2391 =C4=85  4%  vmstat.system.cs
>     162616            -2.6%     158340        vmstat.system.in
>      84179            -3.0%      81690        proc-vmstat.nr_shmem
>     486339            -1.7%     478110        proc-vmstat.numa_hit
>     420032            -2.0%     411796        proc-vmstat.numa_local
>   10880229 =C4=85  2%     -60.2%    4332475 =C4=85 13%  stress-ng.handle.=
ops
>     181335 =C4=85  2%     -60.2%      72206 =C4=85 13%  stress-ng.handle.=
ops_per_sec
>      75993 =C4=85  9%     -28.7%      54148 =C4=85  9%  stress-ng.time.in=
voluntary_context_switches
>     455.17 =C4=85  9%     +61.9%     737.00 =C4=85 10%  perf-c2c.DRAM.loc=
al
>      31509 =C4=85  2%     -36.9%      19892 =C4=85  2%  perf-c2c.DRAM.rem=
ote
>      39333 =C4=85  2%     -24.9%      29523 =C4=85  2%  perf-c2c.HITM.loc=
al
>      25890 =C4=85  2%     -45.5%      14112 =C4=85  3%  perf-c2c.HITM.rem=
ote
>      65223 =C4=85  2%     -33.1%      43635 =C4=85  2%  perf-c2c.HITM.tot=
al
>       5043 =C4=85 31%     -57.9%       2123 =C4=85 25%  sched_debug.cfs_r=
q:/.load_avg.max
>       1423 =C4=85 38%     -51.9%     683.87 =C4=85 30%  sched_debug.cfs_r=
q:/.load_avg.stddev
>      45.04 =C4=85 17%     -47.5%      23.63 =C4=85 41%  sched_debug.cfs_r=
q:/.removed.load_avg.avg
>     141.61 =C4=85  8%     -28.5%     101.19 =C4=85 22%  sched_debug.cfs_r=
q:/.removed.load_avg.stddev
>       1399 =C4=85  8%     -15.2%       1186 =C4=85  4%  sched_debug.cfs_r=
q:/.runnable_avg.max
>       1269 =C4=85  4%     -12.2%       1114 =C4=85  4%  sched_debug.cfs_r=
q:/.util_avg.max
>       1.30           -23.4%       1.00 =C4=85  2%  perf-stat.i.MPKI
>  5.757e+09           -17.7%  4.736e+09        perf-stat.i.branch-instruct=
ions
>       0.65 =C4=85  3%      +0.1        0.70        perf-stat.i.branch-mis=
s-rate%
>   38695005 =C4=85  3%      -7.7%   35708627        perf-stat.i.branch-mis=
ses
>      38.60            -9.7       28.94        perf-stat.i.cache-miss-rate=
%
>   31607382           -38.6%   19404517        perf-stat.i.cache-misses
>   82723252           -17.5%   68236401        perf-stat.i.cache-reference=
s
>       2935 =C4=85  7%     -20.5%       2332 =C4=85  5%  perf-stat.i.conte=
xt-switches
>       9.32           +25.5%      11.70        perf-stat.i.cpi
>       7126           +64.0%      11684        perf-stat.i.cycles-between-=
cache-misses
>  2.442e+10           -19.3%   1.97e+10        perf-stat.i.instructions
>       0.12           -19.0%       0.10 =C4=85  2%  perf-stat.i.ipc
>       1.30           -23.8%       0.99 =C4=85  2%  perf-stat.overall.MPKI
>       0.66 =C4=85  3%      +0.1        0.74        perf-stat.overall.bran=
ch-miss-rate%
>      38.06            -9.8       28.29        perf-stat.overall.cache-mis=
s-rate%
>       9.27           +24.2%      11.51        perf-stat.overall.cpi
>       7157           +63.0%      11670        perf-stat.overall.cycles-be=
tween-cache-misses
>       0.11           -19.4%       0.09        perf-stat.overall.ipc
>  5.645e+09           -17.7%  4.643e+09        perf-stat.ps.branch-instruc=
tions
>   37338101 =C4=85  3%      -7.7%   34453073        perf-stat.ps.branch-mi=
sses
>   31016005           -38.6%   19050425        perf-stat.ps.cache-misses
>   81505741           -17.4%   67356950        perf-stat.ps.cache-referenc=
es
>       2878 =C4=85  8%     -20.9%       2275 =C4=85  5%  perf-stat.ps.cont=
ext-switches
>  2.394e+10           -19.3%  1.931e+10        perf-stat.ps.instructions
>  1.469e+12           -19.6%  1.182e+12        perf-stat.total.instruction=
s
>      70.47           -11.9       58.54        perf-profile.calltrace.cycl=
es-pp.handle_to_path.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.open_by_handle_at
>      67.22           -11.7       55.47        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock.ilookup5_nowait.ilookup5.shmem_fh_to_dentry.exportfs_d=
ecode_fh_raw
>      70.16           -11.7       58.44        perf-profile.calltrace.cycl=
es-pp.exportfs_decode_fh_raw.exportfs_decode_fh.handle_to_path.do_handle_op=
en.do_syscall_64
>      70.16           -11.7       58.44        perf-profile.calltrace.cycl=
es-pp.exportfs_decode_fh.handle_to_path.do_handle_open.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>      68.66           -11.7       56.94        perf-profile.calltrace.cycl=
es-pp.ilookup5.shmem_fh_to_dentry.exportfs_decode_fh_raw.exportfs_decode_fh=
.handle_to_path
>      70.15           -11.7       58.44        perf-profile.calltrace.cycl=
es-pp.shmem_fh_to_dentry.exportfs_decode_fh_raw.exportfs_decode_fh.handle_t=
o_path.do_handle_open
>      67.16           -11.7       55.44        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ilookup5_nowait.ilook=
up5.shmem_fh_to_dentry
>      68.64           -11.7       56.94        perf-profile.calltrace.cycl=
es-pp.ilookup5_nowait.ilookup5.shmem_fh_to_dentry.exportfs_decode_fh_raw.ex=
portfs_decode_fh
>      76.88            -8.8       68.10        perf-profile.calltrace.cycl=
es-pp.open_by_handle_at
>      76.73            -8.8       67.98        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open_by_handle_at
>      76.69            -8.7       67.96        perf-profile.calltrace.cycl=
es-pp.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open_by_h=
andle_at
>      76.79            -8.7       68.07        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.open_by_handle_at
>       9.29            -0.1        9.17        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.=
__legitimize_path.try_to_unlazy
>       1.42            +0.0        1.46        perf-profile.calltrace.cycl=
es-pp.find_inode.ilookup5_nowait.ilookup5.shmem_fh_to_dentry.exportfs_decod=
e_fh_raw
>       1.39            +0.1        1.45        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock.find_inode.ilookup5_nowait.ilookup5.shmem_fh_to_dentry
>       1.40            +0.1        1.46        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.do_dentry=
_open.do_open
>       1.44            +0.1        1.52        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.__fput.__x64_sys=
_close
>       1.45            +0.1        1.53        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.path_put.do_hand=
le_open
>       1.36            +0.1        1.44        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock.find_inode.ilookup5_n=
owait.ilookup5
>       1.42            +0.1        1.50        perf-profile.calltrace.cycl=
es-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.p=
ath_openat
>       1.41            +0.1        1.50        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock.lockref_get.do_dentry_open.do_open.path_openat
>       1.46            +0.1        1.56        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock.dput.__fput.__x64_sys_close.do_syscall_64
>       1.46            +0.1        1.57        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock.dput.path_put.do_handle_open.do_syscall_64
>       1.43            +0.1        1.55        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_file_open_root
>       1.47            +0.7        2.19        perf-profile.calltrace.cycl=
es-pp.path_init.path_openat.do_file_open_root.file_open_root.do_handle_open
>       1.86            +0.7        2.59        perf-profile.calltrace.cycl=
es-pp.__close
>       1.79            +0.7        2.52        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       1.45            +0.7        2.18        perf-profile.calltrace.cycl=
es-pp.lockref_get.path_init.path_openat.do_file_open_root.file_open_root
>       1.78            +0.7        2.52        perf-profile.calltrace.cycl=
es-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       1.82            +0.8        2.57        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.__close
>       0.00            +0.8        0.77        perf-profile.calltrace.cycl=
es-pp.lockref_put_return.dput.path_put.do_handle_open.do_syscall_64
>       0.00            +0.8        0.78        perf-profile.calltrace.cycl=
es-pp.lockref_put_return.dput.terminate_walk.path_openat.do_file_open_root
>       1.64            +0.8        2.42        perf-profile.calltrace.cycl=
es-pp.do_open.path_openat.do_file_open_root.file_open_root.do_handle_open
>       1.67            +0.8        2.48        perf-profile.calltrace.cycl=
es-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe._=
_close
>       0.00            +0.8        0.81 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.lockref_put_return.dput.__fput.__x64_sys_close.do_syscall_64
>       1.58            +0.8        2.38        perf-profile.calltrace.cycl=
es-pp.do_dentry_open.do_open.path_openat.do_file_open_root.file_open_root
>       1.44            +0.8        2.28        perf-profile.calltrace.cycl=
es-pp.lockref_get.do_dentry_open.do_open.path_openat.do_file_open_root
>       1.48            +0.9        2.35        perf-profile.calltrace.cycl=
es-pp.dput.path_put.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
>       1.48            +0.9        2.35        perf-profile.calltrace.cycl=
es-pp.path_put.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
open_by_handle_at
>       1.47            +0.9        2.34        perf-profile.calltrace.cycl=
es-pp.dput.terminate_walk.path_openat.do_file_open_root.file_open_root
>       1.47            +0.9        2.34        perf-profile.calltrace.cycl=
es-pp.terminate_walk.path_openat.do_file_open_root.file_open_root.do_handle=
_open
>       1.50            +0.9        2.38        perf-profile.calltrace.cycl=
es-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame
>       4.73            +2.3        7.06        perf-profile.calltrace.cycl=
es-pp.do_file_open_root.file_open_root.do_handle_open.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>       4.73            +2.3        7.06        perf-profile.calltrace.cycl=
es-pp.file_open_root.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.open_by_handle_at
>       4.67            +2.3        7.00        perf-profile.calltrace.cycl=
es-pp.path_openat.do_file_open_root.file_open_root.do_handle_open.do_syscal=
l_64
>      10.36            +4.2       14.50        perf-profile.calltrace.cycl=
es-pp.user_path_at_empty.__x64_sys_name_to_handle_at.do_syscall_64.entry_SY=
SCALL_64_after_hwframe.name_to_handle_at
>       9.93            +4.2       14.14        perf-profile.calltrace.cycl=
es-pp.filename_lookup.user_path_at_empty.__x64_sys_name_to_handle_at.do_sys=
call_64.entry_SYSCALL_64_after_hwframe
>       9.90            +4.2       14.12        perf-profile.calltrace.cycl=
es-pp.path_lookupat.filename_lookup.user_path_at_empty.__x64_sys_name_to_ha=
ndle_at.do_syscall_64
>       9.63            +4.4       14.03        perf-profile.calltrace.cycl=
es-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.__x64_=
sys_name_to_handle_at
>       9.63            +4.4       14.02        perf-profile.calltrace.cycl=
es-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_a=
t_empty
>       9.62            +4.4       14.02        perf-profile.calltrace.cycl=
es-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_=
lookup
>       9.59            +4.4       14.01        perf-profile.calltrace.cycl=
es-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.pa=
th_lookupat
>       9.69            +4.4       14.14        perf-profile.calltrace.cycl=
es-pp.path_put.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe.name_to_handle_at
>       9.69            +4.4       14.14        perf-profile.calltrace.cycl=
es-pp.dput.path_put.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL=
_64_after_hwframe
>       0.00            +4.6        4.55 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.lockref_put_return.dput.path_put.__x64_sys_name_to_handle_at.do_=
syscall_64
>      20.70            +8.4       29.07        perf-profile.calltrace.cycl=
es-pp.name_to_handle_at
>      20.45            +8.4       28.90        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.name_to_handle_at
>      20.42            +8.5       28.88        perf-profile.calltrace.cycl=
es-pp.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.name_to_handle_at
>      20.52            +8.5       28.99        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.name_to_handle_at
>      70.47           -11.9       58.54        perf-profile.children.cycle=
s-pp.handle_to_path
>      70.16           -11.7       58.44        perf-profile.children.cycle=
s-pp.exportfs_decode_fh_raw
>      70.16           -11.7       58.44        perf-profile.children.cycle=
s-pp.exportfs_decode_fh
>      68.66           -11.7       56.94        perf-profile.children.cycle=
s-pp.ilookup5
>      70.15           -11.7       58.44        perf-profile.children.cycle=
s-pp.shmem_fh_to_dentry
>      68.65           -11.7       56.94        perf-profile.children.cycle=
s-pp.ilookup5_nowait
>      95.73           -11.6       84.14        perf-profile.children.cycle=
s-pp.native_queued_spin_lock_slowpath
>      96.10           -11.2       84.88        perf-profile.children.cycle=
s-pp._raw_spin_lock
>      76.90            -8.8       68.11        perf-profile.children.cycle=
s-pp.open_by_handle_at
>      76.69            -8.7       67.96        perf-profile.children.cycle=
s-pp.do_handle_open
>       0.42 =C4=85  2%      -0.3        0.14 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.open64
>       0.38 =C4=85  2%      -0.3        0.11 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.__x64_sys_openat
>       0.38 =C4=85  3%      -0.3        0.11 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.do_sys_openat2
>       0.33 =C4=85  3%      -0.2        0.09 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.do_filp_open
>       0.20 =C4=85  3%      -0.1        0.07 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.getname_flags
>       0.35 =C4=85  4%      -0.1        0.23 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.do_sys_name_to_handle
>       0.14 =C4=85  3%      -0.1        0.03 =C4=85 70%  perf-profile.chil=
dren.cycles-pp.alloc_empty_file
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.clear_bhb_loop
>       0.14 =C4=85  3%      -0.1        0.05        perf-profile.children.=
cycles-pp.__check_object_size
>       0.12 =C4=85  4%      -0.1        0.03 =C4=85 70%  perf-profile.chil=
dren.cycles-pp.strncpy_from_user
>       0.14 =C4=85  2%      -0.1        0.05 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.link_path_walk
>       1.43            +0.0        1.46        perf-profile.children.cycle=
s-pp.find_inode
>       0.28 =C4=85  2%      +0.1        0.35        perf-profile.children.=
cycles-pp.putname
>      99.41            +0.1       99.56        perf-profile.children.cycle=
s-pp.do_syscall_64
>      99.57            +0.2       99.81        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>       1.86            +0.6        2.50        perf-profile.children.cycle=
s-pp.do_open
>       1.57            +0.7        2.22        perf-profile.children.cycle=
s-pp.path_init
>       1.70            +0.7        2.41        perf-profile.children.cycle=
s-pp.do_dentry_open
>       1.87            +0.7        2.59        perf-profile.children.cycle=
s-pp.__close
>       1.78            +0.7        2.52        perf-profile.children.cycle=
s-pp.__x64_sys_close
>       1.67            +0.8        2.48        perf-profile.children.cycle=
s-pp.__fput
>       1.51            +0.8        2.34        perf-profile.children.cycle=
s-pp.terminate_walk
>       2.91            +1.6        4.46        perf-profile.children.cycle=
s-pp.lockref_get
>       5.00            +2.1        7.09        perf-profile.children.cycle=
s-pp.path_openat
>       4.73            +2.3        7.06        perf-profile.children.cycle=
s-pp.do_file_open_root
>       4.73            +2.3        7.06        perf-profile.children.cycle=
s-pp.file_open_root
>      10.36            +4.1       14.51        perf-profile.children.cycle=
s-pp.user_path_at_empty
>       9.93            +4.2       14.14        perf-profile.children.cycle=
s-pp.filename_lookup
>       9.90            +4.2       14.12        perf-profile.children.cycle=
s-pp.path_lookupat
>       9.69            +4.4       14.05        perf-profile.children.cycle=
s-pp.complete_walk
>       9.68            +4.4       14.04        perf-profile.children.cycle=
s-pp.try_to_unlazy
>       9.67            +4.4       14.04        perf-profile.children.cycle=
s-pp.__legitimize_path
>       9.63            +4.4       14.02        perf-profile.children.cycle=
s-pp.lockref_get_not_dead
>      11.18            +5.3       16.49        perf-profile.children.cycle=
s-pp.path_put
>       0.28            +6.6        6.91 =C4=85  2%  perf-profile.children.=
cycles-pp.lockref_put_return
>      14.16            +7.0       21.20        perf-profile.children.cycle=
s-pp.dput
>      20.73            +8.4       29.08        perf-profile.children.cycle=
s-pp.name_to_handle_at
>      20.42            +8.5       28.89        perf-profile.children.cycle=
s-pp.__x64_sys_name_to_handle_at
>      95.48           -11.5       83.94        perf-profile.self.cycles-pp=
.native_queued_spin_lock_slowpath
>       0.16 =C4=85  3%      -0.1        0.06 =C4=85  9%  perf-profile.self=
.cycles-pp.clear_bhb_loop
>       0.09 =C4=85  5%      -0.0        0.07 =C4=85  5%  perf-profile.self=
.cycles-pp.do_dentry_open
>       0.11 =C4=85  5%      +0.0        0.15 =C4=85 13%  perf-profile.self=
.cycles-pp.do_sys_name_to_handle
>       0.27            +0.1        0.35        perf-profile.self.cycles-pp=
.putname
>       0.16 =C4=85  4%      +0.1        0.25 =C4=85  4%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.00            +0.1        0.10 =C4=85 12%  perf-profile.self.cycl=
es-pp.dput
>       0.37 =C4=85  2%      +0.4        0.74        perf-profile.self.cycl=
es-pp._raw_spin_lock
>       0.08            +1.4        1.53        perf-profile.self.cycles-pp=
.lockref_get
>       0.27 =C4=85  2%      +4.3        4.61 =C4=85  2%  perf-profile.self=
.cycles-pp.lockref_get_not_dead
>       0.28            +6.6        6.90 =C4=85  2%  perf-profile.self.cycl=
es-pp.lockref_put_return
>
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


--=20
Mateusz Guzik <mjguzik gmail.com>

