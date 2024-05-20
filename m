Return-Path: <linux-kernel+bounces-183561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13878C9AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CECFB21F11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B736139;
	Mon, 20 May 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TF0f6pns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED724B5B;
	Mon, 20 May 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198353; cv=none; b=OhERLr1AMAlYWIKftGYjR7me0dUG6U774EAYZH6AIRxZiyMSY2dzdFuDJPNt+fN/0RQs50zLOx/FUtSv6saB9KLai4egJEdrSl0XjgrsV2bQpdUc4etZDIB2Y3ysvxOrACxcn8iHFTjGFLwAWOxxFpGvQgN5WNUIEQlsE2xgRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198353; c=relaxed/simple;
	bh=Zdw3Q1wFX6fCgYfdSfW3vPj43L9qIOAEPDK3nk6Nlzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXNME1jxrnOgS/DMH0Dms+ltKohvqO/SMnocP/sWlrgHnbzYjgj9syTyk6jgW7hHA7o0JJ6nL3TtBakNLvciv2+n0s1txx4QxVHVvTn+1hedkFfKEj8muySZPAQ/TR3yGE05UgXR/9kycmOAlIq0GLl0aC/UpzNjd+7EllbzolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TF0f6pns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68295C2BD10;
	Mon, 20 May 2024 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198352;
	bh=Zdw3Q1wFX6fCgYfdSfW3vPj43L9qIOAEPDK3nk6Nlzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TF0f6pns3XbIdT7W5y9eXDZ5S7ibijiJQj0K399dm6EaOxSpxgpag2sU6fH1j+9lY
	 qUOlTEaaBJo66i5j4W8x/Q1MkHw/mV6DyAcxe2BGhk1ADk5nGMhSEL98If5spJ8aT9
	 hEp8zZx62bul4k3Pv+5YikKa3fx8VTLk69jS0fvZkiGR6jN1gUz5nnm7phNr8RX6mI
	 pHfyIFsPjbZPCjqOqYKYy7E6jINTzEVmbf4ICXyn4jdAyaQ1YLtXjLIL6AwsKRjpfs
	 yjBBNKjzeXUKk2eYOi8EK+Pm6gpALhyya0S8E0KZ/oVZl5yEMFi6AGcMuyqrJHYPJR
	 sG96754ebMMRg==
Date: Mon, 20 May 2024 17:45:49 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] platform/chrome: cros_ec_lpc: MEC access can return
 error code
Message-ID: <ZksbzQeR6cDsQz0B@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-2-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515055631.5775-2-ben@jubnut.com>

On Wed, May 15, 2024 at 06:56:26AM +0100, Ben Walsh wrote:
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
[...]
> @@ -116,14 +118,19 @@ static u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
>   * An instance of the read function of struct lpc_driver_ops, used for the
>   * MEC variant of LPC EC.
>   */
> -static u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
> -				     u8 *dest)
> +static int cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
> +				      u8 *dest)
>  {
> -	int in_range = cros_ec_lpc_mec_in_range(offset, length);
> +	int in_range;
>  
> -	if (in_range < 0)
> +	if (length == 0)
>  		return 0;
>  
> +	in_range = cros_ec_lpc_mec_in_range(offset, length);
> +
> +	if (in_range < 0)
> +		return in_range;
> +
>  	return in_range ?
>  		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
>  					 offset - EC_HOST_CMD_REGION0,

The `in_range` change looks irrelevant to the patch.  Or it should rather be
an independent patch if it fixes something.

> @@ -135,14 +142,19 @@ static u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
>   * An instance of the write function of struct lpc_driver_ops, used for the
>   * MEC variant of LPC EC.
>   */
> -static u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
> -				      const u8 *msg)
> +static int cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
> +				       const u8 *msg)
>  {
> -	int in_range = cros_ec_lpc_mec_in_range(offset, length);
> +	int in_range;
>  
> -	if (in_range < 0)
> +	if (length == 0)
>  		return 0;
>  
> +	in_range = cros_ec_lpc_mec_in_range(offset, length);
> +
> +	if (in_range < 0)
> +		return in_range;
> +
>  	return in_range ?
>  		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
>  					 offset - EC_HOST_CMD_REGION0,

Same as above.

> @@ -179,28 +194,41 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
[...]
>  	/* Check result */
> -	msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> +	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> +	if (ret < 0)
> +		goto done;
> +	msg->result = sum;

Even though they are equivalent, `msg->result = ret` looks more intuitive.

> @@ -255,32 +286,47 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
[...]
>  	/* Check result */
> -	msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> +	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
> +	if (ret < 0)
> +		goto done;
> +	msg->result = sum;

Same as above.

