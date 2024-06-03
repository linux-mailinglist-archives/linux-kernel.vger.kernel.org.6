Return-Path: <linux-kernel+bounces-198902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE5A8D7EF0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9955FB224A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51412D74F;
	Mon,  3 Jun 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxZX9nYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A612D1F1;
	Mon,  3 Jun 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407077; cv=none; b=oVnm1kiz2U77EZE4nbeUF1JOBOcix/jcN/MOWgplIfx/sByU3tTndUqA2jhCc1UT1l0cSwY6tDdmrS7uJJDqX6mcKRQ9/Xcrh8STq6vfLTmF7uJm9/rWhg3jtz5klPKIeemRkKMb47JBKXFMLjuQAcj9HEzkzaysqHnby7WsYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407077; c=relaxed/simple;
	bh=BsLJdnlkFFhzy+R+5F1gs9LZdADpHVjySvSC8PzkZDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDXhy98iihwlFr5Kz6nrNLIN6liQDdnQVOZoYa0whyRQGr2ZjE4/GuggJdiZJeH4qDba9OKA4gxgtluj7gfbEuD+FmWzOTboUZ+FZ63dsLIOSUW7mDnaXw4Mjgmolj/hvKPXjE7+eqZI66ASIqjDqDlQz1a/U4f/ft3onpG0nCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxZX9nYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A01C2BD10;
	Mon,  3 Jun 2024 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717407076;
	bh=BsLJdnlkFFhzy+R+5F1gs9LZdADpHVjySvSC8PzkZDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LxZX9nYT6geBpzdM+OfBR8qWuwkyx+LAtSLqmb1P/t00ELAgLRK7f7YImDOj9gtok
	 ujTqKjxtSZ6t/z44BjM/llo62qWUsH8P2b/RFn9b5oGxSEGDWyG6yNwkcZQvejLdku
	 rdxi4uYBJX0RnUz+OX2h6fV0Ngpr/sqnC32nreBToxITpOYsmoXuXIJgrfbFROaCVP
	 UeS6rIwLMOXKtE1er918iA5gHEG24H5MekUqdwBPXeEJs6MBm/qSgwJAclCaIxsf1K
	 xhmT1r5xyQjHc9mKbmZC3SwWdEk0jlgO1YbK4iXUkLmMzg0h/0qNwlJO2/No+GyyGt
	 2B8hqbFDmrUDw==
Date: Mon, 3 Jun 2024 09:31:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] platform/chrome: cros_ec_lpc: Add a new quirk for
 AML mutex
Message-ID: <Zl2NYTIWtt604WXm@google.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-5-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603063834.5580-5-ben@jubnut.com>

On Mon, Jun 03, 2024 at 07:38:33AM +0100, Ben Walsh wrote:
> @@ -484,6 +492,18 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  			}
>  			ACPI_COMPANION_SET(dev, adev);
>  		}
> +
> +		if (quirks & CROS_EC_LPC_QUIRK_AML_MUTEX) {
> +			const char *name
> +				= driver_data->quirk_aml_mutex_name;
> +			ret = cros_ec_lpc_mec_acpi_mutex(adev, name);

* Assuming the `adev = ACPI_COMPANION(dev);` didn't move in previous patch,
  `adev` here could be uninitialized.

* Also, it shouldn't rely on CROS_EC_LPC_QUIRK_ACPI_ID to set the `adev`.

To keep it simple, I would suggest to use ACPI_COMPANION() instead.

