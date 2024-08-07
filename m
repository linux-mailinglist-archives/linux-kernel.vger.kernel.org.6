Return-Path: <linux-kernel+bounces-277763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04BE94A671
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3221BB2BDFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0471EA0B6;
	Wed,  7 Aug 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQ9ru8tv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C21DF688;
	Wed,  7 Aug 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027407; cv=none; b=DeDs+AITqW2dSSOQEotXVqVixJcHVqGbMdvxIQSYainkCcd9ploDOssNokoqbKgr769BKe/B39lR1cpjH/Lb/fcWuI6RZrOK9HnX3OtXp68hjUcjH7sa7gxWNsGYXgis+basM91PSpws+1xXuNTqvyIn+kkluPk5Fnhr9LWoB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027407; c=relaxed/simple;
	bh=HC/Y/n0iKEk+gLSvVDUxrUtqy4vm76/f73ULGTDYXJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6+e9yhWcCNGOAL5xIpSiF9SLeeVgPHlz6MG4aqbhlfODhNtmlwGs7VV3N2WU+Z+R1pCqfe2ygsRcHTUGHkTxmhOaUJ/JJvDJ5/cSWHZr7+C9I9s+CT0UQ5dqh8KZWQeRs1Cpa7PLpot64OQhb7kfD2TCFA+Ho+7ZPKx4LytK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQ9ru8tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B532AC4AF0E;
	Wed,  7 Aug 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723027407;
	bh=HC/Y/n0iKEk+gLSvVDUxrUtqy4vm76/f73ULGTDYXJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQ9ru8tvqdjWmvqChsSNLF/ne8mvItMA4PDlj56ug4dCemYj4qZCu8jnOokvOXi9D
	 nIAycVIwccIFf2JgPNkTyk9hg+R++Yzi/r2jt9eD4Nlww7hkPH57HPGEMdSg4BbiZ8
	 yiYk8DM+EecTuPTjaXLFyAwqSF5HmAVLpx3Z14lg=
Date: Wed, 7 Aug 2024 12:43:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: mka@chromium.org, javier.carrasco@wolfvision.net,
	macpaul.lin@mediatek.com, jbrunet@baylibre.com,
	stefan.eichenberger@toradex.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v3 1/2] usb: misc: onboard_dev: extend platform data to
 add power on delay field
Message-ID: <2024080751-mule-ladder-cc99@gregkh>
References: <1722440548-107682-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1722440548-107682-2-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722440548-107682-2-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Jul 31, 2024 at 09:12:27PM +0530, Radhey Shyam Pandey wrote:
> Introduce dedicated field 'power_on_delay_us' in onboard platform data
> and update its delay for USB5744 configuration. Hub itself requires some
> delay after reset to get to state where configuration data is going to
> be accepted. Without delay upcoming support for configuration via SMBUS
> is reporting a failure on the first SMBus write.
> 
> i2c 2-002d: error -ENXIO: BYPASS_UDC_SUSPEND bit configuration failed
> 
> Similar delay is likely also required for default configuration but
> because there is enough time (code execution) between reset and usage
> of the hub any issue is not visible but it doesn't mean delay shouldn't
> be reflected.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Suggested-by: Matthias Kaehlcke <mka@chromium.org>

This constant addition of "platform data" seems to be duplicating what
we did before with device tree, right?  Why can't this information be
there instead?

thanks,

greg k-h

