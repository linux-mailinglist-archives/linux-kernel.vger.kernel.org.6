Return-Path: <linux-kernel+bounces-292779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F3A957447
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C482844DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE3C1DC488;
	Mon, 19 Aug 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPQ+r5E8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B21DC474
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095165; cv=none; b=sa0FTMKAsXE4AQeOgN0JCN0tGyukj3oneYwfBWICJ17L8rwjoKD1aZQvdX5HaxBT7y8I9iEvy8ZIDHBuwI3+/r19zj+iy3LOigT2A/R2YwBXREusgt++q3mue6pBPnqjplNSXwcn389/nmhqFUMoO+/gVmltceJYnScmdR0Ee0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095165; c=relaxed/simple;
	bh=l0uujvQphviCfUgoLOB7Legc1VAmKV+Sgf0QWCOgrsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXsGuk8JKCwyTiHtLxI5R8CKw1WZBFUwqT4mrjucqJYsPCibc4glYeNwj/60ZV2IBC353FFr5Iio2HbodBA1dPOV+9cIfeJpkS4Z7bX1LPbGwodjJPb9X2QR5kyDn4Cf80oK4WqcJgTYja982wKKKyebF5YKCygu3Pkatp7Ixmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPQ+r5E8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2020b730049so23706205ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724095163; x=1724699963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj4wanlvbXLU2rrLmaBZrXCS3lFflOyU05zWeAsi0OU=;
        b=YPQ+r5E8Jh4s/+bw/ymoms9qYSgOWO6ovOgqawRVqlNmGz+ueXu7CVNXVw1ngIPHPC
         iHi4NhLFeZuynaI56PcZV8XHlikqfbfyIkCKXxxX1zXt5L08s3FI04wm1o8TD89RnwCq
         aiFW4sxIKYjWI6KLc+P7W2sWSukaDqRAiiJhrKshnaHTA8vnGTLbxr0L981s4lHZYVPy
         RjnvqpkQL3AElrqu81FBnWnM2FeyuqEQSYHriiZpAAttuBK7FcappiQLd+f8jv6w8rLL
         /FnxfZ+wav7FTK9oLlpZg6FmOx0uxu5vt/u4lZzAhx0vUI0gBgu59LCSO+d9w5Yqz0Gl
         iJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095163; x=1724699963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj4wanlvbXLU2rrLmaBZrXCS3lFflOyU05zWeAsi0OU=;
        b=N+8gyPL9WB3b3ZxMaKXg20UruTT6+eZ0qQ7OkkFcQ88ZgBTgsRMyUK8fvrRFxvQh9p
         0iowPH8Yrq8OnAYaeULoZP0Hpi4e4g8yGa7difaby4oQJIgYcL1ZchQrX2Zo2SX5zOam
         us2R6WD0pRcUYQRdEg+qoQ7/SXOW7WT+V7BJbDOjGIhkta/1QNQaogpjwG4XGKejpa03
         Bv+DlsV2iJWAORPcwgxaPKNTnISODzmVrkkkXMs5Bd83jwzdVOwPfmMag1x+ch1X0zso
         dQZ8NKbiXJ+zfOMmfqxWDuy0F1aS4U+GosB+ygxc68cegP+5w1gVCEdMJB+/TA5c93ls
         DFGA==
X-Forwarded-Encrypted: i=1; AJvYcCUl/jh44z9i9e5+VcAqyEX8yo97fvn3xyWtdJh0rGPmR22/1aeh+SKDb0S8/lQTADhK/zSm7dFojhrgnc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nVD5XkOag9wQd/fwo6r4O2Jjn09FqckjDQTI28TwrDMjc7Io
	NrMMUJYebyHd7RWoUF5kWpY8ihM6J4A+zAGMgWgAPqiiWcM49Jpc
X-Google-Smtp-Source: AGHT+IFELBq5ReSAKhFTQPlUxn4Um7Xa2IjUo2ZyJOw+2H7G7nVPqSY8RSa/Mv8hDo+dKm0p2THbzA==
X-Received: by 2002:a17:902:c942:b0:1fd:a264:9433 with SMTP id d9443c01a7336-20203ed1e5dmr111716875ad.29.1724095163151;
        Mon, 19 Aug 2024 12:19:23 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03795edsm65592935ad.153.2024.08.19.12.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:19:22 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:19:18 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/5] lib: Implement
 find_{first,next,nth}_notandnot_bit, find_first_andnot_bit
Message-ID: <ZsOatkpPqzMF6B_c@yury-ThinkPad>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
 <20240819142406.339084-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819142406.339084-2-mathieu.desnoyers@efficios.com>

On Mon, Aug 19, 2024 at 04:24:02PM +0200, Mathieu Desnoyers wrote:
> Allow finding the first, next, or nth bit within two input bitmasks
> which is zero in both masks.
> 
> Allow fiding the first bit within two input bitmasks which is set in
> first mask and cleared in the second mask. find_next_andnot_bit and
> find_nth_andnot_bit already exist, so find the first bit appears to be
> missing.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/find.h | 122 +++++++++++++++++++++++++++++++++++++++++--
>  lib/find_bit.c       |  42 +++++++++++++++
>  2 files changed, 160 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5dfca4225fef..6b2377006b22 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -14,6 +14,8 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
>  					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long nbits, unsigned long start);
> +unsigned long _find_next_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
> @@ -24,11 +26,17 @@ unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long
>  				unsigned long size, unsigned long n);
>  unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long size, unsigned long n);
> +unsigned long __find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long size, unsigned long n);
>  unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					const unsigned long *addr3, unsigned long size,
>  					unsigned long n);
>  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>  					 const unsigned long *addr2, unsigned long size);
> +extern unsigned long _find_first_andnot_bit(const unsigned long *addr1,
> +					 const unsigned long *addr2, unsigned long size);
> +extern unsigned long _find_first_notandnot_bit(const unsigned long *addr1,
> +					 const unsigned long *addr2, unsigned long size);
>  unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>  				      const unsigned long *addr3, unsigned long size);
>  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> @@ -102,15 +110,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
>  
>  #ifndef find_next_andnot_bit
>  /**
> - * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
> - *                        in *addr2
> + * find_next_andnot_bit - find the next set bit in *addr1, cleared in *addr2
>   * @addr1: The first address to base the search on
>   * @addr2: The second address to base the search on
>   * @size: The bitmap size in bits
>   * @offset: The bitnumber to start searching at
>   *
> - * Returns the bit number for the next set bit
> - * If no bits are set, returns @size.
> + * Returns the bit number for the next bit set in *addr1, cleared in *addr2.
> + * If no such bits are found, returns @size.

Can you split rewording of existing comments out to a separate patch
please?

>   */
>  static inline
>  unsigned long find_next_andnot_bit(const unsigned long *addr1,
> @@ -131,6 +138,36 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
>  }
>  #endif
>  
> +#ifndef find_next_notandnot_bit

Don't protect new functions. This is only for those having arch
implementation, and it's only armv7 now.

> +/**
> + * find_next_notandnot_bit - find the next bit cleared in both *addr1 and *addr2
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @size: The bitmap size in bits
> + * @offset: The bitnumber to start searching at
> + *
> + * Returns the bit number for the next bit cleared in both *addr1 and *addr2.
> + * If no such bits are found, returns @size.
> + */
> +static inline
> +unsigned long find_next_notandnot_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long size,
> +		unsigned long offset)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val;
> +
> +		if (unlikely(offset >= size))
> +			return size;
> +
> +		val = (~*addr1) & (~*addr2) & GENMASK(size - 1, offset);
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_next_notandnot_bit(addr1, addr2, size, offset);
> +}
> +#endif
> +

It's not said explicitly, but some naming conventions exist around bitmap
searching.

If you're looking for a clear (unset) bit in a mask, you'd use a 'zero'
modifier. We have only 2 such functions now: find_{first,next}_zero_bit,
both taking one bitmap. I think it's time to extend this rule for
many bitmaps and write down the naming rules.

With the following, the find_next_notandnot_bit() should be named
like; find_next_zero_and_bit(). It's not perfect, but still sounds
better to me than 'notandnot' thing.

If we search for a set bit in bitmap, we use find_first or find_next
prefixes:
 - find_first_bit;
 - find_next_bit.

If we'd like to pass an additional bitmap to AND, OR or XOR with the
1st bitmap, we provide as corresponding logical operation as
suffix(es):
 - find_first_and_bit(b1, b2) : b1 & b2;
 - find _next_and_or_bit(b1, b2, b3) : b1 & b2 | b3.

If additional bitmap must be inverted, we provide a 'not' after the
corresponding logical operation:
 - find_first_andnot_bit(b1, b2) : b1 & ~b2;
 - find _next_and_ornot_bit(b1, b2, b3) : b1 & b2 | ~b3.

If all bitmaps have to be inverted, or in other words, we are looking
for an unset bit in a bitmap or a combination of bitmaps, we provide
a 'zero' prefix in the function name:
 - find_next_zero_bit;
 - find_next_zero_and_bit;
 - find_next_zero_and_or_bit;

Functions having 'zero' prefix should not negate bitmaps (should not
have 'not' in names) because of commutative property. For example,
find_next_zero_andnot_bit(), which is ~b1 & ~(~b2) is redundant
because it's the same as find_next_andnot_bit() : b2 & ~b1.

Iterators over unset bits in bitmap(s) (those based on 'zero' search
functions) should have a 'clear' prefix in the name:
 - for_each_clear_bit;
 - for_each_clear_bit_from;

I should probably put the above on top of the file...

Thanks,
Yury

