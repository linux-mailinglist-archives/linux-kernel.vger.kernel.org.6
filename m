Return-Path: <linux-kernel+bounces-571837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB3A6C2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423D57A7AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9B22D4F1;
	Fri, 21 Mar 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gXeRSXP8"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB8154426
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583966; cv=none; b=Ms/HYrXgm8dKUps24EvFbU2AMiN8TGOl0DOsUJKTudIG5MqWVA5JaJy8bJxtfCALuRl14+Zeaa2DmUqcofd0ztsDKUF6L6X2veQnt/nusyW+nkloAD6W1Mn+LWN0POED47u3YNj6wpMUa/7xPaFU5ggPDovT0Zo4oQD61y6TFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583966; c=relaxed/simple;
	bh=sPA3YMc7zB5fmsVIwEgENpeTURZ/iV7aheO5rZV+wXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duut5WoEJV46B5J9NijY4B3tfI+w7xSDJlBkQW55Hf6G+FF7FMPXlgnLScOoodQ/BmqRM2Q/QQIQe8hA087KRcEp06RZKwIy7MmderqbYnKXTYsc6RyUHuDqqEtnB19+MXUvQRwtliDVlfRfo72zQsfA6S0z86zwe8wI1HFiSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gXeRSXP8; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso3012404276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742583964; x=1743188764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nSFzAgQaMCuwvxmSdJkfWwEiaWngP9LwXhsN0dSMzo=;
        b=gXeRSXP8CvCeMqi8JRY6Yi1ynaSX2ubPjv4cZVo9lJ1KaE0hpliskj+dq/hb9lvA0a
         0qY2B81JGVh/PLt1HbFDVP1t0iZ+rk3a3iF11Fe5MNVttoxjtqG3jp/+aC2rXQ1ptXzt
         HtRaCP06kNfcHf3FlQ5aQy2pMenXZ6FYJAkhw6DcZaa9bw7W51BNBHJ1U4I47KepOuTW
         M91CiaNmgPqI2w708nVgYHvFXnHgrvvv57Rmxo+lx2z6/ciB2dMyn8YYFq490fzuNFuQ
         6ii/pFCvYtrUdffRNrhkfgSZ9rtTRyF0Up3UIPT+Kse+41Miv0mAoqlA+n0vCUc5gUhE
         EO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583964; x=1743188764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nSFzAgQaMCuwvxmSdJkfWwEiaWngP9LwXhsN0dSMzo=;
        b=V8bqQ1gGSld987kzaYnT5tOVAnqLjeOCPviUL12gKW10UyG7Bup13og0WQ6KlxI+1c
         EKAcAC77njlqYazfIwRTUE/q2aBq5K3ZtAZwghN8mT0o5fvcBauSSn4yUG1CX+i+SmAy
         GnWjiCeLUKs19ICWcEedqAm4FKDBLPnoAbD6p87KL3sygCimFhzUBmVxpnNv/RHMmBs2
         Kmj18pSFjruaPUvukSjnuo6pXpAHuaA3yWXxlmor9UrhD0HAUlmGujB6RjiTNwTItxoD
         xgMlgAwdS5twqpz8WNcgQtrGB5s136vILOorZytalaKusENbACSQc4pfkhejarfAVwfl
         L5QA==
X-Forwarded-Encrypted: i=1; AJvYcCV8GtxcST8g6ya6G7SSptU/nXNg+nwT75w5mSlb4FIvrf9FkE8mjyQJOp4jlnNb15s5W1ce9vGYx81u2ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsXxkaEyf+wbijyfC6ak36i2cBznCDeUVfU36GHUNpJktVwMj
	1EDVhZ/ETASm1vrc4Rq4aTNO+FoppmsHpx7rpfodP22lSAdfk/yBpXAyYfaV+EkSPZZZYXHbSqy
	48ZtlXR4vDgFOVaMPBEoicXIDEfonyaGvvjIv
X-Gm-Gg: ASbGncv+SwtEtfdvUOiTm/vRI63GKQKTdlBomAKXHNx1xZ0VNHZfGqnUhznIj2NK6Cs
	1oO974baQ3VHcJQxDkW9r+esEorB+6J2NnqG7r6724CH4hpVvhqx4Zi/hQ5g0kSybgPy2K+1doi
	DZZEaUWhT8hN2POhON/rfmyoMIfQ==
X-Google-Smtp-Source: AGHT+IH/+vybMPgjTy+Q/lR+WQGG9I7BYYRaZ8XGvbeWqhA0zAi7QHXEcXle+vpl3pUGz1AEgz4oOGz9sgmGVmlf3/8=
X-Received: by 2002:a05:6902:4a8d:b0:e66:a274:7fff with SMTP id
 3f1490d57ef6-e66a2748117mr6225899276.21.1742583948895; Fri, 21 Mar 2025
 12:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com> <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com> <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com> <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com> <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
 <Z92gTQj6QkedbH0K@kernel.org>
In-Reply-To: <Z92gTQj6QkedbH0K@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 15:05:38 -0400
X-Gm-Features: AQ5f1JoCVuy6gH5pZ3qt9eL4_YTiGz_EbkGoV-AHORqyWmdnqKeKo0JNC59Hn0c
Message-ID: <CAHC9VhSi06azJ+b5YgLuDM6xff2401ArMM6LoP0vsqsUgz6VNA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
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

On Fri, Mar 21, 2025 at 1:22=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Thu, Mar 20, 2025 at 05:36:41PM -0400, Paul Moore wrote:

...

> > I want to address two things, the first, and most important, is that
> > while I am currently employed by Microsoft, I do not speak for
> > Microsoft and the decisions and actions I take as an upstream Linux
> > kernel maintainer are not vetted by Microsoft in any way.  I think you
> > will find that many upstream kernel maintainers operate in a similar
> > way for a variety of very good reasons.
>
> This is understood. If one takes a kernel maintainer role, one should
> unconditionally disobey any vetting by the employer (even at the cost of
> the job, or alternatively at the cost of giving up the maintainership).
>
> And with you in particular I don't think anyone has any trust issues,
> no matter which group of villains you might be employed by ;-)

Haha :D

> > The second issue is that my main focus is on ensuring we have a
> > secure, safe, and well maintained LSM subsystem within the upstream
> > Linux kernel.  While I do care about downstream efforts, e.g. UEFI
> > Secure Boot, those efforts are largely outside the scope of the
> > upstream Linux kernel and not my first concern.  If the developer
> > groups who are focused on things like UEFI SB want to rely on
> > functionality within the upstream Linux kernel they should be prepared
> > to stand up and contribute/maintain those features or else they may go
> > away at some point in the future.  In very blunt terms, contribute
> > upstream or Lockdown dies.
>
> Could Lockdown functionality be re-implemented with that eBPF LSM? I
> have not really looked into it so far...

I haven't looked at it too closely, but the kernel code is very
simplistic so I would be surprised if it couldn't be implemented in
eBPF, although there might be some issues about *very* early boot
(Lockdown can run as an "early" LSM) and integrity which would need to
be addressed (there is work ongoing in that are, see the recent Hornet
posting as one example of that work).  Beyond that there are
policy/political issues around that would need to be worked out;
nothing that couldn't be done, but it would be something that we would
need to sort out.

However, as I mentioned earlier, with Lockdown already present in the
kernel, deprecation and removal is really only an option of last
resort, and I'm hopeful we won't come to that.  We've seen some proper
Lockdown patches submitted overnight (!!!) and I'm discussing
maintainer roles with a couple of people off-list; with a bit of luck
I'm thinking Lockdown might be properly maintained after this upcoming
merge window.  Fingers crossed :)

--=20
paul-moore.com

