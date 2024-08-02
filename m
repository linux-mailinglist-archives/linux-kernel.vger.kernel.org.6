Return-Path: <linux-kernel+bounces-272189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3294586C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC441C23508
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C379A15B12D;
	Fri,  2 Aug 2024 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cfNOIWcp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8B15AD9C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582579; cv=none; b=O6Vu79MnR505uGNKGHZhTDGzwBhC2QzSyeLXEPH77+W0tu6zHmsthNmnt8l+RhAiusyFbQ+/JuItWkQhnG9q8mkS+jbpnJYu793NmU1j+sYaU+g8PG+T0Dr0E3n2ncv4f5rIFtxVuxjUoJ8Hwn7qsEfp87Bki5e3DnK5SlsqoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582579; c=relaxed/simple;
	bh=hMiBlKDN58PswalzrIqaXOCk4IQmXtzaGtMOuqtse7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfPaPVW+WQN48Ycx3Wde0OhZmYq3LQ08xiw4H/pgdKu9UN4egtcxWIWixSNgMjiS3N+FDYOlWMGm9qv2ZO4bGGkqTkGyUxLI5aDGYMIBhqEvZGwr33TUNIItr3KGiynCQT0pMGp1L4gwQdCC5kVWz+IYneOh9qoIrra6wTmB1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cfNOIWcp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4726Rt1b015694;
	Fri, 2 Aug 2024 07:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	hMiBlKDN58PswalzrIqaXOCk4IQmXtzaGtMOuqtse7k=; b=cfNOIWcpt2OprGzz
	Xf8awKLlVxqI49CAIuH5WebVSDBW2+iM+5+QaP0PdGCfIDJhg35VmDO3Xf2zr5Go
	xhdyR5f+ZJ7+nTYXlEZpSBz56W1vfK2HdO4cfpmGcyQMglMfTeAu+5R5zIC95UIW
	77Dqfnd2GDAJZoP/BOHe2+fBvbv06urE4FAmE8VqSfeOqQcNQU9IujyzEZ60Ompz
	ARbprePoCP40CPh1ui8qEM5p4V4B2fH0MWFz9d9BYn64cQjBNyn/8nPZCAkTs6Ab
	b1TA465SN+g8Wk6ElhuQs36NhV2fU0n5gsPXkcmJTaOnvUrBI6d3ZG0L56kZ1n2K
	dE8llw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rq508crt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 07:09:28 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47279RxL023009;
	Fri, 2 Aug 2024 07:09:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rq508crr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 07:09:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4723WEQA003935;
	Fri, 2 Aug 2024 07:09:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemwr3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 07:09:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47279NuW54395136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 07:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 838102004B;
	Fri,  2 Aug 2024 07:09:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7DF20043;
	Fri,  2 Aug 2024 07:09:23 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.18.251])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 07:09:23 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH] workqueue: Remove incorrect
 "WARN_ON_ONCE(!list_empty(&worker->entry));" from dying worker
In-Reply-To: <CAJhGHyD7Ligkp4Ww0STbj=p=igOmORQP86XyB-CmQ0wGqK351Q@mail.gmail.com>
References: <20240725010437.694727-1-jiangshanlai@gmail.com>
 <87wml4s9zz.fsf@linux.ibm.com>
 <CAJhGHyD7Ligkp4Ww0STbj=p=igOmORQP86XyB-CmQ0wGqK351Q@mail.gmail.com>
Date: Fri, 02 Aug 2024 09:09:22 +0200
Message-ID: <87ikwjo0yl.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FJnCimlD5O53tn3wcokeWmOago2V53c_
X-Proofpoint-ORIG-GUID: NPMp9irE41fuqtVXBcWlPGQ8RTpAStKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_04,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408020047

On Thu, Aug 01, 2024 at 11:11 AM +0800, Lai Jiangshan <jiangshanlai@gmail.c=
om> wrote:
> Hello, Tejun
>
> On Mon, Jul 29, 2024 at 7:39=E2=80=AFPM Marc Hartmayer <mhartmay@linux.ib=
m.com> wrote:
>
>>
>> [=E2=80=A6snip]
>>
>> The crash I reported is fixed by this patch. But I can't say whether the
>> removal of the warning is OK.
>>
>
> Could you have a look at it please?

Hi Lai,

I am not familiar with the code, so I cannot give a qualified answer.
But if it helps, here is my

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

>
> Thanks
> Lai

