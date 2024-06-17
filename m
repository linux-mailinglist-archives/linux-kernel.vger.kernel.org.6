Return-Path: <linux-kernel+bounces-217373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F000490AEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6050228CE99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83A194AF5;
	Mon, 17 Jun 2024 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CKBU07B2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A681E4A4;
	Mon, 17 Jun 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630231; cv=none; b=IWeMIYC7rMIp4Dwvumbtupt9/dTBICTTIusEDrV9WuudObN83OzB96dc3gJUUmFBMdENMZmeuNGQebBYzJ2pRjLa4LFWY88gKWzAfw1vDJz4ba3BkYNpwfA2WZm0Z4SE4RHbKTvFIYROU1tjkK6eYf/wZeG2td5fsqMJqBseeVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630231; c=relaxed/simple;
	bh=RKJ0+DI/GfjpvRhEVZGksVoGUkq2EqTprGfcf8rMZOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntBv9WVJWqKF/uz/eBAup5b5I1JiVKOE1pqM3fLmR8MWhSqoQanJKLZJjZdtv3nTUfGX86WqouVPfiMUdK1w2icqrKDh8h/oT2TvgQHeUTZv9kVzxcboLP42wtyKojUkbSxaxmaf6bGpAocPO8OtanL+ch23EfPXm6RxhOu/Ick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CKBU07B2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HD3MbI003782;
	Mon, 17 Jun 2024 13:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=RKJ0+DI/GfjpvRhEVZGksVoGUk
	q2EqTprGfcf8rMZOM=; b=CKBU07B2vr9mFs8KoqrZ2kvaWRmS977GHfk3Guszpw
	logo5A2xMCBMkHTHT+TpjV0Qnske1zBp+Ne8MSKIfvYkIozEmG2HhlKIonPYYXvf
	CSZyAbUM31rBZkKh4TD6w03CAzkop92H14lHplLgeaaC3UeFRA03j1DeZMxwFetz
	ixxbkUqZdfAneCDHE9+P0dIepmOJ4JIunEMRhqGcgpLlJ48CQghXXzxLEKBGzYN3
	drK3xmn2RfVcSTUs6MbOUGvdNLtw3rEP9NXJUlB0TdFzcYtWVlbagsV7s7AU4wC4
	b0AeCyWt2FnvQShYMsonhUnt7Mw+leZVFcQ2Mz3O0QPA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj408kpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:16:59 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HDGwwr025081;
	Mon, 17 Jun 2024 13:16:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj408kpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:16:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45HC82bj011355;
	Mon, 17 Jun 2024 13:16:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsmt5u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:16:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HDGtol23921224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 13:16:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5058658065;
	Mon, 17 Jun 2024 13:16:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D90558056;
	Mon, 17 Jun 2024 13:16:55 +0000 (GMT)
Received: from localhost (unknown [9.67.51.116])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 13:16:54 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
        Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] Documentation: Remove the unused "topology_updates"
 from kernel-parameters.txt
In-Reply-To: <20240617060848.38937-1-thuth@redhat.com>
References: <20240617060848.38937-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 08:16:53 -0500
Message-ID: <87jzinemka.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FE8UjtYUg6wY9H1zb7kcNbMRzBo5w9dc
X-Proofpoint-GUID: WhFz5y364r2AYxaXYbZE_KRsEEBpHpx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_11,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=748 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170100

Thomas Huth <thuth@redhat.com> writes:
> The "topology_updates" switch has been removed four years ago in commit
> c30f931e891e ("powerpc/numa: remove ability to enable topology updates"),
> so let's remove this from the documentation, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

Thanks!

