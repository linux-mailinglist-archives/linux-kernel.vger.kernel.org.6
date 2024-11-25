Return-Path: <linux-kernel+bounces-421101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B69D8697
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A647289161
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE861AD3E5;
	Mon, 25 Nov 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwS/jUbh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F61547CA;
	Mon, 25 Nov 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541868; cv=none; b=Ioq6hjNBtWEMWdONL93msXSRJcX7aZoyTMJPwSLO8y1COFgRK4iZvzinlYLGJKwOStmfhW+XtMzVwnOQM33ul0wsfjOJ5XqND56vmn6pIlP8OvMpudmIDbrZgYgZTIlVNi0YorhTeVvEDGly8Yj3lhLY6IKxT8vS+/bEa5Rz1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541868; c=relaxed/simple;
	bh=bUE8IkDavlb4kDbCuhf4PTFugvZwU8SBUGcGkI/eTdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAYSnWwxOXtYq6apOxK1nYG/xPui0l3ltR8YDnhwA7PEjL92nML98L0HsFuLYqhrBqA2/agEcczMB+YPxgUA7H+X/MfWcdbbN9cD9n1zeLjEsgR310LU6eKe5Dq6sMwN9IDKQSrdlsqjRer4Whc5QQgML3i8s6wdwnkNPNP6w/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwS/jUbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6AEC4CECE;
	Mon, 25 Nov 2024 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732541867;
	bh=bUE8IkDavlb4kDbCuhf4PTFugvZwU8SBUGcGkI/eTdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwS/jUbhRz1mh+o65iXommayDoZdNYviSUxW0tE++eQAy79LrwzyynIUmcQrG7Mqa
	 zAYmAwC0NPeW2A6Va9BOW38/7jv0gJ6ny+KMYHP7qO+OFI3q81bS2iww33cXCUmxzs
	 bHu+APO1QPIVVlP0en3rvMR9Xtea7Ue6h9PmSnIA=
Date: Mon, 25 Nov 2024 14:37:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: philipp.g.hortmann@gmail.com, ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix broken code when cflag is used
Message-ID: <2024112500-authentic-primarily-b5da@gregkh>
References: <20241124200934.156252-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124200934.156252-1-rodrigo.gobbi.7@gmail.com>

On Sun, Nov 24, 2024 at 05:08:22PM -0300, Rodrigo Gobbi wrote:
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> As noticed at [1], hal_com.c is not compiling with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA due
> the changes at [2] (a few statements were not replaced with the new struct).
> A little discussion was made at [1] too about how useful this cflag was or if the
> code under the cflag should be deleted. I think there is no harm to keep those things
> as is since we can easily fix the error.
> Tks and regards.
> 
> [1] https://lore.kernel.org/linux-staging/f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain/T/#mffa281a89e67c609db9b125878d5b8d090776812
> [2] "staging: rtl8723bs: Rework 'struct _ODM_Phy_Status_Info_' coding style.", commit ec57f8641fbca07bbb61a75bd4760fd7aef86860
> ---
>  drivers/staging/rtl8723bs/hal/hal_com.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> index 95fb38283c58..63bf6f034f61 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> @@ -906,7 +906,7 @@ void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
>  	struct hal_com_data *pHalData =  GET_HAL_DATA(padapter);
>  	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
>  
> -	struct odm_phy_info *pPhyInfo  = (PODM_PHY_INFO_T)(&pattrib->phy_info);
> +	struct odm_phy_info *pPhyInfo  = (struct odm_phy_info *)(&pattrib->phy_info);
>  	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
>  
>  	psample_pkt_rssi->data_rate = pattrib->data_rate;
> @@ -919,8 +919,8 @@ void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
>  		psample_pkt_rssi->mimo_signal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
>  		psample_pkt_rssi->mimo_signal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
>  		if (!isCCKrate) {
> -			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
> -			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];
> +			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->rx_pwr[rf_path];
> +			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->rx_snr[rf_path];
>  		}
>  	}
>  }
> -- 
> 2.47.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

