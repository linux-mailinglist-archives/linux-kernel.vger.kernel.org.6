Return-Path: <linux-kernel+bounces-553551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D860A58B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B797169149
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83C1BE251;
	Mon, 10 Mar 2025 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="motiyE2o"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75A23A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582835; cv=none; b=H6ICY8ADqfDJUWYH6RPHExm/SX9feTA+IVh34GMzFujDYT5xC1H8RCBODjiuMSSPR5FTRRrLpdBVVDZzp6AWcVZyqn5niuzUoRno4QprttOt3DDCwz+uSXIj1/rO9ZAj4ZbIsWMy79yY7Q2K3SXiqdsgTjZiN8+XrFj624jguho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582835; c=relaxed/simple;
	bh=FbKQgE+nEkhykKhL5CGeuwVAxEG82UnFKn4gh6uIss4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bd6xYdsj5IFpM2SvxY4X9T8A93o3L1sbeYqudKSOR4n8T7+X/mId0VRf0/19R22j9cGJJX6OOITpXoWQoupWvvthXid29uStb0FzN3xfFtfh0rW+5nNjN0Etx9aUQT09Ndo6w5ywQhO5rwEJ5Jj0FzY1OQ1XJiSQ2SNZ1XthvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=motiyE2o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529KepAJ020348;
	Mon, 10 Mar 2025 05:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tYzngVIj/pzWvrZmaIiWWQg1pW8CUV
	O4dUVHdoOjGiw=; b=motiyE2oP4r4QHOHr0Z+h027QCFKmnrxDQ+gTa3hLAQYAw
	bGhxNX+KF+RNgk+4EOPBsgdU9SEY+pszeA+uAQM+WDlWXAAvnJoVp/N5v4dyM/tY
	qk8viwnABkx/RKu2iv5NvdfK7yfo1Kd47KjK5xTQAV/OdiE8ALphSFC8lHSkzi/Q
	B1O3oyBjT6e9bZfKwX3lp1iUGh6YFHSbTs6bbR3dpyQEZCGfPHMPld46UwzU4rGn
	JyAyGqz4uUaYpztyxus/jdWziJZcHKFHe7BGchEjrhh/v+/oDYldeye8DGqt1qeF
	eHJNUmJE5xpHiFhGsKQAW0p1vWnZUov8Tw5x3T0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459j6yh6sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 05:00:12 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52A50Bns014700;
	Mon, 10 Mar 2025 05:00:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459j6yh6s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 05:00:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52A2HfqL027530;
	Mon, 10 Mar 2025 05:00:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkctj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 05:00:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52A507U234865910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 05:00:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E705E20043;
	Mon, 10 Mar 2025 05:00:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2FC22004E;
	Mon, 10 Mar 2025 05:00:03 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.218.228])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 10 Mar 2025 05:00:03 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Mon, 10 Mar 2025 10:30:02 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/msi: Avoid reading PCI device registers
 in reduced power states
In-Reply-To: <20250305090237.294633-1-gautam@linux.ibm.com>
References: <20250305090237.294633-1-gautam@linux.ibm.com>
Date: Mon, 10 Mar 2025 10:30:02 +0530
Message-ID: <87tt81tr8t.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FQIXXM5-dJMkqGfkkabZWwAJ7PBnfEWC
X-Proofpoint-ORIG-GUID: DkN087udYypB2ASs1EV_FiKFSW_-CNnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=922
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100036

Gautam Menghani <gautam@linux.ibm.com> writes:

> When a system is being suspended to RAM, the PCI devices are also
> suspended and the PPC code ends up calling pseries_msi_compose_msg() and
> this triggers the BUG_ON() in __pci_read_msi_msg() because the device at
> this point is in reduced power state. In reduced power state, the memory
> mapped registers of the PCI device are not accessible.
>
> To replicate the bug:
> 1. Make sure deep sleep is selected
> 	# cat /sys/power/mem_sleep
> 	s2idle [deep]
>
> 2. Make sure console is not suspended (so that dmesg logs are visible)
> 	echo N > /sys/module/printk/parameters/console_suspend
>
> 3. Suspend the system
> 	echo mem > /sys/power/state
>
> To fix this behaviour, read the cached msi message of the device when the
> device is not in PCI_D0 power state instead of touching the hardware.
>
> Fixes: a5f3d2c17b07 ("powerpc/pseries/pci: Add MSI domains")
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
LGTM. Hence
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-- 
Cheers
~ Vaibhav

