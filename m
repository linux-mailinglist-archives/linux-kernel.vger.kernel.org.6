Return-Path: <linux-kernel+bounces-257454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19181937A57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC5A1C21966
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9B145B26;
	Fri, 19 Jul 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwxdBqrw"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC844145FEA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405248; cv=none; b=MPvh+LsvBnnF1fW6YCWZF5dS38jKoMN0N14WKDSDbzm8Gyv6naF3jzugNrH2HTaFj7Rep+GQQYKir3iwQeZ2n664AuWmosOWeEB44Vm1KBA0OQFqfLrMCpHSH++ZUgrFlx1418oGpHGWh3A91mny+S4lJQ8clqdIo8X1WiRgZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405248; c=relaxed/simple;
	bh=RzmAvLHSbgmcruv6HxrlLDFJgCLmbbWZvQIHXC6sP6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqR4V1rrDTx0BHU3kUtmUszp7OLmHjUEJr2LQYTxuUwva4q0gfkv3lfmLUschIqmGSmeq81UIrxf1IwWQ4gTKfCPwVXsaGG6OXSUgQYlBEcF3iYCMxYWz/JRHNaXKJwhN5nHAyspdyvUWZ5SqKvTaQPysPXb1jE+04BLF2FyJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwxdBqrw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44e534a1fbeso239031cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721405245; x=1722010045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjqS8fkCO/srMo5n9zQw4FBiRAtWy5UAGWLeRktVi8E=;
        b=mwxdBqrwItIEyT55FoCJaJozOtTja8q8Csw7Uoi2SV6niNBPaDB3dFMrAQ0W7Mvh4I
         NND6DBIJhbboz9gV6gt2hmO4gcLrYY3dUmCLSmkElTIEgLRq6T+agoDdefUnM/OduNxi
         Ma+sgzDa6XjiNGeW1Sdd13CLKqdx2O2wfwk/PKcI6ZqYhDy0ujS11CViUTS4CyELHif5
         SjRdZR5G0Dj053DboneuDOHbcfmnjDOa3Eke8dc5L2bBBNLJzRa0VjkuDxRNIfasbmha
         /ihh6jhDyZPi3mwiJbSe2+LPvrBX0nnfPiAHhYJ5C5ttLnJ01tLpzOdEGsz99QXPbN+j
         BFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405245; x=1722010045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjqS8fkCO/srMo5n9zQw4FBiRAtWy5UAGWLeRktVi8E=;
        b=a/w5q99qqrj4niA7p+kzkDquM0VIyvfVsMdoi26FvVc2/NIuEomOMZvE189drowu8n
         O5s7fnq+NHJr25tndR17VnxBbczr54MT7pqctMRbTuYLv+F+WwB+55CM5iTqANQSGPLz
         T2d45a0Q3HJAoj4l6JAJkRTc+k1c2U2Rk8QmwFRvEONfubXd6EPOu8Cqhq3yy++hF7ph
         LsVnG7FB5kgd5UfAuLrJDGoQ+nhEZEJ5Y5KwH8rBkvg4ru9z3eZWZB8nJmZEOUenzew+
         KcwzuAkfbq98g6B610ETujwmuJEn0od88YMAImrbu7nwhwqX7CHuCYYi+v2XdbEJr3Ij
         S2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0uXqdLA6GQUtX3UXqhBzx/ga7xyy6DEMNM1ovElp7ev3BuzTgzWaBiqIfE4EH+Sche2ru6mBj9FuFhXgPkI/L/K1iSfzhhlm7BakC
X-Gm-Message-State: AOJu0Yw3pT8JCI1bevCNoJZK4obamkRgaXiXp5IX38qmiTt9iQ7XO52H
	s1y96NFjQ0R0ut5Aefhc/V2x5klSWJPgLVxYJRO+pl1zuPlhun0WfNXUW3bE4wfdWE/Kr0CM7bu
	xVA07IZ+uYOnNoMEfY3e5LCykxV2z3o8lbo1E
X-Google-Smtp-Source: AGHT+IE/vUFxADcLRtK34ajk1DyIlolbxIgX9try6BtCZcKrnabXqLQwhXKRMGyjWLYeGjoKzNvxG8EMfkdNGpaA0PY=
X-Received: by 2002:a05:622a:2592:b0:444:dc22:fb1d with SMTP id
 d75a77b69052e-44f9ac6c659mr3912311cf.12.1721405244322; Fri, 19 Jul 2024
 09:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407091001.1250ad4a-oliver.sang@intel.com> <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
 <CAOUHufYvCeiGGa+3PbPDfFx__aV2XxyS7TMHMicws4aNTg4qmQ@mail.gmail.com>
 <CAOUHufaO-hxdEJZtdN-5EHEs-wOJoGQ1pVGeHaa89L7hSz8grQ@mail.gmail.com> <ZponC7ewZeq62UzS@xsang-OptiPlex-9020>
In-Reply-To: <ZponC7ewZeq62UzS@xsang-OptiPlex-9020>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 19 Jul 2024 10:06:46 -0600
Message-ID: <CAOUHufb1qteTQ+rLHBgu5yVQNYPBVrv7wCfEYC85y_pjQQ3EfQ@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Frank van der Linden <fvdl@google.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Yang Shi <yang@os.amperecomputing.com>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Marc Hartmayer <mhartmay@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:44=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Yu Zhao,
>
> On Wed, Jul 17, 2024 at 09:44:33AM -0600, Yu Zhao wrote:
> > On Wed, Jul 17, 2024 at 2:36=E2=80=AFAM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > Hi Janosch and Oliver,
> > >
> > > On Wed, Jul 17, 2024 at 1:57=E2=80=AFAM Janosch Frank <frankja@linux.=
ibm.com> wrote:
> > > >
> > > > On 7/9/24 07:11, kernel test robot wrote:
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed a -34.3% regression of vm-scalability.t=
hroughput on:
> > > > >
> > > > >
> > > > > commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vme=
mmap: fix race with speculative PFN walkers")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git =
master
> > > > >
> > > > > [still regression on linux-next/master 0b58e108042b0ed28a71cd7edf=
5175999955b233]
> > > > >
> > > > This has hit s390 huge page backed KVM guests as well.
> > > > Our simple start/stop test case went from ~5 to over 50 seconds of =
runtime.
> > >
> > > Could you try the attached patch please? Thank you.
> >
> > Thanks, Yosry, for spotting the following typo:
> >   flags &=3D VMEMMAP_SYNCHRONIZE_RCU;
> > It's supposed to be:
> >   flags &=3D ~VMEMMAP_SYNCHRONIZE_RCU;
> >
> > Reattaching v2 with the above typo fixed. Please let me know, Janosch &=
 Oliver.
>
> since the commit is in mainline now, I directly apply your v2 patch upon
> bd225530a4c71 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers=
")
>
> in our tests, your v2 patch not only recovers the performance regression,

Thanks for verifying the fix!

> it even has +13.7% performance improvement than 5a4d8944d6b1e (parent of
> bd225530a4c71)

Glad to hear!

(The original patch improved and regressed the performance at the same
time, but the regression is bigger. The fix removed the regression and
surfaced the improvement.)

> detail is as below
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/tes=
tcase:
>   gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/5=
12G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability
>
> commit:
>   5a4d8944d6b1e ("cachestat: do not flush stats in recency check")
>   bd225530a4c71 ("mm/hugetlb_vmemmap: fix race with speculative PFN walke=
rs")
>   9a5b87b521401 <---- your v2 patch
>
> 5a4d8944d6b1e1aa bd225530a4c717714722c373144 9a5b87b5214018a2be217dc4648
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>  4.271e+09 =C2=B1 10%    +348.4%  1.915e+10 =C2=B1  6%     -39.9%  2.567e=
+09 =C2=B1 20%  cpuidle..time
>     774593 =C2=B1  4%   +1060.9%    8992186 =C2=B1  6%     -17.2%     641=
254        cpuidle..usage
>     555365 =C2=B1  8%     +28.0%     710795 =C2=B1  2%      -4.5%     530=
157 =C2=B1  5%  numa-numastat.node0.local_node
>     629633 =C2=B1  4%     +23.0%     774346 =C2=B1  5%      +0.6%     633=
264 =C2=B1  4%  numa-numastat.node0.numa_hit
>     255.76 =C2=B1  2%     +31.1%     335.40 =C2=B1  3%     -13.8%     220=
.53 =C2=B1  2%  uptime.boot
>      10305 =C2=B1  6%    +144.3%      25171 =C2=B1  5%     -17.1%       8=
543 =C2=B1  8%  uptime.idle
>       1.83 =C2=B1 58%  +96200.0%       1765 =C2=B1155%    +736.4%      15=
.33 =C2=B1 24%  perf-c2c.DRAM.local
>      33.00 =C2=B1 16%  +39068.2%      12925 =C2=B1122%     +95.5%      64=
.50 =C2=B1 49%  perf-c2c.DRAM.remote
>      21.33 =C2=B1  8%   +2361.7%     525.17 =C2=B1 31%    +271.1%      79=
.17 =C2=B1 52%  perf-c2c.HITM.local
>       9.17 =C2=B1 21%   +3438.2%     324.33 =C2=B1 57%    +270.9%      34=
.00 =C2=B1 60%  perf-c2c.HITM.remote
>      16.11 =C2=B1  7%     +37.1       53.16 =C2=B1  2%      -4.6       11=
.50 =C2=B1 19%  mpstat.cpu.all.idle%
>       0.34 =C2=B1  2%      -0.1        0.22            +0.0        0.35 =
=C2=B1  3%  mpstat.cpu.all.irq%
>       0.03 =C2=B1  5%      +0.0        0.04 =C2=B1  8%      -0.0        0=
.02        mpstat.cpu.all.soft%
>      10.58 =C2=B1  4%      -9.5        1.03 =C2=B1 36%      +0.1       10=
.71 =C2=B1  2%  mpstat.cpu.all.sys%
>      72.94 =C2=B1  2%     -27.4       45.55 =C2=B1  3%      +4.5       77=
.41 =C2=B1  2%  mpstat.cpu.all.usr%
>       6.00 =C2=B1 16%    +230.6%      19.83 =C2=B1  5%      +8.3%       6=
.50 =C2=B1 17%  mpstat.max_utilization.seconds
>      16.95 =C2=B1  7%    +215.5%      53.48 =C2=B1  2%     -26.2%      12=
.51 =C2=B1 16%  vmstat.cpu.id
>      72.33 =C2=B1  2%     -37.4%      45.31 =C2=B1  3%      +6.0%      76=
.65 =C2=B1  2%  vmstat.cpu.us
>  2.254e+08            -0.0%  2.254e+08           +14.7%  2.584e+08       =
 vmstat.memory.free
>     108.30           -43.3%      61.43 =C2=B1  2%      +5.4%     114.12 =
=C2=B1  2%  vmstat.procs.r
>       2659          +162.6%       6982 =C2=B1  3%      +3.6%       2753 =
=C2=B1  4%  vmstat.system.cs
>     136384 =C2=B1  4%     -21.9%     106579 =C2=B1  7%     +13.3%     154=
581 =C2=B1  3%  vmstat.system.in
>     203.41 =C2=B1  2%     +39.2%     283.06 =C2=B1  4%     -17.1%     168=
.71 =C2=B1  2%  time.elapsed_time
>     203.41 =C2=B1  2%     +39.2%     283.06 =C2=B1  4%     -17.1%     168=
.71 =C2=B1  2%  time.elapsed_time.max
>     148901 =C2=B1  6%     -45.6%      81059 =C2=B1  4%      -8.8%     135=
748 =C2=B1  8%  time.involuntary_context_switches
>     169.83 =C2=B1 23%     +85.3%     314.67 =C2=B1  8%      +7.9%     183=
.33 =C2=B1  7%  time.major_page_faults
>      10697           -43.4%       6050 =C2=B1  2%      +5.6%      11294 =
=C2=B1  2%  time.percent_of_cpu_this_job_got
>       2740 =C2=B1  6%     -86.7%     365.06 =C2=B1 43%     -16.1%       2=
298        time.system_time
>      19012           -11.9%      16746           -11.9%      16747       =
 time.user_time
>      14412 =C2=B1  5%   +4432.0%     653187           -16.6%      12025 =
=C2=B1  3%  time.voluntary_context_switches
>      50095 =C2=B1  2%     -31.5%      34325 =C2=B1  2%     +18.6%      59=
408        vm-scalability.median
>       8.25 =C2=B1 16%      -3.4        4.84 =C2=B1 22%      -6.6        1=
.65 =C2=B1 15%  vm-scalability.median_stddev%
>    6863720           -34.0%    4532485           +13.7%    7805408       =
 vm-scalability.throughput
>     203.41 =C2=B1  2%     +39.2%     283.06 =C2=B1  4%     -17.1%     168=
.71 =C2=B1  2%  vm-scalability.time.elapsed_time
>     203.41 =C2=B1  2%     +39.2%     283.06 =C2=B1  4%     -17.1%     168=
.71 =C2=B1  2%  vm-scalability.time.elapsed_time.max
>     148901 =C2=B1  6%     -45.6%      81059 =C2=B1  4%      -8.8%     135=
748 =C2=B1  8%  vm-scalability.time.involuntary_context_switches
>      10697           -43.4%       6050 =C2=B1  2%      +5.6%      11294 =
=C2=B1  2%  vm-scalability.time.percent_of_cpu_this_job_got
>       2740 =C2=B1  6%     -86.7%     365.06 =C2=B1 43%     -16.1%       2=
298        vm-scalability.time.system_time
>      19012           -11.9%      16746           -11.9%      16747       =
 vm-scalability.time.user_time
>      14412 =C2=B1  5%   +4432.0%     653187           -16.6%      12025 =
=C2=B1  3%  vm-scalability.time.voluntary_context_switches
>  1.159e+09            +0.0%  1.159e+09            +1.6%  1.178e+09       =
 vm-scalability.workload
>   22900043 =C2=B1  4%      +1.2%   23166356 =C2=B1  6%     -16.7%   19076=
170 =C2=B1  5%  numa-vmstat.node0.nr_free_pages
>      42856 =C2=B1 43%    +998.5%     470779 =C2=B1 51%    +318.6%     179=
409 =C2=B1154%  numa-vmstat.node0.nr_unevictable
>      42856 =C2=B1 43%    +998.5%     470779 =C2=B1 51%    +318.6%     179=
409 =C2=B1154%  numa-vmstat.node0.nr_zone_unevictable
>     629160 =C2=B1  4%     +22.9%     773391 =C2=B1  5%      +0.5%     632=
570 =C2=B1  4%  numa-vmstat.node0.numa_hit
>     554892 =C2=B1  8%     +27.9%     709841 =C2=B1  2%      -4.6%     529=
463 =C2=B1  5%  numa-vmstat.node0.numa_local
>      27469 =C2=B1 14%      +0.0%      27475 =C2=B1 41%     -31.7%      18=
763 =C2=B1 13%  numa-vmstat.node1.nr_active_anon
>     767179 =C2=B1  2%     -55.8%     339212 =C2=B1 72%     -19.7%     616=
417 =C2=B1 43%  numa-vmstat.node1.nr_file_pages
>   10693349 =C2=B1  5%     +46.3%   15639681 =C2=B1  7%     +69.4%   18112=
002 =C2=B1  3%  numa-vmstat.node1.nr_free_pages
>      14210 =C2=B1 27%     -65.0%       4973 =C2=B1 49%     -34.7%       9=
280 =C2=B1 39%  numa-vmstat.node1.nr_mapped
>     724050 =C2=B1  2%     -59.1%     296265 =C2=B1 82%     -18.9%     587=
498 =C2=B1 47%  numa-vmstat.node1.nr_unevictable
>      27469 =C2=B1 14%      +0.0%      27475 =C2=B1 41%     -31.7%      18=
763 =C2=B1 13%  numa-vmstat.node1.nr_zone_active_anon
>     724050 =C2=B1  2%     -59.1%     296265 =C2=B1 82%     -18.9%     587=
498 =C2=B1 47%  numa-vmstat.node1.nr_zone_unevictable
>     120619 =C2=B1 11%     +13.6%     137042 =C2=B1 27%     -31.2%      82=
976 =C2=B1  7%  meminfo.Active
>     120472 =C2=B1 11%     +13.6%     136895 =C2=B1 27%     -31.2%      82=
826 =C2=B1  7%  meminfo.Active(anon)
>   70234807           +14.6%   80512468           +10.2%   77431344       =
 meminfo.CommitLimit
>  2.235e+08            +0.1%  2.237e+08           +15.1%  2.573e+08       =
 meminfo.DirectMap1G
>      44064           -22.8%      34027 =C2=B1  2%     +20.7%      53164 =
=C2=B1  2%  meminfo.HugePages_Surp
>      44064           -22.8%      34027 =C2=B1  2%     +20.7%      53164 =
=C2=B1  2%  meminfo.HugePages_Total
>   90243440           -22.8%   69688103 =C2=B1  2%     +20.7%  1.089e+08 =
=C2=B1  2%  meminfo.Hugetlb
>      70163 =C2=B1 29%     -42.6%      40293 =C2=B1 11%     -21.9%      54=
789 =C2=B1 15%  meminfo.Mapped
>  1.334e+08           +15.5%  1.541e+08           +10.7%  1.477e+08       =
 meminfo.MemAvailable
>  1.344e+08           +15.4%  1.551e+08           +10.7%  1.488e+08       =
 meminfo.MemFree
>  2.307e+08            +0.0%  2.307e+08           +14.3%  2.637e+08       =
 meminfo.MemTotal
>   96309843           -21.5%   75639108 =C2=B1  2%     +19.4%   1.15e+08 =
=C2=B1  2%  meminfo.Memused
>     259553 =C2=B1  2%      -0.9%     257226 =C2=B1 15%     -10.5%     232=
211 =C2=B1  4%  meminfo.Shmem
>    1.2e+08            -2.4%  1.172e+08           +13.3%   1.36e+08       =
 meminfo.max_used_kB
>      18884 =C2=B1 10%      -7.2%      17519 =C2=B1 15%     +37.6%      25=
983 =C2=B1  6%  numa-meminfo.node0.HugePages_Surp
>      18884 =C2=B1 10%      -7.2%      17519 =C2=B1 15%     +37.6%      25=
983 =C2=B1  6%  numa-meminfo.node0.HugePages_Total
>   91526744 =C2=B1  4%      +1.2%   92620825 =C2=B1  6%     -16.7%   76248=
423 =C2=B1  5%  numa-meminfo.node0.MemFree
>   40158207 =C2=B1  9%      -2.7%   39064126 =C2=B1 15%     +38.0%   55436=
528 =C2=B1  7%  numa-meminfo.node0.MemUsed
>     171426 =C2=B1 43%    +998.5%    1883116 =C2=B1 51%    +318.6%     717=
638 =C2=B1154%  numa-meminfo.node0.Unevictable
>     110091 =C2=B1 14%      -0.1%     109981 =C2=B1 41%     -31.7%      75=
226 =C2=B1 13%  numa-meminfo.node1.Active
>     110025 =C2=B1 14%      -0.1%     109915 =C2=B1 41%     -31.7%      75=
176 =C2=B1 13%  numa-meminfo.node1.Active(anon)
>    3068496 =C2=B1  2%     -55.8%    1356754 =C2=B1 72%     -19.6%    2466=
084 =C2=B1 43%  numa-meminfo.node1.FilePages
>      25218 =C2=B1  4%     -34.7%      16475 =C2=B1 12%      +7.9%      27=
213 =C2=B1  3%  numa-meminfo.node1.HugePages_Surp
>      25218 =C2=B1  4%     -34.7%      16475 =C2=B1 12%      +7.9%      27=
213 =C2=B1  3%  numa-meminfo.node1.HugePages_Total
>      55867 =C2=B1 27%     -65.5%      19266 =C2=B1 50%     -34.4%      36=
671 =C2=B1 38%  numa-meminfo.node1.Mapped
>   42795888 =C2=B1  5%     +46.1%   62520130 =C2=B1  7%     +69.3%   72441=
496 =C2=B1  3%  numa-meminfo.node1.MemFree
>   99028084            +0.0%   99028084           +33.4%  1.321e+08       =
 numa-meminfo.node1.MemTotal
>   56232195 =C2=B1  3%     -35.1%   36507953 =C2=B1 12%      +6.0%   59616=
707 =C2=B1  4%  numa-meminfo.node1.MemUsed
>    2896199 =C2=B1  2%     -59.1%    1185064 =C2=B1 82%     -18.9%    2349=
991 =C2=B1 47%  numa-meminfo.node1.Unevictable
>     507357            +0.0%     507357            +1.7%     516000       =
 proc-vmstat.htlb_buddy_alloc_success
>      29942 =C2=B1 10%     +14.3%      34235 =C2=B1 27%     -30.7%      20=
740 =C2=B1  7%  proc-vmstat.nr_active_anon
>    3324095           +15.7%    3847387           +10.9%    3686860       =
 proc-vmstat.nr_dirty_background_threshold
>    6656318           +15.7%    7704181           +10.9%    7382735       =
 proc-vmstat.nr_dirty_threshold
>   33559092           +15.6%   38798108           +10.9%   37209133       =
 proc-vmstat.nr_free_pages
>     197697 =C2=B1  2%      -2.5%     192661            +1.0%     199623  =
      proc-vmstat.nr_inactive_anon
>      17939 =C2=B1 28%     -42.5%      10307 =C2=B1 11%     -22.4%      13=
927 =C2=B1 14%  proc-vmstat.nr_mapped
>       2691            -7.1%       2501            +2.9%       2769       =
 proc-vmstat.nr_page_table_pages
>      64848 =C2=B1  2%      -0.7%      64386 =C2=B1 15%     -10.6%      57=
987 =C2=B1  4%  proc-vmstat.nr_shmem
>      29942 =C2=B1 10%     +14.3%      34235 =C2=B1 27%     -30.7%      20=
740 =C2=B1  7%  proc-vmstat.nr_zone_active_anon
>     197697 =C2=B1  2%      -2.5%     192661            +1.0%     199623  =
      proc-vmstat.nr_zone_inactive_anon
>    1403095            +9.3%    1534152 =C2=B1  2%      -3.2%    1358244  =
      proc-vmstat.numa_hit
>    1267544           +10.6%    1401482 =C2=B1  2%      -3.4%    1224210  =
      proc-vmstat.numa_local
>  2.608e+08            +0.1%  2.609e+08            +1.7%  2.651e+08       =
 proc-vmstat.pgalloc_normal
>    1259957           +13.4%    1428284 =C2=B1  2%      -6.5%    1178198  =
      proc-vmstat.pgfault
>  2.591e+08            +0.3%    2.6e+08            +2.3%  2.649e+08       =
 proc-vmstat.pgfree
>      36883 =C2=B1  3%     +18.5%      43709 =C2=B1  5%     -12.2%      32=
371 =C2=B1  3%  proc-vmstat.pgreuse
>       1.88 =C2=B1 16%      -0.6        1.33 =C2=B1100%      +0.9        2=
.80 =C2=B1 11%  perf-profile.calltrace.cycles-pp.nrand48_r
>      16.19 =C2=B1 85%     +28.6       44.75 =C2=B1 95%     -11.4        4=
.78 =C2=B1218%  perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fa=
ult.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>      16.20 =C2=B1 85%     +28.6       44.78 =C2=B1 95%     -11.4        4=
.78 =C2=B1218%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_ad=
dr_fault.exc_page_fault.asm_exc_page_fault.do_access
>      16.22 =C2=B1 85%     +28.6       44.82 =C2=B1 95%     -11.4        4=
.79 =C2=B1218%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_pag=
e_fault.do_access
>      16.22 =C2=B1 85%     +28.6       44.82 =C2=B1 95%     -11.4        4=
.79 =C2=B1218%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_pag=
e_fault.asm_exc_page_fault.do_access
>      16.24 =C2=B1 85%     +28.8       45.01 =C2=B1 95%     -11.4        4=
.80 =C2=B1218%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_acce=
ss
>      12.42 =C2=B1 84%     +29.5       41.89 =C2=B1 95%      -8.8        3=
.65 =C2=B1223%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_stri=
ng.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault
>      12.52 =C2=B1 84%     +29.6       42.08 =C2=B1 95%      -8.8        3=
.68 =C2=B1223%  perf-profile.calltrace.cycles-pp.copy_subpage.copy_user_lar=
ge_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
>      12.53 =C2=B1 84%     +29.7       42.23 =C2=B1 95%      -8.9        3=
.68 =C2=B1223%  perf-profile.calltrace.cycles-pp.copy_user_large_folio.huge=
tlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
>      12.80 =C2=B1 84%     +30.9       43.65 =C2=B1 95%      -9.0        3=
.76 =C2=B1223%  perf-profile.calltrace.cycles-pp.hugetlb_wp.hugetlb_fault.h=
andle_mm_fault.do_user_addr_fault.exc_page_fault
>       2.50 =C2=B1 17%      -0.7        1.78 =C2=B1100%      +1.2        3=
.73 =C2=B1 11%  perf-profile.children.cycles-pp.nrand48_r
>      16.24 =C2=B1 85%     +28.6       44.87 =C2=B1 95%     -11.4        4=
.79 =C2=B1218%  perf-profile.children.cycles-pp.do_user_addr_fault
>      16.24 =C2=B1 85%     +28.6       44.87 =C2=B1 95%     -11.4        4=
.79 =C2=B1218%  perf-profile.children.cycles-pp.exc_page_fault
>      16.20 =C2=B1 85%     +28.7       44.86 =C2=B1 95%     -11.4        4=
.78 =C2=B1218%  perf-profile.children.cycles-pp.hugetlb_fault
>      16.22 =C2=B1 85%     +28.7       44.94 =C2=B1 95%     -11.4        4=
.79 =C2=B1218%  perf-profile.children.cycles-pp.handle_mm_fault
>      16.26 =C2=B1 85%     +28.8       45.06 =C2=B1 95%     -11.5        4=
.80 =C2=B1218%  perf-profile.children.cycles-pp.asm_exc_page_fault
>      12.51 =C2=B1 84%     +29.5       42.01 =C2=B1 95%      -8.8        3=
.75 =C2=B1218%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_strin=
g
>      12.52 =C2=B1 84%     +29.6       42.11 =C2=B1 95%      -8.8        3=
.75 =C2=B1218%  perf-profile.children.cycles-pp.copy_subpage
>      12.53 =C2=B1 84%     +29.7       42.25 =C2=B1 95%      -8.8        3=
.76 =C2=B1218%  perf-profile.children.cycles-pp.copy_user_large_folio
>      12.80 =C2=B1 84%     +30.9       43.65 =C2=B1 95%      -9.0        3=
.83 =C2=B1218%  perf-profile.children.cycles-pp.hugetlb_wp
>       2.25 =C2=B1 17%      -0.7        1.59 =C2=B1100%      +1.1        3=
.36 =C2=B1 11%  perf-profile.self.cycles-pp.nrand48_r
>       1.74 =C2=B1 21%      -0.5        1.25 =C2=B1 92%      +1.2        2=
.94 =C2=B1 13%  perf-profile.self.cycles-pp.do_access
>       0.27 =C2=B1 17%      -0.1        0.19 =C2=B1100%      +0.1        0=
.40 =C2=B1 11%  perf-profile.self.cycles-pp.lrand48_r
>      12.41 =C2=B1 84%     +29.4       41.80 =C2=B1 95%      -8.7        3=
.72 =C2=B1218%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
>     350208 =C2=B1 16%      -2.7%     340891 =C2=B1 36%     -47.2%     184=
918 =C2=B1  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
>      16833 =C2=B1149%    -100.0%       3.19 =C2=B1100%    -100.0%       0=
.58 =C2=B1179%  sched_debug.cfs_rq:/.left_deadline.avg
>    2154658 =C2=B1149%    -100.0%     317.15 =C2=B1 93%    -100.0%      74=
.40 =C2=B1179%  sched_debug.cfs_rq:/.left_deadline.max
>     189702 =C2=B1149%    -100.0%      29.47 =C2=B1 94%    -100.0%       6=
.55 =C2=B1179%  sched_debug.cfs_rq:/.left_deadline.stddev
>      16833 =C2=B1149%    -100.0%       3.05 =C2=B1102%    -100.0%       0=
.58 =C2=B1179%  sched_debug.cfs_rq:/.left_vruntime.avg
>    2154613 =C2=B1149%    -100.0%     298.70 =C2=B1 95%    -100.0%      74=
.06 =C2=B1179%  sched_debug.cfs_rq:/.left_vruntime.max
>     189698 =C2=B1149%    -100.0%      27.96 =C2=B1 96%    -100.0%       6=
.52 =C2=B1179%  sched_debug.cfs_rq:/.left_vruntime.stddev
>     350208 =C2=B1 16%      -2.7%     340891 =C2=B1 36%     -47.2%     184=
918 =C2=B1  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
>      52.88 =C2=B1 14%     -19.5%      42.56 =C2=B1 39%     +22.8%      64=
.94 =C2=B1  9%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>      16833 =C2=B1149%    -100.0%       3.05 =C2=B1102%    -100.0%       0=
.58 =C2=B1179%  sched_debug.cfs_rq:/.right_vruntime.avg
>    2154613 =C2=B1149%    -100.0%     298.70 =C2=B1 95%    -100.0%      74=
.11 =C2=B1179%  sched_debug.cfs_rq:/.right_vruntime.max
>     189698 =C2=B1149%    -100.0%      27.96 =C2=B1 96%    -100.0%       6=
.53 =C2=B1179%  sched_debug.cfs_rq:/.right_vruntime.stddev
>       1588 =C2=B1  9%     -31.2%       1093 =C2=B1 18%     -20.0%       1=
270 =C2=B1 16%  sched_debug.cfs_rq:/.runnable_avg.max
>     676.36 =C2=B1  7%     -94.8%      35.08 =C2=B1 42%      -2.7%     657=
.82 =C2=B1  3%  sched_debug.cfs_rq:/.util_est.avg
>       1339 =C2=B1  8%     -74.5%     341.42 =C2=B1 24%     -22.6%       1=
037 =C2=B1 23%  sched_debug.cfs_rq:/.util_est.max
>     152.67 =C2=B1 35%     -72.3%      42.35 =C2=B1 21%     -14.9%     129=
.89 =C2=B1 33%  sched_debug.cfs_rq:/.util_est.stddev
>    1116839 =C2=B1  7%      -7.1%    1037321 =C2=B1  4%     +22.9%    1372=
316 =C2=B1 11%  sched_debug.cpu.avg_idle.max
>     126915 =C2=B1 10%     +31.6%     166966 =C2=B1  6%     -12.2%     111=
446 =C2=B1  2%  sched_debug.cpu.clock.avg
>     126930 =C2=B1 10%     +31.6%     166977 =C2=B1  6%     -12.2%     111=
459 =C2=B1  2%  sched_debug.cpu.clock.max
>     126899 =C2=B1 10%     +31.6%     166949 =C2=B1  6%     -12.2%     111=
428 =C2=B1  2%  sched_debug.cpu.clock.min
>     126491 =C2=B1 10%     +31.7%     166537 =C2=B1  6%     -12.2%     111=
078 =C2=B1  2%  sched_debug.cpu.clock_task.avg
>     126683 =C2=B1 10%     +31.6%     166730 =C2=B1  6%     -12.2%     111=
237 =C2=B1  2%  sched_debug.cpu.clock_task.max
>     117365 =C2=B1 11%     +33.6%     156775 =C2=B1  6%     -13.0%     102=
099 =C2=B1  2%  sched_debug.cpu.clock_task.min
>       2826 =C2=B1 10%    +178.1%       7858 =C2=B1  8%     -10.3%       2=
534 =C2=B1  6%  sched_debug.cpu.nr_switches.avg
>     755.38 =C2=B1 15%    +423.8%       3956 =C2=B1 14%     -15.2%     640=
.33 =C2=B1  3%  sched_debug.cpu.nr_switches.min
>     126900 =C2=B1 10%     +31.6%     166954 =C2=B1  6%     -12.2%     111=
432 =C2=B1  2%  sched_debug.cpu_clk
>     125667 =C2=B1 10%     +31.9%     165721 =C2=B1  6%     -12.3%     110=
200 =C2=B1  2%  sched_debug.ktime
>       0.54 =C2=B1141%     -99.9%       0.00 =C2=B1132%     -99.9%       0=
.00 =C2=B1114%  sched_debug.rt_rq:.rt_time.avg
>      69.73 =C2=B1141%     -99.9%       0.06 =C2=B1132%     -99.9%       0=
.07 =C2=B1114%  sched_debug.rt_rq:.rt_time.max
>       6.14 =C2=B1141%     -99.9%       0.01 =C2=B1132%     -99.9%       0=
.01 =C2=B1114%  sched_debug.rt_rq:.rt_time.stddev
>     127860 =C2=B1 10%     +31.3%     167917 =C2=B1  6%     -12.1%     112=
402 =C2=B1  2%  sched_debug.sched_clk
>      15.99          +363.6%      74.14 =C2=B1  6%     +10.1%      17.61  =
      perf-stat.i.MPKI
>  1.467e+10 =C2=B1  2%     -32.0%  9.975e+09 =C2=B1  3%     +21.3%  1.779e=
+10 =C2=B1  2%  perf-stat.i.branch-instructions
>       0.10 =C2=B1  5%      +0.6        0.68 =C2=B1  5%      +0.0        0=
.11 =C2=B1  4%  perf-stat.i.branch-miss-rate%
>   10870114 =C2=B1  3%     -26.4%    8001551 =C2=B1  3%     +15.7%   12580=
898 =C2=B1  2%  perf-stat.i.branch-misses
>      97.11           -20.0       77.11            -0.0       97.10       =
 perf-stat.i.cache-miss-rate%
>  8.118e+08 =C2=B1  2%     -32.5%  5.482e+08 =C2=B1  3%     +23.1%  9.992e=
+08 =C2=B1  2%  perf-stat.i.cache-misses
>  8.328e+08 =C2=B1  2%     -28.4%  5.963e+08 =C2=B1  3%     +22.8%  1.023e=
+09 =C2=B1  2%  perf-stat.i.cache-references
>       2601 =C2=B1  2%    +172.3%       7083 =C2=B1  3%      +2.5%       2=
665 =C2=B1  5%  perf-stat.i.context-switches
>       5.10           +39.5%       7.11 =C2=B1  9%      -9.2%       4.62  =
      perf-stat.i.cpi
>  2.826e+11           -44.1%   1.58e+11 =C2=B1  2%      +5.7%  2.987e+11 =
=C2=B1  2%  perf-stat.i.cpu-cycles
>     216.56           +42.4%     308.33 =C2=B1  6%      +2.2%     221.23  =
      perf-stat.i.cpu-migrations
>     358.79            -0.3%     357.70 =C2=B1 21%     -14.1%     308.23  =
      perf-stat.i.cycles-between-cache-misses
>  6.286e+10 =C2=B1  2%     -31.7%  4.293e+10 =C2=B1  3%     +21.3%  7.626e=
+10 =C2=B1  2%  perf-stat.i.instructions
>       0.24           +39.9%       0.33 =C2=B1  4%     +13.6%       0.27  =
      perf-stat.i.ipc
>       5844           -16.9%       4856 =C2=B1  2%     +12.5%       6577  =
      perf-stat.i.minor-faults
>       5846           -16.9%       4857 =C2=B1  2%     +12.5%       6578  =
      perf-stat.i.page-faults
>      13.00            -2.2%      12.72            +1.2%      13.15       =
 perf-stat.overall.MPKI
>       0.07            +0.0        0.08            -0.0        0.07       =
 perf-stat.overall.branch-miss-rate%
>      97.44            -5.3       92.09            +0.2       97.66       =
 perf-stat.overall.cache-miss-rate%
>       4.51           -18.4%       3.68           -13.0%       3.92       =
 perf-stat.overall.cpi
>     346.76           -16.6%     289.11           -14.0%     298.06       =
 perf-stat.overall.cycles-between-cache-misses
>       0.22           +22.6%       0.27           +15.0%       0.26       =
 perf-stat.overall.ipc
>      10906            -3.4%      10541            -1.1%      10784       =
 perf-stat.overall.path-length
>  1.445e+10 =C2=B1  2%     -30.7%  1.001e+10 =C2=B1  3%     +21.2%  1.752e=
+10 =C2=B1  2%  perf-stat.ps.branch-instructions
>   10469697 =C2=B1  3%     -23.5%    8005730 =C2=B1  3%     +18.3%   12387=
061 =C2=B1  2%  perf-stat.ps.branch-misses
>  8.045e+08 =C2=B1  2%     -31.9%  5.478e+08 =C2=B1  3%     +22.7%  9.874e=
+08 =C2=B1  2%  perf-stat.ps.cache-misses
>  8.257e+08 =C2=B1  2%     -27.9%   5.95e+08 =C2=B1  3%     +22.5%  1.011e=
+09 =C2=B1  2%  perf-stat.ps.cache-references
>       2584 =C2=B1  2%    +169.3%       6958 =C2=B1  3%      +2.7%       2=
654 =C2=B1  4%  perf-stat.ps.context-switches
>  2.789e+11           -43.2%  1.583e+11 =C2=B1  2%      +5.5%  2.943e+11 =
=C2=B1  2%  perf-stat.ps.cpu-cycles
>     214.69           +41.8%     304.37 =C2=B1  6%      +2.2%     219.46  =
      perf-stat.ps.cpu-migrations
>   6.19e+10 =C2=B1  2%     -30.4%  4.309e+10 =C2=B1  3%     +21.3%  7.507e=
+10 =C2=B1  2%  perf-stat.ps.instructions
>       5849           -18.0%       4799 =C2=B1  2%     +12.3%       6568 =
=C2=B1  2%  perf-stat.ps.minor-faults
>       5851           -18.0%       4800 =C2=B1  2%     +12.3%       6570 =
=C2=B1  2%  perf-stat.ps.page-faults
>  1.264e+13            -3.4%  1.222e+13            +0.5%   1.27e+13       =
 perf-stat.total.instructions

