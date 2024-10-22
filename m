Return-Path: <linux-kernel+bounces-376377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BB99AB091
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE55B2293F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC41A3034;
	Tue, 22 Oct 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRnVCrx/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F81A070D;
	Tue, 22 Oct 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606371; cv=none; b=pMIrfYa592qQ1hlNaaHaNo3e8FVKKHWk8yM+RKexPShSVa4C2bOrtCXKtfe7s3O+axpIhLah8qszro0KFP+TLjmjC7Qgu18xfCW/x7S4A5fUjiaiLk7NWArDPStBfdiI/Cl+e7+D2PzebT/1l2zILqlNNuhErLDGfchDDfVW5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606371; c=relaxed/simple;
	bh=erUdRP/wSJOt0yc9hZpXjQRva3XVjQinT99xAB7yPXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M94nUxckjhLWzII9XIVR5t9PK+kRRuoproF3bhYOSbKNqLZP0fRW/DN6K48TqG3WNQud5lNciy7yO3fogInxwRZVv2HdxPNVsUPvCM580memRXA9zrmiLOXQzt/d9Umw3bZb/T87d2Zim40Sjjqw9Gg3YJGFf50OmJZnPX8cd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRnVCrx/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729606370; x=1761142370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=erUdRP/wSJOt0yc9hZpXjQRva3XVjQinT99xAB7yPXs=;
  b=nRnVCrx/KGZMwz6jL5nrk0dGXv74xA0yvaBmdvgVzYnHt7Cx3xR49b6V
   nnyEWuJEvMib1fmk/fmm/a23ePYW0DQyWZ74keUdWm5B/SOX2d9cVqkKF
   BmyJt5AviCEy1Tp1yDyFuL7X4LrzN/KykKsdOgZd6/VOpZjR3EvYKK7S/
   3OtRdgJi+IT9TxmbUr7E3gasS1ah114jGgH4zvvDJBKTsgFTdK9lFEpK+
   u9QjR/vQxx0nkAJTgOUPQAzDF+DoJzO5gVVztW/wXS8KMTn+mkmC6N854
   TlZxzCMlruvx6Bf/ZbbPshqQR2hI8ydq1zoRe6DSVtEPZ2230VNtiZsD+
   w==;
X-CSE-ConnectionGUID: CiO1yxFgR9GFONsv0Ot6Rg==
X-CSE-MsgGUID: TeLs8nSITCWYEdPfWej/KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54549341"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="54549341"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 07:12:49 -0700
X-CSE-ConnectionGUID: KaV1t5eqSuSrYp/Fh0Bo7Q==
X-CSE-MsgGUID: BdX3WIWOTlKtRa3FYsH9BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84700329"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 22 Oct 2024 07:12:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Oct 2024 17:12:45 +0300
Date: Tue, 22 Oct 2024 17:12:45 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: use cleanup facility for
 'altmodes_node'
Message-ID: <Zxey3Y9YkFATfwB2@kuha.fi.intel.com>
References: <20241021-typec-class-fwnode_handle_put-v2-0-3281225d3d27@gmail.com>
 <20241021-typec-class-fwnode_handle_put-v2-2-3281225d3d27@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-typec-class-fwnode_handle_put-v2-2-3281225d3d27@gmail.com>

On Mon, Oct 21, 2024 at 10:45:30PM +0200, Javier Carrasco wrote:
> Use the __free() macro for 'altmodes_node' to automatically release the
> node when it goes out of scope, removing the need for explicit calls to
> fwnode_handle_put().
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 1eb240604cf6..58f40156de56 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -2293,7 +2293,7 @@ void typec_port_register_altmodes(struct typec_port *port,
>  	const struct typec_altmode_ops *ops, void *drvdata,
>  	struct typec_altmode **altmodes, size_t n)
>  {
> -	struct fwnode_handle *altmodes_node, *child;
> +	struct fwnode_handle *child;
>  	struct typec_altmode_desc desc;
>  	struct typec_altmode *alt;
>  	size_t index = 0;
> @@ -2301,7 +2301,9 @@ void typec_port_register_altmodes(struct typec_port *port,
>  	u32 vdo;
>  	int ret;
>  
> -	altmodes_node = device_get_named_child_node(&port->dev, "altmodes");
> +	struct fwnode_handle *altmodes_node  __free(fwnode_handle) =
> +		device_get_named_child_node(&port->dev, "altmodes");
> +
>  	if (!altmodes_node)
>  		return; /* No altmodes specified */
>  
> @@ -2341,7 +2343,6 @@ void typec_port_register_altmodes(struct typec_port *port,
>  		altmodes[index] = alt;
>  		index++;
>  	}
> -	fwnode_handle_put(altmodes_node);
>  }
>  EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
>  

-- 
heikki

