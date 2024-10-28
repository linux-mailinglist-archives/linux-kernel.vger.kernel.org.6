Return-Path: <linux-kernel+bounces-384543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6979B2B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D992825A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CBD18800D;
	Mon, 28 Oct 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LT/RDKkX"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464E762E0;
	Mon, 28 Oct 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107906; cv=none; b=ZKW/mJgn74N3ypuWRIKS7+AJXhNyGzIH92ZbP6UIt+jFqj97fUNF7yFrlqyRAd8IXsMJWfIVv9it8tHzV6lDlmTQE58X1t6xNPXXRz6SX1eXQWnnv71zdlEMXXBASYKAxm58Qg9g/pdtSm5o4iCPXygpLXMQJozmXjONziEY7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107906; c=relaxed/simple;
	bh=GHjYaCqpDy5MUxpTA8+UK4KZFKM1KDzO734VKuAQA48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvwZ1SUeVpL0NsiZ/sUkyZXV0Or5teAh5kfvwhL1U/FKBFNBxwEkyL+A72++ImwOEW638LbpkiiQ54j6c5FOq8jD8n4O01DDgYKfRkobOI6VVUTCwZv4HLikD9ObGXt5UMVCQVrDWKJ+DoNvvmsYSAfm31H4f7M/2N0L86Qv6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LT/RDKkX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9218E60004;
	Mon, 28 Oct 2024 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730107895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlV6UCm7hBRqZrCbCmEQWq0Im41fGPv7HTBeS70SPZI=;
	b=LT/RDKkXLooxV3gR0MSD37lefbdj4oGIsqxAvDpIzsmLHNUUaGWg1VuYc7DQQutSdgcdwm
	nbPDgmdxo6JDrjkq6LQXG7vBHEMGVxmgBvDFo1CMkgyJacIkwCV7RJ6aFO/qK8ofqGgd3r
	3P2KU7wuwaco180J0U8dCj26NK+kXcqTNRJa9uVsGk6HWUjTe1UwK+RRutCMChzkagZrkh
	iyEfthBuNybUUvFifPfoQwsv+TfDgoHsNNw98OUC7uQWuwGub3r56JRGChVRPndEPGqhDu
	60hXhnB67UhpYvgSOC2Ffyb+ts99drS6rFVvbxkloakzTglNFSOx32IXSRCJyw==
Message-ID: <09e7baa9-8715-4f9c-924b-3e782dd3196f@bootlin.com>
Date: Mon, 28 Oct 2024 10:31:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: cgbc-core: Fix error handling paths in
 cgbc_init_device()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <24ec1348b99e76a853435ab081ae9a8f0e51fd52.1729938747.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <24ec1348b99e76a853435ab081ae9a8f0e51fd52.1729938747.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

Hello Christophe,

On 10/26/24 12:32, Christophe JAILLET wrote:
> If an error occurs after a cgbc_session_request() call, it should be
> balanced by a corresponding cgbc_session_release(), as already done in the
> remove function.
> 
> Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/mfd/cgbc-core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> index 93004a6b29c1..7771d010eb2e 100644
> --- a/drivers/mfd/cgbc-core.c
> +++ b/drivers/mfd/cgbc-core.c
> @@ -321,9 +321,19 @@ static int cgbc_init_device(struct cgbc_device_data *cgbc)
>  
>  	ret = cgbc_get_version(cgbc);
>  	if (ret)
> -		return ret;
> +		goto release_session;
> +
> +	ret = mfd_add_devices(cgbc->dev, -1, cgbc_devs, ARRAY_SIZE(cgbc_devs),
> +			      NULL, 0, NULL);
> +	if (ret)
> +		goto release_session;
> +
> +	return 0;
> +
> +release_session:
> +	cgbc_session_release(cgbc);
> +	return ret;
>  
> -	return mfd_add_devices(cgbc->dev, -1, cgbc_devs, ARRAY_SIZE(cgbc_devs), NULL, 0, NULL);
>  }

nitpick: useless blank line before the close brace.

Reviewed-by: Thomas Richard <thomas.richard@bootlin.com>

Regards,

Thomas



