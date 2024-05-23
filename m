Return-Path: <linux-kernel+bounces-187600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7A8CD51A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C271F2372D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6A14AD35;
	Thu, 23 May 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jo9GUH+p"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC61E495;
	Thu, 23 May 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472595; cv=none; b=CYgviUl9tZ+CErjho2AiUp0c0mao5WlrW871/VlDdX3DicEo9OOBjcki8ubCUp62F4Hqpf31xFE66SnsiHUqSknS8r3DOO/E+l+eTkdcx8nmwH89HgDbJZCnwG1JDKmrAye+23wxstj/yVct8bBhRfAdolZNkHDJuoQorp81Iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472595; c=relaxed/simple;
	bh=Xb8qO2I41gJcHZg83FegyaOw4Ohk0PqglR2+mgaZJ74=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oBSMvn5/elbSevzGuaDEaTXI63y+y78iePgvQ9QLMcyLrmbJcfnnWMzHbKwHPVhJFblKY8VGsUwLFT9PVCtgoszuG9oIgw7DkdOrbb76bQn9cFBPPa//X5jTHhyM7C4msrOo9KQAkFerGsx8JR/ppCVnDlhgk7SQFVQQPhMsfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jo9GUH+p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NDs9Cu009986;
	Thu, 23 May 2024 13:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=IiDcpBAtwCTauEs5A24TvczuaU3DEm7tWLmbfvMJP44=;
 b=Jo9GUH+pzRvzG41lqiBKWP4a2mXZ1n7xpfqm7DOFY+2CTH/Jbz5U1X9YfIa7G9Ni5FTl
 /PBxWRidk7Q+HNyxrn0IAFst+ZhZJNCLqQUgcuoX3BBnMBeBUuDtNlxPcOPguwVKkExx
 t4ncVrg3NLqu49zkXFBwi/WRLX1ylQMNLwA0JaP7s2vAuqd7FbG5wpV+bfPw3ghUk1lf
 3jKpo2+klEU7YQyVr1BTIYROJujdUstDxhxXTvkLZMyQRJWjtuV78lJlEVGg60O/DJ9x
 r4gcFAzvCO5xrxg/pJXVyAkO2koNie91eLjrVQzdobNA0/HY+xKbttVbbYdQe4kYr7pO sA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya73700cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:56:17 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44NDuHac013471;
	Thu, 23 May 2024 13:56:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya73700ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:56:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44NDpvd0022240;
	Thu, 23 May 2024 13:56:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y76nu2jgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:56:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44NDuAsC13107528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 13:56:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC2442004B;
	Thu, 23 May 2024 13:56:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 275AC20049;
	Thu, 23 May 2024 13:56:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.97.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 May 2024 13:56:07 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH V2 7/9] tools/perf: Update instruction tracking with add
 instruction
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <7c8af115-56fb-4b1f-818c-f2a7d532166b@csgroup.eu>
Date: Thu, 23 May 2024 19:25:55 +0530
Cc: "acme@kernel.org" <acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "segher@kernel.crashing.org" <segher@kernel.crashing.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "disgoel@linux.vnet.ibm.com" <disgoel@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akanksha@linux.ibm.com" <akanksha@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07BB6C89-D014-44EF-87A7-42A15C43EDD6@linux.vnet.ibm.com>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
 <20240506121906.76639-8-atrajeev@linux.vnet.ibm.com>
 <7c8af115-56fb-4b1f-818c-f2a7d532166b@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gRgaGV3KD953S74j9LgzaKHKTLDSHr2L
X-Proofpoint-GUID: 6dP_0A09OfUJccs6J35rocteLegzsgBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_08,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405230096



> On 7 May 2024, at 3:28=E2=80=AFPM, Christophe Leroy =
<christophe.leroy@csgroup.eu> wrote:
>=20
>=20
>=20
> Le 06/05/2024 =C3=A0 14:19, Athira Rajeev a =C3=A9crit :
>> Update instruction tracking with add instruction. Apart from "mr"
>> instruction, the register state is carried on by other insns, ie,
>> "add, addi, addis". Since these are not memory instructions and =
doesn't
>> fall in the range of (32 to 63), add these as part of nmemonic table.
>> For now, add* instructions are added. There is possibility of getting
>> more added here. But to extract regs, still the binary code will be
>> used. So associate this with "load_store_ops" itself and no other
>> changes required.
>=20
> Looks fragile.
>=20
> How do you handle addc, adde, addic ?
> And also addme, addze, which only have two operands instead of 3 ?

Hi Christophe,

Thanks for pointing these cases. Will address these cases in next =
version

Thanks
Athira
>=20
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>>  .../perf/arch/powerpc/annotate/instructions.c | 21 =
+++++++++++++++++++
>>  tools/perf/util/disasm.c                      |  1 +
>>  2 files changed, 22 insertions(+)
>>=20
>> diff --git a/tools/perf/arch/powerpc/annotate/instructions.c =
b/tools/perf/arch/powerpc/annotate/instructions.c
>> index cce7023951fe..1f35d8a65bb4 100644
>> --- a/tools/perf/arch/powerpc/annotate/instructions.c
>> +++ b/tools/perf/arch/powerpc/annotate/instructions.c
>> @@ -1,6 +1,17 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <linux/compiler.h>
>>=20
>> +/*
>> + * powerpc instruction nmemonic table to associate load/store =
instructions with
>> + * move_ops. mov_ops is used to identify add/mr to do instruction =
tracking.
>> + */
>> +static struct ins powerpc__instructions[] =3D {
>> + { .name =3D "mr",         .ops =3D &load_store_ops,  },
>> + { .name =3D "addi",       .ops =3D &load_store_ops,   },
>> + { .name =3D "addis",      .ops =3D &load_store_ops,  },
>> + { .name =3D "add",        .ops =3D &load_store_ops,  },
>> +};
>> +
>>  static struct ins_ops *powerpc__associate_instruction_ops(struct =
arch *arch, const char *name)
>>  {
>>   int i;
>> @@ -75,6 +86,9 @@ static void update_insn_state_powerpc(struct =
type_state *state,
>>   if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
>>   return;
>>=20
>> + if (!strncmp(dl->ins.name, "add", 3))
>> + goto regs_check;
>> +
>>   if (strncmp(dl->ins.name, "mr", 2))
>>   return;
>>=20
>> @@ -85,6 +99,7 @@ static void update_insn_state_powerpc(struct =
type_state *state,
>>   dst->reg1 =3D src_reg;
>>   }
>>=20
>> +regs_check:
>>   if (!has_reg_type(state, dst->reg1))
>>   return;
>>=20
>> @@ -115,6 +130,12 @@ static void update_insn_state_powerpc(struct =
type_state *state __maybe_unused, s
>>  static int powerpc__annotate_init(struct arch *arch, char *cpuid =
__maybe_unused)
>>  {
>>   if (!arch->initialized) {
>> + arch->nr_instructions =3D ARRAY_SIZE(powerpc__instructions);
>> + arch->instructions =3D calloc(arch->nr_instructions, sizeof(struct =
ins));
>> + if (!arch->instructions)
>> + return -ENOMEM;
>> + memcpy(arch->instructions, powerpc__instructions, sizeof(struct =
ins) * arch->nr_instructions);
>> + arch->nr_instructions_allocated =3D arch->nr_instructions;
>>   arch->initialized =3D true;
>>   arch->associate_instruction_ops =3D =
powerpc__associate_instruction_ops;
>>   arch->objdump.comment_char      =3D '#';
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index ac6b8b8da38a..32cf506a9010 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -36,6 +36,7 @@ static struct ins_ops mov_ops;
>>  static struct ins_ops nop_ops;
>>  static struct ins_ops lock_ops;
>>  static struct ins_ops ret_ops;
>> +static struct ins_ops load_store_ops;
>>=20
>>  static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
>>     struct ins_operands *ops, int max_ins_name);


