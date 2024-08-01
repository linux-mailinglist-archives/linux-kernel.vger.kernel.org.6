Return-Path: <linux-kernel+bounces-271116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB859449B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E83E1C25C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C5170A32;
	Thu,  1 Aug 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoScWogC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470B16FF48
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509541; cv=none; b=qiNkZLSv5sv68JVs+UyUudDdnuy0TpWlJnrzW4io0YoSRsWAvDpzG8/9vuWh1erb7QuJWehh1pW7wmcw3YnWwiJrm8WhNysEh84LPDlUdYVmLV8g9tdWaxOoSXJvPWAI+H01u3ZKa1mjQpifv8dLlNeZBDfd2LHEUU5dX5MWAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509541; c=relaxed/simple;
	bh=afvaUh9SVTLZ2BWmV21GFOjwe+1CWV/Ik/Yte903v9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MG0vJgX2iBXu+ze47GzMemV1VuR8TIiC668clsBrjAu1OWMawJl7N9i5+h0eOeg4Qlr6bX4YCmUPaauM1uPwaZdfj4Pm5F8ylBwA7Zx+2gko5bqtIZoqLT2gInv4uelTT3mqwYlmLXKYtvTk4c0UECgy1lCPuK5uU3nfI4cij+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoScWogC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9e25008aso911261666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722509538; x=1723114338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZZ1ekPVpLMN5B/Wgxfv8u2hSz79sz7fNTIQlvmVhI0=;
        b=QoScWogC9kytOpdq94WAWG7OV1E3QrOz22XxB4JC7YoodDW/TJV9XMLoxlsiptPR0o
         sbdHBT83Tc19zQAlCaV9nExNTTYstC4l9XMq+rXxJkRDxk+CE8uXHiLiFcyfsq/JpkHF
         TD9hutbEyND9f9VLhvnzY/PXtwBtEBM5zV9v1ud3FhRPqM1YqGRp9568A8Cxr/bbidNw
         6mc4Kl5xUmZI+h4WC69Ymt+KAZAVCKrkB+IrkCgOKb8auPW5y5wSxne4T5selv57C7nv
         cr490Ley9wkI3kUE3Tv21t6rydbmOhxdNcYxcqqaAtwTN57kTBxPmHCOAQZZ4k3NFwGE
         b73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722509538; x=1723114338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZZ1ekPVpLMN5B/Wgxfv8u2hSz79sz7fNTIQlvmVhI0=;
        b=or/vfq0aX0+y4JzPbLUNe7Gw60jTXf1a/nXiqckaltPp6mPFop9TY/iLUH+VwkbNOB
         TZRsfQzx5l5c+NYsCw/SHQ77kVapCRn07Su1a+9y2+3FvzNbRIpyUKU20GVb7DwNeJlL
         8I85pJw7MzCJteVvizFtE4QmnWBcLI9PBVArVeHrnIZVQMi3F6MtQkOIwtCH1ogVdKzB
         fmTU4nQoRLYy1S3z2gt20wlFPHpvT62v/louuDrUhNsy42yVtXh9KKOBZnT4jw0/qnik
         sdfzVuz+ZwGlUUBgPRQTN3q5SCBMmy7WysEqjMJZh6eQePJG65xQpCoNpTu12qMY99ga
         smOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWixO3Mon7s1Wr1+Gd8KzIxzwB77eQSqkoWC1msul0V0uRLPL1zJKb9H0wbMqcvgeIsqpoXRdKkeQy6e5yQH691BVLf4BLxRGTAmN2j
X-Gm-Message-State: AOJu0YxR3Nx1BKJ5/qJqT2fyIbREjFG1pKgPf+brDklDQDGUXcKtQqay
	NMXHchrXz3uqyEQs6qhiSUhZJnxJCTFjihwzd6dOzWS52F0WhovIq5AfcMuDlfs=
X-Google-Smtp-Source: AGHT+IFw2MwFO2zScaSth9q1bBsBmAyyK4sgL06g3TLdUzX6jPvZTqYz6N1Wz0+RF8ncF4jBMo9iHQ==
X-Received: by 2002:a17:906:6a16:b0:a77:d63e:d8fd with SMTP id a640c23a62f3a-a7daf79372fmr154376466b.12.1722509538047;
        Thu, 01 Aug 2024 03:52:18 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41027sm878233666b.122.2024.08.01.03.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 03:52:17 -0700 (PDT)
Message-ID: <32f23133-c494-46c1-a1f7-cabddb6331a8@linaro.org>
Date: Thu, 1 Aug 2024 12:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Enable EUD on Qualcomm sm8450 SoC
To: Trilok Soni <quic_tsoni@quicinc.com>,
 Elson Roy Serrao <quic_eserrao@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240730222439.3469-1-quic_eserrao@quicinc.com>
 <023d4ea8-635d-435f-bae2-87284f70123b@linaro.org>
 <2a17eaca-54af-d1fa-304d-c7e0afd85b33@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <2a17eaca-54af-d1fa-304d-c7e0afd85b33@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Trilok,

On 31/07/2024 21:58, Trilok Soni wrote:
> On 7/31/2024 4:13 AM, Caleb Connolly wrote:
>>>      
>>> 2.) Proper routing of USB role switch notifications: EUD hub is physically
>>>       present in between the USB connector and the USB controller. So the
>>>       usb role switch notifications originating from the connector should
>>>       route through EUD. EUD also relies on role switch notifications to
>>>       communicate with the USB, regarding EUD attach/detach events.
>>>
>>> This series aims at implementing the above aspects to enable EUD on
>>> Qualcomm sm8450 SoC.
>>
>> Are there any plans to make this feature available for folks outside of Qualcomm / an NDA?
>>
>> There is an openOCD fork on CodeLinaro but it still requires some proprietary library which is only available to folks with a quicinc email as I understand it.
>>
> 
> Which codelinaro link are you referring here?

That would be 
https://git.codelinaro.org/clo/la/openocd-org/openocd/-/blob/qcom_changes/README_QCOM?ref_type=heads

Which says:

Qualcomm specific tools:
- Login to qpm.qualcomm.com
- QUTS: 1.64.1.39 (version & above)
- Qualcomm Host USB Product Suite - QUD QC only : 1.00.63 (supported 
version)
- EUD QC : 2.1.1 (supported version)

I believe the specific versions of QUD and EUD are only available to 
Qualcomm engineers and not even to OEMs, though I might be mistaken.

Kind regards,
> 
> 

-- 
// Caleb (they/them)

