Return-Path: <linux-kernel+bounces-432487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B520A9E4BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444C81881989
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF2E149C64;
	Thu,  5 Dec 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="jNyoix/H"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734837DA82
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362940; cv=none; b=JzF8enmfFyeGecsJb2Qjwjhads2EZGte6T554GjIjKp1VKEI66hvz4ywHU4Dw9uA8h0kLabnthFeqKE1Bq7ECPpgvM4tAnueOBEulgxIvXhu9udb+Zsxts1OC6d3RFICyrjDS7dB6sjvtbKEyAtv6RjPy8nTRxevxNwowu6wAjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362940; c=relaxed/simple;
	bh=0BURu8DvwFOVPGca6YN7y1NRJgZQgXvPSCN4SHA3hnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiqKa5ObyH6PNrcau+5ylB0yiPotcx1uXHAIQUK+qlmxKr/XR6PkzAtFhmfn5EtMfhEk1G7A2tf14WsRwezAaa6pBs1zT4W6bn7W2WRKxXoqYjX1A4p9ImXMuKAFr0p+Fv/grH3kZzgsuVPz+XcEdq461WihRm+GBhm6lTDkGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=jNyoix/H; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id D44BB2003BE;
	Thu,  5 Dec 2024 02:42:07 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=jNyoix/H;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eDKcusopXquKmHVKHd5VSYJMro9KedZVGC8QmPsjNLU=; b=jNyoix/H9aypJ6ZtgZ8JTjafWR
	n4d5Rd9Un3IbPtwBry1m5IxJMEUUTE2PrkxecTvkqErekdnThFkyqQDc7DDEv8HuXPRxxbbyyvlHF
	vbl9mFHGv50mqCQ5OMvjmGX2HIQ2P0LgH1BayeMAY6NsN9QSJBTOzcKrVFXVK3g9gH2w=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tJ0sZ-001Hrx-09;
	Thu, 05 Dec 2024 02:42:07 +0100
Date: Thu, 5 Dec 2024 02:42:06 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1EE7gIlaSI3V4SY@bender.morinfr.org>
References: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
 <202412050840.umPPa7cK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412050840.umPPa7cK-lkp@intel.com>

On 05 Dec  8:39, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    mm/gup.c: In function 'can_follow_write_pud':
> >> mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Werror=implicit-function-declaration]
>      665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
>          |                                                ^~~~~~~~~~~~~~
>          |                                                pmd_soft_dirty
>    cc1: some warnings being treated as errors

David, how do you recommend I deal with this?

There is no prototype for pud_soft_dirty() in include/linux/pgtable.h
if CONFIG_HAVE_ARCH_SOFT_DIRTY is not set. Should I just add one?

-- 
Guillaume Morin <guillaume@morinfr.org>

