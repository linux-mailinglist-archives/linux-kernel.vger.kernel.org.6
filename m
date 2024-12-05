Return-Path: <linux-kernel+bounces-432488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613CC9E4C13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B3F1881535
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27981720;
	Thu,  5 Dec 2024 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="rsk8276i"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD62F56
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733363831; cv=none; b=WqON68bmy+M6vl9f/HHzwU1Y8Xb5NG+WjFkB2abHE7x6bI+OI9Tg30Qd/NWmr2FFCBJSbBSxPddAN2fD+GmCIVyqP12xmJret04J/PBz5uCM0/ImTRtYRxdqzUoXUuDWjoPw9BilCletdMJX9DsWuSQ5YI7ZaPPbgFzSMhG6m+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733363831; c=relaxed/simple;
	bh=iYk5igVeXHOFRXu5T/JSMsT+R2lcpCR/g8bS43SvqeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVOEQCOw+JDL+RBxv1wCH3y2LcfATnE/Q5+GU02zQrqVPfmJZ/052mzrCuJL7j91R9Z3dDiBbrK6M4Cur4/W+kDFg9Ntkyz/n86LfuUikllW8ggasD06yuvZyg5SQ4x5bmD8EJ/3+maNEwtc4Wc5eHBXuAkwyluJ31YKvdjuujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=rsk8276i; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 1FF9A2003BE;
	Thu,  5 Dec 2024 02:57:00 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=rsk8276i;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IjLNNGvNOI6B31kAryzNagbK4F2cDGeBpknM3DNt44E=; b=rsk8276ig8VS+Y4y4hoG0aD1nQ
	FWus6rX2P10TJUv7gRUGWSfXxyRqM4G+aIlrl618N9iPAndL3yho14Bu5u9fQ9QVE54i2RwX7fDJE
	2YVbNoh2MDr0N7Uo7nHy1/IyFfz4oL4tnlTKJNahKhmPxTeEs7HqMMj451RPlc1pFiaU=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tJ16x-001IBZ-1W;
	Thu, 05 Dec 2024 02:56:59 +0100
Date: Thu, 5 Dec 2024 02:56:59 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1EIa51dKCrsHdTC@bender.morinfr.org>
References: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
 <202412050840.umPPa7cK-lkp@intel.com>
 <Z1EE7gIlaSI3V4SY@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1EE7gIlaSI3V4SY@bender.morinfr.org>

On 05 Dec  2:42, Guillaume Morin wrote:
>
> On 05 Dec  8:39, kernel test robot wrote:
> > All errors (new ones prefixed by >>):
> > 
> >    mm/gup.c: In function 'can_follow_write_pud':
> > >> mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Werror=implicit-function-declaration]
> >      665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
> >          |                                                ^~~~~~~~~~~~~~
> >          |                                                pmd_soft_dirty
> >    cc1: some warnings being treated as errors
> 
> David, how do you recommend I deal with this?
> 
> There is no prototype for pud_soft_dirty() in include/linux/pgtable.h
> if CONFIG_HAVE_ARCH_SOFT_DIRTY is not set. Should I just add one?

I am going to respin v3 with that. Let me know if you think it makes
sense or you think it should be fixed some other way

-- 
Guillaume Morin <guillaume@morinfr.org>

