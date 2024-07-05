Return-Path: <linux-kernel+bounces-242072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9248F92833C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027FFB24FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9871448C6;
	Fri,  5 Jul 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UI+vfMPk"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651713A412
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166112; cv=none; b=ubjKoKLUKFoyA9MiPk8WnhwzW7BltDPtbi0FPQCH4u1zv3SGvFo3FcPGId/8KnVUKg01GthZpUco4yjfNOVdK6ZRS0tCWEKB4GuMbR99RbPUP7704owdXd5/RWy7dMFrXB5DH9O9or8ZdCnCsQXL0jOCRZnebFZV4rmJeuXUxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166112; c=relaxed/simple;
	bh=LtMTlaB84GgG5HeqXZ5fwgFaCutnC3PD4FS3DTGVmJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZZGJL82ohHROY5dZuPss+XM7ryzmUvsi6W54A6oSZzd2V3RWIP6AJJs0S2aJctGBeg8Mj44a0t0I9KOfAV/47L9OIWkuwnPd7+UXHV4LQE6eTly9Tk1+jgoR6tMHQgoVRnPmQORBqFeyea5rhfmwHB2kmXF4+uj44UICHNUxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UI+vfMPk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ed5ac077f5so19421781fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166109; x=1720770909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0mXdP3EbsPAjem1gi0alQI9RASKwVLxOcq8tp+VvoM=;
        b=UI+vfMPk7QELCkJ9/9eqf3qm5r1MrdFneNYqAX5NSsYAD8HqSTRi4srE0awB0IP8o6
         UnRQmUxj3kD9RI8bEjalqH8pCNplC4k7aEuFOk70CLvIKucMD+9xwr4LJS45QYekD5O4
         I2C9/J9iMFLbByj6h59BPihRQMhXb8nM0cbASn3L8XheRw1UbqmmfHOx0+5zTxydj0VW
         WV+7ZF3gONiAltHukRMhCDfG6TT72hIfFSHLEpjy5/Pl6hSdAuKrG5z5LfB0L5d+7K8v
         wM0T2aFjBOetUhXpR+7Eb6na3nnQbHM9D1ax7l23QQfs8yTu1MrEalXdftXzi3VKJubw
         3mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166109; x=1720770909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0mXdP3EbsPAjem1gi0alQI9RASKwVLxOcq8tp+VvoM=;
        b=adXWN+5psXsV6Kt8z9QV3T4GGsmCjUUwEfx4VVZiSaEOqO/+V7w6wXN0LVtvWcYEGu
         kflIiPz93lUMSIxNCWXBqwqvfE8GLhh5JmxEqnVFkrC+jzXmIOfgWguKKgOiv2A7CyGc
         RS+oJaRC1yxWUccjnqmKfIU20RYSbDlHbLf71i2OnIXbOmZqs8TkeRB4AgcHQXFl9Owb
         FXsfr2pCfs5HYG0X3urn+Ef//BPZKZPHZQzf0b5ldOMloxc+5JRoJpDbvhyLnG4oyfhL
         9wlXXJpnE38eypwXIATV+Kkcpf9EDkXMM0BKwV5Hls7k6TPwmiTDVsxS1anJspXLknj4
         UE6w==
X-Gm-Message-State: AOJu0YxesEXVBd4Gw3oSZKqrGxU1Yn/NCHGzfZqFww6YONH0hvDpLnPa
	q0oVNc5hMlpKQZjk+efRhcjARU2omUfdV+vR3/nJOB6/bN9u9R8zkDmAHYGbm7p3TT6an3mN/Cs
	KfzM=
X-Google-Smtp-Source: AGHT+IFaso2uZs+/ZbZrS9+tINt7cNWKxqKxP/mr2GfJYZZ8HoSfsg56maHDoxzh8YQFXQNZ03kGqw==
X-Received: by 2002:a2e:7e07:0:b0:2ec:500c:b2e0 with SMTP id 38308e7fff4ca-2ee8ed95f2dmr25293411fa.22.1720166109063;
        Fri, 05 Jul 2024 00:55:09 -0700 (PDT)
Received: from [192.168.86.191] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2ee5168d0c2sm25908421fa.124.2024.07.05.00.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 00:55:08 -0700 (PDT)
Message-ID: <a4b1b2cc-79ab-4e88-a38c-40b89d1c4d69@linaro.org>
Date: Fri, 5 Jul 2024 08:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] slimbus: Fix struct and documentation alignment in
 stream.c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Amit Vadhavana <av2082000@gmail.com>,
 "Ricardo B . Marliere" <ricardo@marliere.net>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
 <20240705074045.418836-3-srinivas.kandagatla@linaro.org>
 <2024070532-romp-clarify-7d2b@gregkh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2024070532-romp-clarify-7d2b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/07/2024 08:53, Greg KH wrote:
> On Fri, Jul 05, 2024 at 08:40:40AM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Amit Vadhavana <av2082000@gmail.com>
>>
>> The placement of the `segdist_codes` array documentation was corrected
>> to conform with kernel documentation guidelines. The `@segdist_codes`
>> was placed incorrectly within the struct `segdist_code` documentation
>> block, which led to a potential misinterpretation of the code structure.
>>
>> The `segdist_codes` array documentation was moved outside the struct
>> block, and a separate comment block was provided for it. This change
>> ensures that clarity and proper alignment with kernel documentation
>> standards are maintained.
>>
>> A kernel-doc warning was addressed:
>>      ./drivers/slimbus/stream.c:49: warning: Excess struct member 'segdist_codes' description in 'segdist_code'
>>
>> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
>> Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/slimbus/stream.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> I don't think this was ment to be sent as part of the fastrpc patch
> series :(
> 
> Can you fix this up and resend a v2?

True, this patch ended up in the folder.. did not realize that!

will resend!

thanks,
Srini
> 
> thanks,
> 
> greg k-h

