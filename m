Return-Path: <linux-kernel+bounces-383356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAE9B1A88
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 21:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E1A282471
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601AE170A1B;
	Sat, 26 Oct 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/3ZWv7q"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2410E5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729969555; cv=none; b=u6vbvogVBAG2fGcRtn/KlvBjQslKzx1Lb4sjIX5HP5LQaDrLTh2cjpsT0zP3P6fZOwz/QRjgQY08xSOHPCeqoO3lEhE/2Bj4NPZFuKdP4m/jjGq9w5AWIIBdvEn8k0hGQsR2kk6VVe4Bx1sYp9PaUOa7l0PwLyfpqEN635V6N18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729969555; c=relaxed/simple;
	bh=jHZUVEYeMqQUb9fDTc+kqjDZTy4vmF1ULGJ3DUgK7qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ray8ONBywSHDQMsZgR1D/00XcpWnhP6p5mP/TuElF0cn/rKgLuw1qp8LomE7hJ7yY0S2iKW+TE85Bt7tPhmPZbbx5Zutak0pyGK7U27QV1y/ZktM+/V/gxFXej9jl+Bf5OAjHdBWgZA1Dr70JVzGJ5FFx3/wOAtdT5dQFlKyGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/3ZWv7q; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db54269325so2259364a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729969553; x=1730574353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMu6nFv9m1WVpI3Z0zFLZSZgLAEo3FaBzaLQot1713w=;
        b=0/3ZWv7qYT+ZMBMUGdsMn/2ZPRF6s53gKqGZ0GGWiIzq2cVuRocONgDOaFOfTPevPU
         2Lc/UpHQlsvg0LFU3zaN/lqjyVa4xlaPwgMW0W8INeVro1f0By7k5fwpTXBaE9KLUtqJ
         Y930zDCSjy+0aOURmy4hdx3B/F6OUQ51XgrMZ9c6NgEuG0BGcHFWiGjhds1yXDFVqKVS
         IFU3+5rVX1+nunNJgKNFEfABkE9rHz0WQk44OuIfzA1oMrXxALg2v6qnBDy7lqOeW0jA
         W/oXD9fMubKu6sALMzFmrcKtbxy1wHxWatUKXy1vZmp37GI4zPh3nS5HQ/oaLocwLFpD
         plug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729969553; x=1730574353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMu6nFv9m1WVpI3Z0zFLZSZgLAEo3FaBzaLQot1713w=;
        b=cLRFdasx40CY+Xz2G3aRccqP9kTKZsARa/JhBlzYqfzTX6LKNxLLBC3nlK27e1W13l
         /A1QzStkbf6rWMoQIbbUHvAvTXfTLD8FISyG1MgkY7OC8OnjHo9g3B1N22iXFvkMpSsm
         GgdYCqoHqAWTMu7c7LHqYLNkxpLk2HA3f5mOFv/OsdenM4ryaDadQ/PtIU5+yePI93+g
         ougRgwHeYleNnQZSj2AoVTYDSDHoFLFe21eU28+i+7a9mneDsipb3HdAB/KU7a/h5slf
         KtFkDMLl7aVU8F4+8pGezvbTL2E3CHce0WzstyTju4jx2TAJHa77iAkzblHzkOwx/CR+
         X/gw==
X-Forwarded-Encrypted: i=1; AJvYcCUXwmyLrE6H7+FWGhFfq0ZwHkYqE5+9ph03Xh0H4yUWQr7vvglie0jdMqh7mK3QShru+dMIA1kem42Scwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4OXjZGqFsMgFEm2vRrfxUPsV2f4Vb3eAtyJEtdFmuoCavuQ5
	yvJ6vt6X6LnIUCxaXhaBpBAQsEg2nwDWuRfobDI6hyEWR1KAvBj2/vPluYSezam/gpHE+FCeTG2
	nT8rMOxHsu+7G6VOdNnMOoVDkYC/O2mwhi3ia
X-Google-Smtp-Source: AGHT+IG8xjaWBrnI/QWw1j1k7Eyg2Tg8ls2Y0Z7dhZ1ttGi9N4wPqq8F4HXWirz2kvkIPWxO8u0tSjrOE0oOw6e9AlU=
X-Received: by 2002:a05:6a21:1743:b0:1d9:77e1:9e57 with SMTP id
 adf61e73a8af0-1d9a83d019emr4901773637.11.1729969552489; Sat, 26 Oct 2024
 12:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026161413.222898-1-niharchaithanya@gmail.com>
In-Reply-To: <20241026161413.222898-1-niharchaithanya@gmail.com>
From: Marco Elver <elver@google.com>
Date: Sat, 26 Oct 2024 21:05:14 +0200
Message-ID: <CANpmjNPQQid6UirgZkBov-WhpyRR_5tqazvfS5f_K3PoAF3WYw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: report: filter out kasan related stack entries
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, andreyknvl@gmail.com, dvyukov@google.com, 
	glider@google.com, skhan@linuxfoundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Oct 2024 at 18:17, Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
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
>         - A function kasan_dump_stack_lvl() in place of dump_stack_lvl() is
>           created which contains functionality for saving, filtering and
>           printing the stack-trace.
>         - A function kasan_stack_depot_print() in place of
>           stack_depot_print() is created which contains functionality for
>           filtering and printing the stack-trace.
>         - The get_stack_skipnr() function which employs pattern based stack
>           filtering is included.
>         - The replace_stack_entry() function which uses ip value based
>           stack filtering is included.
>
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=215756
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
> Changes in v3:
>         - Included an additional criteria for pattern based filtering
>           in get_stack_skipnr().
>         - Included ip value based stack filtering with the functions
>           sanitize_stack_entries() and replace_stack_entry().
>         - Corrected the comments and name of the newly added functions
>           kasan_dump_stack() and kasan_stack_depot_print().
>
>  mm/kasan/report.c | 111 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3e48668c3e40..648a89fea3e7 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -261,6 +261,110 @@ static void print_error_description(struct kasan_report_info *info)
>                         info->access_addr, current->comm, task_pid_nr(current));
>  }
>
> +/* Helper to skip KASAN-related functions in stack-trace. */
> +static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
> +{
> +       char buf[64];
> +       int len, skip;
> +
> +       for (skip = 0; skip < num_entries; ++skip) {
> +               len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
> +
> +               /* Never show  kasan_* or __kasan_* functions. */
> +               if ((strnstr(buf, "kasan_", len) == buf) ||
> +                       (strnstr(buf, "__kasan_", len) == buf))
> +                       continue;
> +               /*
> +                * No match for runtime functions -- @skip entries to skip to
> +                * get to first frame of interest.
> +                */
> +               break;
> +       }
> +
> +       return skip;
> +}
> +
> +/*
> + * Skips to the first entry that matches the function of @ip, and then replaces
> + * that entry with @ip, returning the entries to skip with @replaced containing
> + * the replaced entry.
> + */
> +static int
> +replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned long ip,
> +                   unsigned long *replaced)
> +{
> +       unsigned long symbolsize, offset;
> +       unsigned long target_func;
> +       int skip;
> +
> +       if (kallsyms_lookup_size_offset(ip, &symbolsize, &offset))
> +               target_func = ip - offset;
> +       else
> +               goto fallback;
> +
> +       for (skip = 0; skip < num_entries; ++skip) {
> +               unsigned long func = stack_entries[skip];
> +
> +               if (!kallsyms_lookup_size_offset(func, &symbolsize, &offset))
> +                       goto fallback;
> +               func -= offset;
> +
> +               if (func == target_func) {
> +                       *replaced = stack_entries[skip];

All this replaced logic is not needed for KASAN.

> +                       stack_entries[skip] = ip;
> +                       return skip;
> +               }
> +       }
> +
> +fallback:
> +       /* Should not happen; the resulting stack trace is likely misleading. */
> +       WARN_ONCE(1, "Cannot find frame for %pS in stack trace", (void *)ip);
> +       return get_stack_skipnr(stack_entries, num_entries);
> +}
> +
> +static int
> +sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip,
> +                      unsigned long *replaced)
> +{
> +       return ip ? replace_stack_entry(stack_entries, num_entries, ip, replaced) :
> +                         get_stack_skipnr(stack_entries, num_entries);
> +}
> +
> +/*
> + * Use in place of dump_stack() to filter out KASAN-related frames in
> + * the stack trace.
> + */
> +static void kasan_dump_stack(unsigned long ip)
> +{
> +       unsigned long reordered_to = 0;

Do you understand what this code is doing? The whole "reordered_to"
logic (along with the "replaced" logic in replace_stack_entry()) is
very specific to KCSAN and not at all needed for KASAN. See the commit
that introduced it:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/kcsan/report.c?id=be3f6967ec5947dd7b2f23bf9d42bb2729889618

You've copied and pasted the code from KCSAN, in the hopes it more or
less does what we want. However, the code as-is is more complex than
needed.

Please try to really understand what the most optimal way to do this
might be. As additional inspiration, please look at how KFENCE does
it: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/kfence/report.c#n49

In the end what I'd like to see is the simplest possible way to do
this for KASAN.

