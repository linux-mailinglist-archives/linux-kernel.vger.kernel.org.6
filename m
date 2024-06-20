Return-Path: <linux-kernel+bounces-222362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B2910056
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6538C1F24359
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5251A00FD;
	Thu, 20 Jun 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWxd0eGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B891A00D5;
	Thu, 20 Jun 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875678; cv=none; b=iNrpTvVZD6jjQvlw7Q5TbuPkTvevo0yGkPXpnvCpbff2BXD6y6g4OlHCh5n4RviQnp0KJQSIQeNqnck9QITyxmFjeHAi9uoUg/Q/lRDEfLKzHKIjA3eehfH6ANF7lu50aO5xm6keJ9YB3KnAXLPxsleyDzSca5WZzfWiBxhnN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875678; c=relaxed/simple;
	bh=gLGoNiZ1NnwdYdGmQeEAfKPcxmeNXMgy1V7sgUYNc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLFfYGKK1pZxBqkTWM9XvnwmpP4fojXMr5R81GNcoAyNyvPyFL21Gw7NfxkiyIH/QOuFiu1LnfjmTFKVhg2qtB1LH9o/nqse57/9QKvQhvpVB+n6q84CACo2H5zhbUWCJIl8HAhmDQaf8JPoNVTYfvWBojiihBEWuLBPTnSVie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWxd0eGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E669C2BD10;
	Thu, 20 Jun 2024 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718875677;
	bh=gLGoNiZ1NnwdYdGmQeEAfKPcxmeNXMgy1V7sgUYNc1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWxd0eGNkh621/xvmrPwfD2uLXwGsyMnGM9CzJV+L41kqwgMXj+Yx/z8KC9URR5AX
	 ZGEN7bDj3OgQf1TgKu8kcnxi7nD4T4l8LTmZsXlRMQhU58sA+784j8QVLQjUR+UqGK
	 RzgrNCfpmpcF6un6PXc35vdC12y4P9RnnwTOnVIJiyxiV2bGNjzL0tZPzQNrQ4cY2j
	 bVxTTUh4yvrDS6o0nYDawYzsbKbNPDvSaHO+OVRT5iVMFJ0lvEDvBRriZJySqodMdi
	 FFnv5zCpNmuff6wbaYbTiNvQnXP19oIdT2pvcBsAostx8Gah2R9CTIyvj72338N/g9
	 +fag7uTLNLlvg==
Date: Thu, 20 Jun 2024 10:27:53 +0100
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH v3] mfd: axp20x: AXP717: Fix missing IRQ status registers
 range
Message-ID: <20240620092753.GG3029315@google.com>
References: <20240613233104.17529-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613233104.17529-1-andre.przywara@arm.com>

On Fri, 14 Jun 2024, Andre Przywara wrote:

> While we list the "IRQ status *and acknowledge*" registers as volatile
> in the MFD description, they are missing from the writable range array,
> so acknowledging any interrupts was met with an -EIO error.
> This error propagates up, leading to the whole AXP717 driver failing to
> probe, which is fatal to most systems using this PMIC, since most
> peripherals refer one of the PMIC voltage rails.
> This wasn't noticed on the initial submission, since the interrupt was
> completely missing at this point, but the DTs now merged describe the
> interrupt, creating the problem.
> 
> Add the five registers that hold those bits to the writable array.
> 
> This fixes the boot on the Anbernic systems using the AXP717 PMIC.
> 
> Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
> Reported-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> the patch itself is unchanged from v2 sent in April, but the commit
> message was updated to give rationale for the Fixes: tag.
> Please take this as a fix into v6.10.
> 
> Thanks,
> Andre
> 
>  drivers/mfd/axp20x.c | 1 +
>  1 file changed, 1 insertion(+)

Submitted to Linus today.

-- 
Lee Jones [李琼斯]

