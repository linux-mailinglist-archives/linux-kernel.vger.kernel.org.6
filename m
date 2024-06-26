Return-Path: <linux-kernel+bounces-230502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C71CA917DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ED81F2575D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2941617B405;
	Wed, 26 Jun 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZMkT1QN8"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3A16089A;
	Wed, 26 Jun 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397458; cv=none; b=Rc0cSSuMBek4gTTYjXW99hTiGIsjmdKcrYy5ASk99mXBUuVytESV6upJ/TblI7mx6jLnk+Ab1fTTNseb7usqOm+qTwoTmrFh8KZqouTjInjg3GXW9sf8yBvOtS4M0AvfeofFQxa4sNFCKpoHomYaHHiOW3q9ClnBptOmVax0uRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397458; c=relaxed/simple;
	bh=Z9OEb+W758nrFwD4DhnTTZ3Php5ucgAJEIdfGNrKUnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsQiv1EXSyP9aRb+U6qHLjybAC317psujhYIaFuplzeb6/rLK04Wtyn74xazF5UuOqSQkDoZsAAo64AC7Um+fO4D4s28Um5b+c0uEfKB8GyaR2Vfscs3GfXbHsxbahxc5IxbvzpjbOl9PFBtKZIoABsjRzEHQdvo8a4/5+18GAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZMkT1QN8; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 16D50200EE;
	Wed, 26 Jun 2024 18:24:14 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719397454;
	bh=Z9OEb+W758nrFwD4DhnTTZ3Php5ucgAJEIdfGNrKUnY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZMkT1QN8UFT0Fak1pLNlBYR6DfHHiVP7NAtk5ixPxEbOhlTV+BU+KVQQkiuZlfdaW
	 B9p5nM8pzH9wkTX2ZcU6/3iNY4qBxZfAE/mPXSrbsLNcFGb5GhmAzOgrCtz1jA/XNb
	 z7OyzlaWcPTXOiq9Cua1Gp3Si+KWkLbaOly3/2j9NxG/M+tkWBXKwpxciRserA0tDk
	 BzLtYRwFmWlCh+qHSsi/VsFkoUy6kZYUY+vdVPoF+t112z0bK3/NC7qGPxAFPIQ+s5
	 zt3uR9bbUedpsMFPDT/XlhKjQpusDxbXX8m24SHWhy+40UJWdTav8KZKU+8klIKQdB
	 QAjLCgQ0thUug==
Message-ID: <ce1786dd7c0e9b892ffdeed20eb0c1c9c0808984.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add property to select IBI ops
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Aniket ." <aniketmaurya@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Wed, 26 Jun 2024 18:24:13 +0800
In-Reply-To: <CAMmmMt3DZWA734iFGLxz7cj+hYiWgq5MDOrc_UJpYeaij+yywg@mail.gmail.com>
References: <20240626052238.1577580-1-aniketmaurya@google.com>
	 <20240626052238.1577580-2-aniketmaurya@google.com>
	 <e28ba03d1df1c0c5aec987411c40e44fc351ce0d.camel@codeconstruct.com.au>
	 <c15045b4-2e5f-4fcc-b25c-76a5e4973e93@linaro.org>
	 <b4ba5fa7834fdfb1a1e26ff0e01b9bb235de63b5.camel@codeconstruct.com.au>
	 <CAMmmMt25nkZTXXLCVGv1baf3azQR0kwbM8LP4EzCQKOPLUhbVQ@mail.gmail.com>
	 <d256cd72ef2011c3bfd045b04fb6509d1ac827e9.camel@codeconstruct.com.au>
	 <CAMmmMt3DZWA734iFGLxz7cj+hYiWgq5MDOrc_UJpYeaij+yywg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aniket,

> I am using dw core directly through Synopsys virtualizer development
> kit(VDK) setup.

Does that mean that *all* existing implementations of this design will
have IBI support? Changing this in the pre-existing driver will be
asserting that.

> Shall I remove the ibi_capable property from the dw_i3c_master
> struct?

Only if you can ensure it's not going to break the driver for existing
hardware deployments.

Cheers,


Jeremy

