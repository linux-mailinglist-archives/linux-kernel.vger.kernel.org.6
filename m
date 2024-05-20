Return-Path: <linux-kernel+bounces-183562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 571968C9AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5677B21F26
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465D433C2;
	Mon, 20 May 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppRk1q5T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47403F9D5;
	Mon, 20 May 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198374; cv=none; b=UOuZoUFpboR6TFUbQ9mFEEI1qgIpD9yTPxfYrvUsXgMp3tFJsGiXCTs2R3TCinKQjkdJTJSE8UYSPzzKvTpwdfdtjWoorc/uG8kRljX3BSGliV1235WLUanHuhYZC9AgzstSJxTLOj4wnB4oifD56gG8MXKug4r+11gr2Q1wo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198374; c=relaxed/simple;
	bh=CD3m2FyYVSHZBS38YWRS5VaJJDhV0ca02GYxBwY0yz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRkdzjkzH+HPSTPPwh/eOi8qkvgH9SjBCSy+0wdd38g0GUUrszNMiFBc8PNwk1rVKHo8lhz8fJinSbQ+Eb1885ptBVQCI3W34Z7yuphwKLO4bj1NjL4+KGFaFffhtvSHeH9ZNsZpFQJtoWmWd7YM0uwMQ9DtpqARanWME9yXJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppRk1q5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A0C2BD10;
	Mon, 20 May 2024 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198374;
	bh=CD3m2FyYVSHZBS38YWRS5VaJJDhV0ca02GYxBwY0yz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppRk1q5TcZHo28GUlKxf2Wu3Lk0loPbLNnBYXtIxQzE3xR+cKoG54d7xubyRGno8O
	 WiBSAqr5foCmcJVuT0B8Shp2PzDXfKGuYPYlRTz6lH8QPNCULFRj5qGtXbd+Fbn6Gb
	 aIZuTSKn/mJM/mZcDaTUYzXWjrJY/0wRNCVuVIaT7Jdvwld0xeFVwcNXwBGQVpvClu
	 Yzoh8nYBf92OJeIjI9+M6tjt5BkZm0R2boCRU/9UFbmDJczBiLQfwyvIhqEC6wsXYQ
	 f49XjWW5Zj6eEaf5PSknTvg3deRldgXAwowJSpxRvF5/kwsLPiDexfOAOiju2SSlju
	 z1Qvxg8uaiugQ==
Date: Mon, 20 May 2024 17:46:11 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] platform/chrome: cros_ec_lpc: MEC access can use an
 AML mutex
Message-ID: <Zksb4xB5wpxCQYtC@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-3-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515055631.5775-3-ben@jubnut.com>

On Wed, May 15, 2024 at 06:56:27AM +0100, Ben Walsh wrote:
> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
[...]
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
> +	if (!success) {
> +		pr_info("%s failed.", __func__);
> +		return -EBUSY;

I guess it doesn't need to print anything as the -EBUSY should be propagated
correctly now.

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
> +	if (!success) {
> +		pr_err("%s failed.", __func__);
> +		return -EBUSY;

Same here.

