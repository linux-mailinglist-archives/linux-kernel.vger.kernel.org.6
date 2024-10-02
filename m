Return-Path: <linux-kernel+bounces-347020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFE98CC56
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52FAB23591
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD31EEE4;
	Wed,  2 Oct 2024 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AAnYH0fb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA721C2E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727846294; cv=none; b=pNhptmSKJYDvVR988hX5YFwylS5oiBTUL0U+nB1F0YhVbskMFhZLbJw/X0W+OSfLiBgP+jraYQfZjexHGadHKrhnK2CxfiNaNVL7egVxJGGw9dGTvi46pHn5LvDoPBqWk+gU/uD/QOFUiFm8K1mwN19Fq2fRMO6j5Rep+fjTfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727846294; c=relaxed/simple;
	bh=FM5Mwou4mXw0nvCvnm9L/JIjwdH5p3CoNzrQbmK71As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klshXxmEvFczLqcXNbfLhNkRAvE5KEkHawNybCOJT7iifUInmWp3EFO8LqLl64s5AutsRwEhKS9O9kcbt5MPcnS3R4h/9wuv2+kdlmiY8yyRCrFxeWRxj0EM6MIU4V01pvkHXd9GQ6s4pXEJQX2/vGHTdPp+iJLYVd4G8GyCc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AAnYH0fb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4925HS3e005249;
	Wed, 2 Oct 2024 05:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=oFiUb/1WmBzyKhMn5ZvpI/bcEnL
	kO/dBhuXFDwzKjEo=; b=AAnYH0fbDDdAMWxA0lmeE9uUDsi/uiePOYTyte3qwXa
	U2WdeDFALdg43jc+M6sTawpiE21Bl4D5hQbFGvttVA3YujzAURiJuplzhRn5f+Sy
	JQUOkg1W6kP8kIl/q0ReFzX+K/xbluZo+m7dZSLgWFeM7qOo8utlTp0R3QvySRLA
	fiZ1xbfS/LYGGSDMETVtZUDgAZo7ZABdQF9CFdp/zzy/qsfJAusLhs2oFlcP4zz8
	mDKysnlXG3R+ekbpeiANR4ZQES3QFyMFs6hflS2uP1CHeFJcDozM1IvVqFUsPc+b
	OFPNr/ntuXOb8y/XXdUTrOAl38baGIB8MT6S7y64k3w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420yvyg03h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 05:18:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4925HH1X004651;
	Wed, 2 Oct 2024 05:18:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420yvyg03e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 05:18:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4922kimr017899;
	Wed, 2 Oct 2024 05:18:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4n0ay8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 05:17:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4925Hwap50331992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 05:17:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F057D2004F;
	Wed,  2 Oct 2024 05:17:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B2C620043;
	Wed,  2 Oct 2024 05:17:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.30.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Oct 2024 05:17:56 +0000 (GMT)
Date: Wed, 2 Oct 2024 10:47:53 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sched_ext: build errors when building flatcg and qmap schedulers
Message-ID: <ZvzXarv10LVGteNd@linux.ibm.com>
References: <ZvvfUqRNM4-jYQzH@linux.ibm.com>
 <Zvxfg-Qpn_oO6qTh@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvxfg-Qpn_oO6qTh@slm.duckdns.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fgOfq3l3Lx5dnLqkV5mganHWwH_pKKR9
X-Proofpoint-GUID: f34ooy-w4rKWgl4IrS3ug8cNYeYsDPMK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_04,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=720 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020036

On Tue, Oct 01, 2024 at 10:45:55AM -1000, Tejun Heo wrote:
> Hello, Vishal.
> 
> On Tue, Oct 01, 2024 at 05:08:58PM +0530, Vishal Chourasia wrote:
> > Getting build error when trying to compile example schedulers in
> > tools/sched_ext/* (logs shared in the end)
> > 
> > 
> > tools/sched_ext # make -s -k
> > 
> > 
> > git repo state
> > $ git log --oneline
> > e32cde8d2bd7d (HEAD -> master, origin/master, origin/HEAD) Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext
> > 190ecde722dd0 Merge tag 'probes-fixes-v6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
> > a5f24c795513f Merge tag 'vfs-6.12-rc2.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
> > f801850bc263d netfs: Fix the netfs_folio tracepoint to handle NULL mapping
> > 28e8c5c095ec2 netfs: Add folio_queue API documentation
> > 2007d28ec0095 bcachefs: rename version -> bversion for big endian builds
> > 34820304cc2cd uprobes: fix kernel info leak via "[uprobes]" vma
> > 9852d85ec9d49 (tag: v6.12-rc1) Linux 6.12-rc1
> > 
> > 
> > Adding __weak attribute seems to have fixed it and compilation completed
> > with no errors.
> 
> Hmm... I don't see the failure here. Maybe toolchain difference? Anyways,
$ clang --version
clang version 20.0.0git (https://github.com/llvm/llvm-project.git 00c198b2ca6b6bee2d90e62d78816686ab056b1b)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin

$ gcc --version
gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Do let me know if you need any other information

> can you send the patch to add __weak?
Sure.
> 
> Thanks.
> 
> -- 
> tejun

