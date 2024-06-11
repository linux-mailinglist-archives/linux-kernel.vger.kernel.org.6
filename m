Return-Path: <linux-kernel+bounces-209139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6879902DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08131C2177E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83763B8;
	Tue, 11 Jun 2024 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS2WFbgv"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55434C81
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067401; cv=none; b=F4CGS1sIR+xLO5K99/5tjzJKNwl+GBH4j2kLufmzVEudTmEVecXjD9dm9jp4GOwX2O4LrGo6qw9mm1RxSlg1M9ZAeNAfw2xwgfukWUVp4qa5W1fZ7EMc4aRIiPC9fNkBBoX65bCR4phuyESfVEt1CCajEgjFw6MPWVXh8YkGMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067401; c=relaxed/simple;
	bh=pWf61BOW6LDJhVR+p7Jr3ddwtK37jvFhbQjHtR1senQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPABuDF3EoSA5lFFcB0dko94RUcxxQQ7/oBiymbLT4YBogTWIipGP2OuyFq7bAqEhF3rZ74jm49/Z1Eh8TfZw7ajwOlRLOF5u4fXiZZoj0LAjlte0xm07c3MvrW4J1xW6RGSEfP4VW0X+RXCb4zh9i871pyCUJt3vNh4JbqE7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS2WFbgv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f1c4800easo194048366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718067398; x=1718672198; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsnMWiRsFgyQvUVQ9cK3PkkXIy3mFEoHC4cpzhwBfS0=;
        b=gS2WFbgvNuFMST0ySHSNykEdjMWiaMnYhEr0nmdeYt77xXxrq9CFUWMHxnFoCLn00H
         nsMy+9JwH4YOXY45x3s+KFK+CPKMHNFiXxfeuJ8a0+BzhSm0xTqijEn7bZvm7DF/ca43
         1V17Qkz2XXv2mAzOKIjHHJnPy99IQKQDu9WLcEq63fUG8cp5CScPWezjD9R0x1Ju1JNu
         dpievKpoHp8ttgIqTw2gzo73/DUaOIuMBJTwOrc2i4UYHCYALMn5xuwHmATOv/k+y+pD
         MY5htcIfk/PyQIi8Ep2OI3LhiS1m2x6+oWMRwseOsRII2JJ9i1cAS4A9sxmjMpiRtEuU
         xMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067398; x=1718672198;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsnMWiRsFgyQvUVQ9cK3PkkXIy3mFEoHC4cpzhwBfS0=;
        b=PMEWGEAJvsq5JXZYIA0fzMhy4qgAtDkiURl/kQ+6xD82Dv0xKZxKsaRfn6sXSCUUyV
         i0TUk4whqjyXG5CH0QiOL9wp8G4sd2c8lj7upN1H8VuBaocbh89AUGoXANKBLucjutzY
         sASpL9KgVNaOQNx5z6z+DtOTCA+PI9y67sF8OcExNrTaGUWpM0SsWIagA/5hvuIOlH6U
         ICskt+ejtLRcv48hEPRZIUxzvEmZbq4x6s0pylJH5f+Eio5E06ero+siYtQPKhyyql0W
         VazyiT3V7KGwUnlzqk11HvXHZ6HIafXXoXNK+lDYtDWtwKbThD8HC3lUxgkps4LkstjD
         H+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWKX4Gs9OHohvWVW8noDT0vwLM+tRLM1z1xKvyCT4pLBokQzHpUH8KEG60wyIAvAts+lLc1kJq7QrphimkCaxcXEQwcawh5xM8CjVxq
X-Gm-Message-State: AOJu0YyHqYti5sb+UQNr6ZJKlKcTVTBCveahcLWP9/cO+rGMuc9kpEsb
	OmOjuWHxwKmjqgGFSo52Of6Kss5ZiHb3vyRf3zhyrFLAwhlidmy3EE7wWy9/
X-Google-Smtp-Source: AGHT+IGZIQqjy50dC/ZcZUGCR1hSV1V7Qo3MXBqgDQ4ubjDi1o9VqVgSC+CY9Zbw3GKbOrOTJAAOCQ==
X-Received: by 2002:a17:906:b4d:b0:a6f:238:85c8 with SMTP id a640c23a62f3a-a6f02389247mr472356466b.71.1718067397868;
        Mon, 10 Jun 2024 17:56:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1226c190sm309544166b.93.2024.06.10.17.56.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2024 17:56:37 -0700 (PDT)
Date: Tue, 11 Jun 2024 00:56:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return
 "unsigned long"
Message-ID: <20240611005636.g6525rkqpos43yds@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-3-david@redhat.com>
 <ZmZ1x6QQYPFSOd7O@localhost.localdomain>
 <99073d55-5b18-4ed2-b860-8c09e056f585@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99073d55-5b18-4ed2-b860-8c09e056f585@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jun 10, 2024 at 10:22:49AM +0200, David Hildenbrand wrote:
>On 10.06.24 05:40, Oscar Salvador wrote:
>> On Fri, Jun 07, 2024 at 10:37:11AM +0200, David Hildenbrand wrote:
>> > It looks rather weird that totalhigh_pages() returns an
>> > "unsigned long" but nr_free_highpages() returns an "unsigned int".
>> > 
>> > Let's return an "unsigned long" from nr_free_highpages() to be
>> > consistent.
>> > 
>> > While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
>> > totalhigh_pages() implementation, to make these look alike as well.
>> > 
>> > Signed-off-by: David Hildenbrand <david@redhat.com>
>> ...
>> > -static inline unsigned int nr_free_highpages(void) { return 0; }
>> > -static inline unsigned long totalhigh_pages(void) { return 0UL; }
>> > +static inline unsigned long nr_free_highpages(void) { return 0; }
>> > +static inline unsigned long totalhigh_pages(void) { return 0; }
>> 
>> Although I doubt it has any consequences, I would just leave them both with UL,
>> so the return type is consistent with what we are returning.
>
>These suffixes are only required when using constants that would not fit
>into the native (int) type, or converting from that native (int) type to
>something else automatically by the compiler would mess things up (for example,
>undesired sign extension). For 0 that is certainly impossible :)
>
>
>That's also the reason why in include/linux we now have:
>
>t14s: ~/git/linux/include/linux $ git grep "return 0UL;"
>skbuff.h:       return 0UL;
>uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>t14s: ~/git/linux/include/linux $ git grep "0UL;"
>bitmap.h:               *dst = ~0UL;
>dax.h:          return ~0UL;
>mtd/map.h:                      r.x[i] = ~0UL;
>netfilter.h:    return ((ul1[0] ^ ul2[0]) | (ul1[1] ^ ul2[1])) == 0UL;
>skbuff.h:       return 0UL;
>uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
>
>
>... compared to a long list if "unsigned long" functions that simply "return 0;"
>

Seems this is the current status. 

Then my question is do we have a guide line for this? Or 0 is the special
case? Sounds positive value has no sign extension problem. If we need to
return 1, we suppose to use 1 or 1UL? I found myself confused.

I grepped "return 1" and do find some cases without UL:

backing-dev.h: wb_stat_error() return 1 for unsigned long.
pgtable.h: pte_batch_hint() return 1 for unsigned int.

So the guide line is for positive value, it is not necessary to use UL?

>
>So I prefer to just drop it.
>
>Thanks!
>
>-- 
>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

