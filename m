Return-Path: <linux-kernel+bounces-269221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC3942F69
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317A1B24481
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7C1BE25D;
	Wed, 31 Jul 2024 12:52:35 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A61C1BD514;
	Wed, 31 Jul 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430355; cv=none; b=brar2EIihczayxcl+1z7Su4CTlghIhhNVTBBeyR711Q9Y+uDLUeMS8QqbI4xiE4Anta5d8uN+7CTZ2HfMtH9s5akW+kkBQPgJVaFkVuchw/5nvHGPRY7fcnpxlMNrpjx0abiUzz/DMKLpiLqfP0jt4+fMhaCzbe261amJ/5AaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430355; c=relaxed/simple;
	bh=6COqeP6R/6UfPOjPmMiluGsDLj5UU/F63qiH5apWj6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndfmRCQuqPcepedyZdKt/gQoF0KetdPDtC0aNJSJ9A0JeKXV2JT9dBRwQBaa4H1TolBCVim/OhNIIVVD563hCFxCcthyRh4LYW/LZEM4pKdbJomr61RF9ql90L0K8tVfZNWjGw/qeYlFBNx9hGztDMzit8aGQlxa1ITpln6Pl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so6094918a12.1;
        Wed, 31 Jul 2024 05:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722430351; x=1723035151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6COqeP6R/6UfPOjPmMiluGsDLj5UU/F63qiH5apWj6s=;
        b=wSMWWHfY0aqwVc9oX1NaIu82HLBAFMDb7EM5VulotLpIUH7S2W0CxvmcUchRTc9690
         BMbfnpjnvxT3NIxsJOiClNyqGoSpbER228BjiceOKSmPCgq+GzqRjVsj+f96+mG3oLcB
         wT7Uf+myyw3YNqDoa2uwKaqipVQk9cH9pzmg7HLPfHhzKe9Df/yA+qe+HC0Po7yHOJtl
         wMR7M7dTf9JX7R9JXthpaotUTTjqtBBvZ2MQXYJNet43rwAM6z5KPTqDB89p0VhBV1Hd
         uu26+mHxHmeeo0hu2qZa/FlN41QvRu8/p/F5RWpJUFjspk46lS8+rHjmtKHbtpMW/vun
         /jVA==
X-Forwarded-Encrypted: i=1; AJvYcCWKmiVFALcU3fkeCfZP5Fs/I5W+r0vZDx8hlw6gNh0PdI/z7JXMdhaZ1kKp2HyVL56FRAJ7Ro7DvC4NmfT9aSFLQC20MpWb+4AabT8S
X-Gm-Message-State: AOJu0Yyr2NiO7CF9UKwoBzBfuLiJemaWR7ME8Q21TpYnoH0BqbSdQq+b
	nvzvr3fAp54M2fRIaKRCD9t4KoTkMYJNtz/o2lFL6zrp5WLZbq6MJpDM5PtK
X-Google-Smtp-Source: AGHT+IFm/+3NPlegmR4X1MUmK2ry7PKKmj/jbLem8MGDkRUVSp2F/6xtr51yH51y5cXtIJqp3UFp7A==
X-Received: by 2002:a17:907:3d8a:b0:a7a:a30b:7b94 with SMTP id a640c23a62f3a-a7d4000b1dbmr1073001566b.28.1722430350430;
        Wed, 31 Jul 2024 05:52:30 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadafd9asm764988666b.187.2024.07.31.05.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 05:52:30 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso8297479a12.2;
        Wed, 31 Jul 2024 05:52:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURxDfRChrt/IsnrtuBDegqXqjfvDdkAtPLhH9XeFC1d9ojz5eu0GIaaC/uq2Zs5ijT1PD51XWg0qZhEO+R2ShhP9pqghu4DJGGmi0E
X-Received: by 2002:a50:9b5d:0:b0:5a1:22d:b0ff with SMTP id
 4fb4d7f45d1cf-5b0225c61f4mr7998812a12.35.1722430349907; Wed, 31 Jul 2024
 05:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731032030.2847151-1-neal@gompa.dev> <CANiq72nXN-pkHAG6A19JrjiL-uKpem_-8GN8RhiVgc+sKJN6wA@mail.gmail.com>
 <CAEg-Je_S8hAUg9Gdp7QAOxww2dvV4_OoCTV1pvxMNAAvVkQueQ@mail.gmail.com> <CANiq72mibFYOpQY4RxuJf1DQAdqnAsuLW2-24MnY=JpdSoXd5w@mail.gmail.com>
In-Reply-To: <CANiq72mibFYOpQY4RxuJf1DQAdqnAsuLW2-24MnY=JpdSoXd5w@mail.gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 31 Jul 2024 08:51:53 -0400
X-Gmail-Original-Message-ID: <CAEg-Je85yStrR4tQ4Dqih=fguT7-zO_9ZpY1RCTEzwHPnjDDxQ@mail.gmail.com>
Message-ID: <CAEg-Je85yStrR4tQ4Dqih=fguT7-zO_9ZpY1RCTEzwHPnjDDxQ@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: Only block on RANDSTRUCT for RUST
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:29=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Jul 31, 2024 at 12:18=E2=80=AFPM Neal Gompa <neal@gompa.dev> wrot=
e:
> >
> > When I originally wrote this patch two years ago to get things
> > working, Fedora used all the GCC plugins, so I was trying to get GCC +
> > Rust to work while minimizing the delta on build differences. This was
> > the combination that worked. We've been carrying this patch in the
> > Asahi tree for a year now. And while Fedora does not currently have
>
> Just for clarity, when you say "carrying the patch for a year", does
> that mean Asahi used it with the other GCC plugins enabled?
>

Yes. When Fedora had it on, so did we.

> > GCC plugins enabled because it caused issues with some third-party
> > modules (I think it was the NVIDIA driver, but I'm not sure), it was
> > around long enough for me to know with some confidence that it was
> > fine this way.
>
> Same here: I am reading this as "yes, in Fedora we tested it for a
> while with the other GCC plugins enabled, although not recently".
>
> If so, that is great to know and we can relax things here.
>

Yup, that is exactly the case.

> > This was mostly because I wanted it to be clearer. The negation didn't
> > exactly read to me the same way, but that hunk can be dropped if you wa=
nt.
>
> I see, that is what I suspected, but I wanted to be sure I was not
> missing something.
>
> I am ambivalent on what reads best, to be honest, so I think I prefer
> to avoid the change if it is unneeded.
>

I'll send a v2 then.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

