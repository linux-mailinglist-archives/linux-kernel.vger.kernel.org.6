Return-Path: <linux-kernel+bounces-191042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDEA8D05DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E091F23349
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7906155C99;
	Mon, 27 May 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5Chba/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0C155CB7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822609; cv=none; b=TpzPVDcCqyMQWklvhnEsMkB4uIQMFAH/O4IQtVE7Mwnnl9gvgpHrCI1c82JeAed9CCncE+MYqfGcmF5sMpbV16z2mz3hsjinTispo9MZygzWEnFAWwNk5x1AA5b81QJLBoVR/VYGL9p2IOVs475Jxualgr1YcAMQtPx80PFdams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822609; c=relaxed/simple;
	bh=sdNsUq7qXOGLNdRoGeJa7Z8iN50W37caPaVat1Wq8dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c161PC1xw//vRlWQmTIhCWLdlVWw6MFHIQ+iwGwIJ4NOaJnTyQu1QwQ4OEsX3Al1UbpzAEVfpOm+BBDgfJM2ZBa0w2ND4ET8LIwKESqLPV3k+IXq/mGrOzh+hPq+mbNIrRcPB2b1O+8MbQxcBoPTA4soDWR3HESkZhS8QxgU28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5Chba/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DF7C2BBFC;
	Mon, 27 May 2024 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716822608;
	bh=sdNsUq7qXOGLNdRoGeJa7Z8iN50W37caPaVat1Wq8dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T5Chba/DsKtB27gbJecQgoGceITl1i79HMLtL/S7owPcxnHrVxM2JrHxV8VvlnayY
	 oaHF6lYpduPTAhDOCcQWKzAuc7r6/sz+H0usUi9Osv0FVAZjbMB2+ezcFZ0UFZtO3I
	 lgsj1mACQ+h3OtGjpQjxxwC5hAAKlS96ogzFD02IRyhI7QW7nrV0Xg4AdFf005p0V9
	 kODuzGU0rCdsk1+FvFsAfYUknyVlcnREEa8TKmpIJJKKEUZXO2HSUIMr1PaaPU8Yts
	 +C1ebZMPfXb+EBpAd7+enup0xtlIO1+kAMHka+qlqQwE919b5oZARMASSIK7Vss9z6
	 W+rX9MgkzxOwg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Ricardo Ribalda <ribalda@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 0/6] mtd: spi-nor: spring cleaning
In-Reply-To: <20240419141249.609534-1-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 19 Apr 2024 16:12:43 +0200")
References: <20240419141249.609534-1-mwalle@kernel.org>
Date: Mon, 27 May 2024 17:10:06 +0200
Message-ID: <mafs0plt71eb5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Michael,

On Fri, Apr 19 2024, Michael Walle wrote:

[...]

Applied the below 4 patches with minor fixups mentioned below. Since
v6.10-rc1 just came out yesterday, this should let the S3AN flash
removal get plenty of time to cook in linux-next, and give people chance
to notice any breakages.

>   mtd: spi-nor: Remove support for Xilinx S3AN flashes
>   mtd: spi-nor: get rid of non-power-of-2 page size handling

Touched up commit message a bit.

>   mtd: spi-nor: remove .setup() callback
>   mtd: spi-nor: get rid of SPI_NOR_NO_FR

s/evervision/everspin/g both in code and commit message.

These 2 patches need rework:

>   mtd: spi-nor: simplify spi_nor_get_flash_info()

This one has some comments from Tudor. I don't think those are big
blockers, but at the same time I don't think this patch needs too much
time to cook in linux-next anyway. So I will wait for a respin.

>   mtd: spi-nor: introduce support for displaying deprecation message

Same for this one. I will wait for a respin with some actual
deprecations.

Thanks for working on this!

[...]

-- 
Regards,
Pratyush Yadav

