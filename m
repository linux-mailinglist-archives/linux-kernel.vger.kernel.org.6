Return-Path: <linux-kernel+bounces-527603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8737A40D35
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A94E17B545
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2741FBEBF;
	Sun, 23 Feb 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="MMKZcMPv"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA802111
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740294771; cv=none; b=DgUlHf+2n8Vv9p7X3LIdJFsHhzFiOEAj3cjBbb4Z/3C5aetEJueOJXDJ4OjvwPb98oaWQr2zFhrQSfEN6PS0QSqF8N9oyz35HkNVHCjggtkCYdcqIRV4j8NP7Rea72GpfzIXrv6nwEicAXYxs56rsZxARJFIg/50dDUXscUpCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740294771; c=relaxed/simple;
	bh=cpcCvhPWrr9JwQoBY8+5sHgrVGVMUj1p6Vb2eP3M79A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RI/K1NUzodHzc+GrA8tN1sLpsYZGsJFoXrsXfH6s/NaE94zsxDBzCcZqDKrLBJNzN1WqsY1iVKkaIEFqdycciq2qMWBSNagmfptU1xlObhLwISiLHeoXPSJ028DLTRYTU9CyJCQjF64kgXo1U9LtR2LDbs8s8BOt4yJz7zW6pWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=MMKZcMPv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fb8de54da9so20770417b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 23:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1740294768; x=1740899568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldzcQVZLNCUbBkmkSbK9JX+buCbspNWQzfPcTiRZxPU=;
        b=MMKZcMPvO0GQ+Wxye0F1P53ihXO9+jce13xxv+lMtFwTqld/KfL+9zMjO2m7BEHPLO
         a3Tu0sMSoS0V8wglHDf3UmM4mcAm5bh/+IOpLopVaKPTLYqjZ3eqGwv/gmb1YQ/3w+RC
         VLIQt+afgz2P6ULiPIpDiJkOKLvALIB31k4dlionRJESd2RIzkxucGLUX48zzV9G4YTy
         5zBe7R5JlHhILG19OEXSkPYCJ2aNLA+Tgz7017zvGqwv249W20KFrB9An5CBpAjztLJP
         Uf4w7jcc5k+CDGD9p2aeWmVEiD2Vtjv5+Ai/fJD/RJAeRtx26lD9gAc1eQeLz4iUh0lH
         Li1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740294768; x=1740899568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldzcQVZLNCUbBkmkSbK9JX+buCbspNWQzfPcTiRZxPU=;
        b=dwCYoR9u9Rjdm+3FEMlyJ+cgDBRqCgL1irZ/cs5oWnrn+1FNNTK9fPfRQyKsnIws+G
         guAjST2guG0VHsa22FjYTW/YbrP0LgaLdh+KTp0B26LJJL7crkkeo2MrDGCTcVGvxfVP
         M2Xl6frVH3QchK+JOD1uZOxBeNU1CjER11RGkx3P8u/ThrPSV8ENNA06lWpwUe45VUBc
         0j8a1YvMtUNTCv+KPgrdQ8RWZl/l3IW/CLFbnyt2QqOAE3JhP+eABpmPoApFQGZdToav
         vIUGNZe1w5npgchEWf749evUc/LcFBghQRWIWeaUI4GWmr0dN7xLj1IFt5j7rjgHKSoD
         tV2w==
X-Forwarded-Encrypted: i=1; AJvYcCV3NzULyeEhserqwjXp/7EhtvoCmKAkZ5OJz3CroKSgP+H3STb1KtLq9zHzEW+nMPMZWkMiWfBratRnZUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbBoqUqGbXDYJ502Cxclwj/dw0uWxp2yTROUyAz/ZZe0tV7k4
	7q2h2Ay8TK6dDZ36P2NxMWcELBLuBmkMPgY2eHWH8EF1EUkv4jNybHbS2qytg3rcpSdTpc12Ide
	HRS8kYcbXySqofAt6VTzYMqCIN+3cG8VVHdvNaQ==
X-Gm-Gg: ASbGnctRpdwPSjWEYGq0lMjCRqJbLKhg+/VibnoM9e59t/7SvzO92Tg4S0XR7dPpLAT
	pVUddiXmJm7ijlmFqYltu5Rgqaywu3o8bJxRKEOMgfrrbwuYBjJaaVhnxbT7tKEzcfMLEP1XjIy
	hWia+b5DOfFF/aDJVgTe6ONJmTfve+C3PtlQ==
X-Google-Smtp-Source: AGHT+IErv7QjZvqwZj7xwVFEty3DyOMgQT39nCw3foX+DTo4lf4iob2nS49dT5fKuofFWcZyAoIBII3K1uxoegJ4n5M=
X-Received: by 2002:a05:690c:7401:b0:6ee:8363:96d3 with SMTP id
 00721157ae682-6fbcc372266mr78832957b3.27.1740294767658; Sat, 22 Feb 2025
 23:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
In-Reply-To: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
From: Anton Blanchard <antonb@tenstorrent.com>
Date: Sun, 23 Feb 2025 18:12:36 +1100
X-Gm-Features: AWEUYZl2UnE5I4LEXGNcBcYyg7ug4nKfYel88Patux_dppHJ-4gcND83DtzAV8E
Message-ID: <CAN7m+mC18ch=+iqJxarc-Xi_W9hZZkHD-p7ZthXqH9CwDtsqKA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] riscv: uaccess: optimizations
To: Cyril Bur <cyrilbur@tenstorrent.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paul Walmsley <paul.walmsley@sifive.com>, charlie@rivosinc.com, jrtc27@jrtc27.com, 
	ben.dooks@codethink.co.uk, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jszhang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cyril,

On Fri, Feb 21, 2025 at 11:09=E2=80=AFAM Cyril Bur <cyrilbur@tenstorrent.co=
m> wrote:
> This series tries to optimize riscv uaccess by allowing the use of
> user_access_begin() and user_access_end() which permits grouping user acc=
esses
> and avoiding the CSR write penalty for each access.

I tested this on the upcoming Tenstorrent Ascalon CPU using a simple
microbenchmark (getdents64() on a directory with 10 files in it) and it was
significantly faster (over 40%). This came from both a reduction in
instruction count as well as a reduction in sstatus CSR writes.

It would be great if we could get this merged considering x86, arm64 and
POWER are exploiting this optimisation already.

Thanks,
Anton

> The error path can also be optimised using asm goto which patches 3 and 4
> achieve. This will speed up jumping to labels by avoiding the need of an
> intermediary error type variable within the uaccess macros
>
> I did read the discussion this series generated. It isn't clear to me
> which direction to take the patches, if any.
>
> V2:
> I've taken on this series as there isn't any response from Jisheng. No
> significant changes other than build fixes.
> - Fixes build breakage in patch 3 to do with not having used 'goto' keywo=
rd.
> - Fixes build breakage in patch 4 on 32bit not having delcared __ptr in t=
he
>   macro.
>
> V3:
> Significant commit message rewrites.
>  - Corrected the justification for patch 2
>  - Better explained/justified patches 3 and 4
> Minor code changes for legibility and more comments.
>
> Jisheng Zhang (4):
>   riscv: implement user_access_begin() and families
>   riscv: uaccess: use input constraints for ptr of __put_user()
>   riscv: uaccess: use 'asm goto' for put_user()
>   riscv: uaccess: use 'asm_goto_output' for get_user()
>
>  arch/riscv/include/asm/uaccess.h | 205 +++++++++++++++++++++++--------
>  1 file changed, 152 insertions(+), 53 deletions(-)
>
> --
> 2.34.1
>
>

