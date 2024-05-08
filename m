Return-Path: <linux-kernel+bounces-173566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393B8C0244
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B900B2240C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D879F6;
	Wed,  8 May 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wf5Jz71+"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D103D6D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186986; cv=none; b=UrjINW1IAbdsUhn/q8Qh9nW/03NkFPGceCM3z6NBb98CXD1C2BghwywvLKTgw5H0y7fvSEQykZSn5Bc66btLtzTJyxM36+ovkJ4Qzjlx9C7O8PLKkUZOVAV0tPr1l/oIdfp/5Fkvdj4LFr/aEyArBjbSIeq9Ag5/D/pgxgzLRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186986; c=relaxed/simple;
	bh=yAUwyyi//6rQZ6TQYRDK+pCV/Cnv8ejSWJjTbvPw8Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0ForQvRhthuPlilitZ7IxKVREbL04cfRfVVXdmRUadhO3fZ8XWSyfJ2SeuKHjVnDx7KFk6Atpu5XOmMJwOSCkadRFWaDJDB8wARilOgwD9WQU7f+p3kzNlEklU9tKAROwdAcOZo37ZCGwprmHO3Zzi1ICAdrzbQF4QlqKssdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wf5Jz71+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a934ad50so1093655666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715186983; x=1715791783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqiY82pP+oUOkFDwK0rSdutI8cJvBxh2Jo3lnsppe7k=;
        b=wf5Jz71+CwfNXzEZtCXA3mLF+cdGpDpWAyT+b15L9iN43WBvsgWDG0MU26VgwZfjLU
         4arW7y4jkurYrqxjUNQI4DoN3x4ZEqigt0jukWRz9kFbKeAKtivjjd/5eWmVKeHQVxXn
         oiIXwRTvPy0jmyQqZXpQIjM/oud5tKCH3H4Qm+OKyWCfxTcTFI03Y5zZ6mNg+uA+nsJr
         DnEpzDAR5KOKQ68RuCciw54uk06fSJdFz+qVUEXJaaa3qrcccdnyKjyCt7o7b2o+R9zf
         LqzlDSovoPnPrRPOTE1cij11r100GG99eFq5yKowf0K+rsuatQ7FjlKuI5W5iQouOId1
         IxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186983; x=1715791783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqiY82pP+oUOkFDwK0rSdutI8cJvBxh2Jo3lnsppe7k=;
        b=H0sCgGuGZL16Nrdc4Z3sPO0DyhODkqXO7sjMxZGXmHpjC2ZK1XgGe9gvTwTIrBoPOz
         iVk8e+UJbOU5ikro7ZPZFM3QWYdTl+II6lQDkPxKgotm740W4WibPPOursbqpWxFtudX
         +w/3eqnciXRda2kd6Hh362KJSATsXn0xS+a2CzKAmLiKY9IsC+nBGUZtSqixvepIO22+
         NFEZzeb3SPy+SMZWJY4WJ7U3rBrkP3J4GcgTlQ8P7I1CDMzH5Hz4WQUyqA+FgHduy/VQ
         IzmNqWzw92Ud0wUvHy+HdDTTXzJru0NxF6xgoA5/y9gitnRc+wmgPwZfEPPKK6evro/y
         ge5g==
X-Forwarded-Encrypted: i=1; AJvYcCVldhu1hWZ8jFgOe5Yd7EN4fMMOKPselJY/fmGxW2YECTuds1M5LeMoubJJEA3hN3h1zQ8NeWioWxaEnSVwiV71cWZvcGohLilzJSuK
X-Gm-Message-State: AOJu0YyLnO/0gx2+adybEdTbbMGt5hv6dmk1DwIHjQnl37CzWwTmsrrT
	xwuTH2YJ767CcJ+pUZAE3sWXhu8kOEUK9J9VIaEjgdANQoB426oPoAgb/bodpNaJxKAqcwMct46
	iGJQ+4kdQA7mvqFHO1OeCIVEn4JA1qaxmWPcO
X-Google-Smtp-Source: AGHT+IGylNLJehM/FOKtigjjdYwggjBh2t+TVlXasYlgbtfZnEPnX/eY/4zlcTXlMuGNKTOtkKB3pmH3Ddf2g4jqwlw=
X-Received: by 2002:a17:906:c78c:b0:a59:ced4:25af with SMTP id
 a640c23a62f3a-a59fb95d55cmr183230266b.41.1715186982572; Wed, 08 May 2024
 09:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508102222.4001882-1-usamaarif642@gmail.com>
In-Reply-To: <20240508102222.4001882-1-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 8 May 2024 09:49:05 -0700
Message-ID: <CAJD7tkYrYOqfNELGWmXq+BTy8FYNbpR92QFtO8VtBcD3avB=CA@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 3:22=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
> Attempt writeback with the below steps and check using
> memory.stat.zswpwb if zswap writeback occurred:
> 1. Allocate memory.
> 2. Reclaim memory equal to the amount that was allocated in step 1.
>    This will move it into zswap.
> 3. Save current zswap usage.
> 4. Move the memory allocated in step 1 back in from zswap.
> 5. Set zswap.max to half the amount that was recorded in step 3.
> 6. Attempt to reclaim memory equal to the amount that was allocated,
>    this will either trigger writeback if it's enabled, or reclamation
>    will fail if writeback is disabled as there isn't enough zswap
>    space.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>
> v3 -> v4 (Yosry Ahmed):
> - Use a fixed page-sized buffer for filling and checking memory when
>   attempting writeback
> - Use cg_write_numeric instead of cg_write for memory.reclaim
> - Improved error checking for zswpwb_before and zswpwb_after
>
> v2 -> v3:
> - Remove memory.max (Yosry Ahmed)
> - change from random allocation of memory to increasing and 0 allocation
>   (Yosry Ahmed)
> - stricter error checking when writeback is disabled (Yosry Ahmed)
> - Ensure zswpwb_before =3D=3D 0 (Yosry Ahmed)
> - Variable definition reorder, function name change (Yosry Ahmed)
>
> v1 -> v2:
> - Change method of causing writeback from limit zswap to memory reclaim.
>   (Further described in commit message) (Yosry Ahmed)
> - Document why using random memory (Nhat Pham)
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 130 +++++++++++++++++++-
>  1 file changed, 129 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index f0e488ed90d8..beab9b979957 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -50,7 +50,7 @@ static int get_zswap_stored_pages(size_t *value)
>         return read_int("/sys/kernel/debug/zswap/stored_pages", value);
>  }
>
> -static int get_cg_wb_count(const char *cg)
> +static long get_cg_wb_count(const char *cg)
>  {
>         return cg_read_key_long(cg, "memory.stat", "zswpwb");
>  }
> @@ -248,6 +248,132 @@ static int test_zswapin(const char *root)
>         return ret;
>  }
>
> +/*
> + * Attempt writeback with the following steps:
> + * 1. Allocate memory.
> + * 2. Reclaim memory equal to the amount that was allocated in step 1.
> +      This will move it into zswap.
> + * 3. Save current zswap usage.
> + * 4. Move the memory allocated in step 1 back in from zswap.
> + * 5. Set zswap.max to half the amount that was recorded in step 3.
> + * 6. Attempt to reclaim memory equal to the amount that was allocated,
> +      this will either trigger writeback if it's enabled, or reclamation
> +      will fail if writeback is disabled as there isn't enough zswap spa=
ce.
> + */
> +static int attempt_writeback(const char *cgroup, void *arg)
> +{
> +       long pagesize =3D sysconf(_SC_PAGESIZE);
> +       char *test_group =3D arg;
> +       size_t memsize =3D MB(4);
> +       char buf[pagesize];
> +       long zswap_usage;
> +       bool wb_enabled;
> +       int ret =3D -1;
> +       char *mem;
> +
> +       wb_enabled =3D cg_read_long(test_group, "memory.zswap.writeback")=
;
> +       mem =3D (char *)malloc(memsize);
> +       if (!mem)
> +               return ret;
> +
> +       /*
> +        * Fill half of each page with increasing data, and keep other
> +        * half empty, this will result in data that is still compressibl=
e
> +        * and ends up in zswap, with material zswap usage.
> +        */
> +       for (int i =3D 0; i < pagesize; i++)
> +               buf[i] =3D i < pagesize/2 ? (char) i : 0;
> +
> +       for (int i =3D 0; i < memsize; i +=3D pagesize)
> +               memcpy(&mem[i], buf, pagesize);
> +
> +       /* Try and reclaim allocated memory */
> +       if (cg_write_numeric(test_group, "memory.reclaim", memsize)) {
> +               ksft_print_msg("Failed to reclaim all of the requested me=
mory\n");
> +               goto out;
> +       }
> +
> +       zswap_usage =3D cg_read_long(test_group, "memory.zswap.current");
> +
> +       /* zswpin */
> +       for (int i =3D 0; i < memsize; i +=3D pagesize) {
> +               if (memcmp(&mem[i], buf, pagesize)) {
> +                       ksft_print_msg("invalid memory\n");
> +                       goto out;
> +               }
> +       }
> +
> +       if (cg_write_numeric(test_group, "memory.zswap.max", zswap_usage/=
2))
> +               goto out;
> +
> +       /*
> +        * If writeback is enabled, trying to reclaim memory now will tri=
gger a
> +        * writeback as zswap.max is half of what was needed when reclaim=
 ran the first time.
> +        * If writeback is disabled, memory reclaim will fail as zswap is=
 limited and
> +        * it can't writeback to swap.
> +        */
> +       ret =3D cg_write(test_group, "memory.reclaim", "4M");

We need cg_write_numeric(.., memsize) here as well.

Otherwise, this LGTM. After fixing this, feel free to add:

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> +       if (!wb_enabled)
> +               ret =3D (ret =3D=3D -EAGAIN) ? 0 : -1;
> +
> +out:
> +       free(mem);
> +       return ret;
> +}
> +
> +/* Test to verify the zswap writeback path */
> +static int test_zswap_writeback(const char *root, bool wb)
> +{
> +       long zswpwb_before, zswpwb_after;
> +       int ret =3D KSFT_FAIL;
> +       char *test_group;
> +
> +       test_group =3D cg_name(root, "zswap_writeback_test");
> +       if (!test_group)
> +               goto out;
> +       if (cg_create(test_group))
> +               goto out;
> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"=
))
> +               goto out;
> +
> +       zswpwb_before =3D get_cg_wb_count(test_group);
> +       if (zswpwb_before !=3D 0) {
> +               ksft_print_msg("zswpwb_before =3D %ld instead of 0\n", zs=
wpwb_before);
> +               goto out;
> +       }
> +
> +       if (cg_run(test_group, attempt_writeback, (void *) test_group))
> +               goto out;
> +
> +       /* Verify that zswap writeback occurred only if writeback was ena=
bled */
> +       zswpwb_after =3D get_cg_wb_count(test_group);
> +       if (zswpwb_after < 0)
> +               goto out;
> +
> +       if (wb !=3D !!zswpwb_after) {
> +               ksft_print_msg("zswpwb_after is %ld while wb is %s",
> +                               zswpwb_after, wb ? "enabled" : "disabled"=
);
> +               goto out;
> +       }
> +
> +       ret =3D KSFT_PASS;
> +
> +out:
> +       cg_destroy(test_group);
> +       free(test_group);
> +       return ret;
> +}
> +
> +static int test_zswap_writeback_enabled(const char *root)
> +{
> +       return test_zswap_writeback(root, true);
> +}
> +
> +static int test_zswap_writeback_disabled(const char *root)
> +{
> +       return test_zswap_writeback(root, false);
> +}
> +
>  /*
>   * When trying to store a memcg page in zswap, if the memcg hits its mem=
ory
>   * limit in zswap, writeback should affect only the zswapped pages of th=
at
> @@ -425,6 +551,8 @@ struct zswap_test {
>         T(test_zswap_usage),
>         T(test_swapin_nozswap),
>         T(test_zswapin),
> +       T(test_zswap_writeback_enabled),
> +       T(test_zswap_writeback_disabled),
>         T(test_no_kmem_bypass),
>         T(test_no_invasive_cgroup_shrink),
>  };
> --
> 2.43.0
>

