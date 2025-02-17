Return-Path: <linux-kernel+bounces-516994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5AA37ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C952188CEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF311624F9;
	Mon, 17 Feb 2025 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YN9PezDd"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B014F9CF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739768862; cv=none; b=VgDmD/LcgHU8TQrudyeJYS1U/YSYQb6vW3EAcOBV4cJq+ADbQUnK19WNoUDKNmdhbk3EtX2zkJ2YPx7t8DJyQ9yOMyLtiJBdVBa8B1C50CEpYDkGoKb/UDQbut1+zVJH6UBlhn0w4QWKt7KEGdUJCwPcZX9z9e9426WRquXLnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739768862; c=relaxed/simple;
	bh=dCoGZoHz33mF8BFIMrxziCXQKSpSSpH/w9T+t4bTYmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IymO0/zvkJub6tQmyaMMczP/M3XIWZF5zXaV5amUJOSqNxqE1Cg5OMxUylcxajloxe+tZRiCPPCjggVaZFqvLf30ssbJGykDO9Qi5JQnHV4rNtHwR4Cw3BoPV0NeQ42qrtTxD86cebRAW34Uc7yYeZZUsNAg4U23LSmeZhClJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YN9PezDd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H1803c013348;
	Mon, 17 Feb 2025 05:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dCoGZoHz33mF8BFIMrxziCXQKSpSSp
	H/w9T+t4bTYmw=; b=YN9PezDdqTGANXaJMdyjLe3wzBNKOR/omfHc5SZR9LSvEG
	6hHUinPhy5mwPHaVYta0y5wOVClQKW/odzDdQcxif/UTMvSyjnkwkw7sdvWwg75c
	jz8W6QM60Bwtx9Kd9tk6dNQONpiytcqj1LwLbA2dpYk+8sEaOYOTcbVE9Xcmf0JT
	fGA8QhYrko+CkpJ2RaRDjH+59f+xWyjRd0Tt8mQf3gavY3QrCvm4cIG/bgMId7eg
	9Rq6qi5HnrEgcNL60JAuJT+o/eFL3DdPixo7cr4OWt6cvAkMsBHrWevdLZfLsH5O
	JsbrKTZYgL6GpNyr/XsS3JCzgwzmisDazzwqBzWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uu698sjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 05:07:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H52JJx011882;
	Mon, 17 Feb 2025 05:07:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uu698sjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 05:07:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H0tOia013259;
	Mon, 17 Feb 2025 05:07:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fkcamy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 05:07:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51H57C4N38863358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 05:07:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81D82004B;
	Mon, 17 Feb 2025 05:07:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 463DF2004F;
	Mon, 17 Feb 2025 05:07:09 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.221.81])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 05:07:09 +0000 (GMT)
Date: Mon, 17 Feb 2025 10:37:04 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, maddy@linux.ibm.com, clg@kaod.org,
        brking@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] powerpc/pseries/msi: Avoid reading PCI device
 registers in reduced power state
Message-ID: <lbbob6ac7qxgu5aot2sbti6frkhr4zsugshkfb32e7uxjevgbg@n7sxmbdqcorn>
References: <20250206100956.438888-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206100956.438888-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4qBhL7N7Y2YycLOldJqiwaM-VulYZUI7
X-Proofpoint-ORIG-GUID: LKK_szV8Hjl3iIGNP-dBIuNs6AG_uMnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_02,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=396
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170041

Hello,
Please review this patch and let me know if there are any issues with
the same.

Thanks,
Gautam

