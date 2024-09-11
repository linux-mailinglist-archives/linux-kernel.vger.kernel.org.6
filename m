Return-Path: <linux-kernel+bounces-325624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C8975C34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ADD281EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF71531E8;
	Wed, 11 Sep 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oGUAiKjq"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CB143C5A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088913; cv=none; b=jMq3QK3kheOmzEuDXfzYju6s0Hq875mtAwU47BGGRggYpKaL4FWAy8OwWW65H8Mne+/E3FUgA3TOhFxuCGNP5xg9OqL1OcIaertOuWzLm97F/aHe57YkO7wH2jL4HTOScKEOvxCnkx71vRvaJW9KedF66xIVQUa8/tOtEoW6tMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088913; c=relaxed/simple;
	bh=W4HvhM49Z3WHkmOQeWgblqJfbVbjDnc5OxJk1ek1N8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFvGaDU9vj3h+gqWFconLxWXEe2W9jSNBynPPjUvLzw37hTdqN5W9nyn2baiXk3e8cHkVqp3DDFTLMHmlcKY73YqKLAhB1IgAag+Qemrh4yN4QndxAQE/oo7NyhfUTIgOwIK2apH/BHcxOk05eOmITSdkhkNBZ1yJMZExxuHtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=oGUAiKjq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c524b4a3aeso1673486d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1726088909; x=1726693709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1q9C8g+7qPjQQ1WU75uSsRI/cAkAobRA9aew6drCVM=;
        b=oGUAiKjqHGB3CGv8lc94GlGzzJl/DOqGpC8dt2P+Vxl3Q0UZEVYzpP6HSYCmBC/TCr
         XvROiTnC6a3DpnU8D/nfKeBCTIWqZ43y+jYVJnitPcey/PBXRR4v8QC0XC0Syk5jdl52
         /QvsoeHNLtDEcCLuyI/BnrSE7PnoWnM7Pdj0P9Jn4Fx3vIKVk7Y/FSsfBq6fIglsynWs
         p+Ke+nKuxoEJ01R9Re/eWTWsHBwiGHOGKCTmfKNvio550PVefWIwHv6KlICd61wwHNqJ
         q1XgiDOzsY4OMY7SBk37fXnUDHD4waCONRPC/I2iM62j3ORdIvpPaisteUuohlkgyDUW
         l01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726088909; x=1726693709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1q9C8g+7qPjQQ1WU75uSsRI/cAkAobRA9aew6drCVM=;
        b=lPjvMYE9BnCis7kpFr7FfbACUoZrYHxQ1XdP7OEWd2dUOsWLxyAOMlK0GwmdIRKD10
         X42MEgyAXWyY35IHHxSgXQ00JLk9/m3JZZiT3G4zLgy4SCM7O0z99cGMAkBvgDh2BwJS
         eeyoI/ThJayXIzw4LZVbgEQzPQsIyH4pk33ptLCtxIQrq20NGySfPrW+34WfBLH5KnDk
         0JHfu/WlDgRdBWL6RhScnlarRY3g5kpcBZwL/NZBkmnpiVQxAQAnBHr8zqdYiMRBG86r
         f5jBT6cjsWX9aJ/gngokTQa5beTZwO29fZ8+BS6pTGciwYK+Pz5uklokvDgjj+Gx7sE5
         lY9A==
X-Forwarded-Encrypted: i=1; AJvYcCU6AVUP7h9/7ijS1KON5eHeC18iltgCTBE/XIayZuXVKSOom0RjaaUMgSrKsBkJ8MrmwbsD/NhMlXF0jCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5j8+dYLw70exw6fl7SLrJnaPhe87+V/tL9ul6x3b8gYSgeQU
	t70j7y88+1SGOl+yfRYI0gpHn9S8TfgNkWanJZkRepb+Z1h+3vqjOAtfii1CXMA=
X-Google-Smtp-Source: AGHT+IFm928y7rO/WdV4f77rZlTCrW5iXX2snnA//hZsOeffSuUjI+t6T/ZJjtq7H1MGKY7sJbbXHA==
X-Received: by 2002:a05:6214:320f:b0:6bf:7bcd:78e3 with SMTP id 6a1803df08f44-6c573530335mr11513076d6.29.1726088909368;
        Wed, 11 Sep 2024 14:08:29 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432954fsm45931186d6.25.2024.09.11.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 14:08:28 -0700 (PDT)
Date: Wed, 11 Sep 2024 17:08:24 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Omar Sandoval <osandov@osandov.com>, Chris Mason <clm@fb.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: optimize truncation of shadow entries
Message-ID: <20240911210824.GA117602@cmpxchg.org>
References: <20240911173801.4025422-1-shakeel.butt@linux.dev>
 <20240911173801.4025422-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911173801.4025422-2-shakeel.butt@linux.dev>

On Wed, Sep 11, 2024 at 10:38:00AM -0700, Shakeel Butt wrote:
> The kernel truncates the page cache in batches of PAGEVEC_SIZE. For each
> batch, it traverses the page cache tree and collects the entries (folio
> and shadow entries) in the struct folio_batch. For the shadow entries
> present in the folio_batch, it has to traverse the page cache tree for
> each individual entry to remove them. This patch optimize this by
> removing them in a single tree traversal.
> 
> On large machines in our production which run workloads manipulating
> large amount of data, we have observed that a large amount of CPUs are
> spent on truncation of very large files (100s of GiBs file sizes). More
> specifically most of time was spent on shadow entries cleanup, so
> optimizing the shadow entries cleanup, even a little bit, has good
> impact.
> 
> To evaluate the changes, we created 200GiB file on a fuse fs and in a
> memcg. We created the shadow entries by triggering reclaim through
> memory.reclaim in that specific memcg and measure the simple truncation
> operation.
> 
>  # time truncate -s 0 file
> 
>               time (sec)
> Without       5.164 +- 0.059
> With-patch    4.21  +- 0.066 (18.47% decrease)
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Looks good to me. One thing that's a bit subtle is that the tree walk
assumes indices[] are ordered, such that indices[0] and indices[nr-1]
reliably denote the range of interest. AFAICS that's the case for the
current callers but if not that could be a painful bug to hunt down.

Assessing lowest and highest index in that first batch iteration seems
a bit overkill though. Maybe just a comment stating the requirement?

Otherwise,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

