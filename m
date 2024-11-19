Return-Path: <linux-kernel+bounces-413691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794D9D1D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A191F2231E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA51CA84;
	Tue, 19 Nov 2024 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="asGMpDZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB67A935
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979504; cv=none; b=E4oz4khGZZhVhFVkgj/Yl+4I5+knR5tHdzGY7CbBVfuSfebddHFTODi+swhIuRRXBSj4iOXf7gG2dRZUF3sXgC41YvCTwOhI1SFYf+gbYicaJergE1i+yqlBiOot7bAkQ1+MndMSnSHQ3IZlQi8mWGUGb3uN/KwgPRmVduwQDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979504; c=relaxed/simple;
	bh=SgaXwAE6BFFmMas8q94/D06/PqnJOVIDyoiP3RnS/mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAV/5/01DPMXNwWD/9WwXmJnf+o0Jf2xUm417BJzKdI+K4oodkvTcT23mVGYGz0ySV7xZCZvCmdRkEWPWao4wkxsTVIAHe6twpmG6e62hl7kFzZg5JVqLf98VcZsw0g/lM9wQO1aCajDIRG3UGrDpsxXyLLcEmmIV00DmEk0sWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=asGMpDZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F53BC4CECC;
	Tue, 19 Nov 2024 01:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731979504;
	bh=SgaXwAE6BFFmMas8q94/D06/PqnJOVIDyoiP3RnS/mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asGMpDZ+b57/ogiXbJOdv3amVsLM9ZsTOJkmA9pYHIo0u8ACngRyvGysOnLPV8OR2
	 tA/gNZusZ1KMyQrp/GtIM4M4dawENjNVjm7pMrdnPbIKn3lVnmhgv9jES5eNM9G7HI
	 GlZwp69cx74VmOD0RSut1OMQJQ83oAqJcmA8qBVk=
Date: Tue, 19 Nov 2024 02:24:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers/card_reader/rtsx_usb: Restore interrupt based
 detection
Message-ID: <2024111917-anyplace-mop-47b2@gregkh>
References: <20241118195201.39007-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118195201.39007-1-sean@starlabs.systems>

On Mon, Nov 18, 2024 at 07:52:01PM +0000, Sean Rhodes wrote:
> This commit reintroduces interrupt-based card detection previously
> used in the rts5139 driver. This functionality was removed in commit
> 00d8521dcd23 ("staging: remove rts5139 driver code").
> 
> Reintroducing this mechanism fixes presence detection for certain card
> readers, which with the current driver, will taken approximately 20
> seconds to enter S3 as `mmc_rescan` has to be frozen.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/misc/cardreader/rtsx_usb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

So this fixes the referenced commit?  If so, shouldn't that get a Fixes:
tag and cc: stable if needed?

thanks,

greg k-h

