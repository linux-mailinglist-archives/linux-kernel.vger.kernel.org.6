Return-Path: <linux-kernel+bounces-382813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA49B13A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA2E1F230FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD3B20F3F0;
	Fri, 25 Oct 2024 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VusjzEzP"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391531D9324
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900737; cv=none; b=Pt5rLPAm3DG6R0ibZvJHfHE9XqilKVXIO9PTFx7noP23yozbOyJQS9mfq//1FMkHTJqdVqjPnWLtwM2prD5rsX0oKDmAGJ1Sv7qAiWMjiHjh4wOJxwpa/BBenfXsLpc4ycvWi48TlcIsKLv/l1/vQ97VsbhFL8iXxP1RUIqq1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900737; c=relaxed/simple;
	bh=8hUbu4MaRq9AxbfkW3PMggLaRCerpnATXjAlZmJxMqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTXBuuRIBG6EvRAFBwNu6fAaiDlS0eoxEp8BUky8LUoRrfCzS07sxJQy0WfCR7XfUR9+Oi6bMqryMstmDQLVQqyWqocXP858P05HKGMr88/ByYsyyDksQXW5gdi9AcL8OwdXc7w4BiSSjSfaBtn5MIru7GUitL7O6+Qfce2VO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VusjzEzP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso338692966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729900733; x=1730505533; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YU4iezoimY3xDJuyaUhpglbz+tA7vUR6FZSc0nbsZ3w=;
        b=VusjzEzPqrq6T2XR1RN+4uWiE1E+uwGFhqkeJGGZvXuzZFRF8yoAKpMg2MkS/Vcheg
         gIq/q5pP9twgqebAekANLpvHVXMNYUVXp7hXLkrIGC7s8TQJfSPz3IUO5IenbBpk6GOb
         1Lye8rb6oa8sGMKnwbuAxIe3M1X4PhZUAOVT225xwIsEuu/DZ9Mn/HPXoclbeKUS/1C8
         GBX8kzCq+GYIUQFAKIjIJJbYhGfI1/HBxusONo/E/gIL0Zvef5tV8NY1eIFvSi+qcSi4
         39CayEcypYrcICWW4bABiaAHSYOgWBSsy0df/taQ2U91AyZTPzo98hUR7qi26fh+59TG
         MRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729900734; x=1730505534;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU4iezoimY3xDJuyaUhpglbz+tA7vUR6FZSc0nbsZ3w=;
        b=V+f79kt7P7FvtxpcGD+gehHGf0ZqrjMDd567PtehXKOhq6YRt2HzMzbtBnITE6NmEe
         c4uJ+MN5JxsE81nOCYlMe/P/EuQwfGAIlAm/BnMP8Xi3mfdxWtTJMYjdoZRnGkGP5A97
         7O112oQQ/B3B/ChGyqvvlRFF851Bs3nqCARGMTy5SzsXBxESf3EkvJY0EzoS8oO3QtbZ
         Px8Byn5y3rNeld7BR8tLnLJYd7wHO1RUCRfSbFtfJOzLr4tjZd0x5Q5v9jKyR5xyquqT
         W2h4YLGhSBTO7/JkneTXxGEKJKrHQCQcBeM3did6Ox2T+h+sBlrQqLg+tJzPkMjrdRiv
         xPpg==
X-Forwarded-Encrypted: i=1; AJvYcCVfJsvdKkJvTli7eymO50+K24ILzYmxRF8SZNLwc1/Q9NOtXq1EGl2T8K2FVRdeaihYSrxclkh7/7Wn1Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2/r67g8/bTi1qX0lsfObAC8oNObP0hyTA1jYExSqA7W7Ooa9
	WFiq+/AK3iMOiU2220G7NnIU1NrfoGAVfQBuWp125FiB1UJPlVJJ
X-Google-Smtp-Source: AGHT+IGUBfWXLxnVctUo8oJPkToHu9+i4Y7W4o0ODoEGnhUkm2Z10Z1aAtwT/eOETNjd5+yXPaCusg==
X-Received: by 2002:a17:907:1c88:b0:a99:e1a1:473f with SMTP id a640c23a62f3a-a9de619406cmr65118166b.57.1729900733315;
        Fri, 25 Oct 2024 16:58:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f030c40sm116889266b.84.2024.10.25.16.58.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2024 16:58:51 -0700 (PDT)
Date: Fri, 25 Oct 2024 23:58:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sid Kumar <sidhartha.kumar@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com,
	willy@infradead.org, surenb@google.com
Subject: Re: [PATCH v4 16/17] maple_tree: remove unneeded mas_wr_walk() in
 mas_store_prealloc()
Message-ID: <20241025235850.5o6l3k2u2so6hxrs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-17-sidhartha.kumar@oracle.com>
 <20241024012038.zf3dpqsflnyi4wce@master>
 <b4ad4b6a-f0b5-4ed1-a49a-d4e9ed0e4831@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4ad4b6a-f0b5-4ed1-a49a-d4e9ed0e4831@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 25, 2024 at 03:54:04PM -0400, Sid Kumar wrote:
>
>On 10/23/24 9:20 PM, Wei Yang wrote:
>> On Wed, Aug 14, 2024 at 12:19:43PM -0400, Sidhartha Kumar wrote:
>> > Users of mas_store_prealloc() enter this function with nodes already
>> > preallocated. This means the store type must be already set. We can then
>> > remove the call to mas_wr_store_type() and initialize the write state to
>> > continue the partial walk that was done when determining the store type.
>> > 
>> May I ask what is the partial walk here means?
>> 
>> It is the mas_wr_walk() in mas_wr_store_type() which is stopped because of it
>> is spanning write?
>
>Yes, this is what I meant by the partial walk that's already been started.
>It's the walk done by mas_wr_store_type().
>
>> I may lost some background, so the assumption here is mas_wr_store_type() has
>> already been invoked and the store type has been decided, right?
>
>Ya users of mas_store_prealloc() should have already called mas_preallocate()
>which does:
>
>    mas->store_type = mas_wr_store_type(&wr_mas);
>    request = mas_prealloc_calc(&wr_mas, entry);
>
>to set the store type and allocate the nodes.
>
>
>> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> > ---
>> > lib/maple_tree.c | 18 +++++++++++++-----
>> > 1 file changed, 13 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> > index 8c1a1a483395..73ce63d9c3a0 100644
>> > --- a/lib/maple_tree.c
>> > +++ b/lib/maple_tree.c
>> > @@ -3979,9 +3979,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
>> > 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
>> > 	else
>> > 		wr_mas->end_piv = wr_mas->mas->max;
>> > -
>> > -	if (!wr_mas->entry)
>> > -		mas_wr_extend_null(wr_mas);
>> > }
>> > 
>> > static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>> > @@ -5532,8 +5529,19 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>> > {
>> > 	MA_WR_STATE(wr_mas, mas, entry);
>> > 
>> > -	mas_wr_prealloc_setup(&wr_mas);
>> > -	mas_wr_store_type(&wr_mas);
>> > +	if (mas->store_type == wr_store_root) {
>> > +		mas_wr_prealloc_setup(&wr_mas);
>> > +		goto store;
>> > +	}
>> > +
>> > +	mas_wr_walk_descend(&wr_mas);
>> This one does not descend the tree, just locate the offset in a node and
>> adjust min/max. So not look like to continue the partial walk to me.
>> 
>> > +	if (mas->store_type != wr_spanning_store) {
>> > +		/* set wr_mas->content to current slot */
>> > +		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
>> > +		mas_wr_end_piv(&wr_mas);
>> If not a spanning write, the previous walk should reach a leaf node, right?
>
>Ya that's true.
>
>> I am not sure why we don't need to check extend null here. Because we have
>> already done it?
>
>
>Ya we extend null in mas_wr_store_type() which has already been called at
>this point.
>
>
>    /* At this point, we are at the leaf node that needs to be altered. */
>    mas_wr_end_piv(wr_mas);
>    if (!wr_mas->entry)
>        mas_wr_extend_null(wr_mas);
>
>Thanks,

Hmm... if we have already done this, why we need to do mas_wr_end_piv() again?

>
>Sid
>
>> > +	}
>> > +
>> > +store:
>> > 	trace_ma_write(__func__, mas, 0, entry);
>> > 	mas_wr_store_entry(&wr_mas);
>> > 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>> > -- 
>> > 2.46.0
>> > 

-- 
Wei Yang
Help you, Help me

