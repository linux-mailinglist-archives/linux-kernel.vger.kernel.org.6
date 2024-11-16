Return-Path: <linux-kernel+bounces-411571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA49CFC46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 02:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4460EB2A821
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4891917F3;
	Sat, 16 Nov 2024 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCINxAY4"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672213C682
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721283; cv=none; b=fABvPXpIFGGt/lUhJeVVSlX07xZvE7rcCPQq+mV/hXrhVq435MjUjUsVyqv7p9YIpsgN7XU1RjS70AufTMhk1GgWIAlbqJuEv5cpptDYV6di1BdRwRQnFyX/kNWr0o1qErM/ld1lgvk1QUjizle6v0pdrqUCz3nkjpa/EPuZUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721283; c=relaxed/simple;
	bh=kcxd4DpdqlwLGPsME9mBHqRp/DFmOWM6BPvURFNvPRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky1Rhs3qMWRmZiDhEcM5LGjoQEowBM/cnGpPE2vtK1pc4QXUikICMKGU28ryihwdLV0dLS8FbJoaoJxNR6C52qUn9lwqKcTfogVGMGoEbf3aT0dpM4hTJg3C3bIddi0TSpvt402JDNLL3Pj7FLZkFcGjOeSUki5YrG3lGsIGgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCINxAY4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f646ff1bso339944666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731721280; x=1732326080; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT52XIvuMeYgn+oMzKuzUITdq0BanYWIJNtHWfhNXjg=;
        b=nCINxAY4t3fu/XsrobMFILi+7nlvarNI+OaOMSNgLcrxQ0T3smUWUvm8GugXYvJLVW
         sZopt2mqjfg20KfZxIiWsulMcfh1Q/17zfCPgvH55z4k638X3FOWi6mzgiAl8nbt7jol
         A29QtuRbax93KL0FwO4gU0TyVy9QogZgaYsvpQfs+Q2h4xtGebGiLrwIPdwRGwnDlOuW
         zktyiVr2+nQz+Jc/lvdmL1RgRFl2+8TX1tbxpaRGMSvTZ7ZiKt8W82q/TLu5LAg/iops
         tf8wAKglP6JPniJAJEGiP6TW/lQoDF4D2PHNYhF6quWJFsjpw+FblQ0pzc/0po5fiz7R
         EP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731721280; x=1732326080;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kT52XIvuMeYgn+oMzKuzUITdq0BanYWIJNtHWfhNXjg=;
        b=gxZJB+HMOZg9p8y1WZ1tnFS3JHAD1bUQB6je+YIO3hmWnxraQqegtsICA/HQhTx0Nh
         6cZsiSL144u2fydbzZP+8fLpRqNJ5ZqRo804QUIIagWzFde0qae3cQ9uVR1zxb/was03
         xurUqrcWHvU8Rq7De6VD0k2OdfEYr4wmjOrP9BhQq/W/ewBthTe8zMeS997CAPpbTYcx
         Yr212hO+LjlR7yJlkhk/+nJHJOvxddvbXOwktZSQAaiTLbsMpmDER4cXKkY2oVa/UGnL
         n5kXfOLl4epNNOUACVivCcXeFcRQrj6iWuCUT/E2Pn/uM1ECO8jT4Yb1rMSLCxtRz3HQ
         A8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVL8347zXmM0kgeX1PxORemCGDTUU7VTkH73NClSIBUKIOvyJwJTiZgKzq23WEKAxjUKucTGFvpWyTPg9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMdHap2fx+Hg/GrJEfOctMI2OfhhAlaQQunfUtL5tHaFoQe/d
	E32qdwERMpf9d0ugKhj+O4bxdauhDTHHL9/SjM0ZqtichBgOQ8tVz+gB/g==
X-Google-Smtp-Source: AGHT+IHzlLHHlYLC08RK++hR/9MtTAwXU9ob5isqHjfuY7I5J3gS2FmEQxNmTR5MMGxb+W1kaKCzjw==
X-Received: by 2002:a17:907:809:b0:a99:5021:bcf0 with SMTP id a640c23a62f3a-aa483454541mr333282266b.34.1731721280067;
        Fri, 15 Nov 2024 17:41:20 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26598sm237246266b.2.2024.11.15.17.41.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2024 17:41:18 -0800 (PST)
Date: Sat, 16 Nov 2024 01:41:16 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com
Subject: Re: [PATCH 3/5] maple_tree: use vacant nodes to reduce worst case
 allocations
Message-ID: <20241116014116.a7am7z4p7k33rkl5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <20241114170524.64391-4-sidhartha.kumar@oracle.com>
 <20241115075203.ojspk255cw3sr3s3@master>
 <2aa439f1-d33d-43ee-9945-5ac570506c7e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa439f1-d33d-43ee-9945-5ac570506c7e@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 15, 2024 at 03:34:55PM -0500, Sidhartha Kumar wrote:
>On 11/15/24 2:52 AM, Wei Yang wrote:
>> On Thu, Nov 14, 2024 at 12:05:22PM -0500, Sidhartha Kumar wrote:
>> > In order to determine the store type for a maple tree operation, a walk
>> > of the tree is done through mas_wr_walk(). This function descends the
>> > tree until a spanning write is detected or we reach a leaf node. While
>> > descending, keep track of the height at which we encounter a node with
>> > available space. This is done by checking if mas->end is less than the
>> > number of slots a given node type can fit.
>> > 
>> > Now that the height of the vacant node is tracked, we can use the
>> > difference between the height of the tree and the height of the vacant
>> > node to know how many levels we will have to propagate creating new
>> > nodes. Update mas_prealloc_calc() to consider the vacant height and
>> > reduce the number of worst allocations.
>> > 
>> > Rebalancing stores are not supported and fall back to using the full
>> > height of the tree for allocations.
>> > 
>> > Update preallocation testing assertions to take into account vacant
>> > height.
>> > 
>> > Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
>> > ---
>> > include/linux/maple_tree.h       |  2 +
>> > lib/maple_tree.c                 | 13 +++--
>> > tools/testing/radix-tree/maple.c | 97 +++++++++++++++++++++++++++++---
>> > 3 files changed, 100 insertions(+), 12 deletions(-)
>> > 
>> > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> > index cbbcd18d4186..7d777aa2d9ed 100644
>> > --- a/include/linux/maple_tree.h
>> > +++ b/include/linux/maple_tree.h
>> > @@ -463,6 +463,7 @@ struct ma_wr_state {
>> > 	void __rcu **slots;		/* mas->node->slots pointer */
>> > 	void *entry;			/* The entry to write */
>> > 	void *content;			/* The existing entry that is being overwritten */
>> > +	unsigned char vacant_height;	/* Depth of lowest node with free space */
>>                               ^^^           ^^^
>> 
>> Would this be a little misleading?
>> 
>
>Could you elaborate on how its misleading?
>

As you mentioned in previous patch, depth and height has different meaning.

Root node has depth of 0 and height of 1. So I may wandering whether this is
depth or height.

>> > };
>> > 
>> > #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
>> > @@ -498,6 +499,7 @@ struct ma_wr_state {
>> > 		.mas = ma_state,					\
>> > 		.content = NULL,					\
>> > 		.entry = wr_entry,					\
>> > +		.vacant_height = 0					\
>> > 	}
>> > 
>> > #define MA_TOPIARY(name, tree)						\
>> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> > index 21289e350382..f14d70c171c2 100644
>> > --- a/lib/maple_tree.c
>> > +++ b/lib/maple_tree.c
>> > @@ -3545,6 +3545,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>> > 		if (ma_is_leaf(wr_mas->type))
>> > 			return true;
>> > 
>> > +		if (mas->end < mt_slots[wr_mas->type] - 1)
>> > +			wr_mas->vacant_height = mas->depth + 1;
>> 
>> For some cases in rebalance, we may split data into three parts, which means
>> we need 2 extra vacant slot.
>> 
>> Maybe this check is not accurate?
>> 
>
>The triple split scenario which you are describing comes from the spanning
>store case not on the wr_rebalance case. There is a check before we set
>vacant height to return if is_span_wr() so I believe this is correct still.
>

Hmm... I come up with a case in which vacant_height may not high enough.

Here is the subtree where spanning write locates. The first level is the
parent node of the second level nodes.

                vacant node
                +--------+-+-+-------+
                |        |l|r|       |
                +--------+-+-+-------+

                l                 r                 
    +------+    +----+-------+    +---------+--+    +------+
    |      |    |    |       |    |         |  |    |      |
    +------+    +----+-------+    +---------+--+    +------+
                     ^                      ^
		     |                      |
		   index                   last

When mas_wr_walk_descend() to node l, mas_is_span_wr() return true since last
is in the right sibling, node r. Let's say the parent is vacant and l/r is
leaf. So the request number is (1 * 3) + 1.

Let's assume:

  * vacant node is just sufficient
  * l's left part + r's right part is sufficient but not overflow

Then the "new vacant node" would be deficient and needs another round
rebalance.

For this case, I am afraid it doesn't allocate enough nodes. Or I
misunderstand this?

-- 
Wei Yang
Help you, Help me

