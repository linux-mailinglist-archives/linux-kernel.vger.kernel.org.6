Return-Path: <linux-kernel+bounces-344398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481898A915
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84592827BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C919259E;
	Mon, 30 Sep 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ag9ymcKO"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C5190667
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711471; cv=none; b=AFvQLfe6+Wl4yr/AniOJsawf4BY6AfzwPtqI8Co6M2ZVDMQuHYIDvuoKLhqhKE8Q8pMCtANsmqhOirNrMKPX6fXRh09pUVVQNBLrPEY3Q+miQ2FQgPoEovKZyBINEBJCP24/OXzVu5Mw6dmFMk+iC3YpBeClKk3umyJFRoNvf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711471; c=relaxed/simple;
	bh=T35ULpwVbRJuOmIRIx+os/9mu+do1wghrZm68Mip/10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifTnotgO5tqRj2OiDy3SIv5Isf/+rdi8FHyjjh5kcLWhRjcGlDQFCj0Aiwq7ucyI3+VIODn6EyML9grl/iMSTnfyA+yWbk1ojy6NyItIrAS0lYmGichXiEsqn2UATnhFvByNbWZEm9pD3Y8+8c5522O+KTPH+GY931vc/6bJOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ag9ymcKO; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a274ef3bdeso16979595ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727711468; x=1728316268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fuYkx8OLs+UXHSI5UZjYmH1ej22RCGT1VI15a1W2zpo=;
        b=ag9ymcKOg6YW3yR/6dqrI6K+xwnVQpaqwZSqNTJOlHF+F9SZJ7ZnbNBofQIxBIdQ4V
         dQIc+90iwpTDo4blBjq+fmfX4mlfrDrFk1XWZH0/d3WJRU7JqPg1nhMditmLIE8XBa6/
         +Zly4BY65aUcDBPfv385XD0mauB4+PWuYPa5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711468; x=1728316268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuYkx8OLs+UXHSI5UZjYmH1ej22RCGT1VI15a1W2zpo=;
        b=lIR1HKqtLbyoroQNduyAX7jk1iFDw8azkbaPUdDDR8NBHITk2AX14u7pYfYZ8XPrAS
         HUz1b/BJQBmdwK/0UCRKBlB4EwAkLXjLJfRC3ZshoYWiiyw/39dRGxrw0kp4xQCkdb81
         FktQYugkf7xa4WNRtC4Y2eg9sOnuVsnnj9qtKPqG8nsmzpqpmF7k6DAIxF99IsKjcNvP
         imeqBWYvEIgvVpI3ke95QktTLB9QOdUWC/c81CMBPJAFq9rEPIczc4oUkCNJUcBa/PN1
         K+9GWSF7JxNyYI51m9N3oByNU3qxws/kFG/dAPXavWxQOMY6ES1ikTVgX7aIOSebSa8F
         tDLA==
X-Forwarded-Encrypted: i=1; AJvYcCXE+lsCnjyeReKaoSL1KuAflnBbgTRW40c2H5XthroTP0GWSS+3TrXxgKL6gr53I0u5x7uZ0SYAu7QfU20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdG00hnppFW1DuCmqTJlPF6jEY0YFqFl54Yh+1Kp/W1QoxPGLO
	S4NY1YGtk6E9Xr6IExJnEul2FiTkgmbgA8yXKltyzvC45XtDgZU0BWvWwr5imfA=
X-Google-Smtp-Source: AGHT+IErVvKdnLHud2l/pbEVIBXMahmUvli74pzcDKIt9SByrthhCmfHU3YT0o4X/e1rsd76+BiXLg==
X-Received: by 2002:a05:6e02:216b:b0:3a0:a26f:7669 with SMTP id e9e14a558f8ab-3a345169020mr99610005ab.7.1727711468318;
        Mon, 30 Sep 2024 08:51:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88883534fsm2191198173.36.2024.09.30.08.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 08:51:08 -0700 (PDT)
Message-ID: <73b9ad39-cf4a-4030-83fc-4e632177b7a3@linuxfoundation.org>
Date: Mon, 30 Sep 2024 09:51:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/cpupower: Add documentation for some recently
 introduced options
To: Tor Vic <torvic9@mailbox.org>, trenn@suse.com, shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924141747.6428-1-torvic9@mailbox.org>
 <ba84bf50-67fa-44b2-b73c-f219c277e38f@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ba84bf50-67fa-44b2-b73c-f219c277e38f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 12:36, Shuah Khan wrote:
> On 9/24/24 08:17, Tor Vic wrote:
>> The 'cpupower-set' tool has learned new options with commits:
>>
>>    f2ab5557119a "cpupower: Add EPP value change support"
>>    df8776b03689 "cpupower: Add support for amd_pstate mode change"
>>    eb426fc6bdd6 "cpupower: Add turbo-boost support in cpupower"
> 
> 
> Thank you for finding and fixing this.
> 
> Checkpatch complains about commit description format. I fixed them
> for now.
> 
> This patch will be applied once the merge window closes.
> 
>>
>> However, the corresponding manpage was never updated.
> 
> Thank you for finding and fixing this.
> 
> This patch will be applied once the merge window closes.
>>
>> Add a basic description of these new options to the existing manpage.
>>
>> Signed-off-by: Tor Vic <torvic9@mailbox.org>
>> ---
> 

Thank you. Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

It will be included in my next pull request to PM maintainer.

thanks,
-- Shuah


