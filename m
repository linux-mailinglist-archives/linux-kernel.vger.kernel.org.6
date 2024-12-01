Return-Path: <linux-kernel+bounces-426705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA989DF6D8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36318281752
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6944B1D86CE;
	Sun,  1 Dec 2024 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxYV8dg3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9341D417B
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075746; cv=none; b=WXUcnsKFca57pG0EXMRdvCI67avJ/+3xuEK1qRCX+6hX+WQHvin5c6qBLUeyGG9G6L4h4pqDQm+YhVHdQ8SfQ0hbsMeBzDibO7ZOr8JrPX3SKHMWdCeq4IbtfOafRQpCdxnmVx9jD06m6kzIg05hH1nk6iUGyT37MWS2E0OyTZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075746; c=relaxed/simple;
	bh=pDh3sxIXjSiOmi/2YmBJfp6Dv4l2bH2RMTYOFvdjOCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkJ7s1ZXE7yPauXfpy73n9qAgaCyqlRAzscjlSgHD67ujDMobjvm7lX2byAP18stEOlwXy15ZPhvYdyWIRoKgMgz7gwXvU2wIUynl+WIP+Ak+etC+BY38palFgNWhqZSMQPVcG5fsCsKpsTwE0KYKp6XShmJKrNzovSdYoPiduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxYV8dg3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733075743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj/FRfspWv/DskWdu4ezgBxsZYrptmYDnGDs7cuKhHc=;
	b=XxYV8dg3yjgCkLiuu/0iTorsX3EAXWBI6ufO6OEhhqnH8bWsZ1N4nIF2/B8XJ02lkfdjoC
	NVbbK8mKV24xaCqpvfwCawdC9KuTjFvZNFhXXeuq+KAy2D1DcRDOv7ipFIkQrpSRocE/Ag
	1LyTadmgxFoF0SgdG003DV7jCyFbgKY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-foRtsDzlP9GhigplW1msfw-1; Sun, 01 Dec 2024 12:55:42 -0500
X-MC-Unique: foRtsDzlP9GhigplW1msfw-1
X-Mimecast-MFC-AGG-ID: foRtsDzlP9GhigplW1msfw
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841a3f2aebfso275478739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075742; x=1733680542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj/FRfspWv/DskWdu4ezgBxsZYrptmYDnGDs7cuKhHc=;
        b=mzj6IW6gpL3zYUlXvLD7QSvKjS3E3IPrinws26AOGg8WPJCuTkNtwvC9u7GajIo6W5
         6vWEKhwLcje6PxdNEJ+JMV6h2XrRVHxXHYvof60jowCyWg9MCgTni4mMucU+HIujwze7
         QHjx+mZ9QHtlR6nhTPVyWQhNycrfBDqtX8+HkrDaZqpV+g40Z9AyT/EMJZDLJFZsVujN
         GpdgrfeROLmzzHglJMm7e/0xLIYOghShK0sTUpaQj5mIAZIvi0BF3s+DswrLqLpV/DHS
         W9bYymPzLw0olAD/oOMdcUig2xSDkmGqHbI9YH7P5+WfE8vWm4U5jzBzqGSf0YGSbDJF
         YjzA==
X-Forwarded-Encrypted: i=1; AJvYcCX23WeexmYOdZQLut2L305KVprdtXrYw6TLTH3ZlE5+VcoKHtqoisQvFUO12HwUZCgT96uArTOVEQ8xLd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpBAS9R1cTzMc53W8cgFr04RTcOnWdhKVxY26GsvfX02wSoVf
	EKBZkwSj6duJl2SzvjuEQdl37Sif5Q/RZ1M8wYzR3ALwe96Z+3oEJLwc/X6NCzT/oJK4RtOHpPr
	+14kJ2h6fOtbmkPxO18SGbfnV7CG0CoPxOgWPP5RVGjkVazFX2Ub3ZLtNLZemeA==
X-Gm-Gg: ASbGncsWIhVOjM0HMStjSJ3t31xkLxoO1tIkGDskwmJyY3P8zxDdv394d8sjtgmH2bW
	GBl7j1yclVuvjN84OM5rSPcJZNKJa56TAxSrsT1nhOFbmlgeXRf1doatjdKwFZeMdf2NzllOkso
	q05m/evYUilkz+LXJ4XI3dPzBadIPmf31VK5aCoyseTZYI48mAOExSsmIeM2U0lDudQJE+ijaZI
	b/BCIX9g9nmh6WEGQyOv1E6IvglugrfoqBIOJBySq7/hZKaFHer3GryOjsc5fNprXNGy0VWWlFs
	88WelAUR5PI=
X-Received: by 2002:a05:6602:1485:b0:83a:bd82:78e with SMTP id ca18e2360f4ac-843ed0d5db1mr1823656939f.13.1733075741850;
        Sun, 01 Dec 2024 09:55:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/C29sEt8k4hWcQ9UZmsHjRNvozdtx0q9RcLM88/BVqTagSmnFuAl4NtUM6pK3J/5zeSzg2A==
X-Received: by 2002:a05:6602:1485:b0:83a:bd82:78e with SMTP id ca18e2360f4ac-843ed0d5db1mr1823651239f.13.1733075741502;
        Sun, 01 Dec 2024 09:55:41 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84405faf14fsm171115139f.42.2024.12.01.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:55:40 -0800 (PST)
Date: Sun, 1 Dec 2024 12:55:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	mike.kravetz@oracle.com, erdemaktas@google.com,
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com,
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org,
	bfoster@redhat.com, kent.overstreet@linux.dev, pvorel@suse.cz,
	rppt@kernel.org, richard.weiyang@gmail.com, anup@brainfault.org,
	haibo1.xu@intel.com, ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 15/39] KVM: guest_memfd: hugetlb: allocate and
 truncate from hugetlb
Message-ID: <Z0yjGA25b8TfLMnd@x1n>
References: <cover.1726009989.git.ackerleytng@google.com>
 <768488c67540aa18c200d7ee16e75a3a087022d4.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <768488c67540aa18c200d7ee16e75a3a087022d4.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:46PM +0000, Ackerley Tng wrote:
> +static struct folio *kvm_gmem_hugetlb_alloc_folio(struct hstate *h,
> +						  struct hugepage_subpool *spool)
> +{
> +	bool memcg_charge_was_prepared;
> +	struct mem_cgroup *memcg;
> +	struct mempolicy *mpol;
> +	nodemask_t *nodemask;
> +	struct folio *folio;
> +	gfp_t gfp_mask;
> +	int ret;
> +	int nid;
> +
> +	gfp_mask = htlb_alloc_mask(h);
> +
> +	memcg = get_mem_cgroup_from_current();
> +	ret = mem_cgroup_hugetlb_try_charge(memcg,
> +					    gfp_mask | __GFP_RETRY_MAYFAIL,
> +					    pages_per_huge_page(h));
> +	if (ret == -ENOMEM)
> +		goto err;
> +
> +	memcg_charge_was_prepared = ret != -EOPNOTSUPP;
> +
> +	/* Pages are only to be taken from guest_memfd subpool and nowhere else. */
> +	if (hugepage_subpool_get_pages(spool, 1))
> +		goto err_cancel_charge;
> +
> +	nid = kvm_gmem_get_mpol_node_nodemask(htlb_alloc_mask(h), &mpol,
> +					      &nodemask);
> +	/*
> +	 * charge_cgroup_reservation is false because we didn't make any cgroup
> +	 * reservations when creating the guest_memfd subpool.

Hmm.. isn't this the exact reason to set charge_cgroup_reservation==true
instead?

IIUC gmem hugetlb pages should participate in the hugetlb cgroup resv
charge as well.  It is already involved in the rest cgroup charges, and I
wonder whether it's intended that the patch treated the resv accounting
specially.

Thanks,

> +	 *
> +	 * use_hstate_resv is true because we reserved from global hstate when
> +	 * creating the guest_memfd subpool.
> +	 */
> +	folio = hugetlb_alloc_folio(h, mpol, nid, nodemask, false, true);
> +	mpol_cond_put(mpol);
> +
> +	if (!folio)
> +		goto err_put_pages;
> +
> +	hugetlb_set_folio_subpool(folio, spool);
> +
> +	if (memcg_charge_was_prepared)
> +		mem_cgroup_commit_charge(folio, memcg);
> +
> +out:
> +	mem_cgroup_put(memcg);
> +
> +	return folio;
> +
> +err_put_pages:
> +	hugepage_subpool_put_pages(spool, 1);
> +
> +err_cancel_charge:
> +	if (memcg_charge_was_prepared)
> +		mem_cgroup_cancel_charge(memcg, pages_per_huge_page(h));
> +
> +err:
> +	folio = ERR_PTR(-ENOMEM);
> +	goto out;
> +}

-- 
Peter Xu


