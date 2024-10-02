Return-Path: <linux-kernel+bounces-348214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E298E433
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53154B21A42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC59217302;
	Wed,  2 Oct 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G4NkD68s"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76181720
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901218; cv=none; b=RSVtOoXofiQ5MYg+rvU9Z/YEnacKqkyAgnzxXhBeC3Uj0bZAj3HLtss3o0xAc0rPF31ev5hJwp+Y9mbZpi+IbVE/xeAgFvivxQvGaLS3C4Izx7hxWlvVpziJ4jC1Il+46ZygOHoMyII+pnGcTp6MnZo31cVUeHX0AhZnezZfO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901218; c=relaxed/simple;
	bh=vYFfMsyPD4fdVa42A17PQL3U499ljM3P6ENokeeipcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZwoptwbr/msTmTFUrwGj1gKLN0fMdz1bcXff/gyBEjgP3mzyBRu3ViufXuRqAJWtRZDOLFPh60yjL50tVVKKL73xquguxUOa1IuPvRSiEun7Xm8+3j9xuZeYM2xY2oicJa/wylMYFgEBNzLxiZGA32Niqor7nuqFv7/oPR07iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G4NkD68s; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8323b555ae2so12534739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727901215; x=1728506015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIV6lH5FyZeIWyK3iBVhKXN6xjSAFCfpXdH8a1hnOqk=;
        b=G4NkD68sVgZzTyLTd99yZPoW4b2ZrdoXzmxUg2fHMVCWA7ywFHw2EaG5F0YCTn4e/S
         uABNn4kh24OQOR9Kpukg2FNYT6ccDOFUmpLvAJhDKMHbPO4nSoHWWCS9b7Wt5HRuEEYb
         6LMRoGVVyQhpSZpwAXNj0OClko1QsjTDGZ6h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727901215; x=1728506015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIV6lH5FyZeIWyK3iBVhKXN6xjSAFCfpXdH8a1hnOqk=;
        b=RLcKKjhfNRRhKW8jdJac+zqhjp8DEQQvNf5+iUAXcz25IxWokPHoo/hcr7MmjvLt+m
         LrJIfngoWea5680zRsdf9bxUHZDrbVwMcUvslE3KB6lmZq6ZkI++48pDDmIYS8IFT9BF
         ngXj8TGKrx83fSrYdcCNNcLRv9GTi1hgZQEIpPsVv8xFU3p6G5yssp3SvRwQ5Nz/UI4s
         7O4U87SiefhBZZkX7NOpqST7UhrjLqI7V7B/qGypeL5axY/FOKKiSqa6P9yy5HiZpYRj
         aLKGAFkcny5NOG0L7wWiNe5gP2KJ7xSPCjIDCiduSrUZPCsiCF1kPCNSYTR1OLUSjA75
         nrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEwO+9WNWTAN0Lt+0k/mC2tYpt5onyjl/jPYvF7Qm1BPzV8q2lCwTkrz8ZjHnYzkpZpQkr3sLovVGkEtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2352+TJMWKKvZws+Kb1+0AKxMjfefrCDSbe/c9grbH/igalw
	5oLC/HISvLAj5fg26U5V11EocRJWqJ5214yX6JliMOND2jOJQ1d8YPBo1D9rJoQ=
X-Google-Smtp-Source: AGHT+IEygY0t3p8+aBjlRGLgdwaDvI7m8LTnpFpkB22i4Op5SN7lXIA0tawLFz19GZDo90hJF54R1Q==
X-Received: by 2002:a05:6e02:1e0d:b0:3a3:49f0:f425 with SMTP id e9e14a558f8ab-3a3658b83d8mr49768945ab.0.1727901215298;
        Wed, 02 Oct 2024 13:33:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d82bb9sm37669425ab.31.2024.10.02.13.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:33:34 -0700 (PDT)
Message-ID: <6e023b6a-af3d-4cfc-a956-1e47852adde5@linuxfoundation.org>
Date: Wed, 2 Oct 2024 14:33:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest/devices/probe: Fix SyntaxWarning in regex
 strings for Python3
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org,
 gregkh@linuxfoundation.org, nfraprado@collabora.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240806121500.51337-1-alessandro.zanni87@gmail.com>
 <6tlfxlgukpftlfh7z4mwbklcjl74rxixo7xjauyf5dstyhwav2@wvkwd3df5am6>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6tlfxlgukpftlfh7z4mwbklcjl74rxixo7xjauyf5dstyhwav2@wvkwd3df5am6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/24 03:00, Alessandro Zanni wrote:
> Hello,
> 
> this email is just a friendly reminder to know if the present patch is going to be applied or not.
> 
> Thank you.
> Best Regards,
> Alessandro Zanni
> 

No top posting please.

> On 24/08/06 02:14, Alessandro Zanni wrote:
>> Insert raw strings to prevent Python3 from interpreting string literals
>> as Unicode strings and "\d" as invalid escaped sequence.
>>
>> Fix the warnings:
>>
>> tools/testing/selftests/devices/probe/test_discoverable_devices.py:48:
>> SyntaxWarning: invalid escape sequence '\d' usb_controller_sysfs_dir =
>> "usb[\d]+"
>>
>> tools/testing/selftests/devices/probe/test_discoverable_devices.py: 94:
>> SyntaxWarning: invalid escape sequence '\d' re_usb_version =
>> re.compile("PRODUCT=.*/(\d)/.*")
>>
>> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from
>> discoverable buses")
>>

checkpatch complained about

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")'
#110:
Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>

Run checkpatch before sending the patch. I fixed the problem
and applied to linux-kselftest fixes branch for next rc.

Sorry for the delay.

thanks,
-- Shuah


