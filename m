Return-Path: <linux-kernel+bounces-234510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8A91C780
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8681C22B08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B257A15C;
	Fri, 28 Jun 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PLdC4c8V"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAB79B84
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607701; cv=none; b=LktRWtFUQ5t7tScIVnC6kmm6qGqbXixuel0hmE7s9qql6wAzHh1lYJFyDW84jAwRbjGwty7Ur07lA95AX42hhyvCASk8iW43QC4Bfn1/wdkSRnqiaE0U4GzqTaDOATo5qz3l30DsBRl4ecVuMiz6MI7q6QRG+enuwqer0BOMXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607701; c=relaxed/simple;
	bh=/SZ/JnYlwLFnsngI10vRLKDskTGPI1uYxgAhl8eFLLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plbwa9PHaeYOiOnPxtbl18VvzEO6lUJ8+hEWSxvrxY3gs/wqfbqQJUJiRL/PZGfYpR8xcSijXeM1QVXl8esRnRoi+ROE7eJKMoFvYy9e+cZqeeMNl0Fh/VkePmLc4IYWxrs81SH+XuWVVPl7jJ27R7ht9R6OlUcjhrKYAie7hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PLdC4c8V; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so659975ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607699; x=1720212499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RhRAaIcFckOGbSwBM0gw3fA4UHYAsq+QsUTelxyxGQ=;
        b=PLdC4c8VQg6bWcjZC86vGrDsJnb/Bm4tXvEX35m+bGxIufLWByZZM1Ah41Zcnh+8ec
         9i7ECKKOkQKJclZiBQ5GJof0MXHF3qgY6AEQ1EigEL6oDGxRvW8uBpEOVoca6Fz1QJzu
         EPWm/ZvwxU8Q7qW9v4yEyLuCCfS1xGYQfLXbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607699; x=1720212499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RhRAaIcFckOGbSwBM0gw3fA4UHYAsq+QsUTelxyxGQ=;
        b=djh5zl+KbyfMWBxefAZcU9FfzsewKrwfpA/RNeCMJ6njOJWk2UqWbrwHiNBwJl9+m5
         radruchuyoKza5Pyrfx7BfdqjC2lOE8AxR4umrUEMKk9HnXWHRUt9W8eI6sPAfXU8pF3
         zX53jtwR91t7DQ6GZ5yZYoKRkWJYpYZuifxX6IoT9SbmldeBQqzumrqchzv0+il7qTII
         Pjmz9fjXm759PsOLNwWWAHjTs8VAcIk27h2lMpXhCB920IQfL8SLw5fINiHjs6lI1Dh8
         kmPYze0qVw2CvtKRXo1iUQj2gqsb8TmjQwr2izMDk9UDBp0mKoJrOI5S/0N4Bps163YR
         P4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX4+OUTp8cyIrhuq3/sdsYJMtHZjBZ4X+i5jJbjKzqQr94tnvj59IGV3GVL/kCtmE6qKoi+iWI/goxkrtleVqYMjxgj5oAO49CQSP71
X-Gm-Message-State: AOJu0Yz4UuZ4xrQgz5k3NXTKf9nGdAcq1okcfZxPIBLEe7/0BHPCzb4x
	/V+K8SBVKc5bqV8iZ7jth4hsOhPT0WvIsjgu/6I3lsCYMSKHR7GofKQXWOmF5iY=
X-Google-Smtp-Source: AGHT+IEpT2FqyZwzrw4cgsy1Nsyp2Z/9sYFxpXDuMiO3v/g1MjK8gxBVsPt+mwmLQGOJ+AvYGMYPvg==
X-Received: by 2002:a05:6e02:15ca:b0:376:4224:7611 with SMTP id e9e14a558f8ab-376422477a7mr196355695ab.3.1719607699339;
        Fri, 28 Jun 2024 13:48:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad29827d6sm5844565ab.32.2024.06.28.13.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:48:19 -0700 (PDT)
Message-ID: <30c9717b-3714-4340-9fb1-9b4a78701daf@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cpupower: Add 'help' target to all the makefiles that
 don't have it
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> This patch series adds the 'help' target describing all the user-available
> targets to the makefiles which haven't had that target yet.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Roman Storozhenko (4):
>        cpupower: Add 'help' target to the 'bench' subproject makefile
>        cpupower: Add 'help' target to the 'debug/kernel' subproject makefile
>        cpupower: Add 'help' target to the 'debug/x86_64' subproject makefile
>        cpupower: Add 'help' target to the 'debug/i386' subproject makefile
> 
>   tools/power/cpupower/bench/Makefile        | 12 ++++++++++++
>   tools/power/cpupower/debug/i386/Makefile   | 12 ++++++++++++
>   tools/power/cpupower/debug/kernel/Makefile | 12 ++++++++++++
>   tools/power/cpupower/debug/x86_64/Makefile | 12 ++++++++++++
>   4 files changed, 48 insertions(+)
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240623-make_help_rest-e799889f43a1
> 
> Best regards,

Sorry. I don't see value in adding help messages for common make targets

thanks,
-- Shuah

