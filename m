Return-Path: <linux-kernel+bounces-336647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200A983D84
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A44283DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCA9126C0B;
	Tue, 24 Sep 2024 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WGFtxSrN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7442AB3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161358; cv=none; b=PmjBG29U4EMBeWbZub/52gyaq4aRaTy8x8vj4VezjzRstMNvHvR6uKzs1tUm9SyUW++lGGbxdkCRite9VfMvh7L/yS5QFy1pB17ZJ8CX+mfmJdWdiH2oJ5ffZ+8vXnhOQk4bHK7atOCRDw8YoMy5BmMnhMunYA3/j2B9WVvwV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161358; c=relaxed/simple;
	bh=iD5VtOdQv5Wv882b3+6lkvFG2lXHn1rjcNrLnsbkzgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/F00o4QoHeBFTWnopErFR8l6YzgxUCAS7hoQjkgByAdxCzQKjESVpicqczvZlkZvmDXvfFpckOfWheqcWB7xfXRcBjuoiFONHwyYfYh4n7oQJ3NSSuWExjI1Cj8bBtZL75HIp1LJj+hc5mwD5RU/99zwa9z88jLqAm71ODt4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WGFtxSrN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FMeWTOqOAD7M1LmcnAkvVkBSA2an0KhGXWy8GvrGsn4=; b=WGFtxSrNdWZ8vxKtyyAL5oa2RJ
	V6CAqtDiQyR9HZ0OEpYOtRSPkUixNfr6KefhjnV6s1E7bl3r7oYdWNKqXXex03jf/XwTVg1jgiBrW
	cSfx1PpoXPFi9LUTMP7GnabDB3gvH2928hQl8HfuXki/OKKd4A80LQz4QkVyCCAHM1lrNQTRryObX
	snByTuNRM2VcVLS9BKWnBetDl1k+pB7ex5zuJpoo9ryHLpJEKgTrqYlPayPmO7cLyUiqxLR7bKjoo
	qnDlwFuETCGdLHdG2/mXuPR27+7I0JM9/kNTjZBZJ6ANgDMCb72iELJhKOGdQT171GpabJ066n+3B
	8kVMONig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sszZD-00000001LEW-2UTU;
	Tue, 24 Sep 2024 07:02:35 +0000
Date: Tue, 24 Sep 2024 00:02:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm: do not export const kfree and kstrdup variants
Message-ID: <ZvJkC_3cov1rfY0V@infradead.org>
References: <20240924050937.697118-1-senozhatsky@chromium.org>
 <ZvJfhDrv-eArtU8Y@infradead.org>
 <20240924065653.GQ38742@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924065653.GQ38742@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 24, 2024 at 03:56:53PM +0900, Sergey Senozhatsky wrote:
> Totally agree with all the points, I haven't looked at how
> popular that API was before sending out the patch.  Is there
> some sort of "built time const" but for strings that we, perhaps,
> can add to kfree_const() (and make kfree_const() always inline)?
> So that we can turn this
> 
> 	str = "boom";
> 	...
> 	kfree_const(str);
> 
> into a safe scenario for modules.

Not sure, but even then the API would be horrible as it still would
not work for constants in other modules than the one calling it.

