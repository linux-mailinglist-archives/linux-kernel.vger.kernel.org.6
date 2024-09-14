Return-Path: <linux-kernel+bounces-329267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB85978F65
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE741C21653
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3D14D290;
	Sat, 14 Sep 2024 09:20:43 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E74C96
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305642; cv=none; b=MHIMW+spRFDcF8/z8wzA4GSxSmWfz+P0x72pPhsy52ePUxaPq1oXpU3iXiPd3wy98obm9gT6hdo4mn3irtCzoavJCGXRPloh74UZyHGjnLCvalFHnmS9ZhWuPRthEr85mgJPTCH16j7pSLBQ2q0TE+Zj3LUk9NZRs9HbBoqSWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305642; c=relaxed/simple;
	bh=3myQNJkR7boD41Q99SYuJGTNOTLDVic4GWcx6Z1alvg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pK7ZvTT3dibPscdTtJOLggHIh3lYC+y2uFJ4UIR81/fyhVmrV6InIDG99ImfTL/7OhS2GH+oLPrY2FxpjifZez3BAtTuG+2xTldjTr3FSXE71y56FZTBBe7ooo9W2UCUUCReOaXXL+XaWRCda5azzkkGqPuA739msFl9owKyDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726305629-1eb14e31a7105f80001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id DgMjzc9TuTMKDwHm (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 14 Sep 2024 17:20:29 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:29 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:28 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Sat, 14 Sep 2024 17:20:27 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 16:53:27 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH 0/4] locking/osq_lock: Update osq_lock to dynamic
Date: Sat, 14 Sep 2024 16:53:23 +0800
X-ASG-Orig-Subj: [PATCH 0/4] locking/osq_lock: Update osq_lock to dynamic
Message-ID: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/14/2024 5:20:25 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1726305629
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 13399
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130433
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

    The dynamic numa-aware osq_lock supports numa architecture based on
    the kernel in-box osq_lock.
    After enable by echo 1 > /proc/zx_numa_lock/dynamic_enable, the patch
    keeps checking how many processes are waiting for a osq lock. If more
    than a threshold, the patch stops these processes and switches to the
    numa-aware osq lock, then restarts. By a cleanup work queue,
    numa-aware osq lock turns back to osq_lock when all nodes unlocked,
    all the numa-aware lock memory returns to the pre-allocated Linux
    kernel memory cache.
   =20
    The struct optimistic_spin_queue of dynamic numa-aware lock is also
    4 bytes, the same as the in-box osq lock. If enable dynamic switch,
    it will be accessed as three members by union. The tail is tail16,
    2 bytes, supports 65534 cpu cores. The other two members are for lock
    switch state and numa memory index, each 1 byte.
   =20
    The serial and numa are added to the struct optimistic_spin_node to
    know how many processes is waiting an osq lock. Each process applies
    an osq lock, the serial will add 1. The numa is a condition for
    turning program from osq_lock to numa-aware lock.
   =20
    We have done some performance evaluation for the dynamic numa-aware
    osq lock by perf, locktorture, unixbench, fxmark etc.
    fxmark: Filesystem Multicore Scalability Benchmark
    https://github.com/sslab-gatech/fxmark
   =20
    The following results are tested by Zhaoxin KH40000 32 cores processor
    or 32+32 cores, two sockets processor, and AMD EPYC 7551 32-core
    processor, two sockets. Since I do not know well about AMD CPU, the
    code to support AMD CPU is a sample only.
   =20
    The number under Average represents an average of test five times.
     The CV is the Coefficient of Variation.
    The kernel source code is 6.6.28 stable, compiled in the default
    configuration.
    The 6.6.28-osq-dynamic is the kernel 6.6.28 with the patch and enable
    dynamic switch.
    The OS is Ubuntu 22.04.02 LTS, gcc version 9.5.0.
   =20
    perf bench     Zhaoxin KH40000 32 cores
    kernel     6.6.28          6.6.28-osq-dynamic
    epoll  Average  CV       Average  CV    Improve
    ADD     25620  0.78%     64609  2.55%  152.18%
    WAIT     7134  1.77%     11098  0.52%   55.56%
   =20
    locktortue                Zhaoxin KH40000 32 cores
    kernel                 6.6.28            6.6.28-osq-dynamic
    lock torture        Average   CV     Average      CV    Improve
    mutex_lock Writes   7433503  1.59%   17979058   1.90%   141.87%
   =20
    unixbench             Zhaoxin KH40000 32+32 cores, run on ssd
    64 copys                          6.6.28           6.6.28-osq-dynamic
    System Benchmarks Partial   Average    CV     Average   CV     Improve
         Execl Throughput       1460.18   1.18%   1865.22  0.25%    27.74%
    File Copy 1024 bufsize 200   549.94   0.62%   1221.32  6.71%   122.08%
    File Copy 256 bufsize 500    339.62   2.20%    896.58  6.57%   164.00%
    File Copy 4096 bufsize 800  1173.68   1.88%   2089.7   5.20%    78.05%
         Pipe Throughput       52122.26   0.18%  53842.72  0.15%     3.30%
    Pipe-based Context Switchi 18340.38   0.92%  19874.66  0.80%     8.37%
         Process Creation       2325.12   0.18%   2178.16  0.21%    -6.32%
    Shell Scripts (1 concurren  7414.32   0.29%   8458.5   0.10%    14.08%
    Shell Scripts (16 concurre                                   =20
    Shell Scripts (8 concurren  7156.48   0.10%   8132.42  0.14%    13.64%
       System Call Overhead     1476.9    0.14%   1574.32  0.09%     6.60%
    System Benchmarks Index Sc  2982.64   0.33%   4008.66  0.94%    34.40%
   =20
    fxmark                Zhaoxin KH40000 32 cores, run on ssd (ssd, ext4)
    parallel cores              32                           24
              6.6.28  vs   6.6.28-osq-dynamic  6.6.28 vs 6.6.28-osq-dynamic
    item  Improve      Average,CV:Average,CV         Improv      CV:CV
    DWAL  -0.17% (  455895, 0.14%:  455115, 0.37%)   -0.07% ( 0.42%: 0.44%)
    DWOL   1.10% (32166648, 2.64%:32521877, 2.06%)   -0.68% ( 2.54%: 3.04%)
    DWOM  51.63% (  496955, 4.34%:  753509, 8.32%)   45.93% ( 3.14%: 2.57%)
    DWSL   1.67% (   20229, 2.34%:   20566, 3.18%)   -1.74% ( 1.96%: 2.66%)
    MWRL  71.00% (  348097, 0.92%:  595241, 1.26%)   65.95% ( 0.65%: 2.27%)
    MWRM  63.06% (    6750, 3.33%:   11007, 4.31%)   60.18% ( 5.67%: 4.81%)
    MWCL  16.99% (  149628, 1.66%:  175054, 0.82%)   16.96% ( 2.57%: 0.51%)
    MWCM  80.97% (    9448, 4.66%:   17098, 0.96%)   73.79% ( 5.37%: 1.79%)
    MWUM  37.73% (   16858, 3.13%:   23220, 3.42%)   31.16% ( 3.59%: 1.62%)
    MWUL  12.83% (   45275, 3.90%:   51083, 3.25%)   19.94% ( 4.19%: 1.98%)
    DWTL  41.44% (   85255, 5.01%:  120583, 9.83%)   45.07% ( 6.42%: 6.11%)
    MRPL  -2.63% (11448731, 1.91%:11147179, 4.18%)   -0.56% ( 1.65%: 3.33%)
    MRPM   0.29% ( 5423233, 1.77%: 5438929, 2.59%)  -10.54% (15.85%:16.42%)
    MRPH  -0.49% (  688629, 2.84%:  685266, 2.88%)  -18.99% (15.00%:24.98%)
    MRDM   8.42% ( 3662627, 0.76%: 3971133, 0.45%)    4.53% ( 1.77%: 1.72%)
    MRDL   6.25% (  530518, 2.75%:  563671, 5.33%)   12.43% (25.88%:26.91%)
    DRBH   7.16% (  388144, 7.88%:  415933,17.87%)  -20.61% (29.12%:21.91%)
    DRBM  -4.34% (  381710, 5.51%:  365159, 3.15%)  -16.93% (27.15%:29.85%)
    DRBL  -0.17% (46227341, 2.50%:46147935, 2.89%)   -4.03% ( 4.01%: 5.30%)
   =20
    fxmark      Zhaoxin KH40000 32 cores, run on ssd (ssd, ext4)
    parallel cores      2                        1        =20
    	6.6.28 vs 6.6.28-osq-dynamic  6.6.28 vs 6.6.28-osq-dynamic
    item     Improve    CV:CV          Improve    CV: CV
    DWAL     1.78%  (0.31%:0.20%)      6.36%  (2.52%: 0.67%)
    DWOL     2.46%  (2.26%:2.53%)      1.83%  (2.69%: 3.07%)
    DWOM     2.70%  (2.58%:3.12%)      2.22%  (2.67%: 3.79%)
    DWSL     3.28%  (2.90%:3.38%)      4.41%  (1.32%: 1.36%)
    MWRL    -0.76%  (1.46%:1.94%)     -0.82%  (2.04%: 2.32%)
    MWRM     1.94%  (4.38%:0.89%)     -2.05%  (4.07%: 5.16%)
    MWCL    -0.07%  (1.36%:3.84%)     -2.17%  (1.58%: 3.04%)
    MWCM     1.85%  (2.95%:4.68%)      0.28%  (0.45%: 2.48%)
    MWUM    -2.85%  (1.48%:2.01%)     -3.06%  (1.47%: 1.97%)
    MWUL    -1.46%  (0.58%:2.27%)     -2.98%  (0.71%: 2.11%)
    DWTL     0.40%  (3.89%:4.35%)     -2.68%  (4.04%: 3.15%)
    MRPL     3.11%  (1.38%:0.35%)     -4.81%  (0.32%:16.52%)
    MRPM     2.99%  (0.29%:1.19%)      3.50%  (0.56%: 0.78%)
    MRPH     3.01%  (1.10%:1.42%)      5.06%  (1.18%: 1.73%)
    MRDM    -1.67%  (4.59%:5.58%)     -3.30%  (0.23%: 8.01%)
    MRDL     1.94%  (1.56%:4.39%)     -0.55%  (0.88%: 9.57%)
    DRBH     7.24%  (7.07%:7.10%)      3.36%  (3.30%: 2.95%)
    DRBM     4.40%  (5.11%:0.74%)     -2.55%  (0.46%: 3.28%)
    DRBL     5.50%  (5.58%:0.30%)     -1.00%  (0.71%: 5.21%)
   =20
    (some tests has more than 10% loss, CV is also more than 10%,
    the result is not stable)
   =20
    perf bench    AMD EPYC 7551 32-core, 2 sockets
    kernel     6.6.28          6.6.28-osq-dynamic
    epoll  Average  CV       Average  CV    Improve
    ADD     15258  2.30%      62160  2.40%  307.38%
    WAIT     3861  4.20%       6990 16.77%   81.03%
   =20
    locktortue            AMD EPYC 7551 32-core, 2 sockets
    kernel                 6.6.28            6.6.28-osq-dynamic
    lock torture        Average   CV     Average      CV    Improve
    mutex_lock Writes  10435064  3.14%   22627890   4.92%   116.84%
   =20
    unixbench     AMD EPYC 7551 32-core, 2 sockets. run on ramdisk
    64 copys                          6.6.28        6.6.28-osq-dynamic
    System Benchmarks Partial   Average   CV      Average   CV   Improve
         Execl Throughput       2677.18  0.90%    3451.76  0.22%  28.93%
    File Copy 1024 bufsize 200   815.2   0.59%    1999.54  0.36% 145.28%
    File Copy 256 bufsize 500    504.6   0.69%    1359.6   0.49% 169.44%
    File Copy 4096 bufsize 800  1842.76  1.24%    3236.48  1.40%  75.63%
         Pipe Throughput       57748.74  0.01%   57539.6   0.03%  -0.36%
    Pipe-based Context Switchi 20882.18  0.57%   20525.38  0.57%  -1.71%
         Process Creation       4523.98  0.20%    4784.98  0.10%   5.77%
    Shell Scripts (1 concurren 13136.54  0.06%   15883.6   0.35%  20.91%
    Shell Scripts (16 concurre                                  =20
    Shell Scripts (8 concurren 12883.82  0.14%   15640.32  0.20%  21.40%
       System Call Overhead     3533.74  0.04%    3544.16  0.02%   0.29%
    System Benchmarks Index Sc  4809.38  0.23%    6575.44  0.14%  36.72%
   =20
    fxmark  AMD EPYC 7551 32-core, 2 sockets. run on ramdisk (mem,tmpfs)
    parallel cores         64                                32
                6.6.28 vs 6.6.28-osq-dynamic   6.6.28 vs 6.6.28-osq-dynamic
    item  Improve   Average,   CV :  Average,   CV    Improve  CV  :   CV
    DWAL  -0.22% ( 24091112, 0.31%: 24038426, 0.52%)  -0.26% (0.10%: 0.12%)
    DWOL   2.21% ( 86569869, 0.36%: 88479947, 0.27%)   1.99% (0.41%: 0.29%)
    DWOM 210.41% (   425986, 0.77%:  1322320, 0.28%) 128.86% (0.59%: 0.46%)
    DWSL   1.27% ( 70260252, 0.39%: 71149334, 0.37%)   1.19% (0.31%: 0.22%)
    MWRL   0.85% (   489865, 0.22%:   494045, 0.25%)   2.29% (0.12%: 0.33%)
    MWRM  96.28% (   149042, 0.45%:   292540, 3.55%)  60.10% (2.49%: 0.38%)
    MWCL  -5.44% (   772582, 2.92%:   730585, 0.80%)   0.32% (2.41%: 2.56%)
    MWCM  53.89% (   153857, 1.92%:   236774, 0.46%)  23.84% (0.72%: 0.50%)
    MWUM  88.20% (   214551, 3.90%:   403790, 0.41%)  62.81% (0.80%: 1.12%)
    MWUL  -8.26% (   970810, 1.63%:   890615, 1.63%)  -6.73% (3.01%: 1.61%)
    DWTL   5.90% (  5522297, 0.49%:  5847951, 0.18%)   5.03% (0.44%: 0.08%)
    MRPL  -1.10% ( 39707577, 0.07%: 39268812, 0.03%)  -1.30% (0.18%: 0.07%)
    MRPM  -0.63% ( 16446350, 0.47%: 16341936, 0.40%)   0.45% (0.15%: 0.45%)
    MRPH  -0.03% (  3805484, 0.50%:  3804248, 0.12%)   3.02% (1.54%: 0.36%)
    MRDM  49.41% ( 20178742, 1.89%: 30148449, 1.01%)  17.58% (1.19%: 0.85%)
    MRDL  -1.95% (227253170, 0.48%:222825409, 1.34%)  -1.80% (0.32%: 0.54%)
    DRBH   6.01% (  1045587, 1.91%:  1108467, 0.64%)   0.12% (0.13%: 0.30%)
    DRBM   0.65% (117702744, 0.31%:118473408, 0.87%)   1.12% (0.25%: 1.18%)
    DRBL   0.93% (121770444, 0.42%:122905957, 0.25%)   1.59% (0.31%: 0.40%)
   =20
    fxmark  AMD EPYC 7551 32-core, 2 sockets. run on ramdisk (mem,tmpfs)
    parallel cores      2                        1        =20
    	6.6.28 vs 6.6.28-osq-dynamic  6.6.28 vs 6.6.28-osq-dynamic
    item     Improve    CV :  CV           Improve    CV :  CV
    DWAL    -0.74%   (0.33%:  0.19%)      -1.02%   (0.19%:  0.34%)
    DWOL     1.50%   (0.36%:  0.44%)       1.89%   (0.30%:  0.36%)
    DWOM    -2.00%   (0.73%:  0.38%)       2.43%   (0.35%:  0.29%)
    DWSL     1.03%   (0.34%:  0.54%)       1.18%   (0.46%:  0.61%)
    MWRL     0.93%   (0.39%:  0.18%)       2.25%   (1.28%:  1.78%)
    MWRM    -0.30%   (0.60%:  0.47%)       0.17%   (0.58%:  0.47%)
    MWCL    -1.28%   (0.41%:  0.66%)      -0.38%   (0.19%:  0.44%)
    MWCM    -1.23%   (0.36%:  0.23%)      -1.42%   (0.41%:  0.54%)
    MWUM    -2.28%   (0.57%:  0.75%)      -1.11%   (0.82%:  0.21%)
    MWUL    -1.87%   (0.64%:  0.50%)      -1.75%   (0.58%:  0.65%)
    DWTL     0.36%   (0.09%:  0.12%)       0.19%   (0.09%:  0.09%)
    MRPL    -1.45%   (0.37%:  0.31%)      -1.35%   (0.12%:  0.54%)
    MRPM    -0.58%   (0.30%:  0.11%)      -1.04%   (0.18%:  0.31%)
    MRPH     0.79%   (3.92%:  0.48%)      -0.53%   (0.68%:  0.33%)
    MRDM    -0.55%   (0.93%:  0.44%)      -0.13%   (0.43%:  0.67%)
    MRDL    -0.11%   (0.56%:  0.19%)       0.68%   (0.71%:  0.49%)
    DRBH     0.09%   (1.31%:  0.87%)       2.75%   (0.68%:  0.45%)
    DRBM     1.09%   (0.19%:  1.05%)       1.60%   (0.15%:  0.72%)
    DRBL     3.26%   (1.00%:  0.56%)       2.34%   (0.36%:  0.23%)

    From the test result, when heavy contention, the performance of
    dynamic numa-aware lock is better than the performance of in-box
    osq_lock. If not too many processes apply a lock, the performance
    is nearly the same as the in-box osq_lock.

yongli-oc (4):
  locking/osq_lock: The Kconfig for dynamic numa-aware osq lock.
  locking/osq_lock: Turn to dynamic switch function from
    osq_lock/unlock.
  locking/osq_lock: From x_osq_lock/unlock to numa-aware lock/unlock.
  locking/osq_lock: The numa-aware lock memory prepare, assign and
    cleanup.

 include/linux/osq_lock.h     |  33 ++-
 kernel/Kconfig.numalocks     |  17 ++
 kernel/locking/Makefile      |   1 +
 kernel/locking/numa.h        |  98 +++++++
 kernel/locking/numa_osq.h    |  32 +++
 kernel/locking/osq_lock.c    |  62 +++-
 kernel/locking/x_osq_lock.c  | 332 ++++++++++++++++++++++
 kernel/locking/zx_numa.c     | 537 +++++++++++++++++++++++++++++++++++
 kernel/locking/zx_numa_osq.c | 433 ++++++++++++++++++++++++++++
 lib/Kconfig.debug            |   2 +
 10 files changed, 1543 insertions(+), 4 deletions(-)
 create mode 100644 kernel/Kconfig.numalocks
 create mode 100644 kernel/locking/numa.h
 create mode 100644 kernel/locking/numa_osq.h
 create mode 100644 kernel/locking/x_osq_lock.c
 create mode 100644 kernel/locking/zx_numa.c
 create mode 100644 kernel/locking/zx_numa_osq.c

--=20
2.34.1


