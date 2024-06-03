Return-Path: <linux-kernel+bounces-199446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB718D8750
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB928150F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2E136674;
	Mon,  3 Jun 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0aujAKD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869B1EB39
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432256; cv=none; b=Be/zi+PF7R0Dn8jrMFpzUNw/IQPn2olr3vGgwluGggfzxqoy6yPYLDP62x82vDy2x3c8fqoSbXfI7PzF7C5snMKIgBFg+TkA52zpgZW36m85k2CieV4SVrQzGF7lQDKF652GWnkO9iaaUsADoc04eWnxluoaQc+Tt7FaSg69QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432256; c=relaxed/simple;
	bh=fZIiuKElKoJ1gXd7IOjy/DFSyC3MB+7/dnlhudgzbMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE2/zZW871KeIxf9L9l+HxvC974dVJbDPNzdoe8fS8M9dnCl4fn0ec0OtkB0ptWUfU8Dabec3YDDaxH2uOCqgRDEz6Ke0CXlB+EuGtFZWuQqORtE+9+9VGkASDJJ+hh0m6dkezU5WO248oamrxd4BsjfamaMAS3MmFz6BCoQWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0aujAKD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f61bbb1dfcso1305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717432254; x=1718037054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odXlTBloBlCtY6mJHNwtLQip4qBpe7S6TT1VIDMgyc0=;
        b=p0aujAKDwP36PD1ONK9PIq9DYRB8lXklEPHM4GSlz+knlcMdo9H6DodsO/ryfRFhJy
         ROB7wHbMw3Lpdt1rvoWSlvqejVtnlKHa5BddZAI4zDsRae83xmPV98Z+4B/nqZs59y7c
         hrZ8UL3wV8JDwIlHPKrttrzKaZHRcemWVn/htRh460cCKoG62z/ro/oJh5VSZKzjCYkO
         5NK+1LHQshx25vmNNbrOn9Tr3jjhCFlsxwkxGm51in+zN8lxP8m/ffWeaeON0wmG1di4
         ePvxYN+hnm+T6Hu4eXtpbNXJOv84+Y6OW1kfUuZ1CfxcMlDXedenAjPWov0cdxNbekQX
         0g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432254; x=1718037054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odXlTBloBlCtY6mJHNwtLQip4qBpe7S6TT1VIDMgyc0=;
        b=DLh9xupRqKikNkqR3j5sO8qXqUgolnACry82UOSZg367yqOugprK0xF150AtXBIJ6a
         aJLgHtLk3WxlcZCI5XKWmZpOl+seVAFnL4AZs7/ZqH30/0YFXU88lfW1a6ImoKuGdTCI
         4BnoEwMSyMTHHlImAzXY2GNDYUZ6yzRuhjpNjR0ZGmPMrA5k3ACh2mj/huQeo21Fe0Ye
         bihVZIr8tZWv/VwG4eFRIqVetCUaWE2ao9ede+KcK/EvWMucpCpI37BS+B1IsmjCXkTa
         uPX5Tu5Tb164sSX+FToeoI22ofPeduYUXkMqsPeeVdJ+0kwQJFeUEhGBlIsywOxvR8If
         AWmA==
X-Forwarded-Encrypted: i=1; AJvYcCVrxibr6Llr5t+/lNXmNymMuRCCcQUGd06hJ5MZCO3eXx0ULtQxFLts1ie3NdTzcEfoAcD0PTHkWlU52U8eAzvgWOq2n2DbV1U+enN8
X-Gm-Message-State: AOJu0YwQTDjDjmIfbZ/89Jv0s21RUAA87bpwheePdbKXBwUSODAFZfAa
	BnyDB/gNwXpkZQTrQyon90u74LgBOyWHMCqXZpFVZbYwThqW82tp5IdAq5Z3CVuNpBO10GuJ79U
	GJTsj9so0iA5V29n5il2pQa9JJkNTt5ekM91b
X-Google-Smtp-Source: AGHT+IF2fa/1LAfZ1yVynmIpK6UPK/U7tRzAnLsgwdvETg2psAWTivYFQMlqgasNVrQIEoKOKtlYnJthmscfBKEZuSM=
X-Received: by 2002:a17:902:ee4d:b0:1f3:49f6:a851 with SMTP id
 d9443c01a7336-1f64b655db0mr4340115ad.10.1717432254045; Mon, 03 Jun 2024
 09:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601060941.13692-1-atrajeev@linux.vnet.ibm.com> <20240601060941.13692-12-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240601060941.13692-12-atrajeev@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:30:42 -0700
Message-ID: <CAP-5=fXGPHMF+5cUu42ns0=qm9QCPg0LNUveLLnjdGHPCnVg3w@mail.gmail.com>
Subject: Re: [PATCH V3 11/14] tools/perf: Add support to use libcapstone in powerpc
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org, segher@kernel.crashing.org, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:10=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Now perf uses the capstone library to disassemble the instructions in
> x86. capstone is used (if available) for perf annotate to speed up.
> Currently it only supports x86 architecture. Patch includes changes to
> enable this in powerpc. For now, only for data type sort keys, this
> method is used and only binary code (raw instruction) is read. This is
> because powerpc approach to understand instructions and reg fields uses
> raw instruction. The "cs_disasm" is currently not enabled. While
> attempting to do cs_disasm, observation is that some of the instructions
> were not identified (ex: extswsli, maddld) and it had to fallback to use
> objdump. Hence enabling "cs_disasm" is added in comment section as a
> TODO for powerpc.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/disasm.c | 148 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index d8b357055302..915508d2e197 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1540,12 +1540,18 @@ static int open_capstone_handle(struct annotate_a=
rgs *args, bool is_64bit,
>  {
>         struct annotation_options *opt =3D args->options;
>         cs_mode mode =3D is_64bit ? CS_MODE_64 : CS_MODE_32;
> +       int ret;
>
>         /* TODO: support more architectures */
> -       if (!arch__is(args->arch, "x86"))
> +       if ((!arch__is(args->arch, "x86")) && (!arch__is(args->arch, "pow=
erpc")))
>                 return -1;
>
> -       if (cs_open(CS_ARCH_X86, mode, handle) !=3D CS_ERR_OK)
> +       if (arch__is(args->arch, "x86"))
> +               ret =3D cs_open(CS_ARCH_X86, mode, handle);
> +       else
> +               ret =3D cs_open(CS_ARCH_PPC, mode, handle);
> +
> +       if (ret !=3D CS_ERR_OK)
>                 return -1;

There looks to be a pretty/more robust capstone_init function in
print_insn.c, should we factor this code out and recycle:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/print_insn.c?h=3Dperf-tools-next#n40

Thanks,
Ian

>         if (!opt->disassembler_style ||
> @@ -1635,6 +1641,139 @@ static void print_capstone_detail(cs_insn *insn, =
char *buf, size_t len,
>         }
>  }
>
> +static int symbol__disassemble_capstone_powerpc(char *filename, struct s=
ymbol *sym,
> +                                       struct annotate_args *args)
> +{
> +       struct annotation *notes =3D symbol__annotation(sym);
> +       struct map *map =3D args->ms.map;
> +       struct dso *dso =3D map__dso(map);
> +       struct nscookie nsc;
> +       u64 start =3D map__rip_2objdump(map, sym->start);
> +       u64 end =3D map__rip_2objdump(map, sym->end);
> +       u64 len =3D end - start;
> +       u64 offset;
> +       int i, fd, count;
> +       bool is_64bit =3D false;
> +       bool needs_cs_close =3D false;
> +       u8 *buf =3D NULL;
> +       struct find_file_offset_data data =3D {
> +               .ip =3D start,
> +       };
> +       csh handle;
> +       char disasm_buf[512];
> +       struct disasm_line *dl;
> +       u32 *line;
> +
> +       if (args->options->objdump_path)
> +               return -1;
> +
> +       nsinfo__mountns_enter(dso->nsinfo, &nsc);
> +       fd =3D open(filename, O_RDONLY);
> +       nsinfo__mountns_exit(&nsc);
> +       if (fd < 0)
> +               return -1;
> +
> +       if (file__read_maps(fd, /*exe=3D*/true, find_file_offset, &data,
> +                           &is_64bit) =3D=3D 0)
> +               goto err;
> +
> +       if (open_capstone_handle(args, is_64bit, &handle) < 0)
> +               goto err;
> +
> +       needs_cs_close =3D true;
> +
> +       buf =3D malloc(len);
> +       if (buf =3D=3D NULL)
> +               goto err;
> +
> +       count =3D pread(fd, buf, len, data.offset);
> +       close(fd);
> +       fd =3D -1;
> +
> +       if ((u64)count !=3D len)
> +               goto err;
> +
> +       line =3D (u32 *)buf;
> +
> +       /* add the function address and name */
> +       scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
> +                 start, sym->name);
> +
> +       args->offset =3D -1;
> +       args->line =3D disasm_buf;
> +       args->line_nr =3D 0;
> +       args->fileloc =3D NULL;
> +       args->ms.sym =3D sym;
> +
> +       dl =3D disasm_line__new(args);
> +       if (dl =3D=3D NULL)
> +               goto err;
> +
> +       annotation_line__add(&dl->al, &notes->src->source);
> +
> +       /*
> +        * TODO: enable disassm for powerpc
> +        * count =3D cs_disasm(handle, buf, len, start, len, &insn);
> +        *
> +        * For now, only binary code is saved in disassembled line
> +        * to be used in "type" and "typeoff" sort keys. Each raw code
> +        * is 32 bit instruction. So use "len/4" to get the number of
> +        * entries.
> +        */
> +       count =3D len/4;
> +
> +       for (i =3D 0, offset =3D 0; i < count; i++) {
> +               args->offset =3D offset;
> +               sprintf(args->line, "%x", line[i]);
> +
> +               dl =3D disasm_line__new(args);
> +               if (dl =3D=3D NULL)
> +                       goto err;
> +
> +               annotation_line__add(&dl->al, &notes->src->source);
> +
> +               offset +=3D 4;
> +       }
> +
> +       /* It failed in the middle */
> +       if (offset !=3D len) {
> +               struct list_head *list =3D &notes->src->source;
> +
> +               /* Discard all lines and fallback to objdump */
> +               while (!list_empty(list)) {
> +                       dl =3D list_first_entry(list, struct disasm_line,=
 al.node);
> +
> +                       list_del_init(&dl->al.node);
> +                       disasm_line__free(dl);
> +               }
> +               count =3D -1;
> +       }
> +
> +out:
> +       if (needs_cs_close)
> +               cs_close(&handle);
> +       free(buf);
> +       return count < 0 ? count : 0;
> +
> +err:
> +       if (fd >=3D 0)
> +               close(fd);
> +       if (needs_cs_close) {
> +               struct disasm_line *tmp;
> +
> +               /*
> +                * It probably failed in the middle of the above loop.
> +                * Release any resources it might add.
> +                */
> +               list_for_each_entry_safe(dl, tmp, &notes->src->source, al=
.node) {
> +                       list_del(&dl->al.node);
> +                       free(dl);
> +               }
> +       }
> +       count =3D -1;
> +       goto out;
> +}
> +
>  static int symbol__disassemble_capstone(char *filename, struct symbol *s=
ym,
>                                         struct annotate_args *args)
>  {
> @@ -1987,6 +2126,11 @@ int symbol__disassemble(struct symbol *sym, struct=
 annotate_args *args)
>                         err =3D symbol__disassemble_dso(symfs_filename, s=
ym, args);
>                         if (err =3D=3D 0)
>                                 goto out_remove_tmp;
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +                       err =3D symbol__disassemble_capstone_powerpc(symf=
s_filename, sym, args);
> +                       if (err =3D=3D 0)
> +                               goto out_remove_tmp;
> +#endif
>                 }
>         }
>
> --
> 2.43.0
>

