Return-Path: <linux-kernel+bounces-409516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD09C8DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9A6B2B07B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4D169AE6;
	Thu, 14 Nov 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y52RVQ0x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SycmBeHD"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9A13CA8D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597881; cv=none; b=me3w3TrRr2VuZlx4kOB7j2nW7l79p9soqYP4DEGNizfxK2eTXT7noJlvCwfBYBcrV1D0yHJN0NUfC+XCcZGj33nyVThc7XVTOvBMi2yNOxibi35PcaJVC1bvqKzRlbA9JWEviiEtyoRaeNNA9CJMXwX8oZb3QOw1le6SllbYZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597881; c=relaxed/simple;
	bh=PWkQyBasUyIzaJpGGHYnFtmxaeh34KKlH/BfVJtVsqQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BxZmCSxX9+2b3e7lRvamuplGzPOEtopnKuqXmJgHhz4aWLa3x5Al8RT3L7EHYk+4TCGT8Lm5h5GF/dqGKneyra2LtOO9t/PWeGjxAFc4j1P8VwvDxKigQY2gWSWcEusmGo9uJpQjdnGzkv3+PcBI5lIIlh+SNHjFA5A1YxAGOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y52RVQ0x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SycmBeHD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 17F411380588;
	Thu, 14 Nov 2024 10:24:38 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 10:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731597878;
	 x=1731684278; bh=sEKG2KJM22+jKSTHPnbchUezEDrqO6zc31mntUBERxU=; b=
	Y52RVQ0xIbfPhhKXYgHeja0MKfUI4AG1CCfZvZJFJw5UTCSO+filZbg1oSb4JA9M
	KRlBDyQ1PgYlusBE0tF4ZnpLOVpVtbVpSJmFVKbS3yYeHK8PCLk57sMt4gspeIGQ
	XwOI3vqx65r4kZIug77LQKOohlSEkoTem/uP8xc4AD990Pe6IHTXKkWT4953RItu
	ADDO901HVq3wiAvUKYDPB7iIt/uFvf9NFiKV2yZmOWGGz5Q5V03JpJgA6Z94WA/u
	PBw+h78QUgl3i90yl/xP5HaCEOVpZeROWqjigiSHNvua6tk+IBzTIxmFHF4sV07B
	2TgrKDsXZBh/tNU8r8Vgsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731597878; x=
	1731684278; bh=sEKG2KJM22+jKSTHPnbchUezEDrqO6zc31mntUBERxU=; b=S
	ycmBeHD6XvRQkl/3pixfFvOojf4RTjmSUxWC6VcUMhFgmD2jW5GHrkp3ycRbsNu6
	sBkLAORexbuh8QgtxCmg/jWLQ1I7bWUidNtx6pORjoSZuE1qPjh5yVDPEo1a0Gj6
	AA5UpwroUYfRx9i+hiNA8G7m9w/mQfPvD4CmxYhygozZD1JEXczEfEP0axnb6Pg7
	zJkBgX3+m0dhqglMTvL0RLCrJFYE1QEOWxJ4+xncIE7B4rHsNNh+XFqZbUtqB/Z9
	NEALEzewsvFwexOuYD3nHUcgE4K8DrSRZGidAwqQ2laPXA1MQi/PMdl12gN38U+M
	TZkDO2lTD8go82u8HmhsQ==
X-ME-Sender: <xms:NRY2Z1lQlkAonugTOHvHY-1BktHEABFzGjHLJI0WSoh6p9FKWxxClg>
    <xme:NRY2Zw1IMhRyYGygTw31F9_wSAiOclAm6KtrplVC009WudyUkw6qqKVa-2mxUT1zF
    N53-XLpbU18qI1CLxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurd
    gruhdprhgtphhtthhopehgvghofhhfsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    oheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtph
    htthhopehjkhesohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NRY2Z7qzgG_ajSoFqwLoSxb6B0u6vy9flx0HGLTcxLCVqjS8dAtSjQ>
    <xmx:NRY2Z1kOoVsH2gRUka_KWSaVkGZw8EiRER11q_53_qsPN-ViJleZZQ>
    <xmx:NRY2Zz3WxlpF0XTlI293HTTuhBjS1nG2g8-S6tLULTZIRUV5o_gQmg>
    <xmx:NRY2Z0uiRjJ2rjzTRwfK4dH8NUobEnONQadzWmwV3uZfXU2KDqikDA>
    <xmx:NhY2Z-T1W8IPpq-MpyJp1NB0iz-44721XI5rIb3rdCNwLu43YFUlWdQE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 981222220071; Thu, 14 Nov 2024 10:24:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Nov 2024 16:24:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, "Jeremy Kerr" <jk@ozlabs.org>,
 "Geoff Levand" <geoff@infradead.org>
Message-Id: <e34e2353-5818-408f-ab04-ce289bf418af@app.fastmail.com>
In-Reply-To: <20241114125111.599093-13-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
 <20241114125111.599093-13-mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 13/20] powerpc/io: Remove unnecessary indirection
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 14, 2024, at 13:51, Michael Ellerman wrote:
> Some of the __do_xxx() defines do nothing useful, they just existed to
> make the previous hooking macros work. So remove them.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> @@ -607,27 +600,27 @@ static inline u32 readl_be(const PCI_IO_ADDR addr)
> 
>  static inline void writeb(u8 val, PCI_IO_ADDR addr)
>  {
> -	__do_writeb(val, addr);
> +	out_8(addr, val);
>  }

I would open-code PCI_IO_ADDR here.

Also, at this point the writeb() etc functions are close enough
to the asm-generic/io.h version that we could try to go the next
few steps. One problem doing this is the definition of the
*_relaxed() accessors. Ideally the inline asm would go
into the __raw_*() helpers, with the "sync" and "twi;isync"
going into __io_br(), __io_bw() and __io_aw(), at which point
these can all use the generic versions, and out_*/in_*() can
be defined on top of those.

What I'm not sure about here is the __io_br() (sync before
readl()), since most other architectures don't do this.
Any idea why powerpc does it, and if the relaxed() version
needs it as well? Is this for spinlocks serialization?

I think the sync before write and twi;isync after read() is
needed mainly for synchronizing against concurrent DMA, so
it should be fine to leave those out of the relaxed
versions, but it's possible that there is something
more going on than I remember.

      Arnd

