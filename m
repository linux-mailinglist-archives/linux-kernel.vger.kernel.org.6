Return-Path: <linux-kernel+bounces-529628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A3A42904
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0EE17EAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C46266593;
	Mon, 24 Feb 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8Bk8Qp/"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D92264A72
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416443; cv=none; b=LVFjEx60tELp1hE1UKhOCmtg21Eh7trsPkcTWmNMsuBxyhBa/TivXNZKEDJHOLdBq3Pq8f3bft89Sc56gnnu+WVDYKxPuplinNpn5U+4z3SwOv1xWJ3jVYpv6HVEEUPoQOF/uR7dUz5QMLb4lo/Y4OA79+PS11tdWTmAK+JG/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416443; c=relaxed/simple;
	bh=bTOtbXAYGDMeeWId57hTH2KaX9ZYq4OA04dE5E7f3QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFIFNyEcIfIM990Nd/h1ytVIg33AeFw7601H5rD/uWU0k0gyTIcAd/kMMMQSputAWCdWSNMnRA9q5N5/Fb0NpMfTaGJ+4TLxwlqOB6dOJqV5WzikYFdhPVTalF8LpliOP+thQR1mVTCl4Xm8XOSQdqQkR5ukstpTpfVoL87+yeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8Bk8Qp/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471fbfe8b89so696551cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740416441; x=1741021241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCDPYfQc9hPFOiWzrMrQ09gp/CGBhAXiyMFfJAzvH6I=;
        b=W8Bk8Qp/+2wJULTNmx4OnSSPgvOwxPVn0cNshePJM1pOcQjf9lXZvCnBLE883NtjBG
         n01oXxrhO2TwAXUyBqqp8MvttoZwwc7rP9GMFT5tkpGgpzMW729XRKOrLcDc5t4bL6Xr
         D/J25KzdHLRws38Zrq8TnHfSXR1rH7lpc3F+CSK9nP2HdL8aeJDegel/lpYGk9nR74Qu
         HFPEWDdrWlg/FrmDltw6Y8N6D/rPCzQ/A3Iz3f4s8yCE6PAEESUDfpNtXYbSyqrkcL3o
         85d8Ny8i2WPxCnL2MRc/6WC45fcfjgoUd/GE+cfyF3i6LK5IsZ1LFCpyXQvV83wX7rRb
         0X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416441; x=1741021241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCDPYfQc9hPFOiWzrMrQ09gp/CGBhAXiyMFfJAzvH6I=;
        b=cjHl8xg0rjTZlMKxLeaXP3Phe7uy1qt4XLOx9TEpBOH5Do3+RXLikczlpZwuBSoGdY
         l9AB7PDDUWs7Dw/ASTebEnW7GBwZzNX5CquShlSr1CydTiw1o5fL9x6jHrh306flyMlU
         h0nXVwulPA0L7VaaILNzyK51FQmIoFZZi40iQSpjbnM0jEPcnrE+J+d6EyivN+3b463R
         eDzG8wbirk6xBZJ09ZvO+LtaWsu3SjTgMhwvEeHtgO5j4tUYRceYROr/qFOHMz1DamFk
         SHLMMoUZO0TgZOGJMWnt7pNN6DRsPxs6preHvik3jCKO1eejLoml1C946yrBmb2Qgt6W
         meGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPon0phgHP7gisjejx4CX1mDt02FinYj8FfsPGGUmy5zw11GqNjswvlIG0hgrnGodGuZA1LZw67DzpA2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUirKgJuSjPZ7jVz6P+0lkKtXJFs/h7jMXm85pwCFImqn544CU
	Rl7cWS2VYiKZQZpuO7EkYyG+vMtrX3tCZxj4UZH0pLGUy2kpLLfW7nNNGwxszFDMV0Pc9uP/L1K
	hYpSVy2Pz0q4aw82MFB0WoMOHwiWsi+4VCLt6
X-Gm-Gg: ASbGncv2FRdOxYVKOOIJTbY3/W1wi/aFQbukn4IsrxhP+/Y3Wj+M4qFP/4nldDKBsig
	ulBBn7lHYxGf5X7Haq5HqL5UFVqDr6Z4gE2WWjRQNPboz3tXKtIFNWJAWZDBLGVvw7qeIXL9/JH
	fjrEXV
X-Google-Smtp-Source: AGHT+IGDiL/NzinuvOUr3+fEdY5ydwqjWixBjK5chxqAB4cgY6b/E2u3NNO77Wm/fNagSnSSnlNVN6JFC7ja6T0wMdw=
X-Received: by 2002:ac8:5dce:0:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-4723358478emr7710481cf.26.1740416440442; Mon, 24 Feb 2025
 09:00:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224141120.1240534-1-arnd@kernel.org>
In-Reply-To: <20250224141120.1240534-1-arnd@kernel.org>
From: Frank van der Linden <fvdl@google.com>
Date: Mon, 24 Feb 2025 09:00:28 -0800
X-Gm-Features: AQ5f1Jp7zC3xCebv78f9PiKcuUbXObQC3P1hoiW3UFkiO3HxC8Bls2jmj40XTdI
Message-ID: <CAPTztWbLJ1iQ96okvTZX3JL2fkpHhOj=jPGULS2RriYg0T0eCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, cma: fix 32-bit warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:11=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about certain always-true conditions, like this one on 32-bit
> builds:
>
> mm/cma.c:420:13: error: result of comparison of constant 4294967296 with =
expression of type 'phys_addr_t' (aka 'unsigned int') is always true [-Werr=
or,-Wtautological-constant-out-of-range-compare]
>   420 |                 if (start < SZ_4G)
>       |                     ~~~~~ ^ ~~~~~
>
> Replace this one with an equivalent expression that does not cause a warn=
ing.
>
> Fixes: 4765deffa0f7 ("mm, cma: support multiple contiguous ranges, if req=
uested")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index 34a4df29af72..ef0206c0f16d 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -417,7 +417,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t t=
otal_size,
>          * Create a list of ranges above 4G, largest range first.
>          */
>         for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &start, &end, NULL=
) {
> -               if (start < SZ_4G)
> +               if (upper_32_bits(start) =3D=3D 0)
>                         continue;
>
>                 start =3D ALIGN(start, align);
> --
> 2.39.5
>

Thanks for fixing these nits in my patch series - which, btw, needs
more reviews, if anyone's reading this - please :)

Reviewed-by: Frank van der Linden <fvdl@google.com>

