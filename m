Return-Path: <linux-kernel+bounces-559169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC503A5F051
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E94189E383
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737D1BC5C;
	Thu, 13 Mar 2025 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="MlHaLa0k"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0D264630
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860636; cv=none; b=eIQ1Tt2D8i5stKYBhETOVJHuNt5k/6ZDIQbPSyR/9nrz5oLOdPlfTiFJj0pEFFga1eOowPuoZKwbm4b6rvbIGK+CG/qMhpU3Pi7+Jek+RTDpS6vDGt8x6wnw2Evo6h+Zswo9Dr6V9XIkVgu1KNHwK7TecADLf/XnwkoU8IZSa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860636; c=relaxed/simple;
	bh=hcFCnx3uS3TpvHJPQgKv8tXwbefp9V9rPmL9l2TgJdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKHjFRtlAXUBqVyC12Q43Nmz/SQ0vg28IjwPPCtg3R78zqAGxONIvbYx5P9o+S/qGFnxM6MDFXq4+9TrL+1MWhwt1Deg/vofeKvRmLzR6aFBXpzGZuOojoj2tdI9OTuY6b+uWJQbEIhgTaRb7FEYBw7TSe1EfG64H209jD4mxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=MlHaLa0k; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549b12ad16eso831558e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1741860633; x=1742465433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cB67YH6YfdXrNYVTUHeNhr27VpzrcXfl9PICsA70xKI=;
        b=MlHaLa0kHzNRp0VPBw815ow93TkQzmIzwD4BFiA8BFye+9Aj8D1jzzR2bBBgJtYkBx
         gyGpiwDuJEOB5WNOVKaK/iYbzJydtMrNWhKUkV8wExd5Nz5iDWhZMKNKVWDpTgMpkNUM
         5nIS9YKqxqLW21CLHOCkPnJ+pFNVpt+hev1m2LgWCJHZPIAzwMJRMksv5FEDjKSnUq8L
         ylqE5A71OVaxAhNkM1Dl9+MVzCntyOfCKV7mLlLeZg+OH0usAsnD8rG5Js2HyYCvFyZ1
         PE8t9gjnxzHJ6RwycjPFbbJ9PGmrgRCEHhlhxv9qTsrLu5h8JxE0wNcAw/gTNGQ/pzED
         9K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860633; x=1742465433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cB67YH6YfdXrNYVTUHeNhr27VpzrcXfl9PICsA70xKI=;
        b=WLHzxT2mvj1PpqdqcCwh7tMcfVV/o4SF7/HpzeQgx4FjixV2VKP1JQ9MiFelAl++Oo
         BTW4ChUtR0oWRlFD8QQHSrMcmREdXEJj9961qs91cdnX39Nsl4CB2OgI+JskoJc3/qaG
         pS9l1rnCCY7HBEeJ/5ojQWqrBeMHhS47cpIQa1UOkwYGspTuoSyZ6msaX+U/Pp4Wbo+7
         0tBcGSzn9dLdLNuHmxejNYqrpVKTGISbODTv3O8b7Bc1FwMdfjDVvZCuIBxttS93fhWa
         UGsWMr5AmCGyIG1UTFfJpPXquLvR+p+/w7VU4bj3IfHSBiHHwWZQy22A/zGEA+Jmy+k+
         WYjw==
X-Forwarded-Encrypted: i=1; AJvYcCX86hOZ3TjlMQdzh/zSUqEmjlwfqVmriQab/onKaSk5Lcs4QniCHlVa3eelT8sX9B8ObeMrEweelavYvsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OrcUCASgwVMRHnplfnErL/3du9P/AsVESGGDjijkvGVwbJKB
	OWopJKQg+dsgLijecgnDXqTycU7rz6fHHYSiEdwKaACo2mzrUEn4H3hdDUaEPOZFQRydiQSh9bT
	b
X-Gm-Gg: ASbGncuLfX6owTN0HVzQPoDMoBbgGyY6UfmlUDzJQSsMc/cEFD5THzCJb/15BMqBgxX
	I4kKH++yJtiW5AI2LCrzVU0G3pIt5XbrVmtT2XD++eXkjN1dZMdqx0y8lsgu6CwfdZ4I3DojWZ1
	lIYnHM0XE5Gb4OpfYJAUsGhRuGycTnfMPfbi5qtvALeSUWONgC3hQX6tsUOewDXphgtT4kA9+g+
	wtS3VfyibxToNhxEHyGIgtp9FuSR54zCvVS7S3Gx5y+41Q2/0OMRoNAXYns0GOv7mUerpIad8EJ
	kPDPm4EoFX2OwY6wRL1PFNAS4Wj4/nOVYUiejRcKxi4C5Ehq8+XXTwodNHc=
X-Google-Smtp-Source: AGHT+IFG51K1w0HPoy9OtijujySdcKdTqN4yBf/VMBFgBwfH8an14pHCg9O3uX4RyxkS50AvoG6zCw==
X-Received: by 2002:a05:6512:3988:b0:545:2e76:495c with SMTP id 2adb3069b0e04-54990e6729dmr6810635e87.25.1741860632590;
        Thu, 13 Mar 2025 03:10:32 -0700 (PDT)
Received: from [192.168.2.202] ([78.62.132.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c0723sm163463e87.70.2025.03.13.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:10:31 -0700 (PDT)
Message-ID: <187c8be7-23ef-4bcb-9ac1-cf1882fe3e62@8devices.com>
Date: Thu, 13 Mar 2025 12:10:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: limit WMI_SCAN_CHAN_LIST_CMDID
 argument size
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310-limit-wmi-chanlist-v1-1-8f0fb45459a7@8devices.com>
 <a44f064f-19fd-16ea-222f-058486698951@quicinc.com>
Content-Language: en-US
From: Mantas <mantas@8devices.com>
In-Reply-To: <a44f064f-19fd-16ea-222f-058486698951@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-13 11:45, Vasanthakumar Thiagarajan wrote:
>
>
> On 3/10/2025 6:58 PM, Mantas Pucka wrote:
>> When using BDF with both 5GHz and 6GHz bands enabled on QCN9274, 
>> interface
>> fails to start. It happens because FW fails to process
>> WMI_SCAN_CHAN_LIST_CMDID with argument size >2048, resulting in a 
>> command
>> timeout. The current code allows splitting channel list across 
>> multiple WMI
>> commands but uses WMI max_msg_len (4096) as chunk size, which is 
>> still too
>
> Did you have any private changes to increase the message_len from current
> 2048 ot 4096 bytes? As mentioned in a reply for your other patch, 
> multi-band
> in qcn9274 requires additional changes in driver, only scan mode is 
> supported
> even with those changes.
>
No private changes, using unmodified FW from:

https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/tree/main/QCN9274/hw2.0/1.4.1/WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

max_msg_len comes from FW initialization message:

ath12k_htc_connect_service max_msg_len=0 flags_len=0x0 assigned_eid=0
boot htc service 'Control' ul pipe 0 dl pipe 1 eid 0 ready
ath12k_htc_connect_service max_msg_len=2040 flags_len=0x7f80100 
assigned_eid=1
boot htc service 'HTT Data' ul pipe 4 dl pipe 1 eid 1 ready
ath12k_htc_connect_service max_msg_len=4088 flags_len=0xff80200 
assigned_eid=2
boot htc service 'WMI' ul pipe 3 dl pipe 2 eid 2 ready


Is support for multi-band AP/STA limited by FW? AFAIK it works with 
proprietary driver.


Mantas


