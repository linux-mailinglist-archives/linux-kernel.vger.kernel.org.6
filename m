Return-Path: <linux-kernel+bounces-232395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9B791A82C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C73B25991
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C11946DC;
	Thu, 27 Jun 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fHe0dy1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B0193099;
	Thu, 27 Jun 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495817; cv=none; b=kfOfFyg4iq+Ielu4lRi6rf5l5mTPe8vSmwPp5vPb1S16r9ojvwiWmhUDOB7Bcmlujx7mCt3w8WUY6DxyzIy9hVYn5ZdPF470fqXiyZwPCqNcaHjqWNOfwesv5ztkG6enkCUmP7zSojnKZzSuLXNWconwINqdroymtKEanQcIYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495817; c=relaxed/simple;
	bh=30Wm+FYaFO0J1IOIq8JikGpZH8vrEpCw4Kk7PBmsFu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kArhBxzndH1yif/aiuWu1Ghnvp7y0ZVPHXJjONqh4LbgNVto5OTLrvzLl3uPw4a0EwLhbwVVDFVI1YwBXieI2pU75FBkgv3zF9llUf05Qp24D1dH1iRUHBj7EG/DJNAs1jLvZW55hfHOQ9fankYDlTKVLR+A9ER9PZRypsvKwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fHe0dy1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C132C2BBFC;
	Thu, 27 Jun 2024 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719495816;
	bh=30Wm+FYaFO0J1IOIq8JikGpZH8vrEpCw4Kk7PBmsFu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHe0dy1krUDyOXirrwxUHDrggA6kVJ+y8fe9Isp2Ws9HaKGAzNCPJWI5d3k7rfw9h
	 Q2EkhWN/MXoG5EQpPj86pOZg/KAPb1JF07hV8Uz7B1M6fC4KsQJDg9nUc1yogUby3F
	 XqZtGpm/QYt4Rgfd/yb0uYHubpLUek4XhZW+xpb8=
Date: Thu, 27 Jun 2024 15:43:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yusef Aslam <yuzi54780@outlook.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
Message-ID: <2024062727-diabolic-lusty-7baf@gregkh>
References: <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>

On Wed, Jun 26, 2024 at 01:56:34PM +0100, Yusef Aslam wrote:
> From: Yusef Aslam <YUZi54780@outlook.com>
> Date: Wed, 26 Jun 2024 13:02:02 +0100
> Subject: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment

This all should not be in the body of the email, please use a tool like
'git send-email' to send patches.


> 
> Fix alignment.

We need more description than that, right?  What would you want to see
here?

> 
> Signed-off-by: Yusef Aslam <YUZi54780@outlook.com>
> ---
>  v3:
>  - Used the correct email addresses.
>  - Developed against the correct git repository.
>  v2:
>  - The email address of Greg Kroah-Hartman was wrong.
>  - Developed against the wrong git repository.
>  v1:
>  - Developed against the wrong git repository.
> 
>  drivers/staging/rtl8192e/rtllib_rx.c | 110 +++++++++++++--------------
>  1 file changed, 55 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index 84ca5d769b7e..1f6c4a3de5c2 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -410,7 +410,7 @@ static bool add_reorder_entry(struct rx_ts_record *ts,
>  	while (list->next != &ts->rx_pending_pkt_list) {
>  		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
>  		    list_entry(list->next, struct rx_reorder_entry,
> -		    list))->SeqNum))
> +			       list))->SeqNum))
>  			list = list->next;
>  		else if (SN_EQUAL(pReorderEntry->SeqNum,
>  			((struct rx_reorder_entry *)list_entry(list->next,
> @@ -736,7 +736,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
>  	/* just for debug purpose */
>  	SeqNum = WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
>  	if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
> -	   (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
> +	    (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
>  		is_aggregate_frame = true;
>  
>  	if (RTLLIB_QOS_HAS_SEQ(fc))
> @@ -876,13 +876,13 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
>  	frag = WLAN_GET_SEQ_FRAG(sc);
>  
>  	if (!ieee->ht_info->cur_rx_reorder_enable ||
> -		!ieee->current_network.qos_data.active ||
> -		!is_data_frame(skb->data) ||
> -		is_legacy_data_frame(skb->data)) {
> -		if (!ieee80211_is_beacon(hdr->frame_control)) {
> -			if (is_duplicate_packet(ieee, hdr))
> -				return -1;
> -		}
> +	    !ieee->current_network.qos_data.active ||
> +	    !is_data_frame(skb->data) ||
> +	    is_legacy_data_frame(skb->data)) {
> +	  if (!ieee80211_is_beacon(hdr->frame_control)) {
> +	    if (is_duplicate_packet(ieee, hdr))
> +	      return -1;
> +	  }

That's obviously not correct.  Did you run your patch through
checkpatch.pl after creating it?

thanks,

greg k-h

