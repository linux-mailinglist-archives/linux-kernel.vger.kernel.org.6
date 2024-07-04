Return-Path: <linux-kernel+bounces-240997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028C4927582
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3462D1C21258
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB01AD9D1;
	Thu,  4 Jul 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RAcQPM3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61016A945;
	Thu,  4 Jul 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094002; cv=none; b=CpiQNb+uBer5cuI4ow+LlTN7FEnxUpaWKEc8CxkMKDrOXr6WRIsnFvWy7/FWDYkrcZbo7h+GqdkVGo9OJAV+n+neDVZLvHwvNZL95vPAiX2n2CJHiaKL3Q1EBFmPR3UeBNE8eOXLLGS2t4xc56ZglabFAImhSg3LkDTEcGiURbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094002; c=relaxed/simple;
	bh=U3dPr5l/cWz9eU6uDK/U5qicfmezuiQruprhrMGvAwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upZcl1Czw1j0QOGI4T+Yyl8mKY/n/1fQges4W4WkcMsaezQAQq12ORarS/o6TTbBXDRKPUg0HwRuD2aPZH6dq2PBd6Hz/9Bjy+8//jqaT2+ZHfns8DtmzdqniM3oeI87XCrGTrfHNgQm5ScXXT6DqdKXJYXya9rJdKYZZt/LbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RAcQPM3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0734EC3277B;
	Thu,  4 Jul 2024 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720094002;
	bh=U3dPr5l/cWz9eU6uDK/U5qicfmezuiQruprhrMGvAwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAcQPM3+1kLHxoBzf16sZ8IQTKx4nbsCip/OWI+I0Puq+6kBLFYRuJYPPdiFctkQg
	 Ag1UF52wDjb7n1kBaqwnIHFgXSa3vym0++qBSbiQ6YL6tXqonA3i6c7KZjIxMjBLcU
	 lufjwuzkDgMaPXm84KiqKLbk3tOW5JB7TRFw9qWI=
Date: Thu, 4 Jul 2024 13:53:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 3/6] misc: sbrmi: Use regmap subsystem
Message-ID: <2024070400-sweat-playback-3a80@gregkh>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-4-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704111624.1583460-4-akshay.gupta@amd.com>

On Thu, Jul 04, 2024 at 11:16:21AM +0000, Akshay Gupta wrote:
> - regmap subsystem provides multiple benefits over direct smbus APIs

In what way, please document.

> - The susbsytem can be helpful in following cases
>   - Differnet types of bus (i2c/i3c)
>   - Different Register address size (1byte/2byte)

Is that what is happening here?  I don't see i3c support...

> --- a/include/misc/amd-sb.h
> +++ b/include/misc/amd-sb.h
> @@ -7,8 +7,8 @@
>  #define _AMD_SB_H_
>  
>  #include <linux/mutex.h>
> -#include <linux/i2c.h>

Why remove this?

>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  /*
>   * SB-RMI supports soft mailbox service request to MP1 (power management
>   * firmware) through SBRMI inbound/outbound message registers.
> @@ -23,11 +23,11 @@ enum sbrmi_msg_id {
>  
>  /* Each client has this additional data */
>  struct sbrmi_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
>  	struct mutex lock;
>  	struct platform_device *pdev;
>  	u32 pwr_limit_max;
> -};
> +} __packed;

Why is this suddenly required to be __packed?

Isn't that going to cause more problems than it is worth?  And why is it
worth it at all?

thanks,

greg k-h

