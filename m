Return-Path: <linux-kernel+bounces-565169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA57A66221
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B685F3B7E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527C204C35;
	Mon, 17 Mar 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U64cwzbn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852921EEA20;
	Mon, 17 Mar 2025 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252218; cv=none; b=cWIBHWqBn5lWqz4WHnQcWGrDyA8KzoZgDLAvDRFs/yyh976ZFmcLI6Cr3wA4PslEIEpuo/GMavR1bvoE+6GaE9C62QCJ7X8zNaQr3vspstkGWrGMu1j99VJUAmw4QqxY64Jnwc5xpqWa3ZjLULotWovHTP9frGzsm7t0WC0Nyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252218; c=relaxed/simple;
	bh=lLa5+DE9kYUZUIHBLV6bf/7Xa4sPQDu2yEbHQBMRj3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQyIMkb3eUOYai1f2g+bcfZkpE1lBw2tAicNYFQwisTkwllGSMClFTXUJa7Z8p1Scydn+RqXmEBp2J8w01HrhEchxKs8NPPquhMz2yHQq3W4A/Esv6SAgASaf8JF/hoi/SiPT/ZlQ4KJZYUOMfE0xE7guNYeKJ2CPl7kIEqiiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U64cwzbn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so786107266b.2;
        Mon, 17 Mar 2025 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742252215; x=1742857015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ohnbD9HST5mn+5PVHLWOCx41oZ6CqeGk3ifbuefAvzA=;
        b=U64cwzbn+XameZwVjpiKiI9a1fX50QezocGI17w6b3LHBCVh3L/IKem5Nv1HCvRBjO
         KclVw1FwAUVkJ5t0qZpaCu5xse/L/vD1Zn5oJEioBrcl60NOBCnWGV6IqzYwJdwFI5S3
         gyghE/P6l/0VLsBX1BVBNOdB9H+aLjp3en6ZAnnNNIWT9yEUUebZZFmLQNCX9hGaIbeQ
         zxO+Ate/qlkRJZiQpOmyq5+EzPH01R4TliMamytUUrxsHAYx/YR+ZFvKutDf6+xriK/x
         6lZ8VAf4D3rqNDl/YU4fc0WBet6/kwfXo0AK0m811yVzmXsaou+3Q8H1NstoeSs5OC+5
         /Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742252215; x=1742857015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohnbD9HST5mn+5PVHLWOCx41oZ6CqeGk3ifbuefAvzA=;
        b=fQIeEgDdFJTtWNIdRdHejvufySVw+xJljg6Xt6taPoSfno5gH+y+EUHqdfSZ6g0HI6
         Sf60m/VuELQhMc1YnFse6ykYmcY8tu25vOXes4IYxFJKNjiwxID+hqj344eCJyGG/yj3
         gRnMTZQFmXnXiAmAPMNoMMGVlj2Ijgl+5zCfNfGDSbx91i4k5VXHa18TGmD/auCRSAVU
         JBa/YFiNbcdytlAPo9Id/5D8BV091WMRB+rcuWubU5Dz+7DV3sFLHIdoNRVJSHJcFRCs
         y8fCKFnfiUrmVMd4FIN8iE4gIMEsC5ptGO8nDuugpqDMs/M4rm/+QrtB/uhs7HaRC5dZ
         udiA==
X-Forwarded-Encrypted: i=1; AJvYcCVK7uYq9ILdi18pJwYYO0Y5MCUsFIKLazQEJE9PEBD2Mv0oUDV1Mx5ipsyEuoH3jGNNERnW3tCjH9w=@vger.kernel.org, AJvYcCW9XFVXhf092H/CV68Ky8dYY2CpEiGaKgm1U5kgqqsyu4pNwDc7XMJME2nh1QKDm7aqzY0xRLnAmh8tkICw@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxDk0WoMPSfoWCYv30isohJ18MdniIfrSwdFGn3AQIqDRelv5
	Vnw21/Sj4H8KCwqVGZl3xvV22muv1tyHAryWPi52XzkX7X5b64Xp7D/SHYvsZddnQJexXagf2uk
	5FRmf9UjRR/vUjS439BPMLRjEdpk=
X-Gm-Gg: ASbGncsKQfilh36QH+AwKOAc17OXxSgCJiTBF/CE4R8LYxFAfflj2pK44qcmc5uG08+
	7Rm5vJzYJrIwP7DyrcmthzzUqXmVOF1fmQWw0xYzzZaQA7f3r74QBN2xvIKBZK0++U3BirYnOy5
	6L9ZaE2H9i10t4FuzILpgAg//4
X-Google-Smtp-Source: AGHT+IG5c2AKfafLHhqewzGjoy7JQPZVl1/smJNnze77drFWI3ZuNyHqFeaM/mxCilbOmM5Q4oVA7/RiV8IU8XBCbIg=
X-Received: by 2002:a17:907:72cf:b0:ac2:bcf3:b19b with SMTP id
 a640c23a62f3a-ac38d8d1f2emr116636466b.49.1742252214473; Mon, 17 Mar 2025
 15:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314100137.2972355-1-jacek.lawrynowicz@linux.intel.com> <874izre0aq.fsf@trenco.lwn.net>
In-Reply-To: <874izre0aq.fsf@trenco.lwn.net>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 18 Mar 2025 08:56:41 +1000
X-Gm-Features: AQ5f1Jp-xAiBDwu3-_7K3Dlm6rUr4V1lmAoixbXtePi_ukSPK5ZTUaJK2e2pCOs
Message-ID: <CAPM=9tzv+=+ZGRtHgapUVAiDjHn=Bp33BqyLLQKDuKsR-AoC7A@mail.gmail.com>
Subject: Re: [PATCH] docs: driver-api: firmware: clarify userspace requirements
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, linux-doc@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	simona.vetter@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 08:53, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com> writes:
>
> > The guidelines mention that firmware updates can't break the kernel,
> > but it doesn't state directly that they can't break userspace programs.
> > Make it explicit that firmware updates cannot break UAPI.
> >
> > Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> > ---
> >  .../driver-api/firmware/firmware-usage-guidelines.rst        | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/driver-api/firmware/firmware-usage-guidelines.rst b/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
> > index fdcfce42c6d28..5f8f13e2ee510 100644
> > --- a/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
> > +++ b/Documentation/driver-api/firmware/firmware-usage-guidelines.rst
> > @@ -42,3 +42,8 @@ then of course these rules will not apply strictly.)
> >    deprecating old major versions, then this should only be done as a
> >    last option, and be stated clearly in all communications.
> >
> > +* Firmware files that affect the User API (UAPI) shall not introduce
> > +  changes that break existing userspace programs. Updates to such firmware
> > +  must ensure backward compatibility with existing userspace applications.
> > +  This includes maintaining consistent interfaces and behaviors that
> > +  userspace programs rely on.
> > \ No newline at end of file
>
> This ^^^^^^^^^^^^^^^^^^^^^^^^  is a good thing to avoid.  That can be
> fixed up at apply time.
>
> Dave, you're the only one with fingerprints on this document; is the
> change OK with you?

LGTM,

Acked-by: Dave Airlie <airlied@redhat.com>

Dave.

>
> Thanks,
>
> jon

