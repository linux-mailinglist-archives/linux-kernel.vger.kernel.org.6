Return-Path: <linux-kernel+bounces-319277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF696F9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652C21F23B58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1641D4606;
	Fri,  6 Sep 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJ+ynGKD"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0C1CCB57
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644299; cv=none; b=oVVRWxQbStEYWrXwdtdk/qoQQdAHaJLc0sMr7B2xYsDxPb5pZ3eeVxOjUke9XePXdyZcvQfp97mb7tuN/LFLJWlsoKis7dvJQem0hKoNc8dfp4lKiN489orJb9/R7Oin2+jKaGefcOqO1yeL0Ql+q2bjLoSwnYzadEMruwNZvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644299; c=relaxed/simple;
	bh=MBSdAq54cA02vOd4SlFlVheqemxVUlmRu3KrdRgL2tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+ZPJd2EHw83rfa6Y35RXejpNLLA/5BjrsHgRhvC/NvzYaaHEbZCEL6CV7BK6M5fUN27xmr4MYnMwz+sl3G3ur6CexJsP6zZL7Xh2xiJZBro5JoTKEWjABYxxedQG8ggVfjPJHKusFmEcs3j+PmM5QzS0Y2/zfGpLCm/+/jM01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJ+ynGKD; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 13:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725644294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2rrML3ACDmSJeuYEP9TNvzY/VV+Uuzrg34u5fJL1u8=;
	b=FJ+ynGKDs6o7cFyfTV95vmrsA+BogmCz8UrNbbrMFuyuRfhUn89Fu3SdVcN8yqiLzWjjl9
	14WW+33u8X6L4SXL9ozbUC1l1NiOHvLsip6iQrXjmxb59h5G/VeQXnEH0+/8POSAUl1bpK
	H3JiGL6N6bp9BFdkIQwBh9ckkbM8fMg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Wang <00107082@163.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] bcachefs performance: read is way too slow when a file
 has no overwrite.
Message-ID: <ka3sjrka6dugdaab2bvewfbonc3ksixumue3hs2juhajhjm37w@bnxvz5mozpgr>
References: <20240906154354.61915-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906154354.61915-1-00107082@163.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 06, 2024 at 11:43:54PM GMT, David Wang wrote:
> 
> Hi,
> 
> I notice a very strange performance issue:
> When run `fio direct randread` test on a fresh new bcachefs, the performance is very bad:
> 	fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test  --bs=4k --iodepth=64 --size=1G --readwrite=randread  --runtime=600 --numjobs=8 --time_based=1
> 	...
> 	Run status group 0 (all jobs):
> 	   READ: bw=87.0MiB/s (91.2MB/s), 239B/s-14.2MiB/s (239B/s-14.9MB/s), io=1485MiB (1557MB), run=15593-17073msec
> 
> But if the files already exist and have alreay been thoroughly overwritten, the read performance is about 850MB+/s,
> almost 10-times better!
> 
> This means, if I copy some file from somewhere else, and make read access only afterwards, I would get really bad performance.
> (I copy files from other filesystem, and run fio read test on those files, the performance is indeed bad.)
> Copy some prepared files, and make readonly usage afterwards, this usage scenario is quite normal for lots of apps, I think.

That's because checksums are at extent granularity, not block: if you're
doing O_DIRECT reads that are smaller than the writes the data was
written with, performance will be bad because we have to read the entire
extent to verify the checksum.

block granular checksums will come at some point, as an optional feature
(most of the time you don't want them, and you'd prefer more compact
metadata)

