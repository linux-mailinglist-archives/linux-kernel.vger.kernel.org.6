Return-Path: <linux-kernel+bounces-539044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966D6A4A024
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0937A2CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494FF1F099B;
	Fri, 28 Feb 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyj8r+4D"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D818C011
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763204; cv=none; b=da+j857/yJMBiSlUDAeCd5PnbePm6UqbmJqsJ2Sxt4SqQDsqpphqn9f/QI+lLsarr55IYpYpbY35h+WYSkXO+bQKQkTRGH1OLH/bglwgmlLSgO1TU1hcZFvq/jANxGPIOdK78EIiK3axipuTPWK4UeiQINtk/YvDMQWth3noqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763204; c=relaxed/simple;
	bh=lIWeH3Tboy6HGMoULxi8k18XVvdLTbiErv9XRPiEyeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5PemvEBoIvrgujVGGolIetEAwaRGtU0HkzLLRGK36FvgshjLhl8OOeUbjZqojk5iSfyzHGngueqrf9jQy2T+K6amCq9YmESjO6xsuObZDgvgsDkY4zZ5ER+reyNHHvy0VLrkPacVlQZtWCybVX6jJsIPgspCdhxywY6+NIOAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyj8r+4D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22185cddbffso62365425ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740763202; x=1741368002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VET5eArBu+43r67oe2DJk0w/RikzXdTiG7eAzr9StgI=;
        b=Uyj8r+4Duj3eP41C7pkEsVGaKxWuo0DOrwnn98ItOhxbNuYkSfNuv9oyBbszvbIBd+
         3EpbJ19ut4H91Y/h5C5D+DQkUBgheOFRdGLqPND49mhtvpDXPrdVyKEOLh5c2XnJtqlS
         NefuC3qKWXc2r4M5RiWJ+fQpnHSmxAKlOp2+2ezF8+MaeBp/q8Xj92oKConKTGhYKMAr
         FqLDIyvrxsUEqsZM8EM62ADRrvWktfvH2jDP8Xy4y3Bc8KFK/u/liYRQph0Z7w3qElJx
         G8/Roar2CX9/x75H5YNb62g3EhFVUlNxGQBfAshwRfoE4/pa59dgHRgKQngKIJ0FhLPr
         7QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740763202; x=1741368002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VET5eArBu+43r67oe2DJk0w/RikzXdTiG7eAzr9StgI=;
        b=ivyqZODPZLib5V6SE+uyIg7vjyXlhrH1th92xuYj+VUjVpj4Tq+cbYK3FyyZCAyrRG
         SGSFifbNprUKQ+HwOOwFenpTSJGaX9Byq0Uq46nHMNihNnHSLicUo+farMpzga3+aCcE
         QUXxiCUDlGqxq7HR/qZwpE/+tvP36/RBa4l80AOBRu3KO80OSWtL+V/G//isfkJ6ZThC
         0cLK93SjdH5aWl/gW79uTv7sIIAWacHgrjy2iMU9LoAfQkmHXL59l1HECPg742gXWJJI
         iqi/nmIox1S99wd/rWq6XlhMaRCn3C+7DJdZtechq4WtG3xpyOD6nx/tCIKi1TqZx6pc
         yrDg==
X-Gm-Message-State: AOJu0Yz4ta2g2WGMq2LDQgkZwcZ8CLQu+ezYk+3yZAKkYsZk9hmkEEdK
	5qXWbLl2YmgI7L1A0S0WQEr8ByyAReuhiqBtT1cICJd3qiKLHb733aDWgwr/EA7CROLK7V4udmO
	qVIdzk8Jt2dpPjur/dJZqlaLl48A4Ug==
X-Gm-Gg: ASbGncv705WBz2Zf/Mxkvj0efSBEjWLYGKVnTw5fY2WWzDfMj054bmFFlJdgJijjLFU
	e5xiBIKI2JQc46AU3DqhXsalvXInemvnK3ecg3G1y080zc181P0DvdOf3xzkVikFK4VoqihJQom
	bRYLlc4bGVc+oMvTIKDVgUWwY=
X-Google-Smtp-Source: AGHT+IHJ4/GOLRYcFw2Ss7ass/jeDGaA8yDr4x2SmuOvxIMwiU92+bAaNgF3dBw9uKkeaVtC91FBWypHD++GixJfpfU=
X-Received: by 2002:a05:6a00:1310:b0:725:41c4:dbc7 with SMTP id
 d2e1a72fcca58-734ac385a52mr7858063b3a.4.1740763202459; Fri, 28 Feb 2025
 09:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227195302.1667654-1-brgerst@gmail.com>
In-Reply-To: <20250227195302.1667654-1-brgerst@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 09:19:50 -0800
X-Gm-Features: AQ5f1JoF4dp3S515kJ-LZ8rQYAXYUw-YyJz9Yr5ILyybg6aqPISjFDT8gbdxyTg
Message-ID: <CAEf4BzZt486SUMQq2DwnRX7n_XS9Rd1KYqMTFxg=6=QRZf=-xA@mail.gmail.com>
Subject: Re: [PATCH -tip 1/1] x86/bpf: Fix BPF percpu accesses
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:53=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> Due to commit 9d7de2aa8b41 ("Use relative percpu offsets"), percpu
> addresses went from positive offsets from the GSBASE to negative kernel
> virtual addresses.  The BPF verifier has an optimization for x86-64 that
> loads the address of cpu_number into a register, but was only doing a
> 32-bit load which truncates negative addresses.  Change it to a 64-bit
> load so that the address is properly sign-extended.
>
> Fixes: 9d7de2aa8b41 ("Use relative percpu offsets")
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 60611df77957..f4859516b190 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21707,7 +21707,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                          * way, it's fine to back out this inlining logic
>                          */
>  #ifdef CONFIG_SMP
> -                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);
> +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);

wouldn't you need to at least drop the (u32) cast? Otherwise what's
really the point?

>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
>                         cnt =3D 3;
> --
> 2.48.1
>

