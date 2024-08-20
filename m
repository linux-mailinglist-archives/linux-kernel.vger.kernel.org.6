Return-Path: <linux-kernel+bounces-294578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F8958F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D91C21B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C914A09E;
	Tue, 20 Aug 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5XIbwUl"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011D1E86E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188531; cv=none; b=Avj1hi20/mcuqt0snCmsXHlbXKMHbZ7ReS/iK4NN7af/kNcu7klcmInevfxxY3Hr4ou0/ymZAJ6kmPvCyoLxPhkZHXxQEqn8XmV+yCsHrS7AHv8HJ5yAcQ64CY++F1CKPRn/F3hqDiEzj+W6wijkhLuSB3tEJTuIavEsX3BB32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188531; c=relaxed/simple;
	bh=9RWnIjUiiW6pljnVDnVK5iNTeqbtvOjVsWT9XHKH8HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhGXuiF0ywnDBLGSRID/sJtBCxIHI4wBHf0pSAVRMfdFF+oDUFvhTIIO4xPzy8WYZjwTrn5lOt7Foee1iNwX9s8ZYXqryNIwKYq8ogj+pyrFal+/Y1QgA/8P52yCkQWnM4AbV8zaarcAM9WNq4Fx/ts9JqksJyX5iOKme2qtcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5XIbwUl; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6c0ad8dca82so1602487b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724188528; x=1724793328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QTC4wc5LOx1PJXj9S88NW93jxtDEotdAsloOqA5baFY=;
        b=a5XIbwUlvXqSeaFy+bd5HopKg7fc1SdkJhx/vv3lZZ7SjhEqQdimktmWvkPrPyU5XT
         b4KJ2kQl4hYbkNM+Zr6JmtlvQcj5bdu3bEHwiZwDEx5maTJ2rQD5z3TrTDtgRC+9COlm
         al1XBLshZVVAGb3zWecRavLGUyOIO92GLw0sEXNbz081SDS+1o6AtFTW2iT/9Vrags/8
         DcpvsY1uLuvtkBw5ZanWMU76NOTthQB8R4reURHkhEdQ/At3FVPQF8cK9hwI2cwcGGsB
         1RrFEu+lQB73RALITYgT1GpSJ67RyMuQ3KO6mQ4Oj2ro8z1LzhkwW+MEd3rEUChoiZ7J
         KwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188528; x=1724793328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTC4wc5LOx1PJXj9S88NW93jxtDEotdAsloOqA5baFY=;
        b=q3w6KqG4TARsSKN1vXKyZJjzzHPlLN/vuXnjzCONbZHvT4b1FsNrUQoAYhe5zeJzjF
         gfApkSnfRZINss1gHqsSp7WakDnVGiaG+8RpL0LzPq87QTv05fNimf9V4ZjeOyYdn0ku
         ch8cRt2o9mvoHY8IZKtUEIn/yBnoFEdq42RDSEgevJt69qiiSr5FEzpHCxubk3CWpbJr
         sE6BsF/wDa1yCu+LyJtW5Jw0P575qO83cveMX83nJCPi7nWfF3P2YndIpXUAdV2QQMgw
         v9570yWw0246LQ8VSnMLEJKm4fOb06FCCefho6553ZGIbVQh7fWHrsPk+xzhz95UeWwy
         EbLg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRJa7nBqhj/QgGNGduFGnIwCqfiLKysGOu3GScwLfuUZY9yUMNLpcHFqpvwNlNS2CrMcF2i2mewax+ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3A0SVVNuBiPSfWVIL0u/eoc9g1KLjtW9mpneYpiXM+0B/xq8L
	f9QRC45qjXEMBW/m9kfr9HmvXDQ+EwAccy0EKRklhcKHr/r+fa+C
X-Google-Smtp-Source: AGHT+IEaEqTXdhAc6ZBp4rYdRYhxAJBpdkb1nfTLzPM9WBEfTSkKN6vMyqGoshugTERf69lX2UH0WA==
X-Received: by 2002:a05:690c:c83:b0:65f:a486:5a61 with SMTP id 00721157ae682-6c09c7887ebmr8066827b3.10.1724188528501;
        Tue, 20 Aug 2024 14:15:28 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99506caasm20111257b3.28.2024.08.20.14.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 14:15:27 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:15:14 -0700
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
Message-ID: <ZsUHYqEJxdb2kYyP@yury-ThinkPad>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
 <20240819142406.339084-2-mathieu.desnoyers@efficios.com>
 <ZsOatkpPqzMF6B_c@yury-ThinkPad>
 <1207b505-0842-40cc-a581-44e595f67601@efficios.com>
 <df068816-7269-4275-a673-d9ed5c050365@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df068816-7269-4275-a673-d9ed5c050365@efficios.com>

On Tue, Aug 20, 2024 at 10:45:17PM +0200, Mathieu Desnoyers wrote:
> On 2024-08-20 19:19, Mathieu Desnoyers wrote:
> > On 2024-08-19 21:19, Yury Norov wrote:
> [...]
> > > > +/**
> > > > + * find_next_notandnot_bit - find the next bit cleared in both
> > > > *addr1 and *addr2
> > > > + * @addr1: The first address to base the search on
> > > > + * @addr2: The second address to base the search on
> > > > + * @size: The bitmap size in bits
> > > > + * @offset: The bitnumber to start searching at
> > > > + *
> > > > + * Returns the bit number for the next bit cleared in both
> > > > *addr1 and *addr2.
> > > > + * If no such bits are found, returns @size.
> > > > + */
> > > > +static inline
> > > > +unsigned long find_next_notandnot_bit(const unsigned long *addr1,
> > > > +        const unsigned long *addr2, unsigned long size,
> > > > +        unsigned long offset)
> > > > +{
> > > > +    if (small_const_nbits(size)) {
> > > > +        unsigned long val;
> > > > +
> > > > +        if (unlikely(offset >= size))
> > > > +            return size;
> > > > +
> > > > +        val = (~*addr1) & (~*addr2) & GENMASK(size - 1, offset);
> > > > +        return val ? __ffs(val) : size;
> > > > +    }
> > > > +
> > > > +    return _find_next_notandnot_bit(addr1, addr2, size, offset);
> > > > +}
> > > > +#endif
> > > > +
> > > 
> > > It's not said explicitly, but some naming conventions exist around bitmap
> > > searching.
> > > 
> > > If you're looking for a clear (unset) bit in a mask, you'd use a 'zero'
> > > modifier. We have only 2 such functions now: find_{first,next}_zero_bit,
> > > both taking one bitmap. I think it's time to extend this rule for
> > > many bitmaps and write down the naming rules.
> > > 
> > > With the following, the find_next_notandnot_bit() should be named
> > > like; find_next_zero_and_bit(). It's not perfect, but still sounds
> > > better to me than 'notandnot' thing.
> 
> Actually, now that I come to think of it in terms of logic gates:
> 
> ~A & ~B == ~(A | B)
> 
> So this "notandnot" is simply a "NOR" gate.
> 
> I therefore intend to name it "find_next_nor_bit" if that's OK with
> you.

Yes, I'm OK.

To me, if you can put definition of a logical operation inside
FIND_NEXT_BIT() macro directly, you can name it correspondingly.
So in this case, find_next_nor_bit would be a:

  FIND_NEXT_BIT(~(addr1[idx] | addr2[idx]), /* nop */, size)

Correspondingly, instead of 'zero_or' we should use a 'nand' notation,
if it will be needed. I'll notice that in the naming manual.

Good catch.

Thanks,
Yury

