Return-Path: <linux-kernel+bounces-262555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1525893C88F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C1E1C21E61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C435B4CB2B;
	Thu, 25 Jul 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="C4CMyTxp"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A114C7B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721934024; cv=none; b=uciqnkzcrLwfalTGzFREAtkppm3L0sxCKTgcaCsmyeLaycddolAjJrbQRD/bxieCPBKA5CeuX8It79BORDnHp3wfAjZBxLjcyJrU4BGmMNw2c0SA0v7hn9PPGa1R7zksX8TCX5rBwGWM3Lk8NFHbNZHlgm0crfNLKrLSHcLh+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721934024; c=relaxed/simple;
	bh=Odp82Bt/6lQT9q7XLZznJSSdvglIivq+nF5Svn4ptT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIbGRCvEgSUWdP+D2FMjS12NY3mhFXInpIPGxsDQBUaTeKrEtA/8h0Z+QMs2Mc+2my2Sr2Ptvq+M8HaM/c1Qrjy4zb7YzqGMhCYZnezR5NoXaYxTLFXBYL0Ex67UZNY9Ea/HdvMS/0yu1T2YW2Dam5jpeJEGxA2JVxRj4mCV8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=C4CMyTxp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so1717734a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721934021; x=1722538821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odp82Bt/6lQT9q7XLZznJSSdvglIivq+nF5Svn4ptT0=;
        b=C4CMyTxpBcgEyntsBbmoBMG/Kplyrb9tzhVute+3QiJr8eVy72764SJOFX+0LX/3j/
         VYPKxPriJG+9tiHw/q+u1Kw02d43gsNipkU+XzUUB67NA4fBuB2tEVZ9mLeygjR4ieoK
         NbpONUio0nPZyDvD8iDliSA7hOk+7+Cd6SrEVzGOSkmys1Vd7MK88FysGryotYcL/v8t
         GG1MnfNgJPevm7zhHqeK3sulsPlBw49ZWJgY+8xSqCBhf83z598aQt9yWDOv8jETNfZp
         /UdRBVWeKPW7DciWePfe4w415wGGWLM9mfrasIMhd2iQRACPCG/bcpGoWJymTFXhOAUy
         gK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721934021; x=1722538821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Odp82Bt/6lQT9q7XLZznJSSdvglIivq+nF5Svn4ptT0=;
        b=MJYjI9Vp/gSA3CcchIqORun13fKk4aRb5gdLWglLaUdqmIMaGX3By7tZ6ee9eaP6yh
         gtcmYZGTFGaYb7AEPvARerdWGWhkrLxjoCG7vcY3LgpC7OM9bueryWvpYXaw+p/KUBI/
         KanRzebpboUPJjnnIpwqTSQ1WXlsWSbjhu8ZnxBJHJ4PM7D71OFY7J//KEv2UJCmGbIi
         bl7UfnIKycaFNYCTRn7kLAekCvrNlBAQCpkvIfJy8FL2tVOjT6K/BoLkTNWVXiunsr3I
         LTrFBwTKvwxA6UZI/rH0oFPxLgK2xlBhyqYTyrlfkpOUAvCT1bLlZpZU7qEHIl0TZ6O7
         5BoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiBOF5WkkISE2kwXGTgKUNI0YWRcV9IWKdXBa7fMtjaBCc5PQQ2Nribe4HzhDmv8ta2jkeAIAAqJMt3yHp6Kt5T4oo+hznTxGk5s4x
X-Gm-Message-State: AOJu0YwPvL2Hl9fCd5Nw0pWxPrESb/Qgpfj1yFAoQlbo1iriOpxpZCRZ
	LuXDDOhVLx2r2VIBRN3L6xIPiFGN3If2jyvqCW11MROPCZ0KXG7kZtiKTSXEeTBDBSZDq8+U1Qr
	mYAH1vtLXZ1HPRFZcQjkyP+jT5IuHunrAAwD4lA==
X-Google-Smtp-Source: AGHT+IHDvkKcJD4Ik/iost4JLdfIAMZE785wfXdt7jij5gd0w5caXSBtwl0brqZnk6WI+gW1KzKa1dQRWmFciMLLxGA=
X-Received: by 2002:a17:907:93d6:b0:a72:40b4:c845 with SMTP id
 a640c23a62f3a-a7ac50641dcmr215221666b.51.1721934021027; Thu, 25 Jul 2024
 12:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724183605.4038597-1-jesse@rivosinc.com> <20240724183605.4038597-6-jesse@rivosinc.com>
In-Reply-To: <20240724183605.4038597-6-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 25 Jul 2024 11:59:44 -0700
Message-ID: <CALs-HsuW+p4KsR0GiOT5OpFVNB6CL23hJd2r6qgu2Ff7dhfRLQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:36=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED to allow
> for the addition of RISCV_VECTOR_MISALIGNED in a later patch.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

