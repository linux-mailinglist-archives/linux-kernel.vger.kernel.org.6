Return-Path: <linux-kernel+bounces-360758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6457999F24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E641C20F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5420C484;
	Fri, 11 Oct 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3oZH89P"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C020B21C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635786; cv=none; b=agxVcGlfOafxHui7/3qTOhKl+i6Q9jn/Ao9+luETDwh3DqtJjd2GfFFq/ySKl3Am6rqDzNUZiGKrLPzhBL5UMbBr3hlCbREiqPfzETAVvj8GO0lW2yUQNm6lUxVdh24gj67XqF3sIJxunE41iY5ZX2MdX3PZV08yb1R5knmnNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635786; c=relaxed/simple;
	bh=i2cIQ3EZZr55dWf5gDnPNsTXjTx5MNUUMC3a+W0g/SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7cT+posP2R1up5BN8shDBUrkSN5XdbMql1Xw7zejFThE5hCniP95cYNCt+lBa6IPxLGGSGyIuXLiFMMJNf+5fxq1nD0D6bor/6h9eD0d2O9couySjVkd3OoKP2sobA+iOKbBKZ2ePYx0sorzfGPP7xkz5QFDNr8sgXAik9Mr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3oZH89P; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2facf48157dso19757701fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728635783; x=1729240583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HeWIw2EIIrUhovMyS0WmAAf1++JCdkJVYyCxNs9AfLs=;
        b=k3oZH89PZxuwquDoJ7Nzv/1cXj+B2Lb87oVtF/dUV7krHZP98GdBgrY7YjY6ax9mCk
         1OGFVddUswBZecDEjFFUnvhCqtRWpILR0yav7IVD133BHBjGtma1WOA8owV0iIbK/JvD
         JdLD4fafdcjjgOPExNBOURTIklY5B9n5C6YwtGr69kLbqo9CVUO5VLkRpcef0VpPtMF8
         fhADhYdJuyKP9gs6P1pg2NeIjEHyD6C98HZlLrJ9HYIZOkH2Es68P54p6UGdl85eamnm
         q2dQvnZBHR8Z6GhzXFjFRRQC9ffafyajs0EvCTOL2UzWpRc+Y5f97ulbs4wkz8fV+JIn
         O0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635783; x=1729240583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeWIw2EIIrUhovMyS0WmAAf1++JCdkJVYyCxNs9AfLs=;
        b=xLOYFELWkYkl+qKhrysRm07leeglGbN3A5PWHGXPobobXcyffkvYQ1n+EIQobRRxSy
         xsw33mQtseOS3hWE430wYhcUFBpAW+4EVi4Pk8w8bnL23M44ygHIl4Em+uOplF3VZMxz
         e4eQNRC/VbzVrrUT+OWW+AQHrGg6i+VH0x0qVpd2bHubVu4GbUznELZPdYisAUg2K5WM
         UU6fARPAlzew5I5174S33ONP3GxrDe3TfzbxeTULsUf5IJH4M+d3jksnHTYea4jvBYlx
         NNX+oxRhPSxKHzUXpFIVnXm1emtC0aKd8+lw4teu0/Q4P2OD3mqF/HXs4I/8NFfCud7x
         iCQg==
X-Forwarded-Encrypted: i=1; AJvYcCWDebkB/siy07OzAwZ6+GbcwWZPhLYeaB3n+27ArRp3AG5W/Rxvv/x3e1Z+XlYP30qMTMhtesp/rSyL8Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYswAx8gJtg/XsZ6ANR1HbfPwrPwx46sgkA+sQBCkTPXihCRy
	ypnIH03sCKykVtBO0CZHmN2yVgkx/hKrjvcCfC+WituxzlV9P9J32ouekR77kSllIEJfnMjc8sJ
	n/jHvwJyDmpMj4vgYEs2Xzhr5DrtD2ljR6IDzFTl/Gqgdis/W+w==
X-Google-Smtp-Source: AGHT+IH2Hj89emNR41QbNSWbJD3uU195PXC2mXbSa25TOE0GUSjbVErEYQUJrf8fvyf8aBpNGmolZ7XkKdfmEmNV0QM=
X-Received: by 2002:a2e:be84:0:b0:2fb:2e27:5324 with SMTP id
 38308e7fff4ca-2fb326ff3admr9890051fa.4.1728635782731; Fri, 11 Oct 2024
 01:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011033604.266084-1-niharchaithanya@gmail.com>
In-Reply-To: <20241011033604.266084-1-niharchaithanya@gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 11 Oct 2024 10:36:07 +0200
Message-ID: <CACT4Y+ZVq76St5hTTNYtpU_EZGNf2g0iPf82DzzW9-SByh=t2w@mail.gmail.com>
Subject: Re: [PATCH] mm:kasan: fix sparse warnings: Should it be static?
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 05:40, Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> The kernel test robot had found sparse warnings: Should it be static,
> for the variables kasan_ptr_result and kasan_int_result. These were
> declared globally and three functions in kasan_test_c.c use them currently.
> Add them to be declared within these functions and remove the global
> versions of these.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@intel.com/
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> ---
>  mm/kasan/kasan_test_c.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..d0d3a9eea80b 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -41,13 +41,6 @@ static struct {
>         bool async_fault;
>  } test_status;
>
> -/*
> - * Some tests use these global variables to store return values from function
> - * calls that could otherwise be eliminated by the compiler as dead code.

Doesn't this change break what's described in this comment?
Since we are assigning to a local var, I assume the compiler can
remove these assignments.

> - */
> -void *kasan_ptr_result;
> -int kasan_int_result;
> -
>  /* Probe for console output: obtains test_status lines of interest. */
>  static void probe_console(void *ignore, const char *buf, size_t len)
>  {
> @@ -1488,6 +1481,7 @@ static void kasan_memchr(struct kunit *test)
>  {
>         char *ptr;
>         size_t size = 24;
> +       void *kasan_ptr_result;
>
>         /*
>          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> @@ -1514,6 +1508,7 @@ static void kasan_memcmp(struct kunit *test)
>         char *ptr;
>         size_t size = 24;
>         int arr[9];
> +       int kasan_int_result;
>
>         /*
>          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> @@ -1539,6 +1534,8 @@ static void kasan_strings(struct kunit *test)
>  {
>         char *ptr;
>         size_t size = 24;
> +       void *kasan_ptr_result;
> +       int kasan_int_result;
>
>         /*
>          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> @@ -1585,6 +1582,8 @@ static void kasan_bitops_modify(struct kunit *test, int nr, void *addr)
>
>  static void kasan_bitops_test_and_modify(struct kunit *test, int nr, void *addr)
>  {
> +       int kasan_int_result;
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit(nr, addr));
>         KUNIT_EXPECT_KASAN_FAIL(test, __test_and_set_bit(nr, addr));
>         KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, addr));
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20241011033604.266084-1-niharchaithanya%40gmail.com.

