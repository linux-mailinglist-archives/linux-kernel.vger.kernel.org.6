Return-Path: <linux-kernel+bounces-409008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E069C8650
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DD22841D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E901F7080;
	Thu, 14 Nov 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZS94gMd"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F051DF24B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577069; cv=none; b=Dp9srHdYcW5LpozIPhRpzG1hdjnGo+LEmCYqhfqVe3HH/a6QUnplixYzXOMpv8ttAWL2NQzxPJq+pO9CCp4jiPVBQnlkYciuxTsitn+BrHozaOpFsWGWDR/z6sVN3xzlMSiPP+nCZFVoSO+BFK6rzYA5KORvlpZHi8Nmf6H21Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577069; c=relaxed/simple;
	bh=cv0g3AgKJuElra233uFKtUzzTjTFK6obx5ix2SzvJQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsasfHySGDDxQ4/RJEL6y82bWBt33bOM6XV5GZKo9G6KunWBB6Jk+MWqcg+YFFIJHgRu8fMCXCdXaIqtnB8rWiIf5/Qhncb4SyRUpPJtoBeL4iDORpvIL4ICZLvvkTOSBuPlsDKP9PwC4Q5w57NbXM7gksK4dns4Sl6sF2LqWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZS94gMd; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85019a60523so187416241.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731577067; x=1732181867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehGB6dTMf4LXNmabx+6xsT2G4N4oRc0A26QJig4YDNQ=;
        b=RZS94gMdx1S5yc5xXWQTK12pq6zkK/t2RRkcsRIx3zffn/ougDRB04hMnK/bBIcHgn
         zB6H0ABlpVl8u7bu+phwbVhEWddawKJwHPHUvSwlOIfUSvMxxpstkeDx4T/IorHfXxRx
         RduN78rIYrjnI+nvGlsUm2D+wYPC85iNYSpif512sJElhdtgtQa/Qti6KXhAUnJENhYM
         zmGGqT9lRLEVIQF1zMNvB7yUyOnPfT0D1Hj4xsrifX6H16TCpNdG2Le9qY5S5teLy6Q+
         Vi98q165RzG2kf+kN/VbtDRLhKSZ9W3p9N98FiTThSm8elfIUYy+eJWLPRQEW0OuEbNC
         u5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731577067; x=1732181867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehGB6dTMf4LXNmabx+6xsT2G4N4oRc0A26QJig4YDNQ=;
        b=Hj9mKiYFQKCSkcBxdmAF3a2iu0f6t1K0EZIlXuZ7RXp8qS2gkuiFc+f6EmdluMYYO1
         x2t0PfjB5DuL1QKfK2coJ6YtZFOYKoOfjzhgEpTlwtaeDigz2POzrJ0ftkDWOTM7kfH+
         KFsezhmo/2UK1nSEufr5SinII8Noz46ZCEjMdEkctAe7b8ZIlQGazJezasnfUyP4zsCG
         mJZ+JciqQGxneXeQD8AVdkK5GtEj1p3VkMcG8hChEouFpgC10EsiMdSBJlUSutD/dakm
         gm0zY2PujctvAok8tOYR1oslKZ83jBjS/OlwQKvJe9ASDK3467oQVUCAVoCbctCb+YqR
         hvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjfk6No5KqJSpstaHvWi0AAAhN/5EZY3Un5mXImNq5J08g/c46AooTCY5TkBJTQbxY1yRDNjVqPQLZ36Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBU+sekRqBBM7VYdYyXFzGrswIiW9iTQrjJh4eNrr39kl6KWhZ
	cdDJayu1/wMhwCgzKRvlcIA/GllkqQT2zvmFJGr0SsAapUQunsKnFrNgxtR+YiCnq7cxvr9FP56
	+aVztfj9GgeqoNJcQGDSjOUfgY+W4ICUm
X-Google-Smtp-Source: AGHT+IHI15hqHssAzfGGtyXPf31+1ZqoEAtir3h7D+FOXfOCfYcI4E+WZhvgG1S5uTZEAKfrOixmorXSlStST/rghQ8=
X-Received: by 2002:a05:6102:32cf:b0:4a3:c6f3:89c9 with SMTP id
 ada2fe7eead31-4aae138dcccmr23911356137.11.1731577066793; Thu, 14 Nov 2024
 01:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
In-Reply-To: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 14 Nov 2024 09:37:20 +0000
Message-ID: <CA+V-a8sdSBFin=edpj+p5k4KZU4aen+k0acJVTD35YxTbE1qYQ@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: Save base/size instead of pointer to shared
 DMA pool
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, Rob Herring <robh@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-renesas-soc@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:41=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> On RZ/Five, which is non-coherent, and uses CONFIG_DMA_GLOBAL_POOL=3Dy:
>
>     Oops - store (or AMO) access fault [#1]
>     CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc1-00015-g8a6e=
02d0c00e #201
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __memset+0x60/0x100
>      ra : __dma_alloc_from_coherent+0x150/0x17a
>     epc : ffffffff8062d2bc ra : ffffffff80053a94 sp : ffffffc60000ba20
>      gp : ffffffff812e9938 tp : ffffffd601920000 t0 : ffffffc6000d0000
>      t1 : 0000000000000000 t2 : ffffffffe9600000 s0 : ffffffc60000baa0
>      s1 : ffffffc6000d0000 a0 : ffffffc6000d0000 a1 : 0000000000000000
>      a2 : 0000000000001000 a3 : ffffffc6000d1000 a4 : 0000000000000000
>      a5 : 0000000000000000 a6 : ffffffd601adacc0 a7 : ffffffd601a841a8
>      s2 : ffffffd6018573c0 s3 : 0000000000001000 s4 : ffffffd6019541e0
>      s5 : 0000000200000022 s6 : ffffffd6018f8410 s7 : ffffffd6018573e8
>      s8 : 0000000000000001 s9 : 0000000000000001 s10: 0000000000000010
>      s11: 0000000000000000 t3 : 0000000000000000 t4 : ffffffffdefe62d1
>      t5 : 000000001cd6a3a9 t6 : ffffffd601b2aad6
>     status: 0000000200000120 badaddr: ffffffc6000d0000 cause: 00000000000=
00007
>     [<ffffffff8062d2bc>] __memset+0x60/0x100
>     [<ffffffff80053e1a>] dma_alloc_from_global_coherent+0x1c/0x28
>     [<ffffffff80053056>] dma_direct_alloc+0x98/0x112
>     [<ffffffff8005238c>] dma_alloc_attrs+0x78/0x86
>     [<ffffffff8035fdb4>] rz_dmac_probe+0x3f6/0x50a
>     [<ffffffff803a0694>] platform_probe+0x4c/0x8a
>
> If CONFIG_DMA_GLOBAL_POOL=3Dy, the reserved_mem structure passed to
> rmem_dma_setup() is saved for later use, by saving the passed pointer.
> However, when dma_init_reserved_memory() is called later, the pointer
> has become stale, causing a crash.
>
> E.g. in the RZ/Five case, the referenced memory now contains the
> reserved_mem structure for the "mmode_resv0@30000" node (with base
> 0x30000 and size 0x10000), instead of the correct "pma_resv0@58000000"
> node (with base 0x58000000 and size 0x8000000).
>
> Fix this by saving the needed reserved_mem structure's contents instead.
>
> Fixes: 8a6e02d0c00e7b62 ("of: reserved_mem: Restructure how the reserved =
memory regions are processed")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  kernel/dma/coherent.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

