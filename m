Return-Path: <linux-kernel+bounces-171980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F98BEB7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D307FB214EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9616D320;
	Tue,  7 May 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boZTvIUc"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A2165FCF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106572; cv=none; b=erLlaJtX7GsBskBnY7tPXY7sCoQtOcA5ynlFq7C/BVhlNjqA0/yqGviWnyFXNV6hSIAHcX/uoN5EtGc6y2B9Wm9mH/oqylML9xMGDaZZYlzzL7cEXgQl+OWJAArfk6t4F6VcMPCglPCn3MiGh17LYp1wfzHVrPwllfdb/navzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106572; c=relaxed/simple;
	bh=ww43JNfGUOpTjiI8XNbtvQOK0cNR+pvkNNxnQmcdZYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tik7ItvrkOy0GHYWINDxe1rWTqd5FVcCVyz9PUI6lE+HDlCGGCClbccerzgW95VDTdCw+HKXCg7+m+uGZcrg6RConXBIUS08frSz4OW1HFdN/vJhgDCkukvuCLJX0vZmlJ12SZR8widclSRrLpCbx0zhROAR8mvNuxU7MT77hp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boZTvIUc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ce1e8609so7140566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106568; x=1715711368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KpYXpCglzTufbnH+/rYxT4F7Xx3Oa7GqRK1wLmM3XQ=;
        b=boZTvIUcGYu7Jp+muuYkhLyQacxg6tspRbKaKiXa3XnlXe64C/bJExq+aLxKzuIESh
         rh4+p517kAB27PozwU/WqCfjGBlExR2eYB9qaBXM9ojZ938mvMdbhvx/Rg1wlMXmp8bi
         Ogt2TwFB6nvryZXQ5Zw0VSZDMpqhe/Vj9vEEa2GrLDLXH1BL7TukdJNlF5RL1tTH/YKS
         EsHWS4dxq6CPWYGwdEzgGOJ0WUumwlDPl7O/7w1OI9/VU3F/AlS4ejdr+R9vTTgT9Q4R
         Yi+D+2i3BgBXMLGrwsGZsMDYOvTHxtTQezkqjpo1DGnrO/MhmrWIpceUceoN3QbcvRmU
         F5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106568; x=1715711368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KpYXpCglzTufbnH+/rYxT4F7Xx3Oa7GqRK1wLmM3XQ=;
        b=bDGUcWXEMmULdVa5OD4A52YKhiYDKE0I+kbgJ2ceSd2WtDxpBWOz2BUJZ7l4s3tqu6
         kmFFDejWTBGqglb/o9wWGlqXbTSm+E5XTZENexZlSUVYhBdMNSKXy7bLP8wLYxH6lYfC
         5oHJ4MhMIhE59G/RrfA7Ln53udcXM/zP5wqkxVoVhbjkaJTNRXhrwCDeHJBblpkGuy2r
         w3DCkoHGoSKsRHTJE8/1i83tPYbfGxDtoYjWa4fD/UfaQ6ou328qKc+arExWxbPKEcGb
         XNJOCBD2PUY95EQG3JwGq4zhso51CnA2lAh1dZk2+/OgrO22BiyFd8tCIVOtejVyb/KL
         aDIw==
X-Forwarded-Encrypted: i=1; AJvYcCUu7zS3JA0yFAFsKfDFDmxkP0+hO8XIyAqxapmbX9+1+LA0aHQEgtxhQoBnhy/1KaE6rElnybhQ+f+aB8ou8ZzZtkLFhuYlUxTUW0m7
X-Gm-Message-State: AOJu0YyOFBMn+O20hjI8ewCXT7SNgUOE6dMiJ5qqUF4z56W7WdEosSdx
	0TREj4FGAVTkih7XQAbqNxtvr3V1GriKTyXlSkD+bx5qw7aaysGuA9yZ5Pizy8yhqOLdLW4TgPY
	9BwRBNk166hZ6RgU1XssEJs1dTyjFAqUWKmzB6+SLOFb6vaUKfk7DuTk=
X-Google-Smtp-Source: AGHT+IE/2+DpWpsBlHzgVAwCuytID1y2RxtmxqTs7MjvvpxserdIU1u/G1eF+XxXoYeoCkuqwtRnDQjAUSpYQGU9Poo=
X-Received: by 2002:a17:906:3396:b0:a59:b5a6:65c7 with SMTP id
 a640c23a62f3a-a59e4cbe31emr281228366b.3.1715106568237; Tue, 07 May 2024
 11:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507101443.720190-1-usamaarif642@gmail.com>
In-Reply-To: <20240507101443.720190-1-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 May 2024 11:28:49 -0700
Message-ID: <CAJD7tka_Q6v=Hxg4nV2r4UV5r9m-nuzmsZ_BQsQYoq0BdbiwBw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:14=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
> Initate writeback with the below steps and check using

s/Initate/Initiate

> memory.stat.zswpwb if zswap writeback occurred:
> 1. Allocate memory.
> 2. Reclaim memory equal to the amount that was allocated in step 1.
>    This will move it into zswap.
> 3. Save current zswap usage.
> 4. Move the memory allocated in step 1 back in from zswap.
> 5. Set zswap.max to half the amount that was recorded in step 3.
> 6. Attempt to reclaim memory equal to the amount that was allocated,
>    this will either trigger writeback if its enabled, or reclamation

s/its/it's

>    will fail if writeback is disabled as there isn't enough zswap
>    space.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
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
>  tools/testing/selftests/cgroup/test_zswap.c | 138 +++++++++++++++++++-
>  1 file changed, 137 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index f0e488ed90d8..805301554fa8 100644
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
> @@ -248,6 +248,140 @@ static int test_zswapin(const char *root)
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
> +      this will either trigger writeback if its enabled, or reclamation
> +      will fail if writeback is disabled as there isn't enough zswap spa=
ce.
> + */
> +static int attempt_writeback(const char *cgroup, void *arg)
> +{
> +       long pagesize =3D sysconf(_SC_PAGESIZE);
> +       char *test_group =3D arg;
> +       size_t memsize =3D MB(4);
> +       long zswap_usage;
> +       bool wb_enabled;
> +       int ret =3D -1;
> +       char memval;
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
> +       for (int i =3D 0; i < memsize; i +=3D pagesize) {
> +               memval =3D 1;
> +               for (int j =3D i; j < i + pagesize/2; j++) {
> +                       /* Overflow of memval is ok, will check with same=
 values later */
> +                       mem[j] =3D memval++;
> +               }
> +       }

It may be more readable if you fill a fixed page-sized buffer with the
pattern, then use memcpy() to fill the whole region with it. You can
also use memcmp() when validating the data below to compare each page
against it.

> +
> +       /* Try and reclaim allocated memory */
> +       if (cg_write(test_group, "memory.reclaim", "4M")) {

Should we use cg_write_numeric() and memsize here instead of the
hardcoded value?

> +               ksft_print_msg("Failed to reclaim all of the requested me=
mory\n");
> +               goto out;
> +       }
> +
> +       zswap_usage =3D cg_read_long(test_group, "memory.zswap.current");
> +
> +       /* zswpin */
> +       for (int i =3D 0; i < memsize; i +=3D pagesize) {
> +               memval =3D 1;
> +               for (int j =3D i; j < i + pagesize/2; j++) {
> +                       if (mem[j] !=3D memval++) {
> +                               ksft_print_msg("invalid memory\n");
> +                               goto out;
> +                       }
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
> +       if (!wb_enabled) {
> +               if (ret =3D=3D -EAGAIN)
> +                       ret =3D 0;
> +               else
> +                       ret =3D -1;
> +       }

nit: This can be more compact

if (!wb_enabled)
       ret =3D (ret =3D=3D -EAGAIN) ? 0 : -1;

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
> +               ksft_print_msg("failed to get zswpwb_before\n");

A negative value means that the read failed. A positive value means
that writeback occurred outside of our control. Let's use a generic
message here instead that zswpwb_before was $value instead of 0.

> +               goto out;
> +       }
> +
> +       if (cg_run(test_group, attempt_writeback, (void *) test_group))
> +               goto out;
> +
> +       /* Verify that zswap writeback occurred only if writeback was ena=
bled */
> +       zswpwb_after =3D get_cg_wb_count(test_group);
> +       if (wb && zswpwb_after <=3D zswpwb_before) {
> +               ksft_print_msg("zswpwb_after <=3D zswpwb_before\n");
> +               goto out;
> +       } else if (!wb && zswpwb_after) {
> +               ksft_print_msg("zswpwb_after !=3D zswpwb_before\n");
> +               goto out;
> +       }

I think we should split the check for a negative zswpwb_after, which
means that the read failed, from the check that the value makes sense
based on whether writeback is enabled or not. Also, we do not need two
separate checks here for the correctness of zswpwb_after. Perhaps
something like:

if (zswpwb_after < 0)
        goto out;

if (wb !=3D !!zswpwb_after) {
        ksft_print_msg("zswpwb_after is %ld while wb is %s",
zswpwb_after, wb ? "enabled" : "disabled");
       goto out;
}

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
> @@ -425,6 +559,8 @@ struct zswap_test {
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
>

