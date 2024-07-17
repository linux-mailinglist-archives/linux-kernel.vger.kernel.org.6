Return-Path: <linux-kernel+bounces-254846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37D93386B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F701F22AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13C1D52D;
	Wed, 17 Jul 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KqQsQMeb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468223774
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203162; cv=none; b=Og5U83v6Sf6Dfi3lANjrrVktns1gwQSIn3+u2IdiN/1p9UvftBW4YaL3YymljOaLwSuOA9rzDzHz6pToZFhF5VMGVcbzDPvVI2oXIpz3XNia4MsOiZ7MTIK+/xf0Xhpz2/7W1FxJbMyvtqF1rknGNnxhFIX+Wh5WdIaptZQBr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203162; c=relaxed/simple;
	bh=Xtpnddfs6h4SJwxl1kF8YkJ9fm4FScxHfK/ff0yMqcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8TSTWlbP8xZhfkyPTZYA0R4ftDnEM46zwfEn7HJU8jwLENoAATUM0aa4sGDAbrK+GFl7xbLxSyeqPFEtk3J2YCTWfMuf8GojJnI6QzfRq+QVVrGh6VxBL+DBmRCP+f8rUCjis2iptV0OOmu1tPdGfsOz9IIy3pezCEMXXOZCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KqQsQMeb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H5Pulg016925;
	Wed, 17 Jul 2024 07:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=l28JQo0kKUYgomFC9Lc7TWgwJuW
	w1xzr+w3MB+aZLFM=; b=KqQsQMebsgKQdrlGns95ZNjc4Fy9D3HaT1O1OT6rMaQ
	nIVQJ/vPxCxrbSx5y5scnCEz4AbLY51ACne1n9hkzm2UxVwv9QrtHwAcc1z5XgWh
	SlhJcVDZd2OMUfrdYly0cutBLWJzvE13SnWDr/wWiKRcxIDZRhBrgk9xIyGGE3Ae
	JrSC8Oeo9abkPMwpqEcC1wVX1rI9WNHeGCQrEvNytCzf4j+TkCzL+rcv1S4kqtev
	gfn9Qfw1MBL0aDNgePKd9ueVlJ4vL3/RTGrNtOMOfsHSnnZ7xUaHhLsucopS1RjA
	Yxq2kHpqnD5wuA78oE9QBdAKS0+3UWEM3m7JsNqAXqw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e4ru8ksf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 07:59:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46H5RFPH006337;
	Wed, 17 Jul 2024 07:59:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmb5hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 07:59:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46H7xAm728902044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 07:59:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C06F92004B;
	Wed, 17 Jul 2024 07:59:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E8F20040;
	Wed, 17 Jul 2024 07:59:09 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.22.40])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Jul 2024 07:59:09 +0000 (GMT)
Date: Wed, 17 Jul 2024 13:29:07 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_ext/for-6.11: cpu validity check in ops_cpu_valid
Message-ID: <Zpd5yzMGN9JtV-4C@linux.ibm.com>
References: <ZpLSEHskvXXv4EoR@linux.ibm.com>
 <ZpSw7PvW1Teh6tNV@slm.duckdns.org>
 <ZpYX7BgiirBmwLa3@linux.ibm.com>
 <Zpbp02N6bAE8mNXb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpbp02N6bAE8mNXb@slm.duckdns.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DQRKpQ1ZGtrPuHCgLUwufxji1j43x5zf
X-Proofpoint-ORIG-GUID: DQRKpQ1ZGtrPuHCgLUwufxji1j43x5zf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_04,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=804 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170059

On Tue, Jul 16, 2024 at 11:44:51AM -1000, Tejun Heo wrote:
> Hello, Vishal.
> 
> On Tue, Jul 16, 2024 at 12:19:16PM +0530, Vishal Chourasia wrote:
> ...
> > However, the case of the BPF scheduler is different; we shouldn't need
> > to handle corner cases but instead immediately flag such cases.
> 
> I'm not convinced of this. There's a tension here and I don't think either
> end of the spectrum is the right solution. Please see below.
> 
> > Consider this: if a BPF scheduler is returning a non-present CPU in
> > select_cpu, the corresponding task will get scheduled on a CPU (using
> > the fallback mechanism) that may not be the best placement, causing
> > inconsistent behavior. And there will be no red flags reported making it
> > difficult to catch. My point is that sched_ext should be much stricter
> > towards the BPF scheduler.
> 
> While flagging any deviation as failure and aborting sounds simple and clean
> on the surface, I don't think it's that clear cut. There already are edge
> conditions where ext or core scheduler code overrides sched_class decisions
> and it's not straightforward to get synchronization against e.g. CPU hotplug
> watertight from the BPF scheduler. So, we can end up with aborting a
> scheduler once in a blue moon for a condition which can only occur during
> hotplug and be easily worked around without any noticeable impact. I don't
> think that's what we want.
> 
> That's not to say that the current situation is great because, as you
> pointed out, it's possible to be systematically buggy and fly under the
> radar, although I have to say that I've never seen this particular part
> being a problem but YMMV.
> 
> Currently, error handling is binary. Either it's all okay or the scheduler
> dies, but I think things like select_cpu() returning an offline CPU likely
> needs a bit more nuance. ie. If it happens once around CPU hotplug, who
> cares? But if a scheduler is consistently returning an invalid CPU, that
> certainly is a problem and it may not be easy to notice. One way to go about
> it could be collecting stats for these events and let the BPF scheduler
> decide what to do about them.
> 
> Thanks.
> 
> -- 
> tejun
Thanks for the replies.

--
vishal.c

