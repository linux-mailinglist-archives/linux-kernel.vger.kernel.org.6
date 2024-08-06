Return-Path: <linux-kernel+bounces-276659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2B9496A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F701F2876E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5159164;
	Tue,  6 Aug 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BChA6+7H"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D4558BC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965099; cv=none; b=LjKbYivi+6OtfbwWWXQvzjFGj3q0sp5+1oMbTqSQLt/UNh+GptKyv4tA/JlbtTbgjUcC4tiSUqpKEnr5IuskbheBuxXtkAq44wKp0Kf8XDjg0+ku7L38d8dk9RINEh9ZmxkyC2CgzK3JUu2Uxx0+4Wi7Fd17z3aAHZi6CkJwu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965099; c=relaxed/simple;
	bh=MqaKHZxPTEOOQL0dPc8HBy57ffLggZgGByL+56jCEA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGQ3YKMbKR6jzkKYIWaeuIQ3KpPmv9b3z0t4lA5hiQ+0kPPHm15M486K0nBnCH88CuqMYKA2Pjm4uH5AKD72lifTmYuWT1qjJ0R73NbdG1vhD2dJrZqYLHJ1Db5XNxNBc64lJbLcu4uHwE5Ld2BtivGgKaf75FBYKSPLVfg951U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BChA6+7H; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b79fc76d03so5233076d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722965096; x=1723569896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7HE5qomFnShgNw+dAFpKQn8211Vw3rMqkRCxPcaqwk=;
        b=BChA6+7H/DuZuuDVTwc+kJUGl1JRoCiifBWKlPvb1riMENYJzszeIpxuIsQbSP0+NE
         fBPt2Wv4qvhC3hd4HMT1sbHXF+lV1eSgk/S3YWaVZbx3Kz52S552eGV2lrzXdvzpqe25
         N2dtGTP2NxAQAfLzt+sngLqrmUUhZLOUNvruIytZDoKJLnlEhJuOdtLHP9udVZhhobmk
         4gsORT73GIjgFQgjITxIzWHsj4FqgfA1kk4bwzK0w/HbTlAVGJmN5r9AsqcgZ+8xOtW0
         rkVo9OLabzEE1Jw3cQKEyh8OIuIA03szr+WDoBPvk6iZPOAaOu/PscuJ94rqC4PQzvBr
         8THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965096; x=1723569896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7HE5qomFnShgNw+dAFpKQn8211Vw3rMqkRCxPcaqwk=;
        b=Qm8NqjMNfSIHEu4AxkGWlyy2QIFbw8BkbDoPcee4aId5xqXF10c5CDCBYtGVAsubDg
         GSZnORKTzTmM1Iz5jz84lmmLJfos0RVVc7PgtePcnq6kL6e0ZvqwjxU+HJC+EzpQ5eVJ
         aqwDdeilrsbKr9ojP8ol3PQ4yznN2BWosho1YEJB2GlWoejCbkkw7mB0tkfii1UYZWaD
         CNSMPQ5qpIceSSGUqgpfY4VH/jrdY2NVLfhb+3itLOW1N7jRdARo5Qn4ad20tMKcPOdE
         YEmQnlAEsp1tucBDPOWCYT+j/CaYF3Ff5zk/sT+Z90xUCpQXvgsAxxnaLe06qQ61rLsN
         ntVA==
X-Forwarded-Encrypted: i=1; AJvYcCWgFgiC5jARNbF5KOyFFP8ubK55FdKY267GmLxJjGdFcs/M6V42WQCR9uGcolQlxcnCpYtKf4EgECEEng6Bi851iTCK5fdETAmwwMnE
X-Gm-Message-State: AOJu0Yyb0Qh4Ro8CkTTOVeyXU6uAH/6dif8EIj0PB+a237XH+y0AiiPi
	NL6mCPAkDEyKom/8PUHmbwPY918cb3jreXOCZmevzXeLUCugXUqGy6EBnu0ODiU=
X-Google-Smtp-Source: AGHT+IFa9dVhWCrdPdbUkpdGZrho6h2SYLIO4aEGRVqFcYo1XlMAaNoBZNabBpbHu2isVnX5Mnu2Pw==
X-Received: by 2002:a05:6214:3a08:b0:6b7:9bdd:c5ac with SMTP id 6a1803df08f44-6bb9845d291mr182312036d6.54.1722965095947;
        Tue, 06 Aug 2024 10:24:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c86772bsm48644876d6.124.2024.08.06.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:24:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNvb-00FYkR-1o;
	Tue, 06 Aug 2024 14:24:55 -0300
Date: Tue, 6 Aug 2024 14:24:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>,
	Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 04/11] mm: Add missing mmu_notifier_clear_young for
 !MMU_NOTIFIER
Message-ID: <20240806172455.GR676757@ziepe.ca>
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-5-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724011037.3671523-5-jthoughton@google.com>

On Wed, Jul 24, 2024 at 01:10:29AM +0000, James Houghton wrote:
> Remove the now unnecessary ifdef in mm/damon/vaddr.c as well.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/mmu_notifier.h | 7 +++++++
>  mm/damon/vaddr.c             | 2 --
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

