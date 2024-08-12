Return-Path: <linux-kernel+bounces-282445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D994E41C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F9A1F21E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA754A32;
	Mon, 12 Aug 2024 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcO3RWIy"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E47193
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424150; cv=none; b=ZJJIujovLO4+Y73+NVuHIdXqAZUU8wajgnh7FSTIXVBk9RqqRRf3c3ekV6yVzUfkvTOb5SHRTuIHi48vy6zmPBPvFaCKRC1T1VN8QDcvPkLt8nw1LNiVUCPolT62B1QfcDap/2XyFu4YAftELpr1CKHM2zmoOrbk/ALu+R18aE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424150; c=relaxed/simple;
	bh=5am0jIIL0wjoxX56gKELDhDdWpcBb6Ij4l84QXiSECI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=awZBd2UszQ0FIXq1+dGzRrm7Wm/OuLHQ3zs26/+Zz2xWFeYUWTJD6cochl7qWhpF9fL5H18SbjJJPAVaZpwm9tsW7KzVL2dsMdD9RzR1Mybys5UB+WFgmpH8QSEGiN5MJXuJq5uiM3E+uBfPc4e3l/gNL3HEmZcMWK7p6uq8dTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcO3RWIy; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39c3bf0584cso92885ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 17:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723424148; x=1724028948; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1wZscBRBmINP9lOLmPC6SYu14+hz1L8Prsr/p/rIDU=;
        b=QcO3RWIyqwguD9JD8KRNAiuUzH3rz790aVWTcJsXSN4+ituY7IhgpAjkW0afkAEsVd
         pa84cAz+anNq2gzfFFq9xxGnfD7NLNbmW2W2ya0HXfv1cmz8Z9FIOuCkvcUTEFbxIPeR
         OtwfumIC/t/zQF5rcuHMoOamKqbGYMQBip8JEmcwUHVQ94JdA1c+g3+iD/8ItEm5mhF9
         oedmdi40LkDJmvVPNFEjs4VjLDCBLvSjNpI68QuuBYMd3KN9P5EfDYK8n0GSZ/xlK97l
         whejkBnlZaF7kQuZOioRaeYH01YgVVcoIDcoptmxvkxKJm34vzQ1lrXlS+wh117ZvhIJ
         Xu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424148; x=1724028948;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1wZscBRBmINP9lOLmPC6SYu14+hz1L8Prsr/p/rIDU=;
        b=EorgG4Kr1nNiJCfmWCLlV/7RW4tYafI/7Mgk0iL0SQYMQnNQifgzvSIYxN/UlHpWP3
         fBi2vMXRhQb6ddzmJsM457h/SFoMBT1QgpUzMlXQdxW402KoRTeCN/djG4FKx5aPLCl8
         Izuin7Yn4NbxOmEGCniNMThsgBb6xX3bVs3TXS4mbT+6beNx4gP6yyAeUMLkQx1Rknij
         tNl85RBC4+KAJl0uk8lEVIhAmzvZ2UfChDX7Vfi4u1nSPsO4uYwETFxh5t6skCp0fmEV
         kWPr57BUv4bewMe1YpzyeDZc1AdOJqWUq8zpp6KWoNhzZK8Q0vW3dpHAZYQA7Ht0WcqK
         l0WA==
X-Forwarded-Encrypted: i=1; AJvYcCVvLypQ8py9/DAsRta684m1Ts83y1azn8OaW+E8Q4qd17/nvNnGnS0c6ZD+w5Cb3H5HYK5tGvSM74IOLlLG+gG0xRjAvef7/JJboNm3
X-Gm-Message-State: AOJu0Yyx/KAQWfYdEzyosBe0UsGZhiFuwRQbGfWMoF+IGeQBqDdkqg/n
	+4KyZQlVgYV/H4hqm0TYJFdZJ1WZ8tyHMK99BDBTBjMMVjcpjSrgjmsSRWQ6KA==
X-Google-Smtp-Source: AGHT+IGDAqzpM79bpYGMVHChZ1fIFHVGw/q8RR1gcs+2AbudhGZaWMHnJ08MS+Oct5ZK3MfQ23NTJA==
X-Received: by 2002:a05:6e02:1aa9:b0:39b:968:85fc with SMTP id e9e14a558f8ab-39c3146c1b9mr3187825ab.9.1723424147543;
        Sun, 11 Aug 2024 17:55:47 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe12fc8sm2630204a12.21.2024.08.11.17.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:55:46 -0700 (PDT)
Date: Sun, 11 Aug 2024 17:55:46 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
In-Reply-To: <CAKbZUD1e5nvmrQ5XZ=xV1eYbh5eeSLBQEeDT=KBx1C5T1Bjjzg@mail.gmail.com>
Message-ID: <aab45188-d34c-93c6-cfab-3c0cd1326a53@google.com>
References: <20240807090746.2146479-1-pedro.falcato@gmail.com> <cdfc5a08-c0ee-30a3-d6c5-22d4cfddc3a4@google.com> <CAKbZUD1e5nvmrQ5XZ=xV1eYbh5eeSLBQEeDT=KBx1C5T1Bjjzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 11 Aug 2024, Pedro Falcato wrote:

> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index 40b582a014b..1abe6a577d5 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -88,6 +88,19 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
> > >  EXPORT_SYMBOL(kmem_cache_size);
> > >
> > >  #ifdef CONFIG_DEBUG_VM
> > > +
> > > +static bool kmem_cache_is_duplicate_name(const char *name)
> > > +{
> > > +     struct kmem_cache *s;
> > > +
> > > +     list_for_each_entry(s, &slab_caches, list) {
> > > +             if (!strcmp(s->name, name))
> > > +                     return true;
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > +
> > >  static int kmem_cache_sanity_check(const char *name, unsigned int size)
> > >  {
> > >       if (!name || in_interrupt() || size > KMALLOC_MAX_SIZE) {
> > > @@ -95,6 +108,11 @@ static int kmem_cache_sanity_check(const char *name, unsigned int size)
> > >               return -EINVAL;
> > >       }
> > >
> > > +     if (kmem_cache_is_duplicate_name(name)) {
> > > +             /* Duplicate names will confuse slabtop, et al */
> > > +             pr_warn("%s: name %s already exists as a cache\n", __func__, name);
> >
> >
> > Shouldn't this be a full WARN_ON() instead of pr_warn()?  I assume we'll
> > be interested in who is adding the cache when the name already exists.
> 
> panic_on_warn? :)
> 

Would get the problem fixed up pretty fast, no? :)

> Personally I don't have anything against WARN_ON, but we've seen that
> panic_on_warn is a real thing on real systems, and DEBUG_VM is also
> set on real prod configs (like Fedora does/used to do). I've sent out
> one or two loose patches for problems I did find in my own testing
> around, but there may be many more (e.g some drivers may call
> kmem_cache_create repeatedly in some sort of callback, like 9pfs was
> doing when mounting; this is not greppable). And I'd guess grepping
> for cache names tends to be easy enough?
> 

Can we add a dump_stack() to make this way easier instead of hiding who is 
creating the duplicate name?

