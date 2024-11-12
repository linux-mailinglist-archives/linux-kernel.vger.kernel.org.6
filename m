Return-Path: <linux-kernel+bounces-405884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A59C587C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F0D1F233D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375671369A8;
	Tue, 12 Nov 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukwfhHS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BD433C0;
	Tue, 12 Nov 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416565; cv=none; b=WPqdqLoi+0CEYhAYkmubbTdrIoXo3tazZAcL9ujeh38RKQFxV+sb20n7rYkTXDQEPjxLQ0zYwS8ktJC4QOx6td0CMYpsgcDvOyNTGrdYgSyyYHtam7fp6fKBkhNqq9CrdxgUq4lPrQQVsYCfg2/RJO8pRLp+cGhrCeLjOKttUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416565; c=relaxed/simple;
	bh=C9qhHkdxvMTuRSejox1HHbCUK/S4CWthrHnzCrzr6wA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJaRylHxWx4/txnpfAJwuKsCXOoA2WZmMlDK9HY2UqKnA6/e9a/wBBGbyrEjS/Uj0e15/oCeHJPBpJJIfGdzzQ4BmuNu6bdu4J28Eg6+GC1uTbFru0wMFxDmF/C8zYaiAKKjmtah+Vs+crKCVPYjd6LGc6ZNFIJtYENYKdxhWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukwfhHS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E08C4CECD;
	Tue, 12 Nov 2024 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416565;
	bh=C9qhHkdxvMTuRSejox1HHbCUK/S4CWthrHnzCrzr6wA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ukwfhHS0Y+TX59sqrVKIwZrvE2+rCeaPVPjXHh3+Kjab9Z32uyBwTaZm4xnc/Gpwd
	 8FJ1HiduPliq7Lzgl/BhcbQuJlxh+nTZ6hqYgBgxmZ071PUVk7w4b/9SHfTc3JiDWA
	 6bDBBkji5/nX/00UvzwavQaApE3oVDWTC0sw1F0DH//Q4fXwBRE6u1/YSxbrjywYni
	 4eqxY6Ng/n7KB8GJPeornUeNtR1P9g0tkrVl3r28Pv1jMZS16N6SEUki90oo1zPJAV
	 gV+RuLvpuI8CTcuzUiMI7vFTXX1hbA1e65LeJVeFIzZZ3/S4nK8mzcfOa+k4JXJoUt
	 IDRKSFU3z0x6Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  peng.fan@oss.nxp.com,
  m.felsch@pengutronix.de,  mwalle@kernel.org,  miquel.raynal@bootlin.com,
  richard@nod.at,  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  shawnguo@kernel.org,  s.hauer@pengutronix.de,
  kernel@pengutronix.de,  festevam@gmail.com,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  Peng Fan <peng.fan@nxp.com>
Subject: Re: [RESEND PATCH v4 2/2] mtd: spi-nor: support vcc-supply regulator
In-Reply-To: <7d5dcd4e-967c-4627-92d5-86232492c7e3@linaro.org> (Tudor
	Ambarus's message of "Tue, 12 Nov 2024 07:01:19 +0000")
References: <20241029102238.44673-1-tudor.ambarus@linaro.org>
	<20241029102238.44673-2-tudor.ambarus@linaro.org>
	<mafs0zfm57tsy.fsf@kernel.org>
	<7d5dcd4e-967c-4627-92d5-86232492c7e3@linaro.org>
Date: Tue, 12 Nov 2024 13:02:40 +0000
Message-ID: <mafs0r07g7ggf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 12 2024, Tudor Ambarus wrote:

> On 11/11/24 2:02 PM, Pratyush Yadav wrote:
>> On Tue, Oct 29 2024, Tudor Ambarus wrote:
>> 
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> SPI NOR flashes needs power supply to work properly. The power supply
>>> maybe software controllable per board design. So add the support
>>> for an vcc-supply regulator.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
>>> [ta: move devm_regulator_get_enable() to spi_nor_probe(). Add local dev
>>> variable to avoid dereferences.]
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> 
>> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>> 
>
> thanks, Pratyush. I sent a v5 here, where I introduce the temporary
> variable to struct device in its dedicated patch. Would you mind adding
> the R-b tag there?
> https://lore.kernel.org/linux-mtd/20241111111946.9048-1-tudor.ambarus@linaro.org/

Ah, I missed that in the many emails in by mailbox. Will take a look.

>
> btw, I try to keep patchwork in sync, so you can see the status of
> patches there as well:
>
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=&submitter=&state=&q=spi-nor&archive=&delegate=
>
> Thanks!

-- 
Regards,
Pratyush Yadav

