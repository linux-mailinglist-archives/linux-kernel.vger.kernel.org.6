Return-Path: <linux-kernel+bounces-339705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D905398694C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E54286969
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19AC156677;
	Wed, 25 Sep 2024 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV3VqO6p"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456913F9D5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305151; cv=none; b=cZ+HeR1nQ63avKTOuhohzpqDeQZY/c8PkjYIEPfMaG4F6m9o/Cu8kGA6eZUTsDcq8bOc+DSzkAbulDdgOVXC/IaM1ewRTd7OiNVU+4cfP6jRDLS6s6H6fIzdCiHgm/NFtLoqF38l432pzGey/dWqg24LXQ0WDnrBH0adpBBvM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305151; c=relaxed/simple;
	bh=O7JiwCuz41E0qOOgcfaHagA5FfzCgmRSsIhCjGasEcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2lokI/RTlNpdrPejOcR2gKBz9YYFCwI7EOrjUahY/LW4CcejLvg//m8kJfDFx2GqrcJR82JPzrU5IlB8SkTjq/Usv7sUwf970THAD9ctt5C21c1wU0a59wi78FQk8cXFxdilA5U9VeHPgWSAugwbS8YK9ImWUDT5AqlvQCn6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV3VqO6p; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365928acd0so530101e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727305147; x=1727909947; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPHAaStQaII888K+8FlasHr0p/vMD/r1ZG30txthNAs=;
        b=YV3VqO6pbTd5kFhDguzc+HXYPcMqktwzcsTgf/zwGSmmCEIbFhf7Md84T10ooGi8/V
         RizwfYGhlaDnr28r6yHLP+Rem2SUojWGdak9rKSs6ti0d0AwU56puyyhlL/ykqC2n+qa
         JCayIUqz3qq4mndB5cO/OAwnF3spDS3FhGMY8yU5Xj3PH5IVEedwWKOzhdxWjT+EfJ2p
         z8wlLnYPSXrz+0OrDEDTCIl2T9AZ+qLRUHWoVRxQDuC8bjQBPN+E6XENVttXP6UTChVl
         vIyAsvsd+GxO6H6wkwDL2b6E3WKwG/lQDifAiAfxnGaTQMj2wwqkEJvLD97rT8KL0khI
         iR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727305147; x=1727909947;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPHAaStQaII888K+8FlasHr0p/vMD/r1ZG30txthNAs=;
        b=qX1XaDS8j594g27xUBQMmrCCHiv1R3LFPtG85YIx5rlaYlKZO1qh4uwiQeG4i4NGd3
         ua5uyGrB+WUkNLoY73x/WKeQyE7KV1hKDuoUMj2kvVl64d96hiA6kdQmODlXbgMPlmME
         oCQgDjGMEK0yVNZzGXphRxRdcPzPqllmwVGiTleeB42kVcBRcv9m7QDPwzbf/55EzFX3
         pG5oWiokbsFsZ6NXDp9+Af2lMBaKLGJqV7Cc6EgJQdr4u3KhvmemX6pRe5C5zoe33NrI
         KVphNDb2YCez+BK9ueUUQS4eTiH4sVCOEBclZ4GcfMTMmW2f33S391gWXd+slVJMniB1
         wuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSnpZoXoM1InvcBIrgNUJqAi734pcLPrBVMhc6f7tzm7REqlYOpk459paLGHmPKqntdREZSIBL6lvKjjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaevR2OOQqQ+nVZO0NuV83f+7MvZHVBI1DEBS8GgJgBm2YNdyi
	pdSkCW5SISoWYzPm82IxLkZszHt9n3YFvufQLlGpH2SGdkpzzZme6mkau5j3
X-Google-Smtp-Source: AGHT+IFh5RcaK0Z1IWIgAeZgenLV2GEOBr1rLWF6USOcFDQF3Fg28CqDAPvm4tYKWZ25FuX1fWFf2g==
X-Received: by 2002:a05:6512:b03:b0:52c:9383:4c16 with SMTP id 2adb3069b0e04-538704986bamr2828395e87.22.1727305146963;
        Wed, 25 Sep 2024 15:59:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f4faebsm277812166b.52.2024.09.25.15.59.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2024 15:59:05 -0700 (PDT)
Date: Wed, 25 Sep 2024 22:59:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sid Kumar <sidhartha.kumar@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com,
	willy@infradead.org, surenb@google.com
Subject: Re: [PATCH v4 04/17] maple_tree: introduce mas_wr_store_type()
Message-ID: <20240925225904.jryrxogfzxsbacsj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-5-sidhartha.kumar@oracle.com>
 <20240925020431.joykmu4zzahoglcl@master>
 <f8924491-929b-4b10-b13f-0b6461d28eec@oracle.com>
 <47463235-bc45-46e2-8d9d-b62c201c6215@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47463235-bc45-46e2-8d9d-b62c201c6215@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Sep 25, 2024 at 02:36:21PM -0500, Sid Kumar wrote:
>
>On 9/25/24 2:33 PM, Sid Kumar wrote:
>> 
>> On 9/24/24 9:04 PM, Wei Yang wrote:
>> > On Wed, Aug 14, 2024 at 12:19:31PM -0400, Sidhartha Kumar wrote:
>> > 
>> > Sorry for a late reply, I just see this change.
>> > 
>> > > +
>> > > +/*
>> > > + * mas_wr_store_type() - Set the store type for a given
>> > > + * store operation.
>> > > + * @wr_mas: The maple write state
>> > > + */
>> > > +static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
>> > > +{
>> > > +    struct ma_state *mas = wr_mas->mas;
>> > > +    unsigned char new_end;
>> > > +
>> > > +    if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
>> > > +        mas->store_type = wr_store_root;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    if (unlikely(!mas_wr_walk(wr_mas))) {
>> > > +        mas->store_type = wr_spanning_store;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    /* At this point, we are at the leaf node that needs to be
>> > > altered. */
>> > > +    mas_wr_end_piv(wr_mas);
>> > > +    if (!wr_mas->entry)
>> > > +        mas_wr_extend_null(wr_mas);
>> > > +
>> > > +    new_end = mas_wr_new_end(wr_mas);
>> > > +    if ((wr_mas->r_min == mas->index) && (wr_mas->r_max ==
>> > > mas->last)) {
>> > > +        mas->store_type = wr_exact_fit;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
>> > > +        mas->store_type = wr_new_root;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    /* Potential spanning rebalance collapsing a node */
>> > > +    if (new_end < mt_min_slots[wr_mas->type]) {
>> > > +        if (!mte_is_root(mas->node)) {
>> > > +            mas->store_type = wr_rebalance;
>> > > +            return;
>> > > +        }
>> > > +        mas->store_type = wr_node_store;
>> > > +        return;
>> > > +    }
>> > After this check, we are sure new_end >= mt_min_slots[wr_mas->type].
>> > 
>> > > +
>> > > +    if (new_end >= mt_slots[wr_mas->type]) {
>> > > +        mas->store_type = wr_split_store;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
>> > > +        mas->store_type = wr_append;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
>> > > +        (wr_mas->offset_end - mas->offset == 1))) {
>> > > +        mas->store_type = wr_slot_store;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    if (mte_is_root(mas->node) || (new_end >=
>> > > mt_min_slots[wr_mas->type]) ||
>> > > +        (mas->mas_flags & MA_STATE_BULK)) {
>> > The check (new_end >= mt_min_slots[wr_mas->type]) here seems always
>> > be true.
>> > 
>> > So the if here seems not necessary. Do I miss something?
>> 
>> It is true that at this point new_end >= mt_min_slots[wr_mas->type] must
>> be true but if we remove that check we won't catch this wr_node_store
>> case if !mte_is_root() and !(mas->mas_flags & MA_STATE_BULK).
>> 
>> We could change the default store type to be wr_node_store and get rid of
>> that whole if statement entirely.
>> 
>> This diff passes the tests:
>> 
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c index
>> 4f34e50c92b5..2ae0c4da9d74 100644 --- a/lib/maple_tree.c +++
>> b/lib/maple_tree.c @@ -4242,14 +4242,7 @@ static inline void
>> mas_wr_store_type(struct ma_wr_state *wr_mas) return; } - if
>> (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) || -
>> (mas->mas_flags & MA_STATE_BULK)) { - mas->store_type = wr_node_store; -
>> return; - } - - mas->store_type = wr_invalid; - MAS_WARN_ON(mas, 1); +
>> mas->store_type = wr_node_store; }
>> 
>> do you think this makes sense?
>> 
>Sorry this diff wasn't formatted correctly, it should look normal now:
>
>diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>index 4f34e50c92b5..2ae0c4da9d74 100644
>--- a/lib/maple_tree.c
>+++ b/lib/maple_tree.c
>@@ -4242,14 +4242,7 @@ static inline void mas_wr_store_type(struct
>ma_wr_state *wr_mas)
>                return;
>        }
>
>-       if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type])
>||
>-               (mas->mas_flags & MA_STATE_BULK)) {
>-               mas->store_type = wr_node_store;
>-               return;
>-       }
>-
>-       mas->store_type = wr_invalid;
>-       MAS_WARN_ON(mas, 1);
>+       mas->store_type = wr_node_store;
> }
>

I am ok for this one.

>> Thanks,
>> 
>> Sid
>> 
>> > > +        mas->store_type = wr_node_store;
>> > > +        return;
>> > > +    }
>> > > +
>> > > +    mas->store_type = wr_invalid;
>> > > +    MAS_WARN_ON(mas, 1);
>> > > +}
>> > > +

-- 
Wei Yang
Help you, Help me

