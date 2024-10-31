Return-Path: <linux-kernel+bounces-391429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C19B869A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDA41F21A81
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8A61CC8AF;
	Thu, 31 Oct 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KtUlIP/+"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E51991AB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415919; cv=none; b=cEVtlR7vUjtVhQmCnh6MJUaKYmT3oz9g83gp4zazRe9qRAZ6tmjVCb/v/2YqwHzT6yx/a+dpOnMjEKuXQOJD9TNkkOj8uYPdi61I+0L2FpVnAU095siRD3/eZF0Av2nOaJqaw47qhLy0eThLyzh7ceUy6isiOuRqXjYTy8ejC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415919; c=relaxed/simple;
	bh=JSPJoseVhvZZUGHK2Re3tXHoz2m4trCmx6dyIFdwlqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7iPQRDwhf0xA4i1nj+wKc9RZTNIqEJWWHEn1wC/aK5c7jUqAJq8s/bJ3+iLoKG3J5KxtxeUnKDFKAtIvsi/F/rB40aTGQzOmFBXYtDA1TIccIaglOJSohNqhHWk3+ICWisd8U1/MWovUMar2LXcLWDKUpKz3NIwDBdFFWnZRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KtUlIP/+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CD3A60005;
	Thu, 31 Oct 2024 23:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730415910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+dr+WbouWG08b3ueIX4Ar5hKem1okbqw/Lq5iSFgUBY=;
	b=KtUlIP/+1X3FlzencxuXhU9kmKLoGem34if3sYm6TSxFs6N6B0tVriuTFhAOXx1scg/8ox
	hpaleZngpo++WjSkA/PVPyT8i5CDiE4acTYRWghHns3sxde74e7LUeKH7d14urA93suJlo
	5hGkQGdfGyv6rU6iGLAHOMBPm1yCxmOkP9CxIfD/yQaIN+JUDcSGsxwSuE9gIGKnJmRQlm
	TYmbu0LeYVbLcD/qLlf78AjWoVVq2j5qduDrIXM0vZCxUhEbTqPldYd5iy0qUG5fwr5onM
	CVbQOA0AuXGdghwygeUURSKdp03cQlkrlO4I4OJK+6bG9vzYW+DhbmPwulcDug==
Date: Fri, 1 Nov 2024 00:05:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"moderated list:SILVACO I3C DUAL-ROLE MASTER" <linux-i3c@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: Modify enabled_events bit 7:0 to
 act as IBI enable counter
Message-ID: <202410312305108f8c61cf@mail.local>
References: <20241024203855.1584416-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024203855.1584416-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 24/10/2024 16:38:55-0400, Frank Li wrote:
> Fix issue where disabling IBI on one device disables the entire IBI
> interrupt. Modify bit 7:0 of enabled_events to serve as an IBI enable
> counter, ensuring that the system IBI interrupt is disabled only when all
> I3C devices have IBI disabled.
> 
> Cc: stable@kernel.org
> Fixes: 7ff730ca458e ("i3c: master: svc: enable the interrupt in the enable ibi function")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

This doesn't apply on i3c/next after applying your patches, can you
rebase?

> ---
>  drivers/i3c/master/svc-i3c-master.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d1ebfba3739c1..66fe0fc12c897 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -130,8 +130,8 @@
>  /* This parameter depends on the implementation and may be tuned */
>  #define SVC_I3C_FIFO_SIZE 16
>  
> -#define SVC_I3C_EVENT_IBI	BIT(0)
> -#define SVC_I3C_EVENT_HOTJOIN	BIT(1)
> +#define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
> +#define SVC_I3C_EVENT_HOTJOIN	BIT(31)
>  
>  struct svc_i3c_cmd {
>  	u8 addr;
> @@ -214,7 +214,7 @@ struct svc_i3c_master {
>  		spinlock_t lock;
>  	} ibi;
>  	struct mutex lock;
> -	int enabled_events;
> +	u32 enabled_events;
>  };
>  
>  /**
> @@ -1532,7 +1532,7 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>  		return ret;
>  	}
>  
> -	master->enabled_events |= SVC_I3C_EVENT_IBI;
> +	master->enabled_events++;
>  	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
>  
>  	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
> @@ -1544,7 +1544,7 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
>  	struct svc_i3c_master *master = to_svc_i3c_master(m);
>  	int ret;
>  
> -	master->enabled_events &= ~SVC_I3C_EVENT_IBI;
> +	master->enabled_events--;
>  	if (!master->enabled_events)
>  		svc_i3c_master_disable_interrupts(master);
>  
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

