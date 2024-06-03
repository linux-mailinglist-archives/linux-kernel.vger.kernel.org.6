Return-Path: <linux-kernel+bounces-198893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CB8D7ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB752886D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808784A46;
	Mon,  3 Jun 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV4RLdNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F612838F;
	Mon,  3 Jun 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407028; cv=none; b=sXRXyNBFhhrSMVoS2hN+BAP3L+mb7m/zaZ0XuRC7++2wxU7r6yZmrx3lqKx0kv//HJfP0DTQjDFIhja6OyXtPWb4ZMj9NN16/WyYBQOlFXp0Pe96vtaWZF8B3MG/y4whCOLc8FgLj/U8TC/UJorCHVe9qCyBcFnmGztTB735Tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407028; c=relaxed/simple;
	bh=gyTvuIXkHMDKkIYNWRrOLwBVU/NHyELF/9o9YnpdpQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnSdIs5juPiD0b5ao8TldjIh/E0F8uRGY/epo9NyhoNCSC2Au1lpB3tz4etSnhDu369BilhbH5y0Ewhm7xut36mdBV0Qb1TxQWSlouXNiissD+c3miAeGI9fdmsYQTPvVIUizybrxRZw4EWh9mVo5hbS6xI+GmwIpU5jDYAynYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV4RLdNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D975FC2BD10;
	Mon,  3 Jun 2024 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717407028;
	bh=gyTvuIXkHMDKkIYNWRrOLwBVU/NHyELF/9o9YnpdpQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GV4RLdNEe1Mg/g2Pcx5NAUep8ndltG+agPssIFjYkSkagmw206unOhFePjhotcvu4
	 liPqPZfE0KHfUEt2Md8DBITrZdMrmEznQp2Kul9WgT6x4kmakJBKGhYDUzQOox84B1
	 KD+5thwq1Hv968Wr0ZqKzggGluqm4JXHjHL0uZAXPjwI5vWi86MEZbGwhBJGzbCyXf
	 RG0AEB0ft1iQRIA0f703VuHWzhXo+uU92aB474OpQLsiv1atonMyN3o0vI+9iKCSAH
	 TEYT5G8AV4nzZWJrBpsLN1CO+YSuLUeMZ2G0/12GSYeY2kEM3grWY6uMMPa3MsRsgk
	 pIvR+n6o7mp6A==
Date: Mon, 3 Jun 2024 09:30:24 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] platform/chrome: cros_ec_lpc: MEC access can
 return error code
Message-ID: <Zl2NMG3NdQHPfe7s@google.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-2-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603063834.5580-2-ben@jubnut.com>

On Mon, Jun 03, 2024 at 07:38:30AM +0100, Ben Walsh wrote:
> @@ -425,8 +469,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  	 */
>  	cros_ec_lpc_ops.read = cros_ec_lpc_mec_read_bytes;
>  	cros_ec_lpc_ops.write = cros_ec_lpc_mec_write_bytes;
> -	cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
> -	if (buf[0] != 'E' || buf[1] != 'C') {
> +	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
> +	if (ret < 0 || buf[0] != 'E' || buf[1] != 'C') {

Slight concern: if the read failed (-EBUSY, because of the lock contention
failed for example), does it still need to probe for non-MEC devices?

> @@ -436,9 +480,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  		/* Re-assign read/write operations for the non MEC variant */
>  		cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
>  		cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
> -		cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + EC_MEMMAP_ID, 2,
> -				     buf);
> -		if (buf[0] != 'E' || buf[1] != 'C') {
> +		ret = cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + EC_MEMMAP_ID, 2,
> +					   buf);
> +		if (ret < 0 || buf[0] != 'E' || buf[1] != 'C') {
>  			dev_err(dev, "EC ID not detected\n");
>  			return -ENODEV;

Similar concern here: should `ret < 0` see as a -ENODEV?

