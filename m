Return-Path: <linux-kernel+bounces-440948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7219EC6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E91169DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D871D799C;
	Wed, 11 Dec 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOjM1Ndw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B471D63FF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905162; cv=none; b=Pw81VkmWrajPv58gPTxeF3xnrn/zpF3WRIdQN8aCL5PPYXdRpOozUuMO7VyI5IBBkYCNnsfpWLreO5A0HjjzCJ3uE1HcERdl9OQXYwgBf//1NGb+Bl/JcUJ2nADiyg1oGUUdseOe/10j6iMBq76bzpcsxqyV06p1wesTmgFYb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905162; c=relaxed/simple;
	bh=kK/MJU/Q9OBs7J/to7TFQAxF5400ypJLjs8WUycDgxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du69L9UWOVqEM/nfgAomQKH9s+mlgvc0kO9GLnZOjqW1zbdIMaiDnF4DpN0Pa2VgsHfWSuMicCqQc/8H+adMcErHlAj41N//XNKMo3es2R9e/HA3HHyuNQbuvsHLASMqwZ3iTRDEmCgMaNqqKWEff3w0dWEPC70pjMBr1wRxKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOjM1Ndw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733905159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df7gzbgWME26R9rpVKPWThUShTeBvSI36yYMQF09Oe4=;
	b=DOjM1NdwF+VQL8bM4GQbAhAFeoLtyINdWeRlWQj62G08Zuogn/jlwYP0PqlUzXaN0/hkj3
	lOuW3lDfVdAuuVDsG1PxJgD/XWJpEdLyLh7YrJA02lE2DfN6Ay6aWYF3WrLk7axaj3H/do
	J8N28bC5TjZYwmy7ZuwBrD53Gm2YJeU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-pYzKto3tMCiEDRjWTO27vA-1; Wed, 11 Dec 2024 03:19:16 -0500
X-MC-Unique: pYzKto3tMCiEDRjWTO27vA-1
X-Mimecast-MFC-AGG-ID: pYzKto3tMCiEDRjWTO27vA
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e38dbc5d05bso11350088276.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905155; x=1734509955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Df7gzbgWME26R9rpVKPWThUShTeBvSI36yYMQF09Oe4=;
        b=Hja9xdTyuI5OcLXsVkVHCaNeHET+z9r/sRACH0NlSvoYSL9mJb5vDTBfs+fFlmKJGl
         sgAk2akIu/OvgsfH/lqmINNTkSlyAWeWaKdRYTydI7UIsBsqKYLt8ra2d2WLGgJvhTbw
         9h/YKQqXYTfPXwcDqME/nj/uz7nEz1PNET+dxHRx+LcJNyDZPdTo9iNCYnl0DLyimU2p
         eb0hNM8kBsg3btxjAAKum5nYkH/Z0+hDkuGKZ85qvbiU5Z521rJ7DRJo+tkmAYrYfGhE
         YDOlYa1kGPq2JNCMAcOUQ12hVtNUO/0eRvu+v4nkN09qF7luOD59VRwepZhnzeKXHTH5
         8Teg==
X-Forwarded-Encrypted: i=1; AJvYcCVfoYUW+y0kQAkX0PqMIBtMQ8fu3fbQgANIfC8tPu98xexHztQq2sRX3sxxqNoiMfTmsri/YNgl37Wr/QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Nl2TaBeW24N0vl5kurv0wGlN/l/2ui9/i7GMPshlK6a9poPn
	F8xmIewI81wbsSoDWnzGesWr/TKftXdaa9bcpUaST6RO63vfbBPH6AOhxDPFPZnZH6MZSjmjfAj
	OBHQ6cwEvdExrYVAaFC0TMoNvL5eOgu9GhfI3DkAe9d7ahQo5WHj9tjMOyvc6jF7bSoau39HZL9
	d2/c8Rlen1mTmTOrL3b3ARpK8AA/n8XdsxM5Ry
X-Gm-Gg: ASbGncsrrL1bNQX1WiT4/TBNOFRw3ENMCkNFeY/W5XFe1yrtKB/J3FcqtAKumaqEljW
	gy61peN+ssT1q47FVP2UecoJ5f/RXipyR7g==
X-Received: by 2002:a05:6902:11c9:b0:e3c:8df7:4cdb with SMTP id 3f1490d57ef6-e3c8e67b517mr2108664276.32.1733905155737;
        Wed, 11 Dec 2024 00:19:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOSTE2WV/b1b9f1XmObRSLBn8v86IpzkAt8gBR0gdzUUukOkFtjbiPnJpDos/gaChbfGYffrt6LB23Z0mJj7U=
X-Received: by 2002:a05:6902:11c9:b0:e3c:8df7:4cdb with SMTP id
 3f1490d57ef6-e3c8e67b517mr2108649276.32.1733905155363; Wed, 11 Dec 2024
 00:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
In-Reply-To: <20241210150413.GI1888283@ziepe.ca>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 11 Dec 2024 09:19:04 +0100
Message-ID: <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, 
	x86@kernel.org, Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:04=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Dec 10, 2024 at 09:55:41AM -0500, James Bottomley wrote:
> > On Tue, 2024-12-10 at 10:40 -0400, Jason Gunthorpe wrote:
> > > On Tue, Dec 10, 2024 at 03:34:23PM +0100, Stefano Garzarella wrote:
> > >
> > > > +               if (platform_device_add_data(&tpm_device, &pops,
> > > > sizeof(pops)))
> > > > +                       return -ENODEV;
> > > > +               if (platform_device_register(&tpm_device))
> > > > +                       return -ENODEV;
> > >
> > > This seems like an old fashioned way to instantiate a device. Why do
> > > this? Just put the TPM driver here and forget about pops? Simple tpm
> > > drivers are not very complex.
> >
> > This driver may be for the AMD SEV SVSM vTPM module, but there are
> > other platforms where there's an internal vTPM which might be contacted
> > via a platform specific enlightenment (Intel SNP and Microsoft
> > OpenHCL).
>
> Sure, that's what TPM drivers are for, give those platforms TPM drivers
> too.
>
> Why put a mini driver hidden under an already mini driver?
>
> > This separation of the platform device from the contact
> > mechanism is designed to eliminate the duplication of having a platform
> > device within each implementation and to make any bugs in the mssim
> > protocol centrally fixable (every vTPM currently speaks this).
>
> That makes sense, but that isn't really what I see in this series?
>
> Patch one just has tpm_class_ops send() invoke pops sendrcv() after
> re-arranging the arguments?
>
> It looks to me like there would be mert in adding a new op to
> tpm_class_ops for the send/recv type operating mode and have the core
> code manage the buffer singleton (is a global static even *correct*??)
>
> After that, there is no meaningful shared code here, and maybe the
> TPM_CHIP_FLAG_IRQ hack can be avoided too.

IIUC you are proposing the following steps:
- extend tpm_class_ops to add a new send_recv() op and use it in
tpm_try_transmit()
- call the code in tpm_platform_probe() directly in sev

This would remove the intermediate driver, but at this point is it
worth keeping tpm_platform_send() and tpm_platform_recv() in a header
or module, since these are not related to sev, but to MSSIM?

As James mentioned, other platforms may want to reuse it.

Thanks,
Stefano

>
> Simply call tpm_chip_alloc/register from the sev code directly and
> provide an op that does the send/recv. Let the tpm core code deal with
> everything else. It is much cleaner than platform devices and driver
> data..


