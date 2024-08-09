Return-Path: <linux-kernel+bounces-280648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B3994CD44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597161F21D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972D11917D0;
	Fri,  9 Aug 2024 09:25:12 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05518FDBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195512; cv=none; b=A1mqyqjfRpVO7PN7573V5C6DVorGr4MBlb0EnAvrw82GQP4f9gPxxtPIN/OVBgFsLFW9mO3RQCErIzSHaUDdiqJf1NxpqPYNVeeELArMvHc7fk6ALTR4McaCQpAthz1th6VaoAP89f2MW2Yp3mWSkrTERVvU7X820hjPHqGm+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195512; c=relaxed/simple;
	bh=21tmuR+uEpjf4I8oa+7Fks6/ar1LljS186mc/7Sb2BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk/SoTPa6sAOKz+Q1EcJ/SS+PuNzLMkqLxB56wfnRBRRpJGn92XAi4Aqse3XVzplMLo7Gmqw6EJw8YzDEu1Ww9iT97N36I5vqplEPPgHFabQaD8OAKl6tTKykpKEsK+2n8ZZ71YdRmVXeMcFa+w9QEKnL+nu6uNsKH3QbeqGneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-492a09d4c42so656591137.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195509; x=1723800309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmzmq7HALPWLcX9GnDg2w3rFPxXduK8YFzJI7L+SaRo=;
        b=PbWo4+DE9K8xMegyCys0A3KlIyRsJmAsZW8jn3LNZen54N+Gzgnid6yoPDP11nNSWa
         vJqOOi0/GyWywhNf9aQSVnliqBN/9KwEjYnupdhdwbXLlxuCCSXp3MFEmwomgRaSqHIA
         Nm0cvMC4LMyhQ+wkItZrKJLJ0ZQO+h79P/3iXdvFoBsSdAW2Ln2jVmfqPaZFrEkXBpLh
         YM8GXwjykb3m95R4a6R6BYEUgjpzvn1EkyrTQC5EroJQoSM/FC7L2Grqor+rBbrGb3s0
         RuISNUDVc0zgp5FYCd1pcyTdtonQhgpJOwtPgXMumYdVzt/p3XryfKjfmcxzvNMC3zqm
         lPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqdav7+bttj71gL1t3zqCkQKtJYAAvQMI8DqhyHyl2hJipXzqV9BtE5UKprwCf57G6ofaZdSDSe6gv3Ey0DbzHv/e4x1qfU6OUsaIu
X-Gm-Message-State: AOJu0Yx2TDxhv3eePFlA/iwSZgRh5nmO96JVxo8d/J386oHLBj690dSY
	E75yF64F/zeWQzVZjE+tLHGrcNIYSOZ+KKO2jTrorIJMEimKHxoI9wU3ZoaLoOSaT8Q7x7yTQ9h
	F2/AiO9/gu0cxr+Q0kM9sby1orv09z/Bb
X-Google-Smtp-Source: AGHT+IFykyb073NTa+DKA+15uG7iZC4IMttVG3aLBdscCwbHSk73gRZM8qT7bs6w229V+xr56S6FlW5GxbNhGve69tw=
X-Received: by 2002:a05:6102:dc6:b0:493:b965:7d03 with SMTP id
 ada2fe7eead31-495d84538cdmr904222137.13.1723195509209; Fri, 09 Aug 2024
 02:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808101700.571701-1-ryan.roberts@arm.com> <99b78488-c524-4269-b1fb-a13eaa4f274c@redhat.com>
In-Reply-To: <99b78488-c524-4269-b1fb-a13eaa4f274c@redhat.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 17:24:56 +0800
Message-ID: <CAGsJ_4z2D2yWWZhUM_yDSdn9=zpkYkHhzAKO8CQ1Xu3gDaECRA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:19=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.08.24 12:16, Ryan Roberts wrote:
> > Add thp_anon=3D cmdline parameter to allow specifying the default
> > enablement of each supported anon THP size. The parameter accepts the
> > following format and can be provided multiple times to configure each
> > size:
> >
> > thp_anon=3D<size>[KMG]:<value>
> >
> > See Documentation/admin-guide/mm/transhuge.rst for more details.
> >
> > Configuring the defaults at boot time is useful to allow early user
> > space to take advantage of mTHP before its been configured through
> > sysfs.
>
> I suspect a khugeapged enhancement and/or kernel-config-dependant
> defaults and/or early system settings will also be able to mitigate that
> without getting kernel cmdlines involved in the future.
>
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >
> > Hi All,
> >
> > I've split this off from my RFC at [1] because Barry highlighted that h=
e would
> > benefit from it immediately [2]. There are no changes vs the version in=
 that
> > series.
> >
> > It applies against today's mm-unstable (275d686abcb59). (although I had=
 to fix a
> > minor build bug in stackdepot.c due to MIN() not being defined in this =
tree).
> >
> > Thanks,
> > Ryan
> >
> >
> >   .../admin-guide/kernel-parameters.txt         |  8 +++
> >   Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
> >   mm/huge_memory.c                              | 55 ++++++++++++++++++=
-
> >   3 files changed, 82 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index bcdee8984e1f0..5c79b58c108ec 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6631,6 +6631,14 @@
> >                       <deci-seconds>: poll all this frequency
> >                       0: no polling (default)
> >
> > +     thp_anon=3D       [KNL]
> > +                     Format: <size>[KMG]:always|madvise|never|inherit
> > +                     Can be used to control the default behavior of th=
e
> > +                     system with respect to anonymous transparent huge=
pages.
> > +                     Can be used multiple times for multiple anon THP =
sizes.
> > +                     See Documentation/admin-guide/mm/transhuge.rst fo=
r more
> > +                     details.
> > +
> >       threadirqs      [KNL,EARLY]
> >                       Force threading of all interrupt handlers except =
those
> >                       marked explicitly IRQF_NO_THREAD.
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 24eec1c03ad88..f63b0717366c6 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would bl=
ock the collapse::
> >
> >   A higher value may increase memory footprint for some workloads.
> >
> > -Boot parameter
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Boot parameters
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -You can change the sysfs boot time defaults of Transparent Hugepage
> > -Support by passing the parameter ``transparent_hugepage=3Dalways`` or
> > -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever``
> > -to the kernel command line.
> > +You can change the sysfs boot time default for the top-level "enabled"
> > +control by passing the parameter ``transparent_hugepage=3Dalways`` or
> > +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever``=
 to the
> > +kernel command line.
> > +
> > +Alternatively, each supported anonymous THP size can be controlled by
> > +passing ``thp_anon=3D<size>[KMG]:<state>``, where ``<size>`` is the TH=
P size
> > +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
> > +``inherit``.
> > +
> > +For example, the following will set 64K THP to ``always``::
> > +
> > +     thp_anon=3D64K:always
> > +
> > +``thp_anon=3D`` may be specified multiple times to configure all THP s=
izes as
> > +required. If ``thp_anon=3D`` is specified at least once, any anon THP =
sizes
> > +not explicitly configured on the command line are implicitly set to
> > +``never``.
>
> I suggest documenting that "thp_anon=3D" will not effect the value of
> "transparent_hugepage=3D", or any configured default.
>
> Wondering if a syntax like
>
> thp_anon=3D16K,32K,64K:always;1048K,2048K:madvise
>
> (one could also support ranges, like "16K-64K")
>
> Would be even better. Then, maybe only allow a single instance.
>
> Maybe consider it if it's not too crazy to parse ;)

I prefer the current approach because it effectively filters cases like thi=
s.

[    0.000000] huge_memory: thp_anon=3D8K:inherit: cannot parse, ignored
[    0.000000] Unknown kernel command line parameters
"thp_anon=3D8K:inherit", will be passed to user space.

if we put multiple sizes together, 8K,32K,64K:always

We can't determine whether this command line is legal or illegal as it
is partially legal and partially illegal.

Just my two cents :-)

>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

