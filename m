Return-Path: <linux-kernel+bounces-290884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51D955A7E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 02:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B702D281FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F984414;
	Sun, 18 Aug 2024 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dStrkpQj"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2621FA4
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723941431; cv=none; b=I1w4tPuVdYoyALGyMc7IIeF4Eev938J033JF1Mc7qwqcJpskXRAOnkMFmADcxGQ1wd/mH+/72WxBkUJ4l5jivgMKITUFM5vNzacUuKmDnkFCG3buaCw8UYNPLaehZ881Lvdrge6s5y+7gAYAo7+72zpQ8QoVIdJzijvAaRTVRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723941431; c=relaxed/simple;
	bh=Q3I3+5JnLT4Jd7w3VOY4XUUrUIBjXVnEN/K8TXC7ZGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjUR3eug5CGaYhfupIDzDoP0SsXnh8KhfqrVLdGoFAJoZl+7o2vFvUKanKiFW3ZUt+v9fCZ5qwxzUnpeRTGg8tbAxgr5wXtwIqufuDmNik4GnmkoHt24K0JRiReQGT6qV+ToT3g9N2x/sLJSt2cP2nBbH2PpcAiT921nnLAGRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dStrkpQj; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Aug 2024 20:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723941425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYkynEKsx9LuEfcOR/KSUyhfmdNcTOX9jCvZHeH06Ys=;
	b=dStrkpQjxmaWENMIsLRx88SgnfKUzNmRKZ0fpjKIo7G21ceYgO0Czi88iufI7Wv83AcqYC
	EbGSh5ETGXiD8AFdy9p1x3gctDTzFGNDWALXfPIE1Iv2DCRpnn3HDd+B7IWGvtzup5g3oJ
	joryuJBjVbzlD80Do1aY/rfVRGjHUPY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: lee bruce <xrivendell7@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, yue sun <samsun1006219@gmail.com>, 
	wang1315768607@163.com, syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: KASAN: slab-out-of-bounds Write in bch2_dev_journal_init
Message-ID: <hcshfmofaowcqbqvdklwhbm4wardtdrlf5lasznnpo7rij3bkf@eg4fppcyqepz>
References: <CABOYnLxyHNxoGGTPTTsE-=rknbQJuto_v6jRdRHG5FJRiphS4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLxyHNxoGGTPTTsE-=rknbQJuto_v6jRdRHG5FJRiphS4w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 17, 2024 at 02:38:40PM GMT, lee bruce wrote:
> Hello, I found a bug titled "KASAN: slab-out-of-bounds Write in
> bch2_dev_journal_init" with modified syzkaller in the lasted upstream
> related to bcachefs file system.
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yuxin wang <wang1315768607@163.com>
> Reported-by: yue sun <samsun1006219@gmail.com>

Do we really need multiple syzkallers running? Is there a reason you
haven't just gotten your patches into mainline?

