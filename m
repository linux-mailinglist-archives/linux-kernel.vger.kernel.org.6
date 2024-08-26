Return-Path: <linux-kernel+bounces-300672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3B95E70D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1CD1F216D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C511187;
	Mon, 26 Aug 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgVgnrv6"
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DD4A33
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640908; cv=none; b=kRuTgBg27B9/Xv8i0263fndIUxdYAgkuzwL6vNdVGZwtXHrOT0AIzYliDg3I4MCXNypqvNHpbNnGrSe8LcAd7CQ1xmaFUpf22capQA0p+RR5vMSfAAwd7aG0QCEVZd+QbzCPBCHPWslIRU+c2CdjrY8sqFlcbplFGtsIBqXLNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640908; c=relaxed/simple;
	bh=wch1VE3ekhiKfPDNZCfm4vFCsVY9Wki3KiyENzLC+Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxyo1J2afRzAWRmyniZH2g++2QvPyMQxeejDQ27DvC9oIpOsRF9QupLiceXvmzsXD1BZM0R4SmYzADgrd6vBEEkwzfgQV0Tu2UAkFD8fQubo9To7GkWp5CuN0zK0bY4iTbuG+HuliyHDfB4NGQrdeJr0ZLsfJzP3JRTXP5JBmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgVgnrv6; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-709485aca4bso2739422a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 19:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724640905; x=1725245705; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IaRtfP1090mN3gRRhXCOebzcm74U5DXp8b46kp+AZI=;
        b=PgVgnrv6OMeBGyWD6agvpKOlXRssr7KIRC8/kHoU2J8Sah5SO5Q/SBXvf5DB/vKPcX
         HY0DP3rwZA1OxO48oeNoJbCaNSRjvZum/0rAKcXry5vOiStIvQ1vU6Ukek8C5E/MPPOL
         A+6hdhViuhqTftD+VqGx0yMlVbfhcn+jI/T20MN9bk6BFviWhbCX5i+39cxz2KFP+CLG
         EvkwwHNDEN+CKUPXNw56elraQsPijnPvFvbl89cRh8ngN2IWcKyAycVZ4RFW3sQKh93Q
         TdmqIGe5FrT87EZByAhz0blFhZAuIFBfzSFsnUlSkkUdXHTXZylDYUQ0yaX9shAxqulY
         52ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724640905; x=1725245705;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IaRtfP1090mN3gRRhXCOebzcm74U5DXp8b46kp+AZI=;
        b=qJ1ZLZLSOhJCeyXE0eEKKr9I4LcEGCrs/GuemxmUXp6lZFE5IbAHqBLvNkuPCdoMWs
         JpnCzsVFWmJRpDtHRgh4CK01IvF6GuJGfTC/oPrf9f+7R2YoZIxUet7rnG7uNrnk4eMm
         mXpmNv8BrHIIVWr/iEBgg77PZIzGq7YaOXAoZa8cZ3J/TKJT9yUGM1Qt6kEpJLj4qmSU
         xSpQHhgLIZIJ8jZYNk3uYZHJQeztDpuQdXS4HVjmGnnxWzLwn411ET9YFU8cRTw5II7F
         /gphRCkkyxE7GbkpGNN81jocjeVgMncl/ERLsw/OGQsijk7D/Qsxeu0RxHy32LtZiFAY
         uT5w==
X-Forwarded-Encrypted: i=1; AJvYcCUMWKQmSNfKPka38KtTrz6IfMRWiihP3XaCwjUjOz6rBkhnNcrYKTbXnLRcwjEoS7Ep57JyWDo+5Qw9eh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjW7OXrugFQt6eH+zn6CEP5Scf/5mjNs84xsNVQ5qxPptKx6Uq
	/RrjTuSjghXjWhc7/fiBaroX9Ye6qnPnvSb5NxXClBY6ETYos+B0
X-Google-Smtp-Source: AGHT+IGE0tfHJit81v9GjxnFkZEMB4v71YR2yCJY/ir99zwISqw6rRuLbcvEUZ/DKp9IcT8nngPgXg==
X-Received: by 2002:a05:6808:210f:b0:3d8:49c1:8f5c with SMTP id 5614622812f47-3de2a881da0mr12478345b6e.28.1724640905485;
        Sun, 25 Aug 2024 19:55:05 -0700 (PDT)
Received: from systemsresearch.io ([2a01:7e03::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9aca5faasm5739552a12.20.2024.08.25.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 19:55:05 -0700 (PDT)
Date: Mon, 26 Aug 2024 02:55:03 +0000
From: Hao Li <haoli.tcs@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
	maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] maple_tree: simplify mas_wr_node_walk for improved
 readability
Message-ID: <20240826025503.GA14851@systemsresearch.io>
References: <20240823081729.GA23434@systemsresearch.io>
 <8f98e3e8-b6c4-4888-bfc7-204bea32004b@bytedance.com>
 <20240823093824.GA566@systemsresearch.io>
 <k7mse2jyysazfayjayamr75dxtsjx3dbgvci65jhaaiye2l7qi@hwwvinj2mgoa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <k7mse2jyysazfayjayamr75dxtsjx3dbgvci65jhaaiye2l7qi@hwwvinj2mgoa>
User-Agent: Mutt/1.12.1 (2019-06-15)

On Fri, Aug 23, 2024 at 01:51:28PM -0400, Liam R. Howlett wrote:
> * Hao Li <haoli.tcs@gmail.com> [240823 05:38]:
> > On Fri, Aug 23, 2024 at 05:07:31PM +0800, Peng Zhang wrote:
> > > 
> > > 
> > > 在 2024/8/23 16:17, Hao Li 写道:
> > > > Refactor mas_wr_node_walk to make the code more clear and easier to
> > > > understand. The main changes are:
> 
> Thank you for your patch, but I don't think this is a good change.

Thank you for taking the time to review my patch and provide detailed feedback.

> 
> NACK
> 
> > > > 
> > > > 1. Replace the forward-iterating loop with a backward-iterating loop.
> > > >   This simplifies the logic for determining the correct range
> > > >   containing mas->index.
> > > I don't think iterating in reverse is a good idea, it makes the code
> > > different from everywhere else.
> > 
> 
> I also agree with Peng that having one loop go a different way seems
> like it's asking for trouble.
> 
> > I understand your concern about consistency in iteration direction.
> > 
> > While the original code correctly handled all cases, the process wasn't
> > as definitive or clear.
> > 
> > The new approach unifies the logic by eliminating the need to treat
> > `offset >= count` as a special case. This results in a more
> > straightforward and consistent flow throughout the function, which
> > provides a more deterministic and easy-to-follow path through the logic.
> > We can more clearly see and understand how we're determining the correct
> > range for `mas->index` without having to mentally parse complex
> > conditional logic.
> > 
> > > > 
> > > > 2. Eliminate the ternary operator.
> 
> This is not more clear as one may miss that the loop may not execute at
> all. So you eliminated the ternary operator, but have all but hidden the
> assignment.  I would rather an if/else for verbosity, but not enough to
> reject the patch that added it in the first place.

Got it!

> 
> You also replaced the "unsigned char count" with an "int idx", for some
> reason.  It seems like you've rewritten it so it's more clear for you.
> 
> > > > 
> > > > The new implementation maintains the same functionality as before, but
> > > > with improved readability. The performance characteristics remain
> > > > essentially the same, as we cannot predict which interval mas->index
> > > > will fall into.
> 
> We do favour the left side of the tree to increase data density, so it
> is more likely to find what we are looking for in the lower slots (but
> not by a whole lot right now). There will probably be more of this
> favouring in the future - minimum span for internal nodes.

Got it.

> 
> BENCH_NODE_STORE went from 8.79, 8.85, 8.79 seconds to 9.68, 9.74, 9.72.
> This change is slower.  It may be because you removed all the temporary
> variables that avoided dereferencing, so the compiler can't be as smart
> about optimisation.  I'm not really interested in finding out why it's
> slower as I don't think this is a good change on the grounds of other
> reasons stated as well.

Thanks for this benchmarking, I didn't even realize this performance
regression.


Regards,
Hao Li
> 
> Thanks,
> Liam
> 
> > > > 
> > > > Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> > > > ---
> > > >   lib/maple_tree.c | 18 ++++++++----------
> > > >   1 file changed, 8 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > > index fe1b01b29..0b3eb55d8 100644
> > > > --- a/lib/maple_tree.c
> > > > +++ b/lib/maple_tree.c
> > > > @@ -2203,7 +2203,7 @@ static inline void mas_node_or_none(struct ma_state *mas,
> > > >   static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
> > > >   {
> > > >   	struct ma_state *mas = wr_mas->mas;
> > > > -	unsigned char count, offset;
> > > > +	int idx;
> > > >   	if (unlikely(ma_is_dense(wr_mas->type))) {
> > > >   		wr_mas->r_max = wr_mas->r_min = mas->index;
> > > > @@ -2213,16 +2213,14 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
> > > >   	wr_mas->node = mas_mn(wr_mas->mas);
> > > >   	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
> > > > -	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
> > > > +	mas->end = ma_data_end(wr_mas->node, wr_mas->type,
> > > >   				       wr_mas->pivots, mas->max);
> > > > -	offset = mas->offset;
> > > > -
> > > > -	while (offset < count && mas->index > wr_mas->pivots[offset])
> > > > -		offset++;
> > > > -
> > > > -	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
> > > > -	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
> > > > -	wr_mas->offset_end = mas->offset = offset;
> > > > +	wr_mas->r_max = mas->max;
> > > > +	idx = mas->end - 1;
> > > > +	while (idx >= mas->offset && wr_mas->pivots[idx] >= mas->index)
> > > > +		wr_mas->r_max = wr_mas->pivots[idx--];
> > > > +	wr_mas->offset_end = mas->offset = idx + 1;
> > > > +	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, mas->offset);
> > > >   }
> > > >   /*

