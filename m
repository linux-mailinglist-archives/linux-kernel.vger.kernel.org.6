Return-Path: <linux-kernel+bounces-285150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF99509DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC0C1F23E02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C841A0709;
	Tue, 13 Aug 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oHfAyYsC"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F251A0710
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565318; cv=none; b=CoSUB8ARX6P+GWEbFmSR9JiIfYxau+tiWsKqhzHdUIB2GwWyhffsitR2E8CNqeAhAzM4EdQ59qz4I686B7gGeKJguVN9H0c48iALmEKzY6ACEY0HqQRbPx9xQJwOclXmOipopl5JD30OynR2JvZEbmhSxw80dKEJjM0ClkiCK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565318; c=relaxed/simple;
	bh=Qkun0PY6vrGhrYkv2YE3X7W5jvRFEQBdmsxxg8EsJiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5ZN9J2D8z/n+hcYSwtus5/cQ5nYt6ivysJn/3u8cW7p4S8EkwRnjfuIVWWwfb+qHvxw3ObLVU7nEkfqgzqVYphcGKDy5YkngmjR5DQiDbLJIOb41iEAPg26d8++itHdT4s6Q8yLwa2ruoAiZrvPTGKz1sc7ySwaf+nZ5IdWl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oHfAyYsC; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d024f775so376367685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723565315; x=1724170115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RKo59Js/Zip4btvaonTbXw89McgLAOYjyPl/ZQBcR8=;
        b=oHfAyYsClWuZ8u2ScWXq8+SBE9S1F0j0OxDQkjdqzPAC2NLnh6AnxiP3HVP59iqeQn
         AR/Ou+s/ynNdOgCJ6nWlyqOg5C7SoXt+fPjWlG1ZmMVk4RVGbEAPCUvbSTN++ScL3i+O
         KKyXuGtjP+tIv3uGqur8CEkfjsk7iXwZixHA5RLIPvj8izAckbMkpLAIw9Kcl4R6pR3a
         DLUbh3/lVwa77ynz6WNx0iF04P0V5B+zhfLZ9dpKvHGSWl9jbvKf2j8pPWL+7Xn8281+
         jYxbbSg2PBjn26sr1Yccna0mdyvMygZA7Cp6rfyVQS4blBuSYZEvX+8AHADZwsBFC27V
         td7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565315; x=1724170115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RKo59Js/Zip4btvaonTbXw89McgLAOYjyPl/ZQBcR8=;
        b=cUmyERvYSb+DKQsUs9DJ4MiwQQXGxc64DBLy97P43y2UDN04Iech/pQg4mu/2esWlU
         InEy1yW/cFlg62h5SabA7PSkmyONo34pnovDwXH9BXBiyybsmbQE7apJZTpPuhio5MwK
         9rZObwKSQJFqlg5KTCRzjLWx7mTDCBkVsPbHvLSmDfIWjDCOhJVFpRXl7i02GmZEyv7b
         oZE3kE6f81WXEcbsCJTLQv3Z5ejL5iv+qRaBfOBmzSSEDG8mPuYNnTZEFfPl13B6jiJt
         QcsTi9h8CBkmGn+p6rxTmmY31WD1rSkviMgbKpuS3e8UESLRB0HNZQEAPfTMbAqBbI/g
         9WzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvX908MMlwWIzwpbp0wz0XXKZxdNC5cwozCYGni+RG2KMzuozPgJho9Y4BDBwqsXD2f2kIzsdZvFI97TMoHxuNctLpi2NNtM94qrtx
X-Gm-Message-State: AOJu0YyrzyqKZF4RDITzT+wNXQyoWCFcPfErvTmXn5dvMl8zL2Ok1Puo
	TQrif0b25+baNjspKm19pWnTiMo+W/H50sQ+b397sQ2gcm+jXaPMPjLW1DmB574=
X-Google-Smtp-Source: AGHT+IFwwh2uTmU3fMs1LTMcKllp8DlZibyM6dUroyb0/uLwll1nqejv7yiDVjIHbpYKHyIqqKh3tA==
X-Received: by 2002:a05:620a:3904:b0:79f:4b5:3696 with SMTP id af79cd13be357-7a4ee3ac21dmr9326785a.56.1723565315308;
        Tue, 13 Aug 2024 09:08:35 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e11130sm352658285a.125.2024.08.13.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:08:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdu18-008Iyi-0q;
	Tue, 13 Aug 2024 13:05:02 -0300
Date: Tue, 13 Aug 2024 13:05:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Message-ID: <20240813160502.GH1985367@ziepe.ca>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
 <ZrmuGrDaJTZFrKrc@infradead.org>
 <20240812231249.GG1985367@ziepe.ca>
 <ZrryAFGBCG1cyfOA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrryAFGBCG1cyfOA@infradead.org>

On Mon, Aug 12, 2024 at 10:41:20PM -0700, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 08:12:49PM -0300, Jason Gunthorpe wrote:
> > > This is unfortunately not really minor unless we have a well documented
> > > way to force this :(
> > 
> > It is not that different from blocking driver unbind while FDs are
> > open which a lot of places do in various ways?
> 
> Where do we block driver unbind with an open resource?  

I keep seeing it in different subsystems, safe driver unbind is really
hard. :\ eg I think VFIO has some waits in it

> The whole concept is that open resources will pin the in-memory
> object (and modulo for a modular driver), but never an unbind or
> hardware unplug, of which unbind really just is a simulation.

Yes, ideally, but not every part of the kernel hits that ideal in my
experience. It is alot of work and some places don't have any good
solutions, like here.

Jason

