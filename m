Return-Path: <linux-kernel+bounces-443053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C819EE64D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26004162D47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD2F212D8A;
	Thu, 12 Dec 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOPPW2lL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64133212D66;
	Thu, 12 Dec 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005195; cv=none; b=MbhtObSANxlqwcR0fGfNhT7qLvJvxrNZ7UnuABVGOvtpTLLoh6KdbEjC+OzYtgBdAsI2TfKoHtvJOn4LULE4z4N7cfL2SBQi8C3PrkySsBQWYWVRiZ2xIBWJ7gSWxhkJ4rRw3jhz+2n1n/1zvOH+OWS8pvhGMtVJJW87ntjrgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005195; c=relaxed/simple;
	bh=ZizdM55Ba4mlDI4F2QZatAUuD6hBE1ZGtByMBWaKgfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+tqSg4s+SsfeQG5ggENfVhibwV0Mxa15nfRQxxWTJGJAdhVNAkoyGTfasq6UAOg/hzZ+A46Np6dwqrEvY1lSIWbuxTcPYRNmvidI2fzQx/z5vJTJE2Q21bJUAtf67iKF4HsJFv2UXQgyHyTqSHFFfwTk478kC6+0LN2Pj4UnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOPPW2lL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D83CC4CECE;
	Thu, 12 Dec 2024 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734005195;
	bh=ZizdM55Ba4mlDI4F2QZatAUuD6hBE1ZGtByMBWaKgfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hOPPW2lLfbC6LfVCH41sdrAYtkuD1BXQnB/gKrJUTKKE0DOlJCJMS2iZSd9ZyNjHw
	 bpN7fOagXrmFZ7LNXTFOlR9UzDeYmpX2lIvkZLM319JybnSb4XUZwZzxOpnm/CUaUz
	 00gwPxKW9jnzN8mNCt6UImN+tYXEtvMdJPhEsLA1Kqxp5yQFSu4oEL/Vxvhvhh1+HS
	 +h6biE55fdeESjX5MEGDX6a86bxswNDq21P0pBb7s//XrCYr44EuPasEcN0BaNO2iK
	 B2AKhBemagN09zSAvSBWDegO4hT7BaKouMw5/Sv4iLiNh2Bb9DvdYAS66SG1RE7dyt
	 iYk0Kr0OPvuzA==
Message-ID: <6ccbf7a8-21d3-4de7-b60d-cc51de323712@kernel.org>
Date: Thu, 12 Dec 2024 14:06:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, "srk@ti.com" <srk@ti.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241209-am62-dwc3-io-ddr-v2-1-da320392b509@kernel.org>
 <20241210225840.r22ds7g3rt4zelnq@synopsys.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241210225840.r22ds7g3rt4zelnq@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2024 00:58, Thinh Nguyen wrote:
> On Mon, Dec 09, 2024, Roger Quadros wrote:
>> If controller looses power during PM suspend then re-initialize
>> it. We use the DEBUG_CFG register to track if controller lost power
>> or was reset in PM suspend.
>>
>> Move all initialization code into dwc3_ti_init() so it can be re-used.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>> Changes in v2:
>> - fixed macro USBSS_DEBUG_CFG_OFF to 0
>> - Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/r/20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org__;!!A4F2R9G_pg!fQlfE8tlmLW59YBhswZnfOSf_zypGRcqWV312B5A0NF0rLaOFPvTkWaPzCoKpz9E-2iihXpR87fFTrfubb-v$ 
>> ---
>>  drivers/usb/dwc3/dwc3-am62.c | 82 +++++++++++++++++++++++++++++---------------
>>  1 file changed, 55 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
>> index 5e3d1741701f..7eef945b1f89 100644
>> --- a/drivers/usb/dwc3/dwc3-am62.c
>> +++ b/drivers/usb/dwc3/dwc3-am62.c
>> @@ -108,6 +108,9 @@
>>  
>>  #define DWC3_AM62_AUTOSUSPEND_DELAY	100
>>  
>> +#define USBSS_DEBUG_CFG_OFF		0x0
>> +#define USBSS_DEBUG_CFG_DISABLED	0x7
>> +
>>  struct dwc3_am62 {
>>  	struct device *dev;
>>  	void __iomem *usbss;
>> @@ -117,6 +120,7 @@ struct dwc3_am62 {
>>  	unsigned int offset;
>>  	unsigned int vbus_divider;
>>  	u32 wakeup_stat;
>> +	void __iomem *phy;
> 
> This is an odd way to name the iomem. I would associate "phy" to a
> device more than an iomem. How about phy_regs?
> 
> In any case, it's just minor nit. Regardless whether you want to rename
> it or not:

I agree with you that it is better to rename. I'll post a v3 soon.

> 
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> BR,
> Thinh

-- 
cheers,
-roger


