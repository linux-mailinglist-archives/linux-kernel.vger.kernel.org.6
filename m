Return-Path: <linux-kernel+bounces-244430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60192A42E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A8A1F21708
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5C13BAD7;
	Mon,  8 Jul 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wl4pPw3G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDC13B28A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447073; cv=none; b=PggTmQGMrshWft1tD2DBKNtRW0DycmSiHxJVp7y+A8/KJ9mpNnRM7HMu8DaZKt15LrYob/O/jFasI60FZ55dF/jdx/Envyj0U1/GavsR3ltKzZed9kVbrOxNfUm63iRzbiomGO82/OI7BeyiixrIvJgr6tebUbVsFBAWtPDqgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447073; c=relaxed/simple;
	bh=NI2Va0dIBPRlNMM8PxX0A+c89MMRxbHjIsBSrjHfro4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPTKpS1hNzn4VYiWI/+pYZxMBzjzZ+VcZj9UndmR+mkOGRLJwnL5B7XBgA0cuQ4qcOq8njdFaEfyZCAgvusFPjijHj57GZFna3/RtR0667+tu8Srur9Nx6KUNb1D1RDDuA3IjTnIONoAIOFm+9KGcqO16EK6NrLi+2Rr4+uV7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wl4pPw3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEF4C116B1;
	Mon,  8 Jul 2024 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720447072;
	bh=NI2Va0dIBPRlNMM8PxX0A+c89MMRxbHjIsBSrjHfro4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wl4pPw3G75v1J3FF/PtdqDy8acFTHGivUQNbU4l9zfH9dgom1XuCh0TSc8i1kpssN
	 E1v3/ZWrOHFfmbajpSnHrSDNfhiBLQzhMImi7pd08Pu+y87kD99URsDzz2mYr6XMSR
	 ISQqEsZNmPa8wkY+K5m/Mo0ucSIOxDqA1UpRmyyI=
Date: Mon, 8 Jul 2024 15:57:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver:core: no need to invert the return value of
 the call_driver_probe()
Message-ID: <2024070829-zen-remake-6bfa@gregkh>
References: <20240708134028.3508-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708134028.3508-1-sensor1010@163.com>

On Mon, Jul 08, 2024 at 06:40:28AM -0700, Lizhe wrote:
> If drv->probe() or drv->bus->probe() returns EPROBE_DEFER,
> then there is no need to invert the sign. Similarly,
> if it returns -EPROBE_DEFER, no sign inversion is needed either
> 
> In the probe function (either bus->probe() or drv->probe()),
> there is no return value of EPROBE_DEFER.
> v2:
>         Delete the judgment with the return value of EPROBEDEFER
>         from the _driver_probe.device()
> v1:
>         Add the judgment with the return value of EPROBEDEFER
>         from the _driver_probe.device()

Versions go below the --- line as the documentation says.

> Signed-off-by: Lizhe <sensor1010@163.com>

Full name?

thanks,

greg k-h

