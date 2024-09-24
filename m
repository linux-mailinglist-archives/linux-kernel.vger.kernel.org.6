Return-Path: <linux-kernel+bounces-337055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7F9844C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E898B264A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57E1AB6D2;
	Tue, 24 Sep 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qc4XrnvM"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A21AB519
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177452; cv=none; b=cyfbUYL69NqnN1WCBP7cufc/cQXvcSxUpxjiAhzul+gsvDvdnH/61lmWc2P8sZtbn9uMfEmHueEm5BQpreqZtwm2idzvTe4Yz0tcv5EES/BQnerxjDO+fScA07MfunB6q6oiSSRkrLq+xzbYRbGLpwUATwTF/g+C0dzjgN6sqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177452; c=relaxed/simple;
	bh=Shdw5+tuYhqBZZnfhahbhFln3ahbwdhU6psYPvqOax4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq5AOu4mOxetUXjP23ZGR+UTF4Nh4MJSr513rejBxZgeOsh96PsdNQKduJ7e0fzUlcQOrZGnKrlbFQOZueH1LK5dilhfGR0nnzYRBQxfANGEffrAPzSE4CHHDowXPcT+5QJHlXh8/6IhqjRxVXwIlLlEIvj2v8KB6sNGkSbCRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qc4XrnvM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Sep 2024 07:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727177448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSx3Xo84OH/LH1yr/oPGKWLdMOfPbNYZydCjHW4ozKI=;
	b=qc4XrnvMRuL6995S/MFuIHmqJBUfbTlAaZ4qr7UZ/EI1+5vEQAEOFdU9/EHpL3I88La/r4
	JMY9BBz2IQFk/trmOfpurfjIa+7FY+4ois7UGVyznQ9lNOYN/5AKpTJevxXpFRRwOykciY
	xnYR/3tUOvNMjpgFfEBTBu04KAdSr80=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Wang <00107082@163.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] bcachefs performance: read is way too slow when a file
 has no overwrite.
Message-ID: <q4jjkhgpahmrr3z7d5qn7qhml3kqtj3roybuykkhfefxlezdbf@y4lbf6ut4siw>
References: <20240907103437.71139-1-00107082@163.com>
 <20240924110807.28788-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924110807.28788-1-00107082@163.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 24, 2024 at 07:08:07PM GMT, David Wang wrote:
> Hi, 
> 
> At 2024-09-07 18:34:37, "David Wang" <00107082@163.com> wrote:
> >At 2024-09-07 01:38:11, "Kent Overstreet" <kent.overstreet@linux.dev> wrote:
> >>That's because checksums are at extent granularity, not block: if you're
> >>doing O_DIRECT reads that are smaller than the writes the data was
> >>written with, performance will be bad because we have to read the entire
> >>extent to verify the checksum.
> >
> >
> 
> >Based on the result:
> >1. The row with prepare-write size 4K stands out, here.
> >When files were prepaired with write size 4K, the afterwards
> > read performance is worse.  (I did double check the result,
> >but it is possible that I miss some affecting factors.);
> >2. Without O_DIRECT, read performance seems correlated with the difference
> > between read size and prepare write size, but with O_DIRECT, correlation is not obvious.
> >
> >And, to mention it again, if I overwrite the files **thoroughly** with fio write test
> >(using same size), the read performance afterwards would be very good:
> >
> 
> Update some IO pattern (bio start address and size, in sectors, address&=-address),
> between bcachefs and block layer:
> 
> 4K-Direct-Read a file created by loop of `write(fd, buf, 1024*4)`:

You're still testing small reads to big extents. Flip off data
checksumming if you want to test that, or wait for block granular
checksums to land.

I already explained what's going on, so this isn't very helpful.

