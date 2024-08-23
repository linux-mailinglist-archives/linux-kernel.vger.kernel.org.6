Return-Path: <linux-kernel+bounces-298610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0E95C960
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4901F25292
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030E14C599;
	Fri, 23 Aug 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZB1kiPc"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2613B5A9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405909; cv=none; b=tdYeRur5mYKutbqISpmm38span3ed7LiT/NIICUfE5SDepXg1LUUX9bsQvZV+2XyFEv1mmwpav+wh1NbJZlXAMae2zvA1C4hik+blaosAEKm38vsmnro2Kla4b5kxIJPogSm1mi9goiTL3Vaur7Q6xP+nw+XorMljMFcKCU6aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405909; c=relaxed/simple;
	bh=eQxHZHHZmAFqRWMwcfGLQMinwSGqSq/jT/4d69pPefs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CisvGVAPsz79M+2j0VFyc2gkMuJ5CyO70vL8hh65i3uTELiwP2UXv/hgIh9zvTC3f9BKc1D9IIxnJzOAPaL+fkoG8YVWLsibrFfHlMhe0t8q84KK+/etExjb2gYnn2aIhIjzcuRK/zWyKA334Op4FRCfCVNNNLZ7nmpY1E+SNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZB1kiPc; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-70b2421471aso1176806a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724405907; x=1725010707; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5oOLk8MI11boHepJ7P1CiKf4aFrlYohNlSadcPGjec=;
        b=eZB1kiPcoguuATu9mCMBgk7muSLm95v3H5yZLCf/yc7kT0r8ke0dRI7DhFWQxotzFA
         3A9MOrbLuy9Do9AbH2JmjFoYnc3hXHJIoemf4wUHHTqkbS5yXrh6SrXlSKwaR/B6NSO1
         kVLcbDXPm5qncInkaz3SZemG0djsanc/Mr34OksJDf+5jnSNu9kHge9B+MbxaGoJZEOj
         yHcw8It7xmyN8hSZJFihRIKZm9eMGuBVSvc5l9ZX+1xfUmfYnvEtKP5XYDG2wHA/f3Qj
         e3xAewooUVcAtbE6jvInZlPacdWjkLcoYqt2S2MgH+lHVuKABaOa8C9BKXBG4QEI7H7a
         wysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405907; x=1725010707;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5oOLk8MI11boHepJ7P1CiKf4aFrlYohNlSadcPGjec=;
        b=lcAnNDNfqQ9LL4OCQ6CWzm9IJSly8WFx4YnJVlB9QpGP3abXOwjmEV0A5WO/XOMolP
         DufFBfk6WwlfsTeiGyAfUgp0ohRvxZwF+1QFHTHWOssCVFQAfOpmewxh0g3akBHL5A7U
         m824+JPOlRe2InpafIarNPlqHG458ftk4bIRXc/iGZjAH3bPmFdPSBqV6qVP+vUob1gI
         rDLG7Lq0mwsH8niWzfJLwexvOWVGNcNqHXdbs/CisrvCIHCbgfJJSNQYUCWUF8T0mFEw
         SptlgP2SVA0cGd2rN6kBDJe3GYtLH0wLhSIIohfQXyWny/F1rTyrfZq847Iq0HUBywVN
         iNmw==
X-Forwarded-Encrypted: i=1; AJvYcCX5m+FKMN+9olWdSPs6/rcGQPGk8H7EgzHRYxlBjnxSuPPBVnaxrwlcVNUUGvg9CDWPlACTaMMd3JRgLP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oCdSdvkTCSTP7Sn1nN09qP7d+ZEsO6LaRskLiFRPgPYAqPfx
	jmBI0sN4lHvBk3Kct7Dhwze36WLLqrw59v/LhQMYOMBppNcWOfi3
X-Google-Smtp-Source: AGHT+IFfvNLP1peJ7NzNwN6v20JKPH1tWF56dD4DnsIedCSeMV7VLiTaXeZ0xMHKgrwRIs5zaGW9BA==
X-Received: by 2002:a05:6a20:2d26:b0:1c9:efcb:db07 with SMTP id adf61e73a8af0-1cc8b41fe1fmr2249578637.2.1724405906748;
        Fri, 23 Aug 2024 02:38:26 -0700 (PDT)
Received: from systemsresearch.io ([2a01:7e03::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fc538bsm24885355ad.290.2024.08.23.02.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:38:26 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:38:24 +0000
From: Hao Li <haoli.tcs@gmail.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
	linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com
Subject: Re: [PATCH v2] maple_tree: simplify mas_wr_node_walk for improved
 readability
Message-ID: <20240823093824.GA566@systemsresearch.io>
References: <20240823081729.GA23434@systemsresearch.io>
 <8f98e3e8-b6c4-4888-bfc7-204bea32004b@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f98e3e8-b6c4-4888-bfc7-204bea32004b@bytedance.com>
User-Agent: Mutt/1.12.1 (2019-06-15)

On Fri, Aug 23, 2024 at 05:07:31PM +0800, Peng Zhang wrote:
> 
> 
> 在 2024/8/23 16:17, Hao Li 写道:
> > Refactor mas_wr_node_walk to make the code more clear and easier to
> > understand. The main changes are:
> > 
> > 1. Replace the forward-iterating loop with a backward-iterating loop.
> >   This simplifies the logic for determining the correct range
> >   containing mas->index.
> I don't think iterating in reverse is a good idea, it makes the code
> different from everywhere else.

I understand your concern about consistency in iteration direction.

While the original code correctly handled all cases, the process wasn't
as definitive or clear.

The new approach unifies the logic by eliminating the need to treat
`offset >= count` as a special case. This results in a more
straightforward and consistent flow throughout the function, which
provides a more deterministic and easy-to-follow path through the logic.
We can more clearly see and understand how we're determining the correct
range for `mas->index` without having to mentally parse complex
conditional logic.

> > 
> > 2. Eliminate the ternary operator.
> > 
> > The new implementation maintains the same functionality as before, but
> > with improved readability. The performance characteristics remain
> > essentially the same, as we cannot predict which interval mas->index
> > will fall into.
> > 
> > Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> > ---
> >   lib/maple_tree.c | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index fe1b01b29..0b3eb55d8 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -2203,7 +2203,7 @@ static inline void mas_node_or_none(struct ma_state *mas,
> >   static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
> >   {
> >   	struct ma_state *mas = wr_mas->mas;
> > -	unsigned char count, offset;
> > +	int idx;
> >   	if (unlikely(ma_is_dense(wr_mas->type))) {
> >   		wr_mas->r_max = wr_mas->r_min = mas->index;
> > @@ -2213,16 +2213,14 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
> >   	wr_mas->node = mas_mn(wr_mas->mas);
> >   	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
> > -	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
> > +	mas->end = ma_data_end(wr_mas->node, wr_mas->type,
> >   				       wr_mas->pivots, mas->max);
> > -	offset = mas->offset;
> > -
> > -	while (offset < count && mas->index > wr_mas->pivots[offset])
> > -		offset++;
> > -
> > -	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
> > -	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
> > -	wr_mas->offset_end = mas->offset = offset;
> > +	wr_mas->r_max = mas->max;
> > +	idx = mas->end - 1;
> > +	while (idx >= mas->offset && wr_mas->pivots[idx] >= mas->index)
> > +		wr_mas->r_max = wr_mas->pivots[idx--];
> > +	wr_mas->offset_end = mas->offset = idx + 1;
> > +	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, mas->offset);
> >   }
> >   /*

