Return-Path: <linux-kernel+bounces-571224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52059A6BA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B021E179AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3622579E;
	Fri, 21 Mar 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5P2DTG6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D0225761
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559800; cv=none; b=GpfVLAu7duVdx/OTNCL+iZ2+D7v2X8LdUsIOnKTbAn5UCw3EvJSvMGHE3JkflyZv4wsYU50Uy9yDQ2DNOBj3sWm2D4W3ppYirhdPzptYXOjWdY6DN0d+NZrYao9xIDuEr/r1ZURJkWjE5cG4a5T4LBQBIkKn41l61uP9pI/len0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559800; c=relaxed/simple;
	bh=GFmjOQ8o731QUVGB1UkYcDx4yW69PceHE7xVKSn6j3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB01DLLsA6kutYbPT5Fxj+lOF9LmBYYueLL3JHEiAlVWT1zXfSkhmr28EKvdFY7Of1uVLo1Yu5GgFu/J+3GXtwK08kXWyPbWy2f62rM0AmRhxBPeY2fK+Y8upzv5pOehQA2zuNALx6I3dBiT+TPqEc0E1FQ26jARY/+TulU5BdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5P2DTG6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so16780775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742559796; x=1743164596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCHRcsxe/+pskodsN56Dy1BONWoeHJ0Tuu1dcJXeMMo=;
        b=d5P2DTG6z37mnwfQW/Y4pbDH4VNx9HQ+hFJuQkxoOe296dPCThtaUNQmtw/bcX6p0U
         FpXXPyqavk+O4j9DYjUxo0cH5Cduqo4X0cOy8ahl1WRiP2i2YO/+rlsF9A+TRuo1TPc4
         LWsLwflb2kzVaedyXW1J173WZddhS8dlum3P1wDgSHlow0GtR7346Ku9aTQNzJ35QRXV
         niBxwoIiroyrZd9FPbTvz6kHCIXg7z8dG61iBsZwZASqROyhXww8MeTjRvHVT9DTnaWo
         7GJhcoNqMgvUCiN7iWkVbd4cDad5WNa21wfD12GqkQKEhmcP/Hh9oMRc2wb8bPUVKuuk
         Zvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559796; x=1743164596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCHRcsxe/+pskodsN56Dy1BONWoeHJ0Tuu1dcJXeMMo=;
        b=rLLdqQmP6MgVjFqN2TgtwqEH6Wvlv/3N/6DcNUHoqmYbv5xOj98UWpuSXxx6TxxfWx
         vI+hsQQd2vl4gWAN+5MAk03L0CaXqKxYNYaJZDfX/s0Cf78SUiFxhBNwLO3Q/dEWjZ6T
         sqFBh0Et03LSFObQMpzj8XhzIQNZCd/tughcLNjdLGZBWujBZ0XGuGKQtjTPKfip9LJ7
         P0qj3YY7A6HBSAZk9ieqB7a4ymX7iiansQdH07bVFykuWe1oZgs0IPRqRU9iPpaYh9OB
         xWQlR4PZu8ipSwbydmtJhqRrVS5eiFcwIvWwVL4PCI01jsWg8R8fs1ZqXgPGQi+7tHEZ
         zCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUGzQ0wc3BGLJZ6y7+auPwTMzJ/Eo8HCkTY/DQxtx/h6iQjZQ8vch9EtBU1FwQbXZgu9RuwqoM9howk90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaeHvuJuU5s71hnzjE7r+oMGHoCcko+D60UwhlpRxwPuhQiHEj
	UwonhTxactjmSsFsSOPnVLcD845ochBSDptCLhfx/rlH0EuGkcPPi+kDABc/8e4=
X-Gm-Gg: ASbGncuKYOVY77iSHv1zhgtDKUG/lgyrQTzbvwDhykdaTj8zT6ZrB1/0zcY6sVvwPJt
	xTdOgJ9BuBjjcmjzp/Has/FqFGLdQpyXyPlKFs/7bpGqLYdZyTXzoyffofsxTmarRUhhUzM20Uk
	IXTCGU8ae1PRVwzNiREHatUqoSIUkarG+b0S1iNEbuV5SZrKns+CZnxShD0qe8htLJxwn1/RMlb
	eIpDMhIfgqQqcGTG3Aa6U1e28OOVuAHOIEhYLlbStoYRIJkoPEHC89jZ2bQKHFNQxJC9ZrDTqJp
	m0jlQHXDHP3Du8PElPwQZinncglSMhK0HsOPSBpf97MweCG0GdUmOazuV2K5Izk=
X-Google-Smtp-Source: AGHT+IGyhd0C3UJpzvPZ0bVWbsnLobFeYW2i8lgDV+9JLWekTtRmEt7WWLRk7j4RRBw0Gi70mwVr5A==
X-Received: by 2002:a5d:5f96:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-3997f8fb0f7mr4046481f8f.13.1742559796246;
        Fri, 21 Mar 2025 05:23:16 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f995766sm2221656f8f.1.2025.03.21.05.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 05:23:15 -0700 (PDT)
Message-ID: <9962c517-5c0e-4d46-ac0c-2a7bab550156@linaro.org>
Date: Fri, 21 Mar 2025 12:23:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] misc: fastrpc: add support for gpdsp remoteproc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, quic_kuiw@quicinc.com,
 quic_ekangupt@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-3-quic_lxu5@quicinc.com>
 <30bba296-8e6f-41ee-880e-2d5ecc8fe5a4@linaro.org>
 <qhriqbm6fcy5vcclfounaaepxcvnck2lb7k2gcpbtrojqzehua@khv5lwdgbysc>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <qhriqbm6fcy5vcclfounaaepxcvnck2lb7k2gcpbtrojqzehua@khv5lwdgbysc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/03/2025 18:43, Dmitry Baryshkov wrote:
> On Thu, Mar 20, 2025 at 05:11:20PM +0000, Srinivas Kandagatla wrote:
>>
>>
>> On 20/03/2025 09:14, Ling Xu wrote:
>>> The fastrpc driver has support for 5 types of remoteprocs. There are
>>> some products which support GPDSP remoteprocs. Add changes to support
>>> GPDSP remoteprocs.
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>> ---
>>>    drivers/misc/fastrpc.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 7b7a22c91fe4..80aa554b3042 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -28,7 +28,9 @@
>>>    #define SDSP_DOMAIN_ID (2)
>>>    #define CDSP_DOMAIN_ID (3)
>>>    #define CDSP1_DOMAIN_ID (4)
>>> -#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
>>> +#define GDSP0_DOMAIN_ID (5)
>>> +#define GDSP1_DOMAIN_ID (6)
>>
>> We have already made the driver look silly here, Lets not add domain ids for
>> each instance, which is not a scalable.
>>
>> Domain ids are strictly for a domain not each instance.
> 
> Then CDSP1 should also be gone, correct?
Its already gone as part of the patch that I shared in this discussion.

I will send a proper patch to list once Ling/Ekansh has agree with it.

--srini
> 

