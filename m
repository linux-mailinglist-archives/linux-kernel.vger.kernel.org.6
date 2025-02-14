Return-Path: <linux-kernel+bounces-515230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1EA3620E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FF53B1C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77222676CA;
	Fri, 14 Feb 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GzoChY85"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E1267391
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547800; cv=none; b=urBYtJvNwje0ejs8wrl9CvMx/M2IwG3MrY9ZeP4k77qfh1BmYp2aN2xBju+LEroo0eylo3bmsSI4mudo2EPtqUn9zOREyyg0tQgYInhegz9bFcIDDC7xmnVx+y9mX1m6/cze9aHRjKj2wAbzwjUcVcBLz7UsajI8zRBSFkkZ+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547800; c=relaxed/simple;
	bh=BK1Fri+lO/TXol6bH8gYdzl+cJl1Jjrl8NM5lBDI6XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emiRlFALn+VGG7AbkPgtdPVdAX2dg1vpcrVAuwzdxDIElGJ3X5P8QzbV0gCBswfeImH+4OKtD47Lm0xhRolS1Km4vW5bt+jqatAQOWzXvJkZKD2NPrlOSayLP8PondhHk3m+0mJ9S2Y7Q3e4YVO/VIKUrFHM1spIiRjwSEymNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GzoChY85; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaedd529ba1so266582366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739547796; x=1740152596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfchgde7Yv7qF0UntuAhBqD+duvdBiOGtsjacDnwNCs=;
        b=GzoChY852cziJ1hW5epJLrkc3ypDCaL+zdOn9CSLVF5mZ+aJZ5FelXpz+U/MnhTLTF
         Tx7uFTZDjDMv2JHH4kHMOUIIwG5K+StcVjxRC9Bn6Liq8jxkCdsYKBgP0mw4CQqKoy7z
         /oGzl1eZHG7qBJVsOOtosWhGcmqD3yo4NtOqOWyFsDCaMWOAeVYLzM4Gt9Y3w4ln6A90
         hy81cy6xydJRXU66I1P737fAUJfd6T7U1DyzUcZCI8iCie68nrpK92TMAue2h1XuvWMO
         ss3ypZxAE0w190wGKFHBdDWO4WQNsLXPWnrMc4Nq8BJYb29I6Xwl0Ul+wXZ6N+PWBeM7
         fm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547796; x=1740152596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfchgde7Yv7qF0UntuAhBqD+duvdBiOGtsjacDnwNCs=;
        b=JqgbX9OJb9Tb2AeTnr60masQfZHC02eH2nn7iVli5Djsqp2zWNcaj26tZ5Z0rfpvLd
         ENiPBfjGi53pMVQF9nQlBOl8MABYELMHTKVJwQacFtHxhQc66D8wBsnIWef98ibCc4F2
         qjjFuTZXincdOocXn6d0WdAwoQndoDAplkUkrZCHZkduYsGpZixgtOLV/IqcaGYijXiG
         +sXjLkKi5h9xf7IouozNebk7ENvd+Qx5vKrQsDzGUM13JCw0tmJ7EB2o5CONeamzzQxe
         7Iq8thNqXNSS9Um6q40JcVVqomNncwFu1LMKmINZOAoWY7jKoQljLeqhrhi+XbTmqZ81
         MX5A==
X-Forwarded-Encrypted: i=1; AJvYcCV2pz0f5FYIV93wamtlkjqlOhUOMXokt19KgfvUGpHmqWo3p3KtYcttzDunFCphUteq/se/R5lXYfE6LW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoVQnMKifLH+RCMYIc/rkpE+2fLc20tbIhVWIQZurcDcTnDLy
	91mA6RMhKI09XAYJPgN0xr2dU/dKeis3ELv1yb7NyrsPLsWlgHXwZ0QzMIfRdzg=
X-Gm-Gg: ASbGncsE3UAp1yVC1IL663N0la341Q8bumk3FhbNZ5xiHKOIvXHVPFQpSdzy5aYWn0v
	bcKYL2vNuCTur9z0KpwA5FJN1QOPuUAIRiz/q3hujK5tsmUczC9SQzlR+A4oI9q8qox1VlMOHB8
	81UF3pqx4LLadi54ZFXdaSeSZlmUfd78WRvIadUnuTvuK3o3rzHeQC/L7kEvI9vffM42BIh6ugX
	fKvEfRheNkzAyHZnu6Q+5D83otl0l/wwkOe086K6RUx0XffSjGoE1isCqArRO77VULUNEimwyvJ
	5HAbEVTeuFxp87NDNSO26JPZ5bxF
X-Google-Smtp-Source: AGHT+IEljRPkHUwrGSBWwsbIq5yiqXebPZljtjhoLwsqrpKYJJh82UYEhWEqnhbpnAgox5pTITjMog==
X-Received: by 2002:a05:6402:278e:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5dec9faaeb3mr18928193a12.30.1739547796513;
        Fri, 14 Feb 2025 07:43:16 -0800 (PST)
Received: from localhost (109-81-86-120.rct.o2.cz. [109.81.86.120])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1d360esm3170687a12.43.2025.02.14.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:43:16 -0800 (PST)
Date: Fri, 14 Feb 2025 16:43:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z69kkwVJuRIWjJ8K@tiehlicka>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org>
 <Z60KQCuPCueqRwzc@tiehlicka>
 <Z60S4NMUzzKbW5HY@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z60S4NMUzzKbW5HY@slm.duckdns.org>

On Wed 12-02-25 11:30:08, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 12, 2025 at 09:53:20PM +0100, Michal Hocko wrote:
> ...
> > > Hmm... you'd a better judge on whether that'd be okay or not but it does
> > > bother me that we might be increasing the chance of allocation failures for
> > > GFP_KERNEL users at least under memory pressure.
> > 
> > Nope, this will not change the allocation failure mode. Reclaim
> > constrains do not change the failure mode they just change how much the
> > allocation might struggle to reclaim to succeed. 
> >
> > My undocumented assumption (another dept on my end) is that pcp
> > allocations are no hot paths. So the worst case is that GFP_KERNEL
> > pcp_allocation could have been satisfied _easier_ (i.e. faster) because
> > it could have reclaimed fs/io caches and now it needs to rely on kswapd
> > to do that on memory tight situations. On the other hand we have a
> > situation when NOIO/FS allocations fail prematurely so there is
> > certainly some pros and cons.
> 
> I'm having a hard time following. Are you saying that it won't increase the
> likelihood of allocation failures even under memory pressure but that it
> might just make allocations take longer to succeed?

yes, this is like any other NOFS/NOIO allocation non-costly
(<=PAGE_ALLOC_COSTLY_ORDER) which effectively never fail.

-- 
Michal Hocko
SUSE Labs

