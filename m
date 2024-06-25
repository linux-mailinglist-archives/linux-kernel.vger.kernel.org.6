Return-Path: <linux-kernel+bounces-228891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9691683F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC522282B95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22590156F4A;
	Tue, 25 Jun 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TLZWbw3r"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9D1482F8;
	Tue, 25 Jun 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319405; cv=none; b=Q4clF7Zro8KRIXbRet79VWVVm5Y87R0jpvyO742LttgvGL65oO301mZGHfQOWbqMUAzEn48M+tcgY/9ZGwYO28x4Be14ZmbvQoXAKB2t6LGHhwDBVxBuAX9vA31WZISnyW47s0SnQSlHqIyhlVu4TWrwfawxoKSZhSmBx9apmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319405; c=relaxed/simple;
	bh=BytIXqEwQC1JIkV5nus82zZgBpx8sKpOUW74s1/WyBs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k+z9KV+n7B0T5MP7YGree0EyQsDKz3dmeLfVgBJbx0Pjgjd4WdxXLGKtsZ4x1x00cfHFBvmOmmIehkPzBIShrlYvrNDzbQPCkUnNyPFtorvgzmSBGr1l0vxW6XRL2p+S1ChdDxgBt057BRPJnuyHHZPuf42Hyvs+WnVvYatQ+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TLZWbw3r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBvhYu030315;
	Tue, 25 Jun 2024 12:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=l
	MCw3Zr8bTjh4mqMUsvWrONi+bcQl/JDNBQHOpwyAWI=; b=TLZWbw3r3CuJnzbwy
	ktpIBK4DkTve8oaKl5tYfM5ovUZIqf4Vpc5/rqDUGMICa87AgCu4atNNlmPRjGqq
	E4hIs4k2X9rLitd/S0X0Q0W68dnLsGCWJnxeUBHhDm2sdLjHjJlGGE3MOzLoWYRd
	nI8Bhbk42B+wh/7nxeV3MqLbiZiZc5SzhggSOJGGlOnVSMTz0c+0kZL8NFKRDIef
	AaOvhzhc5gGlSjLAweSI1M261AFYMixMvNQeE+aqM/vQ1qWmEG669t5wt2Xn9+mE
	pZzvdM7/ucJbI8to3f3HGxTaYmpZiuIxFlafZ/Tkbplncv7vs5T9yYxdzxqapnLF
	DXO2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yytuqrknh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:43:13 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45PChChE014052;
	Tue, 25 Jun 2024 12:43:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yytuqrknc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:43:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P9awP2000397;
	Tue, 25 Jun 2024 12:43:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn35yhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:43:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PCh6kJ53084574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 12:43:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18DF420043;
	Tue, 25 Jun 2024 12:43:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D0C020040;
	Tue, 25 Jun 2024 12:43:03 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.30.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 12:43:03 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [V4 05/16] tools/perf: Add disasm_line__parse to parse raw
 instruction for powerpc
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZnpYBvXLhyAqZzvh@google.com>
Date: Tue, 25 Jun 2024 18:12:51 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akanksha@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2A1A4AA-E344-4B42-86CE-E0EDD82A398F@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-6-atrajeev@linux.vnet.ibm.com>
 <ZnpYBvXLhyAqZzvh@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w71VKuhSdEP9tjFrizwxxvtPffvOcCSa
X-Proofpoint-ORIG-GUID: RYBoERuCe6STEsWk4xJCtKCgQ2AwCZan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250091



> On 25 Jun 2024, at 11:09=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> On Fri, Jun 14, 2024 at 10:56:20PM +0530, Athira Rajeev wrote:
>> Currently, the perf tool infrastructure disasm_line__parse function =
to
>> parse disassembled line.
>>=20
>> Example snippet from objdump:
>> objdump  --start-address=3D<address> --stop-address=3D<address>  -d =
--no-show-raw-insn -C <vmlinux>
>>=20
>> c0000000010224b4: lwz     r10,0(r9)
>>=20
>> This line "lwz r10,0(r9)" is parsed to extract instruction name,
>> registers names and offset. In powerpc, the approach for data type
>> profiling uses raw instruction instead of result from objdump to =
identify
>> the instruction category and extract the source/target registers.
>>=20
>> Example: 38 01 81 e8     ld      r4,312(r1)
>>=20
>> Here "38 01 81 e8" is the raw instruction representation. Add =
function
>> "disasm_line__parse_powerpc" to handle parsing of raw instruction.
>> Also update "struct disasm_line" to save the binary code/
>> With the change, function captures:
>>=20
>> line -> "38 01 81 e8     ld      r4,312(r1)"
>> raw instruction "38 01 81 e8"
>>=20
>> Raw instruction is used later to extract the reg/offset fields. =
Macros
>> are added to extract opcode and register fields. "struct disasm_line"
>> is updated to carry union of "bytes" and "raw_insn" of 32 bit to =
carry raw
>> code (raw). Function "disasm_line__parse_powerpc fills the raw
>> instruction hex value and can use macros to get opcode. There is no
>> changes in existing code paths, which parses the disassembled code.
>> The architecture using the instruction name and present approach is
>> not altered. Since this approach targets powerpc, the macro
>> implementation is added for powerpc as of now.
>>=20
>> Since the disasm_line__parse is used in other cases (perf annotate) =
and
>> not only data tye profiling, the powerpc callback includes changes to
>> work with binary code as well as mneumonic representation. Also in =
case
>> if the DSO read fails and libcapstone is not supported, the approach
>> fallback to use objdump as option. Hence as option, patch has changes =
to
>> ensure objdump option also works well.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/include/linux/string.h                  |  2 +
>> tools/lib/string.c                            | 13 ++++
>> .../perf/arch/powerpc/annotate/instructions.c |  1 +
>> tools/perf/arch/powerpc/util/dwarf-regs.c     |  9 +++
>> tools/perf/util/annotate.h                    |  5 +-
>> tools/perf/util/disasm.c                      | 59 =
++++++++++++++++++-
>> 6 files changed, 87 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/include/linux/string.h =
b/tools/include/linux/string.h
>> index db5c99318c79..0acb1fc14e19 100644
>> --- a/tools/include/linux/string.h
>> +++ b/tools/include/linux/string.h
>> @@ -46,5 +46,7 @@ extern char * __must_check skip_spaces(const char =
*);
>>=20
>> extern char *strim(char *);
>>=20
>> +extern void remove_spaces(char *s);
>> +
>> extern void *memchr_inv(const void *start, int c, size_t bytes);
>> #endif /* _TOOLS_LINUX_STRING_H_ */
>> diff --git a/tools/lib/string.c b/tools/lib/string.c
>> index 8b6892f959ab..3126d2cff716 100644
>> --- a/tools/lib/string.c
>> +++ b/tools/lib/string.c
>> @@ -153,6 +153,19 @@ char *strim(char *s)
>> return skip_spaces(s);
>> }
>>=20
>> +/*
>> + * remove_spaces - Removes whitespaces from @s
>> + */
>> +void remove_spaces(char *s)
>> +{
>> + char *d =3D s;
>> +
>> + do {
>> + while (*d =3D=3D ' ')
>> + ++d;
>> + } while ((*s++ =3D *d++));
>> +}
>> +
>> /**
>>  * strreplace - Replace all occurrences of character in string.
>>  * @s: The string to operate on.
>> diff --git a/tools/perf/arch/powerpc/annotate/instructions.c =
b/tools/perf/arch/powerpc/annotate/instructions.c
>> index a3f423c27cae..d57fd023ef9c 100644
>> --- a/tools/perf/arch/powerpc/annotate/instructions.c
>> +++ b/tools/perf/arch/powerpc/annotate/instructions.c
>> @@ -55,6 +55,7 @@ static int powerpc__annotate_init(struct arch =
*arch, char *cpuid __maybe_unused)
>> arch->initialized =3D true;
>> arch->associate_instruction_ops =3D =
powerpc__associate_instruction_ops;
>> arch->objdump.comment_char      =3D '#';
>> + annotate_opts.show_asm_raw =3D true;
>=20
> Right, I think this will add the raw insn in the output of objdump, =
no?
> Why not using the information?

Shared response in previous patch
>=20
>> }
>>=20
>> return 0;
>> diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c =
b/tools/perf/arch/powerpc/util/dwarf-regs.c
>> index 0c4f4caf53ac..430623ca5612 100644
>> --- a/tools/perf/arch/powerpc/util/dwarf-regs.c
>> +++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
>> @@ -98,3 +98,12 @@ int regs_query_register_offset(const char *name)
>> return roff->ptregs_offset;
>> return -EINVAL;
>> }
>> +
>> +#define PPC_OP(op) (((op) >> 26) & 0x3F)
>> +#define PPC_RA(a) (((a) >> 16) & 0x1f)
>> +#define PPC_RT(t) (((t) >> 21) & 0x1f)
>> +#define PPC_RB(b) (((b) >> 11) & 0x1f)
>> +#define PPC_D(D) ((D) & 0xfffe)
>> +#define PPC_DS(DS) ((DS) & 0xfffc)
>> +#define OP_LD 58
>> +#define OP_STD 62
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index d5c821c22f79..9ba772f46270 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -113,7 +113,10 @@ struct annotation_line {
>> struct disasm_line {
>> struct ins  ins;
>> struct ins_operands  ops;
>> -
>> + union {
>> + u8 bytes[4];
>> + u32 raw_insn;
>> + } raw;
>> /* This needs to be at the end. */
>> struct annotation_line  al;
>> };
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index b81cdcf4d6b4..1e8568738b38 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -45,6 +45,7 @@ static int call__scnprintf(struct ins *ins, char =
*bf, size_t size,
>>=20
>> static void ins__sort(struct arch *arch);
>> static int disasm_line__parse(char *line, const char **namep, char =
**rawp);
>> +static int disasm_line__parse_powerpc(struct disasm_line *dl);
>>=20
>> static __attribute__((constructor)) void symbol__init_regexpr(void)
>> {
>> @@ -844,6 +845,59 @@ static int disasm_line__parse(char *line, const =
char **namep, char **rawp)
>> return -1;
>> }
>>=20
>> +/*
>> + * Parses the result captured from symbol__disassemble_*
>> + * Example, line read from DSO file in powerpc:
>> + * line:    38 01 81 e8
>> + * opcode: fetched from arch specific get_opcode_insn
>> + * rawp_insn: e8810138
>> + *
>> + * rawp_insn is used later to extract the reg/offset fields
>> + */
>> +#define PPC_OP(op) (((op) >> 26) & 0x3F)
>> +
>> +static int disasm_line__parse_powerpc(struct disasm_line *dl)
>> +{
>> + char *line =3D dl->al.line;
>> + const char **namep =3D &dl->ins.name;
>> + char **rawp =3D &dl->ops.raw;
>> + char tmp, *tmp_raw_insn, *name_raw_insn =3D skip_spaces(line);
>> + char *name =3D skip_spaces(name_raw_insn + 11);
>> + int objdump =3D 0;
>> +
>> + if (strlen(line) > 11)
>> + objdump =3D 1;
>> +
>> + if (name_raw_insn[0] =3D=3D '\0')
>> + return -1;
>> +
>> + if (objdump) {
>> + *rawp =3D name + 1;
>> + while ((*rawp)[0] !=3D '\0' && !isspace((*rawp)[0]))
>> + ++*rawp;
>> + tmp =3D (*rawp)[0];
>> + (*rawp)[0] =3D '\0';
>> +
>> + *namep =3D strdup(name);
>> + if (*namep =3D=3D NULL)
>> + return -1;
>> +
>> + (*rawp)[0] =3D tmp;
>> + *rawp =3D strim(*rawp);
>> + } else
>> + *namep =3D "";
>> +
>> + tmp_raw_insn =3D strdup(name_raw_insn);
>> + tmp_raw_insn[11] =3D '\0';
>> + remove_spaces(tmp_raw_insn);
>> +
>> + dl->raw.raw_insn =3D strtol(tmp_raw_insn, NULL, 16);
>> + if (objdump)
>> + dl->raw.raw_insn =3D be32_to_cpu(strtol(tmp_raw_insn, NULL, 16));
>=20
> Hmm.. can you use a sscanf() instead?
>=20
>  sscanf(line, "%x %x %x %x", &dl->raw.bytes[0], &dl->raw.bytes[1], =
...)
>=20
> Thanks,
> Namhyung
>=20
Sure will address in V5

Thanks
Athira
>> +
>> + return 0;
>> +}
>> +
>> static void annotation_line__init(struct annotation_line *al,
>>   struct annotate_args *args,
>>   int nr)
>> @@ -897,7 +951,10 @@ struct disasm_line *disasm_line__new(struct =
annotate_args *args)
>> goto out_delete;
>>=20
>> if (args->offset !=3D -1) {
>> - if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < =
0)
>> + if (arch__is(args->arch, "powerpc")) {
>> + if (disasm_line__parse_powerpc(dl) < 0)
>> + goto out_free_line;
>> + } else if (disasm_line__parse(dl->al.line, &dl->ins.name, =
&dl->ops.raw) < 0)
>> goto out_free_line;
>>=20
>> disasm_line__init_ins(dl, args->arch, &args->ms);
>> --=20
>> 2.43.0



