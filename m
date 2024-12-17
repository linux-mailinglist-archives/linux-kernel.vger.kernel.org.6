Return-Path: <linux-kernel+bounces-448548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4249F41A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAD16C970
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86014601C;
	Tue, 17 Dec 2024 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E5h/glVJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B838136347
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409077; cv=none; b=PSvpx/v499TSSb2sRJC0J2I7vg79izwiLbxS0zghwJoJ3Ky1PDtMfP/Wce9jBF4/RPzmQDePsay7DpKT++Y2f7qpJyl/mdgZTLEv7R83nmslQlx3vP/qasnDxrGqOmt+MNIc/rfyRNLzMluGq70Mdrm+C83JgkQTozHsBKX3WIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409077; c=relaxed/simple;
	bh=tZ4/ZdO0Lu3f185R6V70VgueauEhg3ezHTHVLsuvfys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKvVvmBjXlYctOUaL8PFPoqMfcIrG7hx2zN8wD49bCUy6Yi8hVs2lRGu017C9JEIgNneG7XTMWYXa9498JBmazCkBL2vMGSJlS9v+xGeJt8OSvgNC2Fs4uDMZal/V1GeNDDjr7fJTOvb/s0IxEosBkhumF1Zp8F2VaQ4vzGVa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E5h/glVJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I/0zws/9aLkiOvy585Pgjr02thNq6CotbQy/GM3ejDA=; b=E5h/glVJVtrnJhTIhlTaHX6zaA
	zMG4t5yJWyNHQL1OljyoRoyjdD41Brrs1s86vuu5z4Ae2xkkERBvzgtk+OouitYy/SlzUsYXInMSh
	pCsUSELqk5NH+lrQ7E5HTCEjDxiWmf28dYramiC9oOYCSdnHXHBlgIPavdRjiLI3DaOb+Prrzq4Nr
	JjMqqGRLoFbpfnHWvTCCbM0SFFxC3bmLqz9FB9pB5nRjWPeVX7sfsYHfKjtrp5+nDjIaJufWp1gvm
	Wxm4UdswwgAfKqKiQGzz7XyEyZ9oGRXDzIo26oxhoXW3VS2XmdVRbKWQlAq8CP4XVt8iAzCZ+cqRa
	Ka2AIQNg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNP1d-00000004lT5-3TbF;
	Tue, 17 Dec 2024 04:17:37 +0000
Date: Tue, 17 Dec 2024 04:17:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
	kirill.shutemov@linux.intel.com, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
	jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
	hughd@google.com, aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
	wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
	surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
	zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
Message-ID: <Z2D7YctQaFW_iwei@casper.infradead.org>
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216165105.56185-3-dev.jain@arm.com>

On Mon, Dec 16, 2024 at 10:20:55PM +0530, Dev Jain wrote:
>  static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +			      int order, struct collapse_control *cc)

unsigned, surely?

>  	if (!folio) {
>  		*foliop = NULL;
>  		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		if (order != HPAGE_PMD_ORDER)
> +			count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);

i don't understand why we need new statistics here.  we already have a
signal that memory allocation failures are preventing collapse from
being successful, why do we care if it's mthp or actual thp?

>  	count_vm_event(THP_COLLAPSE_ALLOC);
> +	if (order != HPAGE_PMD_ORDER)
> +		count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC);

similar question


