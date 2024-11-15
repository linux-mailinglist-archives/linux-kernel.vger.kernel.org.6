Return-Path: <linux-kernel+bounces-411255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AAA9CF540
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200DEB2ACED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBED1E1C1A;
	Fri, 15 Nov 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bh0o2tXC"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7A1AF0CE;
	Fri, 15 Nov 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700102; cv=none; b=nOI4QlqIDKmq0yUPq0odCeMQ69dtydnwX8NJjnVuFmcGNvykPE9X3bqHqA6tV56H9OF5aAuzkFmawPLqcpfvGH/qvIMr+YyJ7GhXWTA/cQk7CItGJXxuy4dLoDZoUZKAuksIlEoPAiwXWuyTt6tyTw3fobcViD8bcpWwx6eWY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700102; c=relaxed/simple;
	bh=zidj6aK4ZzZS5mK+WBisxr8dK9UXKfKqNFz5dL1Vybo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmF6TfWpBMsHo0244CaiCOtllis7GFtQDUfLNe9RRmaYy4xp9L45WpTt+Y/fa4SSXgHnl+E4YxXFeICjfh4DQT5cVKjQvUgxAVFLk491DNCz0psnT0Py0k45NoqTS/iOvWp3+pqjZQte0sKU/VZiD6Q4jTzXJFO92HhJbkjUTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bh0o2tXC; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E5991C0005;
	Fri, 15 Nov 2024 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731700091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zidj6aK4ZzZS5mK+WBisxr8dK9UXKfKqNFz5dL1Vybo=;
	b=Bh0o2tXCaWlJ/kPdhW1p2kKgtneIYHjFijVrY4kE+oazMUmXua9ga6YDQywPhiQ3Q2VmnW
	d8ybYCDwQ1i0eNlHJJhq8YADAvFgYVvelvoNuzs7fK9yND5+9W0YEsDkHgijWy4OcfSOBA
	njdAdj7GTBJiOlWh7uIPSWl3fnzYV067iP6TE3J92yft64lkSnfYbZGy+PMkLdnyn9IS0g
	hcDApdX2+LxmbSrQ/8Q8guKFKTULDGqQFYC/ruetmm9o7yyodz+qVNx/6yf6w+dehqDLtT
	GH3VLkvdQQ833m5bu6ohnQLyLkNBUsdLmBQRDyBMn7ZWsrsoolnW0m4tWJvINw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
In-Reply-To: <ZzcL53TmSOwTuIFM@gmail.com> (Marcus Folkesson's message of "Fri,
	15 Nov 2024 09:52:55 +0100")
References: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
	<20241107-ondie-v7-1-98829fc8a958@gmail.com>
	<ZzcL53TmSOwTuIFM@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 15 Nov 2024 20:48:09 +0100
Message-ID: <871pzcnurq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 15/11/2024 at 09:52:55 +01, Marcus Folkesson <marcus.folkesson@gmail.com=
> wrote:

> On Thu, Nov 07, 2024 at 02:47:07PM +0100, Marcus Folkesson wrote:
>> Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
>> Add "on-die" as ECC engine type in order to be compatible with those.
>>=20
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> ---
>
> Can someone please take a look at this patch?

Well, it's v7, so I believe we've given attention to this
patchset :-) Also, please consider 2 weeks as a better delay for pings.

It is flagged "okay" on my side, but will only be applied after -rc1
unless I get negative feedback about it in the mean time.

Thanks,
Miqu=C3=A8l

