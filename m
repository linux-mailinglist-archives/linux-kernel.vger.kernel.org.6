Return-Path: <linux-kernel+bounces-547373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E97AA50658
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763B6163937
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7927250C02;
	Wed,  5 Mar 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K0TT9O2h"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029F481DD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195751; cv=none; b=W756cVINfFStP+VMzsqZcnrNqE7dBTvVxV1MODdttLSfAkV7+l7F8h2hue7wAbEdXkvivcOOUkQeK6rwpiRh64i1eDa0IdFuThNc7i3e6ItlNhdJAxibqiWKrcdcSwsRdgLM3UbhYalVpgmkxdewR+0m8BYBcMrou2qpGudXlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195751; c=relaxed/simple;
	bh=B1wNsGRlbNuh23FquOiVRPjfZ7QTWBC3oKDQKjyCdJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYtZK9BmSYLJfNzH3ga82wvRd3sRrQsVSLyLb0AZD3rKc2lHIR6Kf3x3GyUXkCkDYFrrwiQlk23SUGl3mtWUslGm2yKyQ73wG6psdLmyMuw9m5bp4CA2WkpLpdbOtM1UF2yLH977srOgKGXH8ec+hVvduYiho08loRrq1fBnpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K0TT9O2h; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471ebfbad4dso52485421cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741195748; x=1741800548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c907La5P+bJluU/LHcR6Es6yd6jk3jgKb5ChVAM4Ut4=;
        b=K0TT9O2hTf5bnrGKM+kXK/8rBL6Dhtz+A4wj+laJR6nnyAkZjq44J4EE8EtNgDvcTR
         GMZ8BmS30STVnJERL3MiucAk51Asx+hAXWU3mK64Tyu6LDYr6bbSlR9Gn3neJ8hptXsU
         xxCyRay28z+yZFzULF33wVx/WebpPtuS0bdTnhcm6aMKxZ0vtXc9EVI1HhsFl3RZ803M
         WHt8l2Rm84t/cv+0/aOiUfxGjWLrkJgHPnYhfXxPYysppMTQDtER6BfmG88GKeNfcx9g
         JLP51QHm2HG1X1xQW7cyLXqqo8SSrvqiO9bZjjom0hoSBTPsG1caktyW69JBJOW5OpGp
         HeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195748; x=1741800548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c907La5P+bJluU/LHcR6Es6yd6jk3jgKb5ChVAM4Ut4=;
        b=XPJT1ClpMMvIIp8U0eIddOP70x6Jbo3t0GXMGNIO5adB0s3SFK3Xd+dnfEFF2NJ8wh
         Azq0b4ULQQkQ+xV68Zsfajjl8bwG+gDXWa6DlcZMKMEXJEIuge+1Rm8pNsbaA8kf9AGz
         /Kx4Xwul2Oy1Ag+wOmC91kCUQDjBYz5T0U3ny8HdLMn56XeulyBDfqVThGYDFYstNSGN
         zO/Dc48oLDNeDSVcCtQ8LbtQy6RQuty2saSeRNbqnbrHiEV3yYP9fjx6to7nz8uTuLzK
         g91RpQPjgezJFfwtPJK19OuUPE2Qm7DzSks4L6mV8MQPig/oG6CJfoZQlco8q2Txubm1
         Vjxg==
X-Forwarded-Encrypted: i=1; AJvYcCULKk9/fQONbHcLKu4CPo16IB0+WBrjhPi/ns7oi6akxXlloDmMghy7dc+PlcrvKXzqjFdkXmIjLAuL9o8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxje95fjYXG/Z0EIcYh5qKOs3RI3NaJsNi4Jyn/KM2z1/7vPW+U
	IOwNlpPQAgOf+VnzUmSH+Ekkq2lzRQCnNNnS+/oifRU39BR1tK8kAFk3FfEwwQU=
X-Gm-Gg: ASbGnctg/sDi4KkzGEJ7QDI+t+6G30TDxdVTx4zz8h/YNl0Ni+geGgxgncFk+nDNnRi
	LYEWWnulXXtfm+7lCPJS2Nqbx9C2+q7/vhwVUIXDf0dXOjQ/TwwbtsMejOE+59GWMI+3GLpzOOV
	OPQf7KhDvn0H+vbVhvVu5T/uGh3k9oOMLo7vAprjtC2ncccVimM2/J6rLEQ7GM2CLzFC9yLjoxE
	mvkS0KF1JF8QP3mCEh9stG/jRtYNcOLdBx1UozTUIFskAUxbEX8fG0QUeK/I5S/wxgKtf4r7E/6
	ijFxH/fQVyIr6eJTTp0=
X-Google-Smtp-Source: AGHT+IF4HNniD3vBEgV7Gc4XgcYAVaPywo5omCnN6AqAFGgL1Wjv+qwspVU+lTzqtNoHgcoOul5LVg==
X-Received: by 2002:a05:6214:2525:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6e8e6d144c4mr53580176d6.4.1741195748275;
        Wed, 05 Mar 2025 09:29:08 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765364esm81249136d6.35.2025.03.05.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:29:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsYM-00000001TIk-3gw4;
	Wed, 05 Mar 2025 13:29:06 -0400
Date: Wed, 5 Mar 2025 13:29:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 4/4] page_pool: skip dma sync operation for
 inflight pages
Message-ID: <20250305172906.GG5011@ziepe.ca>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-5-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226110340.2671366-5-linyunsheng@huawei.com>

On Wed, Feb 26, 2025 at 07:03:39PM +0800, Yunsheng Lin wrote:
> Skip dma sync operation for inflight pages before the
> sync operation in page_pool_item_unmap() as DMA API
> expects to be called with a valid device bound to a
> driver as mentioned in [1].
> 
> After page_pool_destroy() is called, the page is not
> expected to be recycled back to pool->alloc cache and
> dma sync operation is not needed when the page is not
> recyclable or pool->ring is full, so only skip the dma
> sync operation for the infilght pages by clearing the
> pool->dma_sync, as rcu sync operation in
> page_pool_destroy() is paired with rcu lock in
> page_pool_recycle_in_ring() to ensure that there is no
> dma sync operation called after rcu sync operation.

Are you guaranteeing that the cache is made consistent before freeing
the page back to the mm? That is required..

Jason

