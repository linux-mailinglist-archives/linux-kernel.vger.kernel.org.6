Return-Path: <linux-kernel+bounces-246789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D1592C6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E1FB22518
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B21189F46;
	Tue,  9 Jul 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKgsEQy6"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8C189F27
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568359; cv=none; b=lH9BipqJ2MfIHCC00/0xpzjwFFANw/w5qGdAtBHhmJTugJpow8LAShRGIISo6WFLD21sqDSxOpbDx54WRhVQxvNCOMHO9JmYyZsjH7R7dvFFPZgoIvJtKGlazlvgr/cRfIiPhRHRAQeYtR0Xl+zDJncXGhmdMPrqnfaDj1qjJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568359; c=relaxed/simple;
	bh=v13RojyNkrmLvZIYKxPxcFW9s/xF3d+S1wjfUtD88wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEPqL8oNksVsdXv9Em3iXNo2aRLKdzvC8FDLfuznRRdD/iuZkxC+A0piHiNkaeSmeFBuggPq9Sy4R7WDNuRs44yb4ziNdzcBJHhJnJMB1UDvKFWZmYH5LjedMiN+hYf6d2ldmrFn+1+4kER/MUMVj/KfSx2Zeg7BeOhz1BmlPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKgsEQy6; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f90be41bbcso9384639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720568356; x=1721173156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPHX4dzzyvza7GIEzAuMce3E3fWQvE/BuyWds2omlz4=;
        b=fKgsEQy6addE6NuVpK9jC/KWUpz1bv3HHHoi6wPgrAh5noEmOqYHSRbHgB2hP0osUV
         eLw8wsdkhJ39FA11t56KlLGlA2Tnn13mSFyoCv9icxdvGTpAOqa4e/g3g48d7UR39yR3
         9CnKVuuTxJ6faLmI8TFiTF2idrEex4wnhxSZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568356; x=1721173156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPHX4dzzyvza7GIEzAuMce3E3fWQvE/BuyWds2omlz4=;
        b=eJ+VezjPK6/DUabj2kaW3onFrX6WLXF/YZWNFu1LZBNzGoRdCWactuum9X51pso+OI
         W8qcn1rTdhKDd/E4bp5/aje8MApjdS1d5RFOYDnOdh82xSCfGKrYj+0hBN86FRbXFqwx
         znnfrS2cd/LTUc7IFAi9Ty+H6MkNbRUharDTfFmfP7C3dfiikn1TIi3A5jnekmJFA7QS
         WCgewHcAFw5Xeef07JznD+pPgLgll4dCcCj0fWxBd/HS4+dzJMhuJREl0fHFMSithNlw
         ZlnHwI4sDrb6YrMEytzDCTiVUBt3sbCM/RFxx94fY7ZuGCfqXMWRHVwRHjjv9U0vJoFL
         Z3xw==
X-Forwarded-Encrypted: i=1; AJvYcCW7K7LT6at1uJBSyr+oOV+65QjrMNh58kEiZcwCPJwAESl4+bOR0oARpWNvzYxUWC6ht15KeP2QGkQH+YIruxnsBxTbOUlY6D93tYCA
X-Gm-Message-State: AOJu0Yx0Az21xg1I40yWxe3BWelG5ViC2UEJhNoqseKUWypYUAPAVJmr
	Xk97NE2M0SfWR/EdVWT3xorBq93ilQ8O9xajnwoJpZG6rSgdglsoyZZoPcKXD88=
X-Google-Smtp-Source: AGHT+IHs7kD0Ze1CquM53sNDxDzUw7iITKvUWidVMGeDcyaS52ylpyK3DsW4wJS9slXxuvJMLZNZyA==
X-Received: by 2002:a5e:c90a:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-803f97f5a96mr120011539f.0.1720568356523;
        Tue, 09 Jul 2024 16:39:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c29d90sm765580173.163.2024.07.09.16.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:39:15 -0700 (PDT)
Message-ID: <cac603cc-2fa1-42e1-afc5-c9d8ce789112@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:39:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/thermel/intel: conform the test to TAP
 output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
 <20240702101259.1251377-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702101259.1251377-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 04:12, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> The test has infinite loop to read the value of status_str. Break the
> loop after getting the value once and finish the test.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use ksft_exit_fail_perror if read() returns error
> - Break the infinite loop after printing status_str
> ---

Usama,

As I mentioned another TAP conversion patch from you  patch if the
following command gives you TAP, there is  no need to convert.

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

kselftest framework lib.mk and runtests wrappers take care for
TAP. The reason to take care of this at framework level is to
avoid changes to individual tests. The wrapper keys off of
KSFT_* codes returned from tests.

Please don't send TAP conversion patches like this one. The output
from the commands will have duplicate messages. The reason tests
return

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

thanks,
-- Shuah


