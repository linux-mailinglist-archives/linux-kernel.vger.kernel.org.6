Return-Path: <linux-kernel+bounces-275454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D369485EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86C11F2344E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F216EBF4;
	Mon,  5 Aug 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MUjxSBCC"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032A16CD0E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900552; cv=none; b=hNsK2bxf+tcLM4G5IOJYBXAABkRXaeKY8wssmcYD78qITNUoYz3l+9rFW0H31/AKqVYDWf1HPSY8xfWnf28EP2ptOfOOizUQs7RZlwxyMjunhgnp1FuPNalKmAvzXk7/QQKV7WsNiuKDfqnRNwp90Y/iFPY1z6SCbAXxz7+dQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900552; c=relaxed/simple;
	bh=Ud+vs2yn6sXlpWsYL0inF2KS4QwbN9S8Dxwgfx2J134=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msk9apIPp9QNpM7MFhwnR9NVEH4+jTW2otVOtcGkz9PFeo2bJQt1Yhm0uD5e8unicOQR5Le+BQD4pIE9IqSdu7um68DrjxbJIa5KM1S/2UHyhNyXqqHpJbOpF3mt3nnfuHxJ88DqmS9CXeKxw/5RkCG/LIaZ0L/prU3JcpzQerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MUjxSBCC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7a0ef0dfcso483926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722900549; x=1723505349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud+vs2yn6sXlpWsYL0inF2KS4QwbN9S8Dxwgfx2J134=;
        b=MUjxSBCCZ4a/cVUr5whOihgnOhTIYXF0aEXKzqmkYPINjr2E2onX+wwDkAu+tt2jae
         vSjt3pDf+aBqVfC6dxFEHZ4svDH4LrmEjCYAZQmduXCp8vXix+jxlUBHhKYHgGaW1/yW
         l1qN0qq+usNSXvQSyq+Tp+0B7x0NEuXEqscpTUhcgY78HAWu031Us+eLGQZeS/W1bgpN
         XrGWKsKl/uBIBeA52qi4Oe88x5h/I0Kru6lucgexVGr11pbUeyTKRCcPPxk3rluDsfcY
         cnpLlQy/ciP3+sS+qh9bugNx+UutmpyKVOmDR10/tFV4LnHprPI+JcbOi1lfrY9xRfAU
         pKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722900549; x=1723505349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud+vs2yn6sXlpWsYL0inF2KS4QwbN9S8Dxwgfx2J134=;
        b=DFvlflUs1TuGzdNcetLZf/2pRyFrN7dO1qsSme8eyvGcut5wLj9BmtJd/D9CnzJPKv
         YkFQ6LiWuFysglII8trK8HqxjZC27CZvwHnmJeznqeJeQbNFYF0ZY7cXa0+hVA6/MKou
         i6P65KO6Q7TL4H4EMN+6/jla3dFwHOVS+zr7lAW3D4f3/kA6Mzrh7vaUkcNxiTtrxU5V
         O6AM2kdlHFPGVtBrCzz/a1dM5Rz1TTbmQtRVD2hIeCZuVV45CfPkmNYD+ENFXXeTUkcs
         FjAFlu085PNRLHcGuzTROtWAZVVnOJBV2Ses1hiRKu8PXy8OWsxwN/8bMg9tmXQfOqB5
         Y2IA==
X-Forwarded-Encrypted: i=1; AJvYcCXHk4T/h9M3zX072+KjPYvYqPhtYyEGg8c0VeeimCFwi5MtHiUy7vMEHIcmaopWU3RLZBT7RkXhUoAs8RYrTHS3HAv+sW6bCB/1QZNB
X-Gm-Message-State: AOJu0YxFAYWhlTvFeSU5KFlxjvdXzFJrY2CCXno6TL8pvg6JzAvqJGcp
	mm9ar048IAT2SthzHP/ZKueXIzKKnla+47mWLxMKpgKKWPS6EDKGEmh7Msq9Two=
X-Google-Smtp-Source: AGHT+IEUqd6hIg9HDyEzlke8VzqWmU4TFD6nLDglYJ354O5s+08g370xcdmQz9qNHG00XmeufXnXGg==
X-Received: by 2002:a0c:f209:0:b0:6bb:b478:52fd with SMTP id 6a1803df08f44-6bbb4785327mr1712666d6.31.1722900549464;
        Mon, 05 Aug 2024 16:29:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83cc30sm39451646d6.101.2024.08.05.16.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:29:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sb78W-00BvtY-0n;
	Mon, 05 Aug 2024 20:29:08 -0300
Date: Mon, 5 Aug 2024 20:29:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jan Kara <jack@suse.cz>
Cc: James Gowans <jgowans@amazon.com>, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paul Durrant <pdurrant@amazon.co.uk>,
	Nicolas Saenz Julienne <nsaenz@amazon.es>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory
 filesystem
Message-ID: <20240805232908.GD676757@ziepe.ca>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805200151.oja474ju4i32y5bj@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805200151.oja474ju4i32y5bj@quack3>

On Mon, Aug 05, 2024 at 10:01:51PM +0200, Jan Kara wrote:

> > 4. Device assignment: being able to use guestmemfs memory for
> > VFIO/iommufd mappings, and allow those mappings to survive and continue
> > to be used across kexec.

That's a fun one. Proposals for that will be very interesting!

> To me the basic functionality resembles a lot hugetlbfs. Now I know very
> little details about hugetlbfs so I've added relevant folks to CC. Have you
> considered to extend hugetlbfs with the functionality you need (such as
> preservation across kexec) instead of implementing completely new filesystem?

In mm circles we've broadly been talking about splitting the "memory
provider" part out of hugetlbfs into its own layer. This would include
the carving out of kernel memory at boot and organizing it by page
size to allow huge ptes.

It would make alot of sense to have only one carve out mechanism, and
several consumers - hugetlbfs, the new private guestmemfd, this thing,
for example.

Jason

