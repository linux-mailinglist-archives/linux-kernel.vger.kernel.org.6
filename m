Return-Path: <linux-kernel+bounces-538838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64E7A49DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF89169C47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485D189B80;
	Fri, 28 Feb 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pM5ublSD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A71EF366
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757150; cv=none; b=b2WHTzn4Pi69wDNJQjj+fYTJNSnxgDX8jEeZdkyWWsaCt6Vkan9sPHFcYcEkHeC3MKwLmSoN97/TSce1OIoE+cWy79zjOHKKlzkfPNXGEWH+PM/+uJuj8ohUT9d3ubBEnm2umQpw7haqf/PahBnQ3Xk6D5ZpW1E8jLujdJ/7xHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757150; c=relaxed/simple;
	bh=AChTyM9HXnSzNqES1jZlNlbepSmTNsshVFZm47ZYMZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQmJNHVDa5Q9PIQYwJ7cLCjvIgGydBoRtgWYeKilHdCQvaT63oPONNeKVOe8fg3QMqdBxC93X4zfqL/PZoh5r6JyXlwkfblqzZAFDBfF71AO6Erj0luRlGMrq4G6CKiR5ipAL7cg3MmRUg5yFmCsQeCuIBlQQiBcVdmFvKT5Guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pM5ublSD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AChTyM9HXnSzNqES1jZlNlbepSmTNsshVFZm47ZYMZ4=; b=pM5ublSDQ9ECIzQvdQM3O6KmRm
	FxR9hGVcvPRMsVv25Lz+0y0NIiRdV5ioAjWqvB/1N/8cVtZBscKWdGB93r8FwbTOZJ6TL+Pb4pwIx
	wiISITsF13UD5rWvbY4dh5M0yoNZwn1j1cGpCDFX7PDnu4TKE00Kmq2gTVcXKNL34R7HAmnjMwmDG
	9AkKdtgvKSfQZ+xe6UozaSvOsmW1evt9Z0cIJ2yr5n0mtyw1PBjhglKllGG2sR9YvDhnwbEAxSsYY
	YA0IIuS2mqOymTokDvlbru/1o+nhvZJ4O8n7w819/SmcC9/zXQqX6pZDR6bNFZkKDStBX3ers9Bz1
	05wDpNyw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1to2S3-00000002B9m-168B;
	Fri, 28 Feb 2025 15:38:59 +0000
Date: Fri, 28 Feb 2025 15:38:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
Message-ID: <Z8HYk8bvvpg-n2Yu@casper.infradead.org>
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <a70158c3-d683-42d6-8af5-c800d51039e4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70158c3-d683-42d6-8af5-c800d51039e4@redhat.com>

On Fri, Feb 28, 2025 at 04:34:50PM +0100, David Hildenbrand wrote:
> Maybe it would be comparable to khugepaged vs. MADV_COLLAPSE?

I think it is comparable ... because many people find khugepaged
unacceptable and there are proposals to move that to userspace.


