Return-Path: <linux-kernel+bounces-367295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BC9A0091
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56683B22726
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8E318B49F;
	Wed, 16 Oct 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wy2Ddf2u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC361171D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056380; cv=none; b=rBRdAjZO53YLmiKyT9psoaP1qTvwkE9LvO2ZqqOBnVoX/vdoJklRBTFoycHE+BaB+mIR4S+DgVzxSooe+Z/TyN5gzDq/xU9W7qS2USpW8W0FsiC2nMXrKOjiyHLpKBKMQGY/pM5FYDtjYzEw1nxZwGPBp0ZXl5rpREgm+sRgbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056380; c=relaxed/simple;
	bh=rdIG8bdON8eg0upmdIZgzqWAZ14iwo7fh0+LLx9BfdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuXuymSXgPzTtFc3Vx7PJN1rrvWON3sQC7/terDk+xL+AZs3e4tV1eAzsyj7VQvmca5k8ZrLOdDzY1BHwsdRxNBUdaN9Po5+Pq9QHaJ6I5E6scckzNOyUY+5SouqbKCx1OyY/sdhFBe7GJBETRDE/8UTquSidleKdQxl3DGTiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wy2Ddf2u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729056376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdIG8bdON8eg0upmdIZgzqWAZ14iwo7fh0+LLx9BfdA=;
	b=Wy2Ddf2uYvYdpEoanR5g5Q0TrCJ4Rb0x72KfEaM7l9fGR76UGT4XUf4k2GOgBD+fSHUeOb
	9SPZVE2VQ2cVCMngkbWoEhqc9hFivq3cGn+yiKLRhEpz9XwKHAxdOGeOJSuuts04bLKDQL
	3eyiip529MauJY2X8EKE8BQ16n4yH1A=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-txKib_-uM_yJqT2-0RK4_A-1; Wed, 16 Oct 2024 01:26:15 -0400
X-MC-Unique: txKib_-uM_yJqT2-0RK4_A-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2886d7f00f4so3797916fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729056374; x=1729661174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdIG8bdON8eg0upmdIZgzqWAZ14iwo7fh0+LLx9BfdA=;
        b=thAWPKuclakdv7yU1ohGJsKMiXkOeqGgJXN+c+KtB25j9hTVlB2FufyKlCQlAZ5jGi
         voLF/jvq0OpFHFWhe1zQic5j7dElFIC0uqUf3JFaZbRmlL0JkAGvPMCbFZsLZt3wFWZJ
         F2PjWJL/MlJRN/TMBa9J6nMSEPeHRkY+kwHt57xFbzAAi9UAM5xUidfAVLwm5zmCKAff
         yAAiQo0bwPKMkZm+PbF5YtufS/KEu2lY5ITy9GpnB75I5WmHPtKjWF0ZviXM50WmDzv/
         RywpPw9QfNpFoUKTgJkQk1rxhff1Zp7/y4KW/gVp7b9z5wT99WaZdSUAzn/adjNzrKzl
         qc7w==
X-Forwarded-Encrypted: i=1; AJvYcCUHd+YnAE/cH1UHaErUCZMV5D5kNcYMRKh7cc9AlcvoYqdqjY2I2Lt+DagFVUpSJYf5FB0NJNFO0h6w2lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrmQT3x8FIcmxJCa5c+mPcKRHxkN1U2U3o0ZdjHAKlnv2VEn9
	yGvFKwwffiXlxejBMi1yGvuGAuaBxBG1UoWoXW0eMw9/S8rWYNPr/xGbCr4YAYnnlF4mXDWM9uW
	I0bwQuJPsiHVjEWlhBETcXnnJp8d5mN10DQ86rXAbbeZiUAP8zPu3UVbdpbeISeNyVJtzhT6T/8
	pTZboSujv3VW8QMknBu8ylyz5sMi53PJh/Mium
X-Received: by 2002:a05:6870:3295:b0:277:eea4:a436 with SMTP id 586e51a60fabf-2886dce9923mr11714431fac.7.1729056374282;
        Tue, 15 Oct 2024 22:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHiwn4RE3PioCKXl96uz0dXLqcSvrhpM0cdTcTe9wx/x5I/zORO0z5prrIEan+L0+LNFhQwIPGrANg5wAyQEA=
X-Received: by 2002:a05:6870:3295:b0:277:eea4:a436 with SMTP id
 586e51a60fabf-2886dce9923mr11714422fac.7.1729056374017; Tue, 15 Oct 2024
 22:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072749.45006-1-alexghiti@rivosinc.com> <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
In-Reply-To: <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
From: Jason Montleon <jmontleo@redhat.com>
Date: Wed, 16 Oct 2024 01:26:02 -0400
Message-ID: <CAJD_bPLcKX+U1k60mgsB_==qrQE+jnLMXSotq3rMrH_o+FtOQQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Stuebner <heiko@sntech.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:05=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 9 Oct 2024, at 08:27, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > Early code designates the code executed when the MMU is not yet enabled=
,
> > and this comes with some limitations (see
> > Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").
> >
> > FORTIFY_SOURCE must be disabled then since it can trigger kernel panics
> > as reported in [1].
> >
> > Reported-by: Jason Montleon <jmontleo@redhat.com>
> > Closes: https://lore.kernel.org/linux-riscv/CAJD_bPJes4QhmXY5f63GHV9B9H=
FkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com/ [1]
> > Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> > Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the co=
mmand line")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Is the problem in [1] not just that the early boot path uses memcpy on
> the result of ALT_OLD_PTR, which is a wildly out-of-bounds pointer from
> the compiler=E2=80=99s perspective? If so, it would seem better to use
> unsafe_memcpy for that one call site rather than use the big
> __NO_FORTIFY hammer, surely?
>

I can add that replacing memcpy with unsafe_memcpy did also work for
me. Once it was narrowed down, this is what I originally did in order
to boot.

Jason

> Presumably the non-early path is just as bad to the compiler, but works
> because patch_text_nosync isn=E2=80=99t instrumented, so that would just =
align
> the two.
>
> Getting the implementation to not be silent on failure during early
> boot would also be a good idea, but it=E2=80=99s surely better to have
> FORTIFY_SOURCE enabled with no output for positives than disable the
> checking in the first place and risk uncaught corruption.
>
> Jess
>


