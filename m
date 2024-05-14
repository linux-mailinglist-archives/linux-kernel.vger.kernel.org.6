Return-Path: <linux-kernel+bounces-178611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913058C5317
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A891F22F18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EF613A405;
	Tue, 14 May 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b4WsIwr8"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5513A275
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686301; cv=none; b=P5xl4mx5oUs+B0Lr9P+/apilTej+kUTclHb7GaEkC1gsRPYaXBqapWhSHD2w1VltALicUeR2ZYfCiGFbo255VisYzHpnSp1ANe/0GoB2t/0/mTEUqI6AGsYwTAHBgl1Kn/PVCFc6/FU6LHuBtVcB2MM8Mdd1jujREiXKHeyXGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686301; c=relaxed/simple;
	bh=XhRGyln3sd8lONicUWHD3oNu6jfDpsgZZThQ5tswa48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaPvZlduGYOf+QbCpbWySeSoDVd3HycWBre4wzF01BOHYNiLNIbU5DsDHVwrLKLgFh1NzY28x3d4raYVIbpE4W9jHB8E2KsSbLicl42c70pg8vcQPJ8j0u3GRlRW4oDFhg4EExdmHaB/Pd7ZYa/BeH4nYzPaMLM9ChskMCB4xrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b4WsIwr8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EANCY7030176;
	Tue, 14 May 2024 11:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yXOdXwxnUSH4P8a7AOTpMor36F3JDzt6190nMqMER5k=;
 b=b4WsIwr8zy19hJwwFMUUOO8FPazTRB/qxKEMKmax7SWjFgB55pJPn48OCp8Xjz0aCRV6
 PFqEErF1Ts6j/z5WkeHDcsmoJw60AOP/vnTpCXYJcKdLxtEEXCvRN9iMWrZDMDpCiONv
 DxT2ox9yzZNkkNJytUs6J2+I2QXrRDDfgR+R9K0C6t9kwsFI/BUiHrd9tl6/tO3ZbrCk
 3Va8UsSZn666yvBtpfPdW9ju9erjTOBu38xECGaWbnjWd+xwGuG9kNZ5Rxf7l3Kb45/W
 CWUvDkkLwlB+wRXYKDeTrYqSBXQ9PC7V8g300yiz9p2yQM42qkw2KsXEHc9o5GjsxLxG Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4656g4ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 11:21:55 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EBLsSD022184;
	Tue, 14 May 2024 11:21:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4656g4ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 11:21:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44E8cclE006189;
	Tue, 14 May 2024 11:21:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmcxqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 11:21:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EBLnTJ54001924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 11:21:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9989F20043;
	Tue, 14 May 2024 11:21:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5874E20040;
	Tue, 14 May 2024 11:21:48 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.204.206.66])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 May 2024 11:21:48 +0000 (GMT)
Date: Tue, 14 May 2024 16:51:41 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove the definition of unused cede
 function
Message-ID: <bbz5jnemmpzaz4577fured3vyettp677qgacvifgfgnq4nbeqi@gvqz4r4hc4jc>
References: <20240514100507.271681-1-gautam@linux.ibm.com>
 <vfx2z4dn6afpkl4z7ygewadw7mohfd7l3tfazdya4sbxniurkg@vrubq25slkvs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vfx2z4dn6afpkl4z7ygewadw7mohfd7l3tfazdya4sbxniurkg@vrubq25slkvs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3bgrU1ZxcOf30zPoKAqInHN_9dgFBylG
X-Proofpoint-ORIG-GUID: FiGjcpiVqSb0OJDqIa9WUvmLQP5-qZ19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=403 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405140081

On Tue, May 14, 2024 at 04:20:04PM GMT, Naveen N Rao wrote:
> On Tue, May 14, 2024 at 03:35:03PM GMT, Gautam Menghani wrote:
> > Remove extended_cede_processor() definition as it has no callers since
> > commit 48f6e7f6d948("powerpc/pseries: remove cede offline state for CPUs")
> 
> extended_cede_processor() was added in commit 69ddb57cbea0 
> ("powerpc/pseries: Add extended_cede_processor() helper function."), 
> which also added [get|set]_cede_latency_hint(). Those can also be 
> removed if extended_cede_processor() is no longer needed.

Yes thanks for pointing it out, will remove them as well.

Thanks,
Gautam

