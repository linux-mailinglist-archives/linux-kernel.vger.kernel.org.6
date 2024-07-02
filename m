Return-Path: <linux-kernel+bounces-237436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B2923776
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449C5B224B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51C14E2FB;
	Tue,  2 Jul 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmI6dyGE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0314B97A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909649; cv=none; b=orXyqbASTqaGL+z5KQ9nLBRqxUSonPS/H5aKyqaQor6sQHMm9c6YtX3I8GmvSm5Tw673xd/+vPbsG2LTk7hGsCuhBxENeu8fcI8H51qTTaqqJxkST0LSlWn1z7371DxkXPJugvAe5nffjLxZb91mdIbUdzcyWVKUUfRyyt7f82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909649; c=relaxed/simple;
	bh=lgoQKwqrl6lo6adIzSJoSWBrS+YYMJNu7jiDehJS7ro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=s1I62tMLTR/P4tduIfD7mVUauFTXHxzIIWv0BPK3m5p5HbJKbXK8Ow6AgEYGi3Hvmr/e761w7ERwieDecH1OI9u6t9vJOAvRkTqFRWUl32CrkVScj+Oi+9svVH+sp9B/ncmtqerAmT2srcJ0fgiD72GQFtERzbCJkNLY2WFVN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EmI6dyGE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4628SnYL017531;
	Tue, 2 Jul 2024 08:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	L+MNS6vysixusrBR190iOQ2dv0Bm9953vZGDkAjubRw=; b=EmI6dyGEWDqdpC/A
	cKScFvNvaAlM75fpGqAMBcCxE1kvcr94YZIw7PouxvfD1IvwD+RE3QahlaTHO0B8
	1mAMKl21heXPhWaeH6lTNxrM+NMoDYn+8TJKUM/sLN/mCONGkCPlaLqBnyE4sjI8
	zZK2aiXKx7oDVYfzCQ4KQ7PiIR9PiHTEoCF+88PruGTxCwjbXebM1/oJrKejGF1/
	5pkG1kPcWYdNi8d+dYIWbrY4y4WioJ/xrI2dYRg8EReaAKpxkvOMStd4uMQkvHrM
	98QOGdmbqTEe/gVCnGgvM14f9EUuEqWBYxFjZ9qifnjNScHhAZNeJYPQMF7BAEZF
	rRyIIA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404e2nr1c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 08:40:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4628C9L2009473;
	Tue, 2 Jul 2024 08:40:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtmkndb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 08:40:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4628ednd21168724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 08:40:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EBED58045;
	Tue,  2 Jul 2024 08:40:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D595D58062;
	Tue,  2 Jul 2024 08:40:37 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jul 2024 08:40:37 +0000 (GMT)
Message-ID: <a0e9dea5a434a471576f192b980ad48cb40b742a.camel@linux.ibm.com>
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Documentation: Remove
 mentions of scx_bpf_switch_all
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Date: Tue, 02 Jul 2024 14:10:36 +0530
In-Reply-To: <ZoLtGmBw6kcNtmts@slm.duckdns.org>
References: <20240701123022.68700-1-aboorvad@linux.ibm.com>
	 <ZoLtGmBw6kcNtmts@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rcH9BWqFlyfUJsziErLnfyC02IeXlCMC
X-Proofpoint-ORIG-GUID: rcH9BWqFlyfUJsziErLnfyC02IeXlCMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_04,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=546 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407020063

On Mon, 2024-07-01 at 07:53 -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 01, 2024 at 06:00:22PM +0530, Aboorva Devarajan wrote:
> ...
> > +sched_ext is used only when the BPF scheduler is loaded and
> > running. To use
> > +sched_ext, a task can invoke ``sched_setscheduler`` with the
> > ``SCHED_EXT``
> > +policy constant.
> 
> I wonder whether the last sentence is a bit confusing given that
> tasks can
> be on SCX without setting SCHED_EXT.
> 
> > +When the BPF scheduler is not loaded, tasks with the
> > ``SCHED_EXT`` policy are
> > +treated as ``SCHED_NORMAL`` and scheduled by CFS.
> > ``SCHED_NORMAL`` tasks
> > +continue to be scheduled by CFS.
> > +
> > +When the BPF scheduler is loaded, all tasks with the
> > ``SCHED_EXT`` policy are
> > +switched to sched_ext. By default, if the ``struct ops->flag`` is
> > not set to
> > +``SCX_OPS_SWITCH_PARTIAL``, ``SCHED_EXT``, ``SCHED_NORMAL``, and
> > lower class
> > +tasks are scheduled by sched_ext. In this case, all
> > ``SCHED_NORMAL``,
> > +``SCHED_BATCH``, ``SCHED_IDLE``, and ``SCHED_EXT`` tasks are
> > scheduled by
> > +sched_ext.
> 
> How about something like:
> 
> When the BPF scheduler is loaded and ``SCX_OPS_SWITCH_PARTIAL`` is
> not set
> in ops->flags, all ``SCHED_NORMAL``, ``SCHED_BATCH``,
> ``SCHED_IDLE``, and
> ``SCHED_EXT`` tasks are scheduled by sched_ext.
> 
> > +However, if the ``struct ops->flag`` is set
> > to``SCX_OPS_SWITCH_PARTIAL``,
> > +only tasks with the policy set to ``SCHED_EXT`` are scheduled by
> > sched_ext.
> 
> And update this paragraph in a similar fashion?
> 
> Thanks.
> 

Hi Tejun, Thanks for the review.

Sent out a v2 with the suggested changes.



