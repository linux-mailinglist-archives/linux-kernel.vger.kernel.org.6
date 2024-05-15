Return-Path: <linux-kernel+bounces-179530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC98C60F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AB61F210E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0823B43144;
	Wed, 15 May 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Kztt4isx"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44763D551
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755461; cv=none; b=C4jTDJpl3eVHxCja4uB6MpR5IMPkV6SwMvSPH1Ypvqn4loHU7J84CcET7gxayxqgu1yGJHwgnfIKNYnkg8xyz0HKUzXMo7L/igZrmI7her5Ko9jkoPOBm+K3jaSR0JBi2lJP0wdc3YAYpfpwIFMhQzVSzE5mVMM2vbbKiT4idwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755461; c=relaxed/simple;
	bh=Fajia5z7P12kLeYYIqCKzSxxUzjVfBhm34t9XrY0/yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuQgsSQeIKT+gSTiflcHv5jA1/CMhhf+vAxZv6DxL/RwqgqxKfbjGgyq/VHX7AdM2WKhA010OEJiGrH/HkXr5PrVPV0b4JrnYORBAdyBlIYM1Eq0AHYnKgDgGpupFyqh7kH7SVeq6bcwdO+jRRkq4uWkqOXFcnEaQARsFT0793s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Kztt4isx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4599036a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715755459; x=1716360259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHt6iIdLhW0U7BUX4DS9zeBTZluih3jaSJ3akZl6570=;
        b=Kztt4isx1Mubyl8Fpbrxwcx7WVR/jnojP6TJ/5wHuCSUbd3W7go/1zLZOGFd7EYr9B
         2JRFvVaeSeLQgeDmG7DQyoVaGjJ5idyNDN/T6gM4R5QII+2aOfhgucxc5udCRHCFDnlm
         8HhhrDV2Jel12WEzipoWc1i9V/Cxd04w1SjiDtZezIW34m2ccc3ubDhYaf+5rs4tCpzC
         NPzztGmKeDVXxO1oSGH3VHw6OOR39bwCNEL/xN1cjxn7tTp8aRIBLjuBln8QmhZed7Gt
         hIP1mGuDVx+q0kUb0BGcRBsBSn9hDLcQDmbTtvYsnJz7bH+teVKQAWJLm1VzM8nZaDo1
         pJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715755459; x=1716360259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHt6iIdLhW0U7BUX4DS9zeBTZluih3jaSJ3akZl6570=;
        b=FmONlzhxtZJo8S61l5++wYEiJrjv8h4UEdBS/ImFH3do5xhoOclwUtlibDoIj9KNOg
         bHSdBjn1axofEUVjx3WfjqGQCzCt9SBxKWvLxLixgGN1P0XWeldnEMBQJySJrVt7Y2AL
         e2jX+vt43bfUgpeR1APw+RE8b0nip7NaKeB8uD6+cJiMLFG1jVUVoffru1oLuaeDyDMp
         6fDuoB/0hn7CxwX0XIwlRS3wrkb2tsar9/8Ny92Tddt1G6QtyfhgE0td7xvbjDNPDkO9
         8H0fAtz8Ff+7PtPb28S+sAm/657eg8J2Yv5R7itxuYYGJkW4QhQ4EIAWYKQtmQO4hRb2
         luOA==
X-Forwarded-Encrypted: i=1; AJvYcCWTFpf8NvfkVAg/1JQyNuwF6UJY7tpk06V+UNExixKuJsscU+3FmM/8EJARx+7qRVBHQPmpNpXqETEMSmoAhT8+F7fetCn2BbmgBtD5
X-Gm-Message-State: AOJu0Yw6orDjVH5yzMWTQWoNFjNpud8XckSOf0qr6evJx1x45jpUvJtF
	NxI2lW/lrnsEdcg/WRzspmIvJ967qkTFGLXOwLZWhscZAa/PODPXpFpIFVks8lWIgiLpPnLSgJq
	2awstTsh/Wo/zBkPCj8mVH1F7PsqvEtlIjxO3BA==
X-Google-Smtp-Source: AGHT+IFEtAJZ2VfYRn/ENkTjxi26mgbfcvdMy4KCuQ8gQasIEb6jSLE6aTIv+LC20CsuGZBINyFevEeFRMr7E7pWuzI=
X-Received: by 2002:a17:90b:3715:b0:2b3:9ce8:1239 with SMTP id
 98e67ed59e1d1-2b6cc1438dbmr12551957a91.6.1715755458902; Tue, 14 May 2024
 23:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org> <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
In-Reply-To: <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 15 May 2024 07:44:07 +0100
Message-ID: <CALrw=nEnqBCBQKhK9ACc7tbicqkXaDD+Bjc1d90xizMvbb--oA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 12:44=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Wed May 15, 2024 at 2:10 AM EEST, Jarkko Sakkinen wrote:
> > On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> > > Derived keys are similar to user keys, but their payload is derived f=
rom the
> > > primary TPM seed and some metadata of the requesting process. This wa=
y every
> >
> > What is exactly "some metadata"?
> >
> > > application can get a unique secret/key, which is cryptographically b=
ound to
> >
> > What is "cryptographically bound". Please go straight to the point and
> > cut out *all* white paper'ish phrases. We do not need it and will make
> > painful to backtrack this commit once in the mainline.
> >
> > > the TPM without the need to provide the key material externally (unli=
ke trusted
> > > keys). Also, the whole key derivation process is deterministic, so as=
 long as
> >
> > Why trusted keys is inside braces. It is not important for the point
> > you are trying to make here?
> >
> > > the TPM is available, applications can always recover their keys, whi=
ch may
> > > allow for easier key management on stateless systems.
> >
> > Please drop "stateless system" unless you provide a rigid definition
> > what it is. I have no idea what you mean by it. Probably not that
> > important, right?
> >
> > >
> > > In this implementation the following factors will be used as a key de=
rivation
> > > factor:
> > >   * requested key length
> > >   * requesting process effective user id
> > >   * either the application executable path or the application integri=
ty
> > >     metadata (if available)
> >
> > NAK for path for any possible key derivation. They are racy and
> > and ambiguous.
> >
> > This should have been in the beginning instead of "some data". What
> > other implementations exist. For me "this implementation" implies
> > that this one competing alternative to multiple implementations
> > of the same thing.
> >
> > I do not like this science/white paper style at all. Just express
> > short, open code everything right at start when you need and cut
> > extras like "stateless system" unless you can provide exact, sound
> > and unambiguous definiton of it.
> >
> > Just want to underline how this really needs a complete rewrite with
> > clear and concise explanation :-) This won't ever work.
> >
> > >
> > > Key length is used so requests for keys with different sizes result i=
n keys
> > > with different cryptographic material.
> >
> > What is "key length"? Please refer the exact attribute.
> >
> > >
> > > User id is mixed, so different users get different keys even when exe=
cuting the
> >
> > First of all it would be more clear to just s/User id/UID/
> >
> > And make obvious whether we are talking about ruid or euid and how
> > this interacts with GIDs.
> >
> > I'll look at the code change next round if the commit message starts
> > making any sense.
>
> Right and neither UIDs and GIDs are applicable for key derivation for
> quite obvious reasons. So NAK for that too.

Can you, please, clarify a bit here? Not very obvious for me. I added
euid for two reasons:
  * an unprivileged user might run a normally privileged application,
for example /usr/sbin/sshd, and depending on the code could "leak" the
key
  * without it and with unprivileged user namespaces it is possible to
create an unprivileged container with code at the same path as a
privileged application

Why do you think UIDs/GIDs are not applicable as mixins?

Ignat

> You can make them point out unlimited different identities...
>
> BR, Jarkko

