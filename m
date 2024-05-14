Return-Path: <linux-kernel+bounces-179173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FAC8C5CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEE1B22398
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B46180A97;
	Tue, 14 May 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0z8/quy"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11591DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721132; cv=none; b=XlKTPS/4WoUZOz00V/wU/hjXmoeufYuN929WQwhb+L3dVH/ePp9FkTUzV+tq8Aog2IxpDB3WHJ7WYVQE0wAidj38/dJmBPJX6pDYAMBVNyPfmncaeY+ptYye+IAEyNfTjGRzaxv7MZB4dOoR1q3YuLWXS95xXlM37mp3q5sdfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721132; c=relaxed/simple;
	bh=7dJ+Pxg0qmmno8WwNH+I7QAq9VNZQSyiUrKzkkcu5IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkyoCZcCYkeG7kIfwbCRVc79pw2JxID5DGxaUQOlTgP4wM4yLeYTXmD8fvM8tjDQgR86Q1VLqW9St5d+5Zt8Euhdqhe8OtHS1DcciC/sauzBttt9p8IWfernqyE8wczL/29A4TnO82M+TYAaLlYyv+fXvrLwXmPsb5vLlfLyQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0z8/quy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so5451494b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715721130; x=1716325930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F4UI8jh1QWs+kX0WohCrwVZNbRielxM6MSSN+snrN9k=;
        b=q0z8/quyqSQfiHnD8x7Z2pBBXa+BhIZotzm0DUJ3BIJXj5tjJdQGGvgjvWcumKCM1c
         aN3bCdbZEDACo8RVsQBovBkh3dMZJPTWqJFWLfnnOfQNtZthbFV4KHLInabmxl9h8S2J
         o7odKQPywEEHr6rdkHrtTEUn/M3rMxkB5/7CToxBtKQieaaf+TsUsFV85WORk06lQj9o
         spqzeLPXyJYBot4LWryBZz7IIKd7JUo1PKp710CN99l+fgOMgzSzifpXEp4zK/I5Sdzu
         lkajFy5J8Rwk8DVxcUZ4QWgwIz5hfJBNyvFYhHvQPyfWhGcNjBrYppROzvvQ1Pq41IMn
         n26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721130; x=1716325930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4UI8jh1QWs+kX0WohCrwVZNbRielxM6MSSN+snrN9k=;
        b=ApRkuGc4ZZkNTHxKXvbbuQ/5Z/Jw2KkRTpQc9ZjLJqFv+yreqQA3/8jzKU2aVioQsW
         lmFDZwGzyt7LtotjJuiFbkpQwndRATEpITcVrqQT7JH9mu5CKhDYVDfkQ/1tHE2iprUo
         zLmu41BEUTefGyhRxVgjbSdKBW49v1Om6lZg8lxo1yk5dIxQCw4/DhnPVTiG2AKfvdNv
         AFMd3d2mdrZxmxw4OlfI7wrazm8mqJM3QO9lc27A9C7xP4jNV3QTNz3+yzipeUQpd1bD
         7QR4akFfx90OPdzHIP7bINfoOFV9ZCZM4lily6wFMwy2txdd3jswS6cl8pb5oFj6GCdJ
         6rvg==
X-Forwarded-Encrypted: i=1; AJvYcCXbm1c36q0sH+f76CFh7X2JcQ1Auu8OPm5aJjkCrnbBMZRx+xYakpnfWDz4p2rfhVys0FjfEjHsYQceoMr0N9mRzo4QIepNMV7fCXuK
X-Gm-Message-State: AOJu0YyylbxfrdpV3/+pLcbiUHAUJ5/B+XGVqi2bUXd7pAQnIgNh/EXX
	lLy03i0IioVzybNiEuLGYh6PfGTu+mDi/IAbEhV5m2CWjcsQpViGMvuduluFWg==
X-Google-Smtp-Source: AGHT+IFX4md+l8NXzGXn+Q9inLW7kLUxXGoq7pI4wH8oJHdePgwAWV4w2M5jpkNLcQNX0ZQyb0xglQ==
X-Received: by 2002:a05:6a20:9c8e:b0:1af:d15a:6b60 with SMTP id adf61e73a8af0-1afde11bbafmr14971805637.28.1715721129994;
        Tue, 14 May 2024 14:12:09 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm9587604b3a.169.2024.05.14.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:11:59 -0700 (PDT)
Date: Tue, 14 May 2024 21:11:51 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Tim Murray <timmurray@google.com>,
	Alice Ryhl <aliceryhl@google.com>, John Stultz <jstultz@google.com>,
	Steven Moreland <smoreland@google.com>,
	Nick Chen <chenjia3@oppo.com>
Subject: Re: [PATCH v2] binder: use bitmap for faster descriptor lookup
Message-ID: <ZkPTl0XC4iYO2hUq@google.com>
References: <20240514160926.1309778-1-cmllamas@google.com>
 <d5f51c2e-daef-467d-9430-8c2d48819a56@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5f51c2e-daef-467d-9430-8c2d48819a56@wanadoo.fr>

On Tue, May 14, 2024 at 10:35:56PM +0200, Christophe JAILLET wrote:
> Le 14/05/2024 à 18:09, Carlos Llamas a écrit :
> > When creating new binder references, the driver assigns a descriptor id
> > that is shared with userspace. Regrettably, the driver needs to keep the
> > descriptors small enough to accommodate userspace potentially using them
> > as Vector indexes. Currently, the driver performs a linear search on the
> > rb-tree of references to find the smallest available descriptor id. This
> > approach, however, scales poorly as the number of references grows.
> > 
> > This patch introduces the usage of bitmaps to boost the performance of
> > descriptor assignments. This optimization results in notable performance
> > gains, particularly in processes with a large number of references. The
> > following benchmark with 100,000 references showcases the difference in
> > latency between the dbitmap implementation and the legacy approach:
> > 
> >    [  587.145098] get_ref_desc_olocked: 15us (dbitmap on)
> >    [  602.788623] get_ref_desc_olocked: 47343us (dbitmap off)
> > 
> > Note the bitmap size is dynamically adjusted in line with the number of
> > references, ensuring efficient memory usage. In cases where growing the
> > bitmap is not possible, the driver falls back to the slow legacy method.
> > 
> > A previous attempt to solve this issue was proposed in [1]. However,
> > such method involved adding new ioctls which isn't great, plus older
> > userspace code would not have benefited from the optimizations either.
> > 
> > Link: https://lore.kernel.org/all/20240417191418.1341988-1-cmllamas@google.com/ [1]
> 
> ...
> 
> > +static int get_ref_desc_olocked(struct binder_proc *proc,
> > +				struct binder_node *node,
> > +				u32 *desc)
> > +{
> > +	struct dbitmap *dmap = &proc->dmap;
> > +	unsigned long *new, bit;
> > +	unsigned int nbits;
> > +
> > +	/* 0 is reserved for the context manager */
> > +	if (node == proc->context->binder_context_mgr_node) {
> > +		*desc = 0;
> > +		return 0;
> > +	}
> > +
> > +	if (unlikely(!dbitmap_enabled(dmap))) {
> > +		*desc = slow_desc_lookup_olocked(proc);
> > +		return 0;
> > +	}
> > +
> > +	if (dbitmap_get_first_zero_bit(dmap, &bit) == 0) {
> > +		*desc = bit;
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * The descriptors bitmap is full and needs to be expanded.
> > +	 * The proc->outer_lock is briefly released to allocate the
> > +	 * new bitmap safely.
> > +	 */
> > +	nbits = dbitmap_expand_nbits(dmap);
> > +	binder_proc_unlock(proc);
> > +	new = bitmap_zalloc(nbits, GFP_KERNEL | __GFP_ZERO);
> 
> Hi,
> 
> Nitpick: No need to __GFP_ZERO when using zalloc().

Oops, you are right. I'll drop this for v2.

> 
> CJ
> 
> > +	binder_proc_lock(proc);
> > +	dbitmap_expand(dmap, new, nbits);
> > +
> > +	return -EAGAIN;
> > +}
> 
> ...
> 
> > +#define NBITS_MIN	BITS_PER_TYPE(unsigned long)
> > +
> > +struct dbitmap {
> > +	unsigned int nbits;
> 
> Should it be long (or unsigned long) to better match the bitmap API?

I picked 'unsigned int' precisely because that is what the bitmap API
uses for the nbits (mostly). Unfortunately, there seems to be some
inconsistencies across bitmap.h and the find.h APIs on the bit type.
Ultimately the decision was made on a type that would work with both.

For extra fun, checkout the types of set_bit() and clear_bit(). Those
are using 'long' for the n bit.

> 
> (not sure if it can overflow in this use case, but at least for consistancy)

Bitmaps are allocated with "unsigned int" via bitmap_zalloc() so it
can't overflow.

> 
> > +	unsigned long *map;
> > +};
> 
> ...
> 
> > +static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
> > +{
> > +	unsigned int bit;
> > +
> > +	if (dmap->nbits <= NBITS_MIN)
> > +		return 0;
> > +
> > +	bit = find_last_bit(dmap->map, dmap->nbits);
> 
> find_last_bit() returns an unsigned long.
> 
> (bitmap_get_first_zero_bit() below uses unsigned long)

Yes. However, these are both restricted to the @size parameter.

> 
> CJ
> 
> > +	if (unlikely(bit == dmap->nbits))
> > +		return NBITS_MIN;
> > +
> > +	if (unlikely(bit <= (dmap->nbits >> 2)))
> > +		return dmap->nbits >> 1;
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static inline int
> > +dbitmap_get_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> > +{
> > +	unsigned long n;
> > +
> > +	n = find_first_zero_bit(dmap->map, dmap->nbits);
> > +	if (unlikely(n == dmap->nbits))
> > +		return -ENOSPC;
> > +
> > +	*bit = n;
> > +	set_bit(n, dmap->map);
> > +
> > +	return 0;
> > +}
> 
> ...
> 

