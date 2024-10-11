Return-Path: <linux-kernel+bounces-361908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD699AEC7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ABBFB22560
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003811D357A;
	Fri, 11 Oct 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GrB5jdd+"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF610A1F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686881; cv=none; b=D2V0g3sfUElgeJgINmdwZQafXF50uBM9+2cvCrJrnzFSPlmKwwmXAbP1Lmt4pyMMN5pK5K7PD+avGkBQ4N1qYyF7w2PaM1x1z+Mi3PWoqIA1Z8la4FbWB63JWr9y2U+u+acuTn02rPSWensPOoOn+EZqmgrJ+pxfBzo+uC0oGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686881; c=relaxed/simple;
	bh=8Wi3JDBUsjlWjnvtJ7Q5guyK217Mdacnj2mhUbIEHjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cy1ekGs8qwE01AmMNfy46KyLGJSEaAEyD7OmD8kZbgU4aCKnwLfOEA9BwxsfbMOBqJgYsWWuVo18AwkL/nY35eBNlCUCPx6uzS7gqEl8uNml//rGK8OaCagFtV6RoEGzx1DuzHJfj/iK3zf+BJKT4cpcLGqXfdO6B7NHay7ceTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GrB5jdd+; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8354851fbfaso105594339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728686878; x=1729291678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mzp/hzrig+fA9YNT0bwYNz6N6cWFF5q15o65QRPQI4E=;
        b=GrB5jdd+qgnOo36dol5rh2/mE79EVumz1oA77KDdChc+c+ecIhVf/pnuRv9/iPSVwg
         aXht0bAdX0iNvn+dD3z0hjbgGFSaAVVpKh2lLtIB+MW4yiy2YIYAPNr64dY8Bhgfx/Rs
         qtRhDKaCepQRY8bfzTFE8UWEALiTDWXC2rVDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686878; x=1729291678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzp/hzrig+fA9YNT0bwYNz6N6cWFF5q15o65QRPQI4E=;
        b=dykf00MoWP4sblj9xy0LybQeHlkwMhHbX/Jq01h6km5F9iyUeHrWV3L6vrrZSgtQBJ
         xDKBwigcqoHxh22KkV08oj9SaW3Fk2WzVMXgA3Vh6um3zeX8k/JWz0KN3dqsdsGf5lu2
         zCAlfP00yoxQeBjS7reuZeLS73xn58raNj7TIA1JuH2kj+ytqvjf/YHMwVsBI2mZjfYp
         Xbxp4ZVld5w7TElL80AXQwFFgRa7YR3R8me7rDYAtT9nWwdcd40cTac+pUPjLi3zJRSL
         XqjKOj4ulF+pw50u5m6HjQyC5utXT5/cO3xO+eZXua9K0//SQJym0bO/Nr9yKGnweuQd
         2zOg==
X-Forwarded-Encrypted: i=1; AJvYcCXHTNYOqh6wtliRMO1agMWZYG6p9k6wi5NqwQGtm6CpYS2c5kC1fla5eemBmyWH6Dft4gu7DfsQCIG0KDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxMYW7xDrRlg2Bczh7AWu/08ta7bMMVhgyK2nHe8MAhDMOSZU
	9QtYnRjGjWN8uFWTOevxyNDwzincWAUftofveWfrnc0LLDyeh9dCZOzQEDFv5Hw=
X-Google-Smtp-Source: AGHT+IG0dUmfLDdjMZKEXCHE2/Ff048pzK4ndO/RCt5YWkpFQDA+iNmvFMCE0kNqO61/TE+gAbZIZA==
X-Received: by 2002:a05:6e02:2181:b0:3a0:c88c:e674 with SMTP id e9e14a558f8ab-3a3b5f1de0bmr37302095ab.1.1728686878155;
        Fri, 11 Oct 2024 15:47:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdbcd1dsm8935795ab.43.2024.10.11.15.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 15:47:57 -0700 (PDT)
Message-ID: <e1e59650-0c9d-4100-8e6a-be640caea281@linuxfoundation.org>
Date: Fri, 11 Oct 2024 16:47:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix check of return value in
 fgraph-retval.tc test
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011132042.435f43cc@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241011132042.435f43cc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 11:20, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The addition of recording both the function name and return address to the
> function graph tracer updated the selftest to check for "=-5" from "= -5".
> But this causes the test to fail on certain configs, as "= -5" is still a
> value that can be returned if function addresses are not enabled (older kernels).
> 
> Check for both "=-5" and " -5" as a success value.
> 
> Fixes: 21e92806d39c6 ("function_graph: Support recording and printing the function return address")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Shuah, this update is only for changes in my tree, so you do not need to add it.

Noted. Thank you.

thanks,
-- Shuah

