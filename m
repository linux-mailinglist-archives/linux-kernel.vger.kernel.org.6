Return-Path: <linux-kernel+bounces-569105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB404A69E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E233BF594
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F517A2E3;
	Thu, 20 Mar 2025 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nED20vw+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF22AE6A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439550; cv=none; b=QmR/uHVwZ9ZGjC+qhfVNxb5q+CvDw2NW/FlaXn3lldd4hRHgdi2QKAe07KCWTD79b6/eGTcM57gK2TH4kMuI5GqomTImCkQN/hqaQ/lVgY27NoUr9mncbpdCbxd0q/I3enIHexTkF+/fYbvvk1CrxdbhI77UDUZHACfhtxKBn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439550; c=relaxed/simple;
	bh=UQtuSoulfPfpLjBpEGFoFosojXT5nBwe8U3/zX1sN6s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l38SsiokjcI9y5OGp1u+BpaICWlk8f5GsQncl+fXQkVh446z1HouiZN+r/A8p0AZk1lz7Wp/6FAjfmbnNhi132AI6Kyuq3ylr819sSzahN8GXSelWSfiPY4ocZCjxqROwkm8BBQ4ovXNBHr9D5XFr3GkLhDFwL5ejDBt7azFR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nED20vw+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JLRbaV019461;
	Thu, 20 Mar 2025 02:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j5mn1D
	D7kZlcsmokFGmSl9e+GfOpN6jTIBsqQkVkwbo=; b=nED20vw+SJ63uNLgdCUO7P
	h2VWZwNwyGvUPrLu/2xEE8NvHea8I7CJDgPjQD8xPS2GJzh1trynOQ2gDuKi8wvs
	jxzCSMHSooevacPfFO4MXtK7uLFtMA5L0VjUGGbUyCLCHAD4VsEWkReqMtxxMxg3
	bondH9cdSL+A2WD3hnKgV6FU7mMyAbkAtGl+Vk4+Aj+c91iewph4nCEIXcMyu7e6
	bJmIxnm5SQoTv5JyHb5fN6d1iB+ujhWCo512HveSfsrgOUc206vOE0Vgu7+5YGCk
	FC958Mqza2R5Vjs0zrVL7nkyYwd8QyvVVQDbeYVMRhu2J3MWLfMbOq1szJaOyJvQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fpa9pmag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:58:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K1psXc024425;
	Thu, 20 Mar 2025 02:58:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncmddyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:58:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K2wtGH17629928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 02:58:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74B5C58053;
	Thu, 20 Mar 2025 02:58:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278AE58043;
	Thu, 20 Mar 2025 02:58:55 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 02:58:55 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Mar 2025 21:58:54 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <87a59h3sk9.ffs@tglx>
References: <1742386474-13717-1-git-send-email-wenxiong@linux.ibm.com>
 <87a59h3sk9.ffs@tglx>
Message-ID: <90777da90abe02c87d30968bfedc9168@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wtw_3lgXYjNliVygPisGJ2WuGc-ZTN2a
X-Proofpoint-ORIG-GUID: Wtw_3lgXYjNliVygPisGJ2WuGc-ZTN2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200018

> The real problem has nothing to do with a remove/add operation. The
> problem is solely in the probe function.

Hi Thomas,
Thanks for your suggestion!

I don't think we have problems in probe function since this driver has 
been in productions for many many years.
Also we didn't see the issue before the "MSI domain" patchset dropping 
into linux interrupt code(no issue in rhel92 release).

Device reset is not called in probe function. We don't see the issue 
without dynamically remove/add operation.
There is a small window which irqbalance daemon kicks in during device 
reset. So it took about over 6 hours to recreate the issue when doing 
remove/add loop operation.

We can't find the good way to fix the issue in both of device drivers. 
So we look for some help in interrupt code.

Looks each irq_data has a state(IRQD_AFFINITY_MANAGED), Can we play this 
flag during the reset in device driver?

* IRQD_NO_BALANCING        - Balancing disabled for this IRQ
* IRQD_AFFINITY_ON_ACTIVATE    - Affinity is set on activation. Don't
                    call irq_chip::irq_set_affinity() when deactivated.

OR
If we registered an affinity notifier in device driver, can this tell us 
the msix vector has been clear to 0 when irqbalance daemon kicks in?

Thank you so much, I really appreciate any suggestion/help!
Wendy


