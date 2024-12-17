Return-Path: <linux-kernel+bounces-448652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DDB9F43B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA3116C8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6B15D5B8;
	Tue, 17 Dec 2024 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FE2HofH7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE078BF8;
	Tue, 17 Dec 2024 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416917; cv=none; b=kqPbu5wtK7rUDrD3VnYw7DGimRVqjFn6pswC1WXy3Dbo2wRogcQxSxKLI1XllibtrkMt4IJFr/GzB5t7OAbdVl1yAKUple0LVgPcVAApWiOX4iOKsW2MVSyKatkocpmUwI3rpx46xBs0g6fkK8a0jpWD5/Njm0vwX88SqFCQg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416917; c=relaxed/simple;
	bh=lJujcmki2E1QCLy9lJFM3wiLcOpdWB51VnE5Do17Jzg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RRGqX85qFUhXhFxyKUpa26Lz0fGEil2oWsQhUKoPxHoL6fE5sQzeycBeOSwBjLQMwafKYIq6SXxam9t8MUeSEkeJuF75cAcpibZLf1eyJngwV2MvLWpuQmBP/Ww+r2AZMzDIiQDu9eRRDyAtHlY6nz/UgY8sIeNsWk9iQ2TjH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FE2HofH7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH2I22V011211;
	Tue, 17 Dec 2024 06:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lJujcm
	ki2E1QCLy9lJFM3wiLcOpdWB51VnE5Do17Jzg=; b=FE2HofH7D4gnSIXORnexnR
	5tN2/QjPRExu4I7PfICzgUfRc2+iqF4xLMCFcp0IQbCqWNairzjVf2AihMNU4syo
	/2QI5lVxM2WYcnDvY3nArVKn8siYWI30uKLb1igknJQJVYwi1sLNql13gTkwx8Nt
	6zXM4hzZrV/Fq+hJSZ+pBKNNGg75gBqdtGd7CQcd72SX6BBNN8GYWbHhjVo96SeF
	wD3LUDnv8I+yWktRkQI3jdE8CtoEh/pNSjrf9lroPYvP0KplxCe/dDE5+cRKr0Av
	UsqSClEzbmUKHCc04ThOW3S0Mhg3S8sob0qsfFXzlCYxv0i/jrmH035Q1jKssr9w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jnp4kpyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:28:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BH6Meoc005960;
	Tue, 17 Dec 2024 06:28:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jnp4kpym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:28:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH6Odqa014340;
	Tue, 17 Dec 2024 06:28:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqy1p1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:28:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH6SDFS33096348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:28:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0005520040;
	Tue, 17 Dec 2024 06:28:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CFF2004B;
	Tue, 17 Dec 2024 06:28:02 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.252.224])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Dec 2024 06:28:02 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <173398725978.3728083.17030127353710822170.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 11:57:51 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        Ian Rogers <irogers@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5B2B419-C68C-45FA-9B79-7F6D5B138EDE@linux.vnet.ibm.com>
References: <20241205022305.158202-1-irogers@google.com>
 <173398725978.3728083.17030127353710822170.b4-ty@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ux5MpVD-iVGKDygw1UrsRiXYDjXVn9UE
X-Proofpoint-ORIG-GUID: WghpnKfIFFSxB4-Dn2KxtR2UNZslH1of
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170047



> On 12 Dec 2024, at 12:37=E2=80=AFPM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> On Wed, 04 Dec 2024 18:23:05 -0800, Ian Rogers wrote:
>=20
>> The refactoring of tool PMU events to have a PMU then adding the expr
>> literals to the tool PMU made it so that the literal system_tsc_freq
>> was only supported on x86. Update the test expectations to match -
>> namely the parsing is x86 specific and only yields a non-zero value =
on
>> Intel.
>>=20
>>=20
>> [...]
>=20
> Applied to perf-tools, thanks!
>=20
> Best regards,
> Namhyung
>=20
Thanks Namhyung for pulling this in=20

Athira=

