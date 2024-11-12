Return-Path: <linux-kernel+bounces-405772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEDC9C56CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762C91F21CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93632309AF;
	Tue, 12 Nov 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+/O4UE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26885230998
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411708; cv=none; b=gjndxjedNY4b/4y9Njoe9P7L3Nsh3oXDjaWh2sT/P5J5F9+qiCg8S2WSrlko/hyvd3hkUXHrwAHYDkRDKSL+CirACBgN9gwwTGgJgthy8E4Tnj9gygTMDyYFI03uK0VHLo9oYXPKqzG8vc72gKLq8xpkD6AIyz0YvuQRcrujWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411708; c=relaxed/simple;
	bh=2wZSzH7pvz67tdUpdQtyltg4Ed6kSooBzLCrgnuhF3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5PS3h7t5lRW63q1GQSH3l7Z1AAxjebI++E05YCRhQZE8brfbjvbOcDab7e+7SmRlwWHlrAqubtUqi9QCQuAvFrsBI5hk6JS+Ba5LHVaCQ/Tb5moJ9eygObWwAK4CAywxVIymlZfkLKDWfx0oomyqENd7qGiwaEnb/kBGbyqCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+/O4UE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097D1C4CED0;
	Tue, 12 Nov 2024 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731411707;
	bh=2wZSzH7pvz67tdUpdQtyltg4Ed6kSooBzLCrgnuhF3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+/O4UE4Y08chN7AT6gFCOkFkMmmaijUJnsWcB8z5FduZlpE1XmMrjftPTYps9RZM
	 mpE5m6WTCmGuOXq77VwegTMD8w2tG0bv2b0YT3XG6g5T2rlBsz8J3evNqRquqJ9jm5
	 GDf8INtPavoAAxYDN7m8EtZ0+NibMobJTgpexuzc=
Date: Tue, 12 Nov 2024 12:41:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] drivers: core: clear wake irq in device_unbind_cleanup
Message-ID: <2024111207-baggie-eskimo-d2b0@gregkh>
References: <20241111092131.1693319-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111092131.1693319-1-peng.fan@oss.nxp.com>

On Mon, Nov 11, 2024 at 05:21:30PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With dev_pm_clear_wake_irq in device_unbind_cleanup, there is no need
> to invoke dev_pm_clear_wake_irq in driver remove hook explicitly.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/base/dd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f0e4b4aba885..ea3a871bdd11 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -26,6 +26,7 @@
>  #include <linux/wait.h>
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/pinctrl/devinfo.h>
>  #include <linux/slab.h>
>  
> @@ -556,6 +557,7 @@ static void device_unbind_cleanup(struct device *dev)
>  		dev->pm_domain->dismiss(dev);
>  	pm_runtime_reinit(dev);
>  	dev_pm_set_driver_flags(dev, 0);
> +	dev_pm_clear_wake_irq(dev);

I don't understand, you say you don't need to invoke it, yet you are
calling it here.

What commit id does this fix?  And what bug is this resolving?  What
drivers are broken without this?

thanks,

greg k-h

