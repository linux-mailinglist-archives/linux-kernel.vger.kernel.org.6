Return-Path: <linux-kernel+bounces-392876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D559B9923
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E5D282D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466901D2F5D;
	Fri,  1 Nov 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ieysLvMv"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A551ABEA1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491556; cv=none; b=pVsbXMkpezp1qvGsWo96DpbATaujxS0/xXX0/6M+nkFxgW50s6VNyr8ryM12Z7zn/fcnkLgsVdfPwCNxEezuUTuBjnL+rg/qkaOd2oxKlNtXfj5+Gg7PTipTxljGvb7QEI4Am5jjYzIX1fWDg7G/XkTidA0NKiXQQq5IUqigYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491556; c=relaxed/simple;
	bh=N1aJndOMAw1SjLF6jH4D6Z5XANz96QCZvNODswRk4c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZPyyed+6oczJtVNJVlMGrrCoR2gYVk/yBfvQo4lHeQexJ4GTRT8T8EmjBYPnNmyYzO/jb//3jpg6yDZGFXubedt4O0H3dCy/QtbdGE+yGK81Vdhe72ZrCiN4PlfoNY9Uxad+47FzcwAtAntnnKn7aXU8eVPeuTg6EyemCtNiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ieysLvMv; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1JWJXr010414;
	Fri, 1 Nov 2024 20:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Ko
	J4vSAK5YxnCXsmrMAKZ+F/0g5uFXr4mfTkEeM2p+k=; b=ieysLvMvvmI14bUCax
	ztFfk3ZIOdnopRqMOjlH0agRQiTZS/4FQf1FprcGJAJ6GS/8654laF1OhQ0+r+jd
	g/LvGE2HJiWuxy8eNsDAOY7IxxTkDDKUMVOlrIy1oxtWmcB/M7DnS3cuaZ16WtMP
	btwXlWwikn0OfWuX0iwHVsrG4iU/wvxkmtZjP7eqvk9dHaQiSKapJC9uHkz5iou3
	3778scx/SIPutfOt0uPn/YoNT87d7qLtaInRaKMe01kfoZpnE4wHSITuj6YeUQv7
	5I7nLFGp5SdiA4MTKmsmbvE3jUpPsmNG9talgVYkA0qrdR12vtYhLCgvKH2O3uQX
	pTOw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42n3qgru65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 20:05:33 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 20A22806B5A;
	Fri,  1 Nov 2024 20:05:32 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id E4EA7801FF5;
	Fri,  1 Nov 2024 20:05:28 +0000 (UTC)
Date: Fri, 1 Nov 2024 15:05:26 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: samir <samir@linux.ibm.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>, vishalc@linux.ibm.com,
        sshegde@linux.ibm.com, srikar@linux.ibm.com
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <ZyU0hkjeIteoThQ7@swahl-home.5wahls.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <d64234e1e2c537be9d490247295f7b36@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d64234e1e2c537be9d490247295f7b36@linux.ibm.com>
X-Proofpoint-GUID: GNqD910myT6_q5YxRVbm8WR1nnjjxwBC
X-Proofpoint-ORIG-GUID: GNqD910myT6_q5YxRVbm8WR1nnjjxwBC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 spamscore=0 mlxlogscore=826 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010143

On Tue, Oct 29, 2024 at 11:04:52PM +0530, samir wrote:
> 
> I have verified this patch on PowerPC and below are the results for "time
> ppc64_cpu —smt =off/4" mode,
> Here are the 5 iteration data for “time ppc64_cpu --smt=off/4” command(min,
> max, Average, and Std Dev).
> 
> ——————Without patch——————
> ————uname -a————
> 6.12.0-rc5
> 
> ————lscpu————
> lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   360
>   On-line CPU(s) list:    0-359
> NUMA:
>   NUMA node(s):           4
>   NUMA node0 CPU(s):      0-95
>   NUMA node1 CPU(s):      96-191
>   NUMA node2 CPU(s):      192-271
>   NUMA node3 CPU(s):      272-359
> 
> Without Patch:
> Metric	       SMT Off (s)   SMT 4 (s)
> Min	      	  68.63	      37.64
> Max	      	  74.92	      39.39
> Average	   	  70.92	      38.48
> Std Dev	    	  2.22	      0.63
> 
> 
> ——————With patch——————
> ————uname -a————
> 6.12.0-rc5-dirty
> 
> ————lscpu————
> lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   360
>   On-line CPU(s) list:    0-359
> NUMA:
>   NUMA node(s):           4
>   NUMA node0 CPU(s):      0-95
>   NUMA node1 CPU(s):      96-191
>   NUMA node2 CPU(s):      192-271
>   NUMA node3 CPU(s):      272-359
> 
> With Patch:
> Metric	    SMT Off (s)	    SMT 4 (s)
> Min 	        68.748	     33.442
> Max	        72.954	     38.042
> Average	        70.309	     36.206
> Std Dev	        1.41	     1.66
> 
> From the results it’s seen that there is no significant improvement,
> however, with the patch applied, the SMT=4 state shows a decrease in both
> average time, as reflected in the lower average (36.21s vs. 38.48s) and
> higher standard deviation (1.66s vs. 0.63s) compared to the previous without
> patch apply result.

Samir,

I found your results interesting.  So I tried to compare with our
systems, and I get similar results.  Around 300 processors, this patch
makes little difference.  At higher counts, the topology_span_sane
function change has more influence.

I don't have PPC system access, but I tried to recreate similar
results on our x86_64 systems.  I took a 8 socket, 60 core/socket, 2
thread/core system (960 CPUs), and limited it to 20 physical
cores/socket (320 CPUs) for comparison.

I'm using scripts from Intel's System Health Check,
"Set-Half-Of-The-Cores-Offline.sh" and "Set-All-Cores-Online.sh", but
similar results could be obtained with anything that manipulates
/sys/devices/system/cpu/cpu*/online.

I also found that the first offlining attempt after a reboot goes much
faster, so I threw out the first result after reboot and then measured
5 iterations.  (The reason for this probably needs exploration, but it
happens for me on both patched and unpatched versions.)

All times in seconds.  

With 20 cores / socket (320 CPUs counting hyperthreads):

Without patch:
		Half-Offline	All-Online
min		21.47		30.76
max		22.35		31.31
avg		22.04		31.124
std.dev.	0.3419795	0.2175545

With patch:
		Half-Offline	All-Online
min		20.43		28.23
max		21.93		29.76
avg		20.786		28.874
std.dev.	0.6435293	0.6366553

Not a huge difference at this level.

At 60 cores / socket (960 CPUs counting hyperthreads):

Without patch:
                Half-Offline    All-Online
min		275.34		321.47
max		288.05		331.89
avg		282.964		326.884
std.dev.	5.8835813	4.0268945

With patch:
                Half-Offline    All-Online
min		208.9		247.17
max		219.49		251.48
avg		212.392		249.394
std.dev.	4.1717586	1.6904526

Here it starts to make a difference, and as the number of CPUs goes
up, it gets worse.

I should note that I made my measurements with v2 of the patch,
recently posted.  Version 2 does remove a memory allocation, which
might have improved things.

Thanks,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

