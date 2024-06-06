Return-Path: <linux-kernel+bounces-203567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 105FF8FDD36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AD3B2409C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B51DFEB;
	Thu,  6 Jun 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCEkjqvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63CC13C;
	Thu,  6 Jun 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643581; cv=none; b=gt53KqrJb4mfPExkxFJYeW4UpEGocmJq1p6qYOiuSjkV8k5PE+maE6b0acd4DD25h3Ut9sk9sdAoMQ8WUSjMg7SUZWdCr9WTv9v1tFGRm3b2uYgYxkJizrlSXT6zPO7x8slenliME/g09HE8ZZJSrVHkMu+bdR7uMDlPCvIYAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643581; c=relaxed/simple;
	bh=A6CHI3Qk5QNcWjNxDFXqY9sSiqdoBBmohvQrhSQuAAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXibJxO1kTjh4LfPneTFf82iqVYAdtgEStjOCSzDFOdO/UMH0C7Oncywka3axusvypgAPO7vHw7wP/loK7ixHLkT21PAWULgkqZe5xLVE2Lmm1a0+ibqXhQ0iPcr9YtwDdx/3zlegBUJa6yZJaze9l1OfiorvTYkHiq80euP+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCEkjqvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B96C3277B;
	Thu,  6 Jun 2024 03:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717643581;
	bh=A6CHI3Qk5QNcWjNxDFXqY9sSiqdoBBmohvQrhSQuAAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCEkjqvuGUzznIxy/QhFcx3h2H8X+LSku+NZPjrgaVKkvK31K/Ez5eo5R2SOgAKUw
	 9FuGKqnzeWRHdy/ADs5mTcjV1K4fnub+7sTAOJxHVFSKtfcIFMKyfKZofkd1rM368+
	 evPTba0++zwTbyV0o7c2RlFfY3oDUXi+C+7eM60bDEEtlyfM8n9hUNACY8Pwl+9E1+
	 0wisKgv4zko2HEL07mKNht8ksgWShVXczHMTbG6fcfoS0eSADvNsWjE8Qi6oBBkrdK
	 +pucy8oTZ6mtbiTX0syK2FqK9A0jt+apNYk0LmOBF8JDGvUxsgfiI7GnQ9N5cMlMY7
	 dTa7J9NydymOg==
Date: Thu, 6 Jun 2024 03:12:57 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] platform/chrome: cros_ec_lpc: MEC access can use
 an AML mutex
Message-ID: <ZmEpOQmzFv7Quakq@google.com>
References: <20240605063351.14836-1-ben@jubnut.com>
 <20240605063351.14836-3-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605063351.14836-3-ben@jubnut.com>

On Wed, Jun 05, 2024 at 07:33:48AM +0100, Ben Walsh wrote:
> @@ -93,7 +146,9 @@ int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>  	else
>  		access = ACCESS_TYPE_LONG_AUTO_INCREMENT;
>  
> -	mutex_lock(&io_mutex);
> +	ret = cros_ec_lpc_mec_lock();
> +	if (ret)
> +		return ret;
>  
>  	/* Initialize I/O at desired address */
>  	cros_ec_lpc_mec_emi_write_address(offset, access);
> @@ -135,7 +190,9 @@ int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>  	}
>  
>  done:
> -	mutex_unlock(&io_mutex);
> +	ret = cros_ec_lpc_mec_unlock();
> +	if (ret < 0)
> +		return ret;

A nit haven't caught in previous round review:

- `if (ret)` for cros_ec_lpc_mec_lock().
- `if (ret < 0)` for cros_ec_lpc_mec_unlock().

If I see the inconsistency when reading the code, it would take me further
cycles for seeking why.  We should fix it.

No need to resend for this; I will fix it for you.

