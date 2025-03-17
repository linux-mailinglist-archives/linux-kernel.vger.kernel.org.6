Return-Path: <linux-kernel+bounces-563410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFFA64148
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06ABB3B0416
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25E121507F;
	Mon, 17 Mar 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s1Tcbf7t"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881574A32
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192450; cv=none; b=agljJE53f1w7poPp95QcdN1D6MyGfpkqiOQPeuIshASEH8eu12kMCbz2zD1PxyrU5z8Vaw1qbC08LyoZvN/N1fSxkA8XPq9xR07hoNK3n3Mdk2n0y1VtRvUbeaJEkNfJlzZ/GyIIfKo9K79XwmWYSHMPYhtP1hJ0kaUmkJwEz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192450; c=relaxed/simple;
	bh=JRyZKawA0aAsK8Oo981UPA6+/X9Ck0CBKhRKAyNUJQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLFKXjr5h1IZ9bUhs6EvvrpaLTDIe/YIF75/AhX0ENrtEY2d00wUYXUOTczjN9nGEYL04Dj7TBQU1b1aoDaEEgb4ZxOrhC6Gz1iWnYoE+7Uh0XNSyVlGokFJ5oxdPnVw2iOUaMroTVh4gM9dkOCaO4HNyHn0fkmMGCjGMKAM91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s1Tcbf7t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GLPePD024930;
	Mon, 17 Mar 2025 06:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JdEjos/va6rFaDe+G/TZDgQOrVVQS+
	waWzJf/gsY33k=; b=s1Tcbf7tGooDuxbO65ONUpeTrJQrqgEBccRT3ps3VrsqB0
	PyGLQQCNrvSA5qdn3sFeb5ZAPreiBdWapqaEF4g48hc59zRwcmLJJwjjUD5H2Kc1
	r+GFoEgO9B4EqMNMiE/++YfpY9jHzZ0YEPeJ1AQtMODa3A9gj56I3naMzTw1mOcR
	lIfqoQPJMSo7Qz1RUvWxCdDZYWD27d3L1jYwcxREzGUufCVUosxtgi3j2/Xh022A
	5u8StiuRRf2yw5kJ1jDi7uBkY4F+h/AUtdzTJWWbJ/pBPpk4o4r3ZLr2F3r9hvwA
	x5PP5uAuUtw8y0CbOJf/6dX9iEWdMveFINXDFLcg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e02ntn3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:20:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52H6KN5j020264;
	Mon, 17 Mar 2025 06:20:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e02ntn3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:20:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H3Vqm0031974;
	Mon, 17 Mar 2025 06:20:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvt4whk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 06:20:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52H6KLgs57606500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 06:20:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFCD520043;
	Mon, 17 Mar 2025 06:20:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1DE20040;
	Mon, 17 Mar 2025 06:20:20 +0000 (GMT)
Received: from localhost (unknown [9.43.19.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 06:20:20 +0000 (GMT)
Date: Mon, 17 Mar 2025 11:50:19 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Benjamin Segall <bsegall@google.com>,
        Eric Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 14/18] posix-timers: Avoid false cacheline sharing
Message-ID: <od57wrws3tmcwuyi3rkbgoysg73vdtq6czstwbq4zjr6qrd6ns@zpwvqdiyfvfp>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.341108067@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308155624.341108067@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O7OCMfUbZo8wZ_VERP6zw_u3k3AT2XTd
X-Proofpoint-GUID: d7RfmXC_Z-y04g99467QgI9qRUnPs7NR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_01,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 adultscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170042

On Sat, Mar 08, 2025 at 05:48:42PM +0100, Thomas Gleixner wrote:
> ---
> V2: New patch
> ---
>  include/linux/posix-timers.h |   21 ++++++++++++---------
>  kernel/time/posix-timers.c   |    4 ++--
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -177,23 +177,26 @@ static inline void posix_cputimers_init_
>   * @rcu:		RCU head for freeing the timer.
>   */
>  struct k_itimer {
> -	struct hlist_node	list;
> -	struct hlist_node	ignored_list;
> +	/* 1st cacheline contains read-mostly fields */
>  	struct hlist_node	t_hash;
> -	spinlock_t		it_lock;
> -	const struct k_clock	*kclock;
> -	clockid_t		it_clock;
> +	struct hlist_node	list;
>  	timer_t			it_id;
> +	clockid_t		it_clock;
> +	int			it_sigev_notify;
> +	enum pid_type		it_pid_type;
> +	struct signal_struct	*it_signal;
> +	const struct k_clock	*kclock;
> +
> +	/* 2nd cacheline and above contain fields which are modified regularly */

On architectures like powerpc where cache line size is 128 bytes, we might still
run into false sharing. Perhaps rearranging it towards the end of the struct might
help avoid it? Is the benchmark code public? I can collect perf c2c data on powerpc.

> +	spinlock_t		it_lock;
>  	int			it_status;
>  	bool			it_sig_periodic;
>  	s64			it_overrun;
>  	s64			it_overrun_last;
>  	unsigned int		it_signal_seq;
>  	unsigned int		it_sigqueue_seq;
> -	int			it_sigev_notify;
> -	enum pid_type		it_pid_type;
>  	ktime_t			it_interval;
> -	struct signal_struct	*it_signal;
> +	struct hlist_node	ignored_list;
>  	union {
>  		struct pid		*it_pid;
>  		struct task_struct	*it_process;
> @@ -210,7 +213,7 @@ struct k_itimer {
>  		} alarm;
>  	} it;
>  	struct rcu_head		rcu;
> -};
> +} ____cacheline_aligned_in_smp;
>  

--Nysal

