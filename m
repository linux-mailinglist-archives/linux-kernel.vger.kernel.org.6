Return-Path: <linux-kernel+bounces-185761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07198CBA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BADE283316
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7A762E8;
	Wed, 22 May 2024 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m9v8mX+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDC2F52;
	Wed, 22 May 2024 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716352593; cv=none; b=qBQYvlYz/DUfAdYwXkFqXrr77Qq4KEiZh80n8bymq2O/ZO0uuyPMyVfyAepIIl+DoTSWn+wafHWDdx97BZ06qEsjoeklpQjFFHx5bj3edy1IalnJ1o6Ry1d4qTkRMfnHVZL9qlvS0Fngv4owJ5PgoDoA2Bg4xMP7NXWZ/jss+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716352593; c=relaxed/simple;
	bh=QA7KShsUQ/RqITaPfqex+wYI2Yrs6IAY1kjDju6QTFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PapsW+u1iQ6jajrE7N1htV6BhV2OlrVaCXjYnhXyVcPqCNIhULqtTjgB7MyvoT3EJ3PaXfnKK1AhaDNNYCZJOowRJIJc0BDDUWwoVTWSAmNA6JeYzgur+X1dNMMYiojvczIAqUsAD99MJglILO6s0Uy/f7XttMtMkb+7hyW5TGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m9v8mX+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA74C3277B;
	Wed, 22 May 2024 04:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716352593;
	bh=QA7KShsUQ/RqITaPfqex+wYI2Yrs6IAY1kjDju6QTFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9v8mX+ihy9Kc94TjWOHjXOuwYKB75DUqOj6FLjz32lG9vvyHT9QMEIkI6sy4yqKt
	 PKcWwnGN12/wlLzHTkQ/Nl0qmUWMbWdrfhRQtbSRQXFtsvuNDO6rAmhAvO9POoPa0X
	 fOAuM9oP2ITc9QuZZ+GdA+PgxKKVAYIeNUBLZcR8=
Date: Wed, 22 May 2024 06:36:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI
 host
Message-ID: <2024052204-freehand-say-198c@gregkh>
References: <20240522023918.7613-1-ki.chiang65@gmail.com>
 <20240522023918.7613-2-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522023918.7613-2-ki.chiang65@gmail.com>

On Wed, May 22, 2024 at 10:39:18AM +0800, Kuangyi Chiang wrote:
> As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk for
> asrock p67 host"), EJ188 have the same issue as EJ168, where completely
> dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.
> 
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> ---
>  drivers/usb/host/xhci-pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index ef513c2..a0beb41 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -31,6 +31,7 @@
>  
>  #define PCI_VENDOR_ID_ETRON		0x1b6f
>  #define PCI_DEVICE_ID_EJ168		0x7023
> +#define PCI_DEVICE_ID_EJ188		0x7052
>  
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
> @@ -238,6 +239,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  	}
> +	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> +			pdev->device == PCI_DEVICE_ID_EJ188) {
> +		xhci->quirks |= XHCI_RESET_ON_RESUME;
> +	}

Same question as on other patch, should this be backported to older
kernels too?

thanks,

greg k-h

