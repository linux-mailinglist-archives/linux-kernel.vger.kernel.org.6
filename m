Return-Path: <linux-kernel+bounces-289637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E80954896
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0120284BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9519DFBB;
	Fri, 16 Aug 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrCNdUHD"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14723156C5F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810691; cv=none; b=mRRk4GKQp3B/9YJ2/8ckZVUCwlK5QgyRlzfgWKZBORM5Zp6OaveR/ObnTEPwqZgnowLDHxzHZzokvcQw7oWxpytryHX/Bne7z7MhJGZJVlMYBSRp6PM/auaYCpyTysPoz/aUw1KVgX80pDX6skNhdLCGHoIopTRAJKYkdttEi1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810691; c=relaxed/simple;
	bh=tcJZoZvIvPmmMwu4y2I37jbMl9NI6oAn20IMGSWs88Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS14L51CooUGHT8VQbctKmEqQu9jzjuDp/tP5BbKHIVjlIxB1Zh2thU+2nq2kVkkCCaG1HxSB/0FZgdkc2WKpIyIKpQfVWpHCJutcqOwT8OF6MIBp0+LQlZKqqejRBaLrrm2Cfr209ooZCjRtoFTVlrgnWfLW4hMZuEhEn5J2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrCNdUHD; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-842f95d3501so1071792241.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723810689; x=1724415489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypdZtxVWZEvMrrAE4BHjMdvp8EAGZSUhh00ZRWVJC6s=;
        b=YrCNdUHDktrr2HmQwWnmG1ylEmVQeMgAsW5wov+pEous6cVNCdjLLd+of+l/bOrVrD
         DGJmcpZ5TzXvanxZQY/7mv/DvBumduywJlvXpjt3/v/Y+WzXCzWvPtsTN04dp7h06qQM
         1xH0iEJTMsJoB/aNszDTWmSY5Wu1Gap4En/OuxyPYh3RuqPZ7qbpxh7hZx5UTPOcAsfX
         EHRxby7hx0qUGKGRTmfFexgG1FnqbSCteu+VSWxMmqb3/nBNm5eANLo4++Jw5jMkcNaY
         AIjnyccdzgRhO1MqSpdZEbpdDv0BfA8oDJe+uvPmvTLScd8nBO8LYOqqphr5h0KWpv2r
         IUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723810689; x=1724415489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypdZtxVWZEvMrrAE4BHjMdvp8EAGZSUhh00ZRWVJC6s=;
        b=ClJJgCEX0oghJnUtpuZOLqSNfqtvLpxaLUCeWMu0FqDbLOHd5HoN+hHhZadriHonMK
         FVDgKHygGBhfeyRMpYKLGHmX1Bhp5PGE+9VjQjizqCANDBBDkMmClZxE9BSYP1DtpYUr
         0tfyQwRvC+EKAoLkE5Gq3AE3ThFNtgitp0r9DmIQIEprqWHDo5FzIn34D30kopIEEZI4
         2ZWOV32k2Hrk7RajaKh8i2uu3+rYeTN0R0KmNHwTA2RahYzDZxNv6pgZFAhZc4X8KZ1w
         PhFDEwW/3rvgXbC6NJ3ZlNPG/jQAGRHMChGoZ2elfm7Un/4n06sXS74TC2U24n9SjGpL
         K7wg==
X-Forwarded-Encrypted: i=1; AJvYcCWkV0ry5oCogEklOY5MPQEyZS+B4vLhlOcKof0z1CWQl5e9wtQycRHEawKk1VJn5xtSFLe5FaqnXMoDU94CgTtvREM2qAvvGo3yss58
X-Gm-Message-State: AOJu0Yx+/WkhVc6QqpQetz8GiKh6qxXnAIIO+Y1fNOhQj0AyWbrT040h
	lu9n1Zaa9JMqrC/MZH3gcf6AXUsvKj54GvK5jdfY2gDpMxzkdqpD126R7uk+vzTje9h+VxZ1Ntg
	ZVMQWT+zn7hbUN3EdN1jiltwqgMU=
X-Google-Smtp-Source: AGHT+IHTIZxa99PI8Ipkj4HN42Y2mN/Pzb2xMa/vh4157p3qAiTKSC5msI7Nb9OD7IhyyHOKOO5SzAJG64Fla4dlsfc=
X-Received: by 2002:a05:6102:cd4:b0:48f:3b56:a184 with SMTP id
 ada2fe7eead31-4976a56fff8mr3493717137.5.1723810688717; Fri, 16 Aug 2024
 05:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807090746.2146479-1-pedro.falcato@gmail.com>
 <cdfc5a08-c0ee-30a3-d6c5-22d4cfddc3a4@google.com> <CAKbZUD1e5nvmrQ5XZ=xV1eYbh5eeSLBQEeDT=KBx1C5T1Bjjzg@mail.gmail.com>
 <aab45188-d34c-93c6-cfab-3c0cd1326a53@google.com>
In-Reply-To: <aab45188-d34c-93c6-cfab-3c0cd1326a53@google.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 16 Aug 2024 13:17:57 +0100
Message-ID: <CAKbZUD293X0hOaqHRKpERpmsMKvvOLqRcQoKyB9mssg41Dhxtw@mail.gmail.com>
Subject: Re: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
To: David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:55=E2=80=AFAM David Rientjes <rientjes@google.com=
> wrote:
>
> On Sun, 11 Aug 2024, Pedro Falcato wrote:
> > > > +     if (kmem_cache_is_duplicate_name(name)) {
> > > > +             /* Duplicate names will confuse slabtop, et al */
> > > > +             pr_warn("%s: name %s already exists as a cache\n", __=
func__, name);
> > >
> > >
> > > Shouldn't this be a full WARN_ON() instead of pr_warn()?  I assume we=
'll
> > > be interested in who is adding the cache when the name already exists=
.
> >
> > panic_on_warn? :)
> >
>
> Would get the problem fixed up pretty fast, no? :)
>
> > Personally I don't have anything against WARN_ON, but we've seen that
> > panic_on_warn is a real thing on real systems, and DEBUG_VM is also
> > set on real prod configs (like Fedora does/used to do). I've sent out
> > one or two loose patches for problems I did find in my own testing
> > around, but there may be many more (e.g some drivers may call
> > kmem_cache_create repeatedly in some sort of callback, like 9pfs was
> > doing when mounting; this is not greppable). And I'd guess grepping
> > for cache names tends to be easy enough?
> >
>
> Can we add a dump_stack() to make this way easier instead of hiding who i=
s
> creating the duplicate name?


Bah, sorry for the delay.

I'm fully in favour of adding a dump_stack(), but it seems like hand
coding WARN_ON a bit. Oh well.
If y'all agree, please squash this in (praying gmail doesn't mangle
this diff, in any case it's a trivial change):

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1abe6a577d52..d183655e4b1b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -111,6 +111,7 @@ static int kmem_cache_sanity_check(const char
*name, unsigned int size)
       if (kmem_cache_is_duplicate_name(name)) {
               /* Duplicate names will confuse slabtop, et al */
               pr_warn("%s: name %s already exists as a cache\n",
__func__, name);
+               dump_stack_lvl(KERN_WARNING);
       }

       WARN_ON(strchr(name, ' '));     /* It confuses parsers */

