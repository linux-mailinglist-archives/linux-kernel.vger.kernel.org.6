Return-Path: <linux-kernel+bounces-178541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755A28C4F36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D78A1F212E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241ED13D508;
	Tue, 14 May 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JIv1rqb1"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210157CAE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681173; cv=none; b=ZVi8Cera8Y1Mo3y5IHLs2+ZRrNc1GVEdziweRyvgBUZKa3vtjKGN1+XwyY7G8KOwY3H3jol9YPKHLs7bGk+wEul8F0V9qFDXKEV9i2nM8MzsvjYwgzo1Q4Le+e7+W5ag8qgvx2q4Y5K2E/1IVtwSviKZVb7EJiOCsjJaEp+XyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681173; c=relaxed/simple;
	bh=JJMnPw1emDY+HwY78xe2ASFo8bdc3Bqhb6kfo40H6t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ0mpMIJTcaqu3GEj7oDexk0BwJpJ/DmuAugk0dg7cuAut7zpqDmHZZju5mci5fmTbqKrgPr18BcM8lkW/lwIc56SLfsWRK6PU7/pwX5aXX1KwcFu6LhiIewbu0MdETqVO5ngVf6JztcA5Hh6Ek84T2CYyRX4XhjncxIPgcsSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JIv1rqb1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso3635044a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715681171; x=1716285971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJMnPw1emDY+HwY78xe2ASFo8bdc3Bqhb6kfo40H6t0=;
        b=JIv1rqb1rvdYaUxCnNpMc9FPtDhIid1ji4rmyovP+X/GQTAOHCYRsPLOpJaz2obu2n
         BS97JrPlcm6LK0E5B8vnJslMZgBHZrImpDilNKis3RbK6g57jRS0CJVnlqS+4fnV+1ZB
         /H0wiLAiaokwVaMPHLh5UTPrSp0vMwG5WONeD/aR4wTK6GWbJ4pBk1oqXAnhg4QnAKWg
         OGZO8lYQ1xGg5jBDyDXteqVq4oRj8larJjSBu+MGZTvRuj4OPqsLqKW/5MGkvX1vM+RL
         k5feM2qnqIIPk5PNXOb8hYF9JR22/3OKxgGsbN9trPQEuPRGbGHPG0/oeAgAZPkYVzUL
         8x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715681171; x=1716285971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJMnPw1emDY+HwY78xe2ASFo8bdc3Bqhb6kfo40H6t0=;
        b=skWhbHxMntvX7D9XpDi2mKCm7SCQNNwKHMWWqdArpcgWkewOU6rzEOq74/OSAr83SY
         BVnNj20goYROntSL+DHoLuvLwzE7ySPbO7KcQOmu1URYMhgpPTouiTLwN4QjONKMXI1k
         x1QUK1rIQUTUisbsfq1u4R5rw2RynPSsFGxphlCNsbOW7J033tHG3vJaf5VAR0md1mVN
         tLdP4PcW6Kkd67qmU/LScXYvsPeFdY3HdLlzf60dguABPv9NyrcfgGPXwCgfGg484cP+
         U8cGlQT7Q7XQ4cR118QWliBG2SYk7XfzODKGrk4Pcvdhw/XQn99+fHahfQsUozciCQnw
         Jdzw==
X-Forwarded-Encrypted: i=1; AJvYcCVK47VhQC74Xw7W/Qh1lkQSW/AovOyjyRcDM5y+0P3Dn+QwnCl+vnJWRf8DEQ2ay3PznIdCSt2toOzoUlJIo/yzWc43W2c9Q8Kc7UZN
X-Gm-Message-State: AOJu0YxM8xGaGYtSdWMcQOn8E5/25Io2C8HSROp9+tMDm0KPYmGHCmUz
	qXiF2VaqgM9I2UjHfsmDwzbMHgb57r5RHP1sXMcQkMF7gzh/vKARS+WGZgE7cqleZ53aZcWFomw
	bhkPERMQm2tUE/OinYdDZxdHZ1gT6n886gIe+xw==
X-Google-Smtp-Source: AGHT+IHre9CZfrwCr+2Zr/doXN48B0LmWFsKXYVStPNCfzBqck4HKosJJb8s7ck5ghhRK6GFB6aXt07XzMJmGo22k+4=
X-Received: by 2002:a17:90a:a108:b0:2b0:e497:56f2 with SMTP id
 98e67ed59e1d1-2b6c70faab7mr18694886a91.10.1715681171194; Tue, 14 May 2024
 03:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
In-Reply-To: <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 11:05:59 +0100
Message-ID: <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:28=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon May 13, 2024 at 8:11 PM EEST, Ignat Korchagin wrote:
> > On Fri, May 3, 2024 at 11:16=E2=80=AFPM Ignat Korchagin <ignat@cloudfla=
re.com> wrote:
> > I would like to point out to myself I was wrong: it is possible to ask
> > the kernel to generate a trusted key inside the kernel locally with
> > "keyctl add trusted kmk "new 32" @u"
>
> Not in a full-time kernel position ATM as I'm working as contract
> researcher up until beginning of Oct (took some industry break after
> a startup went down of business), so please, politely asking, write
> a bit more compact descriptions ;-) I'm trying to find a new position by
> the beginning of Oct but right now I'd appreciate a bit more thought out
> text descriptions.
>
> I'm working out a small patch set with James Prestwood to add asymmetric
> TPM2 keys based on his old patch set [1] but laid out on top of the
> existing baseline.
>
> I did already the key type shenanigans etc. for it and James P is laying
> his pre-existing RSA code and new ECDSA on top of that. So this will

This is great. Perhaps we can finally have ECDSA software signature
support as well, which I have been trying to get in for some time now
[1]

> give x.509 compatibility [2]. This patch set will be out soon and likely
> part of 6.11 (or almost guaranteed as most of it is done).
>
> So by plain guess this might be along the lines what you might want?

I don't think so. I have seen this patchset, but unless the new
version is fundamentally different, it looks to me that the asymmetric
TPM keys are the same as trusted keys except they are asymmetric
instead of being symmetric. That is, they are still of limited use on
stateless systems and are subject to the same restrictions I described
in my revised cover description.

On top of that I'm not sure they would be widely used as "leaf" keys
by applications, maybe more as root/intermediate keys in some kind of
key hierarchy. TPMs are slow and I don't see a high-performance
web-server, for example, using asymmetric TPM keys for TLS operations.
Also, as we learned the hard way operating many TPMs in production,
some TPMs are quite unreliable and fail really fast, if you "spam"
them with a lot of crypto ops. I understand this is a HW/TPM vendor
problem, but in practice we're trying to build systems, where TPM is
used to protect/generate other keys, but most of the "leaf" crypto
operations are done in software, so we don't make the TPM do too much
crypto.

Just to clarify - I'm not arguing about the usefulness of TPM
asymmetric keys in the kernel. I would really want to see this
building block available as well, but I think it just serves a
different purpose/use case from what I'm trying to figure out in this
RFC thread.

> [1] https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com=
/
> [2] https://datatracker.ietf.org/doc/draft-woodhouse-cert-best-practice/
>
> BR, Jarkko

[1] https://lore.kernel.org/lkml/20221014100737.94742-2-ignat@cloudflare.co=
m/T/

