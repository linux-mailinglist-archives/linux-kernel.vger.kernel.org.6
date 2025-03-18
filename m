Return-Path: <linux-kernel+bounces-565570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8151CA66AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2553919A0BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6AF1DED62;
	Tue, 18 Mar 2025 06:48:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3119199924
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280498; cv=none; b=qvzOVyxum7Ms7HDU0VVrhFI2BCLs2OaM9Q6V8dNX61TWInLBmCgu6quoFIK5Wk+Q0hGxTvtYy0Ny6HCr3t0CdqpX+5hXemIYNS0ef1f4QTQGBD0UmaDcwfYpxvp5iZZistIWDwad02Ugpk559U+hO74XNbykoKvAToAUamSUROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280498; c=relaxed/simple;
	bh=+vOmGynVLEJEyjGsolGld1dROzzH8zp9bw6wLy2zCXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/0LLM5xtYzBnMnfXyJOWXdNUvxk6iByMCaobuy+D3zbMjf6cA1Z7gJsm5R9zzShY/WpV4rYkPlWNq5Zc9tYwsBhENTqsfvB80OGFqg/9XGBfFzCB+7ZVnXHB3L4y+fYs1qjwRRzYujLqZS29cZOLScArs9U/FjbxGIKksPNexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE85268AA6; Tue, 18 Mar 2025 07:48:05 +0100 (CET)
Date: Tue, 18 Mar 2025 07:48:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Huan Yang <link@vivo.com>
Cc: hch@lst.de, akpm@linux-foundation.org, bingbu.cao@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com,
	rppt@kernel.org, ryan.roberts@arm.com, urezki@gmail.com,
	ziy@nvidia.com
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <20250318064805.GA16121@lst.de>
References: <20250317055304.GB26662@lst.de> <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

So you want a folio based version of vmap.  Please work on that instead
of doing crazy hacks using vmap_pfns which is just for memory not
historically backed by pages and now folios.


