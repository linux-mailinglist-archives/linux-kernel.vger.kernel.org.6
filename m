Return-Path: <linux-kernel+bounces-196875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17308D62D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F121C26719
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D018158D9F;
	Fri, 31 May 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bWKdxHhm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99621158D83
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161660; cv=none; b=qAmn2cpkrnGe7w8dedVA0pOB65wv6Wrjg4VpFDTB/McLF5yCDJGy8BLmvAFap6kSx4zwSZ9GAPc/R/OToL6AWAeU5eZZRwd6JjuuqIdH5DzNnIY+0b24VLwXo21y+EuhxZNJ7n4b5d0xV8E8Qe2cL+8hGJ1pmKmpyxvfY2Spsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161660; c=relaxed/simple;
	bh=/HCDdY/T3FCguskc7Pcc3gAtu4nYNC8KBbJGSImBoE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erxvIMqD+vqrYcfpBVVq4kgRI12kPcNmmfTRTl2Q5YzLIKREYPgQkEO+FFJInO9AIRy8DwkJubmZgXx8wi8L+S4RCDzR1HNIcH08wUoS/m6HqrJyO2jnVV+CXFavuNc2OeASvUJpS37e2lTXj9dC1yBU90h7m7H6M4+yMIaUS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bWKdxHhm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yYmj5HbRFBhg7n9dSx3Ho7FPIQnwrH0bnrFIQlD3oxE=; b=bWKdxHhm+/Mf+8Jyp1+myRGOMf
	ZgcrTjv3f1p6zIdY1kk1cDvEeMbeaau9x4OY10j02wbQeZkFZZuzQv27WYkdnZdKzTuPnWIfT8Syt
	NfRxEIetC/mMFPm/gtKve1taQwz/5ySaFHTFHzoJdme7Ua4BHISz0qbozWNv6EjEiluA89EqeKS+2
	iPYdM3pyYqPb+Ebg5lX6hDM7WRKeczBTUtKcJmvkO7Rj49RRpjTqaItSmENP8fHKp+rODiiz4h75J
	525vJxK3NNMsmkK7tbM3r4brIanOgos15J24GMUC8WpNakH8p4dz5WjFRtwpIDMFoGCK7NBqHIApc
	w4CI/V2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2Bh-0000000Bjg8-1Vi7;
	Fri, 31 May 2024 13:20:53 +0000
Date: Fri, 31 May 2024 14:20:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [External] Re: [QUESTION] mm: Redundant const parameter?
Message-ID: <ZlnOtboo8mpWVBxR@casper.infradead.org>
References: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
 <e6b7858b-39cd-432d-9206-4ccbd153baa2@arm.com>
 <7f7c3bbe-e250-420d-a7d5-89508d881f0b@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7c3bbe-e250-420d-a7d5-89508d881f0b@bytedance.com>

On Fri, May 31, 2024 at 08:30:08PM +0800, Chengming Zhou wrote:
> On 2024/5/31 19:31, Dev Jain wrote:
> > I guess it would be better if I send this as a patch and wait for comments.
> 
> Ah, you're right. I think it should be:
> 
> 	return folio_test_workingset(slab_folio(slab));
> 
> Right? Don't notice there isn't any build warning about this "const" discard.

But there used to be!  I fixed that in ce3467af6bde dated Feb 27 2024,
which took a fair amount of prep work to make happen.

