Return-Path: <linux-kernel+bounces-379791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466239AE3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E16B21AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA311C9EDC;
	Thu, 24 Oct 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SB1ItGz4"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621C1B392E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769423; cv=none; b=h1f+ztGCcxIFRHt1EKdYap277V1kSh35SpaFbF7fJPpbCEWbQnt+KeZ/YSf9ag8BeJF7ABTqqzm8NQpe0qrK2vBRAmgCnLf5nU9SxQDJcvSYVN1DNeMZvfCUBEP3GXuHAkdrUO+3qNcXTYw+QF86kn+iB3SIMuS4MKhdQtclboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769423; c=relaxed/simple;
	bh=gqCwOa6WUDvOOY/KfgF4EVFQFU95tHUNA/x7kfIBcLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVtbuHH9dKgzHu7CB9e8nGkcsXFR5DW9+EVuWqMuZnLKN2FKxrDB4kNPGeGbAbE/pM9TGZkIXCZXUMf1+zkrH6I8q2pZnQeZ29OU8ue/JYL9u5uMwTfTTZwiMabVxREoQWnuOPylqV7yHF9pwh835Uw4rFn65XNdmh56p+U3aQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SB1ItGz4; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729769417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uvpXFdO1fMRPhRKLb0e0DbG2kGykG6FHwbUwvY7MxmA=;
	b=SB1ItGz40uIYq4i26qPBSmlvT6Ze853rYaRj3zLkCnWaUD569Lh6XdCWfExwR9HV53UH2g
	q1WI7esOLMX4tQbnHPa0le+2cbXb43y5YGyBQCl1Wvukg+NnfG+xGXyl8eW2q6lae7JImK
	H2Yxtf7FP0VGsKHs6gsuUN8XRJKx7pg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Jeongjun Park <aha310510@gmail.com>, mmpgouride@gmail.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] bcachefs: fix shift oob in alloc_lru_idx_fragmentation
Message-ID: <5a2uq4p74ilwtgnq47qlceiwceyttx7zqgovn7ph3jyuaf2dlm@2rqzwizdamdc>
References: <20241021154356.38221-1-aha310510@gmail.com>
 <1e46f070-3e78-4a81-b7c7-ea021271b12b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e46f070-3e78-4a81-b7c7-ea021271b12b@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 22, 2024 at 10:26:18AM +0800, Hongbo Li wrote:
> 
> 
> On 2024/10/21 23:43, Jeongjun Park wrote:
> > The size of a.data_type is set abnormally large, causing shift-out-of-bounds.
> > To fix this, we need to add validation on a.data_type in
> > alloc_lru_idx_fragmentation().
> > 
> > Reported-by: syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com
> > Fixes: 260af1562ec1 ("bcachefs: Kill alloc_v4.fragmentation_lru")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >   fs/bcachefs/alloc_background.h | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/bcachefs/alloc_background.h b/fs/bcachefs/alloc_background.h
> > index f8e87c6721b1..163a67b97a40 100644
> > --- a/fs/bcachefs/alloc_background.h
> > +++ b/fs/bcachefs/alloc_background.h
> > @@ -168,6 +168,9 @@ static inline bool data_type_movable(enum bch_data_type type)
> >   static inline u64 alloc_lru_idx_fragmentation(struct bch_alloc_v4 a,
> >   					      struct bch_dev *ca)
> >   {
> > +	if (a.data_type >= BCH_DATA_NR)
> > +		return 0;
> > +
> 
> oh, I found I have done the same thing in [1]("Re: [syzbot] [bcachefs?]
> UBSAN: shift-out-of-bounds in bch2_alloc_to_text"). But in my humble
> opinion, the validation changes also should be added. And in addition, move
> the condition about a.data_type into data_type_movable will be better. Just
> my personal opinion.:)

Unknown data types (and key types, btree IDs, etc.) are allowed for
forwards compatibility - they should just be ignored

