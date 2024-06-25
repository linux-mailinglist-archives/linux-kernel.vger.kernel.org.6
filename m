Return-Path: <linux-kernel+bounces-228883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C9916825
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11808286A26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F675158A26;
	Tue, 25 Jun 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YBi9HsPK"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA8157E74;
	Tue, 25 Jun 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319171; cv=none; b=tVJCLEP4ZbGUMHF333dYntfPsEE59IdpB08pPEIA5DQKASXBMWvL5achJU0Xwww0D7Do1qvieUE6gZotC8WSGjG2cDwwkv+mZbejk7ArYvDqV+JxjYDszKksanqxQMeI8gTEMUBtqheW37jqfCSAEsJCFCDDi1ifiNo6LpxSZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319171; c=relaxed/simple;
	bh=MZjLcKAK0U9G4BDHHC+9AaAu7a4co91ezazrOiCDWSI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uMsxlO1p9v5CgGZo5cYu52CJfxKRcEO3zJ4yBC6UbYaZUFHwNBrcPAjN22rehj6y8e1LkRHlxHK7GRhNbwE89MYrzeaVgWDwa+TfpTs/tik0Eq2b/m+seOiXQFxSidVhJdpUSzNFfvGPhXciXJB+Xkrsdt4lyUDm2P1g1Kh6K2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YBi9HsPK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PCQwQ5002249;
	Tue, 25 Jun 2024 12:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=pp1; bh=Z
	Nv6ASfku2ma1tXWeQNgZdAY+8xTVTAP6hp4KCSK4Io=; b=YBi9HsPKvcToXGveV
	Dc8XCGZWc2OIW/3tyCKwcyzfIcb+/3L9JpQsEM/SO9YtVtqXcUq5aKexRVDQ0emb
	GZlW9Du0kfsF6bPGFyZi9//IkQDUJ1au1j2I2mczsfEqagbWCrrRg85dEXK1BE+b
	UCmDlZnVkh8zA7/GIeT1BuWhiSosNkyt5kLK7Yszn0bCBztpw0RkAPz8PNENcb0L
	VrDy2wSOWP+5ZfhtoQpOTB2aKSQMLTqUKn5Z6yAXPJ9v/ziQ9hcdDZO+gjzw8tm8
	MlPfRBbKJXi7ziG17OtOX4kX1LWGeGPowscrrCViiZstpXK7Ubfq9s5IX91SZSnG
	B7wsQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyua4gdkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:39:11 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45PCdB1Z020705;
	Tue, 25 Jun 2024 12:39:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyua4gdkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:39:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45PBFtMn019533;
	Tue, 25 Jun 2024 12:39:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xpxcf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 12:39:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PCd49x10354988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 12:39:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 274762006E;
	Tue, 25 Jun 2024 12:39:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EA522004D;
	Tue, 25 Jun 2024 12:39:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.30.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 12:39:01 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [V4 03/16] tools/perf: Add support to capture and parse raw
 instruction in powerpc using dso__data_read_offset utility
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZnpVn1yLtDnRnTBh@google.com>
Date: Tue, 25 Jun 2024 18:08:49 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B834FFD2-AC2E-4F7F-9B0B-15CBFB19A6A7@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-4-atrajeev@linux.vnet.ibm.com>
 <ZnpVn1yLtDnRnTBh@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P-irrnqpnHeDhbkJai-Q-NFK4xXiDxce
X-Proofpoint-ORIG-GUID: OUmxz4vbXlb3CekdPxXLNlMBTvP4z9um
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250091



> On 25 Jun 2024, at 10:59=E2=80=AFAM, Namhyung Kim =
<namhyung@kernel.org> wrote:
>=20
> On Fri, Jun 14, 2024 at 10:56:18PM +0530, Athira Rajeev wrote:
>> Add support to capture and parse raw instruction in powerpc.
>> Currently, the perf tool infrastructure uses two ways to disassemble
>> and understand the instruction. One is objdump and other option is
>> via libcapstone.
>>=20
>> Currently, the perf tool infrastructure uses "--no-show-raw-insn" =
option
>> with "objdump" while disassemble. Example from powerpc with this =
option
>> for an instruction address is:
>>=20
>> Snippet from:
>> objdump  --start-address=3D<address> --stop-address=3D<address>  -d =
--no-show-raw-insn -C <vmlinux>
>>=20
>> c0000000010224b4: lwz     r10,0(r9)
>=20
> What about removing --no-show-raw-insn and parse the raw byte code in
> the output for powerpc?  I think it's better to support normal
> annotation together.
Hi Namhyung,

Yes, In the other patch in same series, I have added support for normal =
annotation together.
Patch 5 includes changes to work with binary code as well as mneumonic =
representation.

Example representation using --show-raw-insn in objdump gives result:

38 01 81 e8 ld r4,312(r1)

Patch5 has changes to use =E2=80=9Cobjdump=E2=80=9D with --show-raw-insn =
to read the raw instruction and also support normal annotation.
In case of data type profiling, with only sort keys, (type, typeoff) =
there is no need to disassemble and then get raw byte code.
Binary code can be read directly from the DSO. Compared to using =
objdump, directly reading from DSO will be faster in this case.
In summary, current patchset uses below approach:

1. Read directly from DSO using dso__data_read_offset if only =E2=80=9Ctyp=
e, typeoff=E2=80=9D is needed.
2. If in any case reading directly from DSO fails, fallback to using =
libcapstone. Using libcapstone to read is faster than objdump
3. If libcapstone is not supported, approach will use objdump. Patchset =
has changes to handle objdump result created with show-raw-ins in =
powerpc.=20
4. Also for normal perf report or perf annotate, approach will use =
objdump

NOTE:
libcapstone is used currently only for reading raw binary code. =
Disassemble is currently not enabled. While attempting to do cs_disasm, =
observation is that some of the instructions were not identified (ex: =
extswsli, maddld) and it had to fallback to use objdump. Hence enabling =
"cs_disasm" is added in comment section as a TODO for powerpc. Patch =
number 13.=20

Thanks
Athira

>=20
>>=20
>> This line "lwz r10,0(r9)" is parsed to extract instruction name,
>> registers names and offset. Also to find whether there is a memory
>> reference in the operands, "memory_ref_char" field of objdump is =
used.
>> For x86, "(" is used as memory_ref_char to tackle instructions of the
>> form "mov  (%rax), %rcx".
>>=20
>> In case of powerpc, not all instructions using "(" are the only =
memory
>> instructions. Example, above instruction can also be of extended form =
(X
>> form) "lwzx r10,0,r19". Inorder to easy identify the instruction =
category
>> and extract the source/target registers, patch adds support to use =
raw
>> instruction for powerpc. Approach used is to read the raw instruction
>> directly from the DSO file using "dso__data_read_offset" utility =
which
>> is already implemented in perf infrastructure in "util/dso.c".
>>=20
>> Example:
>>=20
>> 38 01 81 e8     ld      r4,312(r1)
>>=20
>> Here "38 01 81 e8" is the raw instruction representation. In powerpc,
>> this translates to instruction form: "ld RT,DS(RA)" and binary code
>> as:
>>=20
>>   | 58 |  RT  |  RA |      DS       | |
>>   -------------------------------------
>>   0    6     11    16              30 31
>>=20
>> Function "symbol__disassemble_dso" is updated to read raw instruction
>> directly from DSO using dso__data_read_offset utility. In case of
>> above example, this captures:
>> line:    38 01 81 e8
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/disasm.c | 98 =
++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 98 insertions(+)
>>=20
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index b5fe3a7508bb..f19496133bf0 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -1586,6 +1586,91 @@ static int symbol__disassemble_capstone(char =
*filename, struct symbol *sym,
>> }
>> #endif
>>=20
>> +static int symbol__disassemble_dso(char *filename, struct symbol =
*sym,
>=20
> Maybe rename to symbol__disassemble_raw() ?

This is specifically using dso__data_read_offset. Hence using =
symbol__disassemble_dso=20
>=20
>> + struct annotate_args *args)
>> +{
>> + struct annotation *notes =3D symbol__annotation(sym);
>> + struct map *map =3D args->ms.map;
>> + struct dso *dso =3D map__dso(map);
>> + u64 start =3D map__rip_2objdump(map, sym->start);
>> + u64 end =3D map__rip_2objdump(map, sym->end);
>> + u64 len =3D end - start;
>> + u64 offset;
>> + int i, count;
>> + u8 *buf =3D NULL;
>> + char disasm_buf[512];
>> + struct disasm_line *dl;
>> + u32 *line;
>> +
>> + /* Return if objdump is specified explicitly */
>> + if (args->options->objdump_path)
>> + return -1;
>> +
>> + pr_debug("Reading raw instruction from : %s using =
dso__data_read_offset\n", filename);
>=20
> You may want to print the actual offset and remove the "using
> dso__data_read_offset" part.

Ok Sure
>=20
> Thanks,
> Namhyung
>=20
>> +
>> + buf =3D malloc(len);
>> + if (buf =3D=3D NULL)
>> + goto err;
>> +
>> + count =3D dso__data_read_offset(dso, NULL, sym->start, buf, len);
>> +
>> + line =3D (u32 *)buf;
>> +
>> + if ((u64)count !=3D len)
>> + goto err;
>> +
>> + /* add the function address and name */
>> + scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
>> +   start, sym->name);
>> +
>> + args->offset =3D -1;
>> + args->line =3D disasm_buf;
>> + args->line_nr =3D 0;
>> + args->fileloc =3D NULL;
>> + args->ms.sym =3D sym;
>> +
>> + dl =3D disasm_line__new(args);
>> + if (dl =3D=3D NULL)
>> + goto err;
>> +
>> + annotation_line__add(&dl->al, &notes->src->source);
>> +
>> + /* Each raw instruction is 4 byte */
>> + count =3D len/4;
>> +
>> + for (i =3D 0, offset =3D 0; i < count; i++) {
>> + args->offset =3D offset;
>> + sprintf(args->line, "%x", line[i]);
>> + dl =3D disasm_line__new(args);
>> + if (dl =3D=3D NULL)
>> + goto err;
>> +
>> + annotation_line__add(&dl->al, &notes->src->source);
>> + offset +=3D 4;
>> + }
>> +
>> + /* It failed in the middle */
>> + if (offset !=3D len) {
>> + struct list_head *list =3D &notes->src->source;
>> +
>> + /* Discard all lines and fallback to objdump */
>> + while (!list_empty(list)) {
>> + dl =3D list_first_entry(list, struct disasm_line, al.node);
>> +
>> + list_del_init(&dl->al.node);
>> + disasm_line__free(dl);
>> + }
>> + count =3D -1;
>> + }
>> +
>> +out:
>> + free(buf);
>> + return count < 0 ? count : 0;
>> +
>> +err:
>> + count =3D -1;
>> + goto out;
>> +}
>> /*
>>  * Possibly create a new version of line with tabs expanded. Returns =
the
>>  * existing or new line, storage is updated if a new line is =
allocated. If
>> @@ -1710,6 +1795,19 @@ int symbol__disassemble(struct symbol *sym, =
struct annotate_args *args)
>> strcpy(symfs_filename, tmp);
>> }
>>=20
>> + /*
>> +  * For powerpc data type profiling, use the dso__data_read_offset
>> +  * to read raw instruction directly and interpret the binary code
>> +  * to understand instructions and register fields. For sort keys as
>> +  * type and typeoff, disassemble to mnemonic notation is
>> +  * not required in case of powerpc.
>> +  */
>> + if (arch__is(args->arch, "powerpc")) {
>> + err =3D symbol__disassemble_dso(symfs_filename, sym, args);
>> + if (err =3D=3D 0)
>> + goto out_remove_tmp;
>> + }
>> +
>> #ifdef HAVE_LIBCAPSTONE_SUPPORT
>> err =3D symbol__disassemble_capstone(symfs_filename, sym, args);
>> if (err =3D=3D 0)
>> --=20
>> 2.43.0



