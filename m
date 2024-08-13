Return-Path: <linux-kernel+bounces-285559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A18D950FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96F01C22162
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD001AAE37;
	Tue, 13 Aug 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VTYj39Tk"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE91AAE10
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587596; cv=none; b=ZnnADGOlYvgsF4Eu6bwGH3+wYUWkn5oI3l5LoP9yXeWn4CnswRvbfvgj77gwGHlgxXoTz21Y3eock4qlka3FKQ8J4BsqzqR4RvcDHIzfhPmwqglzZu00Et0pmXLReZ0XxQLaZsHf0XC/ppolhFBdBKs/1aUWR9y2zr6eLwq3rEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587596; c=relaxed/simple;
	bh=tL+y4hkE1xuXNMnDdiyTI/3GxU8hWLdSXIrkjZ9WbAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BeOcg/ouKTUUsCzIZNzE272oB4FdxXoA+/+u4AWjVpxjfDFcYYMkF86iH4inAaj7StsNtGaq4X2DPmU0G9PbIBCq+PRd4j/MPQN0pFEQ7KnlOOYlp72ywAJHzGXnuAbkFJGFzJ+8TX/0Iy+0q0rEUvK1j4WP44mmVH4yU42S2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VTYj39Tk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710bdddb95cso3618663b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723587592; x=1724192392; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aL3ypITUp89KlV2kP9EV/LgQKSjWAesVMfZkvBn3ycM=;
        b=VTYj39Tk7Tbr1CuqMXwXVbPcPO14EgylzyGTMMZoMuTno9TYXZbFZNzmqS3oCJhNUU
         ywBVq5MfWQSU3/YeJ8RjTHPb1NbcEteiCE5HXDTDzJvLUsVCqCqeRN9twEwsNrMu0nTh
         xfdXdILys8TfIC9GSpZS26/nraW8/RiNlItJ08sjR3da+YmTokAUhN/ZZ8SJ5r2vpHdO
         83ugsqf18cx4bZJZkwqr1N5RlR16mhGaeYfobs9aJt61wh50fk1LzOkGQQdMnCtCSE5R
         /I4IqL/+1QM4VkDiTKtmFBgUWtNpAfYWcIH2mMkgPYxbJ2UI9AVD0PXBo4lnAPzhZ30r
         E3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723587592; x=1724192392;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aL3ypITUp89KlV2kP9EV/LgQKSjWAesVMfZkvBn3ycM=;
        b=fhxW/u+9tNiEun3TUjCJ/5jNQBe4dwQFnJlZj6bt8sGjpS7wPldU2bEwLsqbI/wEb5
         AJytKmRdVK7KRIsqFGiyjX5k9rTCVuwKjO/oj96eD1QVPTPtGyO71zLbm8xdNWQSzhKF
         EbHBAO+Ku6BGpNnVI3OfZK/mNNxLDkNKfdtWPECkTHt9ssdnIGTXUDVFcg95VXFoqkar
         RWaF06CQjFIF7t885+iUUj+VnXt7rdzlKtcXifl6eZMrP5+flqBHmZ90UR7JEd4nonCn
         KdQ1d+qDs2EdA03EkyOruxPitEyhAPCwhfXAOAlK1+Pm+4R856MKiF0c0r/iqy14snBa
         lIqg==
X-Forwarded-Encrypted: i=1; AJvYcCWgeuZ/pEakfjZKe1wEzCg49CG2TCw8itkr9Owqutz1GWbckdBb4s/rqQX4FAhCFGAWIq9qreNm2MNB3Ws+5AsGmir8Pkq/ofypHM+5
X-Gm-Message-State: AOJu0YyW5xnHKoZZzv3VzuupbnsqIuxZT5POHMUQWVlVT6EUou2H/Ga5
	H8b2mdj1XymN7lEafO+BxMdQRtHARfrkRiMxVSQ8r7qHm8C6L7YszypoGaHWBz0=
X-Google-Smtp-Source: AGHT+IERf4X277E5hrGy/fd9rT+i98XPhrp8RywcLeI1O0XYaGkfZEZ9GcdyAmWodd41BiVUfiR2YA==
X-Received: by 2002:a05:6a00:1151:b0:70d:2e24:af73 with SMTP id d2e1a72fcca58-712673ac8fcmr1029398b3a.24.1723587592549;
        Tue, 13 Aug 2024 15:19:52 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-712681419d3sm258449b3a.13.2024.08.13.15.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 15:19:52 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: a0230503 <a-kaur@ti.com>, Dhruva Gole <d-gole@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave
 Gerlach <d-gerlach@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH v9 3/4] firmware: ti_sci: Introduce Power Management Ops
In-Reply-To: <5f6093e5-cf67-4516-b5b8-929987b05a2e@ti.com>
References: <20240809135347.2112634-1-msp@baylibre.com>
 <20240809135347.2112634-4-msp@baylibre.com>
 <20240812054717.6lzkt3lxclzec3zy@lcpd911> <7hcymdphky.fsf@baylibre.com>
 <20240813034935.wqehblov3e5gur3r@lcpd911>
 <5f6093e5-cf67-4516-b5b8-929987b05a2e@ti.com>
Date: Tue, 13 Aug 2024 15:19:51 -0700
Message-ID: <7hy150njzs.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

a0230503 <a-kaur@ti.com> writes:

> On 13/08/24 09:19, Dhruva Gole wrote:
>> On Aug 12, 2024 at 14:16:45 -0700, Kevin Hilman wrote:
>> [...]
>>>>> +/**
>>>>> + * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
>>>>> + *
>>>>> + * @hdr:		Generic header.
>>>>> + * @wake_source:	The wake up source that woke soc from LPM.
>>>>> + * @wake_timestamp:	Timestamp at which soc woke.
>>>>> + *
>>>>> + * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
>>>>> + * used to query the wake up source from low power mode.
>>>>> + */
>>>>> +struct ti_sci_msg_resp_lpm_wake_reason {
>>>>> +	struct ti_sci_msg_hdr hdr;
>>>>> +	u32 wake_source;
>>>>> +	u64 wake_timestamp;
>>>>> +} __packed;
>>>>> +
>>>>
>>>> It looks like we forgot to update the parameters in this API.
>>>> See [1]:
>>>>
>>>> struct tisci_msg_lpm_wake_reason_req
>>>>
>>>> We're missing here the wake_pin, mode and 2 rsvd fields as well.
>>>>
>>>> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-lpm-wake-reason
>>>>
>>>
>>> The docs mention how to interpret the pin, but not the mode.  This
>>> driver should translate this mode number to some human-readable state
>>> for better debug messages.
>>>
>>> Kevin
>> 
>> Agreed, we would all benefit from a logic that prints the human-readable
>> state. The way to interpret the mode would be just as:
>> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#supported-low-power-modes
>> 
>> So for eg. 0x0 = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP
>> 
>
> Missing the call to ti_sci_msg_cmd_lpm_wake_reason in resume path.
>

Oops, OK.  Will be added for v10.

Thanks,

Kevin

