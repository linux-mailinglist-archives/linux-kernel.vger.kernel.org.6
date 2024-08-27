Return-Path: <linux-kernel+bounces-302738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1929602B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FB3B21859
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50896152787;
	Tue, 27 Aug 2024 07:11:56 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2A13774A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742715; cv=none; b=akrtmB6/bylHrSd5/2UNNA7yUUUHv5gtmxFrp/3UYaM0HM4giNNGeSs1rO8fSC0vsOLI9JoeUNYVaPttBqnrbIspahuuvV0AG1YJpZekHDZ3YOFQpqgYrUgUTdlhJtw/zjJNcxCG+wh+3HmY/eaSXtYTX/XwRpWKsDt9BxXtFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742715; c=relaxed/simple;
	bh=j5BpILoTNlLSBEt2+ZY0raTn+epdVTPnd+VDAxdWWFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACnpHR23Hq46wdSGcEgRyfphXDQHYecwoNH8/diNkkcIP94I8gcsv+hp+F6jmeRSYcAsMm0YtDc0dnvwZsslqyxkV7FZUsNiSOXJUktKF9QgbB8HBAh1bv176L+e5zch7ezuW/mwjgbyK7oFiHrB0qNq6G/OnXeQ6vQzAemzpTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e179c28f990so4187807276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724742712; x=1725347512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APSqeIhzw1N+DketUQ7sCGv0QezbS2jJhcROUReG2pg=;
        b=snNfViXZ3Bs0mvoxvu9p2fMVAkm9tM3ykNN2HRlEC3aRmaZnVKUk3U0kjkISFXYi6l
         sXSH/J3RJZQmiMbZGVwx1/XU8FZ0BEtyTnvVXAhp19esRstiqsetGXEdNoWGRHDUVZ0f
         x+9vNkQ2QrTt2tw0KGYWwIF1BCrukyuNAQ595MdTRSdGN3h/FjHoF76O1o8LOtDZZRCa
         xYBW+wlwAQxvCsZ6t0uY5z9LGWA8sVZk1SG9dg5RVjSlTU+1qDcrE2GiIRbQ3ooBYETz
         w1HVpFjkKOwwl0HAJ0GbGKNi9J86ccYrgCF1j0wabZKWja8ajdbT7+vqM3Bz2TkJq7pI
         LYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi82FGfvidM4PALQEDonfANaCSL++zmCX++HjKLgrVCi/Zt6xl3wZtONxstkf/1vro8It6BSgaKAt+xBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10QXdWnKI4neehOixItAsu7jjLi1iUo4iFX1nJL4DJLOu8uCd
	E4Gwjy86cGQ6LjCOJdjV/ACxOm3n8bNz1z1TqYdOfTOspqybsPbEhO9AGz8/
X-Google-Smtp-Source: AGHT+IExaPY9+GcO/WrrgDPFKmNjP4epdTLzkmiMU0+iuIyJpTg71kDCo8Jp7cgMB1DfCk9v+P7VZw==
X-Received: by 2002:a05:6902:2304:b0:e0e:ae31:138a with SMTP id 3f1490d57ef6-e17a867fbc1mr10057416276.50.1724742712237;
        Tue, 27 Aug 2024 00:11:52 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4bb795sm2332406276.34.2024.08.27.00.11.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 00:11:52 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b99988b6ceso50429177b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:11:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuHojnz6qNuR6otVFM8dC0k3OU/EOe7cjMkXVPvMF3wP65Vzz/sbhvtmI4tqTIxfs1ytfG86qy5GhWKB4=@vger.kernel.org
X-Received: by 2002:a05:690c:74c1:b0:6b0:4f2b:29f0 with SMTP id
 00721157ae682-6c628a9f15amr140970477b3.29.1724742711847; Tue, 27 Aug 2024
 00:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827065230.145021-1-alexghiti@rivosinc.com>
In-Reply-To: <20240827065230.145021-1-alexghiti@rivosinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Aug 2024 09:11:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUktxDyDUtcvgHR5vH_JXacvM3DQuW_65DB=abJDcEE8g@mail.gmail.com>
Message-ID: <CAMuHMdUktxDyDUtcvgHR5vH_JXacvM3DQuW_65DB=abJDcEE8g@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Do not restrict memory size because of
 linear mapping on nommu
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, David McKay <david.mckay@codasip.com>, 
	Stuart Menefy <stuart.menefy@codasip.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, Aug 27, 2024 at 8:52=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
> It makes no sense to restrict physical memory size because of linear
> mapping size constraints when there is no linear mapping, so only do
> that when mmu is enabled.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/linux-riscv/CAMuHMdW0bnJt5GMRtOZGkTiM7GK4=
UaLJCDMF_Ouq++fnDKi3_A@mail.gmail.com/
> Fixes: 3b6564427aea ("riscv: Fix linear mapping checks for non-contiguous=
 memory regions")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for your patch!
Sorry, I didn't get to test the preview yesterday...

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

