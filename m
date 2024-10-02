Return-Path: <linux-kernel+bounces-348238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC098E473
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD67428398B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DC21731B;
	Wed,  2 Oct 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2WFB0Zf"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666A212F18
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902363; cv=none; b=Q9FlBJtkMj9ekWrMOnGj2q6ASsJxR8I2gCQFwznxiSb4pfpQySsFcJb6VvkIff16GQPj4srU3ISDG1gyk74tR6vS2NYWE19MgZso+KT5dQzDMx1VyUSOx2pCj09+4dq7YKZU/buix09oCZNR7wxJXLrhVj1VDrtiUOQ/ROnuwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902363; c=relaxed/simple;
	bh=gJajV+BhGLEXtbPOI47GgYVtQY9B7KrwnDOiBsV8VAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/FlaLhRUBkw7FUnPLvqJcMetAbRuTOHAxekZZ7qSiyuyDKGeRpQ7lacid67QiVKLNzmL76ebEbMeZBPldi9Rqr6ucOU+NlI7KkCHMsX/pYDlEtmEUilJP9gqu7+r2amx8fWAovVoCHsQW1RcHIV07MCuwoD5bMe4vYMFkXTw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2WFB0Zf; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cdada0f21so12156339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727902360; x=1728507160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCyQ9VKGqvhwLuEsvgA6RiF/9EhGoJ4EV1yv5bBeEX0=;
        b=R2WFB0Zfqm1DDWHWLscXxvgA+UzCjzfrUwkEgRZQb6+osjzRbDWxP9M+Rxt9MVcLca
         bjydnk42AXFQvWdjPUIRjDRf6g846qdZNxaNpjj3P1RIF/G+r4EKVSD8zVC4jaCY5kiC
         bbG0A2haM3xU8CfDgwPz8vtPsmrlDVpZGhbY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727902360; x=1728507160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCyQ9VKGqvhwLuEsvgA6RiF/9EhGoJ4EV1yv5bBeEX0=;
        b=e9jRaHekFgxbI5sJSboIVPFt4oVIvjcvb4vbheXfjeixt74pSWCnNrJog0HNLNNv5O
         tAnm0vJkcmDG+8uPhrVXTtE6OOri95moxff0z7zx4ezY5LAIQU+E1w8u6kjLWzUs4NUS
         uOVp0/eNOhgDvFYwlMD6QY+7ummDHofTfwnNUNqhBq7C8tazmFboQk4xcn+XIoO84IJA
         xt0NuY0rc/4Ztk7oXvC8zPyMQYapiS/HrnmnN7aMKxsqC8qhaztr/Q86UKe3+5UbbbEQ
         ORhfxxiq0MbqiZqiFCArepcNOSvOyZT3n21xN9Qx85+tnQ5MJUeA5oZWj+eVoStyN1+M
         3O0w==
X-Forwarded-Encrypted: i=1; AJvYcCWRuu3IlLI0KjrlE8JcRJ49qqFa3kIR1a98iFMoX0oeH3ZSNizmCy6muMaI+9AvSzRwPr0EE0W6UpfThjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdodVtJcZu1FE0JjSd+S+TfKYgb1arUDL4C48lHo7dQ/w1cUP
	BH+/aLmHtZpuoAvd5uJ3rwGqtzDAg3AF6X5Z0jp2y7GQ8geijGLmwjroeFXrB8U=
X-Google-Smtp-Source: AGHT+IHkMe4gKs+zRaMgwe7AEeplB1+VjeYK05fvEALbTNW9ecqySb5xDGmPD9cweqOlqXJ+MMmfTQ==
X-Received: by 2002:a05:6602:13cf:b0:82a:a46c:4153 with SMTP id ca18e2360f4ac-834d84baca0mr473453639f.11.1727902360316;
        Wed, 02 Oct 2024 13:52:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888d828esm3256949173.121.2024.10.02.13.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:52:39 -0700 (PDT)
Message-ID: <f884b71e-5f88-4b82-af64-ddff08e60813@linuxfoundation.org>
Date: Wed, 2 Oct 2024 14:52:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] pm: cpupower: bindings: improve test script
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240930232158.29024-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240930232158.29024-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 17:21, John B. Wyatt IV wrote:
> Improve test_raw_pylibcpupower.py with some cleanup and catching more
> states. This includes confirming states have been disabled and a notice to
> use sudo.
> 
> John B. Wyatt IV (2):
>    pm: cpupower: bindings: Improve disable c_state block
>    pm: cpupower: bindings: Add test to confirm cpu state is disabled
> 
>   .../bindings/python/test_raw_pylibcpupower.py | 28 +++++++++++++++----
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 

Applied these two patches to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

They will be included in my next pull request to PM maintainer.

thanks,
-- Shuah

