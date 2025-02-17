Return-Path: <linux-kernel+bounces-517550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA97DA38241
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9338C3ACAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4A217733;
	Mon, 17 Feb 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d7f8KX1C"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358CB15442A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792976; cv=none; b=BrCAltVm0Hwqh9AsxaK7tg/hti/+cgP6puYvLWczyogouah446PAGtdVbbuTOTVVTmlYz0Pe4wprCr5SCh1o3Qb3/dh+zPkL/HarHdRdnTLwHfa5C4oIFnH/3UpXBRcyLWZI/+MCOkLp5r4NzqfUDnodmrfzDC9XLEbNJk6lSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792976; c=relaxed/simple;
	bh=Tv0bbYCjjiOES2U0rJz4jhs01v/xcXZaW174R6bsYAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6+ZlTytkJmx/6epcqGG6FsxFj4GqA3Ug04vrkniF4v3SiYcNJqGLjDE1+qLnR9XyJF+pBHPit9oK2g+RutcOfvCUn7QzwANjMnqxcUuK84TRJ0IxNWKEClebixZhhNuduFnOzjsoEU0BtGwkw6N5vC9CidwYDn3/Ir4GF/HBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d7f8KX1C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HAhZhM031817;
	Mon, 17 Feb 2025 11:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6VE/YKHk61QZsITRD6hDcs2KO3WHGS
	0y8q5SqEQEFjQ=; b=d7f8KX1CQZjBh7IEXyOOkl0VcCKBB0sglrpU2KGooC5LjJ
	ZbbY84XgRERAnLoTPNfH3k6aZZrlkENSLRn1z7P8Y1D2r3L5U/XwGbUCG3GuiNjY
	dOpvuUd3+C58Z/7cyynRhaR0tf1tTwVF6DNcEziYmihMp5IivWXDHK8bXi0WAs3B
	7/8gGt6oEFjwaL7PvD0AAorMnpwmbUXvpJAjF7+utnurs0ZETC7ESS6jIrOV376Y
	YncKSuLtHsVm9LG+LGWfDWmoN5XK75ex4/9KvN46mqeLkTGRa24to3cNXyMQHJLr
	vjYOSB313ypkWBE5hToatXNs4vUgRH08apDeknwg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a2yj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 11:49:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H8rAAi003954;
	Mon, 17 Feb 2025 11:49:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68nnw4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 11:49:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HBnKYS45809924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:49:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D40982004B;
	Mon, 17 Feb 2025 11:49:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 484AB20040;
	Mon, 17 Feb 2025 11:49:20 +0000 (GMT)
Received: from osiris (unknown [9.171.53.224])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 11:49:20 +0000 (GMT)
Date: Mon, 17 Feb 2025 12:49:18 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [GIT PULL] ftrace: Updates for v6.14
Message-ID: <20250217114918.10397-A-hca@linux.ibm.com>
References: <20250119193134.0ebd56bc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119193134.0ebd56bc@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -rxccJEI6JG-gvtXzl07rIx4QZx6uwgH
X-Proofpoint-GUID: -rxccJEI6JG-gvtXzl07rIx4QZx6uwgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=774 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170101

Hi Steven, Masami,

On Sun, Jan 19, 2025 at 07:31:34PM -0500, Steven Rostedt wrote:
> ftrace updates for v6.14:
> 
> - Have fprobes built on top of function graph infrastructure

this seems to cause a regression:

When I run tools/testing/selftests/ftrace/ftracetest I now end up with all
functions being enabled for ftrace after the test suite ran:

$ wc -l /sys/kernel/debug/tracing/enabled_functions
50779 /sys/kernel/debug/tracing/enabled_functions

$ cat /sys/kernel/debug/tracing/enabled_functions
...
down (1)           
down_interruptible (1)           
down_killable (1)           

$ cat /sys/kernel/debug/tracing/current_tracer
nop

Bisected to commit 4346ba160409 ("fprobe: Rewrite fprobe on function-graph
tracer"). Before this commit there were no ftrace enabled functions after the
test suite finished:

$ wc -l /sys/kernel/debug/tracing/enabled_functions
0 /sys/kernel/debug/tracing/enabled_functions

This is on s390 with defconfig.

