Return-Path: <linux-kernel+bounces-299538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E319E95D603
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE231C23713
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE51922FD;
	Fri, 23 Aug 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzEPuB8C"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6818592E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440793; cv=none; b=LnmFB4zAi4NtTdjSb6wmCXp2D4K9SYA7H4Rz5rQNOvFcuZDj4GSnAvZF4dhcCmtcMYT7hMNjRVEgWim3BAO80esOeAUSfBai79OjraPPW0mccRHw5/yWyMs/kz7xFSr9lXRWleDt5Mmc9p6JElq7KGSKBT7bEWo8DGUc/2P4EiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440793; c=relaxed/simple;
	bh=OiAJ4KI4U+CJXqXTu0tXFeMTtLG5KNHNpmK4EMC9wbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQWxxBw1tySqpZLZU+cB3LptgvHm6F4jtZbYhXLZZscdJUPKMA5Uw+54LT55ZH8RvwlggYuTujd9iATBiwD/4FDZgulWFfYmtjcnYMgPJwkq1wSTWPsFn6N4fBJ3YhfJJhYUzzfiCRJeUoX1FHH/sXQMfMKyzXnKui1boeJZn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzEPuB8C; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fbd0d7c2so21940625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724440791; x=1725045591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKe53yYKAtf8X48idbSAyfjC8S77ztYgY49MEq1yc6g=;
        b=hzEPuB8CUc0jpiNxqcDS8shueNhU98I8Bu00/uqq7l521CFQk8OIkp98wpsszMtlpx
         +Q7qj5Y0VNHCGGyOHyLzu0qatpJrDQbzq8GX0QH8+TspyQ09EbtI/Vn+WyCk/8+EVJzU
         CX+uC7MWfOSVdqF6S7jAxEvpM9eIK63FeYoSlDOJKNk0pPPFpA9mnuxSeFUWSh+ooqjD
         cqUwxk3fSjU0gdPri//PjbKXJODYn5NxTphi9Q9ofliBoFMuVX88nxKBeYBjmNyZ+oAe
         uwyStO9Yxu5FwnCqUU6rrbGjyMijP4wEQRT25zyPGPTDYDRgM228CQ3w+o9UB8QWtJIf
         nCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440791; x=1725045591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKe53yYKAtf8X48idbSAyfjC8S77ztYgY49MEq1yc6g=;
        b=xFJOPA1F+TrNqnnIazsnFkp6mdQQ5jsYboHQJ8erg8k6B6nAqxk+QInvsU/jfXR6+J
         SJRHhsY3eRfOCHYoyICjwXjGZJzONAAkZYyUJSkmJqgpTi6qjXXWxQC19/nuMD1Cac2X
         y3GGy9rJQVuPeUV1T0u7Xzxl4xmAa7OTznSMcNdTfBslDVfIQmZYXcYn3X3tn3DtdsMo
         94+J54sl8lhmxZwyWisI6s16sxRtt0xWiFy1+ElzdcKSeF6QvYwuYNeVJb92PatTwM0n
         aYRULrhlh4n2Jkt+K/PaCGCJAkdGAMCDNi3/N3LGrRgNwRZRAuo8rF99FCdxtfWTmcBB
         qknw==
X-Forwarded-Encrypted: i=1; AJvYcCX60/9bXc766Xyl1o7P24KbQR8Kp3WnU0c9Ok954DfAcgE/+692GBGqsAI3Ih0nCldmrEz05uiYhXdGflg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IdKcYVur3NbjB2nPdBl5pIrFSIxkHfPAuNwiD7Qf0rcSowrv
	PlEr9L27mjJjIbDTfWRJSuEuBWcel3g6jNRFfyjWSDXjM1LwIy0Y
X-Google-Smtp-Source: AGHT+IEQ8YWtIUlSKq/2sobIINxB/L0KI5p3/KjjBc4uXIyybctCA4UGajgqBcmBkuhG5s7fJWbEEw==
X-Received: by 2002:a17:902:e80f:b0:202:38ea:f61a with SMTP id d9443c01a7336-2039e4d963amr44946665ad.19.1724440791158;
        Fri, 23 Aug 2024 12:19:51 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385580810sm31712885ad.105.2024.08.23.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:19:50 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:19:48 -0700
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
Subject: Re: [RFC PATCH v1 2/6] lib: Implement find_{first,next,nth}_nor_bit,
 find_first_andnot_bit
Message-ID: <Zsjg1H_V8eq3-grK@yury-ThinkPad>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823185946.418340-3-mathieu.desnoyers@efficios.com>

On Fri, Aug 23, 2024 at 02:59:42PM -0400, Mathieu Desnoyers wrote:
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

Acked-by: Yury Norov <yury.norov@gmail.com>

If it comes to v2, can you also add some sanity tests for the new API?

> ---
> Changes since v0:
> - Rename "notandnot" to "nor", document equivalence.
> - Move comment cleanups to a separate patch.
> - Use __always_inline.
> ---
>  include/linux/find.h | 112 +++++++++++++++++++++++++++++++++++++++++++
>  lib/find_bit.c       |  36 ++++++++++++++
>  2 files changed, 148 insertions(+)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 8a170aa55634..b1394ba92654 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -14,6 +14,8 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
>  					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long nbits, unsigned long start);
> +unsigned long _find_next_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
> @@ -24,11 +26,17 @@ unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long
>  				unsigned long size, unsigned long n);
>  unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long size, unsigned long n);
> +unsigned long __find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long size, unsigned long n);
>  unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					const unsigned long *addr3, unsigned long size,
>  					unsigned long n);
>  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>  					 const unsigned long *addr2, unsigned long size);
> +extern unsigned long _find_first_andnot_bit(const unsigned long *addr1,
> +					 const unsigned long *addr2, unsigned long size);
> +extern unsigned long _find_first_nor_bit(const unsigned long *addr1,
> +					 const unsigned long *addr2, unsigned long size);
>  unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>  				      const unsigned long *addr3, unsigned long size);
>  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> @@ -130,6 +138,35 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
>  }
>  #endif
>  
> +/**
> + * find_next_nor_bit - find the next bit cleared in both *addr1 and *addr2
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @size: The bitmap size in bits
> + * @offset: The bitnumber to start searching at
> + *
> + * Returns the bit number for the next bit cleared in both *addr1 and *addr2.
> + * If no such bits are found, returns @size.
> + * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
> + */
> +static __always_inline
> +unsigned long find_next_nor_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long size,
> +		unsigned long offset)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val;
> +
> +		if (unlikely(offset >= size))
> +			return size;
> +
> +		val = ~(*addr1 | *addr2) & GENMASK(size - 1, offset);
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_next_nor_bit(addr1, addr2, size, offset);
> +}
> +
>  #ifndef find_next_or_bit
>  /**
>   * find_next_or_bit - find the next set bit in either memory regions
> @@ -291,6 +328,33 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
>  	return __find_nth_andnot_bit(addr1, addr2, size, n);
>  }
>  
> +/**
> + * find_nth_nor_bit - find N'th cleared bit in 2 memory regions.
> + * @addr1: The 1st address to start the search at
> + * @addr2: The 2nd address to start the search at
> + * @size: The maximum number of bits to search
> + * @n: The number of set bit, which position is needed, counting from 0
> + *
> + * Returns the bit number of the N'th bit cleared in the two regions.
> + * If no such, returns @size.
> + * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
> + */
> +static __always_inline
> +unsigned long find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
> +				unsigned long size, unsigned long n)
> +{
> +	if (n >= size)
> +		return size;
> +
> +	if (small_const_nbits(size)) {
> +		unsigned long val = ~(*addr1 | *addr2) & GENMASK(size - 1, 0);
> +
> +		return val ? fns(val, n) : size;
> +	}
> +
> +	return __find_nth_nor_bit(addr1, addr2, size, n);
> +}
> +
>  /**
>   * find_nth_and_andnot_bit - find N'th set bit in 2 memory regions,
>   *			     excluding those set in 3rd region
> @@ -346,6 +410,54 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
>  }
>  #endif
>  
> +/**
> + * find_first_andnot_bit - find the first set bit in 2 memory regions,
> + *                         flipping bits in 2nd region.
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the next set bit.
> + * If no bits are set, returns @size.
> + */
> +static __always_inline
> +unsigned long find_first_andnot_bit(const unsigned long *addr1,
> +				 const unsigned long *addr2,
> +				 unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
> +
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_first_andnot_bit(addr1, addr2, size);
> +}
> +
> +/**
> + * find_first_nor_bit - find the first cleared bit in 2 memory regions
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the next cleared bit.
> + * If no bits are set, returns @size.
> + * The bitwise operation nor ~(A | B) is equivalent to (~A & ~B).
> + */
> +static __always_inline
> +unsigned long find_first_nor_bit(const unsigned long *addr1,
> +				 const unsigned long *addr2,
> +				 unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = ~(*addr1 | *addr2) & GENMASK(size - 1, 0);
> +
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_first_nor_bit(addr1, addr2, size);
> +}
> +
>  /**
>   * find_first_and_and_bit - find the first set bit in 3 memory regions
>   * @addr1: The first address to base the search on
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 0836bb3d76c5..8050bc7c7ede 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -116,6 +116,28 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
>  EXPORT_SYMBOL(_find_first_and_bit);
>  #endif
>  
> +/*
> + * Find the first set bit in two memory regions, flipping bits in 2nd region.
> + */
> +unsigned long _find_first_andnot_bit(const unsigned long *addr1,
> +				  const unsigned long *addr2,
> +				  unsigned long size)
> +{
> +	return FIND_FIRST_BIT(addr1[idx] & ~addr2[idx], /* nop */, size);
> +}
> +EXPORT_SYMBOL(_find_first_andnot_bit);
> +
> +/*
> + * Find the first cleared bit in two memory regions.
> + */
> +unsigned long _find_first_nor_bit(const unsigned long *addr1,
> +				  const unsigned long *addr2,
> +				  unsigned long size)
> +{
> +	return FIND_FIRST_BIT(~(addr1[idx] | addr2[idx]), /* nop */, size);
> +}
> +EXPORT_SYMBOL(_find_first_nor_bit);
> +
>  /*
>   * Find the first set bit in three memory regions.
>   */
> @@ -167,6 +189,13 @@ unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned l
>  }
>  EXPORT_SYMBOL(__find_nth_andnot_bit);
>  
> +unsigned long __find_nth_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
> +				 unsigned long size, unsigned long n)
> +{
> +	return FIND_NTH_BIT(~(addr1[idx] | addr2[idx]), size, n);
> +}
> +EXPORT_SYMBOL(__find_nth_nor_bit);
> +
>  unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
>  					const unsigned long *addr2,
>  					const unsigned long *addr3,
> @@ -194,6 +223,13 @@ unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned l
>  EXPORT_SYMBOL(_find_next_andnot_bit);
>  #endif
>  
> +unsigned long _find_next_nor_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long nbits, unsigned long start)
> +{
> +	return FIND_NEXT_BIT(~(addr1[idx] | addr2[idx]), /* nop */, nbits, start);
> +}
> +EXPORT_SYMBOL(_find_next_nor_bit);
> +
>  #ifndef find_next_or_bit
>  unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long nbits, unsigned long start)
> -- 
> 2.39.2

