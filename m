Return-Path: <linux-kernel+bounces-571267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E1A6BB20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D2F4A06C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915BF22A80F;
	Fri, 21 Mar 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="L+OZKske"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DA22A7EC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561327; cv=none; b=Bc5YqFiWZobEzgJT23vbb/rUBwpUyk6b+GnmOG4eNv7jN2mjdAXDdxe9n+trU/nAPE1fsWypSM+iisBnp4suFnB76fRf1vpi3/NeKy5YGDRYL+QJ75SFez0mJ8hXHU3OWFn8ieZTKjK6/S8evvSLJy3O1OS8dDxzbTRttjLR0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561327; c=relaxed/simple;
	bh=NYcHJNxyZ9+rvmxXGqAb0ox3MsNaXlPwV/4WXFK3lY8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i9w2TFtoGihdQqkKzHsMtv/NrWRKAhZHYX03gpHox78aLbgTRaU+Ge2GvNw2Mj5x5Wf8H1iGM2yB7HPf9SYR9/czzX+tJv0IjkRNO92R5sBXwydMyfuo+ZNv88s9TS0I6KHEw0OH4g1CtZGrQWczkeIeMynEPz+7tCrkmxk0TXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=L+OZKske; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HN+q68AfhJlHYLdy8aJOhr17kmYyQWHhDqqu4ktSByQ=;
  b=L+OZKskewizHh8c8ye2DG0WN1rJjlniH+DVXOOObfLltyPwtoyaeTbh9
   axMankDwr5H0+JAa2bKnwsCxlJ1/x9uYLQ5yx6XqhAyw8qHRY5HmQORa0
   Q98lQaA+5pzVYibzIcARmOOHHcITy/6qiJ0NCexKg0eQqFxk9cb7TaD8Y
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214125366"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:48:43 +0100
Date: Fri, 21 Mar 2025 13:48:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: ErickKaranja <karanja99erick@gmail.com>
cc: hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org, 
    gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
    greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix line length issue
In-Reply-To: <20250321115545.24468-1-karanja99erick@gmail.com>
Message-ID: <15e28afa-6faa-4e3e-d92a-b06a3e3b474@inria.fr>
References: <20250321115545.24468-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 21 Mar 2025, ErickKaranja wrote:

> Fix line length exceeding 100 columns in arche-platform.c. The code now
> follows Linux kernel coding style guidelines by keeping lines under the
> maximum allowed length of 100 characters.

Thanks for the patch.

In your log message you can try to avoid the word "Fix".  Probably most
patches fix something, so it doesn't give much information.  And it
doesn't say anything about how you fixed it.  Here it could be "Reduce a
line that exceeds 100 columns".  You don't have to mention the file name,
because one can easily see that from looking at the patch.

>
> Reported by checkpatch:
>
> CHECK: line length of 101 exceeds 100 columns
>
> Signed-off-by: ErickKaranja <karanja99erick@gmail.com>

Here you should have Erick Karanja, not ErickKaranja.

thanks,
julia

> ---
>  drivers/staging/greybus/arche-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index d48464390f58..1a82a7a3991c 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -179,8 +179,8 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  				 */
>  				if (arche_pdata->wake_detect_state !=
>  						WD_STATE_COLDBOOT_START) {
> -					arche_platform_set_wake_detect_state(arche_pdata,
> -									     WD_STATE_COLDBOOT_TRIG);
> +					arche_platform_set_wake_detect_state
> +						(arche_pdata, WD_STATE_COLDBOOT_TRIG);
>  					spin_unlock_irqrestore(&arche_pdata->wake_lock,
>  							       flags);
>  					return IRQ_WAKE_THREAD;
> --
> 2.43.0
>
>
>

