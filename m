Return-Path: <linux-kernel+bounces-287562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EDC95295D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A39283735
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4617798F;
	Thu, 15 Aug 2024 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VP/cqdyv"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89B176AD7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703384; cv=none; b=CbEkmGXNu6UF1Xk/jYqRilhRc25gt/bl8lzY2/lRQCl6MEKZIKPapLACcZNodL2qXPx5Igh9hhNDa3GLzWroHUWTrHhokcXpCArZeNkp45R5AQIsP/W43JIwIHZr+OTGMmihY/bcXvtheqtxwNmiTjM3iiiArHog+QXnqopStfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703384; c=relaxed/simple;
	bh=GyFKytUfy0+tOp6N/GeQOqt1IV0b8dje4SEn+fVb64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP/URlJU/B3+ENO88yWaoNawrOxE75HXdPXQTVzpU2gwMeAdf6DD7Th+T9pKxjCTU8fob5tT0Fgmf2mMSG+RnBCXmuVKH4ZQ1UQX/pliVP6RVQII+AnuXExK65z5zAapYhUp+mqaC3g8kRn6uRSKEbJzfeczRXTVjTFcb/wZJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VP/cqdyv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42808071810so3684445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723703379; x=1724308179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rS3zSikqj+bYXDsc+ql3OeC2bdnsOqnPpeoipHUxNoM=;
        b=VP/cqdyvtQ1VlGNzFRElbgwMyZXmm7/zf9yDb+btseb/mttE68paZT0sCFg6jf1DyL
         S9FKvDlUC62BkpVYwaWhxto2koBtNiadeAYsWJMh1g4IafvFpqbTIqb4m+KqYTcm9G0k
         N+oYPpaV7k9lsZP5UqD59HO6k64fUeidWVz5mWtw1R2D0/Y8X9I5CNe4PBwA95h1BUZh
         UbE/cOCTKN+EowCymwURU7oya6PHUx9g8i+TkEji6bwsiXgUIJK5ZqIrZ36PrJOBbMQM
         vrNzwGM/4sBfTkfD2pCAtie5HqPlhDsAa1wMmShvvXfn1cR4po9eU6VTa2Glu2vl2jpa
         MQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723703379; x=1724308179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS3zSikqj+bYXDsc+ql3OeC2bdnsOqnPpeoipHUxNoM=;
        b=YJnG5RP72/jwQ0OYoylpRVlu8jrtxN/hyd6kE+Qh7ymNHAYMMv7muPLBPnJXPjXOsm
         RH/nmjQscVkI9rWdvPkmm75ato78q1N1qJ+PFonN0fX9WLn7m5iUke68L9qpMEW9eRe5
         o7Kuq5ufvNxuE+68HB+mRUveS+kv7d2A4/DqtN9bMDAeIwOLIq40nMMZNNtH1Wmey6Ss
         slHtx6034HawbCET65/8YFrAgOW1IsoTFfuV1V4arEbjuANb+AKgNOM3a2hs5i0yaItW
         /cRFGq7ihcFnXh+zUqjQtzRB7cMu5K2ivyciW80x6ySL7cnBaQYKeusmYf03jXZvxYTM
         tluQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAF0tEpoS1e1Zs793O09xMINfL2QLfjk8bky9rOp5JnjbajDx2nkXnFvKVCaUP9c8byF4AsN8BfRU75ol5JcbCyTGLE9zrs1ncaBew
X-Gm-Message-State: AOJu0Ywm9jFMErgcNRwP9dw6uyJhkoiMTrQWclB8ylMuFAD+EyChPVzc
	/v0tnqio41ojtuh/GMhqEQj7bTaBXr2uKJa2D6HtrKYB8Q5tOeXIsm3N6uQY9wc=
X-Google-Smtp-Source: AGHT+IEwtK0IByHoEbcy8sKW7Ngi98OsSs4EFQDOyovER/7+6bNzNP8sXQM+liQExRPXVNMEzEFgUw==
X-Received: by 2002:adf:f5d1:0:b0:371:8d9d:d824 with SMTP id ffacd0b85a97d-3718d9dd877mr86901f8f.0.1723703379409;
        Wed, 14 Aug 2024 23:29:39 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac2d1sm702780f8f.109.2024.08.14.23.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 23:29:39 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:29:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/4] memcg: initiate deprecation of v1 features
Message-ID: <Zr2gUUo9xlaywq7P@tiehlicka>
References: <20240814220021.3208384-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814220021.3208384-1-shakeel.butt@linux.dev>

On Wed 14-08-24 15:00:17, Shakeel Butt wrote:
> Let start the deprecation process of the memcg v1 features which we
> discussed during LSFMMBPF 2024 [1]. For now add the warnings to collect
> the information on how the current users are using these features. Next
> we will work on providing better alternatives in v2 (if needed) and
> fully deprecate these features.
> 
> Link: https://lwn.net/Articles/974575 [1]

Acked-by: Michal Hocko <mhocko@suse.com>

I will add these to our SLES kernels to catch our distribution users.

Thanks!

> 
> Shakeel Butt (4):
>   memcg: initiate deprecation of v1 tcp accounting
>   memcg: initiate deprecation of v1 soft limit
>   memcg: initiate deprecation of oom_control
>   memcg: initiate deprecation of pressure_level
> 
> Changes since v1:
> - Fix build (T.J. Mercier)
> - Fix documentation
> 
>  .../admin-guide/cgroup-v1/memory.rst          | 32 +++++++++++++++----
>  mm/memcontrol-v1.c                            | 16 ++++++++++
>  2 files changed, 42 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

