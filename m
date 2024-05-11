Return-Path: <linux-kernel+bounces-176635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF258C3260
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 18:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9EE1C20BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB956B65;
	Sat, 11 May 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mAPpiOoT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0C38DD3
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443521; cv=none; b=KTbsalhvsy4XnnmDBvq/SR82W5r2w17eYOwq4u0IvStr+wxjJBWPRROd10jm9D6wTIu9kW8XsZA0GaRztz2r1JMC0IhnH+L4n7BBi/gMsmek63qzhWxsK/d3gXOt+QL+NKVbq6fUMWhAtAok1AYmUsriZce9tDE9kpKt10XxoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443521; c=relaxed/simple;
	bh=fy69Df2LdSHue4EcW6UTO6judU9exNS5dZwz4R+6/N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN7V3geuJYRcV7MYA47a+hz7ZIToCNOAdpXjCLnacCyIx7sma7wTig/zxcStl5pwoxddqG7YaADZJK9QrZE7EoI+QAKggvltuqFrZ8OR7h/epk1nj6F1isUIarCvhjErYCG8ZPiszbNbMeKRJsQ3GHZnB6DB3sxFrqLbXGtNlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mAPpiOoT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UP0RQCFejEFweF1A8DNne68f64ZB2q8cOhlPulA5RN4=; b=mAPpiOoTjjpni+zN7AOmjP1ID0
	hZ7k4zVHEQiKs451Wv7kbbp7AKgp9dg3hHWuoaUkrb6Vdu4tB5sE2XMXdO5nPjo6T1sWiGqOLAH76
	RP9GUC59c09FAIz8z5/5KuM+ySXT0YZUBG7C94I8xNIoyjqqlt/pjI2sX3QH5mdx1py8voMQitv+G
	kMPx7rLzN7grWGrr5DRm66uNZTmUDOl/iFoF1bWArS60GDBF2hlT0NBFg2y7Sp8Y/1ZGJvsckFgQ+
	6cHDbAoVQfbJZCD95Z5GJYe1qxeszJEmtfrgR01Nid3Wuh0F583xKVP/loZSL8rg+mhuoW8UKC2EB
	+DZEKMmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5pDm-00000005cvF-0DFn;
	Sat, 11 May 2024 16:05:14 +0000
Date: Sat, 11 May 2024 17:05:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, david@redhat.com, shy828301@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: =?iso-8859-1?Q?=A0=5BPATCH_linux-next?=
 =?iso-8859-1?Q?=5D_mm=2Fhuge=5Fmemory=3A_remove_redundant_locking_when_pa?=
 =?iso-8859-1?Q?rsing=A0THP?= sysfs input
Message-ID: <Zj-XOV08WBX33OJw@casper.infradead.org>
References: <20240511144048767fdB7EqYoMHEw6A5b6FrXM@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511144048767fdB7EqYoMHEw6A5b6FrXM@zte.com.cn>

On Sat, May 11, 2024 at 02:40:48PM +0800, xu.xin16@zte.com.cn wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Since sysfs_streq() only performs a simple memory comparison operation
> and will not introduce any sleepable operation, So there is no
> need to drop the lock when parsing input. Remove redundant lock
> and unlock operations to make code cleaner.

i disagree that it makes the code cleaner.

