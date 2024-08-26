Return-Path: <linux-kernel+bounces-301109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F995EC75
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9D21C21635
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D913D882;
	Mon, 26 Aug 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biu1pXG2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BF145B24;
	Mon, 26 Aug 2024 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662453; cv=none; b=uKUacvlkBLHt1WgQ74AP7GfY9Agl7fqAb7Dnj7ZLYEleQ/oFC7CEa8njx6P75AX3sZEaSrBSttPdPLWquMH9xNKlJPjQWirv1djPgzPXa080mKRjP89EjHNBR+BX++eo6uoxuF1rPzN70fevgMwm9snaIAjxYMr9/+1SiCfUIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662453; c=relaxed/simple;
	bh=YpyRsICQh2Ct8m66TziSRhFUnNrO3LSZMeegHmG9WiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlRWV8JWfVzzhJ1Z3LjZ82sPB0IS6wFvOWfLMT1P2Be5ga6bQgKioU97D80Rcgq6qc+6lvzau6hU/OmuCCW1n5F7GoakXIQr3sChmgleke1nHuX4C9NGIegCE4vH/dgHgq/U8bNo1Ca5j8Ahk4AXJJDARdo3GYFrcKg/8TO1SMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biu1pXG2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724662453; x=1756198453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YpyRsICQh2Ct8m66TziSRhFUnNrO3LSZMeegHmG9WiY=;
  b=biu1pXG2suiNZbwERvrrpdbBcU8eDFyNCJ3wduh9GkG9Kr/WbU90W7Ys
   Aanoj1FcP5gBT6laxvpgC12OvQyZDOOfLWQvHUOtFGdLqa+wvFnoPIlhq
   9suGtrYN3l+q1H6vlLSs+2sKBacRLfOX/KKqV0JxZ9TQWXd3MUEBMVIKN
   P6yJ8G3eStQgoC2Ild2p39MjzbV3q13jDqgqgpXYjWLlHSQzjT4gTE/sT
   4LNwoWhSKel0sL4i7t0plimeBGisXf/TzFAY6LiPmu3feNsdW8C2Yl85W
   AqXY5+M8XhW0Ffw3bhHqQsJvV2UvLzCq29pS60C1K0259e/pt+z4dAaGr
   w==;
X-CSE-ConnectionGUID: Ti4jnhB8RxmHUnwMIjtPpg==
X-CSE-MsgGUID: At8E1xeGRKim8CLokGeH+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23200353"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23200353"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:54:12 -0700
X-CSE-ConnectionGUID: 1Dw5wa1cRfKYMJinJLMuUw==
X-CSE-MsgGUID: stdROqkyQmylCrh6tF6S4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62280099"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa010.jf.intel.com with SMTP; 26 Aug 2024 01:54:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Aug 2024 11:54:06 +0300
Date: Mon, 26 Aug 2024 11:54:06 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, alcooperx@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, stern@rowland.harvard.edu,
	justin.chen@broadcom.com
Subject: Re: [PATCH -next 3/4] usb: typec: fix module autoloading
Message-ID: <ZsxCrnp8Cwx+nNjg@kuha.fi.intel.com>
References: <20240822130113.164644-1-liaochen4@huawei.com>
 <20240822130113.164644-4-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822130113.164644-4-liaochen4@huawei.com>

On Thu, Aug 22, 2024 at 01:01:12PM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/anx7411.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 5a5bf3532ad7..33ff301b918f 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -1576,6 +1576,7 @@ static const struct of_device_id anx_match_table[] = {
>  	{.compatible = "analogix,anx7411",},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, anx_match_table);
>  
>  static struct i2c_driver anx7411_driver = {
>  	.driver = {
> -- 
> 2.34.1

-- 
heikki

