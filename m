Return-Path: <linux-kernel+bounces-179581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3494E8C61A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D901C21814
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E143ABE;
	Wed, 15 May 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZmPZVsSp"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7242072
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757997; cv=none; b=GP3NiZMYUinMnoI9N/hrkBcXVH12P4/n5dXkXaz49f/mOzYMsxbfLUGsqNDCDkMn/9igNu8CpIfT3mBRNJRwTngWCuhMFfqXcIZn2jtzdauRjvPvxgZPNLloL29ExvMaQ4ngG0acrR+RLewCH05+UixlHk0GbZXQrywi5DZVH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757997; c=relaxed/simple;
	bh=pHIDXBNssCBc03cLf2WrSSXPNJV9C69TUOs58UGNXiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPnO6AB0rfkAijycmBcuiCosq7GE5AH4G8u+J5Tc9FxbA8MadT1mm6Jmfsb7uChqxdPToRGyL/LiI03wx0OQF7ri9Us5qcGnSSTtE7q0cxJBlVpGYZSCNP2yhFnJ5/r2K1YrwCwf6AmOsc6dZYUuA7i7cVAfa6LaaJDlQ1DKCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZmPZVsSp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44b296e02so3834568b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715757995; x=1716362795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrvNGMUcH8kbhXEijiFcgBH5XmfO0e+fTQFgvwJdcDA=;
        b=ZmPZVsSpAlOrLOzNVMuNGm3E1tubJAyWkLqcvdYvVAK7vZJzS3L6wQ6BuZZJROZPEe
         Ha1THimHGr+6u/jjHA5oDXOQlp1pQBNi7VEeTlyceIccBGCUTm7g61bQaUlk1jE1Nsy4
         9Se0qQqO1dqqSz3MVJQabkMV0Dv8m/z2AhYLSPG+GhSzuHUQoEL7xYwTOCJYV/SY93Xe
         7mXuMw/xavBZwbEdo30lqLS4z5F6fAAIDL+MKF3rDSCA65OOuNXV9JdRKZdS5GiWxQal
         AQjxAk68cu2Re4pM6zdLZFahaN+9sv6cwjHrkzqRtPl4MkCEzclOzihAxVs4L0ogHvB3
         k2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757995; x=1716362795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrvNGMUcH8kbhXEijiFcgBH5XmfO0e+fTQFgvwJdcDA=;
        b=DL1lZ0Bb1mSwNvA3JjkUhoXUVniyMBLf9/vpR2+VB+pIwwEGeeJS/779ke3l7ZufOM
         GpZEbc12Nq8qPOcziNNYLWMinxuKZHNrZ+i8kwqQbuqHuEtZ5xXp4LIzIpkhkya3/tGj
         V1bQL5b1db2R0OeiHRv5q2R7bJ9MtrqBE9bL+hM8G8wHwTbn6/aeCBLJLRTgwlqDOZYk
         6JB1c7m4WpBKcqE3AbiRxTp2QG6OHiFLt5DDzTb6WS7C65vNSmsGTAJCRaYSiPh3xpxA
         nK/bNdB/Vw/FPbVKJjHqiN9VxYuc2SJn2vHVI4Xzc9Veq3IkENrILI14OYce/aNLuCu6
         h3iA==
X-Forwarded-Encrypted: i=1; AJvYcCUbSG2Bu8E6SrXb2LWroi1idnwqzd/K9ljdKqOqFTPIFNePOMNqH7tqwohyOcML0MOguTS/pibKFVP9aa+4GegcvpgcGail67z+XKH+
X-Gm-Message-State: AOJu0YzviR+EJEh6t1bAUCBW9Ci6xoOrZlYaUxCFYJHv21C77U57Q9yI
	1sZIQH+XdYXlysK0xanPpjmD13JJUpJpY6wlacI0ee+bC1zJCuv7V6PJaTB0NLxXPAFyJNoWI5e
	EzTkyrojzWhBhMwTU632907P0toyI90nyAZQwXg==
X-Google-Smtp-Source: AGHT+IFkuxJNBNByOn4dn/O0DmpomBqME3HUvwwIwYCPNWgsW8k2PYZmU2A6Yq68xZdjZJus/8N9Nb7AiHdNU5pwdUo=
X-Received: by 2002:a05:6a20:12d4:b0:1a5:6a85:8ce9 with SMTP id
 adf61e73a8af0-1afde0a8da9mr16307857637.12.1715757994863; Wed, 15 May 2024
 00:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
In-Reply-To: <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 15 May 2024 08:26:23 +0100
Message-ID: <CALrw=nFsjiGTZDN3vYCN+GC9R3eQ3ix6_u2x0xo3jcpHqWjs3A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 12:10=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> > Derived keys are similar to user keys, but their payload is derived fro=
m the
> > primary TPM seed and some metadata of the requesting process. This way =
every
>
> What is exactly "some metadata"?
>
> > application can get a unique secret/key, which is cryptographically bou=
nd to
>
> What is "cryptographically bound". Please go straight to the point and
> cut out *all* white paper'ish phrases. We do not need it and will make
> painful to backtrack this commit once in the mainline.
>
> > the TPM without the need to provide the key material externally (unlike=
 trusted
> > keys). Also, the whole key derivation process is deterministic, so as l=
ong as
>
> Why trusted keys is inside braces. It is not important for the point
> you are trying to make here?
>
> > the TPM is available, applications can always recover their keys, which=
 may
> > allow for easier key management on stateless systems.
>
> Please drop "stateless system" unless you provide a rigid definition
> what it is. I have no idea what you mean by it. Probably not that
> important, right?
>
> >
> > In this implementation the following factors will be used as a key deri=
vation
> > factor:
> >   * requested key length
> >   * requesting process effective user id
> >   * either the application executable path or the application integrity
> >     metadata (if available)
>
> NAK for path for any possible key derivation. They are racy and
> and ambiguous.

Can you elaborate here? What kind of a problem you see specifically?
(This is exactly what I want to get from this discussion)

> This should have been in the beginning instead of "some data". What
> other implementations exist. For me "this implementation" implies
> that this one competing alternative to multiple implementations
> of the same thing.

With "this implementation" I meant the current RFC patchset because I
do expect there would be more iterations and just wanted to solicit
comments.

> I do not like this science/white paper style at all. Just express
> short, open code everything right at start when you need and cut
> extras like "stateless system" unless you can provide exact, sound
> and unambiguous definiton of it.
>
> Just want to underline how this really needs a complete rewrite with
> clear and concise explanation :-) This won't ever work.

Understood.

> >
> > Key length is used so requests for keys with different sizes result in =
keys
> > with different cryptographic material.
>
> What is "key length"? Please refer the exact attribute.
>
> >
> > User id is mixed, so different users get different keys even when execu=
ting the
>
> First of all it would be more clear to just s/User id/UID/
>
> And make obvious whether we are talking about ruid or euid and how
> this interacts with GIDs.
>
> I'll look at the code change next round if the commit message starts
> making any sense.
>
> BR, Jarkko
>

