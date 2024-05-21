Return-Path: <linux-kernel+bounces-184615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5BC8CA99D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E02BB22987
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1059654762;
	Tue, 21 May 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XpBBKJUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D386482DA;
	Tue, 21 May 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278740; cv=none; b=syKPlkWp/OPdtA8W/E7dYa33iApxpVVzHXoSjI9I2R7LC0vBC+EP31iKc/xMV7+7AnrlsON8FtbqqkQDxIX43hMBR9WzQGXY/RIq7ldLfQBg4U494sfxmWfcN/gsBR5pOMiu5Om6RmOLZxtk2/IQUTYiAKgAYfH3ydW7TshBS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278740; c=relaxed/simple;
	bh=DTyi1eSDn6BAI8YPWjUVlHpylLqWA8Tpr2CtxKs8Mfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3YYfLylBkGxzmE/urmoMFhcpwn9X4nFA9K4+9UAtswlyZlvbwOCf3850WsF8wFu2PqONGbCg7DXJIdOVO8Mi4pS5I0ey6Y2JzvxqbOuAN8xVBRaOxRJjWSN59NjRZLDJiM09G2TCliW/55Uy9H/Paa/E8UHxisPvxAOYzq5tnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XpBBKJUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5461BC2BD11;
	Tue, 21 May 2024 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716278739;
	bh=DTyi1eSDn6BAI8YPWjUVlHpylLqWA8Tpr2CtxKs8Mfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpBBKJUbTIH/9tDz5/FEP712Xms07++YuBmRHV/R5iYTcho2JKXcCbMnkrFW2VYi2
	 lU1Sc5gWnDo1cvBsNniLs1Z9YhyuLV/EShGKcuPJb39oOSh8Xrmbteiyy1ctq3nUeW
	 urDaY/8ZOAx90FMha3eHB7RsBMMqSTlPnNmkQX1I=
Date: Tue, 21 May 2024 10:05:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Akash Kumar <quic_akakum@quicinc.com>
Cc: Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
	Pratham =?iso-8859-1?Q?Pratap=A0?= <quic_ppratap@quicinc.com>,
	Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: pci-quirks: Skip usb_early_handoff for Renesas PCI
 USB
Message-ID: <2024052134-roundness-foyer-7bfa@gregkh>
References: <20240521074635.17938-1-quic_akakum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521074635.17938-1-quic_akakum@quicinc.com>

On Tue, May 21, 2024 at 01:16:35PM +0530, Akash Kumar wrote:
> Skip usb_early_handoff for the Renesas PCI USB controller due to
> the firmware not being loaded beforehand, which impacts the bootup
> time.
> 
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>

What commit id does this fix?  Should it go to stable kernels?

> ---
>  drivers/usb/host/pci-quirks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 0b949acfa258..a0770ecc0861 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1264,6 +1264,11 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
>  		}
>  	}
>  
> +	/* Skip handoff for Renesas PCI USB controller on QCOM SOC */
> +	if ((pdev->vendor == PCI_VENDOR_ID_RENESAS) &&
> +			(pcie_find_root_port(pdev)->vendor == PCI_VENDOR_ID_QCOM))

Why are all Renesas PCI devices on a QCOM host to be marked this way?
That's a very big hammer for potentially lots of devices.  Have you
tested them all?

thanks,

greg k-h

