Return-Path: <linux-kernel+bounces-266710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E579B9405AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1813283277
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D5146A6C;
	Tue, 30 Jul 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="luyTwoTY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33309D268
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309109; cv=none; b=JrTxYtAS9ZEwiCuoibw0Z2QvmTNI4L2aTtW1yK8uhTmtlkAJBSxSvikgR08flN6r/u3/CE6D0C/JClyVIF5Hj2PlqJpHI6EvfxmoIUmG/s12KhVYlkCoSRcLd617Gd4FT6JPmT7IiLSdNhYZJ1WlUeF8AGgVrQGJAcjhWp+UnSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309109; c=relaxed/simple;
	bh=eVINJKxwt2qv/geoOiisXP4qd9ncwZg5QZ6XjDnd1Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkHr0YVvfxh8DOZO1gHqqwS/KsuttR5TuZEnzHn3x5xTXqA/QH7YIF5yHdCGpKWcpboZQnpHckPhp/nATECa4PjukmOYQ4+fW65Zki/mz9Z/vpTu2JyA80VRAGk5gC9+LhQN31RYnal46XgFnlAxJ3aa3WhYjs+Q0ySPA6zaq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=luyTwoTY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7pYRuLHYBWIN5u3RA3hPR9pIartGYjIePiVtVVFf8qY=; b=luyTwoTY/k8zFYu+f1V5+/juIH
	pN44U1XrrmTn0k2RW2BwrvKPrzcZDmBDnV6QhByC1H7CgMnfRUzJC1CJ05BiawjcrLuCCEWXikzzP
	BNpWbA0K7ImdmagJqipukNtMFk0pFO0zj8Daju/soioOlNNLvivpp45bU7RjDv7kQxqy8YTSJ/rqJ
	IIUblyEfdPSQkDNytx6AYmBuhdudJA3rfrksqRFjA3rN2m8LHvmhuwUgRYm0B38sdzhLsRSE1Sc/k
	NvQC6UR+YyIDAtnxuq2G9belP4SkRkfk8FgGr3DMeZ1yf6HHwoZsMGFVbxwUgP4idWszi7vxVWArU
	zZ31Td4g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYdGk-0000000EEB4-1sTs;
	Tue, 30 Jul 2024 03:11:22 +0000
Date: Tue, 30 Jul 2024 04:11:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, yosryahmed@google.com
Subject: Re: [PATCH v5 1/4] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
Message-ID: <ZqhZ2sFhZ3-lyqz-@casper.infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726094618.401593-2-21cnbao@gmail.com>

On Fri, Jul 26, 2024 at 09:46:15PM +1200, Barry Song wrote:
> +static inline int swapcache_prepare(swp_entry_t entry)
> +{
> +	return swapcache_prepare_nr(entry, 1);
> +}

Same comment as 2/4 -- there are only two callers of swapcache_prepre().
Just make that take the 'nr' argument and change both callers to pass 1.

