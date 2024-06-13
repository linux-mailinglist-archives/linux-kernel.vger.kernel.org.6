Return-Path: <linux-kernel+bounces-213721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B77B90797E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D64287840
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97914A4C6;
	Thu, 13 Jun 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrwSztuf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A213CF85
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298840; cv=none; b=jMh6inM5bKhrZr8B8NZYCtS2Xy3HSMlORXLGY+a784rXJNOre/EEA/d9gGIG/ukILmUJvx3U+QhGkTpqMc47hB32PhfhEOHdZWR0cNQJH2D3NGlALDDZFKQNPoARSBiFwU5np5n17HIFFl9pxzVLWYXUGIDleJzFMJVtvhiHOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298840; c=relaxed/simple;
	bh=xemkdhPMGacNYdydf3flaCBK3tVRLFLqTB5UykdcJv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCo5SJrKupxaSntPhc6vX1CdW1ApdOYtVjFBa04YhtNU4xbZoJIZJZfO+7J0UeMUxHIu9NLBbo1GFSPBgiNGDrgkCWRRzSIKQc8xNPwWdTFyI17xsqTcf23LUiEXCQ/lPCl+/DUEo2UUS34i8zfroxVWMxqEf/9T3imArydl+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrwSztuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B86AC2BBFC;
	Thu, 13 Jun 2024 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718298840;
	bh=xemkdhPMGacNYdydf3flaCBK3tVRLFLqTB5UykdcJv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrwSztuf2UyF8ICFbnT1JxRDtLAVjD0tVNdIryD0mJ72D1UX++X7EMnzAs4c+vQLj
	 KoYNvh6p8fxQx6qAFTzoyCzZC8+39MhhTGuCidJweBbMOcPqa4vLPBAW0sq1sHLceY
	 Mr1gw8Zl0gsIHveOv/IxqSokdS/rCTNrmxRhFPr5/RgFClew5xRbMKjrwaS96rmdMv
	 lO1da+4mlz7z1rCY9Ty3EnU/4IsPZlk5NA2g9nJ3uZ0eISbQz+jbrlZElAzmXNRuY+
	 QhOqeH0JxqIImh2/ESM16SKf1ykSv/Wp2gjRowhNT7qCGDoe51t5l9qFzZz4wbNFN8
	 ybDsNIAcZfWaA==
Date: Thu, 13 Jun 2024 18:13:56 +0100
From: Lee Jones <lee@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65912: Use devm helper functions to simplify
 probe
Message-ID: <20240613171356.GR2561462@google.com>
References: <20240610153824.218260-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610153824.218260-1-afd@ti.com>

On Mon, 10 Jun 2024, Andrew Davis wrote:

> This simplifies probe and also allows us to remove the remove
> callbacks from the core and interface drivers. Do that here.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/mfd/tps65912-core.c  | 21 +++++++--------------
>  drivers/mfd/tps65912-i2c.c   |  8 --------
>  drivers/mfd/tps65912-spi.c   |  8 --------
>  include/linux/mfd/tps65912.h |  1 -
>  4 files changed, 7 insertions(+), 31 deletions(-)

Doesn't apply.  Please be kind enough to rebase onto the latest Linux
-next and resubmit.

-- 
Lee Jones [李琼斯]

