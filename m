Return-Path: <linux-kernel+bounces-360947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C179299A198
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AEA1C2094F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A923212D09;
	Fri, 11 Oct 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG0eZNDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF901E379F;
	Fri, 11 Oct 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643148; cv=none; b=aousFuG5XFfcOyNIQw3L9m+V6SPqqt9e+bFdFU/j7tXNchpmn2Cck35SIFVFTOJfcRzzMV9F2/zJE3xi5JZqpH5I1EsvkcJcVjwd8BgEBe0ltMCh36jWMNzS8v5nvj3zEDsZ8fpAT24yZ6yg85349EA4wmtYQsipU/vT2IZANXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643148; c=relaxed/simple;
	bh=m/uivRhBGdbER5J7dNUMa5WSmZCH2Wba+rfmAp4dSBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myRv8OwFFkJz8saC405kO+2YqvfeQWMiaaG9Jg10XpW/r0NF4ymZ5gfbigEJm7rDF19ejKu8Rp29QmK7hfK7bxhyO8khO98TvS+Ng/kmy6VPOSP2me66Ke/ZSL4gSzKG/zJUjjsaUGk2E+GSVXAf9quQjV4Wh95VUwW4yCCnXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG0eZNDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9302CC4CECD;
	Fri, 11 Oct 2024 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728643147;
	bh=m/uivRhBGdbER5J7dNUMa5WSmZCH2Wba+rfmAp4dSBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WG0eZNDUYTZHrVsEm2ndhgjeyEVPl6Zv23sFPBVCSSmDJOO5A6CqL5ufFti1A0I6/
	 N7D3vuvzWrQA5wSJIV+3q7xhQDaYQlHyzJzivmQb5kKBte97H9701ZdrsUNjUFcD7w
	 xC3t8RZOZ5UB/tRDtgHuTtdwbqP6g8Uz+RoCzagRio7DyYl+TtSbvblg7BsrPJ4QTY
	 IYgbfanJl5tWXN3ZT6CuW0UKseB1wPFH8s4Lj7K8vF5ZQWkGGBnJjyev+8yDgBim/r
	 Kt4VrW2p1UlIdo79YL46dhOIkhxJJo/pX0+vqMVi+gx0/jMvufDg97Aor4e9cHz3a2
	 kAPtjG4sbCpsg==
Message-ID: <1fdc891a-431b-45ac-bae0-c1c026dbb3aa@kernel.org>
Date: Fri, 11 Oct 2024 13:38:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: cdns3-gadget: Fix cdns3_ep_config() by
 setting ep.maxpacket
To: Siddharth Vadapalli <s-vadapalli@ti.com>, peter.chen@kernel.org,
 pawell@cadence.com, gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20241011054506.2810565-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241011054506.2810565-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Siddharth,

On 11/10/2024 08:45, Siddharth Vadapalli wrote:
> The function cdns3_ep_config() calculates the maximum packet size based
> on the Endpoint Type and the Gadget Speed and stores it in the variable
> "max_packet_size". This value is then programmed in the USB Controller
> for the corresponding Endpoint. This may result in a mismatch between
> the maximum packet size programmed in the USB controller and the maximum
> packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
> Additionally, since TD_SIZE as well as TOTAL_TDL are calculated in
> cdns3_ep_run_transfer() on the basis of the maximum packet size stored in
> the "maxpacket" member of "struct usb_ep", it may lead to incorrect values
> of TD_SIZE and TOTAL_TDL when compared with what the USB controller
> actually expects (max_packet_size). This also applies to the calculation of
> TDL in cdns3_ep_run_stream_transfer().

Could you please mention here what use case was broken due to this?

> 
> Fix this.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 1d227fcc7222 Merge tag 'net-6.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> of Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>  drivers/usb/cdns3/cdns3-gadget.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index fd1beb10bba7..e89bd248e81d 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2145,6 +2145,16 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * The Endpoint is configured to handle a maximum packet size of
> +	 * max_packet_size. Hence, set priv_ep->endpoint.maxpacket to
> +	 * max_packet_size. This is necessary to ensure that TD_SIZE and
> +	 * TOTAL_TDL are calculated correctly in cdns3_ep_run_transfer(),
> +	 * and also to ensure that TDL is calculated correctly in
> +	 * cdns3_ep_run_stream_transfer().
> +	 */
> +	priv_ep->endpoint.maxpacket = max_packet_size;
> +
>  	if (max_packet_size == 1024)
>  		priv_ep->trb_burst_size = 128;
>  	else if (max_packet_size >= 512)

-- 
cheers,
-roger

