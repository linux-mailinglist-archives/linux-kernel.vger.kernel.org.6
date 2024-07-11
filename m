Return-Path: <linux-kernel+bounces-249817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9FD92F04A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9AC1C218ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A310919EEAA;
	Thu, 11 Jul 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXR2XMah"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164116D4CA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729596; cv=none; b=Tb1MIzsV5Pzo/82xjlBM3aOZ5rhLo9Zbg2CgwzqfFwnx5kMv5If9RPVDduwIvrpYvse4UaLmLCXhio+dXHaGI9TxwMd8IWHMGSRFwEemnDOweAkpJ/M6L7sPGPBu0UiVnFmhpxN3uMcHKoQhfn4HAbXossY07jWKa5KI2jBD8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729596; c=relaxed/simple;
	bh=vIMFT0yarMRkobJBPNMU56AZLR4/xYQh7WhaZMq0I7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bkb+ijVhF/7269Sdjn+fnONLqgPWx6/d2bsWrqeXJEFKaxQ4SysZpLed1rlAI9dxAXwzhSnT4U79/Imc+nxz1qgLxhVbOvT9UfLNv3I3kHOu+Vyw2Uh4cNxMMBUOuyJUoENkS/CAZziK+dw5Tz3RRAXXt03kn00aNjf6kdyGLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXR2XMah; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64f4c11d2c9so11835467b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720729593; x=1721334393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx7PSCfcdgExZAoC0olVJGtD/kL+jmX7st457iM451Q=;
        b=yXR2XMahix2K5hNUaYW5TSKSbmzWydFQcOQ5NSk3mxvbd8Ktq6vJKMY0q/dMjcxzk8
         8epuS0NWnqAdYPGZAS9HoDpKXvd+Z4LqMlb3KAXyRbX25u82/D7m1+eGEw5rWW22gV8C
         E6b76xYUxp2PyrHB6whLZfqsaNg4ND6grIJRkVK4mxOZ4jqc+sq6wcJgq5cMsrbCmX8D
         JxTGm3GZMHZh18wDYQ92bZaNvV/7YloAO/srg5eVCwEACnF47BBeC//waxiRgYaT0ELP
         HehhEvk+CbBirJdX+0nxBqiuwjZaolEMcibAvRAzK1KsGyZeijujA+BsZnpU6WmH6+9P
         7sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720729593; x=1721334393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nx7PSCfcdgExZAoC0olVJGtD/kL+jmX7st457iM451Q=;
        b=wcZx7wdsoXgBktQ04lmQJWwELviZOB48trMJ2l8NHX/WCkcFEIDC2VqQFA3ZV7AtB1
         NOe8VswzdBFwOffUVWi52Zww/d7mSc8aFoWEg3iexn67SIhIBL6Y7wXyWQ6Jc04keYbN
         dJvbcmi/2EJPppCenJZ2rGVo0khaAquxSCxZQF1fFvcumWXpu4Cpgmq+2rOm9fv9uJoS
         PqOpLE00e2MjSX8f3PPy0cCJAAjyKEgbaGSEjN3r3zDKtHyotOhGven0q20Mg7YUCj+m
         EkGf55E78c8iztAK+8uobrf5TlCMIURuH8T5YqkbVHIi5I8iLGycd0VQ7OCiJ0FXiMMy
         rDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHFLGfmgEu9ahQbblqt8whzgZI8zp75LN4oN2nQ3zOnlmkticcM4FO5SnNFMmF+kWxvmdsJyQJQy1naDNjh1rG4dh/ARXucL0WWFkp
X-Gm-Message-State: AOJu0YxwAduw/OPvWUO1OcUMDiYuTrdxYUoNzF8/P/LDJpxwXzzTZAek
	SpI3k1XyCi6Bakewsnx/bq4I93hWlv1neCFRHHSClvuy5gOVBhsNLmqA/kHkp/w7S3eLFB+4rEI
	Y8EZbuXF3ljyBD+q4Dm+YH0CTgCRzWRUplOuG
X-Google-Smtp-Source: AGHT+IE99TQ5xDaen9zNOYXY/2DA6vGL27fQnp/41FtPaaLWf4T2dFDF00RLPSBtIMXy0RmNoRyMQE9tkQklAidH6es=
X-Received: by 2002:a0d:e616:0:b0:643:c2bf:c156 with SMTP id
 00721157ae682-658eed628fbmr93052517b3.19.1720729593033; Thu, 11 Jul 2024
 13:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407090645.ruIapj8y-lkp@intel.com>
In-Reply-To: <202407090645.ruIapj8y-lkp@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 13:26:19 -0700
Message-ID: <CAJuCfpHTQh455hKMbRpR3Z71P5J7fucr2Ba+bTA4HyWKzpj7-w@mail.gmail.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 alloc_tag_save+0x24 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:13=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   256abd8e550ce977b728be79a74e1729438b4948
> commit: b951aaff503502a7fe066eeed2744ba8a6413c89 mm: enable page allocati=
on tagging
> date:   2 months ago
> config: xtensa-randconfig-r132-20240707 (https://download.01.org/0day-ci/=
archive/20240709/202407090645.ruIapj8y-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240709/202407090645=
.ruIapj8y-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407090645.ruIapj8y-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> >> WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_sa=
ve+0x24 (section: .text.unlikely) -> initcall_level_names (section: .init.d=
ata)

This looks the same as
https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp@intel.com/
and both should be fixed by
https://lore.kernel.org/all/20240703221520.4108464-1-surenb@google.com/
which I believe is in mm-hotfixes-stable branch:
https://lore.kernel.org/all/20240709224150.B4711C3277B@smtp.kernel.org/

> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_cle=
ar_tail+0x5c (section: .text.unlikely) -> __setup_str_initcall_blacklist (s=
ection: .init.rodata)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

