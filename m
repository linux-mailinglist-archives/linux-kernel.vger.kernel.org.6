Return-Path: <linux-kernel+bounces-229320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18484916E45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A351C21AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB24175544;
	Tue, 25 Jun 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EK8w1ZsM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A186174EC6;
	Tue, 25 Jun 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333734; cv=none; b=mBFyi0+8rYZ8Wvbx51PWfWZpdIU2vylN7yi0jxAH49Obi+scTVvrUsmzzda5TByKjOutHVbcIrLe43aGTylMe9OlnBND+lPACMq9MXTMeDto04En5mxX3oxU5MdhbLKpaKpH9Uh4yYoQn60h9t/A2Txv1ZNUUV9cRcj6uEi3JuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333734; c=relaxed/simple;
	bh=Wf5d1cAbraKNNLLsxaDY7HIAmqmsnAVAz5zc31fMG9g=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=bcnYpjh1Cd0/XqgDEun6/wRs5JTQ1qMQAxjjXS+mGanXMsrQtZvm10oBBUtouQGt8bv8RgGjZDyvo6bJy2xeHPZ2WVgfyDoev5pJIMHpVSrJEq+7iCbqb9bTwlx7O1qqdtgz0jh8eURS5raqvjVKzsDP0lS8XOGPyWxZTLmUCa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EK8w1ZsM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PFT00u016014;
	Tue, 25 Jun 2024 16:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=ZARhP07FHH8u9nngY6BsvG1uJZmY+u9zga9ydRnpEXE=; b=EK8w1ZsMyz2B
	P3BMLqfzuE/aZpn0SjoZMjGSfizBkEUCLYDeyPJiLjZGUWmQEw8kYZ/lZYY0nJ3A
	RDahhEXcKOkdYmhgxU/HCxieDwnqqq1SR6XzxiFGTqas6GT2e2pP67QDfWzfDaVw
	LXx50x5OvBwqCPYg8Q1+d/x9hLsVYg+o4f3L4YRJbU7gpp9NN65kcSH5rLHj48nZ
	3W2d5K1JL60NHwvaBQ/JMHXsku17VAgUBgTOfkE5rwga1yY39N3GMYMHSnH69Gct
	Rj9aId4Rry26veXCIVLtkQIpGi9PbgJ/91HahgKxY+lgcQUApO8SFujoBKgBFHBK
	F5fVGG3lnw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4000jj85ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 16:42:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45PEUI0j008184;
	Tue, 25 Jun 2024 16:42:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b0qj5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 16:42:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PGg6qN19464448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 16:42:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E46E420043;
	Tue, 25 Jun 2024 16:42:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84D452005A;
	Tue, 25 Jun 2024 16:42:03 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.74.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 16:42:03 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH V3 1/3] tools/perf: Fix the string match for
 "/tmp/perf-$PID.map" files in dso__load
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <adc971c5-f2a7-4f2d-97d8-40ed0cfe03c0@arm.com>
Date: Tue, 25 Jun 2024 22:11:51 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akanksha@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Message-Id: <D86EB354-77A9-494B-BE89-61FD6EC269A8@linux.vnet.ibm.com>
References: <20240618140354.5765-1-atrajeev@linux.vnet.ibm.com>
 <adc971c5-f2a7-4f2d-97d8-40ed0cfe03c0@arm.com>
To: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R4zC742nlgAmM6T5Q2NbKRczbjMC9Iaw
X-Proofpoint-ORIG-GUID: R4zC742nlgAmM6T5Q2NbKRczbjMC9Iaw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250118



> On 23 Jun 2024, at 8:56=E2=80=AFPM, Chaitanya S Prakash <chaitanyas.praka=
sh@arm.com> wrote:
>=20
>=20
> On 6/18/24 19:33, Athira Rajeev wrote:
>> Perf test for perf probe of function from different CU fails
>> as below:
>>=20
>> ./perf test -vv "test perf probe of function from different CU"
>> 116: test perf probe of function from different CU:
>> --- start ---
>> test child forked, pid 2679
>> Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa7iy89bx=
/testfile
>>  Error: Failed to add events.
>> --- Cleaning up ---
>> "foo" does not hit any event.
>>  Error: Failed to delete events.
>> ---- end(-1) ----
>> 116: test perf probe of function from different CU                   : F=
AILED!
>>=20
>> The test does below to probe function "foo" :
>>=20
>> # gcc -g -Og -flto -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfi=
le-foo.c
>> -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
>> # gcc -g -Og -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-mai=
n.c
>> -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
>> # gcc -g -Og -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
>> /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
>> /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
>>=20
>> # ./perf probe -x /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile f=
oo
>> Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7=
/testfile
>>   Error: Failed to add events.
>>=20
>> Perf probe fails to find symbol foo in the executable placed in
>> /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7
>>=20
>> Simple reproduce:
>>=20
>>  # mktemp -d /tmp/perf-checkXXXXXXXXXX
>>    /tmp/perf-checkcWpuLRQI8j
>>=20
>>  # gcc -g -o test test.c
>>  # cp test /tmp/perf-checkcWpuLRQI8j/
>>  # nm /tmp/perf-checkcWpuLRQI8j/test | grep foo
>>    00000000100006bc T foo
>>=20
>>  # ./perf probe -x /tmp/perf-checkcWpuLRQI8j/test foo
>>    Failed to find symbol foo in /tmp/perf-checkcWpuLRQI8j/test
>>       Error: Failed to add events.
>>=20
>> But it works with any files like /tmp/perf/test. Only for
>> patterns with "/tmp/perf-", this fails.
>>=20
>> Further debugging, commit 80d496be89ed ("perf report: Add support
>> for profiling JIT generated code") added support for profiling JIT
>> generated code. This patch handles dso's of form
>> "/tmp/perf-$PID.map" .
>>=20
>> The check used "if (strncmp(self->name, "/tmp/perf-", 10) =3D=3D 0)"
>> to match "/tmp/perf-$PID.map". With this commit, any dso in
>> /tmp/perf- folder will be considered separately for processing
>> (not only JIT created map files ). Fix this by changing the
>> string pattern to check for "/tmp/perf-%d.map". Add a helper
>> function is_perf_pid_map_name to do this check.
>>=20
>> With the fix,
>> # ./perf test "test perf probe of function from different CU"
>> 117: test perf probe of function from different CU                   : Ok
>>=20
>> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
>> ---
>> Changelog:
>> v2 -> v3:
>> Addressed review comment from Adrian and James.
>> Added perf_pid_map_tid to save the tid and modified
>> is_perf_pid_map_name to use this internally.
>>=20
>> v1 -> v2:
>> Addressed review comments from Adrian.
>> Added helper function is_perf_pid_map_name to check
>> dso name of form "/tmp/perf-%d.map". Used sscanf
>> instead of regex comparison.
>>=20
>>  tools/perf/util/dso.c    | 12 ++++++++++++
>>  tools/perf/util/dso.h    |  4 ++++
>>  tools/perf/util/symbol.c |  3 ++-
>>  3 files changed, 18 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>> index dde706b71da7..2340c4f6d0c2 100644
>> --- a/tools/perf/util/dso.c
>> +++ b/tools/perf/util/dso.c
>> @@ -1652,3 +1652,15 @@ int dso__strerror_load(struct dso *dso, char *buf=
, size_t buflen)
>>   scnprintf(buf, buflen, "%s", dso_load__error_str[idx]);
>>   return 0;
>>  }
>> +
>> +bool perf_pid_map_tid(const char *dso_name, int *tid)
>> +{
>> + return sscanf(dso_name, "/tmp/perf-%d.map", tid) =3D=3D 1;
>> +}
>> +
>> +bool is_perf_pid_map_name(const char *dso_name)
>> +{
>> + int tid;
>> +
>> + return perf_pid_map_tid(dso_name, &tid);
>> +}
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index df2c98402af3..d72f3b8c37f6 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
>> @@ -809,4 +809,8 @@ void reset_fd_limit(void);
>>  u64 dso__find_global_type(struct dso *dso, u64 addr);
>>  u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
>>  +/* Check if dso name is of format "/tmp/perf-%d.map" */
>> +bool perf_pid_map_tid(const char *dso_name, int *tid);
>> +bool is_perf_pid_map_name(const char *dso_name);
>> +
>>  #endif /* __PERF_DSO */
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index 9e5940b5bc59..aee0a4cfb383 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1799,7 +1799,8 @@ int dso__load(struct dso *dso, struct map *map)
>>   const char *map_path =3D dso__long_name(dso);
>>     mutex_lock(dso__lock(dso));
>> - perfmap =3D strncmp(dso__name(dso), "/tmp/perf-", 10) =3D=3D 0;
>> + perfmap =3D is_perf_pid_map_name(map_path);
>> +
>>   if (perfmap) {
>>   if (dso__nsinfo(dso) &&
>>      (dso__find_perf_map(newmapname, sizeof(newmapname),
>=20
> Reviewed-by: Chaitanya S Prakash<chaitanyas.prakash@arm.com>

Thanks Chaitanya for the reviewed-by

Athira
>=20
> I will drop my fix for the same.
> https://lore.kernel.org/all/20240601125946.1741414-10-ChaitanyaS.Prakash@=
arm.com/
>=20
> The rest of my series can be reviewed as a string function tidy up.
>=20


