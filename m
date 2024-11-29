Return-Path: <linux-kernel+bounces-417555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820F79D5597
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DA82830B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDF1D9324;
	Thu, 21 Nov 2024 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="wR4ErVwr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3161BD4EB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228968; cv=none; b=kD+xWlwL4wgmqXvBOP1AybOivWJXA2lEkSQMgVUD6+DsFxkem7vWBQo9UM6EQevckJY3S7I8/brQeqLs8gw1T8zh76bLVByhw4NnFEZ8IAbOa0kgAxIWtr/MGccHzBrX0a1DP3Th6G58NPHh0PkR46qNRjfnUUtaZEFoOB1r90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228968; c=relaxed/simple;
	bh=M8DVUXQGR6NcXFE188QjZG7fKBPLaNmu+KGvMT6oh00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yzf/ajVom/OEfMw07CHg53z1nKxTYESeiniQZEBIbgMp8nVPUZuJmDQLhyl4QbI/LakeI6y2vTmMjrH+yq2kcQa8xwXQG0Fi0yi7hms1ddVsJxCmE9QXd3Lch0J0QrDLmWKMSfABaY10Ltl3RCyGpGExQvQwHs3HOnMI3wAexII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=wR4ErVwr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso223987366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1732228965; x=1732833765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpl29WxoyNcOaT5g0KSW5/agiiklTO12tp7HkumeaXI=;
        b=wR4ErVwrSZWHysH/me/V8xUKSiEUW8QhCEer658KLg6ybrKfZHFhCRIbz4MYbRlHO/
         Z/D3nBq8/lvFIH4TeF5JyVtqekD10nV988figyGVaE8qia5dcuf7x3i0ENm1pUedtQ7y
         T8IVEORocf63jwbuPomdk/tSrYyIkREpU5CaugTZiEw3DXrhQji3dVE0fwk826TJ16Rs
         K+8RQxVpy4XMqhZ9eJqeQGIwVi7+ab7wKdO2zjlNZbqmwEjpPUNU98/nluefp+uLuFr2
         YnGuB3a4jUziDDuhitZX8cMKlyAi+pKaGySaHE5rmo39/9/8wPBgxFKhRV5Xe0U72P3n
         5afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228965; x=1732833765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpl29WxoyNcOaT5g0KSW5/agiiklTO12tp7HkumeaXI=;
        b=X0H8eQfTgHvsKmJU7XQFdrSL9hWN7uSbzfOFLiQZj2U3pFnfC/4ooPTLkLvlsV6c6h
         FAn+o8eUUwIkZ1TnwXR/kHiei1BJ1sXAw8pT8YA37DvJCqiwpZA2Q9izCNjMY5aHjWNu
         3Seq/Sdlawg7iVSkoT15miS/dSvNekbdk+S+KJOSpe4nclm2Jh5NVHCu0W1acn/BLZAx
         orxRSDDalZoGdrp8bLjsx/Pkn0gNLXjuCEKvTThMggZG9qsbi2a96OgMV0B+2MS2srTA
         VU5NmgwCxWfwPmvr5CRjxQuDBm4asNuG7TRpBtTolpDcnU9gE4ZudznJrNSMdTg9ugWk
         tLZg==
X-Forwarded-Encrypted: i=1; AJvYcCWk6WU/kyNx1v9rl6wDYOR+Tdr+GXEJvjNLCIMrr5KVCW4gWUkJu9398yfGxNUYHTQZeDEGbfyESOi3kLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo02vxiDCpNF7zQahmTHKwUxhxO0Hmm1IJaxbRQjJJedwhlM1R
	+WZnwKgCl85eOpTCxCzk3/ezGeSnmt+5CFa3GtN5J2TyJnPT3nXelDLWuUt3bNLoxzErbjev2Pc
	+tDZ+SYpjQj6bTqQ5iZYfNu2HbaiugC/hQRCt
X-Gm-Gg: ASbGncs+I1nsutJFTax1I9Qd80A8a5/uG92qEnVpdyV32aWQcY6EeVBo9XZF1LIWNrY
	aqPffKJJYaqQv5SnE8ETr91Bdv1/Blw==
X-Google-Smtp-Source: AGHT+IEJBb9KISPdLeRNueM+M6hMlDiEZBnKX/0BK3HOiT007/scaGSB3LtwJa2rfHw9qXCKhSH2k1VVwUmlKXIZfpk=
X-Received: by 2002:a17:907:1dd7:b0:a9a:8a4:e090 with SMTP id
 a640c23a62f3a-aa509bca598mr60753666b.50.1732228964782; Thu, 21 Nov 2024
 14:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
 <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
 <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
 <66fabe21-7d0d-4978-806e-9a4af3e9257a@oracle.com> <CALCETrXXsta0OdgXb5Ti87psaty7gp5WRr-w8vTuEhOLuoGyXg@mail.gmail.com>
In-Reply-To: <CALCETrXXsta0OdgXb5Ti87psaty7gp5WRr-w8vTuEhOLuoGyXg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 21 Nov 2024 14:42:32 -0800
Message-ID: <CALCETrV=PSLvDn4K6o1qoQLwTQtaPU6ESVPZTwRBJF5Pj_XJwg@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: ross.philipson@oracle.com
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:54=E2=80=AFPM Andy Lutomirski <luto@amacapital.n=
et> wrote:
>
> On Thu, Nov 21, 2024 at 12:11=E2=80=AFPM <ross.philipson@oracle.com> wrot=
e:
> >
> > On 11/18/24 12:02 PM, Andy Lutomirski wrote:
>
> > > If the vendor of an attestation-dependent thing trusts SM3 but *Linux=
*
> > > does not like SM3, then the vendor's software should not become wildl=
y
> > > insecure because Linux does not like SM3.  And, as that 2004 CVE
> > > shows, even two groups that are nominally associated with Microsoft
> > > can disagree on which banks they like, causing a vulnerability.
> >
> > Thanks everyone for all the feedback and discussions on this. I
> > understand it is important and perhaps the Linux TPM code should be
> > modified to do the extend operations differently but this seems like it
> > is outside the scope of our Secure Launch feature patch set.
>
> It's absolutely not outside the scope.  Look, this is quoted verbatim
> from your patchset (v11, but I don't think this has materially
> changed):


... I apologize -- I've misread the code.  That code is still wrong, I
think, but for an entirely different reason:

>
> +       /* Early SL code ensured there was a max count of 2 digests */
> +       for (i =3D 0; i < event->count; i++) {
> +               dptr =3D (u8 *)alg_id_field + sizeof(u16);
> +
> +               for (j =3D 0; j < tpm->nr_allocated_banks; j++) {
> +                       if (digests[j].alg_id !=3D *alg_id_field)
> +                               continue;
>
> ^^^^^^^^^^^^^^^^^^^^^ excuse me?
>
> +
> +                       switch (digests[j].alg_id) {
> +                       case TPM_ALG_SHA256:
> +                               memcpy(&digests[j].digest[0], dptr,
> +                                      SHA256_DIGEST_SIZE);
> +                               alg_id_field =3D (u16 *)((u8 *)alg_id_fie=
ld +
> +                                       SHA256_DIGEST_SIZE + sizeof(u16))=
;
> +                               break;
> +                       case TPM_ALG_SHA1:
> +                               memcpy(&digests[j].digest[0], dptr,
> +                                      SHA1_DIGEST_SIZE);
> +                               alg_id_field =3D (u16 *)((u8 *)alg_id_fie=
ld +
> +                                       SHA1_DIGEST_SIZE + sizeof(u16));
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +               }
> +       }

If we fall off the end of the loop, we never increase alg_id_field,
and subsequent iterations will malfunction.  But we apparently will
write zeros (or fail?) if we have an unsupported algorithm, because we
are asking to extend all allocated banks.  I think.  This code is
gross.  It's plausible that this whole sequence is impossible unless
something malicious is going on.

Also, and I'm sort of replying to the wrong patch here, how
trustworthy is the data that's used to populate tpm_algs in the stub?
I don't think the results will be very pretty if tpm_algs ends up
being incorrect.

