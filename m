Return-Path: <linux-kernel+bounces-409480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845EB9C8D38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DE528268D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7544C76;
	Thu, 14 Nov 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ypy31hTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6Rwc3+J"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B6179BD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595861; cv=none; b=HXpCQuOEufTzuzE4RK+1B9aukHg9eEyFDjT0KhUQevcf9wVuDYbRTLbRB62g/VgGwM07/UVtotOfbSwCMI0bY/i6VWpyJHADL/38GFiNYG37pmyxUbc5uQr/hH+xVMKILl8WWUF8FOGJtAk8flh8amTXQaZEzSrD+lNY71+xetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595861; c=relaxed/simple;
	bh=iRbFDIaKL4JXGLdGnOz0fpzSI5N3RfOVwSzNuqiye5E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NdmguwX1uVyptxNeGI8UlNsrkLqm4jVMmKkIoV4n3JrgFfaNxcBdhU2KCeJUgsYDsIWP4n5jwBQtWJKzWJd1H4UoyviThQ66av0BFQIm95yDyHn6n8r7B0EIj0FeAhkIahbYMqh7kiWzMtnQJjU2/Cc/5CcKgvq/FLlZdz+qb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ypy31hTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6Rwc3+J; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E2E3114016F;
	Thu, 14 Nov 2024 09:50:57 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 09:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731595857;
	 x=1731682257; bh=sFWs14+PPXRYtue3bwzu1urfhLPT1BIAspfMaSIijus=; b=
	Ypy31hTpCLKlJ5dFN8J/AMed++WeK1GcoUHCZ6PJ3pB2E1RRw4KmTSTv5WX9vYP1
	FkTeYIXGnCu7YgCpzHz24OHLA31eY0Z3Bzv01WOkuIDuOptM01PR5vvll0xCuiv8
	MjEjSSBS68UTU+jNuExNOhhhV50d10wHNBP1z1CCYkv+jN66Iy+Tfnk1RU233xJX
	4Wc6yS9wERVeLFkb2mbmPUYc05BD1beamrD6sC0IgCcUIdIGfAkZrzZA0PwIomUm
	CBVLBvBfIShumadPZRF/S+hTye06db63fRzyNSJfsA4yQXv68YMR522yitCbK9X1
	nLLFXWXjFLcOHHZnV00Xmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731595857; x=
	1731682257; bh=sFWs14+PPXRYtue3bwzu1urfhLPT1BIAspfMaSIijus=; b=Z
	6Rwc3+JuV7Rj30CPSnmRegEaDf5FgViAQY6FDGmf/dKrwwics4QzQ1rGdf5eaMkn
	IVBhSws3C2CsdDkEcH1m9gCQusgPRmMDq3d/9kr6rI2t29ngSWdElgioTdjWXicy
	yxPIc43KG8LXZ4+ZjyNXf4cDqwqVTIS3cgkyIaKZX0UncQeh6wAVLy8WQK4snObG
	t7KdUiviE9svgD0AsaAw2OmfD2FCs0+w1buxNVUO49cgagwuT8vJ3VykvSEll8ZB
	5FyQ3XyruFyyEr0m6LTyflg7+g1aKHIe+RvSSKDLGE6ztBHH7c039iGfX5/nmQ0q
	cEmA3/aVCxqoFN1TSrAqA==
X-ME-Sender: <xms:UQ42Z6TbDcxYd-ue_gPojRNxqfN8CaZ0Q7wBNDYBGkQHOdfv_qHgTA>
    <xme:UQ42Z_z4YVAj9jlnM8FqCPvjX9WYjj8aO-suXCgM5_l1MjaI3-RW3QCpK43MZr_9Z
    XcONfLFdOoGVFxK2ik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdeilecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:UQ42Z33DGUeHj88_CqJjIpbZtoEayoFnFOF7g_SXuldGhXlGUoKoIA>
    <xmx:UQ42Z2D2uU3PHV-5cmtBNTCxKL3pzy613uLPmRTNIGGNda02RutPOg>
    <xmx:UQ42ZzjrS8gvWUcenW_TNtWHvfZ1Sy_zodmYxEo7SHTvc9Zw1Hm5SA>
    <xmx:UQ42ZyoTLmasgCXH3WLsv1t8N07_8i34c0CiT8-gtax9g8rxCW5Ptw>
    <xmx:UQ42ZzdqHn5Bahe9AwfU-vYIM2Fcuk_0D98fPCpOT_qqjoZFeMoJ_cvk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3170A2220072; Thu, 14 Nov 2024 09:50:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Nov 2024 15:50:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, "Jeremy Kerr" <jk@ozlabs.org>,
 "Geoff Levand" <geoff@infradead.org>
Message-Id: <2938c8d8-1846-4e27-b56a-176a397f5cf6@app.fastmail.com>
In-Reply-To: <20241114125111.599093-11-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
 <20241114125111.599093-11-mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 11/20] powerpc/io: Remove PCI_FIX_ADDR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 14, 2024, at 13:51, Michael Ellerman wrote:
> Now that PPC_INDIRECT_MMIO is removed, PCI_FIX_ADDR does nothing, so
> remove it.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
 
>  static inline unsigned char __raw_readb(const volatile void __iomem *addr)
>  {
> -	return *(volatile unsigned char __force *)PCI_FIX_ADDR(addr);
> +	return *(volatile unsigned char __force *)addr;
>  }
>  #define __raw_readb __raw_readb
> 
>  static inline unsigned short __raw_readw(const volatile void __iomem *addr)
>  {
> -	return *(volatile unsigned short __force *)PCI_FIX_ADDR(addr);
> +	return *(volatile unsigned short __force *)addr;
>  }

I think the __raw_ accessors are all identical to the
version in asm-generic and can be removed altogether.

> +#define __do_writeb(val, addr)	out_8(addr, val)
> +#define __do_writew(val, addr)	out_le16(addr, val)
> +#define __do_writel(val, addr)	out_le32(addr, val)
> +#define __do_writeq(val, addr)	out_le64(addr, val)
> +#define __do_writew_be(val, addr) out_be16(addr, val)
> +#define __do_writel_be(val, addr) out_be32(addr, val)
> +#define __do_writeq_be(val, addr) out_be64(addr, val)
 
These should no longer be needed either since 
arch/powerpc/include/asm/io-defs.h only needs to redirect
the inb/outb calls but not readl/writel and the string 
operations.

      Arnd

