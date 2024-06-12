Return-Path: <linux-kernel+bounces-211081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C61904CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7C71C23DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2913CFB8;
	Wed, 12 Jun 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brzyheyi"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132429413
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177679; cv=none; b=Tfe9L/nPGvpcCqdT/1/ymiUBZsY+BAaRBkIiIxkCyaM9mLeI2VoGm+FgS/gRXyCSb/5tgV2jfY3s7edcXqLsjBFRe9Y1G7v2JtF9wIinrDOq3GE4ZDROsGXYg+4InQGt8Pk8/GFOyEmJnoK5ufzgNrnWurBoSLYVVPArkJgIWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177679; c=relaxed/simple;
	bh=in7Uq7Ckd8ql4oQaJaUoIJyX738NyNrshp18J+kVuQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGqr/rlyphbUJF9NHx04qUJo0GMSmvJiSwoSwx6ZEn/S/C0OzbkQrSn4UYA0KVWvudIArZRdPkoVqBiXGu46oNutLQI5/aJG+Prkh/A1jmp8Do+hSsRxxOz+qPWPeJM3DHBZiYpSWw93aMiGYRzr68IaJTNnHM5beRx+iAHMao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brzyheyi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c83100cb4so3537015a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718177676; x=1718782476; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o77M9qAN+pRgJWJYRJ+nSK3wcPE6vxMUhsaBsoX0kU=;
        b=Brzyheyi1k6LkzBg2dNPVpEagWb8dSalOhUXOAwuKVSWgo8w9VqbgTyUcjlDiXzKgH
         0sZo5sty1abPQUqWSGODS1wfo7KpjO4mki1gTFwweqRa8DBu5NMU0JqV9CYcCL0VJIrD
         M/UPGzumqh9lRN3CuHyuKPooXatu6KzPRLfoe9ayeRjorhlBE7T0S9siLHs/BsOFLAOg
         Sfa2Mc+TDdrgQJDQGSkJxfNa6HevRjjnv2dwHUCHmgY9IKS/grHtjTJld17GZjRrZYqs
         LS55urXoz6RH8T/6Ii1+NI80gwt6NJ7Ur6h236CAfZt0gJv6TRn75BsdYmwHsMtGrigw
         eA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718177676; x=1718782476;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8o77M9qAN+pRgJWJYRJ+nSK3wcPE6vxMUhsaBsoX0kU=;
        b=Pk5sEDbbsHP7ewCutWBUYI7g20ec9m6SQiTfvbQpmySGPEqfD6d/q22dGuGDGXBF6r
         A31LjghyAWmF/4OiPuFdYjeDiUeGRoFq8w3PLBswng8E6cNxz4+2ZWxvoYAgGEPphBoX
         iMT6ikcuWTR2/AW0Z3JfGyJ8KUgn4/m/KViWbLtJQlQP0bwjIDl/YHO+LYWmoQfRnzLb
         Vh2ovtCtHM/wcuw0HCZLIMfPBMgWKP4w6eG0YHmdzTcH2+/s20hzbK55n341BSPyCwUU
         DUBH3wYMqjKgImrDywLTwkL7jojdb6A9K6gXnIV+vSC3LM2oX52PkhY/F/XsKU+ASs5J
         A2NA==
X-Forwarded-Encrypted: i=1; AJvYcCXw6ytfJ/Vzw8/+OuvC5KStHu2sQQ8d7SSriLGbIu8CuKBzdB7ExGUU6r8Nb/r0A9l0i4OHb3WadnGZOo5Nrr1Ma5qg5MvODImOEPvc
X-Gm-Message-State: AOJu0YwWCKEnr9rZfEIABIfT69yl/tQu1c/l3SXR0s6UzI39MvBu/kNq
	BxZS4J7SpgIoPl1d8ffI+pWvpGwspSDnofpuz7Cn612/Dqhw/m4+
X-Google-Smtp-Source: AGHT+IEjfLXx+nSEe/8KSqR2eK19VmxG5zwhz5cEWknfBmK0RrzQ6CxrwsRbpjmHvKlaPAABxzIu2g==
X-Received: by 2002:a50:9f86:0:b0:57c:5f2b:b5a with SMTP id 4fb4d7f45d1cf-57ca9749915mr630736a12.2.1718177676095;
        Wed, 12 Jun 2024 00:34:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c8f6095e9sm3099184a12.24.2024.06.12.00.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 00:34:35 -0700 (PDT)
Date: Wed, 12 Jun 2024 07:34:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return
 "unsigned long"
Message-ID: <20240612073435.52fch2aut5lxeyhf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-3-david@redhat.com>
 <ZmZ1x6QQYPFSOd7O@localhost.localdomain>
 <99073d55-5b18-4ed2-b860-8c09e056f585@redhat.com>
 <20240611005636.g6525rkqpos43yds@master>
 <04b3dda2-c6a8-4f26-90b8-75fe7580d63e@redhat.com>
 <20240612070144.q6rpbq2hkwtielav@master>
 <2d0df7ca-2720-4a0c-95c5-9b665a567e5f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0df7ca-2720-4a0c-95c5-9b665a567e5f@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 12, 2024 at 09:22:25AM +0200, David Hildenbrand wrote:
>On 12.06.24 09:01, Wei Yang wrote:
>> On Tue, Jun 11, 2024 at 11:20:00AM +0200, David Hildenbrand wrote:
>> > On 11.06.24 02:56, Wei Yang wrote:
>> > > On Mon, Jun 10, 2024 at 10:22:49AM +0200, David Hildenbrand wrote:
>> > > > On 10.06.24 05:40, Oscar Salvador wrote:
>> > > > > On Fri, Jun 07, 2024 at 10:37:11AM +0200, David Hildenbrand wrote:
>> > > > > > It looks rather weird that totalhigh_pages() returns an
>> > > > > > "unsigned long" but nr_free_highpages() returns an "unsigned int".
>> > > > > > 
>> > > > > > Let's return an "unsigned long" from nr_free_highpages() to be
>> > > > > > consistent.
>> > > > > > 
>> > > > > > While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
>> > > > > > totalhigh_pages() implementation, to make these look alike as well.
>> > > > > > 
>> > > > > > Signed-off-by: David Hildenbrand <david@redhat.com>
>> > > > > ...
>> > > > > > -static inline unsigned int nr_free_highpages(void) { return 0; }
>> > > > > > -static inline unsigned long totalhigh_pages(void) { return 0UL; }
>> > > > > > +static inline unsigned long nr_free_highpages(void) { return 0; }
>> > > > > > +static inline unsigned long totalhigh_pages(void) { return 0; }
>> > > > > 
>> > > > > Although I doubt it has any consequences, I would just leave them both with UL,
>> > > > > so the return type is consistent with what we are returning.
>> > > > 
>> > > > These suffixes are only required when using constants that would not fit
>> > > > into the native (int) type, or converting from that native (int) type to
>> > > > something else automatically by the compiler would mess things up (for example,
>> > > > undesired sign extension). For 0 that is certainly impossible :)
>> > > > 
>> > > > 
>> > > > That's also the reason why in include/linux we now have:
>> > > > 
>> > > > t14s: ~/git/linux/include/linux $ git grep "return 0UL;"
>> > > > skbuff.h:       return 0UL;
>> > > > uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>> > > > t14s: ~/git/linux/include/linux $ git grep "0UL;"
>> > > > bitmap.h:               *dst = ~0UL;
>> > > > dax.h:          return ~0UL;
>> > > > mtd/map.h:                      r.x[i] = ~0UL;
>> > > > netfilter.h:    return ((ul1[0] ^ ul2[0]) | (ul1[1] ^ ul2[1])) == 0UL;
>> > > > skbuff.h:       return 0UL;
>> > > > uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>> > > > 
>> > > > 
>> > > > ... compared to a long list if "unsigned long" functions that simply "return 0;"
>> > > > 
>> > > 
>> > > Seems this is the current status.
>> > > 
>> > > Then my question is do we have a guide line for this? Or 0 is the special
>> > > case? Sounds positive value has no sign extension problem. If we need to
>> > > return 1, we suppose to use 1 or 1UL? I found myself confused.
>> > > 
>> > > I grepped "return 1" and do find some cases without UL:
>> > > 
>> > > backing-dev.h: wb_stat_error() return 1 for unsigned long.
>> > > pgtable.h: pte_batch_hint() return 1 for unsigned int.
>> > > 
>> > > So the guide line is for positive value, it is not necessary to use UL?
>> > 
>> > I think when returning simple values (0/1/-1), we really don't need these
>> > suffices at all. The standard says "The type of an integer constant is the
>> > first of the corresponding list in which its value can be represented.". I
>> > thought it would always use an "int", but that is not the case.
>> > 
>> > So, if we use "-1", the compiler will use an "int", and sign extension to
>> > "unsigned" long will do the right thing.
>> > 
>> > Simple test:
>> > 
>> > -1 results in: 0xffffffffffffffff
>> > -1U results in: 0xffffffff
>> > -1UL results in: 0xffffffffffffffff
>> > 0xffffffff results in: 0xffffffff
>> > 0xffffffffU results in: 0xffffffff
>> > 0xffffffffUL results in: 0xffffffff
>> > ~0xffffffff results in: 0x0
>> > ~0xffffffffU results in: 0x0
>> > ~0xffffffffUL results in: 0xffffffff00000000
>> > 0xffffffffffffffff results in: 0xffffffffffffffff
>> > 0xffffffffffffffffU results in: 0xffffffffffffffff
>> 
>> I expect this to be 0xffffffff. Why this extend it to a UL?
>
>Apparently, the "U" only restricts the set of types to "unsigned ones".
>
>https://en.cppreference.com/w/cpp/language/integer_literal
>
>So the compiler will use the first "unsigned" type that can hold that value.
>

Interesting, thanks for the reference.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>-- 
>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

