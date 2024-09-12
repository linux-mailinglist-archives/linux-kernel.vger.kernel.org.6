Return-Path: <linux-kernel+bounces-326846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF29976DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4120F1C20AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587611B1D5F;
	Thu, 12 Sep 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AfCrwZyU"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72951B5EC6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154486; cv=none; b=pgu3xFP+jOr5dl5pTBJPd6CmAGS/jL9oe2DL0je6hqzu+0w6ARH7KONUIJsVxjwj/lrPFuEAqIBGHoCH2WovcZ2BTHoeXCVPm+SE1zPj7Owo05GYCXRqrZ8n3IOnvaYI5if03NDYY0HtidCrxI73OYeW761IEXqD5IRZxKYQcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154486; c=relaxed/simple;
	bh=uN1oYA0myYbXgQTkDCm1pVnzk5hImXCysuahXmxFavg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ/uSzYw6RyHXNj5BGdKKyAxpG3x6wRYbU1PwvCoFdiujsahtYA0Lltnhf6HN6RFoANUpOWsOgbY548hOvwstINYYkOjexH7PacNVGvtDnGVFMWAmtJsjUL6Vpglq67D+a09X6rl/Tkm4G+P3/fas0DEd4J+lNK5IkdFXnCXcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AfCrwZyU; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82521c46feaso53021039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726154484; x=1726759284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZNlGWMH9v05LMlASstXyJey4cdG+X1schcNc8DL3xM=;
        b=AfCrwZyUJm3xsXnyL4VRM6jIufqiYJtYBxWwZmTciUaecA3cJczxYCM7BNN5rjU8t9
         0aFHRxr43v+5mH+bLO3w0Mobg75MpysO8xytFRuIxJlrYtfH0LGaTlcrGTzQi2JvKVV+
         6v7Fm2IOuMQca+bD9ZS+Z6wNUpLoXMrbmI4co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154484; x=1726759284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZNlGWMH9v05LMlASstXyJey4cdG+X1schcNc8DL3xM=;
        b=JjCpS3FlIaAF1IMlYJPbnRlm9M/DEoLUE5eDXEYJvoqU4kRSuZT1w3P0KCBzMjKzQl
         HO5dtZ0Al6nUK1RK1styTD58xa8qI0q2UpnYoJNWcwN6iMdXtjrhppcwSdY0Sgy5pwrV
         4tC8o9CjQLJYvEXqYwbzNUKwZPLS3f/U4lD3VAod5Uzp2w3Bq3QZi918Z/Bk+cWm1M1H
         FcXhT5mKRf+CEBkWT2fneMgZsKWEVuFn5an4AB2YiULUEgdABtOS2Hk/tBTq1ckdL8yl
         UFR6S9QPcAJyvqvCmrn15a6aeGFPvfhCupajJqtQ+BdQMkirP91z2tVD82b7im9iGJg0
         qMgg==
X-Forwarded-Encrypted: i=1; AJvYcCVM6IT7a8/rbTiTXNA2eO8waT1UeJmuS2YyANXF0T2o38qHjI3opm5aKRi6pPnztsPV86ZOQa/eEA7t3Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXoCKf23uSGa1pon0KlUVGkorThaiOuI0ppQfCD8UoobJjXoH
	XYhTLcTMzyZWz3njmiCksyrbBoZGMhJmiPabAXLz9u9Qi/+/q/4TX3NP0uj6zs2awhC/NZLfk3G
	A
X-Google-Smtp-Source: AGHT+IHoWGkx34fzoZjY/3fKE7Cqz2uXeVe9T5b0JY6cte+Hc7mU0kvLcrmxBw4Ynk+qFVnkNWF7mQ==
X-Received: by 2002:a05:6602:6b19:b0:7f6:8303:ba80 with SMTP id ca18e2360f4ac-82d1f9624f6mr372896039f.11.1726154483803;
        Thu, 12 Sep 2024 08:21:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f89205bsm642208173.117.2024.09.12.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:21:23 -0700 (PDT)
Message-ID: <0f8df90f-007a-483e-83ce-df8ff0e99791@linuxfoundation.org>
Date: Thu, 12 Sep 2024 09:21:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pm: cpupower: Makefile: better support
 cross-compiling
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
 <20240912013846.3058728-2-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912013846.3058728-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 19:38, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>

Improve subject line. "better support cross-compiling" doesn't
tell me much. "Allow overriding cross-compiling env params" would
is a better subject line for this patch.

> 
> Allow overridding the envs, this will be easier to user Yocto

"Allow overriding the cross-comple env parameters to make it
easier for Yactor users."

Then add what it is like now and how this change helps.

spelling "overridding"?. Run checkpatch on patches before sending.

> cross-compiler toolchains to build cpupower with only two steps:
> 
> source (toolchain path)/environment-setup-armv8a-poky-linux
> make
> 

What steps do you have to take without this change? Include that
in the changelog

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   tools/power/cpupower/Makefile | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 6c02f401069e..e2a48af6fa2a 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -86,12 +86,12 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
>   # If you are running a cross compiler, you may want to set this
>   # to something more interesting, like "arm-linux-".  If you want
>   # to compile vs uClibc, that can be done here as well.
> -CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> -CC = $(CROSS)gcc
> -LD = $(CROSS)gcc
> -AR = $(CROSS)ar
> -STRIP = $(CROSS)strip
> -RANLIB = $(CROSS)ranlib
> +CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> +CC ?= $(CROSS)gcc
> +LD ?= $(CROSS)gcc
> +AR ?= $(CROSS)ar
> +STRIP ?= $(CROSS)strip
> +RANLIB ?= $(CROSS)ranlib
>   HOSTCC = gcc
>   MKDIR = mkdir
>   

Send v2 with cover-letter to make easier for reviewers.

thanks,
-- Shuah


