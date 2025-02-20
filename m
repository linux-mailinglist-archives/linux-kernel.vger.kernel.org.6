Return-Path: <linux-kernel+bounces-523051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD2A3D16C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716F816F7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADDE1E3785;
	Thu, 20 Feb 2025 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N40ZSDWG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB825760;
	Thu, 20 Feb 2025 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033184; cv=none; b=bfQ8odPqZJRguGwQmPutxJMRdtehVrsX/G7Tx3Rl+VInwk7P/dEsTXRCK89b8a6YU3+GRBXcf9fiuRPc/uw+bVMVKOQDZJ1QrO6fpTYJ42bJz/v5rEt53oN8VuAmGtqlerGQ0EhHl0krvcBQJ8LhUZSH3xglmptYOsObKkHFk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033184; c=relaxed/simple;
	bh=CsIKT7rs9zrHL6VYaLhsv5flP79D10ZOGjOixxslX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckiW+zg2+HWymkk60E1eq331mEUFbUjBHIXn+mnDku1oXnvLDBwWLH5srrf4d9aWYB/gCLmCX99ckuiYf4jNup3qsWoiOrOc+zJ5+B1vH5UJ626vTKl83EASRD6UYvTzr83e1l5AE6G9apLFytNE9fhEXygNsmrtVtVaBlufHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N40ZSDWG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/UyTduM4ptNAxZlxL6Vr7DQS5QVkhj4idYmNNIkyK4I=; b=N40ZSDWGzTKs7AL3gSV3O/8ShI
	ZAoho7Sxqqz81Pcb9L7O5Qa1msahkl4/J5LQhIdcuK51yBGfLHukkKxvEGaWLuHcMPlx4sLbmWKQI
	0UlIER4dYSL2hy6Q1W5Zq7grud/+wwpH9+r8Pwe8oZxh2pLFMWtjKguvG95jgiWE4p0R1g5qX51KA
	588FiaY+EoXvn70I2JoK/hjvRkxjY6ogK5KFOBccDl9Ijv1b3JwEOt6R7WAyVDL8htFPPScIhPzam
	HdriNkinCoOobwlPSFye9eox6c67+nOyXSnMh9TrBYbpEu2cz5F0Xq//Bk1eAntqaGCLHclkXwBxO
	gyuIip2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl07K-0000000GxAk-24hX;
	Thu, 20 Feb 2025 06:33:02 +0000
Date: Wed, 19 Feb 2025 22:33:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7bMnpq1cUezsNDl@infradead.org>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <45rpsr92-4416-9no4-8o26-r0998nr77nr8@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45rpsr92-4416-9no4-8o26-r0998nr77nr8@xreary.bet>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 18, 2025 at 06:36:55PM +0100, Jiri Kosina wrote:
> > [2] The idea of drivers in eBPF as done by HID also really doesn't help
> > with that as much as I like eBPF for some use cases
> 
> I don't necessarily agree on this specific aspect, but what (at least to 
> me personally) is the crucial point here -- if we at some point decide 
> that HID-eBPF is somehow potentially unhealthy for the project / 
> ecosystem, we can just drop it and convert the existing eBPF snippets to a 
> proper simple HID bus drivers trivially (I'd even dare to say that to some 
> extent perhaps programatically).

Well, Linus declared any bpf kfunc / helper program type change that
breaks userspace as a no-go.  And such a change very much does.



