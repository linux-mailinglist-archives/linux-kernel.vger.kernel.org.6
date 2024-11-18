Return-Path: <linux-kernel+bounces-412752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349579D0F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AC7B2BCE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B7E194A49;
	Mon, 18 Nov 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ylq7hZRm"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D240154BF5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926041; cv=none; b=ux8zN88SVWSF7BIY19FrndpHTnJQ2D8QH46JebxKbfC8/1Zn27stXLfQVubtZhbRigesNuMxS2T4uj2tSgWA17jwYW/p1rnmerz9Lb7eOOoaWLB4O0jaWX0ogOu4qTHhWGS9m/jaZ57ebo/uvrCDL6OXXQ7Fcl3YKnStR/evjjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926041; c=relaxed/simple;
	bh=3QbtL+cZcW8vapLs122ZmhiOZ6P53VsNtBrGOyv4wqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XjjzDC9IGhfTFvEngy3gyOPJ4AYy5/p5RMyk3+My8YJ+vcxEjxU69mu2Z27cWg/qhzSHgZ6ZoIGwYBi+4EDB+qZqlqRM2i7rpuylbjr55vL4DG/FkKX76Xs13fugIscL+/E9vucbY4tg1MxzwhlGcWM8FmN5Mc+2p03Nigckplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ylq7hZRm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5CB0FF805;
	Mon, 18 Nov 2024 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731926031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QbtL+cZcW8vapLs122ZmhiOZ6P53VsNtBrGOyv4wqk=;
	b=Ylq7hZRmtSxlTZfyiqyPKtDsZFIVPmE/UzKLf8ofZF2eqoJOw/sXNIBRAtly94+njkd3gJ
	zi9SyqpsQ74xYpPYmYIVuA6twHgfCI0irFblosDK+ZiYXuDKKcSmg64/BAbSdP3CFg/TOG
	ySgEh3Hv/cRh+MeLFkhOGL7zlN4i+wM8gfPVkujPiRM5+1xfWvCzvh1uJo8A9BhJ+axmNH
	eDZdjcUZeAG/5BKtUQzDDdp98IUWTBlnb8UsOUII4J5HWoCMeaCJV5Rq4L+C6CjdxB54xG
	3wquu2LgoWrWTW5Fkx9h7edZyBKakJ241JXM2vyyCdyuhWtj05iGLHMSo+GZ5Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  richard@nod.at,  alvinzhou@mxic.com.tw,
  leoyu@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 2/2] mtd: spi-nand: macronix: Add support for read retry
In-Reply-To: <20241114023528.181583-3-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Thu, 14 Nov 2024 10:35:28 +0800")
References: <20241114023528.181583-1-linchengming884@gmail.com>
	<20241114023528.181583-3-linchengming884@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 11:33:49 +0100
Message-ID: <87serozv8y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 14/11/2024 at 10:35:28 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> Add function for supporting read retry:

Add read retry support.

> - Set feature on Special Read for Data Recovery register.

I am sorry this sentence is unclear. Plus there is only a single '-'
which is strange for a list.

>
> The Special Read for Data Recovery operation is enabled by
> Set Feature function.
>
> There are 6 modes for the user to recover the lost data.
>
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Thanks,
Miqu=C3=A8l

