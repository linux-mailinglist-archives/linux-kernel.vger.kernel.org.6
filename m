Return-Path: <linux-kernel+bounces-243942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A16929CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256B71C20E04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46E1BF3F;
	Mon,  8 Jul 2024 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gzM6WjLL"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9318AEA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422573; cv=none; b=hlV6vQXVabBnClsA7nZ62Yj/duh5MxRibfoXNHg+wMaxRC+A+bARBdDzwFoouC93jAdTTIqoPEW080pZKjuDNFRtxI/YWVpGLMiMf5SGKKq51wVqQX8sYSkOZAjdwayPNzMppk7meUETizT/8GxXr1rU2dT3AR34KRdwn+Go90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422573; c=relaxed/simple;
	bh=7YisusubUoe7l4lYp8Te4h3QlvmnUub2NwQhZKyMU0w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uLeez/Hm0o0195vqYrj2kqnkEzowwnEsidNLze7RdoOFkYg4Fuuc5YfxQxtMOTF7PTEt71BdiliOT/x9p5GWkPxbMii8xLg6dJbSMyzaAFsgJWXWEIIAd3PsUdJR5LTXqZtWvsoLq0cgm9jUVq7qZnzGNlKxxezsCDmKALUjImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gzM6WjLL; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linmiaohe@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720422567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8D6qUQ11gn7KCU80LqVUEVXfAYeJAPYzlzio/pNkVY=;
	b=gzM6WjLLR2uuzgwjnCAIfIx4ADVQJ7MwyKWnlsUTYALWUwDlqL/GHUFM24TyMOivTxmxpI
	4syUBde0gFHjlLx9qiJbF1ehty5D021RcZxM6cRew0EgDFsFM0uheALCA2lxiG6jvjmNq+
	KmJDsr2VGFCsT5u/aB35z+/z537U5nM=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] mm/hugetlb: fix potential race in
 __update_and_free_hugetlb_folio()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240708025127.107713-1-linmiaohe@huawei.com>
Date: Mon, 8 Jul 2024 15:08:44 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEF4F0F8-B3F5-4650-8B21-CCCE28FC0FCD@linux.dev>
References: <20240708025127.107713-1-linmiaohe@huawei.com>
To: Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 8, 2024, at 10:51, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> There is a potential race between __update_and_free_hugetlb_folio() =
and
> try_memory_failure_hugetlb():
>=20
> CPU1 CPU2
> __update_and_free_hugetlb_folio try_memory_failure_hugetlb
> folio_test_hugetlb
>  -- It's still hugetlb folio.
>  folio_clear_hugetlb_hwpoison
>    spin_lock_irq(&hugetlb_lock);
>   __get_huge_page_for_hwpoison
>    folio_set_hugetlb_hwpoison
>  spin_unlock_irq(&hugetlb_lock);
>  spin_lock_irq(&hugetlb_lock);
>  __folio_clear_hugetlb(folio);
>   -- Hugetlb flag is cleared but too late.
>  spin_unlock_irq(&hugetlb_lock);
>=20
> When above race occurs, raw error page info will be leaked. Even =
worse,
> raw error pages won't have hwpoisoned flag set and hit pcplists/buddy.
> Fix this issue by deferring folio_clear_hugetlb_hwpoison() until
> __folio_clear_hugetlb() is done. So all raw error pages will have
> hwpoisoned flag set.
>=20
> Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until =
allocating vmemmap")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


