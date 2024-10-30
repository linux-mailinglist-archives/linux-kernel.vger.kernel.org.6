Return-Path: <linux-kernel+bounces-388622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C49B6231
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275231F21EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441231E5719;
	Wed, 30 Oct 2024 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0xhIJoO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1861E571F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288855; cv=none; b=UGm6fOi/zNqcnDjGWSnHAoMEC6HC33JjwAyc6K0TnO5cDbeYCfHPRa3hSjIcYSIDosLvyP3c+0BeDIT61o41OmxcLaH4IeOGHAIHpy2adEl5JRbdV6R95YG5DCQL8QzKKfSPlz8Aw3zvVgGlokKEoKBzk5a1RHSJaUzsn7A7EqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288855; c=relaxed/simple;
	bh=jjowhWeb58M8dkbWfz1/39wWSagqvOzeCM5x/j9GsWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOUz1JPIr4dOfNiXeLPcQa08GzfTujwGYoWX+i6iB0Ss7UiWhWiKTQKkrCZ23izqFeA2L/RggjAw5A/8llkY8hAkzCyMV4LxMr7hr/gJEtfDfNHf2kS5BAhPhzDkUNigJksVfAPPQQ4gI3oTZyWNftfdCNeabuz7taJwjWVxouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0xhIJoO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9abe139088so965137166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730288852; x=1730893652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iPeoiKgqWsihw7QOhYcfHs+xFsoMwxQZ4v+dLUj0kU=;
        b=j0xhIJoOq7emEDmE0KxWkA9dSKnxgDq8Rnuy1xlhmIdVK7mZTNWF0nt7RcKYv2DcRa
         ORGydZQZpmVuFScQMcCFh+m3BoMXN7dAsTVvB2glMRlDK2cXMa9e122vARCbF+4VSWV0
         Vb3ddocPFRIAfzzZ+VSGbOPKkK0W0BidtALmpHe6EMhcDfW7LjBb/byqqpDu7ysrQXD+
         PdOEtSEa2Lprx+CQiCR6Jl6CgvT4GIGXaSrVo9Jvu8/7ZFUTZ82J89GCwsEnnwmfN1/y
         o19YXkQ+49ZFArW9OuH4/uHVUQ5Bstw7xuc+jauWDRMgtYRit+O78tyIpLzdDuM99yAs
         pzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288852; x=1730893652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iPeoiKgqWsihw7QOhYcfHs+xFsoMwxQZ4v+dLUj0kU=;
        b=brwqgdXJR9wOsMdQL3nJdmhIo361bHjPoBGBS3O8OB/LXWTUM4kxSdYtxWnD2M6Vsk
         LdDxP4R4KUDQDNel/zuZZyYkspkBbkCM/Kt6ZQLye/3rhNB8G2edZ48DfE6V6b/UKm9Y
         rW6zXruPR11K/IHW63AZf6lq48WeAHSrBAkj6GAhyvzmgTjXmU1EnUNRbQh44lQSbH+f
         Rj8MYol56aKgz7AEsufctOCd6SaJHdL3aHsVMQvOlF/ooD6lSL4LVh1/wmw1hF030KpN
         /3IvWScRXkTcTYe91GwqBS3To84c7Rh1hc+bfwMEvKxMsJcxnB7zs6O6Xlke6tfKb4lu
         i3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXxg/i2pLb1uMMSON4zUmDmuBZIkAH4fJrty8gC3zQPRlgXMv6uyM1Au5h93Q5kGOhAZFuEC1neshcCcjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcydsGP4Tq1fhQIzs+k8Md7nzy8qy+RZ/LR2ausCsccwjO87oq
	bVVQLEDVq8zh2O6tk1LBxFV/4yIo20m3ZjNQaQIV6SA0L7/fbgoETL7aK8YThACICQ4L3E5Rbxi
	vFJPlSbn9cMoWU+idnFwdDRJIAtY=
X-Google-Smtp-Source: AGHT+IHOhf0jCKXNjWWUFbLvQ8OX9sG6XrtUY0Z+2vfScEF3jOf24p7/NPgnSEG0lkw4bOS9pecA20ZITnp24rCfHHw=
X-Received: by 2002:a17:907:7d8b:b0:a9a:5b4:b19e with SMTP id
 a640c23a62f3a-a9de5ee15damr1543532666b.32.1730288851169; Wed, 30 Oct 2024
 04:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029161341.14063-1-marc.c.dionne@gmail.com> <20241029174518.60fa703fc9cb304d6e69e9a0@linux-foundation.org>
In-Reply-To: <20241029174518.60fa703fc9cb304d6e69e9a0@linux-foundation.org>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Wed, 30 Oct 2024 08:47:19 -0300
Message-ID: <CAB9dFdtd3paOGdYU8qJM5grD3pEFMiiCXk=fmPFW7k6s6yOBpQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools/mm: Fix slabinfo crash when MAX_SLABS is exceeded
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:45=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 29 Oct 2024 13:13:41 -0300 Marc Dionne <marc.c.dionne@gmail.com> =
wrote:
>
> > From: Marc Dionne <marc.dionne@auristor.com>
> >
> > The number of slabs can easily exceed the hard coded MAX_SLABS in the
> > slabinfo tool, causing it to overwrite memory and crash.
> >
> > Increase the value of MAX_SLABS, and check if that has been exceeded fo=
r
> > each new slab, instead of at the end when it's already too late.  Also
> > move the check for MAX_ALIASES into the loop body.
>
> Thanks.
>
> > --- a/tools/mm/slabinfo.c
> > +++ b/tools/mm/slabinfo.c
> > @@ -21,7 +21,7 @@
> >  #include <regex.h>
> >  #include <errno.h>
> >
> > -#define MAX_SLABS 500
> > +#define MAX_SLABS 1000
>
> That isn't a very large increase.

Fair point, given how quickly it has grown, maybe something like 4k
would give more headroom.

>
> >  #define MAX_ALIASES 500
> >  #define MAX_NODES 1024
> >
> > @@ -1240,6 +1240,8 @@ static void read_slab_dir(void)
> >                               p--;
> >                       alias->ref =3D strdup(p);
> >                       alias++;
> > +                     if (alias - aliasinfo > MAX_ALIASES)
> > +                             fatal("Too many aliases\n");
> >                       break;
> >                  case DT_DIR:
> >                       if (chdir(de->d_name))
> > @@ -1301,6 +1303,8 @@ static void read_slab_dir(void)
> >                       if (slab->name[0] =3D=3D ':')
> >                               alias_targets++;
> >                       slab++;
> > +                     if (slab - slabinfo > MAX_SLABS)
> > +                             fatal("Too many slabs\n");
> >                       break;
>
> This could be improved - if the number of slabs is exactly equal to
> MAX_SLABS we'll unnecessarily report an error.  Wouldn't this
> alteration be better?

Actually the issue is rather that we'll accept MAX_SLABS + 1 when we
shouldn't, so yes the checks should be >=3D, or could also be just =3D=3D,
sorry.

>
> --- a/tools/mm/slabinfo.c~tools-mm-fix-slabinfo-crash-when-max_slabs-is-e=
xceeded-fix
> +++ a/tools/mm/slabinfo.c
> @@ -1228,6 +1228,8 @@ static void read_slab_dir(void)
>                                 continue;
>                 switch (de->d_type) {
>                    case DT_LNK:
> +                       if (alias - aliasinfo >=3D MAX_ALIASES)
> +                               fatal("Too many aliases\n");
>                         alias->name =3D strdup(de->d_name);
>                         count =3D readlink(de->d_name, buffer, sizeof(buf=
fer)-1);
>
> @@ -1240,10 +1242,10 @@ static void read_slab_dir(void)
>                                 p--;
>                         alias->ref =3D strdup(p);
>                         alias++;
> -                       if (alias - aliasinfo > MAX_ALIASES)
> -                               fatal("Too many aliases\n");
>                         break;
>                    case DT_DIR:
> +                       if (slab - slabinfo >=3D MAX_SLABS)
> +                               fatal("Too many slabs\n");
>                         if (chdir(de->d_name))
>                                 fatal("Unable to access slab %s\n", slab-=
>name);
>                         slab->name =3D strdup(de->d_name);
> @@ -1305,8 +1307,6 @@ static void read_slab_dir(void)
>                         if (slab->name[0] =3D=3D ':')
>                                 alias_targets++;
>                         slab++;
> -                       if (slab - slabinfo > MAX_SLABS)
> -                               fatal("Too many slabs\n");
>                         break;
>                    default :
>                         fatal("Unknown file type %lx\n", de->d_type);
> _
>

