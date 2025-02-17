Return-Path: <linux-kernel+bounces-517387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6BFA3802C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A143165A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FCC216E20;
	Mon, 17 Feb 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9BqSAYQ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED91A0BF3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788097; cv=none; b=T8V9HCYSwLp7lqWVg49Qk1XOTrEtnrVmj4jwjKcwEHjwzp4YZ5akHwWihasnhVlZ3I4tbBDYX8Zru8iZVXC3hJPVS9AUh3srF453ViNvOnrnVl7a523nxubH/7psdwlm4GqjONbtFCdfZjO+yxx+/XofFus5taixusk9gcvzG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788097; c=relaxed/simple;
	bh=/tbE/6bofLFvTTFaIWPVlRkXqkLFjJy/iQGfTIefy5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYR0T5AAkdDcNOEF00MTmH3Bx20rt/onj8wOtRXS5giGMCq5QXjRYlvdEWZC3BCx7JmxPF6aMIac+NKdyOXtwKv4nCGh8yo/b1dezCGu1lIqy97SdGybdWdfr+jflf2YzJrRFx73kDWEpIK5EmpZ9lRXnQx2VbDahUNZZbKU2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c9BqSAYQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f24fc466aso2980627f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739788094; x=1740392894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5k0YAQWlcMkdFoy5wN4OYZdW7RLZWqkzJWRxM1XOHM=;
        b=c9BqSAYQJNbTdRubzSqeZTAydVyhjf7FZqJ7sL1WEAw3FmHBeEtb4dBloU029u0IkP
         KznupS+NgmhZhrQ1TxI/Tza4PPGQ4ybAAy+x7qIqml7XAb7sHpwtsr7HNllRRjyTwFH9
         lZX2o5M/rzyNEpzYoeJc9uJcIuItvoQA5RevC6lpKI8dryRoOKznB+J+i9FSVwyceDJE
         AX8vD1L4oogT3K39I5O0adejfYyP8Ya5NFgnpzsjMbCLsDWGMBYaUPDP5YUL4FId/B1M
         Uxo+vfi+VJM89jtmsiGJDH2eDqXvyX8xpjFiF5r+CDXON7l9SpJ7God9ktJvIiXYNqCA
         R85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788094; x=1740392894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5k0YAQWlcMkdFoy5wN4OYZdW7RLZWqkzJWRxM1XOHM=;
        b=IDmtP51xREe07HtSd1iB0sSG8asyvkba0fN3VrhUFhbgzYeZjpGGqKM1Iq0+Cf3T3x
         jawjFdcoK4zmGnTuWIUXINyYn0hFTNy9pgbZpVQu9qfAGMsVx31rkJb/N+om1mPMwgTB
         eorE1vXW20Janf7zPPc0dRZRKIjcX1gxk19WMA6W43KVjWcDBkrcEtLk2SRLeu+C9trI
         NP+Ssd0Lp/SSettv+OJHbEhCOHMBrrUWlwuoL/z8EYiIkI3dWofxRqvCV+lerxEZXHDV
         ZSsqCPCF+zq2K6S0fk8TO0Xj/ZK2V9yxPdFKe6AaruSwmY1ppWr38oRFjCbq/JZ/tUXM
         Havg==
X-Gm-Message-State: AOJu0YyodL135C3OpeIFW5RpZGM9/hPTHDrxnfZcu4MRxuRaiUNBV5Jn
	tR/DBOWSqlP6ZtbFSmpW0DbgoQEK93TPo4WTbZZaTHnXhGOU2PhEY6bzYQFPIhs=
X-Gm-Gg: ASbGncsc/Fv0lAMvcCewYUtecVes8N5ZLTLEe1gsAKg5fZeP7/qvTYV65hoM667ke4c
	n5WmE49NHg580MrzQuSwZVRWPthG62Qb6dHzP4iBe3sN5HnGxWAD7LjH0ugG2izUaiRaV5G4Jv0
	Cy+7UiCf05uTyfbRg7V3t1E8auJ9PNnIbK5kldA2ssJcFxeWGrVjhCXnn68DfxMO87IqQxtxn5O
	uJUebxyco86uONoP7BTjTxceXkTkJMKpLgv+YwBP5sH//Gt8EGcOmFN59e+8X3Ckk+LB08Uei+m
	0oh3YmqDvy+CTab62s8os10HjswgYEbIUQ==
X-Google-Smtp-Source: AGHT+IHpqsdVbmm/HQGzzmmgtWuf6jaTYYJyq1nnyX8GcmtaTiwQE7xQqrOfOpDXWHSh+HLHHuaqog==
X-Received: by 2002:a05:6000:1f87:b0:38f:2c10:da07 with SMTP id ffacd0b85a97d-38f340735d8mr8822723f8f.45.1739788094465;
        Mon, 17 Feb 2025 02:28:14 -0800 (PST)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439831f626dsm22252005e9.0.2025.02.17.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:28:14 -0800 (PST)
Message-ID: <a84d675e-3b42-4251-b575-9e6a28cf20bf@linaro.org>
Date: Mon, 17 Feb 2025 10:28:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: slimbus: Inquiry on Additional SLIMbus Drivers and User Space
 Test Utilities
To: Muni Sekhar <munisekharrms@gmail.com>, linux-sound@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <CAHhAz+hmga0hLQcGtOjxuB+xoOsJ9xvFvXXUWfe9HpFcMRNUpw@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAHhAz+hmga0hLQcGtOjxuB+xoOsJ9xvFvXXUWfe9HpFcMRNUpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/02/2025 15:30, Muni Sekhar wrote:
> Hi all,
> 
> I need to work on the SLIMbus interface on a Linux platform. As part
> of my study, I see that in the Linux kernel, the SLIMbus interface is
> managed by the drivers/slimbus directory.
> 
> I would like to inquire if there are any additional device drivers
> required to comprehensively test the SLIMbus interface on a Linux
> platform beyond those listed in the drivers/slimbus directory.

SLIMbus is used as audio transport interface on some of the Qualcomm SoCs.
Qualcomm Codecs (WCD9335, WCD934x and some of the BT Codecs) use SLIMBus 
as primary interface.

w.r.t to testing, its audio end-to-end usecase.

> 
> Additionally, I am seeking information on existing user space test
> utilities that can be used to test the SLIMbus interface on Linux. Any
> references or recommendations for such utilities would be greatly
> appreciated.
Am afraid am not aware of any tools that are public.

--srini
> 
> Thank you for your time and assistance. I look forward to your response.
> 

