Return-Path: <linux-kernel+bounces-577670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE2A72015
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D22A16562D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84C2561C4;
	Wed, 26 Mar 2025 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LUwhr+UJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED2194C75
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021742; cv=none; b=pWzkEg2pIt1F1vbXX43d734boFYhM/56CurdfF19rG5J4aKpPJG6scU4JRS7mwEpGL+khCC6ohq2l28azYBCzUyO42k7ne1tKoZ31TcJ68Rs45ClL6HZIy+zcazBnvKN7wg3e9JIDl6nALbWREydfQEJHU09rO3vxcMVNYOi43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021742; c=relaxed/simple;
	bh=kqpj3gBdFSTu78yKcSfuMiCpqKZs5nij5O3DNADXxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COhnJglQRzyi1DK3F9vdJzVirpRZnCSmfnR5xWOKxplcgVz9vAnbyRIZbSZLGRtI0zkLIABxg1s0WdgfW4ve9swtSBD0xRpUcG2++A/eIHXewjJnS54CSLdxBdhaeUJQ6rHvcu2AcYeblnS7frofFSumF0y9q6nRLoTaSq5pynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LUwhr+UJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1cW/s3bKLJZVIlsHJQj5vb5bjFdwBji7A9G+nvosjl0=; b=LUwhr+UJ1OJTnrWYYpBJ6yQNFy
	meaQi2IQEFcDrOwjK3jMqFlkyOciWgKE6apKePLIYz01qKS80KxOhKhTc0BzEVtPZgj8Dyq6WRg17
	vcPYu/gCj9YglOUvVIhcP+4onthdQ6w6Kz4IUKazp6j6yEZMMwGIWt+OxRcY6iGABA5aKXgo2kxYN
	ajy3jpVj/UNk+6Kp45bJKrmJ8/aef8N/PM7AdkzaSYurfeHTKYDMwvAF5sMFVA6PYhaiYZpQ0sltV
	mDGTUEgBbflB5AchTc306FFV/zGnFK3tYHsH93odO3ROCuPHbUtMbHnW2MYK/V2QcdhH2nM7MqTRo
	k9/Znhew==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txXZj-00000008D3Z-2VOJ;
	Wed, 26 Mar 2025 20:42:11 +0000
Date: Wed, 26 Mar 2025 20:42:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: ffhgfv <xnxc22xnxc22@qq.com>, "vitaly.wool" <vitaly.wool@konsulko.com>,
	linmiaohe <linmiaohe@huawei.com>, akpm <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux6.14-rc5 BUG: spinlock bad magic in z3fold_zpool_free
Message-ID: <Z-Rmo_xx_btMKO99@casper.infradead.org>
References: <tencent_2C3830CD73C3B917ECA59895C90CB43BF009@qq.com>
 <CAKEwX=N98tC5Tq+XYLgAP4MDUBAO01ceE4e+mrk9i3YniL2Vkw@mail.gmail.com>
 <CAKEwX=NbpaQcq_awoPKmAuPWL=D4C2W7o_9D3J_SuDFvtbo9Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=NbpaQcq_awoPKmAuPWL=D4C2W7o_9D3J_SuDFvtbo9Ag@mail.gmail.com>

On Wed, Mar 26, 2025 at 03:43:28PM -0400, Nhat Pham wrote:
> On Wed, Mar 26, 2025 at 10:32 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > On Wed, Mar 26, 2025 at 10:11 AM ffhgfv <xnxc22xnxc22@qq.com> wrote:
> > >
> > > Hello, I found a bug titled " BUG: spinlock bad magic in z3fold_zpool_free   " with modified syzkaller in the Linux6.14-rc5.
> > > If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>
> >
> > Please stop using z3fold :) We already removed it upstream.
> 
> To clarify a little bit - we've found that z3fold is buggy (for a very
> long time), and does not outperform zsmalloc in many of the workloads
> we test on (both microbenchmark and real production workloads). We've
> deprecated it since 6.12:
> 
> https://github.com/torvalds/linux/commit/7a2369b74abf76cd3e54c45b30f6addb497f831b
> 
> and will remove it altogether:
> 
> https://lore.kernel.org/all/20250129180633.3501650-1-yosry.ahmed@linux.dev/
> 
> Perhaps Vitaly can fix the issue for stability's sake (or in case
> there is a reason why you MUST use z3fold)? But I strongly recommend
> you experiment with zsmalloc :)

This group are syzkaller kiddies.  They have no understanding of what
they're testing; they're just running their fuzzer and sending emails.
They don't care what's useful, so there's a lot of noise from unmaintained
filesystems and so on.

