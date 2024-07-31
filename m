Return-Path: <linux-kernel+bounces-269600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F039434B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3811F2420E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCBB1BD4E0;
	Wed, 31 Jul 2024 17:08:06 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27F1BD014
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445685; cv=none; b=dQpuqGHHBDY4Up6tMAN4febNitbO3g30jeOp0WwpohTCXpEqBMeg36I/4/5VO6zOxCYw1Hm35scX8i1KYi/2cY1jvlmPGXWffiIX1jPood8cMSoqBhxKkVD3nMkU9ekYOBEnGeFDy9YqjEG7LLCQ6Lc5w8WNI6ufVLaKWcUKrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445685; c=relaxed/simple;
	bh=2TrrHhO6yosuGpOeuEcfZ0q5RMO3TSdgVW7GHhRFBaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJx7xZ7ew0tJJ31dIWaMrlaMiGfRd6CNWLDj2AUZZqgFBm8IvLIDZm1q+4SlDZdSdBCE9itEj/7/i0XXDPMcKM9ObUkmxny7V2iX3CtKqEhD44qvgasaVj7c4y4Sf9/6JXYguYbUhapB3JDtzCV/hy2qIqaVd9mUhjuNEwxA4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7515437ff16so4563952a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445683; x=1723050483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJJ8sPMH+srdUYEYH/nPqGBsFI9pgAgfOm+HX03RQVQ=;
        b=qcI+W1LYvWSNPtJwgkGWKvMR80ToTCLracQnovCUcG7Ejk45wLvD66SOSiXZds6ibn
         YGFOzVWBkA7EPQfDgtKaui/IyBlF2S0vakU7RCeADwtJK5rXsZCu+qd1+E+9U0jasJln
         tDxKBWIjSHBrvvGpDRMmHuWWbmzAyYATNHLv2DZ4xj2k0awukoJD+xzyWiKV08JRdciY
         c1BIlkO2oqVpYoMlC8JU7cvVi2KqafCfnOPAAZx8C7R1bgxoM9wO3D7NCKeQs/rMNKb4
         BMWqiLNuM2sZUgE4HjI0OtkJbDXxE2ffkpUcVpnethyqIvVzNmbIGt9sr5JV+M0xqQFp
         rTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvxTRgTP2eTT5M83LHJvuBsznAk+P8rB18pLP54twmQjuFdkmb+m12Yeooy2CNiNkBm8biprwn5hXFBxUBmPTY+cwwRUzlkmXN3lnW
X-Gm-Message-State: AOJu0YygR7fi+o4fw8dkOOq/EOvb1/nFREIhM0QkjiuYJS/V5Ql7KHtt
	WQqWRoXzZPiY6PWYsUICPYmL2++pYKQBP8GMDDZ1ph7BOdtL4GdBXRYJjcodrveq6RUszYh8HK6
	4wtKknf878ZEiHrmYJyh7x6JjnPo=
X-Google-Smtp-Source: AGHT+IGXzxVNbNV3vNfdQAGxx8Q4fk5iTKqw6ecRlmqRms6OYvI5ACNvNNPLKpZyGQBy5Z9sD08stfG1aaYxMYG9zZI=
X-Received: by 2002:a17:90a:b111:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2cf7e836c4dmr17175649a91.38.1722445682434; Wed, 31 Jul 2024
 10:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZqpUSKPxMwaQKORr@x1>
In-Reply-To: <ZqpUSKPxMwaQKORr@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 31 Jul 2024 10:07:50 -0700
Message-ID: <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Song Liu <song@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:12=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> There is a clash of the libbpf and capstone libraries, that ends up
> with:
>
>   In file included from /usr/include/capstone/capstone.h:325,
>                    from util/disasm.c:1513:
>   /usr/include/capstone/bpf.h:94:14: error: =E2=80=98bpf_insn=E2=80=99 de=
fined as wrong kind of tag
>      94 | typedef enum bpf_insn {
>
> So far we're just trying to avoid this by not having both headers
> included in the same .c or .h file, do it one more time by moving the
> BPF diassembly routines from util/disasm.c to util/disasm_bpf.c.
>
> This is only being hit when building with BUILD_NONDISTRO=3D1, i.e.
> building with binutils-devel, that isn't the in the default build due to
> a licencing clash. We need to reimplement what is now isolated in
> util/disasm_bpf.c using some other library to have BPF annotation
> feature that now only is available with BUILD_NONDISTRO=3D1.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/Build        |   1 +
>  tools/perf/util/disasm.c     | 187 +--------------------------------
>  tools/perf/util/disasm_bpf.c | 193 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/disasm_bpf.h |  12 +++
>  4 files changed, 207 insertions(+), 186 deletions(-)
>  create mode 100644 tools/perf/util/disasm_bpf.c
>  create mode 100644 tools/perf/util/disasm_bpf.h
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 0f18fe81ef0b2a74..b24360c04aaea424 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -13,6 +13,7 @@ perf-util-y +=3D copyfile.o
>  perf-util-y +=3D ctype.o
>  perf-util-y +=3D db-export.o
>  perf-util-y +=3D disasm.o
> +perf-util-y +=3D disasm_bpf.o

I think this can be gated by LIBBFD and LIBBPF config, but not sure
it can express the both requirements easily.

thanks,
Namhyung


>  perf-util-y +=3D env.o
>  perf-util-y +=3D event.o
>  perf-util-y +=3D evlist.o
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 410e52cd9cfd0306..85fb0cfedf94554b 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -16,6 +16,7 @@
>  #include "build-id.h"
>  #include "debug.h"
>  #include "disasm.h"
> +#include "disasm_bpf.h"
>  #include "dso.h"
>  #include "env.h"
>  #include "evsel.h"
> @@ -1323,192 +1324,6 @@ static int dso__disassemble_filename(struct dso *=
dso, char *filename, size_t fil
>         return 0;
>  }
>
> -#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
> -#define PACKAGE "perf"
> -#include <bfd.h>
> -#include <dis-asm.h>
> -#include <bpf/bpf.h>
> -#include <bpf/btf.h>
> -#include <bpf/libbpf.h>
> -#include <linux/btf.h>
> -#include <tools/dis-asm-compat.h>
> -
> -#include "bpf-event.h"
> -#include "bpf-utils.h"
> -
> -static int symbol__disassemble_bpf(struct symbol *sym,
> -                                  struct annotate_args *args)
> -{
> -       struct annotation *notes =3D symbol__annotation(sym);
> -       struct bpf_prog_linfo *prog_linfo =3D NULL;
> -       struct bpf_prog_info_node *info_node;
> -       int len =3D sym->end - sym->start;
> -       disassembler_ftype disassemble;
> -       struct map *map =3D args->ms.map;
> -       struct perf_bpil *info_linear;
> -       struct disassemble_info info;
> -       struct dso *dso =3D map__dso(map);
> -       int pc =3D 0, count, sub_id;
> -       struct btf *btf =3D NULL;
> -       char tpath[PATH_MAX];
> -       size_t buf_size;
> -       int nr_skip =3D 0;
> -       char *buf;
> -       bfd *bfdf;
> -       int ret;
> -       FILE *s;
> -
> -       if (dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BPF_PROG_INFO)
> -               return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
> -
> -       pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n"=
, __func__,
> -                 sym->name, sym->start, sym->end - sym->start);
> -
> -       memset(tpath, 0, sizeof(tpath));
> -       perf_exe(tpath, sizeof(tpath));
> -
> -       bfdf =3D bfd_openr(tpath, NULL);
> -       if (bfdf =3D=3D NULL)
> -               abort();
> -
> -       if (!bfd_check_format(bfdf, bfd_object))
> -               abort();
> -
> -       s =3D open_memstream(&buf, &buf_size);
> -       if (!s) {
> -               ret =3D errno;
> -               goto out;
> -       }
> -       init_disassemble_info_compat(&info, s,
> -                                    (fprintf_ftype) fprintf,
> -                                    fprintf_styled);
> -       info.arch =3D bfd_get_arch(bfdf);
> -       info.mach =3D bfd_get_mach(bfdf);
> -
> -       info_node =3D perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->en=
v,
> -                                                dso__bpf_prog(dso)->id);
> -       if (!info_node) {
> -               ret =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> -               goto out;
> -       }
> -       info_linear =3D info_node->info_linear;
> -       sub_id =3D dso__bpf_prog(dso)->sub_id;
> -
> -       info.buffer =3D (void *)(uintptr_t)(info_linear->info.jited_prog_=
insns);
> -       info.buffer_length =3D info_linear->info.jited_prog_len;
> -
> -       if (info_linear->info.nr_line_info)
> -               prog_linfo =3D bpf_prog_linfo__new(&info_linear->info);
> -
> -       if (info_linear->info.btf_id) {
> -               struct btf_node *node;
> -
> -               node =3D perf_env__find_btf(dso__bpf_prog(dso)->env,
> -                                         info_linear->info.btf_id);
> -               if (node)
> -                       btf =3D btf__new((__u8 *)(node->data),
> -                                      node->data_size);
> -       }
> -
> -       disassemble_init_for_target(&info);
> -
> -#ifdef DISASM_FOUR_ARGS_SIGNATURE
> -       disassemble =3D disassembler(info.arch,
> -                                  bfd_big_endian(bfdf),
> -                                  info.mach,
> -                                  bfdf);
> -#else
> -       disassemble =3D disassembler(bfdf);
> -#endif
> -       if (disassemble =3D=3D NULL)
> -               abort();
> -
> -       fflush(s);
> -       do {
> -               const struct bpf_line_info *linfo =3D NULL;
> -               struct disasm_line *dl;
> -               size_t prev_buf_size;
> -               const char *srcline;
> -               u64 addr;
> -
> -               addr =3D pc + ((u64 *)(uintptr_t)(info_linear->info.jited=
_ksyms))[sub_id];
> -               count =3D disassemble(pc, &info);
> -
> -               if (prog_linfo)
> -                       linfo =3D bpf_prog_linfo__lfind_addr_func(prog_li=
nfo,
> -                                                               addr, sub=
_id,
> -                                                               nr_skip);
> -
> -               if (linfo && btf) {
> -                       srcline =3D btf__name_by_offset(btf, linfo->line_=
off);
> -                       nr_skip++;
> -               } else
> -                       srcline =3D NULL;
> -
> -               fprintf(s, "\n");
> -               prev_buf_size =3D buf_size;
> -               fflush(s);
> -
> -               if (!annotate_opts.hide_src_code && srcline) {
> -                       args->offset =3D -1;
> -                       args->line =3D strdup(srcline);
> -                       args->line_nr =3D 0;
> -                       args->fileloc =3D NULL;
> -                       args->ms.sym  =3D sym;
> -                       dl =3D disasm_line__new(args);
> -                       if (dl) {
> -                               annotation_line__add(&dl->al,
> -                                                    &notes->src->source)=
;
> -                       }
> -               }
> -
> -               args->offset =3D pc;
> -               args->line =3D buf + prev_buf_size;
> -               args->line_nr =3D 0;
> -               args->fileloc =3D NULL;
> -               args->ms.sym  =3D sym;
> -               dl =3D disasm_line__new(args);
> -               if (dl)
> -                       annotation_line__add(&dl->al, &notes->src->source=
);
> -
> -               pc +=3D count;
> -       } while (count > 0 && pc < len);
> -
> -       ret =3D 0;
> -out:
> -       free(prog_linfo);
> -       btf__free(btf);
> -       fclose(s);
> -       bfd_close(bfdf);
> -       return ret;
> -}
> -#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
> -static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
> -                                  struct annotate_args *args __maybe_unu=
sed)
> -{
> -       return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
> -}
> -#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
> -
> -static int
> -symbol__disassemble_bpf_image(struct symbol *sym,
> -                             struct annotate_args *args)
> -{
> -       struct annotation *notes =3D symbol__annotation(sym);
> -       struct disasm_line *dl;
> -
> -       args->offset =3D -1;
> -       args->line =3D strdup("to be implemented");
> -       args->line_nr =3D 0;
> -       args->fileloc =3D NULL;
> -       dl =3D disasm_line__new(args);
> -       if (dl)
> -               annotation_line__add(&dl->al, &notes->src->source);
> -
> -       zfree(&args->line);
> -       return 0;
> -}
> -
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>  #include <capstone/capstone.h>
>
> diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
> new file mode 100644
> index 0000000000000000..14994515beb341ce
> --- /dev/null
> +++ b/tools/perf/util/disasm_bpf.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "util/annotate.h"
> +#include "util/disasm_bpf.h"
> +#include "util/symbol.h"
> +
> +#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
> +#define PACKAGE "perf"
> +#include <bfd.h>
> +#include <bpf/bpf.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf.h>
> +#include <dis-asm.h>
> +#include <errno.h>
> +#include <linux/btf.h>
> +#include <tools/dis-asm-compat.h>
> +
> +#include "util/bpf-event.h"
> +#include "util/bpf-utils.h"
> +#include "util/debug.h"
> +#include "util/dso.h"
> +#include "util/map.h"
> +#include "util/env.h"
> +#include "util/util.h"
> +
> +int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *ar=
gs)
> +{
> +       struct annotation *notes =3D symbol__annotation(sym);
> +       struct bpf_prog_linfo *prog_linfo =3D NULL;
> +       struct bpf_prog_info_node *info_node;
> +       int len =3D sym->end - sym->start;
> +       disassembler_ftype disassemble;
> +       struct map *map =3D args->ms.map;
> +       struct perf_bpil *info_linear;
> +       struct disassemble_info info;
> +       struct dso *dso =3D map__dso(map);
> +       int pc =3D 0, count, sub_id;
> +       struct btf *btf =3D NULL;
> +       char tpath[PATH_MAX];
> +       size_t buf_size;
> +       int nr_skip =3D 0;
> +       char *buf;
> +       bfd *bfdf;
> +       int ret;
> +       FILE *s;
> +
> +       if (dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BPF_PROG_INFO)
> +               return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
> +
> +       pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n"=
, __func__,
> +                 sym->name, sym->start, sym->end - sym->start);
> +
> +       memset(tpath, 0, sizeof(tpath));
> +       perf_exe(tpath, sizeof(tpath));
> +
> +       bfdf =3D bfd_openr(tpath, NULL);
> +       if (bfdf =3D=3D NULL)
> +               abort();
> +
> +       if (!bfd_check_format(bfdf, bfd_object))
> +               abort();
> +
> +       s =3D open_memstream(&buf, &buf_size);
> +       if (!s) {
> +               ret =3D errno;
> +               goto out;
> +       }
> +       init_disassemble_info_compat(&info, s,
> +                                    (fprintf_ftype) fprintf,
> +                                    fprintf_styled);
> +       info.arch =3D bfd_get_arch(bfdf);
> +       info.mach =3D bfd_get_mach(bfdf);
> +
> +       info_node =3D perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->en=
v,
> +                                                dso__bpf_prog(dso)->id);
> +       if (!info_node) {
> +               ret =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> +               goto out;
> +       }
> +       info_linear =3D info_node->info_linear;
> +       sub_id =3D dso__bpf_prog(dso)->sub_id;
> +
> +       info.buffer =3D (void *)(uintptr_t)(info_linear->info.jited_prog_=
insns);
> +       info.buffer_length =3D info_linear->info.jited_prog_len;
> +
> +       if (info_linear->info.nr_line_info)
> +               prog_linfo =3D bpf_prog_linfo__new(&info_linear->info);
> +
> +       if (info_linear->info.btf_id) {
> +               struct btf_node *node;
> +
> +               node =3D perf_env__find_btf(dso__bpf_prog(dso)->env,
> +                                         info_linear->info.btf_id);
> +               if (node)
> +                       btf =3D btf__new((__u8 *)(node->data),
> +                                      node->data_size);
> +       }
> +
> +       disassemble_init_for_target(&info);
> +
> +#ifdef DISASM_FOUR_ARGS_SIGNATURE
> +       disassemble =3D disassembler(info.arch,
> +                                  bfd_big_endian(bfdf),
> +                                  info.mach,
> +                                  bfdf);
> +#else
> +       disassemble =3D disassembler(bfdf);
> +#endif
> +       if (disassemble =3D=3D NULL)
> +               abort();
> +
> +       fflush(s);
> +       do {
> +               const struct bpf_line_info *linfo =3D NULL;
> +               struct disasm_line *dl;
> +               size_t prev_buf_size;
> +               const char *srcline;
> +               u64 addr;
> +
> +               addr =3D pc + ((u64 *)(uintptr_t)(info_linear->info.jited=
_ksyms))[sub_id];
> +               count =3D disassemble(pc, &info);
> +
> +               if (prog_linfo)
> +                       linfo =3D bpf_prog_linfo__lfind_addr_func(prog_li=
nfo,
> +                                                               addr, sub=
_id,
> +                                                               nr_skip);
> +
> +               if (linfo && btf) {
> +                       srcline =3D btf__name_by_offset(btf, linfo->line_=
off);
> +                       nr_skip++;
> +               } else
> +                       srcline =3D NULL;
> +
> +               fprintf(s, "\n");
> +               prev_buf_size =3D buf_size;
> +               fflush(s);
> +
> +               if (!annotate_opts.hide_src_code && srcline) {
> +                       args->offset =3D -1;
> +                       args->line =3D strdup(srcline);
> +                       args->line_nr =3D 0;
> +                       args->fileloc =3D NULL;
> +                       args->ms.sym  =3D sym;
> +                       dl =3D disasm_line__new(args);
> +                       if (dl) {
> +                               annotation_line__add(&dl->al,
> +                                                    &notes->src->source)=
;
> +                       }
> +               }
> +
> +               args->offset =3D pc;
> +               args->line =3D buf + prev_buf_size;
> +               args->line_nr =3D 0;
> +               args->fileloc =3D NULL;
> +               args->ms.sym  =3D sym;
> +               dl =3D disasm_line__new(args);
> +               if (dl)
> +                       annotation_line__add(&dl->al, &notes->src->source=
);
> +
> +               pc +=3D count;
> +       } while (count > 0 && pc < len);
> +
> +       ret =3D 0;
> +out:
> +       free(prog_linfo);
> +       btf__free(btf);
> +       fclose(s);
> +       bfd_close(bfdf);
> +       return ret;
> +}
> +#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
> +int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct an=
notate_args *args __maybe_unused)
> +{
> +       return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
> +}
> +#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
> +
> +int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_ar=
gs *args)
> +{
> +       struct annotation *notes =3D symbol__annotation(sym);
> +       struct disasm_line *dl;
> +
> +       args->offset =3D -1;
> +       args->line =3D strdup("to be implemented");
> +       args->line_nr =3D 0;
> +       args->fileloc =3D NULL;
> +       dl =3D disasm_line__new(args);
> +       if (dl)
> +               annotation_line__add(&dl->al, &notes->src->source);
> +
> +       zfree(&args->line);
> +       return 0;
> +}
> diff --git a/tools/perf/util/disasm_bpf.h b/tools/perf/util/disasm_bpf.h
> new file mode 100644
> index 0000000000000000..2ecb19545388b114
> --- /dev/null
> +++ b/tools/perf/util/disasm_bpf.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#ifndef __PERF_DISASM_BPF_H
> +#define __PERF_DISASM_BPF_H
> +
> +struct symbol;
> +struct annotate_args;
> +
> +int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *ar=
gs);
> +int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_ar=
gs *args);
> +
> +#endif /* __PERF_DISASM_BPF_H */
> --
> 2.45.2
>

