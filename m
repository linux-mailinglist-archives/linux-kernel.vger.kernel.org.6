Return-Path: <linux-kernel+bounces-269000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE6942C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4688C1C21C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4891AC442;
	Wed, 31 Jul 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b32Mh6Lf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D61A7F83;
	Wed, 31 Jul 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422399; cv=none; b=sW3Gr9s6IBUz8T81awad/OROYa/NZpXmem9FQ+Io66O+QHT3Amz59qoD7ZjMcS/sx+d7tclz9vHAei0LL/9KZdsv3TIxiZEiJlPLuBrgQcgncrRvLlwcoAw7AFCObXFKx4gaeSjzqhl6tC/IhsUljPD/lmqdxuXpvJDjK9gDDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422399; c=relaxed/simple;
	bh=yh4Wgn9OCMi+xMJQto59Y2nDFX4DyCknHujYmApgkzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0vcQcYmLUl6Qa9708LjRY78TapmpzYqat8ybsnhuvmEhPNjWmcdamSXITX/M5b+K7AgWsabnPyzXrH5BqfZJEKD2q6SUnCqgXNwi0UdF+NiMlqqqSmBhLa6+JrorewD21CT9lzCQZljUBnxx/LrGIA3jfNek09ZStLPvh+Z+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b32Mh6Lf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722422398; x=1753958398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yh4Wgn9OCMi+xMJQto59Y2nDFX4DyCknHujYmApgkzY=;
  b=b32Mh6LfvJmxRv3fY4Tdo9t+kYw1jmzWnBapWczyVuJeDSPP1YDu8oD+
   IuN/lG0XsJyGTMTt/0Y5BG10Wbh6SKYemWe92Zw+yms0beIMUN9FbJ+nD
   EHXgU700CiSmOd/xfpcIxCS7L3ntM9+mlQ6QvNx+xIMaOUTHEfM6dUm95
   L11Xa+BZF2hy5BKGnhRYmYaUHW1sLJrCIsKjT3aTnDscVzMKJO80Y+2q9
   EcOhe7f2KnQ/ZPlcVz1mEZaRc63pWOu9fcJ8d+zr0zuoBVSNfgfLuTAKA
   gI2OLzM8ioNr5FXgUoGxxNQlIv3aEIFg4o/3vK3J+OoCUUc08DkPvKTca
   A==;
X-CSE-ConnectionGUID: S1a+3VqpSMuAMkk5Lv2thw==
X-CSE-MsgGUID: v/i4S+oNRLuN9/5nH9oxfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20430947"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20430947"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 03:39:57 -0700
X-CSE-ConnectionGUID: 7GKWHkENRfuLqKQTX1rvVw==
X-CSE-MsgGUID: 5zgMHsPfTASGwes6tawrMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54885706"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 31 Jul 2024 03:39:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 13:39:53 +0300
Date: Wed, 31 Jul 2024 13:39:53 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] usb: typec: tcpci: use GENMASK() for
 TCPC_MSG_HDR_INFO_REV
Message-ID: <ZqoUeUN96bnXO7qB@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-6-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-6-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:13AM +0100, André Draszik wrote:
> Convert field TCPC_MSG_HDR_INFO_REV from register TCPC_MSG_HDR_INFO to
> using GENMASK() and FIELD_PREP() so as to keep using a similar approach
> for all fields.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 2 +-
>  include/linux/usb/tcpci.h      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 5ad05a5bbbd1..ad5c9d5bf6a9 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -456,7 +456,7 @@ static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
>  	unsigned int reg;
>  	int ret;
>  
> -	reg = PD_REV20 << TCPC_MSG_HDR_INFO_REV_SHIFT;
> +	reg = FIELD_PREP(TCPC_MSG_HDR_INFO_REV, PD_REV20);
>  	if (role == TYPEC_SOURCE)
>  		reg |= TCPC_MSG_HDR_INFO_PWR_ROLE;
>  	if (data == TYPEC_HOST)
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 80652d4f722e..3cd61e9f73b3 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -129,9 +129,8 @@
>  
>  #define TCPC_MSG_HDR_INFO		0x2e
>  #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
> +#define TCPC_MSG_HDR_INFO_REV		GENMASK(2, 1)
>  #define TCPC_MSG_HDR_INFO_PWR_ROLE	BIT(0)
> -#define TCPC_MSG_HDR_INFO_REV_SHIFT	1
> -#define TCPC_MSG_HDR_INFO_REV_MASK	0x3
>  
>  #define TCPC_RX_DETECT			0x2f
>  #define TCPC_RX_DETECT_HARD_RESET	BIT(5)
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

