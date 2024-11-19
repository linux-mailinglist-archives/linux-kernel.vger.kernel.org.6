Return-Path: <linux-kernel+bounces-413760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C119D1E49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4DCB22F16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C834642D;
	Tue, 19 Nov 2024 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPnsAjFj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6433F7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983454; cv=none; b=hKDz2fZLhuzoyMmg16wmnU9Y8mG1g3ZofFWfvpk1vqiZsNaWepYQ8EfzpHtsV0LcIW0TvmntB8YMbbqJUqB2QutWsoUMTx0rgtxXKNxQHmD98FDWjPBetch4nKAZdpgfMJkuuMVXmRaQRFSdyOGwr7kzJ6yrOSf1zQaGkvvB/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983454; c=relaxed/simple;
	bh=3+gMwJ0l8jkEuZePWat4JAz1lfm8W3pdj4hfWeYj/s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL041Hs7jFoyRQ5zicVRdoogIkFQDlfATA/c5EVuBKfvObbf2jRBnpnQGksNWzwfKitUdLgmzZJk/e6pEGeXfimFJ5KtOL+QzlAYETKfLL3V6ZTcZXUrbr2HYZbrts8a+tWMvLde2TJTRbd4cMu8+x+2+JW9dKR3MyawEeCxRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPnsAjFj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e44654ae3so619496366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731983451; x=1732588251; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR5z0Zmm7jGTILB2ZTA1J3Uc3kfsx9w8jQHvhZLeBrg=;
        b=KPnsAjFj+jj+R477RUbtGTloRHVhI1atZTEv3vBySdWcvgKlOoCilraDLithzXf6TA
         YLDRVbBqAwG4zHwUsOkkxb7tnBPt0dVn1ln1ckApG4tbBUxfAhCOvl/mMlKNv76vEa/p
         Ly5psSjkrpoEenjKIa9UMSJOKdf0Z/5cdIIkbrYw6XN2idOM3zSD/UwgdrdVQzd/chIB
         2WHSNAnRWHxqGknAyLn4C0IKYC8tqAMYbc/zYVZ+QQSFl09G3GSwqKjlWC1VD9KYNHUY
         IFqcFTzZjqPiH+z/QDoCSLS31RzmDrD4pUnPbpdWwAvOAsoj2eopXe7yPgcBcRvWjUar
         3nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731983451; x=1732588251;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GR5z0Zmm7jGTILB2ZTA1J3Uc3kfsx9w8jQHvhZLeBrg=;
        b=P54nXEB9RCmRsaC2SUBsWiQZFoImuwMguTc/3NAbD2L+Nl1SdXyTDa/4M5khIfiXVh
         DEO7qf22iyXDWtrPS3MGe/7V7ZMkozXs7tOM47OkBgpOI/fkPGN8NZCO8JEomKMyE/pl
         jSin+E9ynn2Mr8O0nt+y6t/oBoy1bXQCSBswXW2YnAfWrXCB9//itd4j9bTscEm/nOEi
         hEzjzMUNzED5wPgl2Ycy5S6Gqhl02+c8OUCQsIw5PXqZmytVVmm2QLCi1wXB8q8peWXR
         TA+fm1/9wPq3jHCEH5XZYqxzaenPbnwWcO1xzYPn8KliBGP6dHiKPQWGiZp045RYydWC
         L82w==
X-Forwarded-Encrypted: i=1; AJvYcCX2V0o9ozPMc40Ri3gKbRqYQxUHirXrw0H/zU7+Yf9q2axP1fERxDUYldov4W/Hi+/7fvIai7OPAKYSyjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ezy72DH0gC0GtSp5grK++k2DV0ZKOKQz5lyQYFSqA7K+Jivh
	/uZXp3LJKw990nZd/9bq/W8wbTEpkk/T78cYJO5P3bDDXn1nB1Y7
X-Google-Smtp-Source: AGHT+IECCcO1uWUVqVM4ALsnE48fZ2zOS3OG/TR46Myj99u1TJg/iJh5npC+mONFvjHM6HPxnZPNOQ==
X-Received: by 2002:a17:906:dac7:b0:aa4:777d:739a with SMTP id a640c23a62f3a-aa4833e9fcbmr1381694766b.8.1731983450744;
        Mon, 18 Nov 2024 18:30:50 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e045270sm595633666b.146.2024.11.18.18.30.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2024 18:30:48 -0800 (PST)
Date: Tue, 19 Nov 2024 02:30:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com
Subject: Re: [PATCH 3/5] maple_tree: use vacant nodes to reduce worst case
 allocations
Message-ID: <20241119023047.sentd5e75yak36za@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <20241114170524.64391-4-sidhartha.kumar@oracle.com>
 <20241115075203.ojspk255cw3sr3s3@master>
 <2aa439f1-d33d-43ee-9945-5ac570506c7e@oracle.com>
 <20241116014116.a7am7z4p7k33rkl5@master>
 <74e8665a-3818-4e6c-83d1-9a0220a79e49@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e8665a-3818-4e6c-83d1-9a0220a79e49@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Nov 18, 2024 at 11:36:18AM -0500, Sidhartha Kumar wrote:
>On 11/15/24 8:41 PM, Wei Yang wrote:
>> On Fri, Nov 15, 2024 at 03:34:55PM -0500, Sidhartha Kumar wrote:
>> > On 11/15/24 2:52 AM, Wei Yang wrote:
>> > > On Thu, Nov 14, 2024 at 12:05:22PM -0500, Sidhartha Kumar wrote:
>> > > > In order to determine the store type for a maple tree operation, a walk
>> > > > of the tree is done through mas_wr_walk(). This function descends the
>> > > > tree until a spanning write is detected or we reach a leaf node. While
>> > > > descending, keep track of the height at which we encounter a node with
>> > > > available space. This is done by checking if mas->end is less than the
>> > > > number of slots a given node type can fit.
>> > > > 
>> > > > Now that the height of the vacant node is tracked, we can use the
>> > > > difference between the height of the tree and the height of the vacant
>> > > > node to know how many levels we will have to propagate creating new
>> > > > nodes. Update mas_prealloc_calc() to consider the vacant height and
>> > > > reduce the number of worst allocations.
>> > > > 
>> > > > Rebalancing stores are not supported and fall back to using the full
>> > > > height of the tree for allocations.
>> > > > 
>> > > > Update preallocation testing assertions to take into account vacant
>> > > > height.
>> > > > 
>> > > > Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
>> > > > ---
>> > > > include/linux/maple_tree.h       |  2 +
>> > > > lib/maple_tree.c                 | 13 +++--
>> > > > tools/testing/radix-tree/maple.c | 97 +++++++++++++++++++++++++++++---
>> > > > 3 files changed, 100 insertions(+), 12 deletions(-)
>> > > > 
>> > > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>> > > > index cbbcd18d4186..7d777aa2d9ed 100644
>> > > > --- a/include/linux/maple_tree.h
>> > > > +++ b/include/linux/maple_tree.h
>> > > > @@ -463,6 +463,7 @@ struct ma_wr_state {
>> > > > 	void __rcu **slots;		/* mas->node->slots pointer */
>> > > > 	void *entry;			/* The entry to write */
>> > > > 	void *content;			/* The existing entry that is being overwritten */
>> > > > +	unsigned char vacant_height;	/* Depth of lowest node with free space */
>> > >                                ^^^           ^^^
>> > > 
>> > > Would this be a little misleading?
>> > > 
>> > 
>> > Could you elaborate on how its misleading?
>> > 
>> 
>> As you mentioned in previous patch, depth and height has different meaning.
>> 
>> Root node has depth of 0 and height of 1. So I may wandering whether this is
>> depth or height.
>> 
>> > > > };
>> > > > 
>> > > > #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
>> > > > @@ -498,6 +499,7 @@ struct ma_wr_state {
>> > > > 		.mas = ma_state,					\
>> > > > 		.content = NULL,					\
>> > > > 		.entry = wr_entry,					\
>> > > > +		.vacant_height = 0					\
>> > > > 	}
>> > > > 
>> > > > #define MA_TOPIARY(name, tree)						\
>> > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> > > > index 21289e350382..f14d70c171c2 100644
>> > > > --- a/lib/maple_tree.c
>> > > > +++ b/lib/maple_tree.c
>> > > > @@ -3545,6 +3545,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>> > > > 		if (ma_is_leaf(wr_mas->type))
>> > > > 			return true;
>> > > > 
>> > > > +		if (mas->end < mt_slots[wr_mas->type] - 1)
>> > > > +			wr_mas->vacant_height = mas->depth + 1;
>> > > 
>> > > For some cases in rebalance, we may split data into three parts, which means
>> > > we need 2 extra vacant slot.
>> > > 
>> > > Maybe this check is not accurate?
>> > > 
>> > 
>> > The triple split scenario which you are describing comes from the spanning
>> > store case not on the wr_rebalance case. There is a check before we set
>> > vacant height to return if is_span_wr() so I believe this is correct still.
>> > 
>> 
>> Hmm... I come up with a case in which vacant_height may not high enough.
>> 
>> Here is the subtree where spanning write locates. The first level is the
>> parent node of the second level nodes.
>> 
>>                  vacant node
>>                  +--------+-+-+-------+
>>                  |        |l|r|       |
>>                  +--------+-+-+-------+
>> 
>>                  l                 r
>>      +------+    +----+-------+    +---------+--+    +------+
>>      |      |    |    |       |    |         |  |    |      |
>>      +------+    +----+-------+    +---------+--+    +------+
>>                       ^                      ^
>> 		     |                      |
>> 		   index                   last
>> 
>> When mas_wr_walk_descend() to node l, mas_is_span_wr() return true since last
>> is in the right sibling, node r. Let's say the parent is vacant and l/r is
>> leaf. So the request number is (1 * 3) + 1.
>> 
>> Let's assume:
>> 
>>    * vacant node is just sufficient
>>    * l's left part + r's right part is sufficient but not overflow
>> 
>> Then the "new vacant node" would be deficient and needs another round
>> rebalance.
>> 
>> For this case, I am afraid it doesn't allocate enough nodes. Or I
>> misunderstand this?
>
>I think you are correct and we need to use the sufficient height which is
>introduced in patch 5 in the spanning store case similar to how patch 5 uses
>it for the rebalance store case.
>
>	case wr_rebalance:
>		if (wr_mas->sufficient_height < wr_mas->vacant_height) {
>			ret = (height - wr_mas->sufficient_height)*2 +1;
>			break;
>		}
>		ret = delta * 2 + 1;
>		break;
>

I have thought about this.

But the spanning write case seems to be a little special to
splitting/rebalance.

It could be both require one more extra slot and may need to be rebalanced.
We are not sure the exact behavior on converge node. Only check one aspect
seems not enough.

Do you think so ?

-- 
Wei Yang
Help you, Help me

