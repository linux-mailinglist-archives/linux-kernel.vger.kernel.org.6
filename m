Return-Path: <linux-kernel+bounces-511668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF550A32E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2071886F05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9925D53C;
	Wed, 12 Feb 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0rHNUaU"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73025B694
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383209; cv=none; b=WebARcoTYfII48IqbV6mOXNvD+gx3z8ozStPhYIpshYUUiD5VZ6pzLo9XjlvSKZ2sOy3nimqISlEOGjfLW7QmS6jg9xpl2mIHVOOqhJ34+55d8Fpp3BacyLmrvYAKNcd8sTPzq6OxGSMUhIcMBF4uZSOjeGWAD3jX7ZyMB10yYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383209; c=relaxed/simple;
	bh=nuBKaKKm6JzdYDuLhSMKTDpSPaXhX6oO85o3tYs4RLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF9XiL9yUyvw5pfqVd1AEFzD7XElabpV5QbAWUYpN6S5g6z2BJyHlLUUHhVfqIyVgoXEuQBBwBxvlYQn24cbZea/JjyGAE0NUQbWvH/Fm0WaYY1vXGk2pw0XzgFSh7PNiOHm7LQn38GMXtgDLQb9UdP3iEJATivI+EGVcm3mUN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0rHNUaU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4718e224eb1so223251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739383206; x=1739988006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnxLzYWtl4fTdxDjuL6cUFX+003YtIZX0UUuj6CKe0s=;
        b=S0rHNUaUSrjn4sfVoZsYOpeEQpMbJ9tIPxEEf2w6BY7Ag9VW/CUQhooV5hnHqum6Ve
         Ar+Dk44JMndEe+s64ifAsEhPoliZFJn1dODeCTmhDYXyndESJ3UswKIyo6/M8yrxWeTl
         12AE5J0N5THwk1hcb75W9yi0ti+y+ZyIwRD2MzY/qqQFeLwpFuVIr1Naraq83yTRp4xJ
         75fKkIaWs/YD8lzSPtQj6aw+QVqCRKQxKmEoVEVDatFoxYdzKyNPCtPr7sWhefkgLJr6
         EVfwo7orO2ccDPihj7i62t0sScpfeudvZLWQDiKZ5vS/NpSAE13WKFjk5ON92BtYL1Vt
         t+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383206; x=1739988006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnxLzYWtl4fTdxDjuL6cUFX+003YtIZX0UUuj6CKe0s=;
        b=J8fC2FkZpQQMtbM5A7bMk5AAb9LcRjY0TvghUOvKKPoeXeZFsOQfIff/XoFGjscq/5
         mM1vShq4QlM5B77c/a6V872I778aZtgWLxxOMFcWyYRt7MchQYgoqub+AO2IRkRiCDif
         heg9famLfjaF/a/A38twqRxYTxpSan4AyQFP7XODBTzy7lOPKapYDLpjh/YBEj2D6nOF
         0SRnjBEAh0ZIelbuukIsI0gT7qgeJr9VSqk3IwuTXNjQWWpigg4pMHdmdpAumB6ocE5D
         cIOl9c2B6ZgJYdTZJqmGfvVfc7MzACer9PD3Ng1wTPeGezxkZ9Za3ktk1iCTYmkufUsm
         UAGw==
X-Forwarded-Encrypted: i=1; AJvYcCW4U947Q2KezcBc8dHiURZc6CZdVPHLD5tLMTZEg2cvpa+OcQonL9ofOi/BdMQB/yGQNSs5aSSERuZqpI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WeRUnJRxnMvEdyhFfWVwCWhbOw8Hdyw5Q1wZeMCWiYlvPHfu
	EtmZ8UK2kRZloSfA/OFlORzlsWyxhYluBQM9XvUkvtITIMPuAXUpW+O4pp6Ol7mYgVDIS/33Fqn
	CTzohUOxAUwwmmxMHCuERIGOUmE+WPCl8v9sO
X-Gm-Gg: ASbGncvggBL0Y1/Z6kHq0djCCViGGmkKvvEYSejvkuizYcl12bIPloocxjMjLpds+gm
	ksW1jUBVvktLiSJkDBP0vJkJzzpDt3XNGOHH1mB4LkJczqo3Y9xc28Q3hJPurPz+qkLRc8A==
X-Google-Smtp-Source: AGHT+IGSw4YKDtfh08bcjWht1M4/uuus9yui3/j9nrKRuQDs5q9mLrKwVQaTI4vhzkToVQHIrnyJG34qHvC4LRsr3hw=
X-Received: by 2002:a05:622a:1b8c:b0:46c:9f17:12f6 with SMTP id
 d75a77b69052e-471b1e5afe4mr3975661cf.27.1739383206304; Wed, 12 Feb 2025
 10:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1aa70a33-2acd-49fb-8049-a20dae40ecba@stanley.mountain>
In-Reply-To: <1aa70a33-2acd-49fb-8049-a20dae40ecba@stanley.mountain>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 12 Feb 2025 09:59:54 -0800
X-Gm-Features: AWEUYZkACIoh4E5LCzP8OVY51LXm0pOowyPRO2n9q1lglrxQw_WVHe-hypVPcjI
Message-ID: <CAPTztWahPK5MLTxMnGH8woe1emM=QA=3pjy1ZCBBG+D39aLGog@mail.gmail.com>
Subject: Re: [PATCH next] x86/mm: Fix uninitialized variable in register_page_bootmem_memmap()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:21=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Smatch complains that "next" could be uninitialized.  The "next"
> assignment was accidentally left out when we moved these lines to earlier
> in the function.
>
> Fixes: bdadaec1526d ("x86/mm: make register_page_bootmem_memmap handle PT=
E mappings")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This goes through the -mm tree.
>
>  arch/x86/mm/init_64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index e7572af639a4..6e8e4ef5312a 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1600,8 +1600,10 @@ void register_page_bootmem_memmap(unsigned long se=
ction_nr,
>                 get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_=
INFO);
>
>                 pmd =3D pmd_offset(pud, addr);
> -               if (pmd_none(*pmd))
> +               if (pmd_none(*pmd)) {
> +                       next =3D (addr + PAGE_SIZE) & PAGE_MASK;
>                         continue;
> +               }
>
>                 if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
>                         next =3D (addr + PAGE_SIZE) & PAGE_MASK;
> --
> 2.47.2
>

Thanks for catching that Dan. I believe Andrew took the series out of
mm-unstable because of some conflicts, and asked me to do a v4 for
mm-unstable. Would you mind if I just folded your change in to the v4
series?

As an aside, it seems that this function could use some cleanup. It
seems wrong to only advance by PAGE_SIZE when you encounter an
unpopulated p4d/pgd/pud/pmd. It should advance to the end of that
p4d/pgd/pud/pmd. I suppose that case won't happen in practice, though,
which is also why this hasn't caused me any issues.

- Frank

