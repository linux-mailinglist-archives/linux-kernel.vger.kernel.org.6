Return-Path: <linux-kernel+bounces-179074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF158C5B47
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BFB1F2149D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDEC180A85;
	Tue, 14 May 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TdYQVhB3"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD973181D1B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712130; cv=none; b=GQHQTjfmV8td/5LRUDqfR0PtMMgod/BNkZEb6vJZRdCnJ5qHbNNg4G/ELWB0PTM8wC6MEvRnnqD9S34cUGXpNLqr9z/+KSIM+qcuq6cFT5Kd/Af+Uf/WJavXtGYDUDPFrxk+un8kx9cNbo7trbHO6LYPKHSh1gllh5RbWgz/ey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712130; c=relaxed/simple;
	bh=hCWkqLqTv3ItUHoFzIgYNgbikvR26cFj8jMx1uex/2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsCpxkRWIRRC1oWtHbzjBJtslV2cdoK4+XMB35qWnIHzBiljroaRq0nHV/8X01Fljl2xv+99L2APdpOFJSGZGtOtYtJ2l3Q8YPl9K8sGTvRmriwpIS1NkbZwyAegdmOcmeM/oH33rNBuhuQjs8HS2LiH+YK2ucBwfV5QbT9xH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TdYQVhB3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so641934a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715712127; x=1716316927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6ryeUi7qTJoBD/62OgqeYM1G6ocyge361mggTj3ews=;
        b=TdYQVhB3Isq1myW6mEzdVYsmN5zUejFysulaz6CHYZowW1kr6qTBGjymR0TPEINdyh
         sgrlzpoXETSyf4XEWFjew5nTpbZKQ/AvtKUtBv83q7eUzLL/VhQH0YoIO6yttJwIqk6z
         X7QQLiSJvZTIjkfUV+oWX/ltYdP0yN1cHOZ2NhIqtnRvPd+GKbr1lCXGafvPiKg76GEg
         50u0wEeA8bLcA7GmyixI+2RYvI/qCffNRMhrG7W/K+DWBNeqet2ESLytYG7mrC4I5aN1
         W7FrUfWvw5bpYDQO6JniDh1a6uP7/kIEohPvsiVl6/rhDNHmFBiWnZwJ3TcjLMvgMy5W
         mmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712127; x=1716316927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6ryeUi7qTJoBD/62OgqeYM1G6ocyge361mggTj3ews=;
        b=VG88I+L+cYLJt8NJ1c5OOgngK9LG0w9xoEIzUJ4S1b/P9mxThFnLPegaheKicGaTYZ
         bR4nFFvSj1NzuRjxPUYHSuD6/vV4CmR2CozVsXI8LmTt7mO1DpSGCH/fKzqz6J8IoXM7
         UFnAGLTYFm6kGYK1xNvnlZfq/Atwy2VeC6bmsUi83jUdqZqulI3j8hHjgsRVl8wE668H
         IXSsd1rxgPdPi9w2xG/vxgKecL7POCsTKc81JjNC5TlejZUDLL+QCXUsXnnOw++xQD9g
         MGZPZPSt06P7n+R3qXi2ByxujWXb1h9SVf5Vh4QanQd/NfPdU+SB27LIBEHyRrNOZEtc
         v2tA==
X-Forwarded-Encrypted: i=1; AJvYcCXXp3v/udV1X36owu2STiHp7b99uNy3uBcfmBmUhxsSbHX/JsRlm9JDwghWuEYgzMGNdEzrM8J1y0F18LBBEzIhH0wej/++0vUtjMqo
X-Gm-Message-State: AOJu0Yy6AhjT7joxGXe7nb+jYzxztgq028PtZQqZhU8w8wUnnAdSH9Et
	urWiCzsS74vNxFu++kOS8E4Nl6nHde0Y2911N+Gp2LXxJcOiP9pnNcz45nNNmm+1n48IsKscU6r
	YKRl8HxX/i9cPe4vn0LrodgNW+szI8UqFsxhywg==
X-Google-Smtp-Source: AGHT+IFbMwiOYUAb7e/8vZthTHtvmc7pKqYbGlejzDyPWTizt9LTFfXax18by9Z28FgBfafwz7WSCj7y4vYaV87ykNE=
X-Received: by 2002:a50:9b05:0:b0:572:47be:a81e with SMTP id
 4fb4d7f45d1cf-5734d707234mr10945519a12.40.1715712127280; Tue, 14 May 2024
 11:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-7-bjorn@kernel.org>
 <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com> <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 20:41:56 +0200
Message-ID: <CAHVXubhbckKD=z74_Y+uukf4FQodnz4-fNdB94fK9OK++xz=nQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 8:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
>
> > On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> >>
> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >>
> >> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
> >> RISC-V.
> >>
> >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> ---
> >>  arch/riscv/Kconfig | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index 6bec1bce6586..b9398b64bb69 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -16,6 +16,8 @@ config RISCV
> >>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> >>         select ARCH_DMA_DEFAULT_COHERENT
> >>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRA=
TION
> >> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU
> >
> > I think this should be SPARSEMEM_VMEMMAP here.
>
> Hmm, care to elaborate? I thought that was optional.

My bad, I thought VMEMMAP was required in your patchset. Sorry for the nois=
e!

