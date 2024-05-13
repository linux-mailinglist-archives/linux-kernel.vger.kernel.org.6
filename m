Return-Path: <linux-kernel+bounces-177262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F98C3C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE928182B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17F1146A99;
	Mon, 13 May 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dGNRGG7z"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571AC52F9B;
	Mon, 13 May 2024 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585570; cv=none; b=todtuQjRdHtmN8JssktYUokJREuLXJ22C8FuHs2Ozt3rg6+igG8NdtJpL6AVh8R9eFTCgWKRumTwm2gQFVihPX9Fr+IYemllCn4y3WZxOYCvwtcvVaAL6q0WyNfPRMF9jtRdCXOLSZpU+7WS6Y1sLoRH00CyApBpltgS/nxaFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585570; c=relaxed/simple;
	bh=9RODcoOn3XXE4D/eoQ3FVYw3lqP/HLZ6L2J61AJFD9M=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=IVo+/DbncsuTOPKhfv2ChU5XGQYtjJhFQNihe4h8CJcVUNWmiq0Q5X0XKraYlxEZN3f46fEfhxtf+7uxkluW+t6kNJgUe1AbYoi0c1w1gLMK25p2zUSCF+L/nMV8F1vAYC7q0v30u+B37ZhMXXfLDFKZe/MlpLyTg6HTzlErALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dGNRGG7z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44D5MXCh032216;
	Mon, 13 May 2024 07:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ipMh0S2b9wIrl377SR0RkH1cgEtXq82LCzeIKpcAqhI=;
 b=dGNRGG7zo9xnef7t46lOgeXbOBxttGrmzFxETsBqjp4trOt/Mn1oACibRgBKeAmjgg+L
 pXiJSWkCTGdxf30qOOsEtltcDxulzDZ9yhsZPi7qzyc1mUwuOQbO1aZIfQiq1FiiIMhM
 RdY0V7qp0tQnYvAsETHMUeI9FHK4YehquaBH8SN/UBHu4CGyAqR/6bUT2tr3lDHGKQD2
 0VuYNcRGXFb3BGjOQH4AYpwoGeqF+sF4MVepoEnv616q/jvPcDcCrAjXbMVHTN4+ruGS
 KYU1it6azJBfiI0N1tlJRSw6JQWfOlLzVNPctEC7igRzvBqDzOmrovYl0Td8nQWr1/h5 Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y3be3gdn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 07:32:32 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44D7WWWH001429;
	Mon, 13 May 2024 07:32:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y3be3gdn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 07:32:32 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44D3qlMc006200;
	Mon, 13 May 2024 07:32:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgm648w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 07:32:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44D7WP9D52101538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 07:32:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5EC42004B;
	Mon, 13 May 2024 07:32:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 362E92004F;
	Mon, 13 May 2024 07:32:23 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 May 2024 07:32:23 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCH V2 0/9] Add data type profiling support for powerpc
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAM9d7ci=AZFpcYy4=qwTYTTVhWd6g6HHHUuV2B53hS-t8SOCag@mail.gmail.com>
Date: Mon, 13 May 2024 13:02:10 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, akanksha@linux.ibm.com
Message-Id: <C5802D81-BBBE-4409-8887-5DBB2269BCB5@linux.vnet.ibm.com>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
 <CAM9d7ci=AZFpcYy4=qwTYTTVhWd6g6HHHUuV2B53hS-t8SOCag@mail.gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vxQyadcmv7N4Olva8ts1Q1R2rNRRyMy_
X-Proofpoint-ORIG-GUID: Zw2ggYWYyL3y1-BlBfIUHts_kw6GquCd
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130046



> On 7 May 2024, at 10:09=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> wr=
ote:
>=20
> Hello,
>=20
> On Mon, May 6, 2024 at 5:19=E2=80=AFAM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>> The patchset from Namhyung added support for data type profiling
>> in perf tool. This enabled support to associate PMU samples to data
>> types they refer using DWARF debug information. With the upstream
>> perf, currently it possible to run perf report or perf annotate to
>> view the data type information on x86.
>>=20
>> Initial patchset posted here had changes need to enable data type
>> profiling support for powerpc.
>>=20
>> https://lore.kernel.org/all/6e09dc28-4a2e-49d8-a2b5-ffb3396a9952@csgroup=
eu/T/
>>=20
>> Main change were:
>> 1. powerpc instruction nmemonic table to associate load/store
>> instructions with move_ops which is use to identify if instruction
>> is a memory access one.
>> 2. To get register number and access offset from the given
>> instruction, code uses fields from "struct arch" -> objump.
>> Added entry for powerpc here.
>> 3. A get_arch_regnum to return register number from the
>> register name string.
>>=20
>> But the apporach used in the initial patchset used parsing of
>> disassembled code which the current perf tool implementation does.
>>=20
>> Example: lwz     r10,0(r9)
>>=20
>> This line "lwz r10,0(r9)" is parsed to extract instruction name,
>> registers names and offset. Also to find whether there is a memory
>> reference in the operands, "memory_ref_char" field of objdump is used.
>> For x86, "(" is used as memory_ref_char to tackle instructions of the
>> form "mov  (%rax), %rcx".
>>=20
>> In case of powerpc, not all instructions using "(" are the only memory
>> instructions. Example, above instruction can also be of extended form (X
>> form) "lwzx r10,0,r19". Inorder to easy identify the instruction category
>> and extract the source/target registers, this patchset adds support to u=
se
>> raw instruction. With raw instruction, macros are added to extract opcode
>> and register fields.
>>=20
>> Example representation using --show-raw-insn in objdump gives result:
>>=20
>> 38 01 81 e8     ld      r4,312(r1)
>>=20
>> Here "38 01 81 e8" is the raw instruction representation. In powerpc,
>> this translates to instruction form: "ld RT,DS(RA)" and binary code
>> as:
>> _____________________________________
>> | 58 |  RT  |  RA |      DS       | |
>> -------------------------------------
>> 0    6     11    16              30 31
>>=20
>> Patchset adds support to pick the opcode and reg fields from this
>> raw/binary instruction code. This approach came in from review comment
>> by Segher Boessenkool for the initial patchset.
>>=20
>> Apart from that, instruction tracking is enabled for powerpc and
>> support function is added to find variables defined as registers
>> Example, in powerpc, two registers are
>> defined to represent variable:
>> 1. r13: represents local_paca
>> register struct paca_struct *local_paca asm("r13");
>>=20
>> 2. r1: represents stack_pointer
>> register void *__stack_pointer asm("r1");
>>=20
>> These are handled in this patchset.
>>=20
>> - Patch 1 is to rearrange register state type structures to header file
>> so that it can referred from other arch specific files
>> - Patch 2 is to make instruction tracking as a callback to"struct arch"
>> so that it can be implemented by other archs easily and defined in arch
>> specific files
>> - Patch 3 is to fix a small comment
>> - Patch 4 adds support to capture and parse raw instruction in objdump
>> by keeping existing approach intact.
>> - Patch 5 update parameters for reg extract functions to use raw
>> instruction on powerpc
>> - Patch 6 and patch 7 handles instruction tracking for powerpc.
>> - Patch 8 and Patch 8 handles support to find global register variables
>>=20
>> With the current patchset:
>>=20
>> ./perf record -a -e mem-loads sleep 1
>> ./perf report -s type,typeoff --hierarchy --group --stdio
>> ./perf annotate --data-type --insn-stat
>>=20
>> perf annotate logs:
>>=20
>> Annotate Instruction stats
>> total 562, ok 441 (78.5%), bad 121 (21.5%)
>>=20
>>  Name      :  Good   Bad
>> -----------------------------------------------------------
>>  ld        :   313    54
>>  lwz       :    51    32
>>  lbz       :    31     5
>>  ldx       :     6    21
>>  lhz       :    23     0
>>  lwa       :     4     3
>>  lwarx     :     5     0
>>  lwzx      :     2     2
>>  ldarx     :     3     0
>>  lwzu      :     2     0
>>  stdcx.    :     0     1
>>  nop       :     0     1
>>  ldu       :     1     0
>>  lbzx      :     0     1
>>  lwax      :     0     1
>>=20
>> perf report logs:
>>=20
>> # Samples: 1K of event 'mem-loads'
>> # Event count (approx.): 937238
>> #
>> # Overhead  Data Type  Data Type Offset
>> # ........  .........  ................
>> #
>>    48.81%  (unknown)  (unknown) +0 (no field)
>>    12.85%  long unsigned int  long unsigned int +0 (current_stack_pointe=
r)
>>     4.68%  struct paca_struct  struct paca_struct +2312 (__current)
>>     4.57%  struct paca_struct  struct paca_struct +2354 (irq_soft_mask)
>>     2.68%  struct paca_struct  struct paca_struct +8 (paca_index)
>>     2.64%  struct paca_struct  struct paca_struct +2808 (canary)
>>     2.24%  struct paca_struct  struct paca_struct +48 (data_offset)
>>     1.41%  struct vm_fault  struct vm_fault +0 (vma)
>>     1.29%  struct task_struct  struct task_struct +276 (flags)
>>     1.03%  struct pt_regs  struct pt_regs +264 (user_regs.msr)
>>     1.00%  struct menu_device  struct menu_device +4 (tick_wakeup)
>>     0.90%  struct security_hook_list  struct security_hook_list +0 (list=
next)
>>     0.76%  struct irq_desc  struct irq_desc +304 (irq_data.chip)
>>     0.76%  struct rq  struct rq +2856 (cpu)
>=20
> Looks great!  I'm glad it worked on powerpc too.
> We still need to verify the returned type is properly annotated.
> But overall it looks really good, I will leave comments in reply.

Hi Namhyung

Thanks a lot for looking at the patchset and sharing the review comments.
I will address review comments and respond to them sooner.

Thanks
Athira
>=20
> Thanks,
> Namhyung
>=20
>>=20
>> Thanks
>> Athira Rajeev
>>=20
>> Changelog:
>> From v1->v2:
>> - Addressed suggestion from Christophe Leroy and Segher Boessenkool
>>  to use the binary code (raw insn) to fetch opcode, register and
>>  offset fields.
>> - Added support for instruction tracking in powerpc
>> - Find the register defined variables (r13 and r1 which points to
>>  local_paca and current_stack_pointer in powerpc)
>>=20
>> Athira Rajeev (9):
>>  tools/perf: Move the data structures related to register  type to
>>    header file
>>  tools/perf: Add "update_insn_state" callback function to handle arch
>>    specific instruction tracking
>>  tools/perf: Fix a comment about multi_regs in extract_reg_offset
>>    function
>>  tools/perf: Add support to capture and parse raw instruction in
>>    objdump
>>  tools/perf: Update parameters for reg extract functions to use raw
>>    instruction on powerpc
>>  tools/perf: Update instruction tracking for powerpc
>>  tools/perf: Update instruction tracking with add instruction
>>  tools/perf: Add support to find global register variables using
>>    find_data_type_global_reg
>>  tools/perf: Add support for global_die to capture name of variable in
>>    case of register defined variable
>>=20
>> tools/include/linux/string.h                  |   2 +
>> tools/lib/string.c                            |  13 +
>> .../perf/arch/powerpc/annotate/instructions.c |  84 +++
>> tools/perf/arch/powerpc/util/dwarf-regs.c     |  52 ++
>> tools/perf/arch/x86/annotate/instructions.c   | 383 +++++++++++++
>> tools/perf/util/annotate-data.c               | 519 +++---------------
>> tools/perf/util/annotate-data.h               |  78 +++
>> tools/perf/util/annotate.c                    |  32 +-
>> tools/perf/util/annotate.h                    |   1 +
>> tools/perf/util/disasm.c                      | 109 +++-
>> tools/perf/util/disasm.h                      |  17 +-
>> tools/perf/util/dwarf-aux.c                   |   1 +
>> tools/perf/util/dwarf-aux.h                   |   1 +
>> tools/perf/util/include/dwarf-regs.h          |  12 +
>> tools/perf/util/sort.c                        |   7 +-
>> 15 files changed, 854 insertions(+), 457 deletions(-)
>>=20
>> --
>> 2.43.0



