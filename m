Return-Path: <linux-kernel+bounces-338340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91F9856A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024E61C2133C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A865C145A11;
	Wed, 25 Sep 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGOMHCcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C213DDB9
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257796; cv=none; b=qOzJByFE0sJpvEnDVp6/OJQcfkR5zmck8GXm0eaQrhZt0Q/4/GFoXj9L0I+uesevaEY9HGIqIul8uDw7hiPZd6ERf99MwC6eQ7eYAXP1La53RJ3zNUubziNQzn8lDhsbL7j82TTwZaD+ZrfR7469W5raSs+FJBeUOqcSpx6Tkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257796; c=relaxed/simple;
	bh=/l/NlhIvBnsLL4fpb8SQAbZu62LcA42OxwWwj83oqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgZgPU2zxTl3wB7/Znb9PKn8geV6GqsK/mQcLJ2Na3esqt70jFMNvGO8j6QVTO2ZQbCNZVGPbM/rSHUMOMxh8THlGRxxmmuYh5N1TZbsmeKEK6RY1+SnfGnRGwezI0z36sXoXXfI2NnHq+AVm0kOCBYWuKqP/17AndFgaMOfY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGOMHCcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD032C4CEC3;
	Wed, 25 Sep 2024 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727257795;
	bh=/l/NlhIvBnsLL4fpb8SQAbZu62LcA42OxwWwj83oqZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGOMHCcZS8dQ5gd/tg32Qq98GfuEixoQ9cxWby473GkhlDSYraAAO150Qu4ZKxG6W
	 IltXBPB9vSPpOyuu9ayvlLou82m1+VWbyHMcNx9QCalLsUVY0CrlnNtecSD0MqKH7K
	 Kx3BCVm9QQftKAMVv/Pj8RULUcUwcuO03UT+J/mM=
Date: Wed, 25 Sep 2024 11:49:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: arnd@arndb.de, W_Armin@gmx.de, hkallweit1@gmail.com, jdelvare@suse.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: fix cacography of switch
Message-ID: <2024092512-immovable-broker-81be@gregkh>
References: <20240921103644.14667-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921103644.14667-1-liujing@cmss.chinamobile.com>

On Sat, Sep 21, 2024 at 06:36:44PM +0800, liujing wrote:
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 9df12399bda3..cb1c4b8e7fd3 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -97,11 +97,11 @@ config EEPROM_DIGSY_MTC_CFG
>  	  If unsure, say N.
>  
>  config EEPROM_IDT_89HPESX
> -	tristate "IDT 89HPESx PCIe-swtiches EEPROM / CSR support"
> +	tristate "IDT 89HPESx PCIe-switches EEPROM / CSR support"
>  	depends on I2C && SYSFS
>  	help
>  	  Enable this driver to get read/write access to EEPROM / CSRs
> -	  over IDT PCIe-swtich i2c-slave interface.
> +	  over IDT PCIe-switch i2c-slave interface.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called idt_89hpesx.
> -- 
> 2.27.0
> 
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

