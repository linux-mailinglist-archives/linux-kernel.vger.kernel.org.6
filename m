Return-Path: <linux-kernel+bounces-207029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C1590116C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4604C2819C5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FD0178375;
	Sat,  8 Jun 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfTFPqM6"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D217BB7;
	Sat,  8 Jun 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717848979; cv=none; b=lCd2LDomXwhsMH7UlC+Na4gaYyxnHNCojFy4VnqNwH9cGu293EHMFL77a8jJZ3TXOA5lhyfGGRk5db/BuuHUTTDyBn0g0ADIO8Hahkpql/b3uF+a+sSvwxTuOJ0hR+qf94WFv6Rua5a4ybPP7amgIqJzz9IzvNVIO3nEjOJJOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717848979; c=relaxed/simple;
	bh=5/UAPYwcgAe7ZWfUsvTDZ0S/CUfovi6lXYY8woJq+8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=od+pEFM9Zi3biSrSKlE4rm5PJJfFnoggnnAojcZPwfzZLPSko+hAiCedOwxzx7Wgq4RUrdcCOota7Nj0t5IvXV9ph71o14wE/zB+mA+CLJYng0wGx6d1msudHm+xf5rNGvf+ubL1VPr0zvooV03WdvuuWc96jn0EX0o82/qQwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfTFPqM6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-681ad081695so2316998a12.3;
        Sat, 08 Jun 2024 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717848978; x=1718453778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKSBnGSmzchFpYgSY1/szHPlRvPcQPGig0KHSHqMUl8=;
        b=EfTFPqM6y2h3bLvXK9eUmS78D4SvVF5fiZdzzeEqoxlhQq3u5wNMBSv7CKymnID/SS
         ziYs0mHUStlT9olzCzcardCXForae6JhFPbM4wTBWAAQrOifOnq0glz34Sjp96Sr53nU
         fiIX77oFfVYm6sqIJZkc+/C+zYl6A6x86TYbIBQhHFDxDF0i2fRUus9wREa5q4u6nyE8
         jvhpD6zufEWfJ8Yn3szdqVMto7itulDRMTQfk3yJk1SA5yfng+C319iqiGt+SlK7L9XA
         mRDwkE+y00Kbiyiy3lfqqdPCkQ61zQd/T1mT1uBa+4AHZtB7QO2wCLRmesojXLNBr7jD
         iP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717848978; x=1718453778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKSBnGSmzchFpYgSY1/szHPlRvPcQPGig0KHSHqMUl8=;
        b=uWAhRfOowA2grYa86N9W8KIgTLycEp3YfkDXufrPhyTxcPnIDxYIPKrPR8KAdcm2Oc
         tXDvAUNCVfGFjuSKXlhyNHaz9wf0GVHzkyritWnRY5C+ctnrV5FNUjWZW96gtkLxMKUX
         inclYIbUo8GII/nRADplaxobuCuO4ZsNvGEI/bJ/xwC8+/qMBa20SGgiOCqWhZ1zGQaH
         v2Cw9jhPIYOX/cwjBTqPWFGpYEWRjs0OcbR40e21CXuhjs1ArRW5D/NVQbrBQuHs9nf1
         z4TA17qslfMqO6Y8QqW4b2mFLfeEHVpfCzSoaLiVobN8Rky0Z3qk/Xr/N3NKJviTEKTs
         H5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMuloKjUINsjEFRfRY6esSI1n2lwUrComofeaYrZ5UsNNhTgxG98fAKspxZSFxg3xmuYC2M3I9UunMOrOzmb86hB+u2kMH+z0M70FCylo=
X-Gm-Message-State: AOJu0YwE4+mpLWY1aIN2WKdvlfVSQCSMTLLPELPOu8VpodaRtKCvtH4I
	BPVL4EbhbxjLUH21A7tlE0OTQtYUV0g3nB8w7dQMyy2orgqyG1cmB9Xv4/J0L20EXy4k2NpejN9
	6nsaein1G9WIUUVX5ywYsQ39qzPI=
X-Google-Smtp-Source: AGHT+IHIYC+jXj7oKSbCIQMn0EzuWo5mO4AS/ZMfyaP7ov3SM8eiT8jgL4H6GyHHSF0xknZrZwBHWyzpxvn1NVg7DR8=
X-Received: by 2002:a17:90a:8a10:b0:2be:9547:41a8 with SMTP id
 98e67ed59e1d1-2c2bcc61b80mr4817088a91.48.1717848977670; Sat, 08 Jun 2024
 05:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
In-Reply-To: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Jun 2024 14:16:05 +0200
Message-ID: <CANiq72kaVw_t=hCJ-qEr=9ybuOngAR6isnCK717dBEm7CFm2NQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Jamie Cunliffe <jamie.cunliffe@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Sven Van Asbroeck <thesven73@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 12:30=E2=80=AFAM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
>
> This is based on the code by Sven Van Asbroeck from the original
> rust branch and inspired by the AArch version by Jamie Cunliffe.

Thanks for mentioning that!

(AArch64 perhaps?)

> I have tested the rust samples and a custom simple MMIO module
> on on hardware (De1SoC FPGA + Arm A9 CPU).

Very nice to have tested it in real hardware, thanks!

(Duplicate "on on").

> +``arm``        Maintained        ARMv7 Little Endian only.

How hard would it be to test and maintain other versions, eventually?
I met Jamie recently, he may have some ideas here.

> -BINDGEN_TARGET_arm64   :=3D aarch64-linux-gnu
> +BINDGEN_TARGET_arm64:=3D aarch64-linux-gnu

Spurious change?

> +# Depending on how the architecute defines ARCH_SLAB_MINALIGN, bindgen m=
ight generate a binding.
> +# Disable this here as there is a const that will always be generated in=
 bindings_helper.c

Typo in "architecute". Also, I guess you mean `.h` instead. Please use
Markdown formatting for consistency with the rest of the file.

> +        panic!("arm uses the builtin rustc target");

Since ARM64 puts the name of the target in the message, it would be
nice to do the same (or perhaps it can be removed from the ARM64 one
otherwise).

Cheers,
Miguel

