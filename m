Return-Path: <linux-kernel+bounces-429646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBA9E2430
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CBCB4773A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33C1F667F;
	Tue,  3 Dec 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n07Qg0ys"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A330E1F6667
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235920; cv=none; b=e7ZQXUrsdl0G+AvZ8cs2Vhj1kB7FY1RZQEqd20LK15YSPpEEFMyHqeuPudcb1K33rZsHRLU8hQ2+oG0WMRtHyV/ZJqi61k3C0ykha2f7D3/sAhpXnYKvfySBgUL1grM+VvGdZakO+ZKW4Mfd9DO9xvZhB1YiEZcEeIfE+HtH3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235920; c=relaxed/simple;
	bh=qwMwDbLOuH79Yu/dedm8QS5LqzYQ8FzV0x+KKdnm1mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=iZ2zo1bpV9E9+UrlukwkJHRJbGefP4Or2aUtzjq3F7+IzdSX/jFDvhBwNb7RVB63e7VpG+HwXsjqqCMhmpWyt8s+G0yXX2GZutLXK5i0zo+M+2ZE3TUiY8s0zVVC5Rky1CU/JT0qJMG1c8Q3/T1l7lQoZDk9TUkmr/BfqTFvIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n07Qg0ys; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so6615789a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733235915; x=1733840715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JXue3TltHvVyJp/X83GPnii6v8vLThHqmwjgC6myYA=;
        b=n07Qg0ys+yhEMtYPK5XzMTHaAG2ePVI5hRy+fslCUoCO12+PKl477klLBvn+k1WoB8
         +XzHuw48jrgjcoszqs/idyQiImwnm5Q5Py1xh0p70UNsIdHjnBE4IUbLXV0J2EM/Srw5
         Du4lcfT8gq5yQhX6b57D7uO34c30PuPN46arSSA5wGkATelynOanWwb1c5qqCVTvGtf5
         AiaK0CzAAgizqy5BiNH2AeWIyOB/15xucpv1bPhjT+A8/5G06mUwVGKGQPdAov1mKmUK
         P90YxGTLSBUurtTsCzDPuLdBLLPdYLO1e/alECN/gGa+t3LxLLUWUIRVHJzApcGmo5Q+
         nzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235915; x=1733840715;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JXue3TltHvVyJp/X83GPnii6v8vLThHqmwjgC6myYA=;
        b=GKqZ65utyWnOGvDlnaD8qV4UwgK8yohqcTbXwYbbk+Z202mIeTzYMrfDPBQSAJTcEF
         It2eBW+2953bZfQ4Ia4t8/giM6XWHg+rhN5AJyKWmBCPBuuEHvOtDDujI3Inc0fDJRZf
         ln3s0hsyUMi+UtFdny8g9wWesKuwKdNGVeKZnB8rzqDRgnaS97mVser0z0fvXh1gPtxw
         1fQG3MOYpqlgXMBS/WYioo2GQbG/15EI4jJzY08T4vJKADhkW0XhRR1mj/QDmcft7n8n
         Nji9j/DdR1th0hvp5FmUwgcB5DOH6CppRHWdCENXCDX+sW6S7+gRU8Vi/u9BEl/RGUbo
         bOQw==
X-Forwarded-Encrypted: i=1; AJvYcCWm5OT2IMifXeVte7+E8ta46ORlrSn0HE8Nv1qSg6+836X5m0a7sY9P3GhNXyDNSB6sE2JFUOtmq+dUMZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq6L+M9HVqZd24Fb9so9hDyqXl239RfkNrx33uvlmRR2ewaW0
	l6uOUDbCRlGaIMYvy25ryFIoB+VBi9B2t/93iof70it9RIeEI2Oe8QfV2bgm0/kLzyd5+mIag8g
	f
X-Gm-Gg: ASbGncvXMjGgT7N7OqQ5m8Gr9ewrioVNGtXQa7z9Qev7aCnmbYiMfG0if/yEDbVl8oj
	JaNR/sglVjyBBumBUvFTcbqSF7kcp8lN/WEAmabfxRVskpqqwrkyYGzAD3GJgD3/7jj+cO6bH+R
	2r15u2pHNP752TAG30XMO/9jlaTsEXY/OaQ3cTrvZHLVReDlYl6AWBJ2b++6RIwqLwulXgK8ecR
	HxBnazz4+LwcnNz/yVy9Qoe347wZYlrk044cKHZec8y6XAKtMewQZApJVxM
X-Google-Smtp-Source: AGHT+IFIxu8ZzCLpP/amf7heIGeGIUDYobsi38i+g/Et8m/9aQEZpmJdp8qSKytKJiJPb4+JiCrUhg==
X-Received: by 2002:a05:6402:5252:b0:5cf:3dc3:7a3f with SMTP id 4fb4d7f45d1cf-5d10cb4f105mr1790880a12.5.1733235914954;
        Tue, 03 Dec 2024 06:25:14 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0e9bba5c2sm2556557a12.8.2024.12.03.06.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:25:13 -0800 (PST)
Message-ID: <9cb1ef5e-eb61-4177-a039-4049850196a5@linaro.org>
Date: Tue, 3 Dec 2024 14:25:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/9] coresight: tools: Add configuration table test
 tools
To: Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>
References: <20241127134256.2254851-1-mike.leach@linaro.org>
 <20241127134256.2254851-9-mike.leach@linaro.org>
Content-Language: en-US
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241127134256.2254851-9-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/11/2024 1:42 pm, Mike Leach wrote:
> Add an example config table generator to test loading configuration
> tables.
> 
> Provides a table buffer writer function that can be re-used in other
> userspace programs.
> 
> Table write format matches that expected by the corresponding reader
> in the configfs driver code.
> 
> Generates tables and outputs in form of binary files.
> 
> Add a config table file reader and printer. Takes in config table files
> and prints the contents. Uses table reader source from kernel driver.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   MAINTAINERS                                   |   1 +
>   .../coresight/coresight-config-table.h        |   5 +

Hi Mike,

Isn't there some convention about maintaining a copy of kernel headers 
in the tools? Especially as you wouldn't rebuild the tools after 
updating the kernel headers so breakages might go unnoticed.

[...]

> +
> +/*
> + * sets of presets leaves strobing window constant while varying period to allow
> + * experimentation with mark / space ratios for various workloads
> + */
> +static u64 afdo_set_a_presets[AFDO_NR_PRESETS][AFDO_NR_PARAM_SUM] = {
> +	{ 2000, 100 },
> +	{ 2000, 1000 },
> +	{ 2000, 5000 },
> +	{ 2000, 10000 },
> +	{ 4000, 100 },

The comment above here looks like its for example1, this one does vary 
the window size.

Probably only example2 is enough, I assumed they were different but 
example2 is basically the same as example1 with an extra preset list. We 
could comment that the second preset list is optional and delete 
example1. Saves people reading more and wondering what the difference is.

I tried to make an example that doesn't use an existing feature by 
reacreating afdo from scratch which I thought would be a good example. 
It's pasted at the end. I had to copy paste the ETMv4 macros and 
constants though, I couldn't include them in the userspace generator 
because of this error:

   coresight-config.h:10:10: fatal error: linux/coresight.h: No such 
file
   or directory
    10 | #include <linux/coresight.h>

I also got this error when loading it:

Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000008

cscfg_reset_feat (drivers/hwtracing/coresight/coresight-config.c:64 
coresight-config.c:124) coresight
cscfg_load_config_sets 
(drivers/hwtracing/coresight/coresight-syscfg.c:217 
coresight-syscfg.c:262 coresight-syscfg.c:492 coresight-syscfg.c:610) 
coresight
cscfg_dyn_load_cfg_table 
(drivers/hwtracing/coresight/coresight-syscfg-configfs.c:294) coresight
cscfg_cfg_load_table_write 
(drivers/hwtracing/coresight/coresight-syscfg-configfs.c:799) coresight
configfs_release_bin_file (fs/configfs/file.c:415)
__fput (fs/file_table.c:432)
__fput_sync (fs/file_table.c:517)
__arm64_sys_close (fs/open.c:1568 fs/open.c:1550 fs/open.c:1550)
invoke_syscall (arch/arm64/kernel/syscall.c:? 
arch/arm64/kernel/syscall.c:49)
el0_svc_common (include/linux/thread_info.h:127 
arch/arm64/kernel/syscall.c:140)
do_el0_svc (arch/arm64/kernel/syscall.c:152)


So I'm wondering if we can do the same thing by setting values via 
individual files rather than one binary blob which would avoid some of 
these issues. From what I understand the feature params can already be 
set directly this way via 
/sys/kernel/config/cs-syscfg/features/strobing/params/period/value

We'd have to add a way to add new configs with a mkdir, then the same
things can be configured without needing an additional tool. Links 
between features and configs can be done with symlinks which is also 
mentioned in the configfs docs.

Something like this would be a bit like the current version:

  # ls /config/cs-syscfg
  configurations
  features

  # mkdir /config/cs-syscfg/features/my_config
  # ls /config/cs-syscfg/features/my_config
  description
  matches
  regs_desc
  params

  # mkdir /config/cs-syscfg/features/my_config/regs_desc/TRCRSCTLRn0
  # ls /config/cs-syscfg/features/my_config/TRCRSCTLRn0
  type
  offset
  val
  mask

But another way could be to enumerate all possible regs for each device. 
This would remove the need to have all the #defines in whatever tool is
making the config (avoiding the #include issue from above):

  # mkdir /config/cs-syscfg/features/my_config
  # ls /config/cs-syscfg/features/my_config/regs_desc

  regs_desc is initially empty, but specify what device it's for to make
  all the properties appear (or the mkdir could be done in an etmv4
  folder):

  # echo "SRC_ETM4" > matches
  # ls /config/cs-syscfg/features/my_config/regs_desc
  TRCRSCTLRn0
  TRCRSCTLRn1
  TRCRSCTLRn2
  ... etc ...

  Now type and offset don't need to be set:

  # ls /config/cs-syscfg/features/my_config/regs_desc/TRCRSCTLRn0
  val
  mask
  save

Don't we already have the full list of parameters in 
etm4_cfg_map_reg_offset(), so we can expose this to users via configfs 
directly rather than needing any tooling. And doesn't any new device 
that's supported by the config mechanism need to know about all its 
parameters, so it wouldn't remove any flexibility?



