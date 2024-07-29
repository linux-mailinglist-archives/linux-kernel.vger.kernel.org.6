Return-Path: <linux-kernel+bounces-266049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22C93F9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29ADCB224EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683BA80027;
	Mon, 29 Jul 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6ukkpiZ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619B81AB6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268112; cv=none; b=LzNKWrUMFWL5GUozGRF5DZbrGXSdO9oCoGEZ1YwgnmDjaHIGb5EGhk2LV34idVBn6fvVbG0kW6tQKsdShHyAqlDI7i/RAsY9IH9ohIUsqg1qKEABXjSLhho/ATF56LWOB25UCGtryLwE56kCwwqemiYtwikWRN6u6xaYE5Cnt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268112; c=relaxed/simple;
	bh=3M44BJ/6llBRI3BY+/27BawTsfMJUQaBcNY4z9SHW/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XM1LsI3xxftqXayBLgPQWaIhlPJD+cHbdncs1fql5q1ChzTQIax7oeBQm+pnS0kXb5IaEw7GjVEU+eK94lbmkmRlxVP8WR5hp1uAuxZq9VGRBlLezX26GWtB4ZwfP8Pt0XdESoSC/y1VCQ6eV982+K7O8b0YdbYqox/gjECVyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6ukkpiZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so15215a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722268109; x=1722872909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXhuRVtdMgKztBG06DUybwA27IR+VJWVhO/lY2CgOJc=;
        b=z6ukkpiZFX3hyMBqjeoOg2GZleki2WIOgK2D4XYceEAUEzXHCQ5vljBHfNxtkJTEh2
         tGrO18uJk5CjMMp0Nbh9R+J62o/j/p1/0hkNmnY6GIAl3lxEgdIrHaDxSE9ziaCr5wnQ
         CVTkIQx9zH0fM05603Rgy636VPNxRzIJkhqK/8Sq9OD7rE7HfWVEeULaEQ/ysSltUzV0
         RbAsijnm6SHje4ZfQvctdSOiXVfXNB/2GSMao0Y0cakr9gX+aUFc/frNOU3lPmWSvX4c
         fw6rR35qVEByhux1MYM/FHcgWqZBmIaYNfeKQncpfya2j/nE0TPMzGYMILseakonoWnv
         ESNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268109; x=1722872909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXhuRVtdMgKztBG06DUybwA27IR+VJWVhO/lY2CgOJc=;
        b=LvsOkDLbcph99WG7nrVmTOOotlT4BZ28pCtAQG6Rs7ppTFlIJvRdoW523e0hwebCyk
         6KHBijJpx6Fmoo2MC3kwgX0jdlsH58RqTxn4nRrDLdsr/wRp1bGMJJrW1JUhj/l9aJ3C
         OXGL3aGvIDIF0tSF9iYVmnRk5ylkFfQ5EhxFc1z6AoTDhMiSC5qtvUyUur8oRlg86XdY
         gP3F+bmV6BrLSNPJEYdtBuTGphf2WdraZDecrQRlH/tiAiNDOGvNgIg3mGvzwxmoMUOL
         VrqQmnzrux+Nw6cglSUluo+I2tw58WxZ6NFEaAHwFljJAJdRyJomMO6h/Nu1F54KH/kK
         bn7g==
X-Forwarded-Encrypted: i=1; AJvYcCXCeldRgtGsO5MlfzY/oPbhyeQEPtkicBvI7JudPZJWPNxIfnJC7kopHahwDHX/iJ8dAOS3Kk+syn4McYgm7BOQDpHvABTMpX9Lu122
X-Gm-Message-State: AOJu0Yx4td94Kt7r8EcQ5pksjQjS70X8uoBi9mISK3EASoy/K1BRTKdn
	UktYvaB1XptC8RTGKH3+8KMcSJNbiU4Lgxpk4gBGm8/USk+sjr1kk5f7CPNRP4VPWIoDGqJS+7W
	iX32+1Cx/ijfotrhCkJDjfRKTly82JNC9O6E6
X-Google-Smtp-Source: AGHT+IH7QFyGS9sG4LuxOfocsqAqv82bMTA+QSn7azu9nOm+cFz5UNLcj0gpvytnicRkd122MuYcGBq2TC00htBHepI=
X-Received: by 2002:a05:6402:350c:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b40d4a1985mr8515a12.6.1722268108796; Mon, 29 Jul 2024 08:48:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
In-Reply-To: <20240627170900.1672542-4-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Jul 2024 17:47:51 +0200
Message-ID: <CAG48ez3VuVQbbCCPRudOGq8jTVkhH17qe6vv7opuCghHAAd3Zw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:08=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
> The need to get ELF build ID reliably is an important aspect when
> dealing with profiling and stack trace symbolization, and
> /proc/<pid>/maps textual representation doesn't help with this.
[...]
> @@ -539,6 +543,21 @@ static int do_procmap_query(struct proc_maps_private=
 *priv, void __user *uarg)
>                 }
>         }
>
> +       if (karg.build_id_size) {
> +               __u32 build_id_sz;
> +
> +               err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
> +               if (err) {
> +                       karg.build_id_size =3D 0;
> +               } else {
> +                       if (karg.build_id_size < build_id_sz) {
> +                               err =3D -ENAMETOOLONG;
> +                               goto out;
> +                       }
> +                       karg.build_id_size =3D build_id_sz;
> +               }
> +       }

The diff doesn't have enough context lines to see it here, but the two
closing curly braces above are another copy of exactly the same code
block from the preceding patch. The current state in mainline looks
like this, with two repetitions of exactly the same block:

[...]
                karg.dev_minor =3D 0;
                karg.inode =3D 0;
        }

        if (karg.build_id_size) {
                __u32 build_id_sz;

                err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
                if (err) {
                        karg.build_id_size =3D 0;
                } else {
                        if (karg.build_id_size < build_id_sz) {
                                err =3D -ENAMETOOLONG;
                                goto out;
                        }
                        karg.build_id_size =3D build_id_sz;
                }
        }

        if (karg.build_id_size) {
                __u32 build_id_sz;

                err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
                if (err) {
                        karg.build_id_size =3D 0;
                } else {
                        if (karg.build_id_size < build_id_sz) {
                                err =3D -ENAMETOOLONG;
                                goto out;
                        }
                        karg.build_id_size =3D build_id_sz;
                }
        }

        if (karg.vma_name_size) {
[...]

