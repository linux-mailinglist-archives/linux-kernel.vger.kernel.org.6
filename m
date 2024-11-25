Return-Path: <linux-kernel+bounces-421533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78B9D8C91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B866C162090
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C4B1AF0CB;
	Mon, 25 Nov 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4v7Ks70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A1158218;
	Mon, 25 Nov 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561284; cv=none; b=etiurd6oFNI+mYo12VXRkQY10nRgJy88YmjgLZBTexUIb2sXIhz/d0kC/ATzm5Rr8qmHsmvPuef8yGgh+TT9SxV3wlBLAgHKK7mlmzgRSnDfS/8WLLhpcOsTh8Hb0uzNj2eY5bIc+vxAlYy7NNZEfdUk1J9w7ETpyvDxaqPPydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561284; c=relaxed/simple;
	bh=nxamCDEoww+i2Yroka/ISN7GbasnJZfd3LmGGlb+UeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRLW0ClPrKvk/PyqC/JpC1TgqinhbBsNDOkY+tM/RxRLboe+dgz70vFPamKf5QkFL0KeI/aPX0HMz06Zo66ABz7EiCNLOY5H3ULZOCKEZuUW1qUDzg0LcH9YrEdKETDlj1WFWrpSx6PG6xVx3ZECK4YUOCR8KfYiYUmDqdRbd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4v7Ks70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7BBC4CECE;
	Mon, 25 Nov 2024 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732561282;
	bh=nxamCDEoww+i2Yroka/ISN7GbasnJZfd3LmGGlb+UeM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u4v7Ks70syAiQIwgKMVZuVmP6RtQ+WtmCv0gvox4yyi+Uee6inTl47FsZ+fjAvdVL
	 rn1AKY/Q0+7+8UNQPAp+WEX8B41b7wM+/t2Zrv2V0L1CCss0DddYOTy5SGPD6QVJmC
	 yJWIGm1pQEq3t19WUE905IqKuE8rLgGm4VTkAsEStKVEU7Uh0ZqpLZM26X+bdKTZNt
	 yUpY1bQ3Trj8mbkWr6RKX5kQPX4oRvwUizXdFyuK7Od46H7IBN+0k9yXQQjSB5jg6o
	 chZ2ua4w4tZHtpplhL6Z+j+fLy3tXvRROSTT1s1VkROmxyl0y9ji7fSAgBrgZKLjlb
	 vO5xjR7N6879A==
Message-ID: <523727cd-7950-45b1-a0d3-3f978e789015@kernel.org>
Date: Mon, 25 Nov 2024 21:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, "srk@ti.com" <srk@ti.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org>
 <20241125182343.bfnecsub2oxohrns@synopsys.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241125182343.bfnecsub2oxohrns@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/11/2024 20:23, Thinh Nguyen wrote:
> On Fri, Nov 22, 2024, Roger Quadros wrote:
>> If controller looses power during PM suspend then re-initialize
>> it. We use the DEBUG_CFG register to track if controller lost power
>> or was reset in PM suspend.
>>
>> Move all initialization code into dwc3_ti_init() so it can be re-used.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/usb/dwc3/dwc3-am62.c | 82 +++++++++++++++++++++++++++++---------------
>>  1 file changed, 55 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
>> index fad151e78fd6..2192222faf4f 100644
>> --- a/drivers/usb/dwc3/dwc3-am62.c
>> +++ b/drivers/usb/dwc3/dwc3-am62.c
>> @@ -108,6 +108,9 @@
>>  
>>  #define DWC3_AM62_AUTOSUSPEND_DELAY	100
>>  
>> +#define USBSS_DEBUG_CFG_OFF		0x7
>> +#define USBSS_DEBUG_CFG_DISABLED	0x7
> 
> Do we need 2 different macros with the same value of the same register
> for this?

Oops. This is a mistake. The second one should be 0.

-- 
cheers,
-roger


