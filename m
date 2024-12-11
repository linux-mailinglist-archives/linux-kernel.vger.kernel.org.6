Return-Path: <linux-kernel+bounces-441709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4239ED2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F032814EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965331DDC3A;
	Wed, 11 Dec 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+XP+nUw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBA1D63CA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936165; cv=none; b=m3yiNuEUgAHPlVULqCPFPri299W0sRv2RGaQ6wBDQXWpg1UNj66HGodWD4Vn0gUH57xKiJRo68jF4UAqlkQfQopvj9jyqZ7txTB3Pb768CNpPknIVuVKDwivwm5wO9w7E1H/5yESXZNdCdkyDqkC0/sx2zVbKAQfF8ahwZxhVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936165; c=relaxed/simple;
	bh=zWHe5m7AniP5NqIBCK2sx2UfrdBjUDZpM6IE2aIbD2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScDpt/mxFBC9SYjCqWL9B6ZDyPU1QpAVD1H0ccIA/gGnlY7+mB84NX/n/128474AZu3LUROLLD3+NfhMIDE6BAjJaqe/RY/m9vigxhfICDTvm4htzM/SnNnVMB8xe/wM3XrvybFB6AatOtlzaNf+odbFHyA6f8R7vagVpxsOvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+XP+nUw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733936163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogy79Ehv4IBlVwhQwJCnxs68QdXDU89Tk1u2sMU6U2Y=;
	b=Y+XP+nUwKejVs/8Y2M8tpqHwY0vPUtDf7NisDAlzxuTcBoidqu9d8JnH/a3ymrB8vgKHHK
	ztAmF0IZS+dYPacg19+zHaG4JCRlzRyuumSzj0esTTEucxdXeEYlz74E0EsZlaHEjjO8yd
	9QyXLh5hzc0MMcZgZB1/ya5g9yqqGOw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-taLjk4NAMsyx4Z63Zi06dA-1; Wed, 11 Dec 2024 11:56:02 -0500
X-MC-Unique: taLjk4NAMsyx4Z63Zi06dA-1
X-Mimecast-MFC-AGG-ID: taLjk4NAMsyx4Z63Zi06dA
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6effbb8c9ffso51028507b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936161; x=1734540961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogy79Ehv4IBlVwhQwJCnxs68QdXDU89Tk1u2sMU6U2Y=;
        b=fj3UoSK7rZFOjRFgBEld4EErUZPNZQdP4gKEsiEpEzJBQoeWxj8JatugKJN89XQaf/
         Z1dVNPvm91hhU1LWTGgTYVkbboAVuc2AcCZJmPtaibZ2NHKdohxu9EfAQr0uyOdnraEc
         P6qa4UWUBVwVnikm+XkZL7HtPF7QdGaRR0V6aEzzLweBh4PL/Mai6yN2gYZYuu6OzD6j
         j5MiWWbxj58tVKTfRqhTFMduNqqt5vgRSBAEkFPo7lfkO528NWifpYSzDFTd9UjGe5Gj
         eMKtXOEz1MVYkmmFUtOK9+Wzn//XU4FWVi7MUAyDIyzPhcrtXXnPGEBnnPrOFbATbecy
         I2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVzcM7a8UolvXkZ8DLzOKEJQLmPvC8QdC5W3Cd/gUVD7SN3ZMxcys6xKTxNBRU+pF7nv+9TK2VMl1REn54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00IXmgpO23t2PWx/8nnrkmVk93BxF10dXdIDDKnavLL2ZgFDu
	eToT5hG7FTUbtqoONAwyBh8qHshLn3aAi9zvBX7sS0Qur8JW2kuPgsICkoaTNHTtM667v8XK8s5
	yQ1M9L+85N0NYLcsYsc+PBjwp8ATzQEwvc0H2QTeQU/BH2h3+POBBgR2WCQpIguS0xKaEonr+Xa
	/I4R6u+QYAcETiXqDEDoWY28XS7IB05D0m4G7c
X-Gm-Gg: ASbGncuxPm5TDfTdPlGrDEhwtmKYFm2kEbnA8WCIHQ8pDsnVoYj8amIK/Qsjn4Sl8Hl
	CfT4BEKjiRzFKsbHr4UrLaRtZWgzexDyFCQ==
X-Received: by 2002:a05:690c:6112:b0:6ef:522a:1c28 with SMTP id 00721157ae682-6f19e85f643mr2789677b3.35.1733936161589;
        Wed, 11 Dec 2024 08:56:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYbotFlEwV4sK4ywFMOqX+paW36g080UIMfoKoScxUSJrCf7vtKNkAJL0n2QmxoNxSc4ETRNmaLswGLGxR1/M=
X-Received: by 2002:a05:690c:6112:b0:6ef:522a:1c28 with SMTP id
 00721157ae682-6f19e85f643mr2789247b3.35.1733936161221; Wed, 11 Dec 2024
 08:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <f8c6c1e0-a42d-6fa6-a10e-925592d7992f@amd.com>
In-Reply-To: <f8c6c1e0-a42d-6fa6-a10e-925592d7992f@amd.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 11 Dec 2024 17:55:49 +0100
Message-ID: <CAGxU2F4EG_uAcSbdjroW=sUo5yu6zQw8yJ4R_b+zxX7Sk-bDZg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:31=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 12/10/24 08:34, Stefano Garzarella wrote:
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> >
> > If the SNP boot has a SVSM, probe for the vTPM device by sending a
> > SVSM_VTPM_QUERY call (function 8). The SVSM will return a bitmap with
> > the TPM_SEND_COMMAND bit set only if the vTPM is present and it is able
> > to handle TPM commands at runtime.
> >
> > If a vTPM is found, register a platform device as "platform:tpm" so it
> > can be attached to the tpm_platform.c driver.
> >
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > [CC] Used SVSM_VTPM_QUERY to probe the TPM
> > Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > [SG] Code adjusted with some changes introduced in 6.11
> > [SG] Used macro for SVSM_VTPM_CALL
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  arch/x86/coco/sev/core.c | 64 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > index c5b0148b8c0a..ec0153fddc9e 100644
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/efi.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/tpm_platform.h>
> >  #include <linux/io.h>
> >  #include <linux/psp-sev.h>
> >  #include <linux/dmi.h>
> > @@ -2578,6 +2579,51 @@ static struct platform_device sev_guest_device =
=3D {
> >       .id             =3D -1,
> >  };
> >
> > +static struct platform_device tpm_device =3D {
> > +     .name           =3D "tpm",
> > +     .id             =3D -1,
> > +};
> > +
> > +static int snp_issue_svsm_vtpm_send_command(u8 *buffer)
> > +{
> > +     struct svsm_call call =3D {};
> > +
> > +     call.caa =3D svsm_get_caa();
> > +     call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> > +     call.rcx =3D __pa(buffer);
> > +
> > +     return svsm_perform_call_protocol(&call);
> > +}
> > +
> > +static bool is_svsm_vtpm_send_command_supported(void)
> > +{
> > +     struct svsm_call call =3D {};
> > +     u64 send_cmd_mask =3D 0;
> > +     u64 platform_cmds;
> > +     u64 features;
> > +     int ret;
> > +
> > +     call.caa =3D svsm_get_caa();
> > +     call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> > +
> > +     ret =3D svsm_perform_call_protocol(&call);
> > +
> > +     if (ret !=3D SVSM_SUCCESS)
> > +             return false;
> > +
> > +     features =3D call.rdx_out;
> > +     platform_cmds =3D call.rcx_out;
> > +
> > +     /* No feature supported, it must be zero */
> > +     if (features)
> > +             return false;
>
> I think this check should be removed. The SVSM currently returns all
> zeroes for the features to allow for future support. If a new feature is
> added in the future, this then allows a driver that supports that
> feature to operate with a version of an SVSM that doesn't have that
> feature implemented. It also allows a version of the driver that doesn't
> know about that feature to work with an SVSM that has that feature.

I couldn't find much in the specification, but is a feature considered
additive only?

Let me explain, since there's no negotiation, the driver can't disable
features, so if these are just additive, it's perfectly fine to remove
this check, but if these can change the behavior of the device, then
it's risky.

I'll give an example, let's say a future version of TCG TPM changes
the format of requests for whatever reason, I guess in that case we
could use a feature to tell the driver to use the new format. What
happens if the driver is old and doesn't support it?

Maybe in this case we can define a new supported command, so if we are
sure that the features are just additive, we can remove this check.

>
> A feature added to the vTPM shouldn't alter the behavior of something
> that isn't using or understands that feature.

Okay, so this confirms that features are only additive.
BTW it wasn't perfectly clear from the specification, so if it can be
added it would be better IMHO.

>
> > +
> > +     /* TPM_SEND_COMMAND - platform command 8 */
> > +     send_cmd_mask =3D 1 << 8;
> > +
> > +     return (platform_cmds & send_cmd_mask) =3D=3D send_cmd_mask;
> > +}
> > +
> >  static int __init snp_init_platform_device(void)
> >  {
> >       struct sev_guest_platform_data data;
> > @@ -2593,6 +2639,24 @@ static int __init snp_init_platform_device(void)
> >               return -ENODEV;
> >
> >       pr_info("SNP guest platform device initialized.\n");
> > +
> > +     /*
> > +      * The VTPM device is available only if we have a SVSM and
> > +      * its VTPM supports the TPM_SEND_COMMAND platform command
>
> s/VTPM/vTPM/g

I'll fix it!

Thanks for the review,
Stefano


