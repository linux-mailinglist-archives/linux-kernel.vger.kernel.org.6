Return-Path: <linux-kernel+bounces-282413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA1B94E3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB59B1F22091
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401315FA7A;
	Sun, 11 Aug 2024 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhXWjDRr"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E216C8E9
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415329; cv=none; b=QmkXTmS/SOeL0xeQnGpFhEEMSBE51LaEVYJ+ldCZDncy1Hu7g1zs0Oovod1xdRDcRvrX3Al76WK6RX8GXISodPYqkng8KYQqq1gmXJnquITiPycck5f7Y//i+pTslaU8FtA5WOioZT45Fb3bObzpk3AhP/7aazWafVIE52mYTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415329; c=relaxed/simple;
	bh=mFWeZZ9uvOVa3emaH5mcC+sUWvIBr7Sntev7sCut2sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuZ2N+Q/yT5KatFOPSp82lTKSjx003Hx/Wxdh/0qpnHl4cG0BXSy7gBEvKM/3y/dRd7934CMLH5W2Moh2k3o4bmQh6VaAbHsS6ehd2fKPglfGCmP3V2R1I05ymwRN3GBnvBYzmWucA43NFs4K69fSSXSqrRXb3uCOC72Ei/Pup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhXWjDRr; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f527c0c959so1071513e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723415327; x=1724020127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXyNW3oqEDm1KWmCg6jKDv5SYMK+GI1yz1PH3s2QALw=;
        b=WhXWjDRrMbNnEqw7ZV5gkB5MZPjFmWy8M1lnCTkTnFX7NKK6xqExHrRNQoyr3sj1wf
         Uh/U0uUTjl7IAQt5dohQ7kmHWqgpxC0N7f4UX0w8UBSRvuvcE0A0UnFFqAmnQ9x/hwTe
         t9aA5jEHqgl9lm/fxuEm3rOx6yRjsezqU7XB/uIfUHHHOanCesbpPXzxExH23pl9tqrQ
         k9XyzeSku2cTcX3eFUH5ZDIva1fucro252HejvzUz4Zy7FJD8GtdfkDBWvY7jn394ke9
         Pjn00XV2H0XTKXxgMXd5kvoPG1AnEItHSC8jdLiovrwwfGjnpUSBMN5nlKQ0NcQgEggJ
         mjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723415327; x=1724020127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXyNW3oqEDm1KWmCg6jKDv5SYMK+GI1yz1PH3s2QALw=;
        b=e81yEGLmDikf2uqPtRPVgYktcLFv+7HAfTXnR+c/GagjR4j3N2HC7kSNq3rxHVnwaO
         aVMkJ0BcNrfvmwZCTJWJpEZWsVhHShb1cVHzbvUwsJ5wpDykwaJF2FeAmEt0/9KwxWkG
         A554WBif+3U9nSkreqt2Id2Jf0SpP4C1vjVZ59UjxdSb1ywLOm0HDU66OyU9pINe2bxA
         ceitb5TRrkLyT8JoXkoM6nrxz7NPknEm1CYmgCyZ5/AU7MRMUv+QWkJGCqXQQ/kQdPh7
         2CItFotTLMHQkt4/Q3LxuG1rmYm/KLzOZDYVjNPnHry/yyvm/7+Owd0vvesXXQDWOCqQ
         VuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWVjfDfqKSELQZUY84moHYUFoIVnA4Kl9gLpnv3pIr2GT/V1c5MMGV2zs3pa+mv4q0ISjqckpAZTb72IA8ZIipp10JMFKVBZu3u1nH
X-Gm-Message-State: AOJu0Yx26YQfh51OPvdWL6VMDn+5J+gUkZEc4Q9a2ppGAxFp9AAivKAN
	7xxUzpcJeEuf6qHPCFwcNnRTKkU8PuBiIaKEjfv9SB6YV7V8cAzaYuQLAcfX6Pfy02OjtSDE73f
	rHnjLPz3dQBC1CKL8CUZP9FxwwLc=
X-Google-Smtp-Source: AGHT+IEJ4hOjiOta/GC9qHrzEs9Zr9SJ3JMYXzXQmPDfJE7SJqNa63NA5swWaBv/ZShHS8piyyQUv5OiU3Nm5/wIIRs=
X-Received: by 2002:a05:6122:218d:b0:4ef:6500:b6b3 with SMTP id
 71dfb90a1353d-4f913001b42mr8460781e0c.6.1723415327105; Sun, 11 Aug 2024
 15:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807090746.2146479-1-pedro.falcato@gmail.com> <cdfc5a08-c0ee-30a3-d6c5-22d4cfddc3a4@google.com>
In-Reply-To: <cdfc5a08-c0ee-30a3-d6c5-22d4cfddc3a4@google.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sun, 11 Aug 2024 23:28:35 +0100
Message-ID: <CAKbZUD1e5nvmrQ5XZ=xV1eYbh5eeSLBQEeDT=KBx1C5T1Bjjzg@mail.gmail.com>
Subject: Re: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
To: David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 9:30=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Wed, 7 Aug 2024, Pedro Falcato wrote:
>
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 40b582a014b..1abe6a577d5 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -88,6 +88,19 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
> >  EXPORT_SYMBOL(kmem_cache_size);
> >
> >  #ifdef CONFIG_DEBUG_VM
> > +
> > +static bool kmem_cache_is_duplicate_name(const char *name)
> > +{
> > +     struct kmem_cache *s;
> > +
> > +     list_for_each_entry(s, &slab_caches, list) {
> > +             if (!strcmp(s->name, name))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static int kmem_cache_sanity_check(const char *name, unsigned int size=
)
> >  {
> >       if (!name || in_interrupt() || size > KMALLOC_MAX_SIZE) {
> > @@ -95,6 +108,11 @@ static int kmem_cache_sanity_check(const char *name=
, unsigned int size)
> >               return -EINVAL;
> >       }
> >
> > +     if (kmem_cache_is_duplicate_name(name)) {
> > +             /* Duplicate names will confuse slabtop, et al */
> > +             pr_warn("%s: name %s already exists as a cache\n", __func=
__, name);
>
>
> Shouldn't this be a full WARN_ON() instead of pr_warn()?  I assume we'll
> be interested in who is adding the cache when the name already exists.

panic_on_warn? :)

Personally I don't have anything against WARN_ON, but we've seen that
panic_on_warn is a real thing on real systems, and DEBUG_VM is also
set on real prod configs (like Fedora does/used to do). I've sent out
one or two loose patches for problems I did find in my own testing
around, but there may be many more (e.g some drivers may call
kmem_cache_create repeatedly in some sort of callback, like 9pfs was
doing when mounting; this is not greppable). And I'd guess grepping
for cache names tends to be easy enough?

--=20
Pedro

