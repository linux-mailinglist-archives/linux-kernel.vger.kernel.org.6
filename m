Return-Path: <linux-kernel+bounces-229076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E0916A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523EFB262A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B016C6A7;
	Tue, 25 Jun 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF0SU9ks"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFD16A945;
	Tue, 25 Jun 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325940; cv=none; b=acoGI1mkY7L0Kmvo3NMXx9IAjg8Ssp7YofOZWl/VMOk2M2NRlMpXGFHwrjp37kvs6ypmdiWEC/c/qcn/g73f4pQShd7oMJ5hRQfrPg0dxLCo7RdrPxsNG3099iYqdW92wcX6RK1EAkXTYrGkCDZ6g4LE7i3V8FGGXjygutshvzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325940; c=relaxed/simple;
	bh=4Btt7nHXmZ/SHrR9ecV9+Bb/5ZFEkYCEOCWUHw966Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDPWgxe/bzoyIv3SyWiWfu4xz2Kk83wnU4E517gKRzAnL2xOkbqQpxh+NvEynicC0H7+2HOZ24saZH60IKC/aBxEuKFPqbHkqrQWPov4+JAxWN/v7H4n0tsIvHGEEcoVm2RICuWY8tOUY4B/U4ls2a2bKaUeDTfs00kS2FjEIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF0SU9ks; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719325940; x=1750861940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Btt7nHXmZ/SHrR9ecV9+Bb/5ZFEkYCEOCWUHw966Dw=;
  b=NF0SU9ksYV9JWLWmY8BygG27qhKdif52pp66wPQ9P933JxxwQ2ZmyYCR
   JGFvu3QvYbWeRcN+fSHb3HgY56bX30Bq9VkrXcHU9uNYQ8Kv0uOvm1Pfw
   1Uvgy2tOSY/kTWaj7S7LjaZ0fY5CTL4ge1cwmwVXxzVk1accB3hmVqKgA
   GiyIQ5h9zXpBctMUv07dTAQuLb5epz5tAMSQNQ7w1lCyDX9HT1wWN9/J7
   F2m12LY0sGKNItNF2ltaojeg3tiNsySY85DdQZYnPvAus8Q2slC+2u0v2
   9o12GGJYTD8vkGDYp4rXVGLSbWnQiHqOneQ6p5Me6+QjrFvWXRbHuA36l
   A==;
X-CSE-ConnectionGUID: ld9gNvjzQZefHtbmVx35lA==
X-CSE-MsgGUID: N65zcewESpGts3R0k8RleA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="33803575"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="33803575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 07:32:19 -0700
X-CSE-ConnectionGUID: MxGmUljuSkynsoyEqaL//A==
X-CSE-MsgGUID: i7/uLi08Qx6Y0Q6T6MvMfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48843489"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa004.jf.intel.com with SMTP; 25 Jun 2024 07:32:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Jun 2024 17:32:13 +0300
Date: Tue, 25 Jun 2024 17:32:13 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, jonathanh@nvidia.com, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: Only set number of plug altmodes
 after registration
Message-ID: <ZnrU7T/5qACbNnIK@kuha.fi.intel.com>
References: <20240625004607.3223757-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625004607.3223757-1-jthies@google.com>

On Tue, Jun 25, 2024 at 12:46:07AM +0000, Jameson Thies wrote:
> Move the setting of the plug's number of alternate modes into the
> same condition as the plug's registration to prevent dereferencing the
> connector's plug pointer while it is null.
> 
> Fixes: c313a44ac9cd ("usb: typec: ucsi: Always set number of alternate modes")
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 76c48d873b2a..77e46bf4a098 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1180,13 +1180,13 @@ static int ucsi_check_cable(struct ucsi_connector *con)
>  		ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
>  		if (ret < 0)
>  			return ret;
> -	}
>  
> -	if (con->plug_altmode[0]) {
> -		num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
> -		typec_plug_set_num_altmodes(con->plug, num_plug_am);
> -	} else {
> -		typec_plug_set_num_altmodes(con->plug, 0);
> +		if (con->plug_altmode[0]) {
> +			num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
> +			typec_plug_set_num_altmodes(con->plug, num_plug_am);
> +		} else {
> +			typec_plug_set_num_altmodes(con->plug, 0);
> +		}
>  	}
>  
>  	return 0;
> 
> base-commit: 819984a0dd3606b7c46fe156cd56a0dc0d604788
> -- 
> 2.45.2.741.gdbec12cfda-goog

-- 
heikki

