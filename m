Return-Path: <linux-kernel+bounces-269181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B5942EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A5F1F26694
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324191B0124;
	Wed, 31 Jul 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoPgn+6f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6651AC425;
	Wed, 31 Jul 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429912; cv=none; b=SIC5fuCp/OAXxT3Prib01Fo6g7hFjFBMZhsy15LkTJPQ3Ifwm8aI+EvR+2Hqvnz35ZUU1vMo9cCiF7tWcGcooESc9yBE+9rZJYdzr1C2RAS3ud/sYfPWafepsgrif88xwmBjWAUwA6YXG8Ssadu1t8Ez5RfmCpJFFmBUo8xurRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429912; c=relaxed/simple;
	bh=EBsNIatrrf6lgvG736PJZ1ORIo+mkpep33/JrZlDzUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J48bn7o7CdcHx1uLN4eOOVxYwVfxOw5ljcWHsd9aMMgDBT6+v4XMDocAttQsMFcYIe4fBMx3rcxs+tWrLLOixtU32y6z60JhL4Z6tlv9rOiG3Tc5W6pI6pfxq5xzgJrwEpNb+MsrtHVYd2Sc308BEsZCgGcSfQhGSRsLsWKoSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoPgn+6f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722429910; x=1753965910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EBsNIatrrf6lgvG736PJZ1ORIo+mkpep33/JrZlDzUY=;
  b=eoPgn+6fwhdwsroufZAZ5iinM5LiLavwaiDeqjPuG3jS9JwzHPWA7v1c
   hSz3p3H8aHm5CXzQF4EA1eEW1sMIECguwC2W7c6SZE+KOzjHDa20pdSjk
   cFImWQQoVPNFPXCMi08zpDciZSGo09JcrytEkXDIxrQV6T9NgT5zQYTCl
   d3JV7w1yiDTk2HadKj4wYft6Eb5FZkZftg6AeX3d1t+NMV/rPQp1gx4ZW
   iuMr3C96yE63UsQsu//RrN2RBeJ4Nhdz3lsMoGph9QXgb++LsCJOmH+Zi
   gB6AZjbqHbdbluSCaQnjlMJ7JfrteBY0Wz3N+SNU5K4jEi1MMPPDK5J6Q
   Q==;
X-CSE-ConnectionGUID: QJOHkTMmQ0eZrXAk3iF6Zg==
X-CSE-MsgGUID: KQiI57KrRRqcLMg0lEWjuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20188375"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20188375"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:45:09 -0700
X-CSE-ConnectionGUID: IMgVWtSkR8WIUP1HmXLtmA==
X-CSE-MsgGUID: pvtvDXjxR/eabJWF1L+PoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59524277"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 31 Jul 2024 05:45:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 15:45:05 +0300
Date: Wed, 31 Jul 2024 15:45:04 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] usb: typec: tcpm/tcpci_maxim: use device managed
 TCPCI port deregistration
Message-ID: <Zqox0KNoLwvMFMKL@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-15-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-15-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:22AM +0100, André Draszik wrote:
> Instead of open-coding the call to tcpci_unregister_port() in various
> places, let's just register a hook using devm_add_action_or_reset() so
> that it gets called automatically as and when necessary by the device
> management APIs.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index ee3e86797f17..7abfd29b4b01 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -472,6 +472,11 @@ static bool max_tcpci_attempt_vconn_swap_discovery(struct tcpci *tcpci, struct t
>  	return true;
>  }
>  
> +static void max_tcpci_unregister_tcpci_port(void *tcpci)
> +{
> +	tcpci_unregister_port(tcpci);
> +}
> +
>  static int max_tcpci_probe(struct i2c_client *client)
>  {
>  	int ret;
> @@ -515,27 +520,21 @@ static int max_tcpci_probe(struct i2c_client *client)
>  		return dev_err_probe(&client->dev, PTR_ERR(chip->tcpci),
>  				     "TCPCI port registration failed\n");
>  
> +        ret = devm_add_action_or_reset(&client->dev,
> +				       max_tcpci_unregister_tcpci_port,
> +				       chip->tcpci);
> +        if (ret)
> +                return ret;
> +
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
> +
>  	ret = max_tcpci_init_alert(chip, client);
>  	if (ret < 0)
> -		goto unreg_port;
> +		return dev_err_probe(&client->dev, ret,
> +				     "IRQ initialization failed\n");
>  
>  	device_init_wakeup(chip->dev, true);
>  	return 0;
> -
> -unreg_port:
> -	tcpci_unregister_port(chip->tcpci);
> -
> -	return dev_err_probe(&client->dev, ret,
> -			     "Maxim TCPCI driver initialization failed\n");
> -}
> -
> -static void max_tcpci_remove(struct i2c_client *client)
> -{
> -	struct max_tcpci_chip *chip = i2c_get_clientdata(client);
> -
> -	if (!IS_ERR_OR_NULL(chip->tcpci))
> -		tcpci_unregister_port(chip->tcpci);
>  }
>  
>  static const struct i2c_device_id max_tcpci_id[] = {
> @@ -558,7 +557,6 @@ static struct i2c_driver max_tcpci_i2c_driver = {
>  		.of_match_table = of_match_ptr(max_tcpci_of_match),
>  	},
>  	.probe = max_tcpci_probe,
> -	.remove = max_tcpci_remove,
>  	.id_table = max_tcpci_id,
>  };
>  module_i2c_driver(max_tcpci_i2c_driver);
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

