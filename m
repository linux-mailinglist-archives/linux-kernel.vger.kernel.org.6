Return-Path: <linux-kernel+bounces-301875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A9595F6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56641C21DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888319755A;
	Mon, 26 Aug 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMqvB5G5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99D195FEA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690256; cv=none; b=KzMVJgfzAEf1iZUlxa1wFn0zXZ2GkxR+GcDF8iXSYWXxKCGi0q0x9bf5TeZ5u2G932O8D/Awh49gWHAzIRWxXcMfy8WAf2Fo8RQ7stZ0If2w47ef319ayfC0JO25CwUrROffqVZyIjiF3NpdlPRfn8K/a5QrN58P1udgh/obp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690256; c=relaxed/simple;
	bh=fyeFyDqNNIVGj6fp5uG8Z95yuv+rPVGeRsZrOgNM4DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rj4rSVS8OYn1RtiPVp+l6IfosdnJ5EeCNgehzYveWdq0wh+fYRTDwPHyNSsGiXAdavyk2Yj9t285Ouy4gSt/zWCLyhvBF5w6WJb4sTRtlotTgi94DhAVg50I+w0W3vMt7GKLFC6JWMrJeVwtFmpHyS61rMjLFK0ekTPwAaURZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMqvB5G5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201fed75b38so390635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724690254; x=1725295054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SOwwEak8HNUtFdi6w1IR3Fh7ui0CdwihCwbP/+t5tk=;
        b=RMqvB5G5NpKnfwcmTk0n+rWG2u2EE4GnJmt3ndpaNGJfNBvYpw8cT2goOb+s8qxWsu
         19JQE/bBT7lvKiiwjBtkTKupx8W62C/0G3CNOvTlrTTRhrgYDeHaD3YOohJtqcmZz9ah
         f5kFRMu1ni2vDp5iDdE3daIsPNtlJn0J+D/NheRQSGqOyOhN41yp9WwZZLI+sxSBREfU
         HAz6/iiXrbB5F24RKqTLvN/z4xj4WvrcXk+7BoYTMqVi9WpiFKXN0eIZzwrwbsPoOfRq
         sP0nsuAJpeamoyd5IB524B1y6Go1qOm4NwqwQauwWbVVHHNHuZJ0Insxcv7QN2naIZ4S
         MJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690254; x=1725295054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SOwwEak8HNUtFdi6w1IR3Fh7ui0CdwihCwbP/+t5tk=;
        b=C6epOfzjUxDHtxEoB9yWUPesRDklDu4hGaZK/o4IMmxL61YVPsqF42OLs27G1uKpTz
         FOPkI1ILnYR9sRHv28VBmBw00oyBNi26sEhDT20OHrQInf4j8fmLKxGrUH/5ccJMY4+C
         lPxb14IQgk5wXoI8utyBP23vRqFSM9BMhw0ncLdZihl7LBoIZEKx+KENCn7V/+rJnNZs
         YhnmFzlA2LsA4GwYZnRa+h/dyKt+UVfoisBv20dNlznkpvRCKWjCkB5AQ354FptbPw10
         Kvw5NdAqZI7BVb1+DPadJsNOS5BHcHvjwluKINngBbb795atsnEwl3ZnJWDaydhnyVjV
         bHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWB40qxRFfhloGYBU9YL3DFMlJfCGyusmJjpn3t9I+DEYQQSjiLq0MF7lv4LPYtWSs4FiGqE0S4wF53Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRBPgtlHBJQEl9UTMCqrq8a35Ic17TKFOLKhctePk97wHCA99
	l8/r3uFZQmL9k8xUMDksk/ahTWBH9V2hCC69C/wGcebNQOlA7trs5vJG80mReKwuB19ZpKou9DB
	yoKecyjVZCgGymRO0mbudzGH1lV2RoB5RfoyF9843eUEkI9ARmKFE
X-Google-Smtp-Source: AGHT+IHjcvh47kOzCIEwZsibkgNOi6co7AgGvdigUdHRaQeq4Gqe/7kb6PEt73qK+dAQhNoKQrBZvRkORDCtN96cUK8=
X-Received: by 2002:a17:902:e84d:b0:1f9:d111:8a1e with SMTP id
 d9443c01a7336-203b2c4867amr5232205ad.26.1724690253624; Mon, 26 Aug 2024
 09:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com> <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
In-Reply-To: <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 26 Aug 2024 09:37:22 -0700
Message-ID: <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray <ngeoffray@google.com>
Cc: Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Suren for looping in

On Fri, Aug 23, 2024 at 4:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 21, 2024 at 2:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Wed, Aug 21, 2024 at 8:46=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Fri 16-08-24 07:48:01, gaoxu wrote:
> > > > Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazy=
free_fn:
> > > > 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If i=
t's
> > > >    moved to the LRU tail, it allows for faster release lazy-free fo=
lio and
> > > >    reduces the impact on file refault.
> > >
> > > This has been discussed when MADV_FREE was introduced. The question w=
as
> > > whether this memory has a lower priority than other inactive memory t=
hat
> > > has been marked that way longer ago. Also consider several MADV_FREE
> > > users should they be LIFO from the reclaim POV?

Thinking from the user's perspective, it seems to me that FIFO within
MADV_FREE'ed pages makes more sense. As a user I expect the longer a
MADV_FREE'ed page hasn't been touched, the chances are higher that it
may not be around anymore.
> >
> > The priority of this memory compared to other inactive memory that has =
been
> > marked for a longer time likely depends on the user's expectations - Ho=
w soon
> > do users expect MADV_FREE to be reclaimed compared with old file folios=
.
> >
> > art guys moved to MADV_FREE from MADV_DONTNEED without any
> > useful performance data and reason in the changelog:
> > https://android-review.googlesource.com/c/platform/art/+/2633132
> >
> > Since art is the Android Java heap, it can be quite large. This increas=
es the
> > likelihood of packing the file LRU and reduces the chances of reclaimin=
g
> > anonymous memory, which could result in more file re-faults while helpi=
ng
> > anonymous folio persist longer in memory.

Individual heaps of android apps are not big, and even in there we
don't call MADV_FREE on the entire heap.
> >
> > I am really curious why art guys have moved to MADV_FREE if we have
> > an approach to reach them.

Honestly, it makes little sense as a user that calling MADV_FREE on an
anonymous mapping will impact file LRU. That was never the intention
with our ART change.

From our perspective, once a set of pages are MADV_FREE'ed, they are
like a page-cache. It gives an opportunity, without hurting memory
use, to avoid overhead of page-faults, which happen frequently after
GC is done on running apps.

IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
prioritized for reclamation over file ones.
>
> Adding Lokesh.
> Lokesh, could you please comment on the reasoning behind the above
> mentioned change?

Adding Nicolas as well, in case he wants to add something.
>
> >
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
> > >
> >
> > Thanks
> > Barry

