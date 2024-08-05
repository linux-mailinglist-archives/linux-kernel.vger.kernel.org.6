Return-Path: <linux-kernel+bounces-274734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27F947C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC04F2815E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288E439ADD;
	Mon,  5 Aug 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0nU9vy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18836AEC;
	Mon,  5 Aug 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865319; cv=none; b=O4NLVjuK/xycHcNj874ofV21goSbizHPLJ4a18vbsMAagvhfOLIwXVNF72/KSIbIjUmNrQjJEVn+0Ld9cZs9G9Klrsv8LF3eh7iamTa5p6y3IvNN0Cvrez5yT3XSmAguln6FjOFUrOUeGCnW6XfYgpVoonF/OFmk85wN/h8+Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865319; c=relaxed/simple;
	bh=iTK51eVs3lIrDUEMAnPJgIK0M1ZWpTpCLF/jpClvAuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4JNfTTqxb6VfpcuPfH1lgs7C1Q8UANOTnObpT7GWiFselE1F2aEAhBoGs4heORQuLYzhBW8LYqA9MOWT5ABe1EBcXSzgu1lmrI1lGIK5861ECvTtNBSgMCbh79YJjCgjx2C2VenfiLrogV9aPFl0gWUf4zNHaDzDR7Ulm6wKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0nU9vy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F3C32782;
	Mon,  5 Aug 2024 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722865319;
	bh=iTK51eVs3lIrDUEMAnPJgIK0M1ZWpTpCLF/jpClvAuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s0nU9vy22dh3PXweEa8DUwGXbYBl0DZe3NFoL5yI8om5TDVe7iULiWjljN2IyJKl/
	 vu0hWSjfhuHkFdHnQwccEWHKr3aJQL/9n2pR0kUK2+zFV+l+8hO7rz+I6y21zsIw3C
	 a2zgdFlBfT1a4yb2i/R+jMSIRQTT7njDnCKbIPKl913TDEpVOcr3FdZeKwL2lTrhxF
	 BIkQjV5XizxCUfoM2puYE5pynK6SnX9j2itUSFaDahhix1fF4H11YuEEXtvKQCLGnJ
	 kcWFhIR8Jlv1yjXfpeCJUSdohkKOEuUYBuDvlMrwZPQ1Unof3IwZcH20nKX4oA55W+
	 ADEvBcyDRwevA==
Message-ID: <1cd45625-84e4-43aa-ae2b-a59f10add898@kernel.org>
Date: Mon, 5 Aug 2024 16:41:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] xhci: introduce xhci->lost_power flag
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-9-8664bfb032ac@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-9-8664bfb032ac@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 21:17, Théo Lebrun wrote:
> The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
> expect a reset after resume. It is also used by some to enforce a XHCI
> reset on resume (see needs-reset-on-resume DT prop).
> 
> Some wrappers are unsure beforehands if they will reset. Add a mechanism
> to signal *at resume* if power has been lost. Parent devices can set
> this flag, that defaults to the XHCI_RESET_ON_RESUME value.
> 
> The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
> controller. This is required as we do not know if a suspend will
> trigger a reset, so the best guess is to avoid runtime PM.
> 
> Reset the xhci->lost_power value each time in xhci_resume(), making it
> safe for devices to only set lost_power on some resumes.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/host/xhci.c | 8 +++++++-
>  drivers/usb/host/xhci.h | 6 ++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 0a8cf6c17f82..2c9b32d339f9 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1029,9 +1029,12 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>  
>  	spin_lock_irq(&xhci->lock);
>  
> -	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
> +	if (hibernated || xhci->lost_power || xhci->broken_suspend)

Why not treat xhci->lost_power and xhci->quriks & XHCI_RESET_ON_RESUME independently?

XHCI_RESET_ON_RESUME is sued by devices that know they always need to be reset on resume.

xhci->lost_power is used by devices that don't have consistent behavior.


>  		reinit_xhc = true;
>  
> +	/* Reset to default value, parent devices might correct it at next resume. */
> +	xhci->lost_power = !!(xhci->quirks & XHCI_RESET_ON_RESUME);
> +

then you don't need to do this.

>  	if (!reinit_xhc) {
>  		/*
>  		 * Some controllers might lose power during suspend, so wait
> @@ -5228,6 +5231,9 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>  	if (get_quirks)
>  		get_quirks(dev, xhci);
>  
> +	/* Default value, that can be corrected at resume. */
> +	xhci->lost_power = !!(xhci->quirks & XHCI_RESET_ON_RESUME);
> + 

nor this.

>  	/* In xhci controllers which follow xhci 1.0 spec gives a spurious
>  	 * success event after a short transfer. This quirk will ignore such
>  	 * spurious event.
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index ebd0afd59a60..ec7c6061363f 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1640,6 +1640,12 @@ struct xhci_hcd {
>  	unsigned		broken_suspend:1;
>  	/* Indicates that omitting hcd is supported if root hub has no ports */
>  	unsigned		allow_single_roothub:1;
> +	/*
> +	 * Signal from upper stacks that we lost power during system-wide
> +	 * suspend. Its default value is based on XHCI_RESET_ON_RESUME, meaning
> +	 * it is safe for wrappers to not modify lost_power at resume.
> +	 */
> +	unsigned                lost_power:1;
>  	/* cached extended protocol port capabilities */
>  	struct xhci_port_cap	*port_caps;
>  	unsigned int		num_port_caps;
> 

-- 
cheers,
-roger

