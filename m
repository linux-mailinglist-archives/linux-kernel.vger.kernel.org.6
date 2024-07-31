Return-Path: <linux-kernel+bounces-269329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C5F94319E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D251C21761
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979231B3751;
	Wed, 31 Jul 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sm7nkbr/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CC1AB50F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434641; cv=none; b=FjcSU89MF6ipQ/Bpo8dbT8xC75bx/TfQAqGGUd8krU2mjDOR7gW/GDLDrkhz7Kh/jW4EOfBWrzaLBhivD62bIiiFyR/zPXehtQpTWFwKkMiAoMXCKUkg5v/bSzeVBNSCQnFZ9Mqk3JPBJpd7nAOFfshppnO2NGcVhrqpqq1MA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434641; c=relaxed/simple;
	bh=pENeQTdGob+2dGnkmNnBGvTjkuNtOgsfqzDdej0zWhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/FOmbz0eY8fvUvP8bMje0G6YajTRdGUfBRrjaZLdY828VUvwZtYqzz9L1HBEBbTDprFYGJutsKzBQDQUUaB1rsnowhqMgDl86W3+k1VXv5xrYCzxbw1FBJydbVgkCr63Y4T+GssAUM0hBAkywSZOKuwJLQOf7BmbL4zvZyMykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sm7nkbr/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VCWO00007982;
	Wed, 31 Jul 2024 14:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=SMQTr8uTCkOgrUgBhX9ERZ0Nj0+
	2UIphwVxmpqp82bs=; b=Sm7nkbr/Zl9CoCNYSOpy2CGZX+FYhIvN7ZjUoBXlHDT
	STizKkfZRzFkljEYjMb8KY04JmlPK41CfBeyoL+1gN5MN0Y6I4xfjBQrrRwbUp2A
	KSlJCQEqmxl4XStTbwPIEgbqDHv2RqS7tWnZA/PsnRY5Dn1AlXqBDy3yAPAKn1LY
	nBHSHGHpL1+rGRglnBnZagxJhkK9muZPNitI1GbOyyrE9Cy1399i+VKVfIZnRWW4
	giJk167k7Xx2lPSL7yBGQWXt6W8rsX79MMurMu5Ix1u63mHDWnYEjyGekvgQv5cC
	2VoOSl+7jq+B1Tp+W7jEwnToK0BFxuo5WB0D1WesRvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qnbq89xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 14:03:44 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VE3ifl011420;
	Wed, 31 Jul 2024 14:03:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qnbq89xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 14:03:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46VDlxsB009181;
	Wed, 31 Jul 2024 14:03:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx33h6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 14:03:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VE3d2521365006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 14:03:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2BA22004E;
	Wed, 31 Jul 2024 14:03:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B60A20040;
	Wed, 31 Jul 2024 14:03:37 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.43.69.217])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 31 Jul 2024 14:03:37 +0000 (GMT)
Date: Wed, 31 Jul 2024 19:33:32 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, zhangqiao22@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] sched/fair: inline cpu_util_without and
 cpu_util to improve performance
Message-ID: <f6wx4yueffde7tflj6nhws5o4hf3tlg4hwr6x5hfiyndrjfgyz@v44emi2dodbz>
References: <20240731092400.675459-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731092400.675459-1-lizetao1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BzC4G5CAukKF-ozHI8A43ZA5sn9oZhn7
X-Proofpoint-ORIG-GUID: wsgeF9Hn5IGX3VA4a1rkEd_jhemArJAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=501 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310100

On Wed, Jul 31, 2024 at 05:24:00PM GMT, Li Zetao wrote:
> The commit 3eb6d6ececca ("sched/fair: Refactor CPU utilization functions")
> refactored cpu_util_without and cpu_util functions. Since the size of
> cpu_util function has increased, the inline cpu_util is dropped. This had
> a negative impact on performance, in the scenario of updating
> sched_group's statistics, cpu_util_without and cpu_util functions are on
> the hotspot path.
> 
> Inlining cpu_util_without and cpu_util functions have been shown to
> significantly improve performance in lmbench as follow:
> 
>   Machine: Intel(R) Xeon(R) Gold 6248 CPU @ 2.50GHz
>                      before          after          diff
>   fork+exit          317.0625        303.6667       -4.22%
>   fork+execve        1482.5000       1407.0000      -5.09%
>   fork+/bin/sh       2096.0000       2020.3333      -3.61%
> 
> This patch introduces inlining to cpu_util_without and cpu_util functions.
> While this increases the size of kernel/sched/fair.o, the performance
> gains in critical workloads make this an acceptable trade-off.
> 
> Size comparison before and after patch:
>      text	   data	    bss	    dec	    hex	filename
>    0x1264a	 0x1506	   0xb0	  80896	  13c00	kernel/sched/fair.o.before
>    0x12672	 0x14fe	   0xb0	  80928	  13c20	kernel/sched/fair.o.after
> 
> Co-developed-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

I ran the same tests on lmbench on Power9 (ppc64le)

Size Comparison

        text	   data	    bss	    dec	    hex	filename
before 111311	  14943	    440	 126694	  1eee6	kernel/sched/fair.o.before
after  111679	  14903	    440	 127022	  1f02e	kernel/sched/fair.o.after

Test comparison
                    before      after     % diff
fork+exit	          698.375	    688	      -1.51%
fork+execve	        2748	      2730.5	  -0.64%
fork+/bin/sh -c	    4298	      4293.5	  -0.10%

Tested-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Reviewed-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

Thanks,
Mukesh

