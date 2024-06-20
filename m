Return-Path: <linux-kernel+bounces-223505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1D3911430
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10745285C22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DB80BF3;
	Thu, 20 Jun 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2teeYkrw"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8224C7FBB6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918031; cv=none; b=fpUyLfU9rq66n2CXkSojDCKT9vTkVL978VeG776GCfLnb51ZKjA4pdLcc+cGw1hG8i8phyzAq8fmAGutRRF2JRjg/VMyh0wnfHtqz3Skaha5Ve8MpgUSIN7GeiMUGO+6EaZ6jlac3Ha8z7e4rqDZa75YBs19SheXDMmqOGOIeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918031; c=relaxed/simple;
	bh=/XhhmhhowDYXjOJixYSeA/pTMAKP6y9kWx5xd+g6HSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWK8Ycmd/9L1Qkhr512NMPiiAx7DoeISOexj/WUYgREyBXFFmG7Tc0nJrR07tJiDBLbQzxdkOE/+VAp+2CoXGbUmQXvNu7n7uilDOg5R6+PRO+g2sLCJqTjFeiJ0MMidM0vInGulTu2VINYFkOZ1isrrOyySOejKYey+PFhPHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2teeYkrw; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc25a7b9fso1377e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718918028; x=1719522828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J5efzHbrBSBEUK5Mw1SAdOtVm61ZWMUI1FF8AD69eY=;
        b=2teeYkrwq4d7hQgYPLM8sQgVwStRk2Wbxca3QqACfhyCeSet4np7WykAlsovLTxTgP
         gevqBPywOzZ9agMGpTlAGbn6elyE5FZ0Z4fVwnCbr4vTlk5QUYiGUyR1X20N5/3uBV1X
         HCIJzLVOXhaSboWSDvnCLaSr/B2U32TevWL2sPwp12KADsqdD013l6rDOd5GWC7ZJCyA
         lYcxUxxyopA7/CGd39IdHCJ9RkOhsLoKUVItTi9ROpp/x5/aE6QVVEnIe3/Gvvj1MeQZ
         d6bd+bWrR+CVVUIgH5OlXkMzWKWQN/Lu7Dy6DSAJftpxzfaeJ1URnU3NeDjWMl+uBr8q
         XCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918028; x=1719522828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J5efzHbrBSBEUK5Mw1SAdOtVm61ZWMUI1FF8AD69eY=;
        b=SvvesDBuvE8kICWNpEAFgNwOTjifuThpmIaD75a2Jwq7GIONycY7oqPimPGVYwrs0l
         iJf5h9RRBccDuZh1+sasMuB6FGq7Zgf7Fj2M3b8GBtZIzr2sghI3M6bCICqthiXuskxv
         1uuoNg5ERm9LR0/Z8fBDGedX2IMGe0guT1qqTGPs4Riape+DoVoo7igaEX0a+2miNOie
         +qFnZzPflvCWdiFnhJQzS56EgLijYi8oR4XccqtArJDSC+uxAf5jAQQP5dth/5yfuv2s
         wybtq5XEWBiMeCFMvAFRqBeTWFr2VnlVVdXSmcH+FeoJar0ZEcK3OEfO00U7bMY6V3IY
         ma6A==
X-Forwarded-Encrypted: i=1; AJvYcCUCOF0RRDLNFcPiPxYjMX4frD7qOG3PzlTIzIFxFy7bjYieyZqY5hbaF8hJo/qFUWxQePPNP23r7t8iwm7oNvMAe+/c/j1UotoHvOP+
X-Gm-Message-State: AOJu0YwztshimIEWG7YXbpMYNT0ARbQ1DyVDZZ7BB2ttxDk8gfXwKJ/r
	V7YK3bkIu2x6Y20+kASuljjJJXT5vaxN2mHKZhbJTeBE/4tRIBI2byaMAoPaQScWip4lI6oGyI9
	cZASRcoPK56G98+gAzmZT3Ju4sFrAnaQq2y8o
X-Google-Smtp-Source: AGHT+IEn8AqNmJKcntBraToyOLUgVbU+xEWQhtkU0QjCiHRU8X5rQAoXIzT/mO+rjYRWXps3yrWu2Ehhip3ibGm/BdE=
X-Received: by 2002:a05:6512:acc:b0:52c:cbdf:f9ed with SMTP id
 2adb3069b0e04-52cd46a7379mr147587e87.0.1718918027535; Thu, 20 Jun 2024
 14:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619202511.it.861-kees@kernel.org>
In-Reply-To: <20240619202511.it.861-kees@kernel.org>
From: Rae Moar <rmoar@google.com>
Date: Thu, 20 Jun 2024 17:13:35 -0400
Message-ID: <CA+GJov5ZpFxKxK44SAb_B8SzWUF9uQV13A8BcVPijo0CV0mStg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, kernel test robot <lkp@intel.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
> this test there.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@i=
ntel.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Hello!

This looks good to me. And seems to fix the problem. Thanks for the fix!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
> Resending as v2 with Shuah in To:
> ---
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  lib/kunit/user_alloc.c | 4 ++++
>  lib/usercopy_kunit.c   | 5 +++++
>  mm/util.c              | 2 ++
>  3 files changed, 11 insertions(+)
>
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index 76d3d1345ed7..ae935df09a5e 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -30,6 +30,10 @@ static int kunit_attach_mm(void)
>         if (current->mm)
>                 return 0;
>
> +       /* arch_pick_mmap_layout() is only sane with MMU systems. */
> +       if (!IS_ENABLED(CONFIG_MMU))
> +               return -EINVAL;
> +
>         mm =3D mm_alloc();
>         if (!mm)
>                 return -ENOMEM;
> diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
> index 45f1e558c464..e819561a540d 100644
> --- a/lib/usercopy_kunit.c
> +++ b/lib/usercopy_kunit.c
> @@ -290,6 +290,11 @@ static int usercopy_test_init(struct kunit *test)
>         struct usercopy_test_priv *priv;
>         unsigned long user_addr;
>
> +       if (!IS_ENABLED(CONFIG_MMU)) {
> +               kunit_skip(test, "Userspace allocation testing not availa=
ble on non-MMU systems");
> +               return 0;
> +       }
> +
>         priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
>         test->priv =3D priv;
> diff --git a/mm/util.c b/mm/util.c
> index df37c47d9374..e70e8e439258 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -484,7 +484,9 @@ void arch_pick_mmap_layout(struct mm_struct *mm, stru=
ct rlimit *rlim_stack)
>         clear_bit(MMF_TOPDOWN, &mm->flags);
>  }
>  #endif
> +#ifdef CONFIG_MMU
>  EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
> +#endif
>
>  /**
>   * __account_locked_vm - account locked pages to an mm's locked_vm
> --
> 2.34.1
>

