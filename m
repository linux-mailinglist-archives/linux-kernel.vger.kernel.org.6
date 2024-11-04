Return-Path: <linux-kernel+bounces-394957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB49BB67C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B3E1C212FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E67E111;
	Mon,  4 Nov 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cvMabDsX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3770816
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727577; cv=none; b=NFwkhnV/KR1sqabAaC3L0PbsiWfJv6al7I1RtQmpqtzYmJeQkwlQ11HCdV2AP8pVA7PdUa78PHCtszsopSSl+6K/6N8PCapYWyG+GuHv2qcBLxfILQy8C0H1VcaEw8eyfLA2toPTjDu/yfoFbpiJp0wGfM2Wa/VjuZlw6O0cbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727577; c=relaxed/simple;
	bh=63cJ/3EqnDUd/mczM9IkDUzlHEgbCQY+Nrd1cdXDjvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbVsLq08zALwYLi6NNvAe9DthsBa6motT0prz3xw5FIF04T2D/BiEQoJ0CmT9QfJLqFIDrF+kGKdpPx62cfu6YGE8kb5MkNcsXM+UL34CRbQHglJfKf5SSrsxwjQpVDQzU9MRD8T5Ki3solNQhAtrSY3v+o0b6MbHvGTbZlGKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cvMabDsX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BRdPBTlcOPtzPn5IHt2FPOSweajW0rcsz4AYTMWTfBs=; b=cvMabDsX91S0/7F4RXfzf74F2o
	ADSbtBhzvzT4cQlA4lKp0/gUr1gMuFI4WaDryu/1yJacQ6dDF8pzoUfcZXcE8HCPnNNg32PBVtjFB
	dIYjnquczJPZ8/KqclXXrJpJp5TnZbP0v1CpxHR72UXCVQ9TghU3hkLSvvlC6GDk4vmuFo6tlDzZH
	Gt4F6gYNq8Go1RjIjFpnlEVKO3Mddhk1aBqqL6FobZdAnFxerU94y7V5UHD7OcAgizKP3jOleJUBO
	I+iKwnm+N29s5HVr/cerUSB1TrNBafVtuAFVXNl5hbx98zA6fVHzY+mKQkLZ5UD/2/Pj4uERYWsuo
	N81LWvrw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xIo-00000001DQl-12uQ;
	Mon, 04 Nov 2024 13:39:30 +0000
Date: Mon, 4 Nov 2024 13:39:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kassey Li quic <quic_yingangl@quicinc.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, akpm@linux-foundation.org,
	minchan@kernel.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] trace/events/page_ref: add page info to page_ref trace
 event
Message-ID: <ZyjOkSvYYKdFrRgt@casper.infradead.org>
References: <20241031024222.505844-1-quic_yingangl@quicinc.com>
 <8418b91e-04bb-4b74-96dd-a9489fbf9ba6@kernel.org>
 <55f6332d-3b4c-4478-93f9-514a906e348d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f6332d-3b4c-4478-93f9-514a906e348d@quicinc.com>

On Mon, Nov 04, 2024 at 03:35:37PM +0800, Kassey Li quic wrote:
> > > In many kernel code we are talking with page other than pfn,
> > > here we added page algin with pfn.
> > How exactly would this help you, what are you doing with the trace?
> 
> we met some problem where filesystem held the page.
> 
> we can show the page pointer other than pfn in filesystem code.

Don't do that.  Change the filesystem code to show the pfn, and send
*that* patch instead.

