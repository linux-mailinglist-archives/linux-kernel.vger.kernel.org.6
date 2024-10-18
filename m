Return-Path: <linux-kernel+bounces-370762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EBA9A31BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DEE2810FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35183BBEB;
	Fri, 18 Oct 2024 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3oarrMh"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989B2A1C9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212275; cv=none; b=TtCsQ3FMDUR196pFAihgKtjXfRheG64WbwjKpMNkBUbkvJCs4te3Vh0PLUhXPqxcUMvQygI2Gj/okB5jf+dNKktW1pxFfjlM2p0+thfAd0DqWbe7uhXnJV2PrXOAIhEmWurrXWhur4LRlqkTJhulIMBMCFSreVCqUxlcykKL+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212275; c=relaxed/simple;
	bh=KAFtCHLJFVlmoM7hXF7tzKUy7zX84mHwUodBO4ztuu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPi4BR9vhw3A6Q9slY1TTtrp7N0ufhb8u8GU4LwcpVzt9UmpTuJI4VWD3BxxTtB0Tz+7IlbpoWMUfK8tGzgXvfJDFmVp254HCNiqYCoaaW4r5hYHFYTRcPuX+6A3T0Adwvevh4BJOQ3SfOASJph/xwsnxGpkrUy+PrCmSCuaN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3oarrMh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43158625112so14377415e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729212271; x=1729817071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAvkFrdc7zAxYyluwBsnI5D7V9ZNzBP/jZq5jYVwZ9E=;
        b=P3oarrMhc6ENDbA3qw6KpxULWmmwTlUxDwTCilSRk2pwO3qpoCCt7CRUsJ3++Bvdqk
         FFqT5WBnazSBv9Wq4gEQ7FI0xvZCP9E5L4Rm52bogVqfRzwNhGowqddg3dI15wco5Kdu
         hv5MShRrJoF0Nv3ogU2g8mfQqliWhmE1/tJKywwoPauDGx3S5Fg+cqOaRntdXzHafXpz
         bAaLT1F3EkYOq5JTiNB3Km/DhxYQ5jlXehhg+wRq44fiSi5fuf675RUP39vaP64LZANp
         dK4bfDr3myZ7hfHGWOZaEBy64F2VXjScuPXcJFITCQxYS9HOLjbrgk6St1xspHai3WPe
         yhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729212271; x=1729817071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAvkFrdc7zAxYyluwBsnI5D7V9ZNzBP/jZq5jYVwZ9E=;
        b=UpC241mJSPv3dcd5GlCNuTqUpmpLxFqVIf33494zsCfsoNn15Y4p1JQ0nZIKERD6wc
         Ys5MIb0z5lzOPGVGfkkd+0MD5IuaZbzbzUNh1iwcRrElBiYQPcG++NIQuxRyPxnACbol
         zFOSshJieoAojEbpHfnfrdv24RvbXJeUA3V2IarWdhEAAhJTANcOrVxai4cTsG+txmO5
         JavwnrgBpokGpVbZcPA3fU9iEprR4ddqeCkZMTsU4+5CBn3bi3oJW+gM1S2jIws9bvq/
         GYLW0qOea4o+8XKzIAWi/v0twIQwIZAL2HraNBWXFIeDdCQ3Z1ioDwmwHXBUiPq4/efx
         c2zw==
X-Forwarded-Encrypted: i=1; AJvYcCWgj8GOYK5oG0DKvZa83Qxx3kB6OsjngXMvBIlntm/e06kPypBAbvi8UQVXHN/XOghqm8BJM56RQD9AFT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvefqz5EhUzKAgc7F3ykyrHovjpyp67kU3xgt9nVrwf+1tXxC9
	D5LtpxuNAz8xPdwGqLHwAame79QQZ20XPhgtypC9kipNGF+ZuLTiYjzLCCiUgzpAW3cQ9qsVvbU
	thBVwhtHTJE+QdfSHjhFps1YZ5w+sYg==
X-Google-Smtp-Source: AGHT+IF9kgJ1l7H5IOg3O67L8AxQau/qsbTUlY71tr6uUVQ9ugyAVXYznkLliAt/1UJ4vi4K2/c0IPfwI3ZxhC8X+oY=
X-Received: by 2002:a5d:4903:0:b0:37d:4eeb:7375 with SMTP id
 ffacd0b85a97d-37ea2164baemr367751f8f.16.1729212271270; Thu, 17 Oct 2024
 17:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017214251.170602-1-niharchaithanya@gmail.com>
In-Reply-To: <20241017214251.170602-1-niharchaithanya@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 18 Oct 2024 02:44:20 +0200
Message-ID: <CA+fCnZfT80jDpQ5Dh-4w+eGQGoJQYd-F6h=_qNP4aw81TUMOCw@mail.gmail.com>
Subject: Re: [PATCH] kasan:report: filter out kasan related stack entries
To: Nihar Chaithanya <niharchaithanya@gmail.com>, Marco Elver <elver@google.com>, dvyukov@google.com, 
	Aleksandr Nogikh <nogikh@google.com>
Cc: ryabinin.a.a@gmail.com, skhan@linuxfoundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:46=E2=80=AFPM Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> The reports of KASAN include KASAN related stack frames which are not
> the point of interest in the stack-trace. KCSAN report filters out such
> internal frames providing relevant stack trace. Currently, KASAN reports
> are generated by dump_stack_lvl() which prints the entire stack.
>
> Add functionality to KASAN reports to save the stack entries and filter
> out the kasan related stack frames in place of dump_stack_lvl().
>
> Within this new functionality:
>         - A function save_stack_lvl_kasan() in place of dump_stack_lvl() =
is
>           created which contains functionality for saving, filtering and =
printing
>           the stack-trace.
>         - The stack-trace is saved to an array using stack_trace_save() s=
imilar to
>           KCSAN reporting which is useful for filtering the stack-trace,
>         - The sanitize_stack_entries() function is included to get the nu=
mber of
>           entries to be skipped for filtering similar to KCSAN reporting,
>         - The dump_stack_print_info() which prints generic debug info is =
included
>           from __dump_stack(),
>         - And the function print_stack_trace() to print the stack-trace u=
sing the
>           array containing stack entries as well as the number of entries=
 to be
>           skipped or filtered out is included.
>
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D215756

Great start!

One part that is missing is also filtering out KASAN frames in stack
traces printed from print_track(). Right now it call
stack_depot_print() to print the stack trace. I think the way to
approach this would be to use stack_depot_fetch(), memcpy the frames
to a local buffer, and then reuse the stack trace printing code you
added.

I've also left some comments below.

Please address these points first and send v2. Then, I'll test the
patch and see if there's more things to be done.

On a related note, I wonder if losing the additional annotations about
which part of the stack trace belongs with context (task, irq, etc)
printed by dump_stack() would be a problem. But worst case, we can
hide stack frame filtering under a CONFIG option.

> ---
>  mm/kasan/report.c | 92 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index b48c768acc84..c180cd8b32ae 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -39,6 +39,7 @@ static unsigned long kasan_flags;
>
>  #define KASAN_BIT_REPORTED     0
>  #define KASAN_BIT_MULTI_SHOT   1
> +#define NUM_STACK_ENTRIES 64

If we keep this as 64, we can reuse KASAN_STACK_DEPTH.

However, I wonder if 64 frames is enough. Marco, Alexander, Dmitry,
IIRC you did some measurements on the length of stack traces in the
kernel: would 64 frames be good enough for KASAN reports? Was this
ever a problem for KCSAN?

>
>  enum kasan_arg_fault {
>         KASAN_ARG_FAULT_DEFAULT,
> @@ -369,12 +370,99 @@ static inline bool init_task_stack_addr(const void =
*addr)
>                         sizeof(init_thread_union.stack));
>  }
>
> +/* Helper to skip KASAN-related functions in stack-trace. */
> +static int get_stack_skipnr(const unsigned long stack_entries[], int num=
_entries)
> +{
> +       char buf[64];
> +       int len, skip;
> +
> +       for (skip =3D 0; skip < num_entries; ++skip) {
> +               len =3D scnprintf(buf, sizeof(buf), "%ps", (void *)stack_=
entries[skip]);
> +
> +               /* Never show  kasan_* functions. */
> +               if (strnstr(buf, "kasan_", len) =3D=3D buf)
> +                       continue;
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

Please also copy the comment for this function, it's useful for
understanding what's going on.

> +static int
> +replace_stack_entry(unsigned long stack_entries[], int num_entries, unsi=
gned long ip,
> +                   unsigned long *replaced)
> +{
> +       unsigned long symbolsize, offset;
> +       unsigned long target_func;
> +       int skip;
> +
> +       if (kallsyms_lookup_size_offset(ip, &symbolsize, &offset))
> +               target_func =3D ip - offset;
> +       else
> +               goto fallback;
> +
> +       for (skip =3D 0; skip < num_entries; ++skip) {
> +               unsigned long func =3D stack_entries[skip];
> +
> +               if (!kallsyms_lookup_size_offset(func, &symbolsize, &offs=
et))
> +                       goto fallback;
> +               func -=3D offset;
> +
> +               if (func =3D=3D target_func) {
> +                       *replaced =3D stack_entries[skip];
> +                       stack_entries[skip] =3D ip;
> +                       return skip;
> +               }
> +       }
> +
> +fallback:
> +       /* Should not happen; the resulting stack trace is likely mislead=
ing. */
> +       WARN_ONCE(1, "Cannot find frame for %pS in stack trace", (void *)=
ip);
> +       return get_stack_skipnr(stack_entries, num_entries);
> +}

Hm, There's some code duplication here between KCSAN and KASAN.
Although, the function above is the only part dully duplicated, so I
don't know whether it makes sense to try to factor it out into a
common file.

Marco, WDYT?

> +
> +static void
> +print_stack_trace(unsigned long stack_entries[], int num_entries, unsign=
ed long reordered_to)
> +{
> +       stack_trace_print(stack_entries, num_entries, 0);
> +       if (reordered_to)
> +               pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordere=
d_to);

This reordered_to is a KCSAN-specific part, KASAN doesn't need it.
Thus, this helper function is excessive, let's remove it.

> +}
> +
> +static int
> +sanitize_stack_entries(unsigned long stack_entries[], int num_entries, u=
nsigned long ip,
> +                      unsigned long *replaced)
> +{
> +       return ip ? replace_stack_entry(stack_entries, num_entries, ip, r=
eplaced) :
> +                         get_stack_skipnr(stack_entries, num_entries);
> +}
> +
> +static void save_stack_lvl_kasan(const char *log_lvl, struct kasan_repor=
t_info *info)

And this one we can then call print_stack_trace().

> +{
> +       unsigned long reordered_to =3D 0;
> +       unsigned long stack_entries[NUM_STACK_ENTRIES] =3D {0};
> +       int num_stack_entries =3D stack_trace_save(stack_entries, NUM_STA=
CK_ENTRIES, 1);
> +       int skipnr =3D sanitize_stack_entries(stack_entries,
> +                                num_stack_entries, info->ip, &reordered_=
to);
> +
> +       dump_stack_print_info(log_lvl);

No need to pass the log level down the call chain, just pass KERN_ERR
directly to dump_stack_print_info().

> +       pr_err("\n");

dump_stack() doesn't add a new line here, let's also drop it to keep
the report style as before.

> +
> +       print_stack_trace(stack_entries + skipnr, num_stack_entries - ski=
pnr,
> +                                        reordered_to);
> +       pr_err("\n");
> +}
> +
>  static void print_address_description(void *addr, u8 tag,
>                                       struct kasan_report_info *info)
>  {
>         struct page *page =3D addr_to_page(addr);
>
> -       dump_stack_lvl(KERN_ERR);
> +       save_stack_lvl_kasan(KERN_ERR, info);
>         pr_err("\n");
>
>         if (info->cache && info->object) {
> @@ -488,7 +576,7 @@ static void print_report(struct kasan_report_info *in=
fo)
>                 print_address_description(addr, tag, info);
>                 print_memory_metadata(info->first_bad_addr);
>         } else {
> -               dump_stack_lvl(KERN_ERR);
> +               save_stack_lvl_kasan(KERN_ERR, info);

Ah, looks like we have duplicated dump_stack_lvl() call. Let's move it
(or rather print_stack_trace() in this patch) before the if
(addr_has_metadata(addr)) check and the drop it from
print_address_description().

>         }
>  }

>
> --
> 2.34.1
>

