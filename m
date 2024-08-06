Return-Path: <linux-kernel+bounces-276656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0499A94969D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F6BB25B70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7374C62E;
	Tue,  6 Aug 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jia9AX2I"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47E1DDEA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965033; cv=none; b=OPRyOqBow4tmHT3LhyyHzCb0zBDv1SdpIMjTjceWo2RWli2JjtrLxmJURABLn9vV1EH5PjPlQdbnkKEsFskrbZI9eRD2qTehmiF234g9kG4pfIt3vtsgrRxDfy08W3ZPlnvdm4I3hp2hI+sgZUboKQOoK/XsbjXHhJEwv3HNCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965033; c=relaxed/simple;
	bh=WbFlE5+qPAkFqLnreSC1NqqOFCvXcZe2PPM30+LdzcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlclvovBM3beyEkZ6Bnhw2Z6ZYoXzUFk2Ypa8of2PIsqTg8IkTsAiehb5Zb4N8FuXAO5Ci/Qvc/vynTWnTjMuUZbs0pYu6HOIYs0F/iq5fddDIn0SYzcEzA8pd8I04mAiRQTWhDLlH/c95v5ZNG31VedSAmoaDTnF8ZpSwRMOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jia9AX2I; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so4756486d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722965031; x=1723569831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4rmNPnz+kGMra0RQJtqJ1i8be+boDPo204/oBt9Rcs=;
        b=jia9AX2IwxxpNeVnIvgp/19a/HX+RXv3L7cvDxoJF+Fu43uKodSDtVMLcvttrHeoXs
         pbAKye7Di66sH8ESpYcmctnvBXoMBks3gzdIGJDCCRQbMrAbAhFLsbndQX9UZpn9ypvs
         TixyeUbRQ4mWxO+3tqc1z/bgaOZIT3+jhrsYo/5PIS+y+1FMKw6snw3+DUy/2YXLgLr4
         FQNGCQC75wC1zgTzxkp/LFOFRzalJLD0GgzzM9L3dx6e6lcyl/edgplKEN391iQYcSkR
         Ah8UpleU87LZ7JuscB/vaG026fENfZ2t62/sOxK/9AvYrNwyVgkW6bP6Uxoc/HXXih8S
         UnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965031; x=1723569831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4rmNPnz+kGMra0RQJtqJ1i8be+boDPo204/oBt9Rcs=;
        b=wD54emeconAK6v52Uvh1gYTdv4iLFxJIql4BU9gsCUms+FWeiCz5hAPcz2BJ9Lc75x
         r/rTaXL4a/XSMkuvM6Z4oV5TKB37pd55JFFyDt4tTVgT74yZQ8bKLG+xqAVpPbi2QoJI
         sYgyvZKyPkaymFa6vFfvGw3au1Bvkle7B6Vn0eEkaNvUNyHawO72Hb21DAE5qxYrcbHt
         WOcbCZJVg6DDrBM+sSklLkXzvo4H5/oSyvwCviNgdPzQz6XXgXnjADW7xF5N0sYraXce
         D+9AZj2Y+KABoVxbk0tBxKAZ9igkgd1rcva7JwmSCbPaSnnZdk8pESX+QuNBjHJH7RHR
         TTfg==
X-Forwarded-Encrypted: i=1; AJvYcCXDH4lDNqnAT3YCU5stkyp2GKbt3qCdaqzfgKfU2YL1ZcaaQFzI5Wet2/Kud6cng2sjlnz6MVYgLW4EWGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetX8raoF6mXd8sUip4H3K4wbZV+mpKj7urnsOw8yyTW6sapzt
	XSGzll6NUildDzBePJBUM1OovfZmpmz24Pbh49LRzigU0363EiU5YizFvLRSxGM=
X-Google-Smtp-Source: AGHT+IGN/g/G+FXYvmY4HkM76lkSBKmxvlD+n6uvRjDt3aMuV/oycOrSHTiQPvVwSkF6jaF3MwJXew==
X-Received: by 2002:a05:6214:5f03:b0:6b0:7ba0:ef67 with SMTP id 6a1803df08f44-6bb9840713dmr163494426d6.31.1722965030621;
        Tue, 06 Aug 2024 10:23:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79744esm48263166d6.40.2024.08.06.10.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:23:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNuX-00FYRk-Mv;
	Tue, 06 Aug 2024 14:23:49 -0300
Date: Tue, 6 Aug 2024 14:23:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Houghton <jthoughton@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v6 05/11] mm: Add fast_only bool to test_young and
 clear_young MMU notifiers
Message-ID: <20240806172349.GQ676757@ziepe.ca>
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-6-jthoughton@google.com>
 <37ae59f2-777a-4a58-ae58-4a20066364dd@redhat.com>
 <CADrL8HUmQWDc-75p=Z2KZzHkyWCCh8xnX=+ZXm5MZ-drALjKTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HUmQWDc-75p=Z2KZzHkyWCCh8xnX=+ZXm5MZ-drALjKTA@mail.gmail.com>

On Thu, Aug 01, 2024 at 04:13:40PM -0700, James Houghton wrote:
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -106,6 +106,18 @@ struct mmu_notifier_ops {
>          * clear_young is a lightweight version of clear_flush_young. Like the
>          * latter, it is supposed to test-and-clear the young/accessed bitflag
>          * in the secondary pte, but it may omit flushing the secondary tlb.
> +        *
> +        * The fast_only parameter indicates that this call should not block,
> +        * and this function should not cause other MMU notifier calls to
> +        * block. Usually this means that the implementation should be
> +        * lockless.
> +        *
> +        * When called with fast_only, this notifier will be a no-op unless
> +        * has_fast_aging is set on the struct mmu_notifier.

If you add a has_fast_aging I wonder if it is better to introduce new
ops instead? The semantics are a bit easier to explain that way

Jason

