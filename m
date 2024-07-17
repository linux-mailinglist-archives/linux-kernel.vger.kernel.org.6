Return-Path: <linux-kernel+bounces-255598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D59342AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E44281E11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796081822EF;
	Wed, 17 Jul 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD9u/xkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FF28DD1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245118; cv=none; b=hsRekIO2WerKM/pCSKWzYPA3pjWsLhoa/hF9zkCzUUR917/hWiE88I4XnP/F6cccMTgdIvi90BrpIKw4N+lUWb3cbGoDgtJBIXXlljZp/I1xCMEcCpBM3zkWFjPXjE7vYMC+4nYxfIvKcB27JEFPpIoV6hcg6eWY8ipzCS/iPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245118; c=relaxed/simple;
	bh=81NOFCtH51EtoVS2k7EUuY27b0cO9Y8jY8unhH+llsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTN1pcLM/uDCGj4qp/fpwIDL7dgMbs5FEBhZ/gvA660+Ny/vcdQ92knghwkfygLd0a7YfOVbUD0E5Q0R8NWULn+Dffmg5GthAs9y1lcoU22WOSD2xgiYS6oDkwy/XCMsVX6jDVS+0VBcjtxH9rSIfdNwcPPH96Wyq2l5YBBUMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD9u/xkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A870C2BD10;
	Wed, 17 Jul 2024 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721245118;
	bh=81NOFCtH51EtoVS2k7EUuY27b0cO9Y8jY8unhH+llsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qD9u/xkN7TBm3bqzSQLagzRROSxr7PSo7K1jf5+NrT84mQjCZlIAu5X5OcfocNKMM
	 y1KhPNEf2XkJZ5+aBe80LoonznWGNRmp8m60vNIdNW8RPnXrivwTpNkq7KklCr3fsv
	 ohOwIdBFupNP2iGX4b30DPqr7NwH5KQbX85tF7zHaR4X3+tY811Hy+ZP8ZNYkmG7mG
	 TdlLd4pU0B9HmSO5Zk3Wa28+Wg7Nhqh9oyeUv5ya4BB43H6drM2z8WXCHULC6djo6Q
	 jrMBQ58Kf1YhcMhdZs8kk1SRbNB7gttCgxL/nDiMUxvHtGslhIxM63wR/GSwftryMW
	 KChCkbdUFSNBQ==
Message-ID: <1c393235-3bf3-4c89-ab54-42de5a33c8c2@kernel.org>
Date: Wed, 17 Jul 2024 22:38:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] phy: cadence-torrent: add support for three or more
 links using 2 protocols
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
 kishon@kernel.org, p.zabel@pengutronix.de, sjakhade@cadence.com,
 thomas.richard@bootlin.com, theo.lebrun@bootlin.com, robh@kernel.org
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240716102442.1605280-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240716102442.1605280-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/07/2024 13:24, Siddharth Vadapalli wrote:
> The Torrent SERDES can support at most two different protocols (PHY types).
> This only mandates that the device-tree sub-nodes used to represent the
> configuration should describe links with at-most two different protocols.
> 
> The existing implementation however imposes an artificial constraint that
> allows only two links (device-tree sub-nodes). As long as at-most two
> protocols are chosen, using more than two links to describe them in an
> alternating configuration is still a valid configuration of the Torrent
> SERDES.
> 
> A 3-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 => Protocol 1 => Link 1
> Lane 1 => Protocol 1 => Link 1
> Lane 2 => Protocol 2 => Link 2
> Lane 3 => Protocol 1 => Link 3
> 
> A 4-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> Lane 0 => Protocol 1 => Link 1
> Lane 1 => Protocol 2 => Link 2
> Lane 2 => Protocol 1 => Link 3
> Lane 3 => Protocol 2 => Link 4
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

