Return-Path: <linux-kernel+bounces-292710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D2195734C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00981F22A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE3189512;
	Mon, 19 Aug 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4tPbha5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834F172BD3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092311; cv=none; b=VeNvrWRJFlEfrJ/TpJnAO9rTE77ROTmP5AKevc1JMubyxfcQLK+7IBriVBRWieBNHEdhsxu/hG0pdLTXjMngaCmsqFZloftjLjES4bs8R/BZjS0KTUB3yawoTnooHE/kRwmFYarKbVH8TbGfZI6ldYeMroi5qOw68kVG60zr4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092311; c=relaxed/simple;
	bh=jz/ZjxWSKaV9E21NAp8gn+3Khw5Z8VpNkDbDc9dwc2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4o0OsBt1QLVVDSvYL6uQqFkWvG7axmlcHGpQotd7MO3Ou2rrCYfPyL88oJ6Y5uJ/Tb7rkUvqBZ+qIQtLX80qLqJRW4M2eLhC+Xzx9cOT+tgPY9akK0uDy5vnWvlwd1jr0YUa7PgdZpjbfwMsjPgKwTsTOBTVQktH8xoUCvjXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f4tPbha5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so35195905e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724092307; x=1724697107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxaAE4cpI7LMjHmJRrNjbSHDwPUlpGudLSFm8GQhDF8=;
        b=f4tPbha5pK8VtHWpwMeJFtkj45/3cXr50Yh+mo8gKprpHBrzBGpRg+n+oDL1rat7ju
         yKEpkAS1qJfZSAapFcnwqo01CeF4GpxcksfNMMXmaXnOmPKQxI6Ckl+9XG09oXx58OY7
         4MZUTKf8rNZDjEJvPv+vFlvNr/IuY1CTxtpuqE1k1gtwj98+gObqSubEwAih7Z1R0+Qv
         wKrun248c+IsZ1ShDzMLMoyvj4YHPVsqZHJt8olADLo5sBoJx4ON5OmRarehlyyICFme
         Octbr5HVF5zxQmBBRkT58+GYbMYmWyPKa1zXxamPSonNz23c87TVfZqARH9qKZFBdZsd
         /8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092307; x=1724697107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxaAE4cpI7LMjHmJRrNjbSHDwPUlpGudLSFm8GQhDF8=;
        b=k+NZpgxaGWlYj1E9HJ39HtsVUSSXwjoDnyu/eAjyU8UmKVshSSpIpPI8pGuIp8T9qO
         +ki3JNT2Ts6KIiAKMdK3bWuPz4D2x9p5B2r4P3vHHDBB46dmdZmTIrK745cCxEforpd/
         4NeQ3K41hHsBitHQydmUcc5scw+/RSok0Jn7FslA3bx0u9qnQz9PcA+pzQWEWlqFS2iK
         cU7v42uY2Nx5HyyEHJpUA0i56v+iEBSIM8lpBXD9+5PMxEWp3u+1xMv5Wxbe21w1Pti4
         OH0yHvLJNt0zQO9HOXCBc6jo0rQdO2Aqdr0WseYrUhG+rCCwIxjXTo1MdGiXKKhEEPfl
         z1tg==
X-Forwarded-Encrypted: i=1; AJvYcCViIMYfO6G7u0A3WwL+FqrwjT3CZjUaNZ5qJHwHJYXlWvtff+YfISANuzxfA7rxR3hQcFL9FIivC6ZUU21YUCdLoErVcuG3Z/7MPDx6
X-Gm-Message-State: AOJu0Yy11X/0NR4vr3mP9KJGcjCwLbHPEF+O3UOe2Vw1/MWdykzSUJx2
	ff5t+jOQQ79Tky5vw9ZwcYUuapsC7ddEAoUDMerx6YHtyQrXcwxBD7H/duSCH8L9kg6qPDprW1i
	C
X-Google-Smtp-Source: AGHT+IGPqrsA51V094dT1HNJcTdp79GxbmHxHjfGNtOcSLpkTDIiIZ0jqfcoK2vPtTRfbGZLpcLtmQ==
X-Received: by 2002:a05:600c:1c24:b0:426:654e:16da with SMTP id 5b1f17b1804b1-429ed61fe76mr91314875e9.0.1724092306583;
        Mon, 19 Aug 2024 11:31:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ed7847d7sm117705455e9.31.2024.08.19.11.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:31:46 -0700 (PDT)
Message-ID: <e438d8c4-3c10-4674-916b-dd645d19f210@linaro.org>
Date: Mon, 19 Aug 2024 20:31:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] clocksource: acpi_pm: Add external callback for
 suspend/resume
To: Hans de Goede <hdegoede@redhat.com>, Marek Maslanka
 <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <935e8c82-3c91-4c9a-8e43-e6045b28279d@redhat.com>
 <20240812184150.1079924-1-mmaslanka@google.com>
 <e0068ba6-c211-4878-8f16-fe97746c2a56@redhat.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e0068ba6-c211-4878-8f16-fe97746c2a56@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 13:35, Hans de Goede wrote:
> Hi,
> 
> On 8/12/24 8:41 PM, Marek Maslanka wrote:
>> Provides the capability to register an external callback for the ACPI PM
>> timer, which is called during the suspend and resume processes.
>>
>> Signed-off-by: Marek Maslanka <mmaslanka@google.com>
> 
> Daniel / Thomas I believe this series is ready for merging now,
> do you want to merge this through the tree for drivers/clocksource ?
> 
> Or shall I merge this through the platform-drivers-x86 tree ?
> 
> In case of the latter may I please have your Acked-by for patch 1/2 for ths ?


I'll pick them, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

