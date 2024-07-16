Return-Path: <linux-kernel+bounces-253399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7B89320BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5007D1C21387
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D21CFBE;
	Tue, 16 Jul 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M7oyBmDG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517C1CD29
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112576; cv=none; b=c1vj7223J9Z3iMh2vM59SuqltKh8C1mYo//dmNzJlROmbAlbPLnpAMmNOWh6NGWoKEH6VylcwgPFJbLsdajHGDbxdurwuyf49ooJ2VDzd8bzInjmzwrgPhcj1vFdHfAuhGevKPDISBBOLJt7xldegTaEfMvivCetCFOz6QIsSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112576; c=relaxed/simple;
	bh=u6zGMe7AFn2M/uTxtJvY31jYBv0LzziLp0O1Ad6E950=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6LCgqHb5Kz271TCXX3YYJtvaa1NWA9Wuizf6sByvUM+rAQfv9yPajcLmDjo2n5HlvqIykk8U+I1HupqbswP1VF0Q+QWxUzXGz70VSS1sXMOXmIPPcS7rwrQfotvUnhGhCPdNHuGcfsGNs/1myjcvt//ri2TDwDDWUnK9Gjb1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M7oyBmDG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G6Q5Yr013934;
	Tue, 16 Jul 2024 06:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=dpCUcIAqXkW6G0o01i7UYeaiyv0
	1UMhuG5DTlzxIDoA=; b=M7oyBmDGBlVH7HR7PGTclmt3Fe+edaLE6fZmhZZ2jR+
	ZTc8yFjRYh26+iVlSS+EP4PU98GULecQC/URF1kTbX/ZuRNb7SbI40EhftZ2x/AA
	scK1ymJsBBKHydFVOM+sxQeErMuMVUFT8LBb6NQXSgxjrFttCGhTMUpGRfQ0dZoT
	0OVNN1p3pivE0wepTcFvhoMELXTevDZWP9xVqlKb7lzMPd5jYRsFCPT+B+aWdBHb
	aHrN7MFxm/9cilXzgKV9siZ9MUtjx/DxLXAez+3CTjhtbqZ38bj3loWpzO87hS2W
	sRB3rT0bO968E1P3YShajpdy/REuW1HjJ3qk+/vjcJQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40djr9r5uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 06:49:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46G6hOYj021920;
	Tue, 16 Jul 2024 06:49:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c5dntn9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 06:49:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46G6nNv513041986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 06:49:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23A602004B;
	Tue, 16 Jul 2024 06:49:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 437C32004F;
	Tue, 16 Jul 2024 06:49:22 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.204.201.194])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jul 2024 06:49:22 +0000 (GMT)
Date: Tue, 16 Jul 2024 12:19:16 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_ext/for-6.11: cpu validity check in ops_cpu_valid
Message-ID: <ZpYX7BgiirBmwLa3@linux.ibm.com>
References: <ZpLSEHskvXXv4EoR@linux.ibm.com>
 <ZpSw7PvW1Teh6tNV@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpSw7PvW1Teh6tNV@slm.duckdns.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gCrC5Hqyxz7F2My0jvuwBO0djnp79U0L
X-Proofpoint-GUID: gCrC5Hqyxz7F2My0jvuwBO0djnp79U0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=580
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160047

On Sun, Jul 14, 2024 at 07:17:32PM -1000, Tejun Heo wrote:
> Hello, Vishal.
> 
> On Sun, Jul 14, 2024 at 12:44:24AM +0530, Vishal Chourasia wrote:
> > Currently, the BPF scheduler can return a CPU that is marked as possible
> > in the system configurations, but this doesn't guarantee that the CPU is
> > actually present or online at the time. This behavior can lead to
> > scenarios where the scheduler attempts to assign tasks to CPUs that are
> > not available, causing the fallback mechanism to activate and
> > potentially leading to an uneven load distribution across the system.
> 
> ops.select_cpu() is allowed to return any CPU and then the scheduler will
> pick a fallback CPU. This is mostly because that's how
> sched_class->select_task_rq() behaves. Here, SCX is just inheriting the
> behavior.
> 
> Dispatching to foreign local DSQ using SCX_DSQ_LOCAL_ON also does
> auto-fallback. This is because it's difficult for the BPF scheduler to
> strongly synchronize its dispatch operation against CPU hotplug operations.
> 
> > By defalut, When a "not possible" CPU is returned, sched_ext gracefully
> > exits the bpf scheduler.
> > 
> > static bool ops_cpu_valid(s32 cpu, const char *where)
> > {
> > 	if (likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_possible(cpu))) {
> > 		return true;
> > 	} else {
> > 		scx_ops_error("invalid CPU %d%s%s", cpu,
> > 			      where ? " " : "", where ?: "");
> > 		return false;
> > 	}
> > }
> >
> > On POWER, a system can have differences in cpu_present and cpu_possible
> > mask. Not present, but possible CPUs can be added later but once added
> > will also be marked set in the cpu present mask. 
> > 
> > Looks like cpu_present() is a better check.
> 
> We can consider tightening each path separately but I'm not sure making
What do you mean by "each path separately"?

> ops_cpu_valid() more strict is a good idea. For example, there's no reason
> to abort because a scheduler is calling scx_bpf_dsq_nr_queued() on an
> offline CPU especially given that the kfunc is allowed from any context
> without any synchronization. It can create aborting bugs which are really
> difficult to reproduce.
I agree, I wouldn't want to kick the BPF scheduler out for things that
can be handled. If an invalid CPU was returned by any sched_class, it's
best to handle it, because we don't have any other option.

However, the case of the BPF scheduler is different; we shouldn't need
to handle corner cases but instead immediately flag such cases.

Consider this: if a BPF scheduler is returning a non-present CPU in
select_cpu, the corresponding task will get scheduled on a CPU (using
the fallback mechanism) that may not be the best placement, causing
inconsistent behavior. And there will be no red flags reported making it
difficult to catch. My point is that sched_ext should be much stricter
towards the BPF scheduler.

Note: There is still the case when a offline CPU is returned by the bpf
scheduler. If sched_ext can catch that and handle it seperately by
calling scx_bpf_select_cpu_dfl

> 
> Thanks.
> 
> -- 
> tejun

