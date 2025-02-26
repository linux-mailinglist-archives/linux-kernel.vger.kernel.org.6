Return-Path: <linux-kernel+bounces-534740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BEBA46A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840B11889A50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44FF237194;
	Wed, 26 Feb 2025 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="qVx7MQzd"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376221E096
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596823; cv=none; b=T5NteQJgMfd+7r7alGOhNmyvYTDz5hpPgxymJWSARFue3nE7W33IoRsN5dzVs2qjnBRARfWtmeh5rykO9DKT/3RcESdLZ+GZDMOKMHRPEc8yL+B+M2nxd0Z/Nmv84Wm2ZnhxwzXrytNYUkg9e6o0eCulCf/JHWmVRdntwQaGqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596823; c=relaxed/simple;
	bh=PlUexOYImPj5tei0xk01zKpou5g/+w1rF72lF5C1g6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhyGuInx9Df5+utpQsI+1k9pNb2626rHEW/7YQMbTNJ7sPbTcfSEEULX8UwNhUIgu8UcDJ2qF+CCzD8EmZWhBBSmLJBOEGQjGPK/n5kwEd1TVmOEiNs4Em3ldMZ3sYEqwDLqV+XYieM82zyGVF3FI1KQnSjY0ZA3R7jiemFtz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=qVx7MQzd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Wed, 26 Feb 2025 14:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740596808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw42xid+WUwsyTXO3dfqODQosn1SYPoGt8Yoqu9g61Y=;
	b=qVx7MQzdPH944+qyXMOoDK5ZWsYeILr/Ab+IeBjUCMmdn7V8E82fLSi3f2zKvfsAMqW9a2
	vmJZ8yINouV+QYKzS/5a7UoTY8xh3E2Lce6JiN0RyKEZ5wPQGkNxcbAnK/pso4QmeKIXKP
	OOUdPOBznVg19MBbxRYhe7pPY7BFjSMZfpIguTK9LE3g/Q1gHYtul+9wN42VIF33nGzC/W
	XZ6tg2jLzRQZO8nz32FC49Yl8EWv4DBp9C/YH0euIaGEi+NWDheeQcAyCWARRaVhQkr0A+
	8PTQxj4z4mubk/OHsoj3zw9qCFq56k4rCvrs3UivpsffJU4zksmqGIKkvVBc/g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: apple: rtkit: Add and use PWR_STATE_INIT
 instead of _ON
Message-ID: <Z79mQqfYQH_rituh@blossom>
References: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
 <20250226-apple-soc-misc-v2-1-c3ec37f9021b@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226-apple-soc-misc-v2-1-c3ec37f9021b@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Wed , Feb 26, 2025 at 07:00:03PM +0000, Sven Peter via B4 Relay a écrit :
> From: Janne Grunau <j@jannau.net>
> 
> This state is needed to wake the dcp IOP after m1n1 shut it down
> and works for all other co-processors as well.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/soc/apple/rtkit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index 2f5f878bf899..be0d08861168 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -12,6 +12,7 @@ enum {
>  	APPLE_RTKIT_PWR_STATE_IDLE = 0x201, /* sleeping, retain state */
>  	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10, /* running but no communication */
>  	APPLE_RTKIT_PWR_STATE_ON = 0x20, /* normal operating state */
> +	APPLE_RTKIT_PWR_STATE_INIT = 0x220, /* init after starting the coproc */
>  };
>  
>  enum {
> @@ -898,7 +899,7 @@ int apple_rtkit_wake(struct apple_rtkit *rtk)
>  	 * Use open-coded apple_rtkit_set_iop_power_state since apple_rtkit_boot
>  	 * will wait for the completion anyway.
>  	 */
> -	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_ON);
> +	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_INIT);
>  	ret = apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE,
>  					  msg);
>  	if (ret)
> 
> -- 
> 2.34.1
> 
> 

