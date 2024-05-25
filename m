Return-Path: <linux-kernel+bounces-189469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11918CF06E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 19:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43801C20B06
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A0286AFA;
	Sat, 25 May 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="D8oQJEZF"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434638382
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716657780; cv=none; b=EvWGpDZfGKfuhbS9cJRqOPALf2mWdMOk9qkvVLI061AJ+RrBrfg2rNCwp5I+iiz7M1g3SiyUpiIgooG5hY57scVGYoOZDvfrvTT+Yg8HkaWdt1tMUM2yGyIbgHxeIdMryxCAsHOoAOA3mafysH2TwmUTm2KEpMRSKwl2U7fwrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716657780; c=relaxed/simple;
	bh=69tVgNNeIFwMzcmMHAEaMzMHWunmsOF2G/tFRuzD9kI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHuz4sMbjmkp8woOIp50+Fnh9WJpMIXZrVoovBsvD1xnGEgeMH7VIJ/0dxue9QnXTOgV0g5O6zfs6hSQ2/61B5g0jqkc60WIajs6hk85XFyFmQNwtuwjuCFI5C88PlW3j76HB1RjDf7o0nbmZWaiyvxIweYsbyFJ2liQ4JpDPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=D8oQJEZF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716657741; x=1717262541; i=efault@gmx.de;
	bh=oqMdMA0qsPXV+eomnPeTtl+iY8AaeNtZYZNMkSbkSa0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D8oQJEZF0QJZukzMeehxXt+OdKo2CH1TRyIitfLjI1UrmFOjwn52klf8+XXkorwH
	 hNfol1gU1+l38AhCSDblGYqkEStl9N+ZkbDPnwj91ZUvyP3tP1F0F8LHjO7xBKumj
	 vQDsgt2zlXUqFSv4gYvpPuWbGpAwAMhwBeSXEZOhhS0YQwM6XkGZxTgwz4ICrq63r
	 1qOMOjU2SiznetnfLP+rRBi7WwdzcDJW4EmU+rzXAMUGIxK7VZLR+Ut79wUKsJyi9
	 hzbFJfk6+1MXICc4ycxFZ0cvscTW+VvdCllLqhLE229YOpasoyNMsGz/bZigdiMKp
	 rw7Gh5aoHzTxO0AZOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.78]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1s0Xcw3bbC-00Vhs7; Sat, 25
 May 2024 19:22:20 +0200
Message-ID: <ebeb6f24ebf5da4e260017b3c16d1b73f7a7c5e1.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
From: Mike Galbraith <efault@gmx.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Chunxin Zang <spring.cxz@gmail.com>, mingo@redhat.com,
 peterz@infradead.org,  juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org, yangchen11@lixiang.com, 
 zhouchunhua@lixiang.com, zangchunxin@lixiang.com
Date: Sat, 25 May 2024 19:22:16 +0200
In-Reply-To: <ZlHSNXe0c5/sx9D9@chenyu5-mobl2>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
	 <e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de>
	 <ZlHSNXe0c5/sx9D9@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K+/qgPWgOVxlcBdT2W5Ixznm/FDulhr1k6KFIMeyGNg9zg6pOhG
 jptJhPYQg/xbQKSyVDFFw5idn0s4WtLMCNghLaSLR0GMJJ47F/DvulihxTM2819ls4qRSIk
 Vr/9h9hckBYaIogHxiov8T8pyuhWQEhgW5ktMaLqkyODv4uJfDIGVM9PFy4WphlMq1DNBQJ
 Q2tZ+dxFP7gF3dONN2IMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cpz0dRF79Sg=;Wq6tN5QX2j6AMFgepn6E1Ptp3XW
 DycXkJZwQboSTYX54l7wjVaNoaTqiMCHRJEP5RU+DUM2SxHoPq4qDC+WQ0bmU4lsZMsr4jXX/
 NmBnIrqCNEB2xAGbqabWuSKle1j2+iUlgZVx5hI2GsyQFxkXxt2oSaLeTCZbGYMU5xWKqEX0u
 3ZyAWZw6fLJwljY5FbA8sPZ+VY0/J2CFqdwVn2piMLZC/VRhc7VwF5tXwZDxXkIxEROdfyNIO
 V43BRLQE2FdpwnHIO50Qd/7eoxxrf6uvmRxMYG3ahisHSdTQCIyRt6NF3ueUJH8rKiNArIGJf
 8uUjlBVXavXEFaHtnf9OThqs3xyFS04vDmoDLRhwUHdl3v5JazHwjjTpXsQhA0KRNX36XHWFA
 mgCuNzoDw4Yv+uLD32ORVJpyJCan/Pke9NLP3tXXBufqcjMg/q/jimVyjuvIiDFblPyGYBzHU
 IRa782OEJmtvIMASTW7LBcWWgEeQqYGlrFCVNL7TCI4LgHWRLMrBF1PdVll5WftQpcwbUW8jn
 D4xHpoxsyfKKR/YEOAOR8Rf417uzRS4jQVfT/R9xojfh9kQEJLHieqG8v8M7i0qK9zEaYq36l
 QBN7vK6nHfNs5x2yyljIOS1a+ELzVdA2fa5b+U8eHXjObcXKHBOCXgDmXNodBEBo/dzr6lzci
 xj4eHFG4wQsBFlUPgYkABiTcfqJFovJWqveAyXFITnWmssBJZzXQEiEXTh8ASeJjwLUxlPu8F
 SQytRhLyMYGGG4lMqJ7/MPZMEtmtI0C7nZ3jhN6posxaVP/bVPZaiQiR/BTOHEvqSm+iFjilr
 385iszhqJIxNuTFRNbs64lt65VxjluOLffwrkO/jHpj+0=

On Sat, 2024-05-25 at 19:57 +0800, Chen Yu wrote:
>
> I suppose this change benefits the overloaded scenario:
> neither current nor the wakee is the best one.

Depends on your definition of benefit. It'll increasing ctx switches a
bit, but I recall it not being much.

I dug up the script I was using at the time, numbers below for the
bored.  Bottom line: yeah, it's not much of a delta, especially when
comparing allegedly current EEVDF to CFS in an otherwise identical..
absolutely everything.

load: 5m chrome playing 1080p clip vs massive_intr (1 88% hog/cpu)

6.1.91-cfs
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(9)      |1897454.685 ms | 11581161 | avg:   0.026 ms | max=
:  43.008 ms | sum:296184.363 ms |
  dav1d-worker:(8)      |  94252.513 ms |   396284 | avg:   0.089 ms | max=
:  12.513 ms | sum:35275.546 ms |
  Compositor:5824       |  36851.590 ms |    61771 | avg:   0.080 ms | max=
:   9.310 ms | sum: 4965.456 ms |
  X:2362                |  32306.450 ms |   102571 | avg:   0.021 ms | max=
:  14.967 ms | sum: 2148.121 ms |
  VizCompositorTh:5913  |  25116.956 ms |    56602 | avg:   0.053 ms | max=
:   8.441 ms | sum: 2986.101 ms |
  chrome:(8)            |  23134.386 ms |    85335 | avg:   0.052 ms | max=
:  34.540 ms | sum: 4459.871 ms |
  ThreadPoolForeg:(43)  |  16742.353 ms |    71410 | avg:   0.083 ms | max=
:  23.059 ms | sum: 5943.056 ms |
  kwin_x11:2776         |  11383.572 ms |    95643 | avg:   0.017 ms | max=
:   8.358 ms | sum: 1589.414 ms |
  VideoFrameCompo:5919  |   9589.949 ms |    37838 | avg:   0.029 ms | max=
:   6.842 ms | sum: 1098.123 ms |
  kworker/5:1+eve:4508  |   8743.004 ms |  1647598 | avg:   0.003 ms | max=
:  12.002 ms | sum: 4956.587 ms |
  kworker/6:2-mm_:5407  |   8686.689 ms |  1636766 | avg:   0.003 ms | max=
:  10.407 ms | sum: 4779.475 ms |
  kworker/2:0-mm_:5707  |   8536.257 ms |  1607213 | avg:   0.003 ms | max=
:   9.473 ms | sum: 4776.918 ms |
  kworker/4:1-mm_:379   |   8532.410 ms |  1603438 | avg:   0.003 ms | max=
:  10.328 ms | sum: 4824.572 ms |
  kworker/1:0-eve:5409  |   8508.321 ms |  1598742 | avg:   0.003 ms | max=
:  13.124 ms | sum: 4742.128 ms |
  perf:(2)              |   5386.613 ms |      713 | avg:   0.020 ms | max=
:   2.268 ms | sum:   13.985 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2242804.984 ms | 26015202 |                 |    =
   43.008 ms |    416326.240 ms |
 -------------------------------------------------------------------------=
---------------------------------

6.1.91-eevdf
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(9)      |1971557.115 ms |  6127207 | avg:   0.034 ms | max=
:  16.351 ms | sum:208289.732 ms |
  dav1d-worker:(8)      |  85561.180 ms |   499175 | avg:   0.262 ms | max=
:  15.656 ms | sum:130584.659 ms |
  Compositor:4346       |  37730.564 ms |   200925 | avg:   0.112 ms | max=
:  10.922 ms | sum:22406.729 ms |
  X:2379                |  31761.636 ms |   229381 | avg:   0.081 ms | max=
:   9.740 ms | sum:18645.752 ms |
  VizCompositorTh:4423  |  24650.743 ms |   155138 | avg:   0.170 ms | max=
:  11.227 ms | sum:26426.655 ms |
  chrome:(8)            |  19551.099 ms |   156680 | avg:   0.201 ms | max=
:  18.183 ms | sum:31449.401 ms |
  ThreadPoolForeg:(43)  |  15547.777 ms |    89292 | avg:   0.223 ms | max=
:  20.007 ms | sum:19916.046 ms |
  kwin_x11:2776         |  11052.045 ms |   119945 | avg:   0.122 ms | max=
:  12.757 ms | sum:14687.478 ms |
  VideoFrameCompo:4429  |   8794.874 ms |    76728 | avg:   0.142 ms | max=
:  10.183 ms | sum:10895.692 ms |
  Chrome_ChildIOT:(7)   |   4917.764 ms |   165906 | avg:   0.190 ms | max=
:  10.212 ms | sum:31461.521 ms |
  Media:4428            |   3787.952 ms |    65288 | avg:   0.194 ms | max=
:  12.048 ms | sum:12662.386 ms |
  kworker/6:1-eve:135   |   3359.276 ms |   616547 | avg:   0.009 ms | max=
:   7.999 ms | sum: 5762.212 ms |
  kworker/4:1-eve:365   |   3144.292 ms |   578287 | avg:   0.009 ms | max=
:   7.619 ms | sum: 5322.637 ms |
  kworker/3:2-eve:297   |   3104.034 ms |   557150 | avg:   0.013 ms | max=
:   8.006 ms | sum: 7050.461 ms |
  perf:(2)              |   3098.480 ms |     1585 | avg:   0.102 ms | max=
:   5.470 ms | sum:  160.995 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2271694.585 ms | 16259483 |                 |    =
   32.144 ms |    669428.151 ms |
 -------------------------------------------------------------------------=
---------------------------------

+tweak
=2D-----------------------------------------------------------------------=
----------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(9)      |1965603.161 ms |  6284089 | avg:   0.034 ms | max=
:  16.005 ms | sum:214120.602 ms |
  dav1d-worker:(8)      |  89853.413 ms |   599733 | avg:   0.240 ms | max=
:  48.387 ms | sum:144117.080 ms |
  Compositor:4342       |  36473.771 ms |   171986 | avg:   0.129 ms | max=
:  11.366 ms | sum:22135.405 ms |
  X:2365                |  32167.915 ms |   218157 | avg:   0.088 ms | max=
:   9.841 ms | sum:19105.816 ms |
  VizCompositorTh:4425  |  24338.749 ms |   151884 | avg:   0.181 ms | max=
:  11.755 ms | sum:27553.783 ms |
  chrome:(8)            |  20154.023 ms |   158554 | avg:   0.207 ms | max=
:  15.979 ms | sum:32742.291 ms |
  ThreadPoolForeg:(45)  |  15672.931 ms |    94051 | avg:   0.215 ms | max=
:  17.452 ms | sum:20185.561 ms |
  kwin_x11:2773         |  11424.789 ms |   121491 | avg:   0.140 ms | max=
:  11.116 ms | sum:16958.020 ms |
  VideoFrameCompo:4431  |   8869.431 ms |    82385 | avg:   0.139 ms | max=
:  10.906 ms | sum:11471.193 ms |
  Chrome_ChildIOT:(7)   |   5148.973 ms |   167824 | avg:   0.189 ms | max=
:  13.755 ms | sum:31640.759 ms |
  kworker/7:1-eve:86    |   4258.124 ms |   784269 | avg:   0.009 ms | max=
:   8.228 ms | sum: 6780.999 ms |
  Media:4430            |   3897.705 ms |    62985 | avg:   0.205 ms | max=
:  10.797 ms | sum:12904.412 ms |
  kworker/6:1-eve:189   |   3608.493 ms |   663349 | avg:   0.009 ms | max=
:   7.902 ms | sum: 6034.231 ms |
  kworker/5:2-eve:827   |   3309.865 ms |   611424 | avg:   0.009 ms | max=
:   7.112 ms | sum: 5552.591 ms |
  perf:(2)              |   3241.897 ms |     1847 | avg:   0.087 ms | max=
:   5.464 ms | sum:  160.383 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2272683.607 ms | 16721925 |                 |    =
   57.181 ms |    692810.431 ms |
 -------------------------------------------------------------------------=
---------------------------------
                                          hohum
+peterz queue w. RUN_TO_PARITY
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(9)      |1972481.970 ms |  4989513 | avg:   0.042 ms | max=
:  20.019 ms | sum:208651.087 ms |
  dav1d-worker:(8)      |  85235.372 ms |   528422 | avg:   0.254 ms | max=
:  15.253 ms | sum:134274.493 ms |
  Compositor:4343       |  36977.626 ms |   154214 | avg:   0.122 ms | max=
:   9.868 ms | sum:18854.543 ms |
  X:2359                |  31873.877 ms |   187392 | avg:   0.094 ms | max=
:  10.100 ms | sum:17644.947 ms |
  VizCompositorTh:4427  |  24881.223 ms |   120412 | avg:   0.176 ms | max=
:  14.813 ms | sum:21210.898 ms |
  chrome:(8)            |  21579.151 ms |   133086 | avg:   0.200 ms | max=
:  12.952 ms | sum:26600.419 ms |
  ThreadPoolForeg:(45)  |  15327.978 ms |    94395 | avg:   0.196 ms | max=
:  35.000 ms | sum:18547.639 ms |
  kwin_x11:2776         |  11232.090 ms |   121392 | avg:   0.135 ms | max=
:  10.313 ms | sum:16426.213 ms |
  VideoFrameCompo:4433  |   8858.806 ms |    65658 | avg:   0.144 ms | max=
:  11.409 ms | sum: 9485.191 ms |
  Chrome_ChildIOT:(7)   |   4970.611 ms |   172570 | avg:   0.142 ms | max=
:  11.008 ms | sum:24467.160 ms |
  Media:4432            |   3781.277 ms |    63640 | avg:   0.162 ms | max=
:  10.096 ms | sum:10283.264 ms |
  kworker/7:1-eve:91    |   2930.823 ms |   534857 | avg:   0.009 ms | max=
:   8.234 ms | sum: 4723.577 ms |
  kworker/6:2-eve:356   |   2579.393 ms |   472864 | avg:   0.009 ms | max=
:   8.046 ms | sum: 4148.828 ms |
  perf:(2)              |   2569.531 ms |     1609 | avg:   0.101 ms | max=
:   5.966 ms | sum:  163.224 ms |
  kworker/4:0-eve:40    |   2432.133 ms |   442300 | avg:   0.009 ms | max=
:   9.475 ms | sum: 3992.979 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2263072.188 ms | 12993836 |                 |    =
   35.000 ms |    601609.374 ms |
 -------------------------------------------------------------------------=
---------------------------------
                                          marko?
+NO_DELAY_DEQUEUE
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(9)      |1968212.427 ms |  6050894 | avg:   0.035 ms | max=
:  20.032 ms | sum:213163.997 ms |
  dav1d-worker:(8)      |  86929.255 ms |   583692 | avg:   0.246 ms | max=
:  14.986 ms | sum:143561.571 ms |
  Compositor:4933       |  36733.711 ms |   219265 | avg:   0.100 ms | max=
:  14.986 ms | sum:21888.378 ms |
  X:2359                |  31624.338 ms |   233581 | avg:   0.074 ms | max=
:   8.629 ms | sum:17324.762 ms |
  VizCompositorTh:5018  |  24597.941 ms |   179049 | avg:   0.147 ms | max=
:  11.717 ms | sum:26333.576 ms |
  chrome:(8)            |  20430.046 ms |   179393 | avg:   0.173 ms | max=
:  20.903 ms | sum:30976.208 ms |
  ThreadPoolForeg:(39)  |  15423.142 ms |   109837 | avg:   0.183 ms | max=
:  24.525 ms | sum:20115.906 ms |
  kwin_x11:2776         |  11413.866 ms |   129426 | avg:   0.121 ms | max=
:  10.718 ms | sum:15719.900 ms |
  VideoFrameCompo:5023  |   8817.956 ms |    78028 | avg:   0.130 ms | max=
:  18.471 ms | sum:10162.602 ms |
  Chrome_ChildIOT:(7)   |   5356.461 ms |   187001 | avg:   0.160 ms | max=
:  11.565 ms | sum:29969.033 ms |
  Media:5022            |   3793.341 ms |    64887 | avg:   0.186 ms | max=
:  13.229 ms | sum:12096.948 ms |
  kworker/6:0-eve:5052  |   3509.228 ms |   643562 | avg:   0.010 ms | max=
:   8.005 ms | sum: 6305.605 ms |
  kworker/3:0-eve:34    |   3363.538 ms |   598417 | avg:   0.012 ms | max=
:   8.892 ms | sum: 6910.297 ms |
  perf:(2)              |   3167.463 ms |     1835 | avg:   0.090 ms | max=
:   5.039 ms | sum:  164.352 ms |
  kworker/4:2+eve:4808  |   3002.682 ms |   549210 | avg:   0.010 ms | max=
:   8.622 ms | sum: 5400.444 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2270484.307 ms | 16315986 |                 |    =
   24.525 ms |    677870.230 ms |
 -------------------------------------------------------------------------=
---------------------------------
                                          polo


