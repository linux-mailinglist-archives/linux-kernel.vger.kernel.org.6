Return-Path: <linux-kernel+bounces-229532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC639917081
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CC828CBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A017BB1A;
	Tue, 25 Jun 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3H0cwxB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BEC1369B6;
	Tue, 25 Jun 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341114; cv=none; b=lDWy5AkI5IpbNFtMVWJJM53g4g1ho4OdeUcHYYs2z9rwiLia90Uxe4jUnjbB1vRn9Ad/17hw3/L+K2GAOPVeJYsvIaHnrRetn3BVbDX773mLWe8gPa+xNDwxkyPYv2m5ssuqq/r7J/Yr5ElfgvQTdvB84bMWvfHz2vEGp7WA7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341114; c=relaxed/simple;
	bh=ls1xBJfcDVgd5ISX3BpuHHrzrDMD41ZZn9MNlv/YzYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma+w3PcAFde5t2nCKWGUcvm7zgiLec3C5+t71w0tQySG0XRSON6OWoA6WsADZDwOtllrrJyqTG22HL3n8axOB6RnhvpUJ4KETHqQeiF1jKK0zXab0zLJMXpX0EAMYMhV1IocVyZMlQspkX6NowF6rqYnsa+Bx0eXk/Bbd0FkXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3H0cwxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B7EC32781;
	Tue, 25 Jun 2024 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719341114;
	bh=ls1xBJfcDVgd5ISX3BpuHHrzrDMD41ZZn9MNlv/YzYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3H0cwxBlzZtci8ZSnTO2Itkyv++pbeNQRaUu0ZLzGQE4JkDqUKXSUJAjjsI6DcLH
	 Eims4gCOmTQPyzXYzcXzzNEkgnmR7AuLwfqNF2J1M11I49DOUF3FzH8BYYVX6zZrps
	 vKKo6Ca+SA8Y3zeWGPAVFsd32SjNYqfIoIVW3uA/6CWzeGZo9KprQl4V0lPcRVWl8o
	 whehrG/Ik6okPGL3JSzJd3L56+iM3F5hCnyP3f961Lh6s6xAjgfw35qrcyyXv9mKg9
	 MQW5xpvbeoecP5xhrPTNZBx17zD5up4v9hrdiy/39XrvTA+YBVhhEwvVvhRiNMUWc/
	 UhXHplo11xr3Q==
Date: Tue, 25 Jun 2024 11:45:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	akanksha@linux.ibm.com, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: Re: [V4 05/16] tools/perf: Add disasm_line__parse to parse raw
 instruction for powerpc
Message-ID: <ZnsQOD3arkR0qoPJ@google.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
 <20240614172631.56803-6-atrajeev@linux.vnet.ibm.com>
 <ZnpYBvXLhyAqZzvh@google.com>
 <E2A1A4AA-E344-4B42-86CE-E0EDD82A398F@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E2A1A4AA-E344-4B42-86CE-E0EDD82A398F@linux.vnet.ibm.com>

On Tue, Jun 25, 2024 at 06:12:51PM +0530, Athira Rajeev wrote:
> 
> 
> > On 25 Jun 2024, at 11:09 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > On Fri, Jun 14, 2024 at 10:56:20PM +0530, Athira Rajeev wrote:
> >> Currently, the perf tool infrastructure disasm_line__parse function to
> >> parse disassembled line.
> >> 
> >> Example snippet from objdump:
> >> objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>
> >> 
> >> c0000000010224b4: lwz     r10,0(r9)
> >> 
> >> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> >> registers names and offset. In powerpc, the approach for data type
> >> profiling uses raw instruction instead of result from objdump to identify
> >> the instruction category and extract the source/target registers.
> >> 
> >> Example: 38 01 81 e8     ld      r4,312(r1)
> >> 
> >> Here "38 01 81 e8" is the raw instruction representation. Add function
> >> "disasm_line__parse_powerpc" to handle parsing of raw instruction.
> >> Also update "struct disasm_line" to save the binary code/
> >> With the change, function captures:
> >> 
> >> line -> "38 01 81 e8     ld      r4,312(r1)"
> >> raw instruction "38 01 81 e8"
> >> 
> >> Raw instruction is used later to extract the reg/offset fields. Macros
> >> are added to extract opcode and register fields. "struct disasm_line"
> >> is updated to carry union of "bytes" and "raw_insn" of 32 bit to carry raw
> >> code (raw). Function "disasm_line__parse_powerpc fills the raw
> >> instruction hex value and can use macros to get opcode. There is no
> >> changes in existing code paths, which parses the disassembled code.
> >> The architecture using the instruction name and present approach is
> >> not altered. Since this approach targets powerpc, the macro
> >> implementation is added for powerpc as of now.
> >> 
> >> Since the disasm_line__parse is used in other cases (perf annotate) and
> >> not only data tye profiling, the powerpc callback includes changes to
> >> work with binary code as well as mneumonic representation. Also in case
> >> if the DSO read fails and libcapstone is not supported, the approach
> >> fallback to use objdump as option. Hence as option, patch has changes to
> >> ensure objdump option also works well.
> >> 
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
> >> tools/include/linux/string.h                  |  2 +
> >> tools/lib/string.c                            | 13 ++++
> >> .../perf/arch/powerpc/annotate/instructions.c |  1 +
> >> tools/perf/arch/powerpc/util/dwarf-regs.c     |  9 +++
> >> tools/perf/util/annotate.h                    |  5 +-
> >> tools/perf/util/disasm.c                      | 59 ++++++++++++++++++-
> >> 6 files changed, 87 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> >> index db5c99318c79..0acb1fc14e19 100644
> >> --- a/tools/include/linux/string.h
> >> +++ b/tools/include/linux/string.h
> >> @@ -46,5 +46,7 @@ extern char * __must_check skip_spaces(const char *);
> >> 
> >> extern char *strim(char *);
> >> 
> >> +extern void remove_spaces(char *s);
> >> +
> >> extern void *memchr_inv(const void *start, int c, size_t bytes);
> >> #endif /* _TOOLS_LINUX_STRING_H_ */
> >> diff --git a/tools/lib/string.c b/tools/lib/string.c
> >> index 8b6892f959ab..3126d2cff716 100644
> >> --- a/tools/lib/string.c
> >> +++ b/tools/lib/string.c
> >> @@ -153,6 +153,19 @@ char *strim(char *s)
> >> return skip_spaces(s);
> >> }
> >> 
> >> +/*
> >> + * remove_spaces - Removes whitespaces from @s
> >> + */
> >> +void remove_spaces(char *s)
> >> +{
> >> + char *d = s;
> >> +
> >> + do {
> >> + while (*d == ' ')
> >> + ++d;
> >> + } while ((*s++ = *d++));
> >> +}
> >> +
> >> /**
> >>  * strreplace - Replace all occurrences of character in string.
> >>  * @s: The string to operate on.
> >> diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
> >> index a3f423c27cae..d57fd023ef9c 100644
> >> --- a/tools/perf/arch/powerpc/annotate/instructions.c
> >> +++ b/tools/perf/arch/powerpc/annotate/instructions.c
> >> @@ -55,6 +55,7 @@ static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> >> arch->initialized = true;
> >> arch->associate_instruction_ops = powerpc__associate_instruction_ops;
> >> arch->objdump.comment_char      = '#';
> >> + annotate_opts.show_asm_raw = true;
> > 
> > Right, I think this will add the raw insn in the output of objdump, no?
> > Why not using the information?
> 
> Shared response in previous patch

Ok, now I understand it's a fallback. :)

> > 
> >> }
> >> 
> >> return 0;
> >> diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
> >> index 0c4f4caf53ac..430623ca5612 100644
> >> --- a/tools/perf/arch/powerpc/util/dwarf-regs.c
> >> +++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
> >> @@ -98,3 +98,12 @@ int regs_query_register_offset(const char *name)
> >> return roff->ptregs_offset;
> >> return -EINVAL;
> >> }
> >> +
> >> +#define PPC_OP(op) (((op) >> 26) & 0x3F)
> >> +#define PPC_RA(a) (((a) >> 16) & 0x1f)
> >> +#define PPC_RT(t) (((t) >> 21) & 0x1f)
> >> +#define PPC_RB(b) (((b) >> 11) & 0x1f)
> >> +#define PPC_D(D) ((D) & 0xfffe)
> >> +#define PPC_DS(DS) ((DS) & 0xfffc)
> >> +#define OP_LD 58
> >> +#define OP_STD 62
> >> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> >> index d5c821c22f79..9ba772f46270 100644
> >> --- a/tools/perf/util/annotate.h
> >> +++ b/tools/perf/util/annotate.h
> >> @@ -113,7 +113,10 @@ struct annotation_line {
> >> struct disasm_line {
> >> struct ins  ins;
> >> struct ins_operands  ops;
> >> -
> >> + union {
> >> + u8 bytes[4];
> >> + u32 raw_insn;
> >> + } raw;
> >> /* This needs to be at the end. */
> >> struct annotation_line  al;
> >> };
> >> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> >> index b81cdcf4d6b4..1e8568738b38 100644
> >> --- a/tools/perf/util/disasm.c
> >> +++ b/tools/perf/util/disasm.c
> >> @@ -45,6 +45,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
> >> 
> >> static void ins__sort(struct arch *arch);
> >> static int disasm_line__parse(char *line, const char **namep, char **rawp);
> >> +static int disasm_line__parse_powerpc(struct disasm_line *dl);
> >> 
> >> static __attribute__((constructor)) void symbol__init_regexpr(void)
> >> {
> >> @@ -844,6 +845,59 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
> >> return -1;
> >> }
> >> 
> >> +/*
> >> + * Parses the result captured from symbol__disassemble_*
> >> + * Example, line read from DSO file in powerpc:
> >> + * line:    38 01 81 e8
> >> + * opcode: fetched from arch specific get_opcode_insn
> >> + * rawp_insn: e8810138
> >> + *
> >> + * rawp_insn is used later to extract the reg/offset fields
> >> + */
> >> +#define PPC_OP(op) (((op) >> 26) & 0x3F)
> >> +
> >> +static int disasm_line__parse_powerpc(struct disasm_line *dl)
> >> +{
> >> + char *line = dl->al.line;
> >> + const char **namep = &dl->ins.name;
> >> + char **rawp = &dl->ops.raw;
> >> + char tmp, *tmp_raw_insn, *name_raw_insn = skip_spaces(line);
> >> + char *name = skip_spaces(name_raw_insn + 11);
> >> + int objdump = 0;
> >> +
> >> + if (strlen(line) > 11)
> >> + objdump = 1;
> >> +
> >> + if (name_raw_insn[0] == '\0')
> >> + return -1;
> >> +
> >> + if (objdump) {
> >> + *rawp = name + 1;
> >> + while ((*rawp)[0] != '\0' && !isspace((*rawp)[0]))
> >> + ++*rawp;
> >> + tmp = (*rawp)[0];
> >> + (*rawp)[0] = '\0';
> >> +
> >> + *namep = strdup(name);
> >> + if (*namep == NULL)
> >> + return -1;
> >> +
> >> + (*rawp)[0] = tmp;
> >> + *rawp = strim(*rawp);
> >> + } else
> >> + *namep = "";

Then can you handle this logic under if (annotate_opts.show_raw_insn)
in disasm_line__parse() instead of adding a new function?

Thanks,
Namhyung


> >> +
> >> + tmp_raw_insn = strdup(name_raw_insn);
> >> + tmp_raw_insn[11] = '\0';
> >> + remove_spaces(tmp_raw_insn);
> >> +
> >> + dl->raw.raw_insn = strtol(tmp_raw_insn, NULL, 16);
> >> + if (objdump)
> >> + dl->raw.raw_insn = be32_to_cpu(strtol(tmp_raw_insn, NULL, 16));
> > 
> > Hmm.. can you use a sscanf() instead?
> > 
> >  sscanf(line, "%x %x %x %x", &dl->raw.bytes[0], &dl->raw.bytes[1], ...)
> > 
> > Thanks,
> > Namhyung
> > 
> Sure will address in V5
> 
> Thanks
> Athira
> >> +
> >> + return 0;
> >> +}
> >> +
> >> static void annotation_line__init(struct annotation_line *al,
> >>   struct annotate_args *args,
> >>   int nr)
> >> @@ -897,7 +951,10 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
> >> goto out_delete;
> >> 
> >> if (args->offset != -1) {
> >> - if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
> >> + if (arch__is(args->arch, "powerpc")) {
> >> + if (disasm_line__parse_powerpc(dl) < 0)
> >> + goto out_free_line;
> >> + } else if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
> >> goto out_free_line;
> >> 
> >> disasm_line__init_ins(dl, args->arch, &args->ms);
> >> -- 
> >> 2.43.0
> 
> 

