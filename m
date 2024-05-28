Return-Path: <linux-kernel+bounces-192798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51C8D223F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864E1B23CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1DC174EC2;
	Tue, 28 May 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQXZGMAO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912117332E;
	Tue, 28 May 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916486; cv=none; b=Zna42g9Z3AdY51pjmTH5bGJ6pgjPcKmQlXyksEPCMxAP70PXonrv0UHkQRgswufWIopDJs1YSFlhseqC6i+feq//arn9qNxitXbUZRZcFsQCbsKLkAXdKbBgmyJFRK7Pgjodz/KDXMvI8doDF5Qs6lG93U53PC0cE9c7EBxP3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916486; c=relaxed/simple;
	bh=qyrjilBChXcbabeuPYMmcl4KCvAVqkL8gOwikW3ih3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQJTkmvAOGMKwckfa8xxDL3ZSXh/tGJm5F6xfyJXhW1yq34fHZyG6SSUgO4qrsqAuUseE1e3HMV9U/hSvt9FAOQDYs0OwYeowhi4ySpdd9gVHmBLY5tJfcVOy889EN4lykTRD9BUlHCH55Tbyo0tA7L5Hw+oCJodPL9+AY5j/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQXZGMAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6879C32789;
	Tue, 28 May 2024 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916486;
	bh=qyrjilBChXcbabeuPYMmcl4KCvAVqkL8gOwikW3ih3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQXZGMAOWpmruXCqCzgdqN+FgfpL0xIelwQi6ettbFGm47F9kLaHUFcm2wZTi0TV7
	 R0XKnoXQIaCboVzE7ohGePcLfD01H8kZMOnEK/fkNwTolKh0ENqoilPPD/F6Aj2XkL
	 7sd94QFlMPmltjCQ/1DKassUe8slfYBJ5PtssVIyUihRErPaj6gNFIqqRFdDnn5alz
	 C4pAk+h74bqzVOwxNh8CrrFLcfeGHCQyf5wmEAmODSgjWmG4LOQsVxSiHL4EfA2vrz
	 sBeWkfmY+T9P2vbCxywziaDrQM4+HbyBuMyOq+SeuM9zRZFz7cjbs/dKKvfHzOP8gL
	 YUwu3XQQVtzbA==
Date: Tue, 28 May 2024 12:14:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
Message-ID: <171691641513.1016774.9157485411952411160.robh@kernel.org>
References: <20240528164132.2451685-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164132.2451685-1-maz@kernel.org>


On Tue, 28 May 2024 17:41:32 +0100, Marc Zyngier wrote:
> Commit d976c6f4b32c ("of: property: Add fw_devlink support for
> interrupt-map property") tried to do what it says on the tin,
> but failed on a couple of points:
> 
> - it confuses bytes and cells. Not a huge deal, except when it
>   comes to pointer arithmetic
> 
> - it doesn't really handle anything but interrupt-maps that have
>   their parent #address-cells set to 0
> 
> The combinations of the two leads to some serious fun on my M1
> box, with plenty of WARN-ON() firing all over the shop, and
> amusing values being generated for interrupt specifiers.
> 
> Address both issues so that I can boot my machines again.
> 
> Fixes: d976c6f4b32c ("of: property: Add fw_devlink support for interrupt-map property")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/of/property.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 

Applied, thanks!


