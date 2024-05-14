Return-Path: <linux-kernel+bounces-178899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A818C5938
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F23CB214E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD117EBBD;
	Tue, 14 May 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e/u+AQ10"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7117EB8B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702476; cv=none; b=W0+CbUCPKDCbn2e2bpzjrbZrfOLIWP80Wd3yEzz4v6e4xoFXm2vi3BYSHqNGOBErvLH/g4EUA6xbVOydRWm5Sj7by9HLWi0PDfe4Tg3XQP0ZbKQX/0+lmnXMiAtbG4Ehckl9mnZyR2S6ezELpE9nqjLJXXWtFvuoF6Ikqqe0LeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702476; c=relaxed/simple;
	bh=BNBKprk69XqKuQd2nd+AK0sj1ZRUamfPFo5xEhcbXbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJgFhlR8NxrK7+yd3NLgOtk+uJ+N4mdxBd4noeKwvXzrzy1BodE2ghRRpNAFbSt2K0zMr0tC89iuoDO03bt7hBGYRT81yCWVUC+oZrlmDGh9nIiQMucqI8r8KNs7q/eMjR4RcVG/DNT9ZcUIEdAn9c89ut+lPRXuaBVBoBxhsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e/u+AQ10; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-61be599ab77so2671631a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715702474; x=1716307274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgD83N4J7mAbRy3EDx661pmTjLnOlorxLzfUuLM4b+w=;
        b=e/u+AQ10mFf+YmAAspVmynsrWhi2pfwBL8ZWFeP9DEg1GEI2mbzCzHpfN3mqmmk7Bi
         KzroWTMDZXeIhx+2ndaEQyIPXy/LyNZYe7UescxuOyIafQ1UYTYGdZ0r7qyZ+x3FVccM
         telxj5rwabcn1OW7cWvDnXDlLqwkqBHat1CdE34gKvGGS3P1A7WTbDQWK/tpDrNGDFJV
         5WHQAnZxrhwpPatX6lQVeTdnVoM41SWEB/c4PQG63V0hlxH9+IHQkVzIjZ46ZCBUAcSp
         UrAmjgcRr5/T7HtvtXvporTLe7KV7fw3tgommK8AIr9Y2e7u6FQtQwkLR6MFZN3OM+y0
         lSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702474; x=1716307274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgD83N4J7mAbRy3EDx661pmTjLnOlorxLzfUuLM4b+w=;
        b=mEonerHFZ42Pq0vyH9IHrIG7vSq2xzHhsHkrmkH6scYH2WqLrh92+URnqTqAGuSU4V
         UiJ688AD/t/myNEKmOYMYw9HYS5dcDkS9Zu+aQ8824J2vnroSUCKICMZlan2hSt48aue
         fNws9zInIIHe/iDN61gxazFd3xicVxvh6BmxO3nWqgNeGjZY4BvpMM3WFJKVXBK5Ew0w
         WajNBUSEmB8nDC0KapyrWa8XqEJniRrvaTM0i4IjZnqu08lqi0igSq6tSwOE+qVw1rRf
         u5zW/q7VkHn45YxkP65x2guX9sGjIAyyL/qP/TMtlw9SgsAJlBWacgsYvGbMuVvlzC3M
         haOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ktvMb/3LqLIpwRFy9wZlHvg2v55Z9BF90Y9qcC5AQp5OlDayXyJAlQKIfQABBTqR5Dtxxsrt+uVRseG0CDEpPh1JLWoCNv7P8yqE
X-Gm-Message-State: AOJu0YzIbE7Im+XkS70zQMlgyXatW4ewI66qx6zodoUZIK3R/ANBipdb
	rdZjJUYQ/ItZbMjRvdZU2Xx4vJi33WbPVmwvMCptbqxUSpvX6sy8qEPQS3wCLpGT9GD12Y8Sfvp
	rINM5kk3k3mCowi2vmwyc6H0orooMV7V5+B/V1Q==
X-Google-Smtp-Source: AGHT+IGniyLHL2d8EkhZ6SHULNVROizWokiY9TO81uFsHrlKrx+cweSwP3i6SKrWQTa8TdW6AOy44PFGwhFEHuu1Dz8=
X-Received: by 2002:a17:90a:b38e:b0:2b5:6f9b:a7b with SMTP id
 98e67ed59e1d1-2b6cc759192mr10553268a91.15.1715702474405; Tue, 14 May 2024
 09:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org> <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org> <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <3bfcacf38d4f5ab5c8008f2d7df539012940222e.camel@HansenPartnership.com>
 <CALrw=nE-t6ZWCvPm=3XS_=-UM9D=mMaXL2GOw-QL5GOLtbcHmA@mail.gmail.com> <c8b98d9fc2ac4062d6c010551244da184af1244d.camel@HansenPartnership.com>
In-Reply-To: <c8b98d9fc2ac4062d6c010551244da184af1244d.camel@HansenPartnership.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 17:01:03 +0100
Message-ID: <CALrw=nFABteNOAOpvaGOMrpUOMW1LMJfRB5EXxs_dPH70G_LGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:54=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2024-05-14 at 16:38 +0100, Ignat Korchagin wrote:
> > On Tue, May 14, 2024 at 4:30=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2024-05-14 at 14:11 +0100, Ignat Korchagin wrote:
> > > >   * if someone steals one of the disks - we don't want them to
> > > > see it has encrypted data (no LUKS header)
> > >
> > > What is the use case that makes this important?  In usual operation
> > > over the network, the fact that we're setting up encryption is
> > > easily identifiable to any packet sniffer (DHE key exchanges are
> > > fairly easy to fingerprint), but security relies on the fact that
> > > even knowing that we're setting up encryption, the attacker can't
> > > gain access to it.  The fact that we are setting up encryption
> > > isn't seen as a useful thing to conceal, so why is it important for
> > > your encrypted disk use case?
> >
> > In some "jurisdictions" authorities can demand that you decrypt the
> > data for them for "reasons". On the other hand if they can't prove
> > there is a ciphertext in the first place - it makes their case
> > harder.
>
> Well, this isn't necessarily a good assumption: the way to detect an
> encrypted disk is to look at the entropy of the device blocks.  If the
> disk is encrypted, the entropy will be pretty much maximal unlike every
> other use case.  The other thing is that if the authorities have your

What if the disk is filled with random data? Would it not be at maximal ent=
ropy?

> TPM, they already have access to the disk in this derived key scenario.

I'm thinking more of a datacenter scenario here - it is much easier to
"steal" a disk rather than a server from a datacenter. So it is
possible that someone has the disk but no access to the TPM.

> If *you* still have access to your TPM, you can update the storage seed
> to shred the data.

The point here is not if I was able to shred the data or not, but the
fact I have something encrypted. Even if I shred the key I would be
considered "uncooperative and refusing to provide the key" vs "I don't
have anything encrypted in the first place".

> James
>

