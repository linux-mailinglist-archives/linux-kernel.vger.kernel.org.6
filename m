Return-Path: <linux-kernel+bounces-263341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13493D49E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03FAB22B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DED17BB2A;
	Fri, 26 Jul 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaWZfl17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD21E536;
	Fri, 26 Jul 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001948; cv=none; b=gJuBF/caiTZdFWbUnQ1zA2Wyjy7hB1gdQTVM8g2HEDQ52bDd7jpMCLWCktdVEJTL+pFB6DcmY2/lL54uPPV/pbNTVlzwWMIcEz06Nq0GihTr8uoIz5lJWqBwOH05KjMJLYGYQMoX9vBAOJ2Z4pvBAdb0egEVvkapRhESJzlMTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001948; c=relaxed/simple;
	bh=jlj8UiyT+P2UaTZylr/dBcyg5sAz55dyW1w+XM1xO5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOJhJC1ZXfKSePpkq3mbJKOW2k+rFv0tM3V8HvZJ6cBRSbq4ieqgzNC97C15fo3CYLB0BxaXwIUOLT7SbzEEgV11D93CSP0wuHLwEg/Xm9/AqhIDDthVyBShMdZ1Z9swXxHW9LXF9TYC2ZagLzh2WxoPkDr6kYMJ6ElIK6tTSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaWZfl17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CE5C32782;
	Fri, 26 Jul 2024 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722001947;
	bh=jlj8UiyT+P2UaTZylr/dBcyg5sAz55dyW1w+XM1xO5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RaWZfl17b2yvVK0pr3eaVtwrOTj505Xp8Tgdii9i4qQj3kq1olOttX4rhZ1153ZUK
	 Kc34cOsHejgFFxQzXqk2l/k/ONOAJ8UjbhtZq6ru3XahiQyPp4l/LkvX1FVDMb4t1u
	 96ClURNi1DHrMAKA9hGksQbPCEhLDm0iVRB8emOyx7wlEZU2Vjr+TGFDkWKj1TVtmG
	 USBeiSjP8f65gPic8KLCv8eweNFA/aO9BnJuN8ZriPxgtvZw/Wi8gk/Z7RD57/bSWM
	 ZU//iWBhM0C7T+BfahJIiGOlOFsdk4jytl6+UzAwUX0dyGhQrH5e8xuQ0k1kWUXqCZ
	 m+fdfbhdvIsfQ==
Message-ID: <30b6e9eb-a6f5-4238-93fe-4d8a19b31590@kernel.org>
Date: Fri, 26 Jul 2024 15:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: fsa4480: Check if the chip is really there
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>
 <2024072615-hassle-enclose-673f@gregkh>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <2024072615-hassle-enclose-673f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.07.2024 3:12 PM, Greg Kroah-Hartman wrote:
> On Fri, Jul 26, 2024 at 01:43:30PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Currently, the driver will happily register the switch/mux devices, and
>> so long as the i2c master doesn't complain, the user would never know
>> there's something wrong.
>>
>> Add a device id check (based on [1]) and return -ENODEV if the read
>> fails or returns nonsense.
>>
>> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
>> the ID mentioned in the datasheet does indeed show up:
>>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)
>>
>> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
>>
>> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> You can't sign off on a patch twice, that makes no sense, sorry.

I'm losing access to the @linaro.org email and want to preserve the
authorship there (as this patch was developed during work hours).

Then, the author's email doesn't match the sender's email, so I'm
expected to sign off with the sender's one.

Should I assume that the maintainer trusts me to be the same person?

Konrad

