Return-Path: <linux-kernel+bounces-223345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5D0911171
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654C91C22F71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C51B5805;
	Thu, 20 Jun 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1HUCR1Jg"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28711AF69B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909526; cv=none; b=KAmcLmyS3LcXf1NlSo6JYh3llKYMBBVwq2YMWTEy622AXsYgH8N0VbqtK/VrEHfx7qJvIcTVEIB3m6iMzl+tZYnMPgnIHmH19bbikWd0yQ6pRW/5ZwH8us6/4GTu3IYFt4k5nhjK3gStulP2tZRarxovtWh372t1U39OdBRrIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909526; c=relaxed/simple;
	bh=vqFQrTxFHrYe1o6WjXHXHo5anK+bMQtB11fhdkGTn5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS0cA5admGkbCNu0Zk1vQZ5PEQlk/tKbgBq9NGNR0zpihAMzll+q7JBesztxzfYVoldWB9/4E1/1AuMOuMfMb6DEbwBWGF+bGOC+FSspKK1zpdJG28a6qBWeWMuL6pFbXo7fwRXLyh1+Hl+tOcGjq1qE04PObFwbfhP2GQQJDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1HUCR1Jg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f1da33826so156378866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718909522; x=1719514322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVDuY1tK8O4XAXxIL/j26gAakgY66nxVupbQ97z0yFQ=;
        b=1HUCR1JgW2pndu5pEykWlkPteG0iZTozOvrYUqIf1oWhAd43L5GJaCZkWfWAzFFhWz
         1FY8I/BL+BevwIx8/PWLn255JZLEdLdt6RLIOHkdv5RPPbEAnA/SZymz6svoo5w7KSGd
         05WaDsa8CMlxDAkJgvIcKGJ1znVaMHUZfMiMNI+lIfS/z1lQkPQxC1jRB7xbnGzTtWJb
         oAAOvBSKQAAHLgURyQxqhxY5TANyR2OEo/CU2Og5lrIrwVxPLV5Z0JkmFWP248CSGSmI
         8rd1Hy/3Hv75IzJjPpoM6cK7jxIQSVZ0USw5LqAgCvZyFyODs/310vs/m+JpR0/wpt9+
         f+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909522; x=1719514322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVDuY1tK8O4XAXxIL/j26gAakgY66nxVupbQ97z0yFQ=;
        b=QK5NgRms/0jk5E0p/W9LZDnsxA1x67s2FZYESTgqDh4dbA2DNBVBk/Swvl4ZLSArOX
         9EVORpWd3QCKH5dCWGAcvEQ6ATgLG68fbJHPSPOAiXx5zDwW/ekCNx2sThQ+/fKxV91R
         HST3OgWflpuiDO4P151EQ4k/PTDT2sq+Isc6jcFSu9NeFLS276WwfHx+ebgjniDedHnm
         Q+nmMuJwdvJn9+NBPyU4AtdsiTIpRANhDbNLoCslojh1uPHj5o4bdp5jh1AK4ZGC+8Pw
         8XGZV8xkvaALhhu4AfsvHa+v0dHu0WgBluXIYaw4EiayJ79TsqCqlxt8OxH80iqeEnoZ
         ZoAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7g02Mo3ZkxPlYXccp6EvcKnC4URea71LoZroNNdUqJVrco3OrwJ3Qi21AtxHNOOspmkb+nHhGgOi0xtFdn+8OPFfaNL5nqicYtepL
X-Gm-Message-State: AOJu0YwRtcKcp229PVMY+9nfITQJfw2X3DfnJlWfFJpPBndoCX+W5N5X
	1h2KXsT6u6wTqFYBDDmp3brPsh1zPirKsXx6c++ywRJLZ4Q+Vf9sYWZWGKej3/3T5GT+74vbF3/
	K0e9QbQJN3TOOoM8uAzbsBLeyEKai5d0gXz/QFw==
X-Google-Smtp-Source: AGHT+IEQzvgg4VGHyUlRo+eqwYsckLUIf9MsEs4G+q5TI9DtWxbGLapuVfQAwEwLLu7jIZ+TrQNgKbi0vAanRN54ZRk=
X-Received: by 2002:a17:907:7625:b0:a6f:53f9:7974 with SMTP id
 a640c23a62f3a-a6fab7791a4mr399958366b.52.1718909522135; Thu, 20 Jun 2024
 11:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613191616.2101821-1-jesse@rivosinc.com> <20240613191616.2101821-7-jesse@rivosinc.com>
In-Reply-To: <20240613191616.2101821-7-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 20 Jun 2024 11:51:25 -0700
Message-ID: <CALs-HssqVkEX0=x+jhQDjwjRQb9TjbskLvrpvzFG_g-2iDXy3w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] RISC-V: hwprobe: Document unaligned vector perf key
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

On Thu, Jun 13, 2024 at 12:18=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Document key for reporting the speed of unaligned vector accesses.
> The descriptions are the same as the scalar equivalent values.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>   - New patch
> ---
>  Documentation/arch/riscv/hwprobe.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 7085a694b801..344bea1e21bd 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -236,3 +236,19 @@ The following keys are defined:
>
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF`: An enum value descri=
bing the
> +  performance of misaligned vector accesses on the selected set of proce=
ssors.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN`: The performance of =
misaligned
> +    accesses is unknown.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_SLOW`: Misaligned accesses ar=
e slower

Should we specify what size of vector access we're comparing against?
In other words, crispen up what "misaligned access" exactly means. I
realize you copied this from my text. I really should have said
"misaligned native word size accesses".

> +    than equivalent byte accesses.  Misaligned accesses may be supported
> +    directly in hardware, or trapped and emulated by software.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_FAST`: Misaligned accesses ar=
e faster
> +    than equivalent byte accesses.
> +
> +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED`: Misaligned acce=
sses are
> +    not supported at all and will generate a misaligned address fault.
> --
> 2.43.0
>

