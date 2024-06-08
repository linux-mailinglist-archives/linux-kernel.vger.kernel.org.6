Return-Path: <linux-kernel+bounces-206917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3B900FC3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E96E1C21449
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63650176AA3;
	Sat,  8 Jun 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="peR56DVO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B137171;
	Sat,  8 Jun 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717830353; cv=none; b=qgH8s4Ylo5aYLibGSLDMSq0Z29tmz9fVprvrQuCeJ5zIci2u0wnmpmgSm0TEj5Czl/xiiJH0M4cAFYPN4840LV/XeKocy6PktBMi8v4aEfqY1SycXr+1W1K2Q3fc3coer0K/zxkFDb7oP9cox0TfDTB0j65C6YyYuO0FYRGhrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717830353; c=relaxed/simple;
	bh=lCqy1BWHXXIYXYNG77xyIbNbZmCen12nkLqrep79IuU=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=mbMc5SgrUeAxVLjURSBZDNNeabXurQg4zbfz5AwHuOhSVzJtY1LT8NHhoteUoQysF56r4YcyGWdbekVCSGBELz4bQ1sP1L3HtUPTsjICDa2s3TvZ0Xdunlonofptdv8MSrkEVbd6T585FoVSZ760xWFUyybVPlD4Q3Ph3qU/JbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=peR56DVO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4586dvGm030438;
	Sat, 8 Jun 2024 07:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=yMWUxJUlF6L2NEhkNDtt9fr8oZ+k7a7+drOhLKklDmg=; b=peR56DVOyQoy
	xf9DtMCjyLHrDI2owu9KGpzbhoto/HOLU7VZgwsVxmw5QZVrFbnABt3XzOxGsnib
	tgOIaXIBmLAbsGKC0fwIiOkko7qViDYZtzfdRr8H62yQIMR+xogyybXfGJQdV/HA
	Ev6fy9IZW4diQOSocuBAFF44bn5Kq9CSs1vxRUxQ8vA8MPSQQuOONYJzcosOhL4g
	ImSBLWdT8jO8Pph3V5lqchSm87ozxUl+BT3ncTG7tRiaUkP/Z+CV6Ppn35XeZUAp
	QRxhBKb3Z0M7GF2ktgK+sE4mxER+YP93ti2TYsWD+UFq1PZ3b8sCGLodQHlGRnP4
	iSiBff35nw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ymhj303n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 07:05:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45875XFq016793;
	Sat, 8 Jun 2024 07:05:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ymhj303n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 07:05:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4583YFnK025382;
	Sat, 8 Jun 2024 07:05:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ymfgv0sfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 07:05:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45875QJo56557974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Jun 2024 07:05:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D9920043;
	Sat,  8 Jun 2024 07:05:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11B6C2004B;
	Sat,  8 Jun 2024 07:05:23 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.125.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Jun 2024 07:05:22 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH V3 11/14] tools/perf: Add support to use libcapstone in
 powerpc
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAP-5=fXGPHMF+5cUu42ns0=qm9QCPg0LNUveLLnjdGHPCnVg3w@mail.gmail.com>
Date: Sat, 8 Jun 2024 12:35:10 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akanksha@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Message-Id: <C6F8CEEC-88B1-46D9-8A51-EC479FF2886D@linux.vnet.ibm.com>
References: <20240601060941.13692-1-atrajeev@linux.vnet.ibm.com>
 <20240601060941.13692-12-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fXGPHMF+5cUu42ns0=qm9QCPg0LNUveLLnjdGHPCnVg3w@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DuqlHtLle4oWRzq8aXRE0UxFEZldybSt
X-Proofpoint-GUID: iUr_mQSFaUnPVr4ehY3HGAB6aWcxk-or
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
 definitions=2024-06-08_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=964
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406080049



> On 3 Jun 2024, at 10:00=E2=80=AFPM, Ian Rogers <irogers@google.com> wrote:
>=20
> On Fri, May 31, 2024 at 11:10=E2=80=AFPM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>> Now perf uses the capstone library to disassemble the instructions in
>> x86. capstone is used (if available) for perf annotate to speed up.
>> Currently it only supports x86 architecture. Patch includes changes to
>> enable this in powerpc. For now, only for data type sort keys, this
>> method is used and only binary code (raw instruction) is read. This is
>> because powerpc approach to understand instructions and reg fields uses
>> raw instruction. The "cs_disasm" is currently not enabled. While
>> attempting to do cs_disasm, observation is that some of the instructions
>> were not identified (ex: extswsli, maddld) and it had to fallback to use
>> objdump. Hence enabling "cs_disasm" is added in comment section as a
>> TODO for powerpc.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/disasm.c | 148 ++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 146 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index d8b357055302..915508d2e197 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -1540,12 +1540,18 @@ static int open_capstone_handle(struct annotate_=
args *args, bool is_64bit,
>> {
>>        struct annotation_options *opt =3D args->options;
>>        cs_mode mode =3D is_64bit ? CS_MODE_64 : CS_MODE_32;
>> +       int ret;
>>=20
>>        /* TODO: support more architectures */
>> -       if (!arch__is(args->arch, "x86"))
>> +       if ((!arch__is(args->arch, "x86")) && (!arch__is(args->arch, "po=
werpc")))
>>                return -1;
>>=20
>> -       if (cs_open(CS_ARCH_X86, mode, handle) !=3D CS_ERR_OK)
>> +       if (arch__is(args->arch, "x86"))
>> +               ret =3D cs_open(CS_ARCH_X86, mode, handle);
>> +       else
>> +               ret =3D cs_open(CS_ARCH_PPC, mode, handle);
>> +
>> +       if (ret !=3D CS_ERR_OK)
>>                return -1;
>=20
> There looks to be a pretty/more robust capstone_init function in
> print_insn.c, should we factor this code out and recycle:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/print_insn.c?h=3Dperf-tools-next#n40
>=20
> Thanks,
> Ian

Hi Ian,

Thanks for checking the patch.

Yes, that=E2=80=99s good change to have. I will have this change in V4

Thanks
Athira

>=20
>>        if (!opt->disassembler_style ||
>> @@ -1635,6 +1641,139 @@ static void print_capstone_detail(cs_insn *insn,=
 char *buf, size_t len,
>>        }
>> }
>>=20
>> +static int symbol__disassemble_capstone_powerpc(char *filename, struct =
symbol *sym,
>> +                                       struct annotate_args *args)
>> +{
>> +       struct annotation *notes =3D symbol__annotation(sym);
>> +       struct map *map =3D args->ms.map;
>> +       struct dso *dso =3D map__dso(map);
>> +       struct nscookie nsc;
>> +       u64 start =3D map__rip_2objdump(map, sym->start);
>> +       u64 end =3D map__rip_2objdump(map, sym->end);
>> +       u64 len =3D end - start;
>> +       u64 offset;
>> +       int i, fd, count;
>> +       bool is_64bit =3D false;
>> +       bool needs_cs_close =3D false;
>> +       u8 *buf =3D NULL;
>> +       struct find_file_offset_data data =3D {
>> +               .ip =3D start,
>> +       };
>> +       csh handle;
>> +       char disasm_buf[512];
>> +       struct disasm_line *dl;
>> +       u32 *line;
>> +
>> +       if (args->options->objdump_path)
>> +               return -1;
>> +
>> +       nsinfo__mountns_enter(dso->nsinfo, &nsc);
>> +       fd =3D open(filename, O_RDONLY);
>> +       nsinfo__mountns_exit(&nsc);
>> +       if (fd < 0)
>> +               return -1;
>> +
>> +       if (file__read_maps(fd, /*exe=3D*/true, find_file_offset, &data,
>> +                           &is_64bit) =3D=3D 0)
>> +               goto err;
>> +
>> +       if (open_capstone_handle(args, is_64bit, &handle) < 0)
>> +               goto err;
>> +
>> +       needs_cs_close =3D true;
>> +
>> +       buf =3D malloc(len);
>> +       if (buf =3D=3D NULL)
>> +               goto err;
>> +
>> +       count =3D pread(fd, buf, len, data.offset);
>> +       close(fd);
>> +       fd =3D -1;
>> +
>> +       if ((u64)count !=3D len)
>> +               goto err;
>> +
>> +       line =3D (u32 *)buf;
>> +
>> +       /* add the function address and name */
>> +       scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
>> +                 start, sym->name);
>> +
>> +       args->offset =3D -1;
>> +       args->line =3D disasm_buf;
>> +       args->line_nr =3D 0;
>> +       args->fileloc =3D NULL;
>> +       args->ms.sym =3D sym;
>> +
>> +       dl =3D disasm_line__new(args);
>> +       if (dl =3D=3D NULL)
>> +               goto err;
>> +
>> +       annotation_line__add(&dl->al, &notes->src->source);
>> +
>> +       /*
>> +        * TODO: enable disassm for powerpc
>> +        * count =3D cs_disasm(handle, buf, len, start, len, &insn);
>> +        *
>> +        * For now, only binary code is saved in disassembled line
>> +        * to be used in "type" and "typeoff" sort keys. Each raw code
>> +        * is 32 bit instruction. So use "len/4" to get the number of
>> +        * entries.
>> +        */
>> +       count =3D len/4;
>> +
>> +       for (i =3D 0, offset =3D 0; i < count; i++) {
>> +               args->offset =3D offset;
>> +               sprintf(args->line, "%x", line[i]);
>> +
>> +               dl =3D disasm_line__new(args);
>> +               if (dl =3D=3D NULL)
>> +                       goto err;
>> +
>> +               annotation_line__add(&dl->al, &notes->src->source);
>> +
>> +               offset +=3D 4;
>> +       }
>> +
>> +       /* It failed in the middle */
>> +       if (offset !=3D len) {
>> +               struct list_head *list =3D &notes->src->source;
>> +
>> +               /* Discard all lines and fallback to objdump */
>> +               while (!list_empty(list)) {
>> +                       dl =3D list_first_entry(list, struct disasm_line=
, al.node);
>> +
>> +                       list_del_init(&dl->al.node);
>> +                       disasm_line__free(dl);
>> +               }
>> +               count =3D -1;
>> +       }
>> +
>> +out:
>> +       if (needs_cs_close)
>> +               cs_close(&handle);
>> +       free(buf);
>> +       return count < 0 ? count : 0;
>> +
>> +err:
>> +       if (fd >=3D 0)
>> +               close(fd);
>> +       if (needs_cs_close) {
>> +               struct disasm_line *tmp;
>> +
>> +               /*
>> +                * It probably failed in the middle of the above loop.
>> +                * Release any resources it might add.
>> +                */
>> +               list_for_each_entry_safe(dl, tmp, &notes->src->source, a=
l.node) {
>> +                       list_del(&dl->al.node);
>> +                       free(dl);
>> +               }
>> +       }
>> +       count =3D -1;
>> +       goto out;
>> +}
>> +
>> static int symbol__disassemble_capstone(char *filename, struct symbol *s=
ym,
>>                                        struct annotate_args *args)
>> {
>> @@ -1987,6 +2126,11 @@ int symbol__disassemble(struct symbol *sym, struc=
t annotate_args *args)
>>                        err =3D symbol__disassemble_dso(symfs_filename, s=
ym, args);
>>                        if (err =3D=3D 0)
>>                                goto out_remove_tmp;
>> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
>> +                       err =3D symbol__disassemble_capstone_powerpc(sym=
fs_filename, sym, args);
>> +                       if (err =3D=3D 0)
>> +                               goto out_remove_tmp;
>> +#endif
>>                }
>>        }
>>=20
>> --
>> 2.43.0



