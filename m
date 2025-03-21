Return-Path: <linux-kernel+bounces-571278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A224EA6BB43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C89162B50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EEE229B30;
	Fri, 21 Mar 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yS3K6222"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B995216E01;
	Fri, 21 Mar 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561614; cv=none; b=rDFHC6b5VNb2Yz0lc/oDBcssuDU2651Z9Qe5jTe72zrhRp8JvHFu4IU+7Zs1FA5on/FOVC4KZh4Z8Ne8uWZLY551thOyKbQwpXZ8oGDL7bEfQIEy8fItUpX0Egpl+Zo1HMRv4WMbsT9H8lfijZnOxqsfV2B7cJH98ZLoJvVWiqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561614; c=relaxed/simple;
	bh=s/cUC2OPWQPcceRiqmx99A3AD3Pmhwe/P6u+rDHTNwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+bx2Fq730dqgwn4zORBNa30gNbCTKBL6RS8PdCvyAsM2hL8/2Cw/wem+PwKdE9jjoyx4LHdih7nYIgxLbyGCZnP9Wl5zfX365enzu+TX8omCJPSqlf+A622bh7l3bvy7lYvEVh2uHetMcU1zm9suFh67exQOQxfrhhsW9zjxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yS3K6222; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801F2C4CEE3;
	Fri, 21 Mar 2025 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742561613;
	bh=s/cUC2OPWQPcceRiqmx99A3AD3Pmhwe/P6u+rDHTNwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yS3K6222ngRFce9hgjH2AtwZ2HHZZb7jM/2B/lt7q42vRMupty7s+YkHXl4NNnMkP
	 Lboqlxr9aEtmghcnWGyYtiQqi6cLSCTkCwR0zjLExuTP4b596G8xCmL9quB63YaPOu
	 O8CEjZ6CGGcXUrYY/OY5j7I1eIs7mbQSCNI4Nmfc=
Date: Fri, 21 Mar 2025 05:52:13 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: ErickKaranja <karanja99erick@gmail.com>
Cc: hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
	outreachy@lists.linux.dev, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix line length issue
Message-ID: <2025032148-backfield-crux-184d@gregkh>
References: <20250321115545.24468-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321115545.24468-1-karanja99erick@gmail.com>

On Fri, Mar 21, 2025 at 02:55:45PM +0300, ErickKaranja wrote:
> Fix line length exceeding 100 columns in arche-platform.c. The code now
> follows Linux kernel coding style guidelines by keeping lines under the
> maximum allowed length of 100 characters.
> 
> Reported by checkpatch:
> 
> CHECK: line length of 101 exceeds 100 columns
> 
> Signed-off-by: ErickKaranja <karanja99erick@gmail.com>
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

With this change, you will now have added a different checkpatch
warning.  So the original should stay as-is, sorry.

thanks,

greg k-h

