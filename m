Return-Path: <linux-kernel+bounces-269180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF24E942EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E44628733C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A61AE868;
	Wed, 31 Jul 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cS9EDuNb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0E1AD9E2;
	Wed, 31 Jul 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429880; cv=none; b=XYpuIE7tU07YOTXqELmrePkdKzc8FykcEHoYDXrtrcpXo8j2wgm2gFHA620hpdoCovk0P3n9nKEayyeZwNw+Qve+6osJdTHPMH8dZuKw1GfnQNex/cqrHbYArP6ZkcMmJogaLVyCfrv9qBRHfSpRrshUw4ux8htpg7mdhEShSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429880; c=relaxed/simple;
	bh=Cwz+QtLftS/QkuafeTQUXUhEuELNtJHVS/tIfm+Fg8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BclPCIw34XRaB7Z5Gs4h4F8PFfjaZ+wgvvVDAzEgVdL5IehgXTXVHXcihha3/swJxFiTxSUmLMVOOzPG2/gcx0Peyuldje0N1KfHNXyHgyCyYuABHxFGcWCztyvGDzWa6h8tmRZksX2ib72PEcw3104nfHTMiULybO3zwtOBi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cS9EDuNb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722429879; x=1753965879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cwz+QtLftS/QkuafeTQUXUhEuELNtJHVS/tIfm+Fg8o=;
  b=cS9EDuNbyg8S92v3kRXdZv5lFJ6G08ZM/uYqfeiQo5le7o9b0ily9Jdw
   gdfgrqXyC42ywYIKy/JBCO63LZp99Uhny9mS0mNO3Dtu6iV+l8A0oJ/cq
   zUYotGTYrTQFyWRvqGLULl3qJu2SQzUwSAAFEPh6Pra/Bnes1oSoPBx1I
   VE8gY/C5MD8sTDCUwmdeswKxB7xO33W7HT2wQg9T/Mt4AZvjPB6dabQ76
   OXWj6oAiib+DBj3XJiK8ISyeCYtSjDwGmIkz9yADmxRLYZJA/fuwogRfm
   3x19QLmqbDljcJLE13CUigmkdc6NhESbPBDbpFzDq/IYh04LwY2HAs/k6
   A==;
X-CSE-ConnectionGUID: VbAYOG2PS8qmey8IZloz1Q==
X-CSE-MsgGUID: ebyyrAbSQOKpdmXHAltgfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="24066509"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="24066509"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:44:38 -0700
X-CSE-ConnectionGUID: vspoSkLWQTKnr+FRvi7VPg==
X-CSE-MsgGUID: LjB2yxjURumhSnPj0/x0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59736602"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa004.jf.intel.com with SMTP; 31 Jul 2024 05:44:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 15:44:33 +0300
Date: Wed, 31 Jul 2024 15:44:33 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] usb: typec: tcpm/tcpci_maxim: convert to
 dev_err_probe()
Message-ID: <Zqoxse2smUiQjcUy@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-14-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-14-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:21AM +0100, André Draszik wrote:
> dev_err_probe() exists as a useful helper ensuring standardized
> error messages during .probe() and using it also helps to make
> the code more legible.
> 
> Use it.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index 5b5441db7047..ee3e86797f17 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -484,17 +484,17 @@ static int max_tcpci_probe(struct i2c_client *client)
>  
>  	chip->client = client;
>  	chip->data.regmap = devm_regmap_init_i2c(client, &max_tcpci_regmap_config);
> -	if (IS_ERR(chip->data.regmap)) {
> -		dev_err(&client->dev, "Regmap init failed\n");
> -		return PTR_ERR(chip->data.regmap);
> -	}
> +	if (IS_ERR(chip->data.regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->data.regmap),
> +				     "Regmap init failed\n");
>  
>  	chip->dev = &client->dev;
>  	i2c_set_clientdata(client, chip);
>  
>  	ret = max_tcpci_read8(chip, TCPC_POWER_STATUS, &power_status);
>  	if (ret < 0)
> -		return ret;
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to read TCPC_POWER_STATUS\n");
>  
>  	/* Chip level tcpci callbacks */
>  	chip->data.set_vbus = max_tcpci_set_vbus;
> @@ -511,10 +511,10 @@ static int max_tcpci_probe(struct i2c_client *client)
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -	if (IS_ERR(chip->tcpci)) {
> -		dev_err(&client->dev, "TCPCI port registration failed\n");
> -		return PTR_ERR(chip->tcpci);
> -	}
> +	if (IS_ERR(chip->tcpci))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->tcpci),
> +				     "TCPCI port registration failed\n");
> +
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
>  	ret = max_tcpci_init_alert(chip, client);
>  	if (ret < 0)
> @@ -526,7 +526,8 @@ static int max_tcpci_probe(struct i2c_client *client)
>  unreg_port:
>  	tcpci_unregister_port(chip->tcpci);
>  
> -	return ret;
> +	return dev_err_probe(&client->dev, ret,
> +			     "Maxim TCPCI driver initialization failed\n");
>  }
>  
>  static void max_tcpci_remove(struct i2c_client *client)
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

