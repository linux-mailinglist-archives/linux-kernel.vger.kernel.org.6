Return-Path: <linux-kernel+bounces-283337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A894F104
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823621C2206F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA4185606;
	Mon, 12 Aug 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mnt2jl/9"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939291836E2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474671; cv=none; b=j8bBqI7BjzazTXagww1oonYY+um7xfMSBTqhCXaOfgGFEZLr89c4wuTFCnUM9WPvEMWlHBf7IjgmWN6ZSOT1cd6Uk/sDTRQtDC8s/mb+x0Ct570SbFvNIh+fG8hdmRVUcUMTBmQFpb7S9RSmEj+oc4j24JTypAdmBzvVqN+kOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474671; c=relaxed/simple;
	bh=AQW2+eL2j/iO9+rbNGUv8GlYmVEU+Bv7ULxdXA05ymY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHaQ15qPKjDfifDQJ7bUoFhVORqU0Ky0dixTu0vzWlRSPz3pReR/c2IZINdHSHSihZItKlwqquWo3AlxeM/N0UHshm+TJD+uxY1NEW7IxQl1XZT/751QRN8V49J4RbwZi0opjU6PyBtXoV9hvFaqkLyEh0F3t4J3ki49HUhe3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mnt2jl/9; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-69483a97848so43635397b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723474668; x=1724079468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQW2+eL2j/iO9+rbNGUv8GlYmVEU+Bv7ULxdXA05ymY=;
        b=Mnt2jl/9ffUiwCkDLRmEPSlXw0eaGvtLqYYOcMsFCd1qewz1vizcqhjLV3oFICUY83
         Dh/vFge7qOhUIcr+HSNv82FYK02FZ8sD/bUTlaEMTsJJrFd94BolLeN/o/bzUUaP1+ne
         JZiT8eA896Y4kh57MfSkzZpr9dZZHS0fNLLSz8p7NxqO6z20IHYoZmKjE5Dn0DhtMxAG
         Belzi8E/QILDp4ulisLicn3aqqG04c1kvdhnRgo3xLayri14ma9tz5XSeFAKq94DqOdt
         rXXfrQGGjUKOlijsaAE/IVY8ZTfVWcHkfnahuV70nmeXzv42Na/PJRP9bg3/LpE9EIc7
         I5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474668; x=1724079468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQW2+eL2j/iO9+rbNGUv8GlYmVEU+Bv7ULxdXA05ymY=;
        b=Y0uLv79u3hzH/mzw9aF7Q26jpuVTF2q5wshKwqw+GCPi+d9REqx0tAcF9kJUHBNh1p
         zntoEmDYan/PIyQgKUPkDqpFEJUteQbAHFMXAGpKawWM+WBxgRMM19lpzq/Ja1qdPLYp
         +uQfx8GgETfWdIrdi86DP0/SzEFbF2eYTGX2EElt1OMj7Eeov/OfU57/nOgB+18/zrue
         GMO+RynbJZ/6pT00OSrg6U4Q8toVJ/4mB7K+MlIWf/dy+kX7Kx7/bVyKTdlQCkkM+MxO
         b7rqt43etGd41Oq6Wqbou4+cWhf6kZjWTOOV2NB4Wp5XJsjllM+AEMEt6F8Abdv9tjLd
         Xtcg==
X-Forwarded-Encrypted: i=1; AJvYcCUTWXVGKIq01j4kv4MHuY3/lsOLqFE4N2h5NVjqTVinvnrrS4OynaeGWZA671HfV+qqC6yKpETjTZohXW8/ZMKThNagviaYDXNTQhE8
X-Gm-Message-State: AOJu0YxZmg9Xyl4KS73+3FznZyTha82wBtE1X+tnkvTxaDVvPuFifI7I
	4ts87JPi6KDov6EW6PqjjKkNrD9y6n+HtWeCb1nxfvV7IvMs1gw6sgIoDGh4zuGb6uWC2GMjb5U
	LOTYI+Hi9+8dyrDzeCwFMaXsfIUxXQXN1MAd3xS5olm7Voys=
X-Google-Smtp-Source: AGHT+IHCqbGNl28Tb0VvZt0b0wiecP+RTS6ldJ+b4kPJnjFZ9A4wuJPsKq05VeAhVR2yC8XNGLQn7nsqAICsX1IPYAo=
X-Received: by 2002:a05:690c:2c83:b0:65f:cd49:48e0 with SMTP id
 00721157ae682-6a9754e6f16mr6868077b3.31.1723474668545; Mon, 12 Aug 2024
 07:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net> <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com> <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
In-Reply-To: <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 10:57:37 -0400
Message-ID: <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: Jann Horn <jannh@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:09=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Mon, Aug 12, 2024 at 12:04=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:

...

> > From a LSM perspective I suspect we are always going to need some sort
> > of hook in the F_SETOWN code path as the LSM needs to potentially
> > capture state/attributes/something-LSM-specific at that
> > context/point-in-time.
>
> The only thing LSMs currently do there is capture state from
> current->cred. So if the VFS takes care of capturing current->cred
> there, we should be able to rip out all the file_set_fowner stuff.
> Something like this (totally untested):

I've very hesitant to drop the LSM hook from the F_SETOWN path both
because it is reasonable that other LSMs may want to do other things
here, and adding a LSM hook to the kernel, even if it is re-adding a
hook that was previously removed, is a difficult and painful process
with an uncertain outcome.

--=20
paul-moore.com

