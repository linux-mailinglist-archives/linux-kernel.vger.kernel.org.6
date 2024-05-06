Return-Path: <linux-kernel+bounces-169636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAAB8BCB8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E69B203CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A99E142E78;
	Mon,  6 May 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2x0QhcV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7901428FA;
	Mon,  6 May 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989799; cv=none; b=O34wNEbmou2Ind9A/ObZZzDGP0jOxuiaPFnF1du3HHIdAOyma1nVXoIyGM9noXvsgW0/7juDsZaktBWE2sj9r4bq3fvpN6hLU3raTHmz4JsuCdDWLo6AxqTqJNjp6xmG6ooJqHYRLzdlIijAUS2hmkPFX7GzJpYvLwuru876CNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989799; c=relaxed/simple;
	bh=jGKjKdTTHtYCR0VQEA2vDa3/c/WRFub9vNT+bb6fzqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvkkvSYuA9ylNRX0u2crRghWUjB4sP6bzYx5/jeTaOlQznRhZEUmhfB9QaDM76tUbllhAnOBAFbDDhy7ITqHUGhNWRjPxPzldBkTzE81Y9OMBArMsgfWTE++9/2vzk/mhUwhP0yJPofXWxxFEsfyKlmGzDrJZga8ldcTTl5lM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2x0QhcV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714989798; x=1746525798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGKjKdTTHtYCR0VQEA2vDa3/c/WRFub9vNT+bb6fzqE=;
  b=N2x0QhcVWMSM8ND0XynuDKOk7e9RgCzVgDyJP1WbZVtBUcKa97QT3HGu
   HPgw98/UUr2CKHTIzKXzZQC+3czbE+pMUN3inLmPL8BjoZYmheJluLltr
   tDlxMdapu8V1D+Tn4M9+85K5w2cFQ2g5Q0rNuIZjbBE0ovzFbXpnJfMTQ
   PZjn4WBc1BhExM18vHRSGcLT+bQxqBw7LqwKdEaU2uhfu0hAIJ9TojdI5
   qCU6IqbMT1e2pDEoOq7up/okMJl56Uo7cA3/UT0klrUH+qNbs79TSyr8S
   JUgHqGAErOJ3P7ZgynZ9WPHQw0+iDogdqagydf+ibIAnTKJPBLBqagTNe
   w==;
X-CSE-ConnectionGUID: FczGfuXHQT62GkY8NX0jLg==
X-CSE-MsgGUID: xCYhXlB0SH63AdIv9kFy2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10889400"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10889400"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 03:03:17 -0700
X-CSE-ConnectionGUID: 8rNnEJpyTnGz/nqtNuckxw==
X-CSE-MsgGUID: GkldQzuiSQiWf7hst6jZ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28217728"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa006.fm.intel.com with SMTP; 06 May 2024 03:03:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 06 May 2024 13:03:12 +0300
Date: Mon, 6 May 2024 13:03:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] usb: typec: ucsi: Fix null pointer dereference in
 trace
Message-ID: <Zjiq4PrL2ju8FOUz@kuha.fi.intel.com>
References: <20240503003920.1482447-1-jthies@google.com>
 <20240503003920.1482447-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503003920.1482447-2-jthies@google.com>

On Fri, May 03, 2024 at 12:39:17AM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> ucsi_register_altmode checks IS_ERR on returned pointer and treats
> NULL as valid. When CONFIG_TYPEC_DP_ALTMODE is not enabled
> ucsi_register_displayport returns NULL which causese a NULL pointer
> dereference in trace. Rather than return NULL, call
> typec_port_register_altmode to register DisplayPort alternate mode
> as a non-controllable mode when CONFIG_TYPEC_DP_ALTMODE is not enabled.
> 
> Reviewed-by: Jameson Thies <jthies@google.com>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

You delivered the patch, so you should have used SoB instead of
Reviewed-by tag:
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in V3:
> - Returns typec_port_register_altmode call from
> ucsi_register_displayport when CONFIG_TYPEC_DP_ALTMODE is not enabled.
> 
> Changes in V2:
> - Checks for error response from ucsi_register_displayport when
> registering DisplayPort alternate mode.
> 
>  drivers/usb/typec/ucsi/ucsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index c4d103db9d0f8..f66224a270bc6 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
>  			  bool override, int offset,
>  			  struct typec_altmode_desc *desc)
>  {
> -	return NULL;
> +	return typec_port_register_altmode(con->port, desc);
>  }
>  
>  static inline void
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

-- 
heikki

