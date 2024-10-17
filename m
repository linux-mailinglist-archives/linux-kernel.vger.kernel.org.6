Return-Path: <linux-kernel+bounces-369899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B1C9A2433
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945AF1F224E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B11DE3A6;
	Thu, 17 Oct 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kjYGn2Ax"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBA1DD548
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172807; cv=none; b=TVu9CSCeN4YaG7kVGkonq58DWK6VjYsRtAf8bA5bT7ME1KNuMQjYlBlAqpUU7WN8UR1fGukko1llC3vs8SLteZ2YuPZ4ftvVG2DBisiNWMlqK07mbAOvhftfKPXr7fBjRDCiAEb6yclXUSkLdQHk6hY3kBwZxR6NKbRY2z/aqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172807; c=relaxed/simple;
	bh=GavC1bCf/RUg1YwBTQ9ARQYBuRar7SYI7Mn3S3262Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO4gw0eJtUNX7U7Hhv3y13TlMfkqBONR01vb8qbtJhi3qI5iBOZ2xkUheosWpRaDnxA/h5VLuAgHkV6+BsGsQWlkIvrlyx29a5GQ/vcrsB1WjhFrMmng5r2Db/jTRWcI/6blolhHKwE5mJwSuuP7RmIIw629QLLFyPCfZHENgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kjYGn2Ax; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e5a5a59094so8355027b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729172805; x=1729777605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0nQN0NCObfK5Vn1zgRw1TpjVIw9ZxydvJ5Q22r05Dw=;
        b=kjYGn2AxsIbtBEhJQaEWVNW+QGvPe00E0SyvGpTtjd/WeJknr+jaInkwRBT1aZBgk3
         YEqOd3lW2uP6+xiqXvxLV705NNEOyl1r5T2awTjYghtGvb2z3BjYnsUSmMFwdbzllZ2p
         fS5ymmIVf1UkBFoPTlkFfbeYL7xMieKJB7lbPKfbB6Q4/JAaGkWfoQHITOqeKFJ7ZW5c
         PxWpL3McQDeHo5wzX/8ANCR3uhLb7a0W47QrOau5Tyj37pkh7cQm94ogzcpuwPhNhXRa
         HSBDMpDof6vCymN9h/aghUdVGhcF9K6h2VeoLp9Oxvb309LabGRw7D6NKYoxSgbziGCw
         b+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172805; x=1729777605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0nQN0NCObfK5Vn1zgRw1TpjVIw9ZxydvJ5Q22r05Dw=;
        b=DDoc2ZKCQeBS4+vh/yPQC64Y4fhXT3wR8zN4YwyYMYaWRZe7bShDw6u7LITyrbwx1M
         BjlBRgp3Hat3Y5gmu+w7prh/HglJX3hbJ0Bs62YnWVn4BlBb5H6nDnafiBurjHV4UVOI
         WY5v/mleaUVCMni7qNZkQIJQiJsok/+PHMsgviKfEXdwvsReZor0scAc4Ap/M4OWiulu
         iV/zT/qvv09txCXWC6JNmWGL91V0KOfOL/uMxXa+MMa7EAe9jBeQ9yUNMMvAnGi2mfxs
         zN8A20Zez2u+nU0Lrktx6uZilz9fkezLT4EgNwybwpovHel2kyRoQNvCE/W7KrmV5FaL
         LWWA==
X-Forwarded-Encrypted: i=1; AJvYcCVQQj+0ZoFXhBKGetmkm+r6KRGs2T1W8UXe5PZQNGfJ2e1azsRv3+u8ZqlmlxziiWjG4h68m3ryW5jEi44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/rLWtjaZ9DkUbmMjMu4/TFOocgpHRZQ/zqRxJAlIJsllBNOD
	5/FNwhhCiaG8uvM5eEHfc1Zow31ExquS14QG43xfSvaiD0OwHYDeyAjCghQp2IL5oDaWW2s+4th
	H
X-Google-Smtp-Source: AGHT+IGpgOmzimpqGZo+yKVQ9O8UZLb6Hva6cSsO+ZYcAVIT1sMFZwMiYnH2dMe9t9IABxyKBdXUOw==
X-Received: by 2002:a05:690c:3586:b0:6e3:3521:88ff with SMTP id 00721157ae682-6e3641411f4mr162528807b3.18.1729172805398;
        Thu, 17 Oct 2024 06:46:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229245f1sm28440036d6.57.2024.10.17.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:46:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1Qpw-00404r-FW;
	Thu, 17 Oct 2024 10:46:44 -0300
Date: Thu, 17 Oct 2024 10:46:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, apopple@nvidia.com,
	bskeggs@nvidia.com, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <20241017134644.GA948948@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
 <20241017130539.GA897978@ziepe.ca>
 <ZxENV_EppCYIXfOW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxENV_EppCYIXfOW@infradead.org>

On Thu, Oct 17, 2024 at 06:12:55AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 10:05:39AM -0300, Jason Gunthorpe wrote:
> > Broadly I think whatever flow NVMe uses for P2P will apply to ODP as
> > well.
> 
> ODP is a lot simpler than NVMe for P2P actually :(

What is your thinking there? I'm looking at the latest patches and I
would expect dma_iova_init() to accept a phys so it can call
pci_p2pdma_map_type() once for the whole transaction. It is a slow
operation.

Based on the result of pci_p2pdma_map_type() it would have to take one
of three paths: direct, iommu, or acs/switch.

It feels like dma_map_page() should become a new function that takes
in the state and then it can do direct or acs based on the type held
in the state.

ODP would have to refresh the state for each page, but could follow
the same code structure.

Jason

