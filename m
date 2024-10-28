Return-Path: <linux-kernel+bounces-385259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86A9B34B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8B51C21F14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38951DE3C4;
	Mon, 28 Oct 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tq/YRZe6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371471DE3B6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128980; cv=none; b=ZO+vjMBmUmZxIahCJpIAg6TTauTLmwYHuI1r5VQIne+anqPIDtt0VCorxXcgMmA+V3DjKKjsc/DzoZ5OWlcY0T3q3mALIm936DEeI/Cw5y00jR90U2SQrgeUTnrvBqkuspjoZHO8+fNsg2kyhlVR/2i7YVlXznu8/TtAP3t3Ep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128980; c=relaxed/simple;
	bh=EhGA/w6VqPqGH4ru+TU5o22hT12tmtN1Fy7doR4H670=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqB9HW9vo71EB0z0vNqOUbStGUDR7FaKmJzJobD2VTAu3cDPa37+Q44abs/vR+GsjF66nUHC22auNshu4HhQoWc+l87vl+javopS9owVFgWAeTEpEKD5VGAmzG1264SaAxfkBGTG7zobxkU/Y0HDvxRlXvGcX/vdDVO5TT5+bYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tq/YRZe6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431ac30d379so8346015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730128976; x=1730733776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hkXXAhpHynUOugoTbYUD7dUzU/PyL/JmJdDYDXegZA=;
        b=Tq/YRZe6k63akPD8f21mBuq4JXLYND0R5pLzZFyvMWgiU+rwS/J9XX3yH0FYua4MUj
         FOco5epZVo+cb9pqkWfSPi5y+FdfvQohQZuehNvRUx6swTkhv/pT6Hb3ndCzY4A/Sxpw
         YqovCSr2rJ+ZGB7EwITKTnQ2BTMxLfkUFpXrKsmQPSnFaLmrYEZl0Qt7Aq+k7nws+3LV
         1qEfpzCSt94LjQX/4zRI2vKoZjRK6avVZqXl1HjpV+wUVA1CNIp0wvBF3kTRqFsyksr9
         U6wRE0fIn2MMxNSFHR4i4pdggLF+7+292vTYU0MQfgOecEAAW6AAKYpLHqsNHDBbOVh8
         BLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128976; x=1730733776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hkXXAhpHynUOugoTbYUD7dUzU/PyL/JmJdDYDXegZA=;
        b=m1Aw7rALV79/YZFZOBtkx5vfwf88c7QFo3DCcCOSuxiVhOP5z1JW+hSUqKiyAsy+UH
         du88jA3Dwkms0nx0yVC3LAQGm8Leyhi4HlLdoE+DplUVn31wqYNL7a92MrR10sEtXKaA
         mkFDnwQ7dXirqQyOc4h6v/vH7XcLxq2TzkSruBiLdxmBW4BtmJGuIfG0Iz+tJrlvEKjL
         n9JCnlzJTFag6xjll4R8GICgFcLajYEtg/78IgnqAKGOYraHb6yg6Slkhy9jmjN2o9D5
         S+OpxhLPHkfCYP/lpbwoeiAcbMnWGVBNEMHWnZIb/nuCXOhs+Exv6AHV8MdPrNwA6RRH
         Ueew==
X-Forwarded-Encrypted: i=1; AJvYcCVbg/A95vL+eaVK9bzmiKI6DDCapr0a5BRiCxo8UAODV3jardDZYcB0CxW4R9tYi5VCFObD1Rhs5tNJnDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIAyXrF7s/xF78o0iWVOu0pOKdkpMZLaFa6GR8gvJunpHF/2N
	5O4KQ98lCWTymxoCWBw+vGCFhG+5u5hfAh4o4CA22xrutSOymY7Go5aXcOXOqz0=
X-Google-Smtp-Source: AGHT+IFjfsCpRopIrxevt0qMq87ZyoBVAYz3eL9HnP4zBNZP/+ipXQpaMCoWpzrRvsMANonvUGeBNw==
X-Received: by 2002:a05:600c:3b86:b0:430:5356:ac92 with SMTP id 5b1f17b1804b1-4319ac7642emr76052185e9.7.1730128976419;
        Mon, 28 Oct 2024 08:22:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-431935a5943sm115111375e9.25.2024.10.28.08.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 08:22:56 -0700 (PDT)
Message-ID: <afda1ccc-d9fc-4025-b114-bd2ddf5f7ec1@linaro.org>
Date: Mon, 28 Oct 2024 16:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/12] clocksource: mips-gic-timer: Always use cluster
 0 counter as clocksource
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Chao-ying Fu <cfu@wavecomp.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@kernel.org>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Serge Semin <fancer.lancer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
References: <20241019071037.145314-1-arikalo@gmail.com>
 <20241019071037.145314-6-arikalo@gmail.com>
 <3c98775b-b61b-478f-838e-59f8e1cf8aed@linaro.org>
 <Zx+qrRVdv5EGXbCF@alpha.franken.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Zx+qrRVdv5EGXbCF@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/2024 16:15, Thomas Bogendoerfer wrote:
> On Mon, Oct 28, 2024 at 03:54:48PM +0100, Daniel Lezcano wrote:
>> On 19/10/2024 09:10, Aleksandar Rikalo wrote:
>>> From: Paul Burton <paulburton@kernel.org>
>>>
>>> In a multi-cluster MIPS system, there are multiple GICs - one in each
>>> cluster - each of which has its independent counter. The counters in
>>> each GIC are not synchronized in any way, so they can drift relative
>>> to one another through the lifetime of the system. This is problematic
>>> for a clock source which ought to be global.
>>>
>>> Avoid problems by always accessing cluster 0's counter, using
>>> cross-cluster register access. This adds overhead so it is applied only
>>> on multi-cluster systems.
>>>
>>> Signed-off-by: Paul Burton <paulburton@kernel.org>
>>> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
>>> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
>>> Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
>>> Tested-by: Serge Semin <fancer.lancer@gmail.com>
>>> ---
>>
>> May I take this patch through the clocksource tree ?
> 
> sure, should be the best option.

Ok, thanks

Can you add your tag ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

