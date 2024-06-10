Return-Path: <linux-kernel+bounces-207845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B1901CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A0B1F216DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4A6F2E7;
	Mon, 10 Jun 2024 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnZk/cki"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7B23B0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008182; cv=none; b=mrODSBIoXi4XJW5GvZaIMnG2MVn0glcV5pKLKZIef9eqMi+/ezA4WJFAo7OmhKmnOVRw+U/turw/PSwKyKiiH0HJW9YCUww0WL+Kd9q1IIekmKfl+F2Z4GBLcU8NGXq/YpaFB6bx9d5s1h3QqWpKb2b9ZVnCtFnCaHxdka3Lbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008182; c=relaxed/simple;
	bh=gYUI0TcjL8jeMg7TO1X8UyEUwhAOyW6uLBMqp42OMR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxmHAOtp0+SdGOS5UBGcHaHOr7zM/JefcWhCek3NiLXnG+W5/tJsNiHmwUGeRwQ+5WgobsjbY1ukstWZm2J5sUorePVEx4XoeEEM/SyXRaZwIjNA7BAZjQ4hXjjBO8AmrhVv4NZY7Ukj6ug5ywjT+2AkORH81S9vMgK6OkI+zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UnZk/cki; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42172ed3597so14719415e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718008179; x=1718612979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5Z/eCEgsGGP99POdRTfA1A5PmBds/NTCrk296+lqgA=;
        b=UnZk/ckiunAd0E5Cd864OM5/x1n8yEv6TMKYGF9V2odeTKBM/Zo/ecikPhDRHWwfU+
         o0DCmCCdKA6pR+4xMWJZSBRyY4CP5ViHMDOtpLjF6taCedBygS6I2db1qsFem+zaWOAU
         Sm24/OlEYoaDS/NcFkDlS4GRGmcfCRmmpJ0EC7/6fXC0iHYTFuzSX5dHlc/miJo4Zwe4
         F72Ys2ut4EG1P3xdkTsbbRUsiLoslZrcV+8JufR1NgGwEn3JT+pPnr4jbA8wrIrFKkZD
         LAsAs5RCYqTPExQ2rb5VRpPb/BBZ8HAgxGHNUCO9FtRUVi/vRSlAU6JSO3jXg1Rf+6eA
         Qoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008179; x=1718612979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5Z/eCEgsGGP99POdRTfA1A5PmBds/NTCrk296+lqgA=;
        b=XYH42p4zEwS65lrCuGme1/LEq184lxOj03jYWS5PC4Qn5o7lVJqH3Mx0M69Zzi9izw
         gwJl/KtnWfC03K6zCTLaXI5pxhrTDhn+aZ41zzNCgGoPR4O2zqD3vSZAvvuFfcrjvR8U
         zau8m9Xf0okT+vRxQXR7WsJZM2ZbSeIUMN8P4zY7BPOjgXmUDCopznlc7H/WBACHwSDB
         whd3XuD98VSWJloq6knR70FVkZtnlRFojLwTEzm2Fuf24uaqdZ8nUFeNRZuG3W69XINq
         kp3Nth6qRJvkMkG6ZvtqKib69smoVJo8ZvAdMMC3w1KojjZS40OrhdPzvuXz3kn/JNhn
         o+iw==
X-Gm-Message-State: AOJu0YzCgocGGfwEN9UTIdDmSmZ+oJgO3A7zWa9thLpQcJdysYhsg2Xw
	evVAn3YzmWgjcumARGpL8bDmaZbeJ99ZzqsRT4aG8WfKMKPRerriHWbrakcw42U=
X-Google-Smtp-Source: AGHT+IFtnR9tlknSYMkx8Ww9jAaqIQehSpo1yhNw2e6iu1WeKOUZnOdeyvnjwD9HnnSofsGo9TnDbw==
X-Received: by 2002:a05:600c:4713:b0:421:5a2a:3cca with SMTP id 5b1f17b1804b1-4215acf6800mr109533205e9.10.1718008178684;
        Mon, 10 Jun 2024 01:29:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f2598ac1esm1533854f8f.93.2024.06.10.01.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:29:38 -0700 (PDT)
Message-ID: <c83306dd-60a5-4f46-83c9-257058f6e848@linaro.org>
Date: Mon, 10 Jun 2024 10:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] thermal/debugfs: Print mitigation timestamp value
 in milliseconds
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <1898781.tdWV9SEqCh@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1898781.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:55, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because mitigation episode duration is printed in milliseconds, there
> is no reason to print timestamp information for mitigation episodes in
> smaller units which also makes it somewhat harder to interpret the
> numbers.
> 
> Print it in milliseconds for consistency.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


