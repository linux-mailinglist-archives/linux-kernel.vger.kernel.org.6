Return-Path: <linux-kernel+bounces-205526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCA8FFD14
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C66285380
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5ED153BC3;
	Fri,  7 Jun 2024 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Zydq7R3N"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B11C2BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745303; cv=none; b=KGKDRbvzqzt6+ORhcspigBOXPiXv8f6/5LcXgXyNx+YJp2OdDIe4al8QKCKw0MSLdD6m6w9NBMNb9983F+HaPkvJ49f0OtKeFkQHPU2XMoN6AVDeLiKA/YAi3YqV2+nhrrBspdQ7jVx3MD8yDM9o+fJz1aydcggXgmcjdM7JrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745303; c=relaxed/simple;
	bh=swrYQEjyK5kYwE+Ufbh6uLcnvJpDBZncNNf7rt1zomQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p0YbYh0WnMGJhY0NWCy6kXhF5eAlPnrQRcrBY8fFZULvkApoS3WvVqo9M5TC6EI1gKOC6RSi+krfSsNNXFe1qRjcf3HwDQVrgNgqkJ8whN9q0X+OPvF1yanPipD9pWqLjVoo4FKv8T1OeVLcqT4UlecMqzDqzhqzTBEYAVSNkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Zydq7R3N; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 90A6620075;
	Fri,  7 Jun 2024 15:28:17 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717745299;
	bh=swrYQEjyK5kYwE+Ufbh6uLcnvJpDBZncNNf7rt1zomQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zydq7R3Npt8pIWMv3xfBIn4ZsguMHAoWuT4jGKZtTpavz3y6niIC7xs6jgYar1yyH
	 WKX+dA8jDzgpHXeg1yFvqF1QOl1reUWcqObxToxTmcNx3ryUOHkVJOnTJJDN92nyfd
	 w+z9yo9C/U52GswCH9DQehGVHu53IXi+OoFrKDfmzP5E5/WuVXZsBeWGPK/1VVqJvD
	 OXJetvyWxy5FCnFF7VW/xb8tN7/ZeAtYEUA5LthppT7+0JfEda4zfx9QZtouYV/USL
	 ZRzmBiBJ2jRcLbfaKo1bDEaOF62/1E8ZaOTpXc5S6glFISUk3IBcill0fde4QOyP37
	 ywmV18aJ9Z/bw==
Message-ID: <c5199da0d4542c7ab8eec1c6d36fc329a937019a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] i3c: dw: Fix IBI intr programming
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Aniket <aniketmaurya@google.com>, Alexandre Belloni
	 <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, Billy Tsai
	 <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 15:28:17 +0800
In-Reply-To: <20240607072030.2618428-1-aniketmaurya@google.com>
References: 
	<CAMmmMt2guEx1jajb2NC0iBnMGpkd2vaSiXg_BqgZhwrA=FARLQ@mail.gmail.com>
	 <20240607072030.2618428-1-aniketmaurya@google.com>
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

> IBI_SIR_REQ_REJECT register is not present if the IP has
> IC_HAS_IBI_DATA =3D 1 set. So don't rely on doing read-
> modify-write op on this register.
> Instead maintain a variable to store the sir reject mask
> and use it to set IBI_SIR_REQ_REJECT.

Looks good, thanks!

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

