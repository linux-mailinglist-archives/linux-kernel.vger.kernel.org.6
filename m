Return-Path: <linux-kernel+bounces-557303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C93A5D6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352FA169F57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71571E9B00;
	Wed, 12 Mar 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9e6J/Zt"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4B1E5B89
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763481; cv=none; b=lPJg8fJyPI0j6jwgZoSa7O2G9XFU9fQ4C+a+wsUaFjefTC7dTsGz5SH+KniOm2mKaut/2aPl5SVgIb5Hqiy6ND+ZEiPqPwlInsiUWwTpOKeBXQqLo/Wuu76jZVa5kXp/QBgulIeRkxHIJr0dzn8H0fJUbHOjz2jnXEqK4BBqlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763481; c=relaxed/simple;
	bh=e7YGaKCY83HR3H/M3ccJe04aTUf4UGlWCN3ibpzLC2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBBHOg6xixn3/LR28U5vHNprCsIzpqbmd9ldDZVZFKXbw6UW0IvNGMnUfgqZXVncItyypfODR+yp9Dnyt3dTQTVMaz88wDiwyatn4kG3JeCZeTJuIytJ0myT22N45fLtpbG4/B9Kf0R5azVBBWyYVhkV3RszmOpFljVsZlnSXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9e6J/Zt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so7517895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741763478; x=1742368278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JQMc0JK4aWXwOcpwJILt54UlEg8yqOSNknC98xAh/4=;
        b=E9e6J/ZtA0EFW+uH1BMp3I45Kvca4Cd+I4nwGuysQjsWBlyxxDe+J21idiZ8mubCvq
         diDIntsZ6hBPcS36kGkCfT+9TR71SQx5AHwKrGzh7g3StH99XncP7aGhNqduq2zfa/3O
         Ie3prybwpUrw5P6i8OCz0yIqwk+AcjAeRg7PrBhxKNdidvHgoNWJSMIX55NgT9I+aIZB
         3CGjxRRbGy0jFBGKBnfXNQuE80zCy8C2hOoQ2w6KHgjKw97gQd1RT7plLEWkxBiRO5wM
         niDZYaKLy63P5ZJQAu+Yx9CSwNebwn5XdRvcgZEWebTFwaZq1XJ7Imv4qKhpuC5HHJVQ
         Cmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741763478; x=1742368278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JQMc0JK4aWXwOcpwJILt54UlEg8yqOSNknC98xAh/4=;
        b=BceW/1LFNFtRUGDMzDDAz1QSYsHS2DMPF/XggAAgPVNubHutzNRE4iefau7OUbnhNF
         nqxjDV6KlhiSh89QTO9RHxmTbLqgqTRSxHYYhNhyFmw0jOWNWoAAeB3/LnSG2mvOe2NA
         E6QdPwsA1JNQnNzLPxDJFxIX9nUS/e0KiceyRj8NYFPrGMcV60930VCnn6okYMWDGLpr
         v3tBN1qTaV+poBUDX7pGsqogQ/a52u28zA08FZiq6wO8hL6vqjNv0lAlbtNra7Ri3DGd
         R1sG8sFwTk7w3NS91iVCaFNk2o/3MsecPkKw2xg/NuKQriMVhHMqT7TDTc6Azw1x1Pxf
         7cqA==
X-Forwarded-Encrypted: i=1; AJvYcCXFYVig9BitfjO+6GCFAqCSuAvkQXdHrICVIx30IZ4V2/b+g55M1+m00CvekXjot+MKuQGV3FuJOTrN62s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfB/HRUIvI2T92T5F2LXcDrAutQiSb2yTRW08yHDvjq7hl85s
	YYRgVNOrbhxWUtrumWXs7K/60c344Ie/1G6Uq/lu/+oTRiUMXVhJD0KHBxJ3MhI=
X-Gm-Gg: ASbGncsvgAjYjQ8iqkt5g4EqZVvLeAv2ea2G+be0DIjRkrQVAwHCEXRPaTibNx6FQ1V
	q3zy0ya/QmRuhB+8JoxdWGK3hQOlbrQ49q14cvjDTt4mcLlWJsFy5aPfd0lZsy9DD1mb/8wsL+W
	qkGnah8MFpUqSuaQCxBLuXY2fngF6bmvfUTF5YFXpCOVvH96F0+b/YTLdGxn2AiJLc3sznqw8B2
	uiL+I/MMfMxT2XCR3q/6ASNvZZs8slpn+V0bVckL3N16Szx7p3Jbu/h631Id0A5kWUUjc/2oz3u
	vZqyDzky9NB7zKC3hRfpCSSBSp7HcDJ0hLxtpNazvpdT2nvpiXMp6Q==
X-Google-Smtp-Source: AGHT+IE7CFqZ+AbL0Q4cb87iC4MZdbphZY+v7bJCpcP2ShGQtgySl1i2tbL1wMwKn/N8LmsPbsCRyA==
X-Received: by 2002:a05:600c:19cc:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-43d04e92a66mr49813565e9.7.1741763469875;
        Wed, 12 Mar 2025 00:11:09 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72ec8bsm12210285e9.5.2025.03.12.00.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 00:11:09 -0700 (PDT)
Message-ID: <696494b8-14e9-4b9b-bf26-2a94a915b2ec@linaro.org>
Date: Wed, 12 Mar 2025 07:11:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] firmware: samsung: add ACPM debugfs support
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: andre.draszik@linaro.org, peter.griffin@linaro.org,
 willmcvicker@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250224-acpm-debugfs-v1-0-2418a3ea1b17@linaro.org>
 <20250224-acpm-debugfs-v1-3-2418a3ea1b17@linaro.org>
 <005424c2-7fb7-48db-b38c-c62f9f8b3897@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <005424c2-7fb7-48db-b38c-c62f9f8b3897@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Krzysztof,

On 3/5/25 7:37 PM, Krzysztof Kozlowski wrote:
> On 24/02/2025 09:01, Tudor Ambarus wrote:

cut
> Please add something like above also as a comment to the driver, so the
> interface will be documented.

okay, will add.

cut

>> +static struct dentry *rootdir;
> 
> exynos-apcm.c is not a singleton, so neither should this be. You should
> create entries per device (so with device name as subdirectory), just
> for correctness.
> 
>> +
>> +static DEFINE_MUTEX(acpm_log_level_mutex);
> 
> And this also looks per-device-instance.

okay, will create per device instances.

>> +
>> +static void acpm_log_print_entry(struct acpm_info *acpm,
>> +				 const union acpm_log_entry *log_entry)
>> +{

cut

>> +		dev_info(acpm->dev, "[ACPM_FW] : %llu id:%u, %s, %x\n", time,
>> +			 log_entry->plugin_id, (char *)&msg, log_entry->data);
> 
> 
> I don't think these should be printed to dmesg - these are not system
> logs. You either return the contents to the caller's read() on debugfs
> entry or, if this is anyhow crashdump related, it goes to
> pstore/minidump once triggered. Or to ramoops.
> 
> Depends what these logs are (so please also explain what do you find
> there in the commit msg).
> 
> Maybe something like CHROMEOS_PSTORE?
> 
> IOW, if enabled, this should go to ramoops/pstore unconditionally. For
> runtime debugging this should be returned somehow to the userspace
> reading the file. I think usually debugfs and sysfs is not expected to
> provide more than PAGE_SIZE data, so this second part has to be
> rethinked still.
> 

This is a logging feature, it's not oops/panic related. These logs are
referred to as "block logs". A "block" is the start of a mailbox command
to its end, so it logs every ACPM mailbox command issued to the
firmware. After each end of a block, we see the state of all regulators,
frequencies and devices up/down extracted from the block.

These are indeed system logs, and using the dmesg ring buffer seems fine
as we typically care about the recent logs, we don't care if the ring
starts all over again.

>> +DEFINE_DEBUGFS_ATTRIBUTE(acpm_log_level_fops, acpm_log_level_get,
>> +			 acpm_log_level_set, "0%llu\n");
> 
> I also do not think debugfs is a knob to control loglevel of messages
> going to dmesg.
> 

This debugfs entry controls which SRAM log ring buffers are queried -
there are 2 SRAM buffers.

I guess you thought about the "logb_gprio_level" entry, which controls
the ACPM print verbosity. 0xf being ERR, and 0x0 all logs. The firmware
defaults on printing all logs. I can't tell right now other way of
controlling the logs verbosity, maybe via sysfs, but it's equivalent and
with more restrictions. Or maybe you think that I shall always print all
logs?

Thanks,
ta

