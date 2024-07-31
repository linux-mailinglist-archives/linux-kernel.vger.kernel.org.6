Return-Path: <linux-kernel+bounces-269038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E109942CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D11C213FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784551AC450;
	Wed, 31 Jul 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Det0uVEC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE023145FEF;
	Wed, 31 Jul 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423731; cv=none; b=QSCe5e6TyBTlkhRjkXD0aObwUOedpr6rWlX9ZpmzA2TPKdx6cK4Yk87T5jI8m2DF3oy2oDauQVc6/S+Cwy5nqEUQKjuYfgYmI8uT7h/VtnyUULBWAyEaxbabA5M9iMCLyi8hSbZ2CXO4eav6VPdS0djyMcUm8sMx2V2XmN38Bos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423731; c=relaxed/simple;
	bh=JOqfqwu552ErS4arcscKszrGQQdQrUqWAJP/x8QhsRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJut8QagKgqW6sc1cYcAkcwfSH6SFVWWNAdsn3nzpMI+IUSc0pim/5PZMox+0FX4EW4tfIxNbW9bHSv0QOgtmWAUkxOXoI2jsiTTPAEhi4g29s8YUe6/TBao581UAOl7sx3mcWjqyYub+6nw7JYjDeyEWTENJ9h0JnRH91o6Jpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Det0uVEC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722423730; x=1753959730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JOqfqwu552ErS4arcscKszrGQQdQrUqWAJP/x8QhsRM=;
  b=Det0uVECodwwt9MNBGNYCGqFEUcc1lwKMTZlHkmgxyfRlWEEJEeZ1kHP
   0icKoAHpwUh0R85wgrOPo7qDiqyOcj4jPTQG0nt/3PsEcWT/GOTw0zrEi
   oUkR48hX0C7NmQmqdIONtaw7QaDWf2Q0DbBumrsZKPSkeJKFoo/aFaVNd
   B4Jbcql8Ua/fdJOU05TrYNPHtYF+PY8PtBtHzvVjhFCPV9m0m5XO/xOBC
   RSLPrFfkHIL0BDUtRNzyirX4DBYkJuOk2OjkorxpVkq5Rr7iiUGTImXfM
   SJv88eB0TkpBU+XvaBVb9VpozvgQ6hlrCkjCAw9KlAldHtIniBLRjIp5Y
   g==;
X-CSE-ConnectionGUID: IXrM96z4QAGMR12KFP0SIQ==
X-CSE-MsgGUID: GY75+SPCRDirL7cCMHaYjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="42824058"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="42824058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 04:02:09 -0700
X-CSE-ConnectionGUID: OuAcWI4qQpyKkAAwhBADAw==
X-CSE-MsgGUID: siziB5eXS7ebOyv84UT52A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="92172464"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa001.jf.intel.com with SMTP; 31 Jul 2024 04:01:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 14:01:54 +0300
Date: Wed, 31 Jul 2024 14:01:54 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] usb: typec: tcpci: use GENMASK() for TCPC_TRANSMIT
 register fields
Message-ID: <ZqoZogC9vYg6vSOS@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-7-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-7-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:14AM +0100, André Draszik wrote:
> Convert all fields from register TCPC_TRANSMIT to using GENMASK() and
> FIELD_PREP() so as to keep using a similar approach throughout the code
> base and make it arguably easier to read.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 7 +++++--
>  include/linux/usb/tcpci.h      | 6 ++----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index ad5c9d5bf6a9..b9ee9ccff99b 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -607,8 +607,11 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type
>  	}
>  
>  	/* nRetryCount is 3 in PD2.0 spec where 2 in PD3.0 spec */
> -	reg = ((negotiated_rev > PD_REV20 ? PD_RETRY_COUNT_3_0_OR_HIGHER : PD_RETRY_COUNT_DEFAULT)
> -	       << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
> +	reg = FIELD_PREP(TCPC_TRANSMIT_RETRY,
> +			 (negotiated_rev > PD_REV20
> +			  ? PD_RETRY_COUNT_3_0_OR_HIGHER
> +			  : PD_RETRY_COUNT_DEFAULT));
> +	reg |= FIELD_PREP(TCPC_TRANSMIT_TYPE, type);
>  	ret = regmap_write(tcpci->regmap, TCPC_TRANSMIT, reg);
>  	if (ret < 0)
>  		return ret;
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 3cd61e9f73b3..f7f5cfbdef12 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -148,10 +148,8 @@
>  #define TCPC_RX_DATA			0x34 /* through 0x4f */
>  
>  #define TCPC_TRANSMIT			0x50
> -#define TCPC_TRANSMIT_RETRY_SHIFT	4
> -#define TCPC_TRANSMIT_RETRY_MASK	0x3
> -#define TCPC_TRANSMIT_TYPE_SHIFT	0
> -#define TCPC_TRANSMIT_TYPE_MASK		0x7
> +#define TCPC_TRANSMIT_RETRY		GENMASK(5, 4)
> +#define TCPC_TRANSMIT_TYPE		GENMASK(2, 0)
>  
>  #define TCPC_TX_BYTE_CNT		0x51
>  #define TCPC_TX_HDR			0x52
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

