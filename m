Return-Path: <linux-kernel+bounces-257656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BDE937D13
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D642824BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403D1487FE;
	Fri, 19 Jul 2024 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CceJsyfj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C33145B25
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419041; cv=none; b=uvxS1yzu8F2jgbMzb8QAtfPRNSHnUQCz4MRqNiAVz8Tl/K6ipKKjnTKdKaJU6ZMREITqT3YDaLfwRwmQl1OdA/L5Gk4ekb8LuRMjVq85W1iVNa1gRqBLzQ73gpTKEE0DMbsWAAd2NAWeKjBG6b2QQgH8dDanFKe3E3eTtewhzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419041; c=relaxed/simple;
	bh=TPczUa5e3h8bDIU3taB7K6gYSZd2QQEpQ+m4m+73HB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zao6U9nS2Ts6cthJKV7KQNh61bG1uFsMvWSXRHMUuTxo8O430TyKFifaPlSBpuhZDLhm3LmIjgQHnLvCzpmMfo7ipoC6HHQh9XLuccI4jw6igWzabnc/slO4lWQOkRT3kHsJxzbiRXiX4Ipd0oZ3ymBG7d0PFA4yg6hwiPurBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CceJsyfj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a797c62565aso213087366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721419038; x=1722023838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPczUa5e3h8bDIU3taB7K6gYSZd2QQEpQ+m4m+73HB4=;
        b=CceJsyfjslID070s5z8Me/F/ASStsjDtCN0nfuPJew1ieFbwRksb56dnTt/GG7cRO3
         jvaTlWFIvWNFY3YPIhmQfIzI/BQnJp601Kg0RJspDdXT9Kb+Vu+vN13dtnfomHED/Cmu
         bUNS9ENSYmF4NTh2GnfmfagDq8q8oTknsxPpyZVahmXAneBxxgBLkShXcNzOa5Svpbfh
         rY/jL5ShbuhN++rYM3TXuWlox98iUxojWNjGQMRc5+Nt6H2ij/Q4R8/cY9spxjKUIWIC
         oXTAJSFjVor6lD4D+/MZ7iO+IQ9ax5wP5N8GYJkY2YdDiHOSyRs6SzVUlpn8kHBrjslO
         NXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419038; x=1722023838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPczUa5e3h8bDIU3taB7K6gYSZd2QQEpQ+m4m+73HB4=;
        b=bO6NWVj4jYo/c4XTAzrKasxGWX6YKVrFZ9VnfVbqDhrxrAvMizWA6rLvxsk1GQ5qSH
         EH0TtF9Cb8v12VCua34f0ywvfge5n3ox/VErfd7XJtfs0AJTr/aJ34aRzs/9DtFwJQWg
         2c62dYIjQJodTopnKAUlgybYhnV/pOWiooO1RASJivm/KZPAJagvk4p+4eoaTcaVykH4
         lbPYxXb6s+y7FCzHiwdhFCqrrFenMdkXy7YBj5XDJCdxPG6vjuun3hZDO/k+9sxywS4r
         WBadLDwGfciShHb9LSxBcIRcUiDFvSjt4oDm4UMw4aTkXU/kdsPeOq48943RnOKX97rS
         /c5A==
X-Forwarded-Encrypted: i=1; AJvYcCWzonEBGV2yi0g7zAFdOXjfO+Lf6V1zpVebU79ZhHRO/9a9YEgnyp2Y+iKg1IVoncD9Oyup//EQx3D+9B3aROp879AW1JHsOPSzkgXt
X-Gm-Message-State: AOJu0YzQCmE12A8dtzXp4/mGWv72BOCu2WKn5IAlbQ2x+VV/w83agpyx
	2AHV9fMHJ7X2w4/W5FIdzP8+LNu5EN/MenWuCEuf1Wc98ZS+NzP98UwueGSR0hSWjECiChE0Z1P
	fhjjF+VT/OYsMpIUwtLlgWho4J4aYKMhxbCKIoA==
X-Google-Smtp-Source: AGHT+IFVF+CVdbaJkg3y+N7bCWjdUcp+1bJmmf0A4XaMnmetAxeY3PLap/EOWXN321STq9oPaIZpGUHPeCqe5U+TJJ4=
X-Received: by 2002:a17:906:2849:b0:a72:685b:7c98 with SMTP id
 a640c23a62f3a-a7a0119e3efmr641117366b.37.1721419038069; Fri, 19 Jul 2024
 12:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717180727.4180475-1-jesse@rivosinc.com> <20240717180727.4180475-5-jesse@rivosinc.com>
In-Reply-To: <20240717180727.4180475-5-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 19 Jul 2024 12:56:42 -0700
Message-ID: <CALs-HsvWv+85EX2iFUgnZG7RdFndfn8WhVx_OB6ROPjzLKw+zg@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
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

On Wed, Jul 17, 2024 at 11:07=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED to allow
> for the addition of RISCV_VECTOR_MISALIGNED in a later patch.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

