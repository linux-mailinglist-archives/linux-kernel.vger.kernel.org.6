Return-Path: <linux-kernel+bounces-194317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4F8D39FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927C01F216BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3922416EBF8;
	Wed, 29 May 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+LRrLzZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80115AD81;
	Wed, 29 May 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994449; cv=none; b=nDDNJSHQy6gBiHbzl8vDHED7asNjnbikkUW3sdfWWLa5B4w2TrWLRTJBQOaIIs2XQExg42I6IqmB+bzEmCd641J7Vjbs1ewSWkolnz+WD94WuvkjWfkRN41U4QO81ElyXZcDv0s1EvceYeeUzUGYbdoM5+Cg/CRjO/5Bcia8HXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994449; c=relaxed/simple;
	bh=TvHgr/DrdDcCPCSnvAc/V27VCtIz6wa6lVOKZF0vidY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJMMDWOXUUYPeErYjnt9zkWZ1HN/ziRC4d47YCWFNxJXJ2KH0QONBpwWpO21rn2gC9Ys8ifDjGwIOcmb/fCwIUilvk/vLPT+4EZ6IABkf3qPNAU1BbFH/TpZxFyg6QDMGDlVrWPeEF1LDzawcCHYofrckel7zoSY3YSUQxFtzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+LRrLzZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5785f7347cdso2410875a12.0;
        Wed, 29 May 2024 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716994446; x=1717599246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvHgr/DrdDcCPCSnvAc/V27VCtIz6wa6lVOKZF0vidY=;
        b=h+LRrLzZEJrOomPcVXg9l0iqNG4H8+27qyhh8BrRu0BrOyEcqGyVJlDi2a3PSUyaXj
         V1JKQQEWNVCsWskmBJn+2Vpe1LhvZTIp17o+elTWUtz8SVV997MyPasRaiWAF0WWAixG
         CopR2YAtLYKHWgzsjfIUJM8EEt96aQu6GjIzAbHSiQelJ+daCP40+n90ZDh3mbyHxbjS
         IDP25+kvuDURLol8AKvneh1gET7jvWsCNeWpeEwdL7oIFnqOiGZbfrWUmY3QqSRVopSe
         jggHUAKx1d8SIO5OtnTACfSd2uJ6jVJI4wIAZO0WSs1/VHyR3Jfu2fYMb3Ts7Yf3q2fC
         0DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994446; x=1717599246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvHgr/DrdDcCPCSnvAc/V27VCtIz6wa6lVOKZF0vidY=;
        b=QgFTR4vHQbkiG0BIhFoDXMk2AAChmd7RtGl7D7ImVNaoBh9+FCi48yTe1biH7PGVcE
         8yy+rbe81yyRtLkVxdXs/X/10zG09fMT9Azy3pdMGZDo3gkLV15jxSewXQZW2lo2B8Pl
         BfoB8knJa35o6pncjcAOOJ9jRRQZdKTFhh2QIaX8q0n1YomyRhtqfbRsyMETFdztc8Wb
         Lf+xgyI0hkjRebqGQEcXM2Fzegf4JxNl5Oc0o6B8B7rG0jegVQSM3M8fK87xV6VB9qhz
         e0yxMekzw6z5X310ecNniG7/faqGd7bRBZCKljwqZsPHKiVr2mlfvf4QmfJCMfVCb2W4
         KAOA==
X-Forwarded-Encrypted: i=1; AJvYcCXl5AtCd7tV9RYvSYeAAZWSiCg5sY4ha9HidQnKoCcY6TAxvB/6ShBc/7r4Q6vB7Isf5aPc8IBfHpU2x+OgSKv2xOHbIQTORPVKxHSdq5qKVMiTy7jcsEO9btKOPVYZFkDfft+qXVNBWrtqCMb4Ran8ew==
X-Gm-Message-State: AOJu0Yzcn4L1qTAWxpRpSuJvHeahTrcno74bTSRp5Ew5uZGQ+HdyKg48
	v9/zss+WjP5pTHUf1ka9Ya1veWcHB20WCt6jutI7Rcc05QwyuxQ0iezyGPpmOH4BDO5yxC4y7It
	3NfLOYchDnZBnJVL4Z/KnWGb8sIY=
X-Google-Smtp-Source: AGHT+IG+N3d7ulzwmqYhO0sKulSQcSl9Fx0Q6i9aP0a9Za9v1q/xJq/fupW6DkGQHbqvca9Cg47xTt/wUW/NMgOBCAQ=
X-Received: by 2002:a17:906:130f:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a6265114c4fmr957885266b.62.1716994446117; Wed, 29 May 2024
 07:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095009.1895618-1-arnd@kernel.org> <CAHp75VdRuK_sOF=25xP0azp8sOJ8DY_SRpLq9mUSaNEmWj5EAg@mail.gmail.com>
 <436667b5-308a-4a0b-b66e-230667ce0cc3@app.fastmail.com> <CAHp75VcVdwxv5Mm3GEv7SmsCiN3ZACpejNb7V_Ld1NBTxcXixQ@mail.gmail.com>
 <3fa493d3-51bb-48bf-b91f-57493be23937@app.fastmail.com>
In-Reply-To: <3fa493d3-51bb-48bf-b91f-57493be23937@app.fastmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 17:53:28 +0300
Message-ID: <CAHp75VfDPuQWGJO3GU2cG8a9Pq9BY8LL2xvGdyvKhmSa6_0EvA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: int3472: make common part a separate module
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 5:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, May 29, 2024, at 16:28, Andy Shevchenko wrote:
> > On Wed, May 29, 2024 at 5:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Wed, May 29, 2024, at 15:41, Andy Shevchenko wrote:
> >> > On Wed, May 29, 2024 at 12:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.=
org>
> > It's different from the exported namespace.
> > The function prefixes are needed due to C language, as we can't have
> > two functions named the same. The export OTOH is what used for linking
> > modules and if there is no need to have it exported globally, if, for
> > example, compiling in this one.
> >
> > So, can we move to the exported namespace at the same time?
>
> Maybe you can come up with a patch then?

Yes, why not.

> I have no idea
> which namespace to use here, seeing that there are already
> six differnet namespaces in use in drivers/platform/x86/intel/
> but none of them seem to be a good fit for this one.
>
> Are you asking to just define another namespace here?

Yes.

> How would I define what the rules about using this namespace
> are, and where are they documented?

Currently we use a common sense, like a pattern:
SUBSYSTEM_DRIVER
or so.

In this case INTEL_INT3472 is good enough as it's unique enough to not
collide with anything else in Intel's world (okay, I hope that we
learnt our mistakes in the past and won't issue same ACPI ID for
different devices).

--=20
With Best Regards,
Andy Shevchenko

