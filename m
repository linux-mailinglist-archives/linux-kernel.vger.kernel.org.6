Return-Path: <linux-kernel+bounces-198896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAA8D7EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D2D289E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0912AAD2;
	Mon,  3 Jun 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNeTQ6Y0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6284DEF;
	Mon,  3 Jun 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407057; cv=none; b=Zt9y4Alg3i+gz9n0rlVIIiP8+Rc1MSpQUZH49F7XjwDS2UHnDCjthCsAOe1YZnV1XH/wHXFX2Rm4AEg6HKU2R/S28IGNSz4+XaRSnX4rQz07IOfgbx5WS1tsZZ8Sd8/G74NjVEML0NlrBvs/kaCOcbFQPVbrWs7n1WFo14S1qsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407057; c=relaxed/simple;
	bh=7WaIuyDOaIPjQkZIh8UwgYDvFQMUAiGRujOm1yfdZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfuBlxwr6nfnxomfqDIVp0o+swb76nzwn2SHPEV3JXGqpczjF+cbTU44JsZUEvfMu/zP9+J1OKJjynvbGJ6kdHrMHXimfpIsjBBb9C8/YQ0p9Ofu5KzI3BwZOtWMXnxHcaD/LVbk9W6Z+P7NKjFR1Fv/XU1cV1+xS5B3vPSOAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNeTQ6Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12CEC32789;
	Mon,  3 Jun 2024 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717407057;
	bh=7WaIuyDOaIPjQkZIh8UwgYDvFQMUAiGRujOm1yfdZ0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNeTQ6Y0hI60gDwpWijPmknCxcxMaFSRk1uAAmTlezvMbXB7k5zO/glqHDaNpGUSc
	 SjLXn0lyyfhUSPlGL0BtZdmTDP0E2fibzT1I+/m4/EcTJwpIVXp1+6Ba4hbkig2vit
	 R2rmfwxEi/otPLZxAt48k6d2K9L4b6eFCGaU16rt/EPell0A9aiOV4NvSfLMdKkT9x
	 W7qZxdCShduffkSN0l6o5TAMMGu+vZDjXZa1VlZUoqseFSmlqabFjVzVApNF5Mj0OE
	 nd34s06wIli8oTHxcL16euW7F6CSVPMNPavpkJLKJld+N5nICQVZz2XvD3ftmsS90y
	 ciOdw+LrZ89bQ==
Date: Mon, 3 Jun 2024 09:30:53 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] platform/chrome: cros_ec_lpc: Add a new quirk for
 ACPI id
Message-ID: <Zl2NTbhk96dhTV2n@google.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-4-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603063834.5580-4-ben@jubnut.com>

On Mon, Jun 03, 2024 at 07:38:32AM +0100, Ben Walsh wrote:
> @@ -436,6 +463,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  
>  	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
>  
> +	adev = ACPI_COMPANION(dev);
> +

The change is irrelevant to the patch.

> @@ -538,7 +577,6 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  	 * Connect a notify handler to process MKBP messages if we have a
>  	 * companion ACPI device.
>  	 */
> -	adev = ACPI_COMPANION(dev);
>  	if (adev) {
>  		status = acpi_install_notify_handler(adev->handle,
>  						     ACPI_ALL_NOTIFY,

See above comment.

