Return-Path: <linux-kernel+bounces-268849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB52942A34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2C1285C87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2D1AB51C;
	Wed, 31 Jul 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EpVeZOhL"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1091AB519
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417479; cv=none; b=DM+Nf2GMPQbndcYkepGoJ6TTbjJ4tIYI/cyPI04ocb/oi0Jdmdpkl2e9AZHPbh9ozwYfudPC3eaDP9WDCkLnZLadkcej9FwsxHi1D/hrSbwOQusi4Tpc/OH+IR9QnG8vDQkmQ08q9viakekEH39lCwYK/7yb5645pSDvmiazguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417479; c=relaxed/simple;
	bh=QSUiq3S5yS+gu0jFKRAVdmru3UnikzlaDluP7RoMFMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abtfikjnLHVHpwQaaJxALP2bOFQiZ/KvLGhA8EQghUxzOSlhCnTvhUmi/W+5u4pwLLFzuSPUhXnWtngYNHU3zTO4IbUsypxMmKm997CKN3r0LFG2am7hkcEJoiTyEXuxySVCA7FzRwQ8JXy49o+Mg7LC3FczO4SNNFrPtQAA7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EpVeZOhL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V6xGmq010278;
	Wed, 31 Jul 2024 09:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=C
	JZYAV3OObcvqWjd1XHqaqFdAWNrLH3EJ1zWax+VnJQ=; b=EpVeZOhLr0ah45LUW
	L8kRYch/yfTs5dCpqy9dpcfowJ9LzwQAGnLap/AhF/HmEpMTLGFR5QDL2HtwNfft
	s541y13x4BByKu7O/KFwAnIlGWzwyF9u+s/mWR9nNZKU6sbzk1d4yb9QF9B0co1x
	+DV20hg6shcgC2pxFzjTfFQBNYU/tw5h0DU0JW4Ci4GZlOuWSETFfCCG/8QEM93B
	ecOU9F1OXE3WMQmHD5YX7DEaEt5D7BNX6sFLCS36QFnvaGWUb/LadY/geMNmpEMF
	fDf4ZiZ/irgTD602loxRKbqyyn0u9dsi8T8t6Iqh/aQRXqZIzmLa2WMzMiB8FODq
	fzlNw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qgfnrd46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 09:17:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46V9Cv8r021718;
	Wed, 31 Jul 2024 09:17:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qgfnrd44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 09:17:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46V8U0qw018928;
	Wed, 31 Jul 2024 09:17:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7ptnkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 09:17:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46V9HhgJ58392978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 09:17:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8200A2004D;
	Wed, 31 Jul 2024 09:17:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A782004B;
	Wed, 31 Jul 2024 09:17:42 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.43.69.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 31 Jul 2024 09:17:42 +0000 (GMT)
Date: Wed, 31 Jul 2024 14:47:38 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: Juan =?utf-8?B?Sm9zw6k=?= Arboleda <soyjuanarbol@gmail.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Replace <asm/processor.h> with
 <linux/processor.h> in sched.h
Message-ID: <n2ws7azgzp6mrrj4cl54xu36yjri5lbm4xo7edewjecti3623g@ra2dgaitoicb>
References: <ZqnuP-_AF3mVrN3E@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqnuP-_AF3mVrN3E@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: npPzLsnd35ahKG724JfotDFTirzr0GR4
X-Proofpoint-GUID: HyDZwjT0QA3yOBcjmDqIAotowYnh2mqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_06,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=479 clxscore=1011
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310066

On Wed, Jul 31, 2024 at 02:56:47AM GMT, Juan José Arboleda wrote:
> The sched.h header file currently includes the architecture-specific
> <asm/processor.h> header. This commit replaces it with the more general
> <linux/processor.h> header to ensure broader compatibility and to
> streamline the code.
> 
> This change helps in reducing architecture-specific dependencies in
> scheduler code, making it more portable and easier to maintain.
> 
> Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>

Build and bootup Tested on ppc64le and x86.

Tested-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Reviewed-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

