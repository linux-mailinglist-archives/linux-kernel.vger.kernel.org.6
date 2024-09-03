Return-Path: <linux-kernel+bounces-313945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098296ACB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94EC8B23F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530361B982C;
	Tue,  3 Sep 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoS47PWa"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAB126C07
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405533; cv=none; b=bEqnjhAhiGhriqg3rfOChfqwfq3kw6UF9kVysE7xPrGS4R5fD3Qq7eFksWb3cXjqV7tS0G3ZOXbcGDkCjBzukTm8CJwObIWrOquTmKx3u9bgUjucLIiKSPqqRJyRnX620qX0obqboJdDubTIZktFeq0eUNzdKtY+fpE3L6okQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405533; c=relaxed/simple;
	bh=TUCBtKaggpC/UcwUpEU1+NQ4+NkeWsmUiPyAGS7enjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coXhxVr3kHk6hmEAaJJM34qUHMBJ/iDl2KCOni9vAsE0vNonfSPvMbS0aRPnLz1e/sRwLQWw73VuSQ8c6RHj2c0cA6smsCbEuin1TflB1mUS5mSuzp/YLp5tUb1+7B7gFRCiVZ/PpRWELNGHMYv2UMTbHeZd7vZczAdiMNFUKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoS47PWa; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a29c11f05so202867639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725405531; x=1726010331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpo2pP48luBYQmS5JDSku8eVTN6sAf4SlRYC5TcODbY=;
        b=GoS47PWaDfy/CqQxpXdx9vATcfUbORh10WsGrImvNclO708Wz79me5DoT1O866Bl8+
         rHXuuBj45gwPk/QIofMkmdAHJ9K/WjyF4xN5l9wVCtP8HAIDlGtIOzWRZg2B6515FpLq
         DJOrFBNKcurPZKQeyPMDctY4mHrC2wgJ50Yew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725405531; x=1726010331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpo2pP48luBYQmS5JDSku8eVTN6sAf4SlRYC5TcODbY=;
        b=oV+tx/RUEztPTR9M1n3QL2ooQR/DQZqjiAAR7Yi+tQ29752ZrayeB3Zm/S5JP4J6Xp
         LRBNbt28n/4cE/Xs/v3fd676M+vckfGslhiXfjUMhZu9FSBfZ9KJEVzwzTt8HYZEqPAx
         Sv1NK9ThDTsIOMGnyun11iHKueFj4rJo8Qdw3GOaYwcoj6PJ8MaxEjf11W+KCdfzan1a
         TcHTZasHs/jw0lgOQYwkijJB7khrP5cfTR5A13LZBgN55g0f180ZitIqMF74qYx19clu
         fh8AHd7yZgvVemYJjH++XupIDF99JtI9Zf1pd48ircsdvJYaYWgpnefzNsmtq14oPO+S
         wF6A==
X-Gm-Message-State: AOJu0YyYEk30mj0LRKQ4D2Q0zvZNC80/Zg9mi87ym/HmuiXwTbuEYRUQ
	I7SGztkvBC6jtbr2EHBXnOhfc8wM69KvHWLDI6V5LjA4+EH4AWd1XeRiOGJ64p0=
X-Google-Smtp-Source: AGHT+IHi01VS0Bv3/JmrZSQbDFpZYKr0seahAwb3aIGsZkDZn/NK+83bOKYZDfPijnjX92FZ+sjS5Q==
X-Received: by 2002:a05:6602:26c7:b0:82a:1e96:bce5 with SMTP id ca18e2360f4ac-82a1e96bd72mr2662073339f.10.1725405531034;
        Tue, 03 Sep 2024 16:18:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a412edbsm325803139f.16.2024.09.03.16.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 16:18:50 -0700 (PDT)
Message-ID: <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
Date: Tue, 3 Sep 2024 17:18:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/24 08:45, Ilpo Järvinen wrote:
> This series first generalizes resctrl selftest non-contiguous CAT check
> to not assume non-AMD vendor implies Intel. Second, it improves
> selftests such that the use of __cpuid_count() does not lead into a
> build failure (happens at least on ARM).
> 
> While ARM does not currently support resctrl features, there's an
> ongoing work to enable resctrl support also for it on the kernel side.
> In any case, a common header such as kselftest.h should have a proper
> fallback in place for what it provides, thus it seems justified to fix
> this common level problem on the common level rather than e.g.
> disabling build for resctrl selftest for archs lacking resctrl support.
> 
> I've dropped reviewed and tested by tags from the last patch in v3 due
> to major changes into the makefile logic. So it would be helpful if
> Muhammad could retest with this version.
> 
> Acquiring ARCH in lib.mk will likely allow some cleanup into some
> subdirectory makefiles but that is left as future work because this
> series focuses in fixing cpuid/build.

> 
> v4:
> - New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
>    (would cause __cpuid_count() related build fail otherwise)
> 
I don't like the way this patch series is mushrooming. I am not
convinced that changes to lib.mk and x86 Makefile are necessary.

I will take a look at this to see if this can be simplified.

thanks,
-- Shuah

