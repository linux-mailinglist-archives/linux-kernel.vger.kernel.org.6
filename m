Return-Path: <linux-kernel+bounces-545843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C7A4F259
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA62188F7F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C939F1CD3F;
	Wed,  5 Mar 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VpPwhOjF"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E814286
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134001; cv=none; b=lPp9HXlCBL5hrqrchAY9jx0+cekfgY6xvgybsHNE5Io4rl1ANiqUiqvH9hyzbYbSsPNIWWiZmhWYDZIhIxyQMwquiVesqhhr4mNIWIyMajc8S9tQ6p5jp3+6Oek/RZo0HmpY5wLbuv8tDlu9mgUjpQmCU7rA64cAJ06WQRhBABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134001; c=relaxed/simple;
	bh=nFmPFrquQ5bomrKpIAorl2f7SP/HswO2qcap7S1MciA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQtVAGc9LV5ZtrpsV9NW9737QnisTWuh2LDCYc/AlIi8NQwTO0Jale+5DmSwr4Ux89aRgOqzacLjIxvSRVOhxT76y1g/2TZn3Tl5PX/SaqKZZV5WKghm80m7kgNDNwDOPpgWFYirAn4ZqaSpg8AixFEClgdPFK1x2Myz4NeeJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VpPwhOjF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f9625c0fccso56513537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741133998; x=1741738798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocfBqfPEo/ZGjFNCT7umNcOBhbM/4xfpitCEs7MgftA=;
        b=VpPwhOjFNxiBiMmvGTcObTttOW5Dj7bBG+a7vtg2EjkoHTunEEoFT0g+jruYi+R4YD
         6VXDfklPzlOtM5XODG2rL77Z2kGosFeXNIw12gB2XQ2FOBD5m9EY9AeLrqpXr4osauDK
         d/Yn4JombAnuBPvbluRvv30nqtxEJ8ZspBhQG7GAMgsmn3cONHz1EON5JJ58i9Ld6j6J
         BSmpPQx+AqFn20PbH4S/CiBuCWpzSZVQCVBeWbbaJXA47gSa2lbTaBiZ3p8vEsCblzAq
         jZsb0hD/36mutqj6w8N0llaNorUBnHCrXNhYcxs5GY1wdpYmcyKmtl+1CVxBTyGBKYSB
         Jo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133998; x=1741738798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocfBqfPEo/ZGjFNCT7umNcOBhbM/4xfpitCEs7MgftA=;
        b=lxAOSdv4LzipIzL2WiYtGoKC7hMLQYMP58T0S46Petq/fSRkY6RQ1R4G4POHCwKw9O
         xageRtQw6v+Vpsq9WQ185fkifcftDn8cQwgYs3h/ILLBKMcmo0SkokuUnkKSH1fTsSF7
         //jawF+mCa3Jf1WBibjNwRVNQcUgS9yvB4gWPzpo8fBY9Ksuq0igV92kRDsgcM/ynrpF
         1z+2xki6hRJKn9g5uMpjVK+jdRVzY6iVhDqby8XV+RGmpOVghwTWW7Y42VGA8SVuhlKC
         0JjYgg+aFqeBPLnXhcd8yoOTG/lRqAPm/vXo3H6pjGzDXQ7cnK27V3TlT6dkuzQmbe0u
         XH3A==
X-Forwarded-Encrypted: i=1; AJvYcCW3IVx5bf7azTuSc2UyHxOnR1D+e9vaOc24x9pksperK8Q6Oq/zjxgUsT5XuIfz4nLyX9r1b9CurqM62Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyulVAvGSCOccR4U+xVcsTAz00Gp3zrdPe8rzuz7XRjZKLOjz+e
	YAAqdV5Ywro3QLOt9FdT2lKUHDrFotr1p6NQZ+z5YjaBdu/QkbQVe6MoZuRr3XPgpfSH7IvPOyD
	dqZNo66EzU7W6ei4bpCh8VQQNZEp5lV3M/Ewb
X-Gm-Gg: ASbGncsZfNmyxOK8t3LtjfwijWb8OVTxnAuRTq6DdiId83RKa01MRs7h0ZWDP0bH3Nl
	8WBJGzzcdChcYf5d0qwBqggqcGhXd9BPwQTyvetw4IwSDf8MVx54ptIePGSd5vHzkd66wHaOhl1
	OZcPvOa8C9wDJxyAkY4S4fd3W50A==
X-Google-Smtp-Source: AGHT+IGF/y0geooCPtJRjqZPvENGrM6G/jIaXoX7kcX22U7OqoXPhdA0YA3220WyCrgUujmfozkdhji7akGtDiTRuzs=
X-Received: by 2002:a05:6902:108f:b0:e60:a2e2:9359 with SMTP id
 3f1490d57ef6-e611e19a0bfmr1796526276.3.1741133997973; Tue, 04 Mar 2025
 16:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <e0e7c0971d42e45c7b4641bd58cb7ea20b36e2e1.camel@linux.ibm.com>
 <CAHC9VhSzc6N0oBesT8V21xuwB11T7e6V9r0UmiqHXvCg5erkVA@mail.gmail.com> <a1d6ce786256bbade459f98e0b4074e449048fee.camel@linux.ibm.com>
In-Reply-To: <a1d6ce786256bbade459f98e0b4074e449048fee.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:19:46 -0500
X-Gm-Features: AQ5f1Jow_JKN5Wb5BydtWrN3W2PF1ZW0sHwsGmKXbhetUZR51OWtnJRtrsmPv-Q
Message-ID: <CAHC9VhT27Ge6woKbBExu2nT_cQE79rG+rrgp3nDYjvjcztVQXg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 7:54=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Mon, 2025-03-03 at 17:38 -0500, Paul Moore wrote:
> > On Fri, Feb 28, 2025 at 12:19=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > On Fri, 2025-02-28 at 11:14 -0500, Paul Moore wrote:
> > > > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > > > On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> >
> > ...
> >
> > > Ok, let's go through different scenarios to see if it would scale.
> > >
> > > Scenario 1: Mostly distro signed userspace applications, minimum numb=
er of
> > > developer, customer, 3rd party applications.
> > >
> > > Scenario 2: Multiple developer, customer, 3rd party applications, sig=
ned by the
> > > same party.
> > >
> > > Scenario 3: extreme case - every application signed by different part=
y.
> > >
> > > With the minimum case, there would probably be a default key or sets =
of
> > > permissible keys.  In the extreme case, the number of keyrings would =
be
> > > equivalent to the number of application/software packages.
> >
> > Perhaps we're not understanding each other, but my understanding of
> > the above three scenarios is that they are all examples of signed
> > applications where something (likely something in the kernel like IMA)
> > verifies the signature on the application.  While there are going to
> > be differing numbers of keys in each of the three scenarios, I believe
> > they would all be on/linked-to the same usage oriented keyring as they
> > all share the same usage: application signatures.
>
> Yes they're all verifying file signatures, but the software packages are =
from
> different sources (e.g. distro, chrome), signed by different keys.

Yep.

> Only a
> particular key should be used to verify the file signatures for a particu=
lar
> application.

That's definitely one access control policy, but I can also envision a
scenario where I have just one keyring for application signatures with
multiple keys from multiple vendors.

> Clavis limits key usage based on LSM hooks (e.g. kernel modules, kernel i=
mage,
> firmware, etc).  It's a good start, but even this probably is not fine en=
ough
> granularity.

Which is fine, but like I said earlier, it makes far more sense to me
to move towards usage oriented keyrings and then apply whatever
additional access control granularity is required to meet a given
scenario.

It's also worth (re)mentioning that what makes Clavis not-a-LSM in my
mind is how it is implemented, not necessarily its security goals.  If
Clavis were to be implemented in such a way that it only relied on
security/LSM blobs and not keys/keyrings it might be more suitable.

> > > > My takeaway from Clavis was that it was more about establishing a s=
et
> > > > of access controls around keys already present in the keyrings and =
my
> > > > comments about usage/spplication oriented keyrings have been in tha=
t
> > > > context.  While the access control policy, regardless of how it is
> > > > implemented, should no doubt incorporate the trust placed in the
> > > > individual keys, how that trust is established is a separate issue
> > > > from access control as far as I'm concerned.
> > >
> > > Clavis defined both a mechanism for establishing trust and access con=
trol rules.
> > >
> > > Clavis defined a single Clavis key to establish trust.  The Clavis po=
licy rules
> > > were signed by the Clavis key.  The Clavis policy rules defined the a=
ccess
> > > control.
> >
> > Unfortunately I think we're getting a little ambiguous with how we are
> > using the word "trust".  Just as "security" can mean different things
> > depending on context, so can "trust" as the qualities we are trusting
> > will vary depending on context.  I'll leave it at that for now as I
> > believe we are talking about different things in the paragraphs above.
> >
> > Regardless, I'll also say this regarding Clavis and key/keyring access
> > controls - as implemented, Clavis doesn't look like a LSM to me for
> > the reasons already given.  If all of the various keys subsystem
> > maintainers believe it is the Right Thing To Do inside the keys
> > subsystem then it isn't my place to have a say in that.  I personally
> > believe that doing the work to support usage oriented keyrings before,
> > or while, implementing a Clavis-like mechanism is the better option,
> > but that is a decision for you and the other key maintainers.
>
> "Usage oriented keyrings" similarly implies any key on a particular keyri=
ng is
> acceptable.

Yep.

> Without understanding what you mean by "usage oriented keyrings", I
> would assume it would work initially, but eventually it too will not be f=
ine
> enough granularity.

It all depends on what your goals are, but like I said above, it
really seems to me like this is a good first step which can be
followed up with additional granularity.

--=20
paul-moore.com

