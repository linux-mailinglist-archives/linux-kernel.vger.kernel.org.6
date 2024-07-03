Return-Path: <linux-kernel+bounces-240288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523C926B61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7B51F21ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF332181D18;
	Wed,  3 Jul 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mIakU6/"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488313B59A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045063; cv=none; b=fd6FzUbeyHueBeqd+Vor4N0/abZOR23AWlTgUIY5nxfA6nJ1NuwfoKbKD0cRoJ6SLFt1JvM1gQF2vP4xr7dIgct3KWenQpEmqijWMhT8D/AS1ja0MhUKlV4Gx+QsmMw1+BQlox0qisUo3iNBWzMilGnud4QhF5XV01HJe5vtp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045063; c=relaxed/simple;
	bh=DaQtQUezy9Cd6dPj/vQJgAG0+5hzPIdQv4yBLL7Tw+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kz6H8N+rbzZibpFhbin7jgSIV+VCHLAEctMtx2Y13E5NnpXk50yP3D0hwQdyCFnfjBmKd1KzmIXBRL8WVOdv8nWZWtmk2j6aSGhyalYtECB4IqD4tC8WpBKkytw67IhmlU0BCEF+JDcwaM1Qr+zknLUDzy9ePu7m3mBvRuXbKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mIakU6/; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03a9f7c6a6so2046276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720045060; x=1720649860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBFY0AezQv8pUC4Zn75QewV+jmxCpy323lgmyp3n110=;
        b=4mIakU6/CkWDxyKFCzoHKk4fCgn90vZ/srgah71MWq8PxeaBr/9/uSALLM04qKDz7R
         kXkIYsb6n1ZQ/SGyBus4sPCmG8KhnQTSEuuD7bvZzdVY15JbRaAZlLoOaxP7BtKJ8YFv
         M8Au1nhgdJQtZJJV7G5usAFdyQA6xbvIBW3Txsmd9NGuI1sKWYAqBznHsMWLCALSqMqy
         2b47n20kJfmE3D0Qgn9+DvKtPbxDfcw2UTg2gGBPGfXDHtgtrMVNR0rDDfe2iUCbdjjK
         C8Tb++KOPjKka1RZtvRRPopTkf8LYo5vH74FsPmhsRNOZhOtw+gkAKgG4bGkAbxmxPB8
         OGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720045060; x=1720649860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBFY0AezQv8pUC4Zn75QewV+jmxCpy323lgmyp3n110=;
        b=kJR90NFQXE5Esc+DPwNlw5Rsslm6txn+mkx2eeXh1i1THw1G2FrK6NVLdA+25+oR1D
         fXEFmfUQlFhBXvAS8UEW0+jsFCFR4Lq2Jbgy8uFCLGeRSwEMsED8wjvIev35p/wMnAH1
         ornW/Exvy6VMZ7rmS/K+rCzY2UCopDIugfwS3d47aQiNiSW6XZY1tumtklPW53isz8rS
         ZCfs81P+BH4uDxd1gJvuPoxEbkGlv9+ZgxQa+ia7RjVoT4QIg3udnJHLK8QpvJpiCqv3
         de/glfVEx7voqUL3Nb4rOjbA8pW0QnE8C7NX9BDpd8VAbZNHR32n4h5sYsGXdX6XORK1
         LX5g==
X-Forwarded-Encrypted: i=1; AJvYcCUEd3ZRK2vyZo7FnJ/KCjIJzrj7EEMLTFln9+dXM/fkWk5KwSqwrYlbXzaZNruKIhTN+BGIoOHP73MiD1Rq3Mg8U5PdtVQS6B47P+TA
X-Gm-Message-State: AOJu0Ywbbc1aHlLa2TVBZbgI/m+lmTRKOwFfCWncH+9+kci5RMuLlSqx
	xWPfOonOvLkUEvu40BKgVYHUbv2gzxN2nVoOMbJJAIP1jkeeE+2ByvwKwyWt8Ee7SqF5VjqwYhU
	lp0i4/ODzJtafIba8Gc35aLsNanExk4NTtu4o
X-Google-Smtp-Source: AGHT+IF+YHjIjtyJP3TQiVa5IYtgSjacB1lIHVSnp746reC92x+NB1avh2v9/xG67hBD7Y6DlOQnEo7BO3UvXnbsAwM=
X-Received: by 2002:a05:690c:650f:b0:64a:3d6c:476d with SMTP id
 00721157ae682-64c71803990mr143734497b3.25.1720045060293; Wed, 03 Jul 2024
 15:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407032306.gi9nZsBi-lkp@intel.com>
In-Reply-To: <202407032306.gi9nZsBi-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 15:17:27 -0700
Message-ID: <CAJuCfpEtRLSiAmv_5+bo-oW_Lnx+=v=rasgVerdVJyoaFQ-R5w@mail.gmail.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 alloc_tag_restore+0x3c (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:42=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   e9d22f7a6655941fc8b2b942ed354ec780936b3e
> commit: b951aaff503502a7fe066eeed2744ba8a6413c89 mm: enable page allocati=
on tagging
> date:   10 weeks ago
> config: xtensa-randconfig-r051-20240703 (https://download.01.org/0day-ci/=
archive/20240703/202407032306.gi9nZsBi-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240703/202407032306.gi9nZsBi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> >> WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_re=
store+0x3c (section: .text.unlikely) -> initcall_level_names (section: .ini=
t.data)

Fix posted at: https://lore.kernel.org/all/20240703221520.4108464-1-surenb@=
google.com/

> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_cle=
ar_tail+0x44 (section: .text.unlikely) -> __setup_str_initcall_blacklist (s=
ection: .init.rodata)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

