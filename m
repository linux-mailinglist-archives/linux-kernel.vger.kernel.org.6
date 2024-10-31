Return-Path: <linux-kernel+bounces-391445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD29B86F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51519B22116
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF81E3DFE;
	Thu, 31 Oct 2024 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrZVxWpo"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8871E0DE5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416703; cv=none; b=MuJiCTno7nhmWBhHc/0Ey41bSiCiXS6G7Rj1hROLsHvRMdiT6Kv+lub7oIj+9eumwZ6xgutV8Mvfezem9Pf5NTJUcR3BOM64q7omJCnwU6PdcMUwA/X+/H2nAsm2vk9lotJOB42RSVRCgq7sFJ2stjUHknsQIGh8HMF+FDghXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416703; c=relaxed/simple;
	bh=ZOyR5cIte5Nd3ycYscyqHnUxuQs9W9yjiWKEA5E3h0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9CvmW766Sf+oh/9IBCPUnVC77+OEwmqtoDCz/Ye4l+zfb1JbtcsyFwDCXqjq4QovHPbO9c9h0Ln7PIkVG9HCyJBVQzmhg9Dhfm475co4R7nI4Rm8e76E4d1WiZxjJZVcWo5kZP2gNcAWl0xllvAJmJy1kmtMipCPZCWTT014qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrZVxWpo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99eb8b607aso163404066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730416696; x=1731021496; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMzXCuLRsSn0Wb6BJfBCmAvab9Yqqj/1fMCR0enJw8E=;
        b=LrZVxWpoeDBumFSXaIXdD74d2FwF6PNlR/bGSf/4osK1IfNLjSvflAIuXbad3tB0lE
         q2aL7El7Xz58K09ue4lbWpY+iLpjzpXs9CU4K5vnu4sxA7I7P/xpJ7bhDKC5ocdiOKqZ
         L8najtmXH2efDJhSLvNQlRvmy+D8CsTXXFT2BbHChhZwcZxnZT6Z9O2we3nvibDN5Ngr
         ffcoiN9IzesE4Ukk0lhrnUUo/WITkn0uA6VlewOEULH84kyBXs74d3Hiv2nSqVjs1m//
         a9DKiAJGsxJmgVBc53/YCzGSKhUierEyAnO5wjQIPP2E/t3vRI+z32mVFNuHS7IOp+xq
         31FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730416696; x=1731021496;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMzXCuLRsSn0Wb6BJfBCmAvab9Yqqj/1fMCR0enJw8E=;
        b=JLkbHT3pDaZpS1ShEQuXCOuYbfUOwjLAPI0Rlxb7+7RuAbFsASXFc5FcWI/qOg7Bfd
         EvEl0MH6IPlOj3GbJo53I05VgmjuU0VmBfcaRvvIoJTsNqjKcJ6p+5ueymTTSPDGuFFi
         MPUFnCQlWtKXeg9ROx21xGdg4MFZBpJo6PKIaOQkedz+3jJ0xHJw5ed9uXhMQ4SceYbV
         +y3bZO2+sGcIvwcm7Ua/uB6JePtTg1MgQp69EwypqNaLKlcehB9U9FzKlGiOni5assrS
         3886uj/doHnxVLLT8Gm7QEgw+lXaxY+1l6cojziJarIib/+zbH8756PddrFtuKfHb3zx
         kHfg==
X-Forwarded-Encrypted: i=1; AJvYcCVYAW8mVVPsQxwknaTMZsPFxwPvmoTNT4OHKGun6jzyvsqrBfo+iRUvCXzHOS+F+4pgIGo8iQxDy9SV0yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlsxxzFYvWQeQeRHJFoofgz1ecgXRA5MjFoJ75Kd2+Lxctw59
	pTguHohrevBIjYhWBSRwP8JYVZr6IslvZzFBUF22dL2fa9rUrWOR
X-Google-Smtp-Source: AGHT+IENbqhdS838jZ3geEuc7x1npwi+AAO9i0bOQRab1PoEVWEyqCBKcDwT2gmlM8518ne1ZVTV9g==
X-Received: by 2002:a17:906:6a19:b0:a99:eb94:3e37 with SMTP id a640c23a62f3a-a9de632ffbamr1731425166b.58.1730416695982;
        Thu, 31 Oct 2024 16:18:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c55f4sm115351766b.78.2024.10.31.16.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2024 16:18:14 -0700 (PDT)
Date: Thu, 31 Oct 2024 23:18:12 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sid Kumar <sidhartha.kumar@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com,
	willy@infradead.org, surenb@google.com
Subject: Re: [PATCH v4 16/17] maple_tree: remove unneeded mas_wr_walk() in
 mas_store_prealloc()
Message-ID: <20241031231812.cnvt4jtw4axykiwh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-17-sidhartha.kumar@oracle.com>
 <20241024012038.zf3dpqsflnyi4wce@master>
 <b4ad4b6a-f0b5-4ed1-a49a-d4e9ed0e4831@oracle.com>
 <20241025235850.5o6l3k2u2so6hxrs@master>
 <2eb5fa18-bcf4-40d8-bf0e-8cc92b30de04@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2eb5fa18-bcf4-40d8-bf0e-8cc92b30de04@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Oct 29, 2024 at 11:46:58AM -0400, Sid Kumar wrote:
>
>On 10/25/24 7:58 PM, Wei Yang wrote:
>> On Fri, Oct 25, 2024 at 03:54:04PM -0400, Sid Kumar wrote:
>> > On 10/23/24 9:20 PM, Wei Yang wrote:
>> > > On Wed, Aug 14, 2024 at 12:19:43PM -0400, Sidhartha Kumar wrote:
>> > > > Users of mas_store_prealloc() enter this function with nodes already
>> > > > preallocated. This means the store type must be already set. We can then
>> > > > remove the call to mas_wr_store_type() and initialize the write state to
>> > > > continue the partial walk that was done when determining the store type.
>> > > > 
>> > > May I ask what is the partial walk here means?
>> > > 
>> > > It is the mas_wr_walk() in mas_wr_store_type() which is stopped because of it
>> > > is spanning write?
>> > Yes, this is what I meant by the partial walk that's already been started.
>> > It's the walk done by mas_wr_store_type().
>> > 
>> > > I may lost some background, so the assumption here is mas_wr_store_type() has
>> > > already been invoked and the store type has been decided, right?
>> > Ya users of mas_store_prealloc() should have already called mas_preallocate()
>> > which does:
>> > 
>> >      mas->store_type = mas_wr_store_type(&wr_mas);
>> >      request = mas_prealloc_calc(&wr_mas, entry);
>> > 
>> > to set the store type and allocate the nodes.
>> > 
>> > 
>> > > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> > > > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> > > > ---
>> > > > lib/maple_tree.c | 18 +++++++++++++-----
>> > > > 1 file changed, 13 insertions(+), 5 deletions(-)
>> > > > 
>> > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> > > > index 8c1a1a483395..73ce63d9c3a0 100644
>> > > > --- a/lib/maple_tree.c
>> > > > +++ b/lib/maple_tree.c
>> > > > @@ -3979,9 +3979,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
>> > > > 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
>> > > > 	else
>> > > > 		wr_mas->end_piv = wr_mas->mas->max;
>> > > > -
>> > > > -	if (!wr_mas->entry)
>> > > > -		mas_wr_extend_null(wr_mas);
>> > > > }
>> > > > 
>> > > > static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>> > > > @@ -5532,8 +5529,19 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>> > > > {
>> > > > 	MA_WR_STATE(wr_mas, mas, entry);
>> > > > 
>> > > > -	mas_wr_prealloc_setup(&wr_mas);
>> > > > -	mas_wr_store_type(&wr_mas);
>> > > > +	if (mas->store_type == wr_store_root) {
>> > > > +		mas_wr_prealloc_setup(&wr_mas);
>> > > > +		goto store;
>> > > > +	}
>> > > > +
>> > > > +	mas_wr_walk_descend(&wr_mas);
>> > > This one does not descend the tree, just locate the offset in a node and
>> > > adjust min/max. So not look like to continue the partial walk to me.
>> > > 
>> > > > +	if (mas->store_type != wr_spanning_store) {
>> > > > +		/* set wr_mas->content to current slot */
>> > > > +		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
>> > > > +		mas_wr_end_piv(&wr_mas);
>> > > If not a spanning write, the previous walk should reach a leaf node, right?
>> > Ya that's true.
>> > 
>> > > I am not sure why we don't need to check extend null here. Because we have
>> > > already done it?
>> > 
>> > Ya we extend null in mas_wr_store_type() which has already been called at
>> > this point.
>> > 
>> > 
>> >      /* At this point, we are at the leaf node that needs to be altered. */
>> >      mas_wr_end_piv(wr_mas);
>> >      if (!wr_mas->entry)
>> >          mas_wr_extend_null(wr_mas);
>> > 
>> > Thanks,
>> Hmm... if we have already done this, why we need to do mas_wr_end_piv() again?
>
>The maple write state here is local to this function:
>
>void mas_store_prealloc(struct ma_state *mas, void *entry)
>{
>    MA_WR_STATE(wr_mas, mas, entry);
>
>so we don't retain the wr_end information from the previous call to
>mas_preallocate() and have to repeat it here. The write state is not
>currently exposed so have to call mas_wr_end_piv() again.
>

Thanks, I missed this point.

>Thanks,
>
>Sid
>
>
>> 
>> > Sid
>> > 
>> > > > +	}
>> > > > +
>> > > > +store:
>> > > > 	trace_ma_write(__func__, mas, 0, entry);
>> > > > 	mas_wr_store_entry(&wr_mas);
>> > > > 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>> > > > -- 
>> > > > 2.46.0
>> > > > 

-- 
Wei Yang
Help you, Help me

