Return-Path: <linux-kernel+bounces-244653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051C92A76B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7168B1C21211
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8FE14659F;
	Mon,  8 Jul 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNRjkqbl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D69145B37
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456573; cv=none; b=bgcfhuJuQ2lHJl3RkhWyT0j4PmsJ/PpsUuXBccTSLRMXHv9sbcx3AwPkeaQ5SR8WI4PrJMlz84nDcaBEoX05oh6uDOKP8SDlvMn7N5f/PeGrtVHIuxD4yFEkJhX+t7H5t5CpD1JNMzYr5cFW/EWf2Q95smVuVuagfMdCo+TXeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456573; c=relaxed/simple;
	bh=kF79k4M0wfI5NybhocxG/V7HbuwRgXY/PbwykoiZ0u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXQ14C24zVlp8Sl/I5PKVdgwWfc+drBAPb+B2I1m1dSVIjGyR2Ulkq7OT+0FZkvk7NjuZ11YVbjgmK26oZ8Xhg6NTKxk8nph0N1FfpEcPXl+pEblST5QqwfZJluRMR/SbkSKlcJV4d6OrKIjIrzk284LqPW6MTHCaSBMrSbi0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WNRjkqbl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so50627811fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720456569; x=1721061369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXr0BWZGWxSKsJl1B6BOaJ9LQX+PHNjm3zoOsNxl8ZY=;
        b=WNRjkqbloxri6luzKllXA5AfQc2ky71ytz6BqIkRQk96rqQG8aW5AeOcwXWA1G580x
         4KmMK0RygLZK463xytq8u9eVTEjv9FkSV1nXd7yHorchpyMAkh8nsj7ysZIdYFbRh02u
         uvg7DpyYAwiDhQgZa40yHx97o5+OC8yrxwERODd81iDXIYoRP51cW5MLuzZuKONz/4AX
         wmYUqmn4Sqh0jWijlKsngzCecWEi5hXnUG+pRKD8C0ygEqiFYCRtVLb5irzRkGpYa5tq
         y95Gt5nY5s7YxxalWjJ6UVhhs9bcP6NzcZMu6ur87JlrcZyKQ7vgrdYs1SmjvgsMqa71
         DjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456569; x=1721061369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXr0BWZGWxSKsJl1B6BOaJ9LQX+PHNjm3zoOsNxl8ZY=;
        b=VTwDRMIxe0shFAkS369N51Xzf/RB3e58GFVdaRM1SVQDd8WdGhv3kPFA/GmN2nenfJ
         MgxK2OY30zibClAHK2/9j2pY5uqWZUUhW+V14LgwSpdaT0RfymA+FakeyTddRvdKcqKL
         rUBxqrtQvblPB/CrvY+R8DV4Xly31OHWadvdUaN3hde1ZlVtnz3ILcjeCDWIULL3mV7A
         DgT4rKMwY0kOBPkUX3bZsTRP8l4RDpxhfFJeeOu78AJ9jJ2Vk10xRIr4w/Rr5amvhAQp
         l724MBzM2MyopDkWGm89P+dGgIpiypx/SE72mxpz51Jgj22FObksNqcNAhGbtsySch+Q
         Jv9A==
X-Forwarded-Encrypted: i=1; AJvYcCV8OsZ/fo4moLPIBY73/wVRCpU74t9NUKL2fZXyfdq8OIQfAacBXEGnkz+8iPqbQgfIVTE4b/nYu7kt5EncQBD9Y5dvu6dMRFE9f7gB
X-Gm-Message-State: AOJu0YzTWTvHPS9CX4Xd2cSirkz5d2mbLHr0hGASkw4dizL6aSaAPc6t
	Rl38aPzUNVMiVe6mfirHybPIBVT22985ptYK+Whe1RIBigtSQp88yCi9d+F30hY=
X-Google-Smtp-Source: AGHT+IFwhURRS94WBKV1QcWHN4yHD3pCaXhUL3ZA3yoqhHrsgcoWidzDCWKI/z1AIwjXQyKRTVK+EA==
X-Received: by 2002:a2e:a792:0:b0:2ec:4f0c:36f9 with SMTP id 38308e7fff4ca-2eeb3169f11mr2339051fa.36.1720456569321;
        Mon, 08 Jul 2024 09:36:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5f51sm5021515e9.25.2024.07.08.09.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 09:36:08 -0700 (PDT)
Message-ID: <bf4a45e9-4ed3-4d3b-bb96-add20a71b04c@linaro.org>
Date: Mon, 8 Jul 2024 18:36:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] clocksource: mips-gic-timer: Always use cluster
 0 counter as clocksource
To: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Chao-ying Fu <cfu@wavecomp.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@kernel.org>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Serge Semin <fancer.lancer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20240511104341.151550-1-aleksandar.rikalo@syrmia.com>
 <20240511104341.151550-8-aleksandar.rikalo@syrmia.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240511104341.151550-8-aleksandar.rikalo@syrmia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/05/2024 12:43, Aleksandar Rikalo wrote:
> From: Paul Burton <paulburton@kernel.org>
> 
> In a multi-cluster MIPS system we have multiple GICs - one in each
> cluster - each of which has its own independent counter. The counters in
> each GIC are not synchronised in any way, so they can drift relative to
> one another through the lifetime of the system. This is problematic for
> a clocksource which ought to be global.
> 
> Avoid problems by always accessing cluster 0's counter, using
> cross-cluster register access. This adds overhead so we only do so on
> systems where we actually have CPUs present in multiple clusters.
> For now, be extra conservative and don't use gic counter for vdso or
> sched_clock in this case.
> 
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
> Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> ---

Applied patch 7 and 8

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


