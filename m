Return-Path: <linux-kernel+bounces-174198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93878C0B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609FB1F239EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B251292EC;
	Thu,  9 May 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AQoBiwqc"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1667C0AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236400; cv=none; b=k9pXPrT6pX8g3+BAWXoKwZUmEu5Zn/n2DH/Vq+ejswQzw85l2KOUtnZKYyilhdn0m6Tgf1+huhHRU1cz9KTGzQf42x+hZiz+iJDtotIbZJ0gO2FVf6yJtWRTwHSzRLbefmJsvgWl31vRf3tZL3aM0dLosKBtQcq2Mo6vLwwWm+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236400; c=relaxed/simple;
	bh=75+ImKASz1UhDeA4yZ+UbdBwXjiMUGdmQ08tKlLy+A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfraRSPccv9HK94/Cgf4kMvp2np7aa5u5BuyMCjPWwQuzT/CMndQ91WQM+Y/0hQlmZFyZCUD/wQiCRxHcIu7YwRZHm8aKTLTI9wosTStIx2JUeW5TsMe79HbS8INM1ozPQlBryxJziG1Ep8qQUH3EEvxX1t0DgGPx870RqIUBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AQoBiwqc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61b4cbb8834so5012217b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715236396; x=1715841196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmaABryygHKi61pe95KisDbKOMR4+gIFPU4VfIf1H/s=;
        b=AQoBiwqcvbMx0+nemDusNt6cFGef77+uDAWtJShfOuFzpZBIYm8Uf4gjWjCBrWKn4D
         08gv/tVJQeOGohMCDpcOf2txEcoaT2+WtDEib1m5IssyMbhRPRvz0/DQz8tkyz8tzwWF
         AqfUxPzNNO2LT03PvQHx4IssL2dRL1b2A7w2Lu4vMlsbk+bzOQx9sgdjPSG458sCsMcN
         9ZV/3cRF9D4wHkFCfx9udCxN/XS9PANbH99stbrFm/92K7zycmfAhVhxQxYHDlyO7v/W
         dlt81EhtdWWdgJB0C8gegvegUZ4BpgsPQ9RxySsJ9ZulO5H9wG4zCrs28MrZGYgK7UFA
         j4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715236396; x=1715841196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmaABryygHKi61pe95KisDbKOMR4+gIFPU4VfIf1H/s=;
        b=W9k4uajuV2i14L4WWOuSJI8ra7UGu9tXIz36XfirJ5Lgs81JsND84koLuRvVBrGZ/t
         HLbLscGVHDsU2urVj1qI4MamvoDJlPYVzkF180wRA/KQrhOwID0ME4cxa0XMf8VWtBye
         0mgaIAqaVwEuH5ab0UEGkA9OH5UhlxEWEgj7IX3bQvFr8/p6ZyVOtK6r3TL0AiH3RKX0
         pHaxATBLkln9/fAqg43b1O5ieCYM5YeukByCpx3I60hpmXk/VzEdpTcPYHaCe92+Ohev
         5ksb7HMNOncFdkuY/zEfHlw5RqL4Ih9yNRkDxm3JA3P7QRDdjlNOmhuyn435qtPFBIbC
         Nagw==
X-Forwarded-Encrypted: i=1; AJvYcCX8HHs+b5VdFAl+RvaY4LGHQf9aaFOwnVkSgbvknNMCsxm6CJ0CQi/PDj3Fr1Hu9bAk7hQi8cyQNSJzA1aYFkXH/mbd4NG3MrrxxqV/
X-Gm-Message-State: AOJu0Yw6FFD8oOuFODs9tflFxZs6RQAh+ql84Zi4nSqka45ispKaC1Ih
	rASqtz8YFJ1rtSgwJJv9Iho2CSts67/9tV3cJ6v6wHUHShNUQQ2rJfCdSOsTH48w3OPVoH4PS2a
	p96RTL8YpT4tOq1+4Pojs+KffIQPlbpTh1K+ofg==
X-Google-Smtp-Source: AGHT+IEXJTVJqWuGMj45szsPBdEDa0ZZRrVrBfnBKFJJ+YWMRi72V45R4q79h8iLNNrsewGt1/l+6+fFu6D0Mt1TJUE=
X-Received: by 2002:a81:49c2:0:b0:615:1294:d6b6 with SMTP id
 00721157ae682-620861f37dbmr51700667b3.9.1715236396090; Wed, 08 May 2024
 23:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <ZjxMfQOqc8ML8nrD@sunil-laptop>
In-Reply-To: <ZjxMfQOqc8ML8nrD@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 9 May 2024 14:33:04 +0800
Message-ID: <CAEEQ3wkTR7BcnOn_iMzmj2_NejeaY=RymoUyu27A8TrXdHtQ9A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Thu, May 9, 2024 at 12:09=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
> > Before cacheinfo can be built correctly, we need to initialize level
> > and type. Since RSIC-V currently does not have a register group that
>
> NIT: Typo RISC-V
Okay, I'll update it in v5.

>
> > describes cache-related attributes like ARM64, we cannot obtain them
> > directly, so now we obtain cache leaves from the ACPI PPTT table
> > (acpi_get_cache_info()) and set the cache type through split_levels.
> >
> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..e47a1e6bd3fe 100644
> > --- a/arch/riscv/kernel/cacheinfo.c
> > +++ b/arch/riscv/kernel/cacheinfo.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/of.h>
> >  #include <asm/cacheinfo.h>
> > +#include <linux/acpi.h>
> >
> Can this be added in the order? Like, include acpi.h prior to cpu.h?
Okay, I'll update it in v5.

>
> >  static struct riscv_cacheinfo_ops *rv_cache_ops;
> >
> > @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
> >       struct device_node *prev =3D NULL;
> >       int levels =3D 1, level =3D 1;
> >
> > +     if (!acpi_disabled) {
> > +             int ret, fw_levels, split_levels;
> > +
> > +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_level=
s);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             BUG_ON((split_levels > fw_levels) ||
> > +                    (split_levels + fw_levels > this_cpu_ci->num_leave=
s));
> > +
> > +             for (; level <=3D this_cpu_ci->num_levels; level++) {
> > +                     if (level <=3D split_levels) {
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_DATA=
, level);
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_INST=
, level);
> > +                     } else {
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_UNIF=
IED, level);
> > +                     }
> > +             }
> > +             return 0;
> > +     }
> > +
> Other than above nits, it looks good to me. Thanks for the patch!
>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>


Thanks,
Yunhui

