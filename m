Return-Path: <linux-kernel+bounces-198645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F498D7BA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C7DB21644
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F492C6BB;
	Mon,  3 Jun 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="R9DzqFpB"
Received: from smtpcmd14161.aruba.it (smtpcmd14161.aruba.it [62.149.156.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7B1799B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396555; cv=none; b=m/Y/FrxLMgKRzW7tdNNWNXjf+slEz88zdrZJwjuBVxpedB6H1oaNmX2Y2IGsh0fC8I8nfIToZThkK88OfSYK5SqSpnxjuRzLl3A7x3kEbjsTFgKPxK5Bc//apoYmZ5lroXXb1Eu2JbWBzurtqKcjy9EYW1f1yv+tCKr33GFL1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396555; c=relaxed/simple;
	bh=IM6Q+jA0EDWL/Yao5Tt0wSFrGtRBBIHLONyz8WNHFYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcrjJ3ZXmWrs5YLRE6DmYxNcHkTvLAV+A0y2y5Dog+1pX1W7I95LCU3XmCIm6DcSXOhcoivSBT+5OrUvwo1FONgUhDF7R3XEcfdI0Z7P5+ZHRBEzoJVaZ8+9HoSwwVLNrC49lYhS4ird1onu1nc6HhfgD+yTytaI9Ndh9NIx3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=R9DzqFpB; arc=none smtp.client-ip=62.149.156.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.56] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id E1FJsoTyL0ADeE1FKsVFMb; Mon, 03 Jun 2024 08:32:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1717396362; bh=IM6Q+jA0EDWL/Yao5Tt0wSFrGtRBBIHLONyz8WNHFYQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=R9DzqFpBL/BMy8BlyD0N7Np5fqJtWAhCKQoyuTf0ef8tJHutAorq5OgNG8LG3852i
	 I4Os30PLVPECdrLroDoROQDho1lnKfYOyo4/0B+M+f0/j2HgfQC0iBbJamROyMIFv3
	 TWz4LdgBIGRKcXgRbONb3vSYDb9bHMVSb6xNAgS2f+uIPaH56W8+/ihzWJeEMvYW4U
	 FAWq4ylezYjQkw7sy+zxkMCXxc9RJuxF6BjJkKvqU4qVVVnKYXSA+b061VJwja7LSm
	 6FR+UVl1apAoFTvMYdoBWVJEg14p/TvsvWjSuPfMCGy9MFU8kh3O8EnHcO/fVSrfP2
	 W5z7NkxcHSuyw==
Message-ID: <177dd111-fb1a-4650-9c81-ab5903859c77@enneenne.com>
Date: Mon, 3 Jun 2024 08:32:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: clients: gpio: Continue after failing to get
 optional ECHO pin
To: Curtis Klein <curtis.klein@hpe.com>
Cc: linux-kernel@vger.kernel.org
References: <20240531224411.3515712-1-curtis.klein@hpe.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <20240531224411.3515712-1-curtis.klein@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHC5lwTERhkIDSX7sQY/7yTkARytNhgs87Le2gvIhIo+Nta0N5pjDUOMNooL1wd6RndHBaD0eTU8jIjM09nwNIG4KxOg01t1MWRxj3yaKxXpaQC2PsM3
 2HzzsLA0v0+M5AZJPJ6RrmUuk4mRFriTYpCrYALidwW5uDVDAu6d8xYq2pHWRXFAvl/xBQFfSr6cDkcIxwisKlamY+HgbHfONbVOmUrrhyCmXkfLMe9wHyoV

On 01/06/24 00:44, Curtis Klein wrote:
> Warn but do not fail when devm_gpiod_get_optional returns an error when
> trying to get the ECHO pin. When creating a pps-gpio device using
> platform data and GPIO lookup tables, the call to gpiod_get_optional
> will match on the unlabeled pin meant as the input when searching for
> the "echo" pin. Since it is already in use as the PPS input, it will

I'm not sure to well understand what you mean here: why the "echo" pin should be 
already in use as the PPS input?

Can you please explain better this situation with a real example?

> fail with -EBUSY. As the ECHO pin is optional, we just warn on the error
> and continue the initialization. This allows us to support devices
> created using GPIO lookup tables instead of ACPI, DT, swnode, etc.
> 
> Signed-off-by: Curtis Klein <curtis.klein@hpe.com>
> ---
>   drivers/pps/clients/pps-gpio.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 2f4b11b4dfcd..b7db4a3ee97e 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -114,9 +114,12 @@ static int pps_gpio_setup(struct device *dev)
>   		device_property_read_bool(dev, "assert-falling-edge");
>   
>   	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
> -	if (IS_ERR(data->echo_pin))
> -		return dev_err_probe(dev, PTR_ERR(data->echo_pin),
> -				     "failed to request ECHO GPIO\n");
> +	if (IS_ERR(data->echo_pin)) {
> +		dev_warn(dev, "failed to request ECHO GPIO: %ld\n",
> +			 PTR_ERR(data->echo_pin));
> +		data->echo_pin = NULL;
> +		return 0;
> +	}
>   
>   	if (!data->echo_pin)
>   		return 0;

Thanks,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


