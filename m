Return-Path: <linux-kernel+bounces-524279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D62A3E161
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA15177BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1D20C034;
	Thu, 20 Feb 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtgqodyM"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96261FF60B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070064; cv=none; b=P1ADBXN1o9PM+EbDBZ4w/7e3J0AwUyiF1F/3VX5TodVmoqZow44i7MLd4kBGCUTZ7HjXOwt8o81rpyJszcypKRDRBhyX9UC6vCpW8FPjKLbTyFgXX2zFxu1jyua/pAnaOF5cTUFNvHf99ev5J6AW8onFWM+xx2b6B7cozTIzfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070064; c=relaxed/simple;
	bh=07JJww02mJEeGAIuugM++K4ebk2f0Zd1D+gq+CAzgrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyVtf7S3sEehE9bH038ZTVozb3zZgPRy/205I+5RWo5wD/NBlmemQ1UvfLIPb3Hyvuqa3QcvpmU9TZ7SQ2Wnx4rRxZywlTDP+s1hZeSWWW03dAy8ciVb5ePs+MFKSc5/6LXlwXBpaYWbWUrI3typOdfBjc70XKWqsKeE5k9qJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtgqodyM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb81285d33so240756266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740070061; x=1740674861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMCL0K+C4GnoACxiUHOKxAWwwUOoQfv8+sE0BWNTm14=;
        b=NtgqodyMEgtiiI68uGzkHKoibqil6IMmY3XQ5cackqnjOxGewdVR2v6F/l/Rd7tI42
         J59sGfa6dM/Lefk3WbzLChH7Hex6MxgwKeZpaVesuMKmN48dT9wS3UI4l86F3R9Y/hlU
         Zuzo5P57FRHQEptWwP+I3Sp42ZU9rpcVz1ceXbIS1de+3ZVeYxmNJDQNGglsgozNz2jK
         JWyyb2Ma6F73s/y135qNmlp9ci+j0B2HgNuLkaZPaQCM7GmRICMDcWGmJ5v+p9Aram0X
         J9YxNpc3pefG/CBXAqam+t6YgXFk5LOAyCKwd9GIi/ZaB1efANDIO1puy1LXDYZUvoU0
         yDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070061; x=1740674861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMCL0K+C4GnoACxiUHOKxAWwwUOoQfv8+sE0BWNTm14=;
        b=uE8IufHFAKvnWK6mmB2ovZo1sP4+SRTinw6s7mqLAoIXgijXd3NG4D3irz+3Vkcfn3
         axvIZ3i7A5S+NFh6sGezXIRmseRzBPDeP7TwWQY+bkgf8+PqV24Y6zP/285bSfSdZAMx
         0hR0eOysl5PXRh+1mXel5Gk2UYXKgNBGgFigKcIiFswNWVk+XaV4VABt1oumvYC9XU7l
         hzvqkH0d7LIOc82BkzK1SynoBUF10P9bHRU6XXMtVQq9lIhV4vprKbAP/nkOIxA7zVik
         elorM6P6qQEV8Bo+UgdXTZ5GxvjtZPUu9HAgHO3Pq9CkjGywaIxJKPaJ+Zf8NhUb2Vvz
         KVjA==
X-Forwarded-Encrypted: i=1; AJvYcCVu60ePvBn90Ye7oWpogQnpwZVH309svPJecfhi9GsZXO2TGk2/9uIh5u3459MJEUgdLoxw/+b/Gdr1UxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjogamYdCuNanu5lZ7WLYvOVjSLEBbCNahBzpjoZPx/6Fkeg+
	N4Eey060follxGvANfuEhy1RUvB3YdzM3T3NkTu8jJ1NyrLCn4Zy8cNPv57j3VXLm8armrHYvWj
	2qp2tz3Efl8nVX1pySYw7O0HG8LJm+29/ECEa
X-Gm-Gg: ASbGnctKdoG082ffGnOIXYnn04GD4sTxMHO68Oj0NZGLCiLLrnYDkcJY+pD1VMMAsP0
	nB/n9/ZTnOzwUPQMy3T6eaVmavx5yB4HOVOQQ1FvXfkOEtQXUTgW+pmcfTD6ZCG5ARneGsah0
X-Google-Smtp-Source: AGHT+IFUN190VqKAbunKFBAi3FWBdH/R347wkO7ytCt3scT9na49h+zVGgXkcRMQmFGqWpBuREc1IPIa560YC5Jlbbg=
X-Received: by 2002:a17:907:7ea0:b0:ab7:d361:11b4 with SMTP id
 a640c23a62f3a-abc099b7f3fmr3875566b.7.1740070061123; Thu, 20 Feb 2025
 08:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739997129.git.ashish.kalra@amd.com> <e13263246be91e4e0073b4c81d4d9e2fc41a6e1d.1739997129.git.ashish.kalra@amd.com>
In-Reply-To: <e13263246be91e4e0073b4c81d4d9e2fc41a6e1d.1739997129.git.ashish.kalra@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Thu, 20 Feb 2025 08:47:28 -0800
X-Gm-Features: AWEUYZlhHlxBHBWrZcmEspkPqwgF6rKQ9OpK2K5xOYbvc-va1cUZOfhJoJDPwGc
Message-ID: <CAAH4kHZsC68+QPC+y-pycM+HfsLF-f_AuW8eZm-Dqqf5meFj+w@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] crypto: ccp: Reset TMR size at SNP Shutdown
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, michael.roth@amd.com, nikunj@amd.com, 
	ardb@kernel.org, kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, 
	aik@amd.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:53=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd.com=
> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> When SEV-SNP is enabled the TMR needs to be 2MB aligned and 2MB sized,
> ensure that TMR size is reset back to default when SNP is shutdown as
> SNP initialization and shutdown as part of some SNP ioctls may leave
> TMR size modified and cause subsequent SEV only initialization to fail.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Acked-by: Dionna Glaze <dionnaglaze@google.com>

> ---
>  drivers/crypto/ccp/sev-dev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index b06f43eb18f7..be8a84ce24c7 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1751,6 +1751,9 @@ static int __sev_snp_shutdown_locked(int *error, bo=
ol panic)
>         sev->snp_initialized =3D false;
>         dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
>
> +       /* Reset TMR size back to default */
> +       sev_es_tmr_size =3D SEV_TMR_SIZE;
> +
>         return ret;
>  }
>
> --
> 2.34.1
>


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

