Return-Path: <linux-kernel+bounces-441537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96D89ECFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D852821E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA601D61A1;
	Wed, 11 Dec 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSUWq7fD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E01C1F34
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931526; cv=none; b=kF4+uWoRd+ZvgLdhxeOzaP44KASD+FRVGjj/zPrp2qr+dI/1xSgjNZOTKg+v/EK//WDfV0qVJSxSevSRoFaOp4vQOZ8zu6tUzJyiv9UDBzhEpGUNruXDS4ezsW+Oqyvy0pnuoAwwy+loMTs25Fkmv/PrvAyVU9MQT4RdxlgO0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931526; c=relaxed/simple;
	bh=a0hv9mFPITU2NDP0pqXzJbW7Mb2xRwyfM5fwAm1ROFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhQXe1fb25HAoyuQGHJGcoo1pOSuCsOhozb6iPcgkbahjOLipDGIUVdnZM/y3EWkSumez7qGW7Ncyd/SMUaJ2ifBQvmVlbzHQZAVcUS8RZdTVDgPZLn+YEaguQe68voDL7vK3ZORnueanQJnwi6XlgzbOoedHmwhIpe6XxXXdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSUWq7fD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733931524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0hv9mFPITU2NDP0pqXzJbW7Mb2xRwyfM5fwAm1ROFg=;
	b=MSUWq7fDHkclKlkSToV6wokgWBdmDC2OWU+Tkq9iyYVPNHd7Bocd8x7yrnKbRiPEgWK+yb
	Fm5oplioij7y9DPzmJxyiXdPTfJX2qFv9NZiFR+ozqFORBTuqOw6/dQBTmMnF0C0pmpoKg
	Yp8iDGh0xktO3UFXVLdmJaiqNyzy9Lo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-jMgcB5l-NW-hTrw_Q2Fziw-1; Wed, 11 Dec 2024 10:38:42 -0500
X-MC-Unique: jMgcB5l-NW-hTrw_Q2Fziw-1
X-Mimecast-MFC-AGG-ID: jMgcB5l-NW-hTrw_Q2Fziw
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e3c7d56aa74so2420886276.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931521; x=1734536321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0hv9mFPITU2NDP0pqXzJbW7Mb2xRwyfM5fwAm1ROFg=;
        b=DTWlajmCq+/8hFeb+MgYUeDG+JmfUfUvZgSj2TG7skkLksdoer4jtESzMb3fU6PfYK
         abxqQwkrw3eKsueBaWGXX6DFb/RfguqH6KrEfoht/DjoXN8jCikpFoVU2HsLlextDP8z
         AEVU1rpz9iEAFzXPc2FUpkl//36CHA2bnQT9Drj3Y6i1I2Q6TnHpiUH3KdOCZ6qIYQbZ
         kPHvliXW5PDjtyZ8GuaXVWoIJUSoUzMSdjH2pfij5VSfpK/a+P/67Y0QeNjkyyVhGdRb
         PTEUI+4Q24tGYfzS7/eFeEbCQKAd1jftU9gaM9Fkyd/1/c4MPB7Mhjk5LSoJk1WAAoWZ
         YQgg==
X-Forwarded-Encrypted: i=1; AJvYcCUNuN0zQRc+d3uEK6jTdo1adnzR6MEae3xIC68zz2Wsh9KGDnkVhv689pLbHD8apON7LkRqbIiGX9KSIeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwImovCdA2K7fSDSI/EJ9eTwbORNo+PxvWU2UMdaACgimw+oBsI
	+745Ao7bpqPcOcW8cveBEUeXMV9DXjjDEArz4xXX0FyRBg++NzhGL88vA9iOcLNq+pJp/4pd6UM
	OPWpKLId3JngiRw80kRLcVvzqwtabMBhuSCk/5BgNP4sOGQs6TlzRsLSmhaxdxZbvjJ72n0lXyR
	FWBfVZtEN6BdMLjGlbb5p5hVHEWYSIfZiiPe9M
X-Gm-Gg: ASbGncueh0JMx4XrOEwxlZ+Svn9nCVkF3K7QNVwUemQmEiPxOX893JfrFLtEOPTrSIs
	s5BYCixYUYrQ/3tJY+fCIKtQmrLPC2g8okA==
X-Received: by 2002:a05:6902:100b:b0:e39:95e8:31be with SMTP id 3f1490d57ef6-e3c8e4249f0mr2855080276.8.1733931521392;
        Wed, 11 Dec 2024 07:38:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE394UlHqCYe1P7sHFdWBBxDdJetIc75Ei4upOeKARHA2ACI/wc9W2mPBcu4AH1Pm2Pwz68qrAYfHGPQSHdD8g=
X-Received: by 2002:a05:6902:100b:b0:e39:95e8:31be with SMTP id
 3f1490d57ef6-e3c8e4249f0mr2855042276.8.1733931521054; Wed, 11 Dec 2024
 07:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca> <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
In-Reply-To: <20241211150048.GJ1888283@ziepe.ca>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 11 Dec 2024 16:38:29 +0100
Message-ID: <CAGxU2F5NSqMbA1Lep3+16GoZXR23q0OP8dFVVRJ6DG5sF20R3Q@mail.gmail.com>
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

On Wed, Dec 11, 2024 at 4:00=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Dec 11, 2024 at 09:19:04AM +0100, Stefano Garzarella wrote:
>
> > > After that, there is no meaningful shared code here, and maybe the
> > > TPM_CHIP_FLAG_IRQ hack can be avoided too.
> >
> > IIUC you are proposing the following steps:
> > - extend tpm_class_ops to add a new send_recv() op and use it in
> > tpm_try_transmit()
>
> Yes, that seems to be the majority of your shared code.
>
> > - call the code in tpm_platform_probe() directly in sev
>
> Yes

Thanks for confirming!

>
> > This would remove the intermediate driver, but at this point is it
> > worth keeping tpm_platform_send() and tpm_platform_recv() in a header
> > or module, since these are not related to sev, but to MSSIM?
>
> Reuse *what* exactly? These are 10 both line funtions that just call
> another function pointer. Where exactly is this common MSSIM stuff?

Except for the call to pops->sendrcv(buffer) the rest depends on how
the TCG TPM reference implementation [1] expects the request/response
to be formatted (we refer to this protocol with MSSIM).

This format doesn't depend on sev, and as James said, OpenHCL for
example will have to use the same format (e.g. buffer defined by
struct tpm_send_cmd_req, filled with TPM_SEND_COMMAND, etc.), so
basically rewrite a similar function, because it also emulates the
vTPM using the TCG TPM reference implementation.

Now, I understand it's only 10 lines of code, but that code is
strictly TCG TPM dependent, so it might make sense to avoid having to
rewrite it for every implementation where the device is emulated by
TCG TPM.

>
> Stated another way, by adding send_Recv() op to tpm_class_ops you have
> already allowed reuse of all the code in tpm_platform_send/recv().

Partially, I mean the buffer format will always be the same for all
platforms (e.g. sev, OpenHCL, etc.), but how we read/write will be
different.
That is why I was saying to create a header with helpers that create
the request/parse the response as TCG TPM expects.

Thanks,
Stefano

[1] https://github.com/TrustedComputingGroup/TPM


