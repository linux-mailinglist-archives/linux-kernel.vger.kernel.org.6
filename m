Return-Path: <linux-kernel+bounces-253750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0E932655
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215891C2190C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBFE146A8A;
	Tue, 16 Jul 2024 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCKrXFZM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD613B5B7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132058; cv=none; b=my0lHIuzMAxzveEoka7VhWasArliYvC33bAuKQ1cuDilTfa2JKFI/7TSCdJDBkl8B14vnHpZi1Inysy8XA4qZAGZdsWYcGdbIkk6vspIlzZFFOfYmaZP5shifN+VNUfKKpeFniAsZhZhmBEiVDavRmg5d7NPX4DvjqDWZzsIq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132058; c=relaxed/simple;
	bh=V7rbI5/Qc8hNO2pBsS2IWIuxSgAUw55HVygVA+XMVCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHKgsR8MJTmYLiqy8cdikTkA1fCiPY4KSwX+zoc5izvYheukgFIXHt3h5Jrw/RGUaxD7txgf8+dcTXFZyQeh2oZ0cWFDoYb8cqmbi5wIUgN/DBD9/QcUT9/UeBadcijwPmZyH1MhVz2hypBVguWmFaetFbO39R4iJYInuxgGPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCKrXFZM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so6734008a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721132055; x=1721736855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vyxnnE0zepFaZUKd9AE+84DlPyZhFF7Z4N8eydCCjbU=;
        b=PCKrXFZMEnyWy91oUY9y/B9emuxJnr8f2SQU7N3Ll5JtTE0FIJT6wlV8wp7hHXT6OO
         nfMBiPko+iRXisqGDqa4xUTNnVyW22mpM7DiNFWm3CBbkK5xXWrEyhcfpu2vpBMlVJn/
         saJrqBFcOFNpYpI6poAwnTUNIE07vRY9a9dYog+R7GpJv+LJmcsuqN0aWXMDFPjqOP8l
         v6cFjtLTehdVD+ullhyaTaTdN5dKHdUzY6wbcjgpFlX4W3FlnJfqF/bukK6szxA0cbe9
         oEfjAHJm72T0461b5LIgmZjNfbzn+KOj/NoIQieiJXCMryPLZkdTr88KGk22rgSPizqj
         Rv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721132055; x=1721736855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyxnnE0zepFaZUKd9AE+84DlPyZhFF7Z4N8eydCCjbU=;
        b=iYUj3YOss0kqTqRbkJIv5t5B3pnAGJMwozIQnP5Fnh8R4FV5e7tau7uA3/xvDIlrRv
         JMUa507GzuI3dVXxdvEhWLOVu8pN7RUVfRaGksALQiGxJPlUPw1wd1TxCdOGIn9tswgb
         /GZ4u6EI+Ub1A05fmzVh6cxJnmGhdyVA3Xpa1aKLpDBXEYU+2lHmDifRS1NgBnUb2tl3
         tPPzWecqULpcsMcFIRJ8gEe7vAYUZoAPNPq5M18gfapya4EHkLEmltRvNq165b3Tew4M
         yfwtZQ4BAjlhJvz3Cvyqb7MRY+suWd+N1pS7qbkeDNAJj62HXguYnuJZlIabGDg1ayrQ
         gcig==
X-Forwarded-Encrypted: i=1; AJvYcCWsfMo9au3TPJqXcrlHRgZa03W1WZFg64tmZg/p1SMANNdsEpUvVQ/IWYvNEwA0TpMKQCtD3wmpI9ek2TF/2gqtkYYldAXrb0ta/1xo
X-Gm-Message-State: AOJu0YxzRShCBA0EI0P2Pjulbw5VR2VQvvfA+XD+/Z5CmhW1KBhVeIl7
	IUABMXr12hqEmEdPH9BbpHOzx2cwmJgJE9DElI10OyhLlj2L4CaZjmuxhDtLJME=
X-Google-Smtp-Source: AGHT+IH0R+a9GVWEl6OcxuSggOE7JIjknEw6ljqIh13dNXnwXp9AsE5YkhDQQ1zeR2LFCNPLR6Gw0A==
X-Received: by 2002:a17:906:2a44:b0:a6e:f997:7d91 with SMTP id a640c23a62f3a-a79ea491f74mr131815266b.38.1721132055204;
        Tue, 16 Jul 2024 05:14:15 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a39dasm305565766b.43.2024.07.16.05.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 05:14:13 -0700 (PDT)
Message-ID: <61e04616-32f8-4574-9721-ea032d227bf2@linaro.org>
Date: Tue, 16 Jul 2024 14:14:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/6] iommu/arm-smmu: add support for PRR bit setup
To: Rob Clark <robdclark@gmail.com>,
 Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
 jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org,
 quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@chromium.org>
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-7-quic_bibekkum@quicinc.com>
 <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
 <0650ba0a-4453-4e2d-8a76-0f396ac1999c@quicinc.com>
 <CAF6AEGv_9e-TDW1r0N4-db6pY_aV_EZFqrpNbATVS5Vy6+fs1g@mail.gmail.com>
 <4a5f54c7-120e-427d-8a0a-9fb83e13a72e@quicinc.com>
 <CAF6AEGtrtFNxDWtuADA4oOHhZJ=dJZcGaJ1XLFJt4fe4Xp=pTA@mail.gmail.com>
 <3b7c05b1-8f36-4c81-a55c-dbb467314099@quicinc.com>
 <CAF6AEGuRKU+DkL0-b3xdR1R45_MiiKQYRRXEXYz-xohu8rUaEQ@mail.gmail.com>
 <CAF6AEGtbw06-gOSvX9gAbi=SA801gmD3_8c5xkOU-G9g2qKptQ@mail.gmail.com>
 <9509f256-04a4-4907-98fc-148c5087d74d@quicinc.com>
 <CAF6AEGuLwZ0yFGWMKX-O1VjQB2M57K+CsyJ=7PCKXE=b=VsSNg@mail.gmail.com>
 <3382aaca-4ca1-46e5-a445-dcb115ff206f@quicinc.com>
 <CAF6AEGu0uH7GuNb3SJVk0cPDUwkYZ6NTG1ze+wmc1OjsaownwA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAF6AEGu0uH7GuNb3SJVk0cPDUwkYZ6NTG1ze+wmc1OjsaownwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15.07.2024 10:07 PM, Rob Clark wrote:
> On Mon, Jul 15, 2024 at 4:00 AM Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:

[...]

>>>> As I checked gpu_prr_mem reserved mem section is not used for mobile
>>>> targets hence not present for other DT only compute targets like
>>>> x1e80100.dtsi has the same. PRR looks to be smmu version specific
>>>> property.
>>>
>>> I only see it in gpu_prr_mem in x1e80100.dtsi, but not documented
>>> anywhere.  I'm only assuming based on the name that it is intended to
>>> be for PRR (but not sure why it is larger than 0x1000).  Are the
>>> PRR_CFG_*ADDR regs programmed by the fw (and access blocked in EL1) on
>>> this device?
>>>
>>
>> As I checked, if the drm/gfx driver allocates the page for drm, then
>> this reserved-memory region is not required.
>>
>> PRR_CFG_*ADDR regs have read and write access in EL1 only for this
>> device, behavior is same as other devices as well. These are not
>> programmed by fw.
> 
> If there is any device which _doesn't_ have EL1 access to these regs,
> I think going the reserved memory route seems more future proof?
> Otherwise we later on have to deal with two different ways to do
> things.  But I'm not sure if there is any such device or risk.

We can have our cake and eat it too, if we keep the check for a
reserved memory node handle, but make it a dynamic allocation (see
[1] for example), this way there's a way to opt into using this from
the DT and there's no need for adding more properties

Konrad

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/msm8916.dtsi?h=v6.10#n109

