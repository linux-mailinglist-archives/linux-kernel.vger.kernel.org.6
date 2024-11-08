Return-Path: <linux-kernel+bounces-402428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A49C2763
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C9F1F22321
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB620B806;
	Fri,  8 Nov 2024 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRkFtVkY"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546020B803
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104013; cv=none; b=YEvyBhnJ8hWqISGhJPz4a8LSH/FhA/ZojJah0PR1jfjV58JEWWVJjsZeyzlzDkULSLLOLyjjRt3NZ3YqLynuZ1notige4MwictOE3qiUCPiQQ4nAyIsqfgwcsSLlwRYJFOT06S1/8aw71zubgp/7CoPfXprVAbJR72i6H0147xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104013; c=relaxed/simple;
	bh=ikCgVYAtTIEdmp1kK+1Azwf7P/QUizVefMuASSNdAIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+dmNeISfjT4P6iXmazKdmdmNohZgzbtd4tUtOd/yK2FNc42Cw0p2FcISDBFqw/JaV2pqvDXbzlT2QbC4rVDznXl+79BhU//vzNKqfvIZ86/ebPIkk7JSkI0ZqVsNRTDetWJkMKEAqUWd+hQk0JIoNi/B7xJO7YM5qEjPvWSLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRkFtVkY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso3497203a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731104010; x=1731708810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOfw7YpH370Zx1QaWqZUGVYJAXKMxoYRsgHinQRISWo=;
        b=MRkFtVkYHH3QxJMAgZrLU2OYn57DGm3AFCI1mcIkOSMJ07F96CRZ5YsaRfVBL1uYQ/
         pXv3djzkoV1AjMypRZ7BlN/tBjCOGOFAeaHTnGGpytuOreAUvpdeQRqKILYwnRQlQlmz
         oQD0ry4/DVirXB5jWfzVCNHHISOGnKwkr7DpahoW1xkcvyN4sOxGLBtRGsyvhF+8AGRq
         CBkJT1wkkxQGc4+0qg/c8qGEO1ATwv/cvO2Kp+cCewwsXukaHk83QJLOSRG00vyJFoT4
         bblZYRz1H/Fka6RB3b+Oz80uPHA3xoghPx/4akQGxRZaNUYH0uRvw0pDr4yV8GCGuG5/
         k/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731104010; x=1731708810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOfw7YpH370Zx1QaWqZUGVYJAXKMxoYRsgHinQRISWo=;
        b=A8R/sadX6kXspmRWgaMjiL97zc3UobvpNMc98Q2UzS3E3eT//KjQ8pi6e9vdHv6HBC
         NdC12kgX+NOKhgPPq9eKXM5Dj2LW1Ra+evmZ9zCcTTBTMCmofioIYc7G5KVn1QQ1zOqG
         kBxfE18yRyjjOXD5r+eIIlbT6VZi9fliRAJdFM0anqBb5erDp3CXrYyCMTjAt3M9M7m9
         OjukyzjL1prgvG6BQ0cUvoDcBUtEIBm/Ij6Spgh1j0IyIXdvrRbzpxe1ApKMl97Wzgz+
         C4dwfj/sTRO8g1rkq+xeP1UfF/Tf6iyN9ZccTWZF06JWzin/icnPeJaV/vE7Jj1BzL0+
         Jfzg==
X-Gm-Message-State: AOJu0YzQtZeWfb5OU2yrz35XzkIt5gnBd/hLkDGyMcoHsmf0A2Y8NP6o
	pfnFmAnQBW1Khsj4HSENM+QUnrqm5Wv4hNwjrHWMLkYVte7AUi7T1tLB50Rk2F5JQ3eScVGjmoD
	ahHDANb0hns+uLBFvehyjuj/UHCJL1+GZmEcN
X-Google-Smtp-Source: AGHT+IFhcXVJlkiYHUMpF/vhtrTeeySy0abkep3ztaxdn2fr4cbguFSFdKc5xYVAtXJHxI4cPorFAk1Ncayz4PsKpLE=
X-Received: by 2002:a17:907:9603:b0:a9e:b281:a212 with SMTP id
 a640c23a62f3a-a9ef00100a8mr435785766b.51.1731104009663; Fri, 08 Nov 2024
 14:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
 <20241107232457.4059785-5-dionnaglaze@google.com> <6642c244-3360-9347-3836-59c5cda5834f@amd.com>
In-Reply-To: <6642c244-3360-9347-3836-59c5cda5834f@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 8 Nov 2024 14:13:18 -0800
Message-ID: <CAAH4kHYWCaE+s_-rzDS3YHy2yMPj=d=64bZHoFSpDxzJnDVL6g@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] crypto: ccp: Fix uapi definitions of PSP errors
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Michael Roth <michael.roth@amd.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, linux-coco@lists.linux.dev, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, stable@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:15=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.co=
m> wrote:
>
> On 11/7/24 17:24, Dionna Glaze wrote:
> > Additions to the error enum after the explicit 0x27 setting for
> > SEV_RET_INVALID_KEY leads to incorrect value assignments.
> >
> > Use explicit values to match the manufacturer specifications more
> > clearly.
> >
> > Fixes: 3a45dc2b419e ("crypto: ccp: Define the SEV-SNP commands")
> >
> > CC: Sean Christopherson <seanjc@google.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Borislav Petkov <bp@alien8.de>
> > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: Ashish Kalra <ashish.kalra@amd.com>
> > CC: Tom Lendacky <thomas.lendacky@amd.com>
> > CC: John Allen <john.allen@amd.com>
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: Michael Roth <michael.roth@amd.com>
> > CC: Luis Chamberlain <mcgrof@kernel.org>
> > CC: Russ Weight <russ.weight@linux.dev>
> > CC: Danilo Krummrich <dakr@redhat.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: "Rafael J. Wysocki" <rafael@kernel.org>
> > CC: Tianfei zhang <tianfei.zhang@intel.com>
> > CC: Alexey Kardashevskiy <aik@amd.com>
> > CC: stable@vger.kernel.org
> >
> > From: Alexey Kardashevskiy <aik@amd.com>
>
> It looks like you used the patch command to apply Alexey's patch, which
> will end up making you the author.
>
> You'll need to use git to make Alexey the author or use git to import the
> patch from Alexey. Then you would just have Alexey's signed off followed
> by yours as you have below without having to specify the From: in the
> commit message.
>

Ah, okay. Amended with --author=3D"Alexey Kardashevskiy <aik@amd.com>"


> Thanks,
> Tom
>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> > ---
> >  include/uapi/linux/psp-sev.h | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.=
h
> > index 832c15d9155bd..eeb20dfb1fdaa 100644
> > --- a/include/uapi/linux/psp-sev.h
> > +++ b/include/uapi/linux/psp-sev.h
> > @@ -73,13 +73,20 @@ typedef enum {
> >       SEV_RET_INVALID_PARAM,
> >       SEV_RET_RESOURCE_LIMIT,
> >       SEV_RET_SECURE_DATA_INVALID,
> > -     SEV_RET_INVALID_KEY =3D 0x27,
> > -     SEV_RET_INVALID_PAGE_SIZE,
> > -     SEV_RET_INVALID_PAGE_STATE,
> > -     SEV_RET_INVALID_MDATA_ENTRY,
> > -     SEV_RET_INVALID_PAGE_OWNER,
> > -     SEV_RET_INVALID_PAGE_AEAD_OFLOW,
> > -     SEV_RET_RMP_INIT_REQUIRED,
> > +     SEV_RET_INVALID_PAGE_SIZE          =3D 0x0019,
> > +     SEV_RET_INVALID_PAGE_STATE         =3D 0x001A,
> > +     SEV_RET_INVALID_MDATA_ENTRY        =3D 0x001B,
> > +     SEV_RET_INVALID_PAGE_OWNER         =3D 0x001C,
> > +     SEV_RET_AEAD_OFLOW                 =3D 0x001D,
> > +     SEV_RET_EXIT_RING_BUFFER           =3D 0x001F,
> > +     SEV_RET_RMP_INIT_REQUIRED          =3D 0x0020,
> > +     SEV_RET_BAD_SVN                    =3D 0x0021,
> > +     SEV_RET_BAD_VERSION                =3D 0x0022,
> > +     SEV_RET_SHUTDOWN_REQUIRED          =3D 0x0023,
> > +     SEV_RET_UPDATE_FAILED              =3D 0x0024,
> > +     SEV_RET_RESTORE_REQUIRED           =3D 0x0025,
> > +     SEV_RET_RMP_INITIALIZATION_FAILED  =3D 0x0026,
> > +     SEV_RET_INVALID_KEY                =3D 0x0027,
> >       SEV_RET_MAX,
> >  } sev_ret_code;
> >



--
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

