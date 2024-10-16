Return-Path: <linux-kernel+bounces-368016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F69A09D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB33AB277F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668F208201;
	Wed, 16 Oct 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lzx22hkL"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD61DFF5;
	Wed, 16 Oct 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081844; cv=none; b=MTomKPgic//cE3nJvITHPKKfDZqT7Pr0qmZubpzMAiQpjVjpveS7SxixP2UXOk+iDmw0qhXVBUrRjzQr5RRXc5gBOJENeUn+auE9Dsw7gQS+2bciu72S66Mp+0HaT+iiqX2Sg8lcdiFJtmfWDgks8Rhx0YYxI4/TJQOnaDIXpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081844; c=relaxed/simple;
	bh=8ItB8GX4brTAtKv9DPFQRgvH2s2EG6Du2d7C4auImP0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=epjYu/G8VcUZ9cf3wwkhE8tf1sYVxxzyxMnXVfD1OcKFVCIaeC0dSoiFtqk5gC5L5fLVzyGR/XHA7FUtg8Awk5l86U2IzJBgbvooJMo6s8GeeDZvkN0YaiI0ZgAHYQ1znOqD1MiMSdYq06NaYnDPfA1SaMdELKOk85qfRavxb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lzx22hkL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GCThTD014061;
	Wed, 16 Oct 2024 12:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NP+q8P
	lXDawFgvRDYFei3jtXLCEGrXvSZgAkTMaquMg=; b=lzx22hkLX2wjJFOq6McD05
	bsy8aeJo4dZIB5/H89hhnEQ5l57ndsnhnaL4XGFv1DeJgldVNFl8576Z6v+ZtfPD
	KnQI9G4kEZq+bBpYTKqJyAYBRhUcVZuXb4Mv0ktDZvMQ+E8TlDtApQtD8RAuw8WE
	mvrFqhvu0BFSf0G4zf+KK4NXpLZaGRHWZ63swmglZemuYLSXRzeeEHA2PhXPevKZ
	Tjv/BkFJC2uwl5qpffORMryDLrf84tmDGFnJISdBLR/BdaPfPld1lPa92PIq119o
	I4LDkPdDQ5m583IYHfbI3re8e0evR2vQFiHy0ZTx5w6hRZB5Yx7ReUOhbOR4Z6kg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42adhqg094-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 12:30:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GCUXI1016152;
	Wed, 16 Oct 2024 12:30:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42adhqg08w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 12:30:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAIYQ7006405;
	Wed, 16 Oct 2024 12:30:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk97nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 12:30:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GCUSb622806846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 12:30:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C9D720043;
	Wed, 16 Oct 2024 12:30:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E6C220040;
	Wed, 16 Oct 2024 12:30:23 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.244.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 12:30:22 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] tools/perf/tests: Remove duplicate evlist__delete in
 tests/tool_pmu.c
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <172892779762.897882.10648635927487710641.b4-ty@kernel.org>
Date: Wed, 16 Oct 2024 18:00:12 +0530
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D96F2226-12DA-4087-802B-74B347BFE43B@linux.vnet.ibm.com>
References: <20241013170732.71339-1-atrajeev@linux.vnet.ibm.com>
 <172892779762.897882.10648635927487710641.b4-ty@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5HNLB9f0Hp45-X39MzvxShrV9gbxJRzD
X-Proofpoint-ORIG-GUID: 6yOhLDAqGiOT7OTwDqwYVOVveR1iCt9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160077



> On 14 Oct 2024, at 11:13=E2=80=AFPM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> On Sun, 13 Oct 2024 22:37:32 +0530, Athira Rajeev wrote:
>=20
>> The testcase for tool_pmu failed in powerpc as below:
>>=20
>> ./perf test -v "Parsing without PMU name"
>>  8: Tool PMU                                                        :
>>  8.1: Parsing without PMU name                                      : =
FAILED!
>>=20
>> This happens when parse_events results in either skip or fail
>> of an event. Because the code invokes evlist__delete(evlist)
>> and "goto out".
>>=20
>> [...]
>=20
> Applied to perf-tools-next, thanks!

Thanks Namhyung for picking the change

Athira
>=20
> Best regards,
> Namhyung
>=20
>=20


