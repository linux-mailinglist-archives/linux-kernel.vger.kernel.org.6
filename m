Return-Path: <linux-kernel+bounces-268998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D81D942C17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0FA1F268D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980451AC442;
	Wed, 31 Jul 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivgt0gLF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6E1A8C0B;
	Wed, 31 Jul 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422235; cv=none; b=tLuxPhiY2X33CnJe+l2jRmz9IERRf1C3Sys3kV74G6lvD/G3826USaMrGzKzCTNtqMBwKQNuxHxBQYTjuc+RccEIvtfMc/HbV79cVRuU9SuBxktRVBSsKCZdmsRnlLV91skpN01qpyRC2IHuNLZf5WO18mUh2ZAGV0d7TRwqEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422235; c=relaxed/simple;
	bh=ssHRUoqJVLPuszrnWUtuipDRggPfl39sO0Wx+i2H3H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIDVwbbLZ9or6ADx9SpRJewlDSKCcjHcWYfUCeRK8HCpb2ESYArbv3RSFCfZR7h0fJYoYBDFjxPJqxDnxHz5q1Ucm6at4fpad5pDalQ2vV1myhgFpH0i1+rSS5ho0KqcbdH8qxwbPFIbEeMPnDx/RGp2+CZOfiW771J/Ty0zowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivgt0gLF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722422234; x=1753958234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ssHRUoqJVLPuszrnWUtuipDRggPfl39sO0Wx+i2H3H8=;
  b=ivgt0gLF1PiM3E5S2dcygdFEZKJpvo6x79DMrfOa+h53/ONP8fHQJGWz
   twy0vB3murHiuiP1Pm9WSHh/EEC6TV0CUuHwzFW+wGSs7ZroY9iqClrlw
   KNbt6MhAg5etjhAmksL9Y9s3ZRrDEJUyx6aalcTKKXpXgRz4ef1bdUcHU
   zNdPczpGjzNXjYugx42K4xddmReKq4m7OQlFRE24DcIMu3fidZxvvwmRD
   4wMsB+j9GyLFHXUsMRrTFm+j4GhtKGFkWZhMF0jgPes9unXyMHsQWahTf
   jxMzDnU1LaU/GmHePsDNHncBoErBkidMxoN33hrUSQSkSKA9xVY7rLN1h
   Q==;
X-CSE-ConnectionGUID: 9GnDqqKVQNutnlRG6L95MA==
X-CSE-MsgGUID: ZykzzhXRSyGomMxsOlnA8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31698138"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31698138"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 03:37:14 -0700
X-CSE-ConnectionGUID: EGcN0eqOQfSt2C7ylMwFpw==
X-CSE-MsgGUID: xpwmANvWS66hxIqCPNA8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59282280"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa004.fm.intel.com with SMTP; 31 Jul 2024 03:37:10 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Jul 2024 13:37:09 +0300
Date: Wed, 31 Jul 2024 13:37:09 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] usb: typec: tcpci: use GENMASK() for
 TCPC_ROLE_CTRL_RP_VAL
Message-ID: <ZqoT1QW4lG5WjQgw@kuha.fi.intel.com>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
 <20240710-tcpc-cleanup-v1-5-0ec1f41f4263@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710-tcpc-cleanup-v1-5-0ec1f41f4263@linaro.org>

On Wed, Jul 10, 2024 at 11:36:12AM +0100, André Draszik wrote:
> Align the last remaining field TCPC_ROLE_CTRL_RP_VAL with the other
> fields in the TCPC_ROLE_CTRL register by using GENMASK() and
> FIELD_PREP().
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c         | 21 ++++++++++++---------
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 12 ++++++------
>  include/linux/usb/tcpci.h              |  3 +--
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index cd71ece7b956..5ad05a5bbbd1 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -114,17 +114,20 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>  	case TYPEC_CC_RP_DEF:
>  		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
>  		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP)
> -		       | (TCPC_ROLE_CTRL_RP_VAL_DEF << TCPC_ROLE_CTRL_RP_VAL_SHIFT));
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				    TCPC_ROLE_CTRL_RP_VAL_DEF));
>  		break;
>  	case TYPEC_CC_RP_1_5:
>  		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
>  		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP)
> -		       | (TCPC_ROLE_CTRL_RP_VAL_1_5 << TCPC_ROLE_CTRL_RP_VAL_SHIFT));
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				    TCPC_ROLE_CTRL_RP_VAL_1_5));
>  		break;
>  	case TYPEC_CC_RP_3_0:
>  		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP)
>  		       | FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP)
> -		       | (TCPC_ROLE_CTRL_RP_VAL_3_0 << TCPC_ROLE_CTRL_RP_VAL_SHIFT));
> +		       | FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				    TCPC_ROLE_CTRL_RP_VAL_3_0));
>  		break;
>  	case TYPEC_CC_OPEN:
>  	default:
> @@ -194,16 +197,16 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
>  	switch (cc) {
>  	default:
>  	case TYPEC_CC_RP_DEF:
> -		reg |= (TCPC_ROLE_CTRL_RP_VAL_DEF <<
> -			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				  TCPC_ROLE_CTRL_RP_VAL_DEF);
>  		break;
>  	case TYPEC_CC_RP_1_5:
> -		reg |= (TCPC_ROLE_CTRL_RP_VAL_1_5 <<
> -			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				  TCPC_ROLE_CTRL_RP_VAL_1_5);
>  		break;
>  	case TYPEC_CC_RP_3_0:
> -		reg |= (TCPC_ROLE_CTRL_RP_VAL_3_0 <<
> -			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				  TCPC_ROLE_CTRL_RP_VAL_3_0);
>  		break;
>  	}
>  
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index bdb78d08b5b5..64f6dd0dc660 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -232,16 +232,16 @@ static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
>  	switch (cc) {
>  	default:
>  	case TYPEC_CC_RP_DEF:
> -		reg |= (TCPC_ROLE_CTRL_RP_VAL_DEF <<
> -			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				  TCPC_ROLE_CTRL_RP_VAL_DEF);
>  		break;
>  	case TYPEC_CC_RP_1_5:
> -		reg |= (TCPC_ROLE_CTRL_RP_VAL_1_5 <<
> -			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				  TCPC_ROLE_CTRL_RP_VAL_1_5);
>  		break;
>  	case TYPEC_CC_RP_3_0:
> -		reg |= (TCPC_ROLE_CTRL_RP_VAL_3_0 <<
> -			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
> +				  TCPC_ROLE_CTRL_RP_VAL_3_0);
>  		break;
>  	}
>  
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 552d074429f0..80652d4f722e 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -63,8 +63,7 @@
>  
>  #define TCPC_ROLE_CTRL			0x1a
>  #define TCPC_ROLE_CTRL_DRP		BIT(6)
> -#define TCPC_ROLE_CTRL_RP_VAL_SHIFT	4
> -#define TCPC_ROLE_CTRL_RP_VAL_MASK	0x3
> +#define TCPC_ROLE_CTRL_RP_VAL		GENMASK(5, 4)
>  #define TCPC_ROLE_CTRL_RP_VAL_DEF	0x0
>  #define TCPC_ROLE_CTRL_RP_VAL_1_5	0x1
>  #define TCPC_ROLE_CTRL_RP_VAL_3_0	0x2
> 
> -- 
> 2.45.2.803.g4e1b14247a-goog

-- 
heikki

