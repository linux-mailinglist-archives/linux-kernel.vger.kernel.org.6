Return-Path: <linux-kernel+bounces-369707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777859A217D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98B31C21F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E71DD53D;
	Thu, 17 Oct 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lZH67v4L"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEE1D3647
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165988; cv=none; b=CxsQ3RfYXadxFwbT4hqjQ6/mz0wNgsZnxPkGunDkPU7rMuIL6VJ7SRLtwpdzi0dKe0rAUPWjEdqh2LzDWdRbkXGM6vmib93pJV1sWPuSZN8TRfdi0J5XGPM7qE05+P9whthNGyWR56QwPwSJj9uhTw4cwLxcCWXtCn1ABTn0c6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165988; c=relaxed/simple;
	bh=t/4OG1r5b/GHH35K9RyDd/lJoTIvhxz9+I27ObFBdek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5FYcGXEOMAFXlWaBSeXFsq+wtMrGP4fqXnhbY21+bbbl1oEtNVnSDAsLb8NoNswHF5VuZ7g7J3yFOst91VelsV2nh7t/oJQ6QuKINq+8ZGW9Jy3H4KUh7QlZVuLW83919iI/56qDbvu/Cfwf12pC9HfZ2zuMFikvIVRILKloxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lZH67v4L; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b147a2ff04so83272685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729165986; x=1729770786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmBZesZtIEIysD3cyQDt0/aeQz0fuSRlJ48sSX4MZM0=;
        b=lZH67v4LOonyWoeGNmAI2RYB0P5q1+zd6TsyJeDrGfvHrnN0MwlqM39Mi0qWG1QBUo
         NrQCIM+wVAvJoQfPtYUZr03XDpdIS2Jqad3+mFldGgNzYL+aoSys42giGQYfSi2NASBL
         nLXPc5PDMmddSnbR1lXm+W+PZLebZSYOaQWzn/BBl1633iLCwZs9rDdLwluedVO3/Sc9
         l/ZXp6HyVBztCIJKfNsnKQVFgukqLi/R97w60f0pP/lrg7CPCvMq40M6/4LrrHgBAM3+
         LOZmdqQsFvNo1KJwtVinVLqyQqBB6aHbaT3SYEsrmZ8EwTG3DY6RT7iXws/hGMLbQlbW
         TVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729165986; x=1729770786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmBZesZtIEIysD3cyQDt0/aeQz0fuSRlJ48sSX4MZM0=;
        b=KCK02UqXQh8TgRztPxJbIjjTTavzNCZ2qjUv5rZ3bIdJsRaNDrrCynTSyuTyeY6UMs
         pKxAkMAwVX9DUVaJexL501UVI3OStSv2LI6RpWxj2srbAozEAuiAv8vfZjA/b6yNZZrh
         by2cuJeyuuK8C2m/lW0ZcenA5ZPdtetuBUwqIVZDlGVVcBfdpMRXK/SC1IyQh/dQWlHz
         FvoNnDLsrrNgcLiaF6lBzaL8iA4ToVTpvsLhQBD76zRr7ZMAQL5Rh7ZlkGu+ebV3MgIs
         bLUx6p6qMUdDj2CeRDmDzEwJc9Jl+uibkIaP1NQDe4XkgsyJpp7IgxbkeOt18V5ZzPw6
         vlzA==
X-Forwarded-Encrypted: i=1; AJvYcCVa7qPfCr3qsbM1j2UTMHMmjaG3I45Tu/YNl0ALq24Mo1PKAg3CKMRUbm7ghHQXk4wvQ7qQTWd4VibuyxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/ph8Rjq/1UxQceUlE8SEixoA6BI+Oy5OAe0e6RtmVitLRBzs
	Ut1JZmQwU8Y/zKiT+I8qw18EfHdpqAq2HTMG6AAUsTpD/zQejhrR9gDf6hBYmzM=
X-Google-Smtp-Source: AGHT+IE0lhUEHRItAIlBXkzlmf1pFQcVgjaWoPErjcdruR1w2i306r6pb8Z5KQ2AjKUo4kdIciA/gA==
X-Received: by 2002:a05:620a:3712:b0:7a9:a8c5:d4b3 with SMTP id af79cd13be357-7b120fc4b4emr3591459085a.33.1729165985823;
        Thu, 17 Oct 2024 04:53:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136164d89sm291152685a.3.2024.10.17.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:53:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1P3w-003fyz-5b;
	Thu, 17 Oct 2024 08:53:04 -0300
Date: Thu, 17 Oct 2024 08:53:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, bskeggs@nvidia.com,
	Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <20241017115304.GH4020792@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <87frow8wdk.fsf@nvdebian.thelocal>
 <20241016154555.GE4020792@ziepe.ca>
 <878quno4os.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878quno4os.fsf@nvdebian.thelocal>

On Thu, Oct 17, 2024 at 12:58:48PM +1100, Alistair Popple wrote:

> Actually I think the rule should be don't look at the page at
> all. hmm_range_fault() is about mirroring PTEs, no assumption should
> even be made about the existence or otherwise of a struct page.

We are not there yet..
 
> > We don't need to enforce, it we don't know what else the driver will
> > want to use that P2P page for after all. It might stick it in a VMA
> > for some unrelated reason.
> 
> And wouldn't that touch the refcount and therefore be wrong?

I mean the originating driver would do that

Jason

