Return-Path: <linux-kernel+bounces-443084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DA9EE6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7D1884E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE4213225;
	Thu, 12 Dec 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlRhPL1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45842204F97;
	Thu, 12 Dec 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007062; cv=none; b=fWMFQta1CnJzzu5oX8ToSDpC+1gJYBxlVK5B+bNU7lO7PtQpn5row5TnDMwz7FCLSBSomBHczf00lcgwP+XgJz5nxDKFjMuN3oyKnl3xqCdXOqitDAgUaicrMpvkzlmxZ0Bv7Fm9OxPCMqRKJofdoTMImZKuZwcPfam4UbmOx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007062; c=relaxed/simple;
	bh=3x4KC8UL/1Qd72jHooAzL+mZhJz7ddYHIBEY7oZJjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRWHoVbKMhGAuuQNtxzxL5lNDn3WcKhJnnxUeogfTLOVhkLzk4AFdJw/B9Hij1Xit+p/cD4tn+E8GOEd1RoiBt+sL94lyzKZ0n+9RjK9BsA5J9G+LuF7GTlIuRFoXLQL+UrSwoTTBw4P1lA84uI611bJVFqOzQtJGGBhl/Y5Cwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlRhPL1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8284C4CECE;
	Thu, 12 Dec 2024 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734007060;
	bh=3x4KC8UL/1Qd72jHooAzL+mZhJz7ddYHIBEY7oZJjS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FlRhPL1EmZcHWh2+2bb7jaHVg6DSfVWvj8N6LKE5AdgE7M7Mq2tUtVSHFo2sz2QaD
	 x4kYTPO4cGCKWpoqIKkDfSTE6m00mSPMpV5rQohKYUjAE8nolFQR7G1iDR8qjYtNQR
	 N+KPFkTr2UQKzudxrvI14P5ebL2jH6N54mTe9Mbpa//eLyzN29T77m710dmSSNjYkU
	 NPeUoZW5Fsvw1Y9baGy6YENC+4G6C0gif3YMd7h8eS3Kr8yvEvOVxvoBf1pcsMIqkb
	 qP5FqfG2ifsp7/Ow/bSwyVVlY1CGjZMuTTNmOlLvShn4CWYgT7BEYrAtX3VHfJu0SJ
	 5D4DpI9nb6X5Q==
Message-ID: <70aced7f-0311-43b9-96af-c8325c39ff2b@kernel.org>
Date: Thu, 12 Dec 2024 14:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] xhci: introduce xhci->lost_power flag
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-4-28a17f9715a2@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241210-s2r-cdns-v6-4-28a17f9715a2@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/12/2024 19:13, Théo Lebrun wrote:
> The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
> expect a reset after resume. It is also used by some to enforce a XHCI
> reset on resume (see needs-reset-on-resume DT prop).
> 
> Some wrappers are unsure beforehands if they will reset. Add a mechanism
> to signal *at resume* if power has been lost. Parent devices can set
> this flag, that defaults to false.
> 
> The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
> controller. This is required as we do not know if a suspend will
> trigger a reset, so the best guess is to avoid runtime PM.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/host/xhci.c | 3 ++-
>  drivers/usb/host/xhci.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 5ebde8cae4fc44cdb997b0f61314e309bda56c0d..ae2c8daa206a87da24d58a62b0a0485ebf68cdd6 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1017,7 +1017,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>  
>  	spin_lock_irq(&xhci->lock);
>  
> -	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
> +	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME ||
> +	    xhci->broken_suspend || xhci->lost_power)
>  		reinit_xhc = true;
>  
>  	if (!reinit_xhc) {
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 4914f0a10cff42dbc1448dcf7908534d582c848e..32526df75925989d40cbe7d59a187c945f498a30 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1645,6 +1645,12 @@ struct xhci_hcd {
>  	unsigned		broken_suspend:1;
>  	/* Indicates that omitting hcd is supported if root hub has no ports */
>  	unsigned		allow_single_roothub:1;
> +	/*
> +	 * Signal from upper stacks that we lost power during system-wide
> +	 * suspend. Its default value is based on XHCI_RESET_ON_RESUME, meaning
> +	 * it is safe for wrappers to not modify lost_power at resume.
> +	 */
> +	unsigned                lost_power:1;

I suppose this is private to XHCI driver and not legitimate to be accessed
by another driver after HCD is instantiated?
Doesn't access to xhci_hcd need to be serialized via xhci->lock?

Just curious, what happens if you don't include patch 4 and 5?
Is USB functionality still broken for you?

Doesn't XHCI driver detect that power was lost and issue a reset in any case
via the below code

        /* re-initialize the HC on Restore Error, or Host Controller Error */
        if ((temp & (STS_SRE | STS_HCE)) &&
            !(xhci->xhc_state & XHCI_STATE_REMOVING)) {
                reinit_xhc = true;
                if (!xhci->broken_suspend)
                        xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
        }

>  	/* cached extended protocol port capabilities */
>  	struct xhci_port_cap	*port_caps;
>  	unsigned int		num_port_caps;
> 

-- 
cheers,
-roger


