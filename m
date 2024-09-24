Return-Path: <linux-kernel+bounces-337447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E91984A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BE2B23CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348071ABEDA;
	Tue, 24 Sep 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqol5too"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358A2941B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198483; cv=none; b=uw/2LCcTXI/4xa3JyutdO9xzEJ6maGiwKj1VcAMa3JdsLY4IVT/VvJonCj49iyuciA0Sv6p57FYEoVZslDI3OQ1o2insh4UisuG01UquAPj2pOYHmOIBs4Cloo4OVEGv+wUi98xzxAs8nXJAqRDyCieC2NxIUiBD2rpKZ2KuzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198483; c=relaxed/simple;
	bh=6fEBRh9H68HPsNWugw0lAVBDQm1QZQdp9Vj3XoF3QKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZkx5wkCsQCI2drF2nIw9/tS+TWhH0Pp6GX5uFfmQRPP4VHUkCT2pjpiWcvghNNX3HEU+VB7LMkHS6cUodws7tTHGsxk4WvGE6wng22b4OKEHeYn9JVnsqGaxgVrPnTzKkNL1VNTdRgiKA4s0C1KFycOAKlwUALTQQw+U6oSzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bqol5too; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2dee7861015so314739a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727198481; x=1727803281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mocP745BB1IDkQ7YwcXnRT+my6+xFIbpinyWL0W5Dc=;
        b=Bqol5tooLk88bbzUC5G/2rrmHDcC/F/RyoE8+X6rSac7iKLnGlVVB80nCttW21azA4
         575bKYbwqsdqI8lcSCumiYMLRkJ36FJgpVn3VcS0KpXdwlBsdmJKyPGTCti4NUq8k9Da
         fbvOJgNjTiL0n04/JAF6NGy/z4od1IQEyssmQAfXzOA32aepBUywbTudj8xixjaKsFI+
         kzFZmQ8wxcFWlv4KhmHg9PwqCnxVI7GQoIkAU0x2+Vfx3xsEksIw3Q++otx4BH8hA1DC
         qbHdDWQxk4xsogu16+M1cL4DqCBltkHGmz0ex4x7kWolDkbZrs0ikdb93EimUFLif6hZ
         PcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727198481; x=1727803281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mocP745BB1IDkQ7YwcXnRT+my6+xFIbpinyWL0W5Dc=;
        b=cViOy7zdbZL8pePtvDdmipaqU/YjN8YhBTxE+jJfs1Rvn4XfwQnQ5iyj5n4fjA7udY
         M6M1js6Qi9snGdD8+rqFwcTrt65SmNl4pSWyd1HCwrJ4JAQjctgTGhYNQGiVU1MxpkWG
         fvXxBJ2axfmTViWUXErlmiK4QYPtrMKpJrfseseW+k0CkzHv9vfaSlsEFZpArZzRwkoK
         h4/D81IJcWEm9qNQbNyd4i2tafUqy20i3hIaM+G2OYffOt2UsLsjCqjuFHXVvFu8jP58
         tQgm12Nt7woRgQ+SnTyegJYjWYANpAM5tumnpRI+QV7gX+Z7Az2DDM7T9ip3KWiNqvTB
         Oppw==
X-Forwarded-Encrypted: i=1; AJvYcCVTkk7rpVj2/49pr0gtzMnHjoZSscQ1qh595fnTRJcYEq/XWCXuaFgl8aJ4N4c7zgepXS94XlV/ETpfxSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmjzLq1ScJo6KnfJmIWs2hGFRlgOZEgMV5/MILdVul/RIgvch
	YDSrq9g1F6gdrY7/NK8Gm2o8TQRZYDCYfqak2K/j40S3jkiDEgefAx255W4Z3xsODIyz/SQ2C2U
	qZiOJCJ6fkzu3x03dPKXuuG2ygW8=
X-Google-Smtp-Source: AGHT+IHEl4SS56wI++33QaNSBNtB60zwXtFiDHBzKILClZ4/hNBTywoIIXCFIyvWbSsaSHcbIXKL/NIMn2uEBdwHNxY=
X-Received: by 2002:a17:90b:4f43:b0:2d8:f13c:55d4 with SMTP id
 98e67ed59e1d1-2dd7f5be591mr7851541a91.5.1727198481441; Tue, 24 Sep 2024
 10:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
In-Reply-To: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Sep 2024 19:21:08 +0200
Message-ID: <CANiq72kqVFs5rfS_y0a40ZAygE5S+vkyb2Fv+B5BNzvuAa_hiQ@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:55=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
> the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
> x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
> The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
> fails in the same way:
>
>     error: =E2=80=98retain=E2=80=99 attribute ignored [-Werror=3Dattribut=
es]

That appears to be the case indeed:

    https://godbolt.org/z/78Gj94vMW

The `.section` does not get emitted, so the warning appears to be
right, but we cannot trust `__has_attribute` for this :(

> Fixes: 0a5d3258d7c97295 ("compiler_types.h: Define __retain for __attribu=
te__((__retain__))")

Nit: 12 char hash.

> +/*
> + * Most 11.x compilers claim to support it, but only riscv64-linux-gnu-g=
cc and
> + * x86_64-linux-gnu-gcc actually do.
> + */

Just to confirm: did you try all? If not, perhaps we should say "at
least X does not work" instead.

> +#if GCC_VERSION < 120000
> +#undef __retain
> +#define __retain
> +#endif

Should this go into the conditional in `compiler_types.h` instead? And
perhaps the `__has__attribute` test removed for GCC?

Even if we keep it here, I think at least a comment there should be
added, since it says GCC >=3D 11 supports it, which can be confusing if
one is not aware of this other thing in this file.

Thanks!

Cheers,
Miguel

