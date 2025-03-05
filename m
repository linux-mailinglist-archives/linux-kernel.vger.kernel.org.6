Return-Path: <linux-kernel+bounces-547431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA0A507F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BC11894076
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6990D14B075;
	Wed,  5 Mar 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKe1ACZ1"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9259250BE9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197741; cv=none; b=CPx0nh1rVD4zelOBtWX5KZu8vhR8jhDXS6AJirDkvXuBVKoxsl1wI5PoIOAN/cX0asxH23ipM3EGLojOhgeOgRh6/dLNgeDIy9OI5122RFHGSx1nyW4twv2TN6z3yGPuVhwSoNkiRmUVeeEa64lE0iYmkzpAQZwErGD2lf7+NvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197741; c=relaxed/simple;
	bh=S2Sc1Gml2J+1iNvjC+MqvRTYT7GxlaaynyGQm7wSRFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGLGV/RBGKjVKbBNOjkEgaG1RGgVP9rovLjvVcRUKts+Gh3cozCTLHcVDeyED2PkI+CbzY6uQtclRysjkSfqTEqdiNKkwSAtr6I+PG3UhDIfttnoN5UZIP6bFJp1wStt24GmWl5tzrYDdPzey7oyftu5A8Vais9vwykdenf49Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKe1ACZ1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-474e1b8c935so11001cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741197738; x=1741802538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce7kUauPnhKfB4I6YLOsGy09Lzeo9MeLVskX7bGtdeI=;
        b=CKe1ACZ1Cwz2I8uyLa/pT++lB0DKEAMaW7/+oTZMAHbQr9jr4y8waXBfLrSU2mlF08
         BYP0FeXALq5hgLAS81Hr1PC/LJf4KVVJn3zd3r5SblbssRHEJSWBmHCY7e1Clv+K+d36
         L9+mP83MPkR5W1I4PBGWLIf49uraJtJsjDLIBdMJPZWjgwERA/yqWPn0MHZ2QQlImrzO
         ZC21WakBWqpJXQYGAMa6kFKxkZp1naNGbVoxtFDQmOxXNd/byp2vXEwbjHeb+6ADPPrH
         9NSGSlibVEwmehvsJrzcspN8VPNbeBQhy0O4FhSSodzirnPNAKoHOHnha+H8jhW5QFrw
         gkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741197738; x=1741802538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce7kUauPnhKfB4I6YLOsGy09Lzeo9MeLVskX7bGtdeI=;
        b=CQscG0n8O7Ihaoj84kJEB7yy/ottmGIwS08HMTt7/IKF25QlP+StLKErtekTOMNggZ
         RzIh6k9uUtoavkAJJ896ZjTHwR4h2Wkb3ymRK+hYxQlfJUHCntJE13x3J26FY4G0B8pn
         EIXDBfz0lPN2mrrzUvXjwBKbKXJPYe32TEiVeYNZWIQjjsUnbPCnrk7VS2YXgHLqhELe
         g1slivSCnidBvPI+3c9OIsuMVj2Yv4i1lAJc+ml/rwqcUA4RrvmX9Rs/hWrsx5BURTNt
         9AERlbWM0hSxOO52Skqd1q3VNFbmM2IRx2mExLXaGPpzfIY0vRw3laZG2fIrkp+MLq9F
         Vo8A==
X-Forwarded-Encrypted: i=1; AJvYcCUhHpU81XZ2UN53MemuX/XdEIKNj4/y63etTNHgHlcnDRM3S4l7a+fh5jspHpmJEX0b3C3Otq3Ue+eBNY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3n6J9voFKCkjmrkf8ic1qoYbhynuXn/FLlQbgMGjpkFQlVuV
	m8wtozCllz2QK7eexmZhzM1nmv0kHE3muTn28SO+fwQ8g/A58lQfWEKXqAG4La24C4O7Q4WJO0B
	XAnc114KT4hUSSFTth3ltm4KRbdxKZ3QcRiggyZbbJ2m6SA75Ww==
X-Gm-Gg: ASbGncuOlcGi61RW9NIdPv9nGVo8+Yhjsa3pymXt82FdVd8zbgEqUWLpePoJ4B0qLI5
	QAqfTr3y0FtcQFDQTn3diUyT+RvHD9Sw9P4IvjU0z/mUQIx1Ik29qich3ys4MV5nJ3VcGX4VZAq
	xDK08aZx2Cr5qXDRKkEswYJvI=
X-Google-Smtp-Source: AGHT+IFA9r40e48P0pUHRPwxiGF25g58Qn7efDLSHlif2uuHza/9Dpfwcb0S4FrEJ4i63iemawEOHXMC3MFNAakXf4o=
X-Received: by 2002:a05:622a:1986:b0:474:e97c:4423 with SMTP id
 d75a77b69052e-4750b55ac9fmr4853601cf.14.1741197738149; Wed, 05 Mar 2025
 10:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228182928.2645936-3-fvdl@google.com> <202503051327.e87dce82-lkp@intel.com>
In-Reply-To: <202503051327.e87dce82-lkp@intel.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 5 Mar 2025 10:02:06 -0800
X-Gm-Features: AQ5f1JpHesB0lMosOdwByQXd4BdAnxPB8Po0EQNzICphKLdaoXnJeFsXCTlZgjU
Message-ID: <CAPTztWassGn0q-gEC+yLB5UQyBP=q4JMEXVncckRGyeih9KEwQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/27] mm, cma: support multiple contiguous ranges, if requested
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Arnd Bergmann <arnd@arndb.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	muchun.song@linux.dev, yuzhao@google.com, usamaarif642@gmail.com, 
	joao.m.martins@oracle.com, roman.gushchin@linux.dev, ziy@nvidia.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:29=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 15.1% improvement of netperf.Throughput_tps o=
n:
>
>
> commit: a957f140831b0d42e4fdbe83cf93997ef1b51bda ("[PATCH v5 02/27] mm, c=
ma: support multiple contiguous ranges, if requested")
> url: https://github.com/intel-lab-lkp/linux/commits/Frank-van-der-Linden/=
mm-cma-export-total-and-free-number-of-pages-for-CMA-areas/20250301-023339
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 276=
f98efb64a2c31c099465ace78d3054c662a0f
> patch link: https://lore.kernel.org/all/20250228182928.2645936-3-fvdl@goo=
gle.com/
> patch subject: [PATCH v5 02/27] mm, cma: support multiple contiguous rang=
es, if requested
>
> testcase: netperf
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00=
GHz (Ice Lake) with 256G memory
> parameters:
>
>         ip: ipv4
>         runtime: 300s
>         nr_threads: 200%
>         cluster: cs-localhost
>         test: TCP_CRR
>         cpufreq_governor: performance
>
>
>
>
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250305/202503051327.e87dce82-lk=
p@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tb=
ox_group/test/testcase:
>   cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/200%/debian-12-x86=
_64-20240206.cgz/300s/lkp-icl-2sp2/TCP_CRR/netperf
>
> commit:
>   cdc31e6532 ("mm/cma: export total and free number of pages for CMA area=
s")
>   a957f14083 ("mm, cma: support multiple contiguous ranges, if requested"=
)
>
> cdc31e65328522c6 a957f140831b0d42e4fdbe83cf9
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       2.43            +0.5        2.90 =C4=85  4%  mpstat.cpu.all.usr%
>    4718850           +15.4%    5446771        vmstat.system.cs
>      62006 =C4=85 43%     -59.6%      25067 =C4=85137%  numa-meminfo.node=
0.Mapped
>    2884295 =C4=85 41%     -59.4%    1171696 =C4=85135%  numa-meminfo.node=
0.Unevictable
>      28159 =C4=85  2%     -17.7%      23164 =C4=85  2%  perf-c2c.HITM.loc=
al
>       5426 =C4=85  3%     +28.5%       6973 =C4=85  8%  perf-c2c.HITM.rem=
ote
>      33586 =C4=85  2%     -10.3%      30137 =C4=85  3%  perf-c2c.HITM.tot=
al
>    5642375 =C4=85  2%     +15.5%    6519596        sched_debug.cpu.nr_swi=
tches.avg
>    7473763 =C4=85  4%     +18.0%    8815709 =C4=85  2%  sched_debug.cpu.n=
r_switches.max
>    4352931 =C4=85  3%     +12.7%    4906391 =C4=85  2%  sched_debug.cpu.n=
r_switches.min
>    2485115 =C4=85  6%     +31.9%    3277456 =C4=85 11%  numa-numastat.nod=
e0.local_node
>    2526446 =C4=85  6%     +32.8%    3356120 =C4=85 11%  numa-numastat.nod=
e0.numa_hit
>    3522582 =C4=85 10%     +28.7%    4535065 =C4=85 23%  numa-numastat.nod=
e1.local_node
>    3613797 =C4=85 10%     +27.0%    4588978 =C4=85 22%  numa-numastat.nod=
e1.numa_hit
>      40617            +5.4%      42811 =C4=85  5%  proc-vmstat.nr_slab_re=
claimable
>    6144430 =C4=85  4%     +29.4%    7948120 =C4=85 16%  proc-vmstat.numa_=
hit
>    6011884 =C4=85  4%     +30.0%    7815542 =C4=85 16%  proc-vmstat.numa_=
local
>   26402145 =C4=85  2%     +40.6%   37129548 =C4=85 14%  proc-vmstat.pgall=
oc_normal
>   25226079           +42.1%   35834032 =C4=85 13%  proc-vmstat.pgfree
>      15712 =C4=85 43%     -59.6%       6348 =C4=85137%  numa-vmstat.node0=
.nr_mapped
>     721073 =C4=85 41%     -59.4%     292924 =C4=85135%  numa-vmstat.node0=
.nr_unevictable
>     721073 =C4=85 41%     -59.4%     292924 =C4=85135%  numa-vmstat.node0=
.nr_zone_unevictable
>    2526848 =C4=85  6%     +32.8%    3355902 =C4=85 11%  numa-vmstat.node0=
.numa_hit
>    2485517 =C4=85  6%     +31.9%    3277238 =C4=85 11%  numa-vmstat.node0=
.numa_local
>    3614259 =C4=85 10%     +27.0%    4589442 =C4=85 22%  numa-vmstat.node1=
.numa_hit
>    3523043 =C4=85 10%     +28.7%    4535533 =C4=85 23%  numa-vmstat.node1=
.numa_local
>    1711802           +15.1%    1969470        netperf.ThroughputBoth_tota=
l_tps
>       6686           +15.1%       7693        netperf.ThroughputBoth_tps
>    1711802           +15.1%    1969470        netperf.Throughput_total_tp=
s
>       6686           +15.1%       7693        netperf.Throughput_tps
>  4.052e+08 =C4=85  5%     +16.7%  4.728e+08 =C4=85  4%  netperf.time.invo=
luntary_context_switches
>     535.88           +18.1%     633.12        netperf.time.user_time
>  3.175e+08 =C4=85  3%     +13.9%  3.615e+08 =C4=85  3%  netperf.time.volu=
ntary_context_switches
>  5.135e+08           +15.1%  5.908e+08        netperf.workload
>       0.07 =C4=85  8%     -31.3%       0.05 =C4=85 23%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__al=
loc_skb.tcp_stream_alloc_skb
>       0.46 =C4=85114%     -71.4%       0.13 =C4=85 34%  perf-sched.sch_de=
lay.max.ms.__cond_resched.lock_sock_nested.__inet_stream_connect.inet_strea=
m_connect.__sys_connect
>       5.70 =C4=85 90%   +2752.3%     162.72 =C4=85202%  perf-sched.wait_a=
nd_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>      33.94 =C4=85 19%     +50.3%      50.99 =C4=85 18%  perf-sched.wait_a=
nd_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      30764 =C4=85 22%     -32.1%      20881 =C4=85 22%  perf-sched.wait_a=
nd_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       7.03 =C4=85 60%  +11736.2%     832.16 =C4=85150%  perf-sched.wait_a=
nd_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.14 =C4=85  8%     -33.5%       0.09 =C4=85 26%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__al=
loc_skb.tcp_stream_alloc_skb
>       0.11 =C4=85  8%     -14.3%       0.10 =C4=85 11%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.lock_sock_nested.inet_stream_connect.__sys_connec=
t.__x64_sys_connect
>      33.61 =C4=85 19%     +50.4%      50.57 =C4=85 18%  perf-sched.wait_t=
ime.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.69 =C4=85109%     -59.0%       0.28 =C4=85 27%  perf-sched.wait_t=
ime.max.ms.__cond_resched.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_=
recvmsg
>       0.76           -39.9%       0.46 =C4=85 12%  perf-stat.i.MPKI
>  3.959e+10           +14.9%   4.55e+10        perf-stat.i.branch-instruct=
ions
>       0.92            -0.0        0.90        perf-stat.i.branch-miss-rat=
e%
>  3.564e+08           +12.7%  4.017e+08        perf-stat.i.branch-misses
>  1.561e+08           -32.2%  1.058e+08 =C4=85 12%  perf-stat.i.cache-miss=
es
>   6.91e+08           -33.8%  4.574e+08 =C4=85  6%  perf-stat.i.cache-refe=
rences
>    4760614           +15.5%    5496803        perf-stat.i.context-switche=
s
>       1.54           -13.5%       1.33        perf-stat.i.cpi
>       2048           +49.1%       3054 =C4=85  9%  perf-stat.i.cycles-bet=
ween-cache-misses
>  2.084e+11           +14.9%  2.394e+11        perf-stat.i.instructions
>       0.65           +15.3%       0.75        perf-stat.i.ipc
>      37.20           +15.5%      42.97        perf-stat.i.metric.K/sec
>       0.75           -41.0%       0.44 =C4=85 12%  perf-stat.overall.MPKI
>       0.90            -0.0        0.88        perf-stat.overall.branch-mi=
ss-rate%
>       1.54           -13.6%       1.33        perf-stat.overall.cpi
>       2060           +48.5%       3060 =C4=85 10%  perf-stat.overall.cycl=
es-between-cache-misses
>       0.65           +15.7%       0.75        perf-stat.overall.ipc
>  3.947e+10           +14.9%  4.536e+10        perf-stat.ps.branch-instruc=
tions
>  3.553e+08           +12.7%  4.005e+08        perf-stat.ps.branch-misses
>  1.557e+08           -32.2%  1.055e+08 =C4=85 12%  perf-stat.ps.cache-mis=
ses
>  6.889e+08           -33.8%   4.56e+08 =C4=85  6%  perf-stat.ps.cache-ref=
erences
>    4746041           +15.5%    5479885        perf-stat.ps.context-switch=
es
>  2.078e+11           +14.9%  2.387e+11        perf-stat.ps.instructions
>  6.363e+13           +14.9%  7.312e+13        perf-stat.total.instruction=
s
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

Since there should be no functional change for existing callers of CMA
interfaces, I'm flattered by this report, but it's definitely not
these commits that cause any change in performance :-)

- Frank

