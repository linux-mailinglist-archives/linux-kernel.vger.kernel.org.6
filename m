Return-Path: <linux-kernel+bounces-306062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136189638B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE32B285C39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301D24F20C;
	Thu, 29 Aug 2024 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="V5Dy5ekw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BBD3A1DA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901440; cv=none; b=dqjCRFlMVfN/IZN4dYY6TJWzzP6Yt9sLknU5za4DxxziYFtbQ8xmphLi0AG+YsgY/kvgMsZ2uUSIoJpTUiF4Y7xgjidZ0GwF89fka3z/L+AJAcoZE+7zbRni/7ZQoMOD1y7Zxsv3qH7q2lSAf7xRNklmx5c9eq0bJyxUn8RvOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901440; c=relaxed/simple;
	bh=2aTnaXW705uxQNx7oNYfenyF4g7+kMVW1ZmdnZoGpwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txiaX2bgMMnOunEvW3fK7uYl5JDcGZqcROSANiwLqdZ1jtdlxtye6WgvDU5coI2kQQzf38OV6gUQJvoRKOFqa63z4ov4aqJ3xaP60/hdUbvLR8prYPCWFC9K15Hy9/Spd7XfOxUR1G1kgAMUcTz/1CffqIrnwTTw3IgsQmI14Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=V5Dy5ekw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso128357a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1724901437; x=1725506237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNmzosmlE3keF9ZOCKanmUq6J3PfB9qYT5nEB2uhPjQ=;
        b=V5Dy5ekwSz4wlE7HIog3NxMEqjOmIkwJJvBJI80QQjk5dv0AllEip3f/d0NrqLAaHv
         cA63UJtIQlP40O7dftABI7mbjgbdLfBu4FWt3Bq3lVfREK4HLx8wT4BFMVtfZ0QOxswt
         vY9CPSS+wSbJZ3nokNkaANEVjcmjKENxLvnmMiqEQVSthWf7v4f+SW3bcUTISkOZOzxu
         prvnwSKg9iKmYoB5JutyocnBiMZxiqpra6t4HKKLymEO3K7YsLRFLOIZryJlHZ09fmLj
         Of9O27H6Nx0n2PjerFUsF5Q2McYvlwTLu4QNmEazbBquYEzt5eMQ+nPCfbV+qOMKUThK
         3eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724901437; x=1725506237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNmzosmlE3keF9ZOCKanmUq6J3PfB9qYT5nEB2uhPjQ=;
        b=FSHg2Y62mp0lpmWR+XiirNk9PQ5jHjrPD/tP67ldMIXtwzDUOre2UPiL4S6HUleHpL
         C1xeDI/O10cLnbhjkJzrZ9C8qlKfW7dy343DnYJVzWSX9EM9PWV4wICx+VDqqzBycwk7
         zHtwf44FF1Zpi2g6vjwd0X1o7XmwjE4soOrmWKsJoZh6nuS5DKvdnnzAPJa1j5+gMXet
         wnngsAPn9y0Lh+WupqwY94LKDdaxCKizo06toid7Zj4rVJp1uUy4X65GZiPkNgJjtrFF
         Leey/67btRRDwMJxCYAMsLC0Nt1/cfOL/acJX1eH7tQ+urxvW6k0uTBcw2mslt3my7+q
         7Tow==
X-Forwarded-Encrypted: i=1; AJvYcCXC1lN2u+ltmriBUSA4wWGwDEPlfrjL/pk9rGeN8ztzIozJBtXXMoSgajnMcEXuNIU6gjwO2NqHXfpl7xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2aEVjGNF0gsMk6OnMLPMQ+Yd6gmXHqdc1Z8DRpJ6VJ90XTy9t
	pCs7Hqp7JKHl2gvMjE6obnV00oXJ9ZSVtHdKAel8a3z589ZQZGZs9D28giNCYoEOZM89GFtzudh
	iyCzvugMyd7ZPpEot4JXxKxA++4+78ZNxVhr90imrORuKjjY=
X-Google-Smtp-Source: AGHT+IFEtovpRJEIjkfJeoX6oyzRzBMJpdpEM5rys6Mzg7Lm/FHfWD6uqtRHPHJtPhzPqMuGNpCp0pksl5KfgHXNdDI=
X-Received: by 2002:a05:6402:518e:b0:5bf:c8:78a with SMTP id
 4fb4d7f45d1cf-5c21ed5316amr952709a12.17.1724901436704; Wed, 28 Aug 2024
 20:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
In-Reply-To: <87ttflli09.ffs@tglx>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 28 Aug 2024 20:17:05 -0700
Message-ID: <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> > On 5/31/24 09:54, Eric W. Biederman wrote:
> >> Eric Biggers <ebiggers@kernel.org> writes:
> >>> That paragraph is also phrased as a hypothetical, "Even if we'd prefe=
r to use
> >>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256=
 only.  Is
> >>> that the case?  Sure, maybe there are situations where you *have* to =
use SHA-1,
> >>> but why would you not at least *prefer* SHA-256?
> >>
> >> Yes.  Please prefer to use SHA-256.
> >>
> >> Have you considered implementing I think it is SHA1-DC (as git has) th=
at
> >> is compatible with SHA1 but blocks the known class of attacks where
> >> sha1 is actively broken at this point?
> >
> > We are using the kernel's implementation, addressing what the kernel
> > provides is beyond our efforts. Perhaps someone who is interested in
> > improving the kernel's SHA1 could submit a patch implementing/replacing
> > it with SHA1-DC, as I am sure the maintainers would welcome the help.
>
> Well, someone who is interested to get his "secure" code merged should
> have a vested interested to have a non-broken SHA1 implementation if
> there is a sensible requirement to use SHA1 in that new "secure" code,
> no?
>
> Just for the record. The related maintainers can rightfully decide to
> reject known broken "secure" code on a purely technical argument.
>

Wait, hold on a second.

SHA1-DC isn't SHA1.  It's a different hash function that is mostly
compatible with SHA1, is different on some inputs, and is maybe more
secure.  But the _whole point_ of using SHA1 in the TPM code (well,
this really should be the whole point for new applications) is to
correctly cap the SHA1 PCRs so we can correctly _turn them off_ in the
best way without breaking compatibility with everything that might
read the event log.  I think that anyone suggesting using SHA1-DC for
this purpose should give some actual analysis as to why they think
it's an improvement, let alone even valid.

Ross et al, can you confirm that your code actually, at least by
default and with a monstrous warning to anyone who tries to change the
default, caps SHA1 PCRs if SHA256 is available?  And then can we maybe
all stop hassling the people trying to develop this series about the
fact that they're doing their best with the obnoxious system that the
TPM designers gave them?

Thanks,
Andy

