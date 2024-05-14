Return-Path: <linux-kernel+bounces-178860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9318C58BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7C81C21BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67E17EBA4;
	Tue, 14 May 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JJOy7b+7"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8017EB87
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700631; cv=none; b=Yomz5C/khpD9147+KI59nN6QJDhXBHVlCcAfrijKLhNQNUmIq4LMFYz1t9Nt7n4s8yIz50HUwNl+lG+9RuYgnKbIjRDHfxi+yquD3vIn/S5p2OiFfALe+GrneNMZSnfnABnyuoEAM6Hc0FV4HQ7mlB2WE8HBzu+bNTzm9KU7V4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700631; c=relaxed/simple;
	bh=1f3Kx489C8VnTBofag5Oo2fJCcf66AJvGSxZ9HqCvzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjU5j4D/M/hCzqWAalL/BBTudVDqyono36np8bAbJzvOzyXmQTNOv2cDjgoHx9sADM6DT0dJcVlDHNWpglniZTbKNuW/naYwAvftY4BZC5GQs9bVTvs9b/8Zt0XaEO2dwLDOkthCf0AtIvrHjKM7TxjZmv6TsIzLH9IsW6DO4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JJOy7b+7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f0f87f9545so1818066a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715700629; x=1716305429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvdE+NyB6AiRqm9vJXqc0Y1UD7sFupg+QTlCnKMFHNw=;
        b=JJOy7b+7vrMad8jKRy8HqXys5vi1VtOZskVx1AYTve23q3WUjt69hExpuzlHaUeb+s
         +6bB4Dm9rwhfpikVAGw6ob8hM3rrX43EYwBif1J81ayv/VwHoCDfaLT1AV6+4EbWahrF
         AN8GLKYIQrdX5SCwQ4uG27SVR09J+wve58NJD0cGdqCdqokSlFihaAKhorIuKR/evfZK
         wMHRyZUmoOnaHKt4KpRdLqCDhxTvUB40zcBxq9NisysJxCVshU2lLLXCnZzS2eug83Yl
         cOk+zSMmBYMtJnEYsxQADxcPI4PxDPd9O8qzuyTFJgBWnM0/gznbqG2rm796wGdrZDqu
         Z4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700629; x=1716305429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvdE+NyB6AiRqm9vJXqc0Y1UD7sFupg+QTlCnKMFHNw=;
        b=qBBNe5mYgCuRWDrzkaObuoYLdjL8Gcl4pz8ogO7jqwHbzDBllacRvcJX34bUb3AEkt
         uNo8unICN/yX0nOBr2BbbJ8XDWtwCyYe2bZNV3xYiaIePEjuIUMnAOkfAVsTw8iLCX9L
         /lfyTa8sC59jrNghLaBM/kjFglM2cgbOoVcvmV6M85BzqzF9GJtatStga4K4mDUzlQVy
         QKkObjua4k7Ok62IB8WWLqa7lqD5hhjmDMIhPElH6/Fdgb9NejxkwZEOzM5tbwfR0AVQ
         V9oRg/SVkofEh6fbw0x76fKHUFG0LtA5BnhqZ4p1kn4HWZ2n9ckkTyUNpHMMVG4OkhSt
         IVCg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ref1neZfgFMzgnWCl44/6ZjzkKedrqX/0BQm9//mydvlmhRQp/wic1bQwZYjH06TNRLKLltqvEDbBUuSMZJIjoM62r7tAF0gDO1a
X-Gm-Message-State: AOJu0Yx+s9OewkBkRzGh+FpT1VLmOkZXMZImpgSGukb6/meMwSb0EqR9
	c/jnhjHEiiCkhrDXJNkDDHyBur4nYUj0szUM4N20s4YPElXD3oyBxNbXxi2QvepBSkcGcsTKVXC
	2v0L/xTo5qY6o1KW/fr6xZCuE3H/PTm2Mbf4WZQ==
X-Google-Smtp-Source: AGHT+IGFRwCdtWqChG6DcrL0YFZ2VPMidhHivvuUhFfT7oqms9QgbbZoTR/EUGByo8qrQN32La+DDCQTlqxQfkN2dBc=
X-Received: by 2002:a9d:3e12:0:b0:6f0:594a:5d5e with SMTP id
 46e09a7af769-6f0e915485dmr14924678a34.18.1715700629224; Tue, 14 May 2024
 08:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org> <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org> <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org> <D19FUGDA2CUO.16EF7U9ZEZ4SD@kernel.org>
 <D19GWXHYP2VC.1OY7BOW5LNXVF@kernel.org> <D19H0UVF3R0O.3N4GLZWFRZ2DO@kernel.org>
In-Reply-To: <D19H0UVF3R0O.3N4GLZWFRZ2DO@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 16:30:18 +0100
Message-ID: <CALrw=nE7ga6wxSqrJBTOaj+pPXhi4+-Rn4ePRC9vXL-8Qd3GrA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:26=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue May 14, 2024 at 6:21 PM EEST, Jarkko Sakkinen wrote:
> > On Tue May 14, 2024 at 5:30 PM EEST, Jarkko Sakkinen wrote:
> > > On Tue May 14, 2024 at 5:00 PM EEST, Jarkko Sakkinen wrote:
> > > > On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > > > > For example, a cheap NAS box with no internal storage (disks conn=
ected
> > > > > externally via USB). We want:
> > > > >   * disks to be encrypted and decryptable only by this NAS box
> > > >
> > > > So how this differs from LUKS2 style, which also systemd supports w=
here
> > > > the encryption key is anchored to PCR's? If I took hard drive out o=
f my
> > > > Linux box, I could not decrypt it in another machine because of thi=
s.
> > >
> > > Maybe you could replace the real LUKS2 header with a dummy LUKS2
> > > header, which would need to be able the describe "do not use this" an=
d
> > > e.g. SHA256 of the actual header. And then treat the looked up header=
 as
> > > the header when the drive is mounted.
> > >
> > > LUKS2 would also need to be able to have pre-defined (e.g. kernel
> > > command-line or bootconfig) small internal storage, which would be
> > > also encrypted with TPM's PRCs containing an array of LUKS2 header
> > > and then look up that with SHA256 as the key.
> > >
> > > Without knowing LUKS2 implementation to me these do not sound reachin=
g
> > > the impossible engineer problems so maybe this would be worth of
> > > investigating...
> >
> > Or why you could not just encrypt the whole header with another key
> > that is only in that device? Then it would appear as random full
> > length.
> >
> > I.e. unsealing
> >
> > 1. Decrypt LUKS2 header with TPM2 key
> > 2. Use the new resulting header as it was in the place of encrypted
> >    stored to the external drive.
> > 3. Decrypt key from the LUK2S header etc.
>
> Maybe something like:
>
> 1. Asymmetric for LUKS2 (just like it is)
> 2. Additional symmetric key, which is created as non-migratable and store=
d
>    to the TPM2 chip. This deciphers the header, i.e. takes the random
>    away.

This could work, but you still have the problem of - if the header
gets wiped, all the data is lost.
As for storing things on the TPM chip - that doesn't scale. Today you
only think about disk encryption, tomorrow there is a new application,
which wants to do the same thing and so on. One of the features of
derived keys - you don't store anything, just recreate/derive when
needed and it scales infinitely.

> BR, Jarkko

