Return-Path: <linux-kernel+bounces-263555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DD93D7A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B271F248FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E737F17CA1B;
	Fri, 26 Jul 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nspXGXMB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A717C7DF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015088; cv=none; b=eGryOTttIobeSDVKoLv+PNC1Z8K6RoZdqOEquRT05SIQux5a5rLPGY/EQuhIGX0elZfQo/PHgV4mYj+ECy0NVLfvECF0XhmsetQ97PSReyFNxjxoP20XeqBU4Xyn0ysb3yIledawwc7sHtlA45cKgwDL55wc7xUkE/o14R3aiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015088; c=relaxed/simple;
	bh=GHKjTGsA5xoJdxNc5US7opyHTsaUSz6DP4R2VVpLsL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0hWQfE/FHADpSPQ36/v8+GlB1M9j1Yj1PztTeCFMSaxeag6qGX6vPsraPP2qEQIc06ieRwho5+c2rVqDcADvKzl+9tNLiLbRxb+PbhPLYk6az4bkvQhFxG3gyxqWGFEVX5TRVIU8FUEjt3Yoy/gUvnVSVBptKfRwqJlw9Wck40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nspXGXMB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a81bd549eso177910166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722015085; x=1722619885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHKjTGsA5xoJdxNc5US7opyHTsaUSz6DP4R2VVpLsL0=;
        b=nspXGXMB4vFOrnx+6+0SaIl5UlBNSnCSVsv31/DSOGz/ujAS0ziHDJCxRXDlWH91OW
         wdXBhfNi8MlSkwluyQCUl+l1XtWgKFlTaGnAuYBjUSp+Al49d8VSb7kN85zGGA8WNzm8
         EaNTGfJrMRhddLcX87FK/vmmK7/eBtDHh/C7dWQbE8RIje05Pvj8q7vuOe2Ka2EDsIr3
         xlrHLh7EpR2Oe0cVIEvMzfbPMaNBctpyXG/39CcrGzhDZwJSlYhVGiZwiiTBixpqHKTu
         mvJdpnbVMipM2vvtRI64f1nlU14P4CYCqKg7E0DBdLOHAZu9CQfTQKAdm+R51ZhLLrkX
         OQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015085; x=1722619885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHKjTGsA5xoJdxNc5US7opyHTsaUSz6DP4R2VVpLsL0=;
        b=q8ZUi+dnKm2LSibxm/k5RgpDeJgrzXi7D73iY7LyBrNHkfm1dmqAA+PabwmSSB/L4A
         YefwZkotqIpDbgdOxtmUny/AEt9ki6pa/wcGjMqHLV7Devx7gMi+1h6N2wl4FPqYcSZ9
         eGsxhy8Ie9vN/HKfS83AB2YYtrd9FHcF5w7RbjzW3Vkfq4t2awMCEHVCqL4b9l/INVlc
         sbMUh5VmdBAmj4+1a3z/kdY5NHsNIw4XJhY8jWJArdVla9fTPJpCcVnTJs93A1rWL2IG
         ndGJ4LjjRyGTxTA0Qj2DXfpWcVP66uUXS5e28aY336wbs9g+p3rjmS21T8LgBRN2BBFr
         ocfQ==
X-Forwarded-Encrypted: i=1; AJvYcCURNhH6+xAJNDMWVinbVmEfwQ5/8M2U2YzfuE2c4cVtHx0SSTV7NRx70zjWGGL60O/O3fxizg9f/JhDmTrWdIS4Wrtnn3Ykb3r2fPkm
X-Gm-Message-State: AOJu0YwysCgtsObS/MUaSoi3mYQkUYciawHmkl877hJ8JEx3cIY7cTDl
	Ya6gXX3fzNXFgT6ajK3qKsAmoVhamHP+LV05yZMxngF39qMuwNysGJ/7G9Ajli4WlkHAlEwDWvy
	/qc+1+4nOtLk0saMg5GWgJFS0lyF6a02ryMBoTw==
X-Google-Smtp-Source: AGHT+IEI2htU4rQmXKR32DSuhL2duertaz8E+94T640gTu2H7zXYYH/H6bLeEQ07Rgpskv2eHm4WeT9H3VNis9yy8bk=
X-Received: by 2002:a17:907:97c4:b0:a77:e1fb:7dec with SMTP id
 a640c23a62f3a-a7d3fffd2b8mr14159766b.17.1722015084967; Fri, 26 Jul 2024
 10:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726163719.1667923-1-jesse@rivosinc.com> <20240726163719.1667923-8-jesse@rivosinc.com>
In-Reply-To: <20240726163719.1667923-8-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 26 Jul 2024 10:30:48 -0700
Message-ID: <CALs-HsvJzeqhymXDG07rN4t_iz2vZV54ACrqtmJ+1UA9jY+Rvw@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] RISC-V: Report vector unaligned access speed hwprobe
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:37=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> wr=
ote:
>
> Detect if vector misaligned accesses are faster or slower than
> equivalent vector byte accesses. This is useful for usermode to know
> whether vector byte accesses or vector misaligned accesses have a better
> bandwidth for operations like memcpy.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

