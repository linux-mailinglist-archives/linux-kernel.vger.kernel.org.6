Return-Path: <linux-kernel+bounces-245758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24792B8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15345283EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7219C1EA74;
	Tue,  9 Jul 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZGnHNt5h"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6887AE5D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525761; cv=none; b=QqDRY/VHcL8V02JYyqsRW1v0rHYDLBR5RngI5VL4VJBQL1vg5PzQ5hpK483ooVAiZMtGze4t8z6G6ExRExQfANtFfswcdZ8JORqZXBaA9ftmf4a4fx8YO2q2IbNM8STKFJXYR+RiIlGNS2724hoOCam6D6QNOdd484fkDeKvf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525761; c=relaxed/simple;
	bh=7haud2wyg9KA+s19sFx0cqvV6Kk19VeBdYK1GkkGMME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXRCFozzrAzcDqIi1f4L+7kE40SLM47/D/vGVVjGqJ4tF0vH/YUCW90F/9QR1jR7E5Gq4cjQBe2Ltu7TcGdDuQk6vI0oDt778nmHBLaR4lEoYcQVmqPw22rc+19HzpBfSnhKRyGcXpyda6pYfiGGlNyQkXw3PTw7sqTF5jRkbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZGnHNt5h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ftO62zkTRGepQ472ogpI/abRci0PI4RVGd3poJ2gXkE=; b=ZGnHNt5hWtIFNrgI8eAaxLFxhf
	0j/Ra0y2N3IFAfURpRGuJn+AS7sT0PaW0+xzZ7kwr/V6q79ICWmugmncQmVPuSjsIJGma7XE9Hmlx
	rTWV9Mk9Md70olJCxliyeCb/KGuklBuIPjrI01Wl+o+F1hVlA+GcbHQYeqURZhOdwEljW0wUwqMQD
	h2uwCcQuHs1riHx7A/8uF7kLJymGKbyhdTIAZS3VRyeedbERb29LPKyBZmPr8KroHx5fR4B8305HV
	rLykTaSouoPhCsMHFf8KD8FafSkedkgRtCm+AWixaMiVpljfErZ2+FG/7dBm9B8Hn4ZjHlQJxARg4
	dCY42w0A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR9LP-00000007qvl-2c3Y;
	Tue, 09 Jul 2024 11:49:15 +0000
Date: Tue, 9 Jul 2024 12:49:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>, opensource.kernel@vivo.com
Subject: Re: [PATCH v6] mm: shrink skip folio mapped by an exiting process
Message-ID: <Zo0ju0NAg2cAikU6@casper.infradead.org>
References: <20240709041050.619-1-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709041050.619-1-justinjiang@vivo.com>

On Tue, Jul 09, 2024 at 12:10:50PM +0800, Zhiguo Jiang wrote:
> +		if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +			check_stable_address_space(vma->vm_mm)) &&
> +			folio_test_swapbacked(folio) &&
> +			!folio_likely_mapped_shared(folio)) {
> +			pra->referenced = -1;
> +			page_vma_mapped_walk_done(&pvmw);
> +			return false;
> +		}

You told me you'd fix the indentation.  You cannot indent both the
continuation lines of the condition and the body of the if by one tab
each!

