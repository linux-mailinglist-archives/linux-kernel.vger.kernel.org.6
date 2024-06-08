Return-Path: <linux-kernel+bounces-206999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FAB90112C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E8E1C20E51
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCB6176FAE;
	Sat,  8 Jun 2024 09:44:57 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2F25740
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717839896; cv=none; b=iQfM8/3RP+oLmN1OH/DiCY1W7087BRQAs1hnHKg0MMsD4qJSegFL3M8Mz0d9ttYtoZs0cMYqG8vpDzmE/JAQO/F8ufHCyW75zOLNU3dpC8OiQb+A1v0cjk5e5tWVg04Ful9UJIjw5C+Q5B9tmUZxbNHtcpo6X5U2Bq0h1m6QvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717839896; c=relaxed/simple;
	bh=540A8R/1TpIFNPJ/N/OR1orqd1BnHCt4N1sRFu3by+o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbvBd30MykpDzmmw+uY2nxelUSa4gbAqDRwhGRkNsa0OEiAgINkQ86UJ41bgm8Z4EGGWfSBtIWJ+o2CK4V70ixRN65OH3uFolRXyzXWxltIBuY3zvTVSVQ/Wwubhb1RpTsNfwDTwYdWwBSyfV3SJ1OV0UGJHkcZOKByJCd61B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id bbaf993f-257b-11ef-80e2-005056bdfda7;
	Sat, 08 Jun 2024 12:44:46 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:44:43 +0300
To: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: pca953x: Improve interrupt support
Message-ID: <ZmQoCwLFuJNyuRG6@surfacebook.localdomain>
References: <20240606033102.2271916-1-mark.tomlinson@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606033102.2271916-1-mark.tomlinson@alliedtelesis.co.nz>

Thu, Jun 06, 2024 at 03:31:02PM +1200, Mark Tomlinson kirjoitti:
> The GPIO drivers with latch interrupt support (typically types starting
> with PCAL) have interrupt status registers to determine which particular
> inputs have caused an interrupt. Unfortunately there is no atomic
> operation to read these registers and clear the interrupt. Clearing the
> interrupt is done by reading the input registers.

What you are describing sounds to me like the case without latch enabled.
Can you elaborate a bit more?

> The code was reading the interrupt status registers, and then reading
> the input registers. If an input changed between these two events it was
> lost.

I don't see how. If there is a short pulse or a series of pulses between
interrupt latching and input reading, the second+ will be lost in any case.
This is HW limitation as far as I can see.

> The solution in this patch is to revert to the non-latch version of
> code, i.e. remembering the previous input status, and looking for the
> changes. This system results in no more I2C transfers, so is no slower.
> The latch property of the device still means interrupts will still be
> noticed if the input changes back to its initial state.

Again, can you elaborate? Is it a real use case? If so, can you provide the
chart of the pin sginalling against the time line and depict where the problem
is?

-- 
With Best Regards,
Andy Shevchenko



