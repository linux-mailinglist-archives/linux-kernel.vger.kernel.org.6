Return-Path: <linux-kernel+bounces-404326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAF9C4272
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A6B2701C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229701A08C2;
	Mon, 11 Nov 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBsW7vSb"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD419D093
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341768; cv=none; b=SR4nA2+eqopsKidMBC8bRVyQNlL7UEk1tkZEo9mLf1UEW0BJM7YYPgP/ecpZDKrgBE9uwj4VlcIqF39DdhEgcwN9EreSluLUpjJ7IPcELmbnyH/2Y5GQbiSCCGc1rrqn/oSZLTnArUqgZ4HdY8RxOfpAcSl9CSi3LseskdeqTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341768; c=relaxed/simple;
	bh=bc4KAQgTO/LpNZDhBvbFp6qGF1a90shX6G5VP3QrCVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haXOpGJiq23Lrah+ImkJJJ622LEFBDfRkkXFM/dlMlHpx9kUEczNrA87veqxh45KFQDZoAKimL1reGp1tsgzHZ5jwc6lss1uGx1L8CwZYFH6t8ndWX+4gc0fpWZ5EmHNPII07mUlHtJ9HA+Pd+Cy24M3g4O0VaSBj9geAw+VY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBsW7vSb; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so511425ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731341765; x=1731946565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7An62prIT0mx4+wHQH6g2p+dtTcsG620N4i8weLcLo=;
        b=MBsW7vSbsn0kbc9qfJ5QBwKBjgrXI/GD2wEoVJ4H3YbGMthgA6Fv1CflHlKVVhTRmL
         iiTonyPzWpN/+WZdNSbqWTqZcqKqZqizsKlLS/i6KWfZJWuIz0flpYglvYRmTipZhuFa
         d0MVvEkhEb7ue4oe8KpTGtJGJYrwaj5eBBdy3jkS1aRhgzftbIxfUdnZ+qgjzjhSmavQ
         dlofCrXzbCfULJmTFwIc9Q4r4YOCx+YOp96AwU58YzzVh7XdKyNV8sKXKM3kSMYMhDa0
         Y3O4HD2iX7RIT17AS21rJ2tlYkWDo3JuGzOTWDWFmttNVmyBRqjkKBi1kMR31lyx6Qyj
         AqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341765; x=1731946565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7An62prIT0mx4+wHQH6g2p+dtTcsG620N4i8weLcLo=;
        b=Vki7I9hcur+Y1V/x1ZyAEL9EtZ9Mw68IrerN9MM1Xc4Uvj+0pCc0Trq9WcV4vMd9WK
         0AiwNRpjlFOADBM+tuzq8u358t8CpMJGDL9aql+GtcCqWz3/dQMq3iSHOsYIWC/GtyFg
         gYgNga8rttj0SowqJFaBB3I6BiKMHj5uFPTYscGDvdhbmDxvJf14C68dLRkbe6WT1d7H
         eKz8ceRNN2Zs86hM5/JgVjSB3pZ/FAc8u63Edhll464vLNqT/uzaoHRAZ0xSksrKj35m
         Mx1yA4jH5c0OBWjXp6pYMj9Kv1J470UGCVgs27b21bhG7pWeyO8fk7a7GVj9P8JYm97y
         MmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLNqycfVYH4vuryY9ck3z4sD/Xi3psXwTPMkViEFlX8fbMWbTFVnOVIfgTdTtBUZuKR0dTbWQdWm5twu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGSy4P47xkj7xbb0eorVhg2717JM7U+GfzayxSkP2IIdoeD/J
	KUss6aoP8oZBrlh59q0FpD8PAICNg+Ih22a8E6T6Yc8gSo0nJijlBVKfcc9v7b1rgG1lJJIH0i5
	3XSbwePiD9m6iYW1w6TUpTCl0xQllN+U2N4vG
X-Gm-Gg: ASbGncsP7HMN6auzDugYKIRt8Q4tq9UoSXle0yYW5209OQzURXQGjnntLOAOZLMWRA8
	bFNpWUVvrAqXg/hOtMGg0VP+gymj6wPMzAiCViRKQOVUNtwE5+zH0/dRmW6/6mWY=
X-Google-Smtp-Source: AGHT+IHWCPReyu3goMc7v/I2utHhizkuzvgKH/WebrIaU7sxzP5C7tYELPhfV952bZmJDSIJPwFxgpFMd2ZQiSjChCs=
X-Received: by 2002:a92:c546:0:b0:3a5:e506:162b with SMTP id
 e9e14a558f8ab-3a6f95396a3mr8100635ab.11.1731341765453; Mon, 11 Nov 2024
 08:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111151734.1018476-1-acme@kernel.org> <20241111151734.1018476-2-acme@kernel.org>
In-Reply-To: <20241111151734.1018476-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 08:15:53 -0800
Message-ID: <CAP-5=fXxwf2wJf-JN7p5F_-V7WdDt_s9jk+Mz5YMkH+9gkpJUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf disasm: Introduce symbol__disassemble_objdump()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:17=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> With the first disassemble method in perf, the parsing of objdump
> output, just like we have for llvm and capstone.
>
> This paves the way to allow the user to specify what disassemblers are
> preferred and to also to at some point allow building without the
> objdump method.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steinar H. Gunderson <sesse@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Nit below relating to a pre-existing condition in the code.

> ---
>  tools/perf/util/disasm.c | 168 ++++++++++++++++++++-------------------
>  1 file changed, 88 insertions(+), 80 deletions(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index a525b80b934fdb5f..36cf61602c17fe69 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -2045,17 +2045,14 @@ static char *expand_tabs(char *line, char **stora=
ge, size_t *storage_len)
>         return new_line;
>  }
>
> -int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> +static int symbol__disassemble_objdump(const char *filename, struct symb=
ol *sym,
> +                                      struct annotate_args *args)
>  {
>         struct annotation_options *opts =3D &annotate_opts;
>         struct map *map =3D args->ms.map;
>         struct dso *dso =3D map__dso(map);
>         char *command;
>         FILE *file;
> -       char symfs_filename[PATH_MAX];
> -       struct kcore_extract kce;
> -       bool delete_extract =3D false;
> -       bool decomp =3D false;
>         int lineno =3D 0;
>         char *fileloc =3D NULL;
>         int nline;
> @@ -2070,77 +2067,7 @@ int symbol__disassemble(struct symbol *sym, struct=
 annotate_args *args)
>                 NULL,
>         };
>         struct child_process objdump_process;
> -       int err =3D dso__disassemble_filename(dso, symfs_filename, sizeof=
(symfs_filename));
> -
> -       if (err)
> -               return err;
> -
> -       pr_debug("%s: filename=3D%s, sym=3D%s, start=3D%#" PRIx64 ", end=
=3D%#" PRIx64 "\n", __func__,
> -                symfs_filename, sym->name, map__unmap_ip(map, sym->start=
),
> -                map__unmap_ip(map, sym->end));
> -
> -       pr_debug("annotating [%p] %30s : [%p] %30s\n",
> -                dso, dso__long_name(dso), sym, sym->name);
> -
> -       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO) =
{
> -               return symbol__disassemble_bpf(sym, args);
> -       } else if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_IMAG=
E) {
> -               return symbol__disassemble_bpf_image(sym, args);
> -       } else if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUN=
D) {
> -               return -1;
> -       } else if (dso__is_kcore(dso)) {
> -               kce.kcore_filename =3D symfs_filename;
> -               kce.addr =3D map__rip_2objdump(map, sym->start);
> -               kce.offs =3D sym->start;
> -               kce.len =3D sym->end - sym->start;
> -               if (!kcore_extract__create(&kce)) {
> -                       delete_extract =3D true;
> -                       strlcpy(symfs_filename, kce.extract_filename,
> -                               sizeof(symfs_filename));
> -               }
> -       } else if (dso__needs_decompress(dso)) {
> -               char tmp[KMOD_DECOMP_LEN];
> -
> -               if (dso__decompress_kmodule_path(dso, symfs_filename,
> -                                                tmp, sizeof(tmp)) < 0)
> -                       return -1;
> -
> -               decomp =3D true;
> -               strcpy(symfs_filename, tmp);
> -       }
> -
> -       /*
> -        * For powerpc data type profiling, use the dso__data_read_offset
> -        * to read raw instruction directly and interpret the binary code
> -        * to understand instructions and register fields. For sort keys =
as
> -        * type and typeoff, disassemble to mnemonic notation is
> -        * not required in case of powerpc.
> -        */
> -       if (arch__is(args->arch, "powerpc")) {
> -               extern const char *sort_order;
> -
> -               if (sort_order && !strstr(sort_order, "sym")) {
> -                       err =3D symbol__disassemble_raw(symfs_filename, s=
ym, args);
> -                       if (err =3D=3D 0)
> -                               goto out_remove_tmp;
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> -                       err =3D symbol__disassemble_capstone_powerpc(symf=
s_filename, sym, args);
> -                       if (err =3D=3D 0)
> -                               goto out_remove_tmp;
> -#endif
> -               }
> -       }
> -
> -#ifdef HAVE_LIBLLVM_SUPPORT
> -       err =3D symbol__disassemble_llvm(symfs_filename, sym, args);
> -       if (err =3D=3D 0)
> -               goto out_remove_tmp;
> -#endif
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> -       err =3D symbol__disassemble_capstone(symfs_filename, sym, args);
> -       if (err =3D=3D 0)
> -               goto out_remove_tmp;
> -#endif
> +       int err;
>
>         err =3D asprintf(&command,
>                  "%s %s%s --start-address=3D0x%016" PRIx64
> @@ -2163,13 +2090,13 @@ int symbol__disassemble(struct symbol *sym, struc=
t annotate_args *args)
>
>         if (err < 0) {
>                 pr_err("Failure allocating memory for the command to run\=
n");
> -               goto out_remove_tmp;
> +               return err;
>         }
>
>         pr_debug("Executing: %s\n", command);
>
>         objdump_argv[2] =3D command;
> -       objdump_argv[4] =3D symfs_filename;
> +       objdump_argv[4] =3D filename;
>
>         /* Create a pipe to read from for stdout */
>         memset(&objdump_process, 0, sizeof(objdump_process));
> @@ -2207,8 +2134,8 @@ int symbol__disassemble(struct symbol *sym, struct =
annotate_args *args)
>                         break;
>
>                 /* Skip lines containing "filename:" */
> -               match =3D strstr(line, symfs_filename);
> -               if (match && match[strlen(symfs_filename)] =3D=3D ':')
> +               match =3D strstr(line, filename);
> +               if (match && match[strlen(filename)] =3D=3D ':')
>                         continue;
>
>                 expanded_line =3D strim(line);
> @@ -2253,6 +2180,87 @@ int symbol__disassemble(struct symbol *sym, struct=
 annotate_args *args)
>
>  out_free_command:
>         free(command);
> +       return err;
> +}
> +
> +int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> +{
> +       struct map *map =3D args->ms.map;
> +       struct dso *dso =3D map__dso(map);
> +       char symfs_filename[PATH_MAX];
> +       bool delete_extract =3D false;
> +       struct kcore_extract kce;
> +       bool decomp =3D false;
> +       int err =3D dso__disassemble_filename(dso, symfs_filename, sizeof=
(symfs_filename));
> +
> +       if (err)
> +               return err;
> +
> +       pr_debug("%s: filename=3D%s, sym=3D%s, start=3D%#" PRIx64 ", end=
=3D%#" PRIx64 "\n", __func__,
> +                symfs_filename, sym->name, map__unmap_ip(map, sym->start=
),
> +                map__unmap_ip(map, sym->end));
> +
> +       pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_nam=
e(dso), sym, sym->name);
> +
> +       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO) =
{
> +               return symbol__disassemble_bpf(sym, args);
> +       } else if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_IMAG=
E) {
> +               return symbol__disassemble_bpf_image(sym, args);
> +       } else if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUN=
D) {
> +               return -1;
> +       } else if (dso__is_kcore(dso)) {
> +               kce.addr =3D map__rip_2objdump(map, sym->start);
> +               kce.kcore_filename =3D symfs_filename;
> +               kce.len =3D sym->end - sym->start;
> +               kce.offs =3D sym->start;
> +
> +               if (!kcore_extract__create(&kce)) {
> +                       delete_extract =3D true;
> +                       strlcpy(symfs_filename, kce.extract_filename, siz=
eof(symfs_filename));
> +               }
> +       } else if (dso__needs_decompress(dso)) {
> +               char tmp[KMOD_DECOMP_LEN];
> +
> +               if (dso__decompress_kmodule_path(dso, symfs_filename, tmp=
, sizeof(tmp)) < 0)
> +                       return -1;
> +
> +               decomp =3D true;
> +               strcpy(symfs_filename, tmp);
> +       }
> +
> +       /*
> +        * For powerpc data type profiling, use the dso__data_read_offset=
 to
> +        * read raw instruction directly and interpret the binary code to
> +        * understand instructions and register fields. For sort keys as =
type
> +        * and typeoff, disassemble to mnemonic notation is not required =
in
> +        * case of powerpc.
> +        */
> +       if (arch__is(args->arch, "powerpc")) {
> +               extern const char *sort_order;
> +
> +               if (sort_order && !strstr(sort_order, "sym")) {
> +                       err =3D symbol__disassemble_raw(symfs_filename, s=
ym, args);
> +                       if (err =3D=3D 0)
> +                               goto out_remove_tmp;
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +                       err =3D symbol__disassemble_capstone_powerpc(symf=
s_filename, sym, args);
> +                       if (err =3D=3D 0)
> +                               goto out_remove_tmp;
> +#endif
> +               }
> +       }
> +
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +       err =3D symbol__disassemble_llvm(symfs_filename, sym, args);
> +       if (err =3D=3D 0)
> +               goto out_remove_tmp;
> +#endif
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +       err =3D symbol__disassemble_capstone(symfs_filename, sym, args);
> +       if (err =3D=3D 0)
> +               goto out_remove_tmp;
> +#endif
> +       err =3D symbol__disassemble_objdump(symfs_filename, sym, args);

This sure does read like the symbol will be disassembled 3 times if
those ifdefs are defined. Is there anyway to make the code look more
intuitive?

Thanks,
Ian

>
>  out_remove_tmp:
>         if (decomp)
> --
> 2.47.0
>

