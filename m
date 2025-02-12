Return-Path: <linux-kernel+bounces-511150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F420A326A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8333A791C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2920E00E;
	Wed, 12 Feb 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ApN3tvVW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFU/+2fm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488F20E021
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365934; cv=none; b=RZMUqcVHnCd65NLTyt1CcDxuTxHW9rX8X2eNpe4amQ9S/I2JvnleK9ZWDzmrpHO5ikqNmyEn0ZHLbPw6BdRg/MFv6uYTRoXCV/ZamA18osbta0HRykf8qNvUFKtaV1Gdoq5aZ0VHEEXmzOq9v7H/vkqXQ83MD6l5q4tr8Rw6wsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365934; c=relaxed/simple;
	bh=mGd4ARVM9vOvCCv/58eUVEQNqdhAq+nr7AUVbyIYiz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxBoCuPyFrB10t2QNkKytX0cV4i6qjyzkI+/JWppbb0mbR8ccKnqM7yWBCoE5XXiiOLRmtdTV8NVXi/nU9s53tLugDBvulPPXjfL5YL2RMEcUUiPXa6aIUglG5Fr2j2mwBKaAvN8mLudVaXXOCerzDsI5i3anWfJMaCBx6yPLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ApN3tvVW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFU/+2fm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Feb 2025 14:12:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739365931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIyafFOGY8KmcJ212hJd6f5zhkJIiu5cyA6Sp6lsU0=;
	b=ApN3tvVW9X5QSH5/JhWR6xVN49+XUM1TfGQERWuQsV8WI9xKhqf5R8PfDbNaJRuQ8ccdQL
	5nNqDAc1SXhJnuI0UZLeFyJbhsyOTt+cWCcIK+rjFUqupIhefukbobSqNIJ+o9//v1FYaH
	ar80IxMGiWClh7trlUoC64OCVGgzGSSaSbxwanYfKgrx5GO4D20+WkQ2USERzvfmPTwi+Y
	YZY4lcNqghAoGr05Ojdj3GBUa8AKInpVNofigVXfQepplmZvERfPqIq+rRO1mIiVDbh8fs
	/WbDw0WMBbAjGBT9yQZARX9pP0iRjuef0ZX1GjXD+XaS1I439p5MKCyy7dXKUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739365931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIyafFOGY8KmcJ212hJd6f5zhkJIiu5cyA6Sp6lsU0=;
	b=UFU/+2fmZqyhS3Ss7QRft2s5hpUh2sNHsfirDYRm5i2hNlt7QP3rVOcqy0mH6JSbngaLxg
	Tkw1n15UbEAtq0Ag==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Remove usage of GFP_DMA
Message-ID: <20250212140412-7a4be486-21ee-4ab8-9371-9f732e92bf7b@linutronix.de>
References: <20250211-cs_dsp-gfp_dma-v1-0-afc346363832@linutronix.de>
 <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e9c1cca-592f-4983-93f4-ab2f76a3c97e@opensource.cirrus.com>

On Tue, Feb 11, 2025 at 05:21:08PM +0000, Richard Fitzgerald wrote:
> On 11/02/2025 5:03 pm, Thomas Weiﬂschuh wrote:
> > Also drop the bounce buffer in cs_dsp_coeff_write_ctrl_raw().
> > 
> > The bounce buffer in cs_dsp_coeff_write_ctrl_raw() could theoretically
> > also be removed. That would be a functional change as the output may be
> > modified in error cases.
> > As I don't know the driver very well I left that part out.
> > 
> > Not tested on real hardware.
> > This came up while porting kunit to mips64.
> > Apparently GFP_DMA does not work there, but IMO the usage of GFP_DMA by
> > cs_dsp is unnecessary in the first place.
> > 
> 
> You're sure that all I2C and SPI bus controllers now handle non-DMA-safe
> buffers correctly?

No, but as mentioned in patch 1, many transfers are done from and to
on-stack buffers and these seem to work.
Anyways, I fixed the DMA zone issue on MIPS in general [0],
feel free to disregard the series.

[0] https://lore.kernel.org/r/20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de
(lore is broken right now, so it will take some time to show up)

> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Thomas Weiﬂschuh (2):
> >        firmware: cs_dsp: Remove usage of GFP_DMA
> >        firmware: cs_dsp: Remove bounce buffer in cs_dsp_coeff_write_ctrl_raw()
> > 
> >   drivers/firmware/cirrus/cs_dsp.c | 15 +++------------
> >   1 file changed, 3 insertions(+), 12 deletions(-)
> > ---
> > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> > change-id: 20250211-cs_dsp-gfp_dma-0581bdd09dd5
> > 
> > Best regards,
> 

