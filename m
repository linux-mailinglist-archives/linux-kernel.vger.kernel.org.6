Return-Path: <linux-kernel+bounces-378135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FB39ACBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0508628148F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E61B5823;
	Wed, 23 Oct 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGuQOA77"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E11BD00A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692072; cv=none; b=RHJlhwd+YKl2zYCIo2CTs9qRm4BTWG1c5dNOamno7Mk8dybBlmH9q6yMBKAsryksYZ3sGaF7Og17/qoRgqMIVyhsXsNEhfIpB3g6GlTPusgOZIhfTfmt71IrmSfVK2qsUJPYpAEBOKobIqzSVXuxAYFWE568GvQTvtFXaRXl8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692072; c=relaxed/simple;
	bh=S6AMRs79SuQ2djaji7tKPTTRLOG1VxaYGRXaH0wL3E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2HKl/EDYoDE12O1DnMMyliumsboZDjqwtqzb2AVNKEJJ3JAFa9qzRDoIz43BNfMvVPO4mPm2ACVeTC0/pLz6eHEeZpC6N1iVupPIlF+Jrbv7hycrV561pKBkxbsVvJTvmLyXfahFGmpTweL1gusp8bXh9i+TeNARwj0FRo5QiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGuQOA77; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so4052518f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692069; x=1730296869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8YzErpd4tdnHMTvH6+uCPbK+63tVcUugmxIwcXzQFM=;
        b=mGuQOA77soOeZSku9X1w2Bum5Tc077GWeyX/Ywyml4JnSgOlEqwwMd75bXEM03hHqC
         rMuG8J1j1KWOmUJNDQVWtYEnhynS1PSCF4jTt0JvFuY/Pj71mt141lrfd9VxV3xg+ikr
         ZIGFtmaOdecL+lKBGrJ8bJZMaHSauwPdoka/htoVs9I2X+FtOhYUOGMzg1xMv5TvT/WN
         39mPrBeUlsJ5WTt2jVzjt/zxUpXc2NabvhG5YZLF+lMCAVbgpd3BSfWukjtG14Rh6pmE
         83HZQEjExGCDxn7/tDw3TzCdpL6tmREORZt2xJ/T4y6bMHkUGbSunMMKCsZFdFvsp0jU
         fU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692069; x=1730296869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8YzErpd4tdnHMTvH6+uCPbK+63tVcUugmxIwcXzQFM=;
        b=IkeXTOGGpwChYOf1x4Th64G/Q0cMBVpR09x8Blc9V12qaGoWCi/iwGi65dhO5Gf6FE
         Q3r6FROJ3om1FPoI2I4CSWi8DY4/oNpb5O88fDBBifeWtb/jdiRkCzj68ZQ/JcmbDBU/
         Ykjj5HJDhzFubwBp/ApKgWuA6LRzNqLSeu7IUQd8WTsvbSHDeC6oQct9JsO/d3q/UlcP
         KDkBgfyfgg4fygmmBUEzkbY8duFsnyfycT4m6yPrAhFMmXPud7E00k5NaDz2VUBgTQ8Y
         FYcHoh+sOkjeAmLvQxhWneZga7pIQfLkiWl+a84cRoABqINY6HKG164EaEAZdrpRCFHq
         H92w==
X-Forwarded-Encrypted: i=1; AJvYcCWQabtrktgGk3VXCtpA3Dma70GNrOD2e5rBtpBlz1TViMODOaX9EjBL3NpfrrbrJKIcoXDXxFxSqjH2dog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUy3H7c0OmZlpu6kzWaHxoFZhs9xEpk9oKhND9WY48cSD8jrwr
	5QTVmpzdTsG+PcxeUJvJUwjhT1ErhVacHQnbrdF9NoF3nEFkTVLrDDMS79wA08Gyu2+IEryDgxZ
	kRqI3nMt6c2gdHW2derFYQDynbiQ=
X-Google-Smtp-Source: AGHT+IERx+x72rOllmHv25G0WBLN+AK0GdwhvTr9uWQff+uNW8ha8OlXquSnGi0dvoehIiVS86aBfJjd7PMUiHQ/7l8=
X-Received: by 2002:a05:6000:12c6:b0:37c:c80e:d030 with SMTP id
 ffacd0b85a97d-37efcfa5050mr1831358f8f.53.1729692068380; Wed, 23 Oct 2024
 07:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021195714.50473-1-niharchaithanya@gmail.com>
In-Reply-To: <20241021195714.50473-1-niharchaithanya@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 23 Oct 2024 16:00:56 +0200
Message-ID: <CA+fCnZf7sX2-H_jRMcJhiYxYZ=5f5oQ7iO__pQnjEXDLUS+fkg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan:report: filter out kasan related stack entries
To: Nihar Chaithanya <niharchaithanya@gmail.com>, elver@google.com
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	skhan@linuxfoundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:58=E2=80=AFPM Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>

Let's change the patch name prefix to "kasan: report:" (i.e. add an
extra space between "kasan:" and "report:").

> The reports of KASAN include KASAN related stack frames which are not
> the point of interest in the stack-trace. KCSAN report filters out such
> internal frames providing relevant stack trace. Currently, KASAN reports
> are generated by dump_stack_lvl() which prints the entire stack.
>
> Add functionality to KASAN reports to save the stack entries and filter
> out the kasan related stack frames in place of dump_stack_lvl() and
> stack_depot_print().
>
> Within this new functionality:
>         - A function kasan_dump_stack_lvl() in place of dump_stack_lvl() =
is
>           created which contains functionality for saving, filtering and
>           printing the stack-trace.
>         - A function kasan_stack_depot_print() in place of
>           stack_depot_print() is created which contains functionality for
>           filtering and printing the stack-trace.
>         - The get_stack_skipnr() function is included to get the number o=
f
>           stack entries to be skipped for filtering the stack-trace.
>
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D215756
> ---
> Changes in v2:
>         - Changed the function name from save_stack_lvl_kasan() to
>           kasan_dump_stack_lvl().
>         - Added filtering of stack frames for print_track() with
>           kasan_stack_depot_print().
>         - Removed redundant print_stack_trace(), and instead using
>           stack_trace_print() directly.
>         - Removed sanitize_stack_entries() and replace_stack_entry()
>           functions.
>         - Increased the buffer size in get_stack_skipnr to 128.
>
> Note:
> When using sanitize_stack_entries() the output was innacurate for free an=
d
> alloc tracks, because of the missing ip value in print_track().
> The buffer size in get_stack_skipnr() is increase as it was too small whe=
n
> testing with some KASAN uaf bugs which included free and alloc tracks.
>
>  mm/kasan/report.c | 62 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index b48c768acc84..e00cf764693c 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -261,6 +261,59 @@ static void print_error_description(struct kasan_rep=
ort_info *info)
>                         info->access_addr, current->comm, task_pid_nr(cur=
rent));
>  }
>
> +/* Helper to skip KASAN-related functions in stack-trace. */
> +static int get_stack_skipnr(const unsigned long stack_entries[], int num=
_entries)
> +{
> +       char buf[128];
> +       int len, skip;
> +
> +       for (skip =3D 0; skip < num_entries; ++skip) {
> +               len =3D scnprintf(buf, sizeof(buf), "%ps", (void *)stack_=
entries[skip]);
> +
> +               /* Never show  kasan_* functions. */
> +               if (strnstr(buf, "kasan_", len) =3D=3D buf)
> +                       continue;

Also check for "__kasan_" prefix: Right now, for the very first KASAN
test, we get this alloc stack trace:

[    1.799579] Allocated by task 63:
[    1.799935]  __kasan_kmalloc+0x8b/0x90
[    1.800353]  kmalloc_oob_right+0x95/0x6c0
[    1.800801]  kunit_try_run_case+0x16e/0x280
[    1.801267]  kunit_generic_run_threadfn_adapter+0x77/0xe0
[    1.801863]  kthread+0x296/0x350
[    1.802224]  ret_from_fork+0x2b/0x70
[    1.802652]  ret_from_fork_asm+0x1a/0x30

The __kasan_kmalloc frame is a part of KASAN internals and we want to
skip that. kmalloc_oob_right is the function where the allocation
happened, and that should be the first stack trace frame.

(I suspect we'll have to adapt more of these from KFENCE, but let's do
that after resolving the other issues.)

> +               /*
> +                * No match for runtime functions -- @skip entries to ski=
p to
> +                * get to first frame of interest.
> +                */
> +               break;
> +       }
> +
> +       return skip;
> +}
> +
> +/*
> + * Use in place of stack_dump_lvl to filter KASAN related functions in
> + * stack_trace.

"Use in place of dump_stack() to filter out KASAN-related frames in
the stack trace."

> + */
> +static void kasan_dump_stack_lvl(void)

No need for the "_lvl" suffix - you removed the lvl argument.

> +{
> +       unsigned long stack_entries[KASAN_STACK_DEPTH] =3D { 0 };
> +       int num_stack_entries =3D stack_trace_save(stack_entries, KASAN_S=
TACK_DEPTH, 1);
> +       int skipnr =3D get_stack_skipnr(stack_entries, num_stack_entries)=
;

For printing the access stack trace, we still want to keep the
ip-based skipping (done via sanitize_stack_entries() in v1) - it's
more precise than pattern-based matching in get_stack_skipnr(). But
for alloc/free stack traces, we can only use get_stack_skipnr().

However, I realized I don't fully get the point of replacing a stack
trace entry when doind the ip-based skipping. Marco, is this something
KCSAN-specific? I see that this is used for reodered_to thing.

> +
> +       dump_stack_print_info(KERN_ERR);
> +       stack_trace_print(stack_entries + skipnr, num_stack_entries - ski=
pnr, 0);
> +       pr_err("\n");
> +}
> +
> +/*
> + * Use in place of stack_depot_print to filter KASAN related functions i=
n
> + * stack_trace.

"Use in place of stack_depot_print() to filter out KASAN-related
frames in the stack trace."

> + */
> +static void kasan_stack_depot_print(depot_stack_handle_t stack)
> +{
> +       unsigned long *entries;
> +       unsigned int nr_entries;
> +
> +       nr_entries =3D stack_depot_fetch(stack, &entries);
> +       int skipnr =3D get_stack_skipnr(entries, nr_entries);
> +
> +       if (nr_entries > 0)
> +               stack_trace_print(entries + skipnr, nr_entries - skipnr, =
0);
> +}
> +
>  static void print_track(struct kasan_track *track, const char *prefix)
>  {
>  #ifdef CONFIG_KASAN_EXTRA_INFO
> @@ -277,7 +330,7 @@ static void print_track(struct kasan_track *track, co=
nst char *prefix)
>         pr_err("%s by task %u:\n", prefix, track->pid);
>  #endif /* CONFIG_KASAN_EXTRA_INFO */
>         if (track->stack)
> -               stack_depot_print(track->stack);
> +               kasan_stack_depot_print(track->stack);
>         else
>                 pr_err("(stack is not available)\n");
>  }
> @@ -374,9 +427,6 @@ static void print_address_description(void *addr, u8 =
tag,
>  {
>         struct page *page =3D addr_to_page(addr);
>
> -       dump_stack_lvl(KERN_ERR);
> -       pr_err("\n");

This new line we want to keep.

> -
>         if (info->cache && info->object) {
>                 describe_object(addr, info);
>                 pr_err("\n");
> @@ -484,11 +534,11 @@ static void print_report(struct kasan_report_info *=
info)
>                 kasan_print_tags(tag, info->first_bad_addr);
>         pr_err("\n");
>
> +       kasan_dump_stack_lvl();
> +
>         if (addr_has_metadata(addr)) {
>                 print_address_description(addr, tag, info);
>                 print_memory_metadata(info->first_bad_addr);
> -       } else {
> -               dump_stack_lvl(KERN_ERR);
>         }
>  }
>
> --
> 2.34.1
>

Thank you!

