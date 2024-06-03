Return-Path: <linux-kernel+bounces-198895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9325E8D7EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470841F2841C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11584D27;
	Mon,  3 Jun 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtODyGZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E56495CC;
	Mon,  3 Jun 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407043; cv=none; b=AwHmmg5KUbg9MHwQp9vTh5Jdo7WwJgqpG7OwpNZoZuACcWoUNJhV3l4WiSjZf6FqHPX3p8zfhXeQtk3+C7GFeU5FQJLmpLONL4IrzQG2aKobHOMqhhW2fmKccEwoDw683Fn2kT37vjM1WOMkRsizPuDVF55fNmlks2cHPTIERJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407043; c=relaxed/simple;
	bh=aCGmBQnn9jMgxSZQN1wU1R72pqs7jsx6KoIKykMgu/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG2j106V9f6Qwq/uOiRvUgPml+mCBF19q9zUusiC7tRLvTQx+BMHiUgdZavKQTNhhxhmzytOAQ+G37qtszIpf0+mkMh05iWbmfYlof75SUdNQ3qhj5+B4M3QEN0VqTezkE+bY6LTOQoIWP5ND4UHIjN39Hd5hTq821a5Hguw6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtODyGZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D726C2BD10;
	Mon,  3 Jun 2024 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717407042;
	bh=aCGmBQnn9jMgxSZQN1wU1R72pqs7jsx6KoIKykMgu/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtODyGZQxKGzr1cEYY8M9WJlBRx+T2hidXuOzT0+QrXSTe7ub7fuhPZbbOWb0e3ee
	 bmTg/gboJiyNWHFy5wjKYZr7HHOdRtsHJUyCLi7p2E6Bi4TbpA+c7GmTP9pXHlDNy4
	 mViza5URWH9RPz9wQe/GKMg+h1VChmSFfJJfbBmYRac3Ii80TRzc2B+K8rJLG6Kdsw
	 ypUzQY+0IN4H0fZz0xJagYMuT3yjtdwrYCZwwYiu9swKEGOqb804sx+JtZSBLa8+LY
	 HB/TcaTmLDsaOHgrjemCACwTaOg1M+JhdrHzweEH4nsvKg68IeAjbGhevFDnTmDCOf
	 WT8283ptzJ9jA==
Date: Mon, 3 Jun 2024 09:30:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] platform/chrome: cros_ec_lpc: MEC access can use
 an AML mutex
Message-ID: <Zl2NP9l9dfJ0EPln@google.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-3-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603063834.5580-3-ben@jubnut.com>

On Mon, Jun 03, 2024 at 07:38:31AM +0100, Ben Walsh wrote:
> +static int cros_ec_lpc_mec_lock(void)
> +{
> +	bool success;
> +
> +	if (!aml_mutex) {
> +		mutex_lock(&io_mutex);
> +		return 0;
> +	}
> +
> +	success = ACPI_SUCCESS(acpi_acquire_mutex(aml_mutex,
> +						  NULL, ACPI_LOCK_DELAY_MS));
> +

The blank line can be dropped.  It's up to you.

> +static int cros_ec_lpc_mec_unlock(void)
> +{
> +	bool success;
> +
> +	if (!aml_mutex) {
> +		mutex_unlock(&io_mutex);
> +		return 0;
> +	}
> +
> +	success = ACPI_SUCCESS(acpi_release_mutex(aml_mutex, NULL));
> +

Same here.

