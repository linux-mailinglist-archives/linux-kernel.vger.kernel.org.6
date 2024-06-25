Return-Path: <linux-kernel+bounces-229063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC7916A57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713631C2245D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C317A90F;
	Tue, 25 Jun 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lACvOxu+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573C178CC8;
	Tue, 25 Jun 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325583; cv=none; b=OIU9+Iw042WXy8Ig9i7gRO6gQFyvakeaAw1TWhM4BSycgWtflQVrdks51rY3xdqkmcN0YklTpzlcdu7e5cJEGCMFkyLjVoumIXIzBsRLEVGRvxVxijnIh5PResmVsKadQO/jcA+tqKxwJUPYYMpaYSxlsoego2aVFya3PkE0fTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325583; c=relaxed/simple;
	bh=1UiCDGgHQ5ObpSvrlGcUdzZAlv2fF8O0u+CoSyWokOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaYqtASBDGKqaaw5+zbASt7DPzBSpvSPAXJHWZI9Km5eu0zHsI/orYEMWz42z/HXvrxhRqRJM7bhXndpmlAI5oK3tRSprmFCzhgyX6RRCrxtweac6xkr78n13zBb7GrbnSYSExmU8RS2KhC0RDCVc0OoGL0NsSUHYlgXTui1g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lACvOxu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609D3C4AF18;
	Tue, 25 Jun 2024 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719325582;
	bh=1UiCDGgHQ5ObpSvrlGcUdzZAlv2fF8O0u+CoSyWokOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lACvOxu+Ix+ixThSVmq6TSefFSYMz6Kt/oC9BnAl4CpmKUw/Rt2a72TyOU8fR2XnO
	 f0OmgQxnSO0suAMc52SEEf8ieXux9bR8LYjaf8XQL8i6qP1RutXtA1DxHOcSjSGBzF
	 uAEA98Ci/Um2y6XyCbOZBr2fhNW/MHfaR2VXfkuhIuZlIdvVISUAllh3oevbyqsk66
	 qg8REQtnkCqEY5nI4IPIGqJKYqr/Vpjfs7SwAhjFweiSr5lpjCXsbu3Df0NYi2/aE2
	 Ru37Ehkpue8HFC6+1qsflglDWtNPdUxaBO6GzNYN/4xHFrHzwULYGEfLujYRFtICUH
	 rJySljONHG0UQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so17204711fa.1;
        Tue, 25 Jun 2024 07:26:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB4quNA7aNlOYjD5BJVKUDGIwNpp+iuAgsHDeMZyExMngdosQSxHq4B6RFkXeydMA6buopW30m8hn5R4rFP7Rn6hz108CHG3txwvAuAE5pwfjzpqmwrexnbC6tyZKpf9mRqstXn+VgGyqqcTa4
X-Gm-Message-State: AOJu0YzqAe+1/xEkgtweqB88ExgjCrmBK4rLXj5pVJ2qpUZ8zXhHUBl3
	Fqa4wbQOXKc4GOtqcyyvVym9HznzNgRByV42oEPgXz4FtquDtHy8rZXNOSOwjciLzwh7PF2zymJ
	euQVGwzDVZUYvB+Rr/VfNHrvIZiI=
X-Google-Smtp-Source: AGHT+IHY6mqrg5q2k7Ksffy5lOKv3VtwyAeYeBWBMKfB1TdfPAKVU073l+OGh7egFuNslbR/DdOAGGYr0MKYiAiVHcw=
X-Received: by 2002:a2e:3218:0:b0:2ec:5685:f06b with SMTP id
 38308e7fff4ca-2ec579837bamr52831631fa.27.1719325580775; Tue, 25 Jun 2024
 07:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622-md-i386-lib-test_fpu_glue-v1-1-a4e40b7b1264@quicinc.com>
In-Reply-To: <20240622-md-i386-lib-test_fpu_glue-v1-1-a4e40b7b1264@quicinc.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 25 Jun 2024 23:25:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDbq=ai0EX0BeKQg8r_mtSJ_68fL1R_ORpynX+BLh_Rw@mail.gmail.com>
Message-ID: <CAK7LNATDbq=ai0EX0BeKQg8r_mtSJ_68fL1R_ORpynX+BLh_Rw@mail.gmail.com>
Subject: Re: [PATCH] selftests/fpu: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Russell King <linux@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, WANG Xuerui <git@xen0n.name>, Will Deacon <will@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 11:55=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
>
> make allmodconfig && make W=3D1 C=3D1 now reports:


This is a boilerplate, but C=3D1 is unrelated.


W=3D1 actually prints this warning.



> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_fpu.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Fixes: 9613736d852d ("selftests/fpu: move FP code to a separate translati=
on unit")
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  lib/test_fpu_glue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
> index eef282a2715f..074f30301f29 100644
> --- a/lib/test_fpu_glue.c
> +++ b/lib/test_fpu_glue.c
> @@ -59,4 +59,5 @@ static void __exit test_fpu_exit(void)
>  module_init(test_fpu_init);
>  module_exit(test_fpu_exit);
>
> +MODULE_DESCRIPTION("Test cases for floating point operations");
>  MODULE_LICENSE("GPL");
>
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240622-md-i386-lib-test_fpu_glue-437927d4afe3
>


--=20
Best Regards
Masahiro Yamada

