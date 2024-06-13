Return-Path: <linux-kernel+bounces-213989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA58907D66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B291C25059
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF913B294;
	Thu, 13 Jun 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSwVCT1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849E12EBF3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309952; cv=none; b=oZPFQawK+wdqvbN9QjaailRZyRwv+W+RdoFSXfpCaK7xqzOeN5Vtd+97U7ko/F9Y7IfGC3t4FBrLJgF6l9TRRQHcKcp/azRRLoWWwsYfhdJMaRSPq9+/2VBaSMqkkkAFb8fkLOfjlJrb0IV+W4wCcx0i+VhEjwE6NRkRYdU2k/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309952; c=relaxed/simple;
	bh=Jqdp3U67GObwq5246ghxD3ALRxVeQ0KFTivrPhuYxVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h4K4jq3XXTxxHDyfERoa0G5w/MldhPtpGBKEmBmvil/PaPgnUpZnzDUFcuMiOIpUNEFy0DLN7+eH2QiixWL1ORAk8E7ysBzW0Wr+SnMlbEZ7Njd3Uh1GS4Lo/NyeOhkJZ59Fn91AfbTV+Skp7WGIEMPaUT056b41KWnm/iLlVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSwVCT1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718309950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jqdp3U67GObwq5246ghxD3ALRxVeQ0KFTivrPhuYxVc=;
	b=DSwVCT1kX9vcqgcMa64M+1TcDEkJa/bq3WkwRkHELNjkEZBx3oRzvF3qBV5XcHfLjC/95n
	Le2bWuOKY9XxrV/buAjsWMoob+kx+nFkvRrfFmGiw0ojo7CXmmC0NkJK+ViM2uc41akeHU
	2Vjytm2OBqgDCwehvtpqlqw0ongOLwc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-a0rok003PZ2vj_TH28hpnw-1; Thu, 13 Jun 2024 16:18:58 -0400
X-MC-Unique: a0rok003PZ2vj_TH28hpnw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b2aec935f5so4529456d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309937; x=1718914737;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jqdp3U67GObwq5246ghxD3ALRxVeQ0KFTivrPhuYxVc=;
        b=c+R2791pjuvfzICoYK3c+bpqLCVRyNNopE97dl77U5cbNNtmJQN+O5HgPMDjBqRhzA
         TQfL0WYTnruHxw8olyrC82CbQjipGcBEdj1MUZN+auBcFKGhlWRyF3L19lda63ov6LBx
         G6D7HV6fNl+qkJIsrrnOkdfpjoCu2uaBL8xOBUf9sh49QWmP/dvOkgEdmLJr9y8N3QbM
         iKJDS0WMY1Va3EA0Bw9DjmR7N3zkIfBH4y/K5OO6e3bOSRylkpr+mis5ZhnpPRhLuAj9
         PJIAWj8ky1LbZmU4VVLuzIXdlrBj2Xle0iaEAoP3lY6UilkyAIWhd90x7nQjdl0Ml/n5
         tInA==
X-Forwarded-Encrypted: i=1; AJvYcCXpwz+OcjAa8Vz3h5nf/UIn1yzdZjV4ZexH+TOrLz1ORlscw/PIlTsD6pYRLEtyyPzGzmZxpYtgFNeTHNMnLEVIG+2xnfaxQ+IfmKah
X-Gm-Message-State: AOJu0YwYqOpiW6YjzraHDx6ZHjR3P0IjUVAcA6GzrDKCK99rGoAdWAnG
	5Dr+EUBiXwDwuHEgqynvGsFOJUxDPN5h1zpyI9Nqyi4ElRaDtylINPcZtOSCnQLJvXZ805Y81H2
	ZRYclLQ76y7kyrukJgaDlGqB0wOV5B4tajHk7LzG8PzhjNevHwiyxDIIC2ISxyg==
X-Received: by 2002:a05:6214:5016:b0:6ad:650a:855d with SMTP id 6a1803df08f44-6b2afc9e1f1mr8824556d6.23.1718309937640;
        Thu, 13 Jun 2024 13:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErJd8M9fqhwfjCydqbIqLlZFHMREZAW10/WLYJOeLO/N0JndEwGAHhKdPLaAPDMteuOgnpLg==
X-Received: by 2002:a05:6214:5016:b0:6ad:650a:855d with SMTP id 6a1803df08f44-6b2afc9e1f1mr8824256d6.23.1718309937268;
        Thu, 13 Jun 2024 13:18:57 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5efb07csm10255266d6.134.2024.06.13.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:18:56 -0700 (PDT)
Message-ID: <3fae55cb4012c137072b54f4ec96027190958048.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
From: Lyude Paul <lyude@redhat.com>
To: Danilo Krummrich <dakr@redhat.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rafael@kernel.org, mcgrof@kernel.org,
  russell.h.weight@intel.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
 wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
 airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com, 
 ajanulgu@redhat.com, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 13 Jun 2024 16:18:55 -0400
In-Reply-To: <Zmrkg7oOceWWV4nz@pollux>
References: <2024061136-unbridle-confirm-c653@gregkh>
	 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
	 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
	 <2024061245-kangaroo-clothes-76e1@gregkh> <ZmnAOfCUFkZqhDji@pollux>
	 <2024061214-dusk-channel-e124@gregkh> <ZmnKXoBYf0qOcPU4@pollux>
	 <2024061254-scoured-gallantly-5e41@gregkh> <ZmoLi57aT4EB_97W@pollux>
	 <2024061345-troubling-visiting-830a@gregkh> <Zmrkg7oOceWWV4nz@pollux>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 14:22 +0200, Danilo Krummrich wrote:
> On Thu, Jun 13, 2024 at 07:47:13AM +0200, Greg KH wrote:
> > On Wed, Jun 12, 2024 at 10:56:43PM +0200, Danilo Krummrich wrote:
> >=20
> > As someone who has written comments in code for functions that are
> > always ignored, I am happy to see you think that this is actually
> > going
> > to do anything :)
>=20
> One advantage we have in Rust is, that if something has a specific
> requirement
> we mark it as `unsafe` and the user of the API has to put it in an
> `unsafe`
> block, which we require a sfety comment for, where the user of the
> API has to
> explain why this is the correct thing to do in this case.
>=20
> In other words we can technically enforce that people read the
> comment and
> explain how they ensure to fulfill what the comment asks for.

Been going through this thread to catch up on the status of the patches
here: I've been working with danilo for a while, but have been busy
with kernel modesetting bindings for rust. Anyway, as someone who's
spent quite a lot of time writing up really detailed documentation for
some of the DisplayPort MST kernel APIs only to keep running into
situations where said documentation was ignored (not to criticize
anyone! I'm certainly guilty of having misread documentation or not
reading something myself :) I like to think about unsafe blocks in the
sense of being one thing I'm less likely to have to keep repeating
myself about over a mailing list. Because I know at the very least that
a contributor has to actively ignore a compiler warning or be aware in
some sense that there is some kind of safety constraint they're being
held responsible for that will come up during code review. If it's just
a comment in C code, I don't even have a guarantee that a contributor's
IDE isn't hiding large kdoc comments by default.

Also, in regards to rust code relying on C code not being guaranteed
safe even if it is 'safe' code: frankly, sometimes I wish "unsafe" was
just named "danger". "un-safe" implies code outside the block is
perfectly "safe" - but it is still possible to introduce UB in entirely
safe code bases (source: cve-rs) and most rust contributors I've talked
to don't see safe code as being perfectly-safe either.

>=20
> >=20
> > Heck, I have put huge messages in kernel code for when people
> > implement
> > the api wrong[1], and they still ignore that at runtime.=C2=A0 Only way
> > to get
> > it noticed is if you break someone's build.
>=20
> You only see the ones who still do it wrong. You probably don't have
> visibility
> of the ones who did it right due to your effort to write it down. :-)
>=20
> >=20
> > So you all need to really define what `Send` means, as it sounds
> > like a
> > userspace thing that isn't going to fit in well within the kernel
> > model.
>=20
> Please see the explanation above.
>=20
> >=20
> > thanks,
> >=20
> > greg k-h
> >=20
> > [1] See the pr_debug() calls in kobject_cleanup() as proof, people
> > just
> > =C2=A0=C2=A0=C2=A0 create an "empty" release function to shut them up, =
thinking
> > that is
> > =C2=A0=C2=A0=C2=A0 the correct solution when obviously it is not...
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


