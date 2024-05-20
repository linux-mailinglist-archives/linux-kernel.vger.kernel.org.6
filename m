Return-Path: <linux-kernel+bounces-184300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFFA8CA50A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBF91C21641
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1704AEC8;
	Mon, 20 May 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U6Ldz3rh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB63D3B3
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247816; cv=none; b=cT+o4wHHPUlnrVhRGQr8cHxH9JcPHCVMGHxzsi0t8UP0ysmH2H8VA5Dx6O8FRTCXjRUBI5budDLyeB2Mgia8CtI0+pUnuR4KvE1CRHW0GStfs5XSPvCV/lKwEMOaiS6mBOcduYtw735ZrslnUpr64kFYfLFXTBUMbpdNlRoLtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247816; c=relaxed/simple;
	bh=/vPCzaH8kMPnegz/mAbhff3VAUkm2Rnb7GzasOPwzro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPyLiUpD4V6LV2rA+MREczEhTqSh8ycoEctNZ+LOc8OoZUH/InxLaYaqH/5sm2idAUceklvHKLU6JrEFOPPveJI9aQ257J5qncGRV+5lI+KVLxCJ3x9LbyISFQi5xERExpQIwJ1JXyvZ5h3cc0wkS7ZIGqUND3CYVbzDLbF1kG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U6Ldz3rh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/vPCzaH8kMPnegz/mAbhff3VAUkm2Rnb7GzasOPwzro=; b=U6Ldz3rhh5p0Ojjdlv9FFS1NQW
	JCBIJtUPnfa9LynK2UC/KzRsaH+zz0usilUDZgoKJH5WK60MrDtwYC/CvAqPBvMtlRlmzyk/2xKTU
	2UW6HDZ9ET89PwrJ6aWFL7++mksmiMtjOCuS29GzhhfqQNXXptvOLlkdAkLUvU6ZuHy3MZBAcE4up
	LYwOE0ztPuZ5E9iZ+kUUfjXdQgkKGu1qj6V/Hypl0vQQcvr5eYQfsNZ0IG4QcPHvr9Ss35ru9l3Iw
	6gh0CosNbDvfyeXIbIRH8dyzHcmu4c8L9jzNgnSkryWOIOBH63LrmK4az56eVkX3d41rNzFUFfmhr
	H+nRdEew==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9CSG-0000000GUGa-2SrV;
	Mon, 20 May 2024 23:30:08 +0000
Date: Tue, 21 May 2024 00:30:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vishal.moola@oracle.com,
	muchun.song@linux.dev, peterx@redhat.com, osalvador@suse.de
Subject: Re: [PATCH] mm/hugetlb: remove {Set,Clear}Hpage macros
Message-ID: <ZkvdAGyua4daHg_S@casper.infradead.org>
References: <20240520224407.110062-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520224407.110062-1-sidhartha.kumar@oracle.com>

On Mon, May 20, 2024 at 03:44:07PM -0700, Sidhartha Kumar wrote:
> All users have been converted to use the folio version of these macros,
> we can safely remove the page based interface.

Yay!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


