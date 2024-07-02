Return-Path: <linux-kernel+bounces-238402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098AC9249F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1341C22B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B620127D;
	Tue,  2 Jul 2024 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVosFV6S"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AA154C00
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956049; cv=none; b=izGAyHha+yS6/smpejOu779Kq+XPluxCoZoa6MM84Wa5lOiu7+HfGhYqsvlCHGeKby9S79IOvHvL65iiLnSZsYStOooyjgZgQk/q12I+myXLr44OA9QtdJTXCRXnNbnqz4AN4oRgFzo/hV5robftoFEmmVxbw8I7aGeeYwWtdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956049; c=relaxed/simple;
	bh=ELI3qm3FmCNzQfbVTY5hJV3PlWzVeUfnT25kFEvdp+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjL1hVwCQNAUhAnUtc8Y4d9Sy4zlGYx0auNsocFw2hIm7Ftu+MHQGrQlLVj2V9oHcEaInL/wF6IPiw2LmiTkjDLdOkr0aoE7uZfDN+wdZ5ajwTna6CvqVuIhnipsBqdSOk0piBrAMcnuhhA2gCEhAXBIcKIc8hh2cUhX5tv6mfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVosFV6S; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3745eeedc76so2255855ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719956047; x=1720560847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1WgNk/YPEbRVNBSRfJrE9za+i3oxO1I0TjYFVdi7kY=;
        b=LVosFV6SOdwJE8vs1ZKkpRVEu6+F9AHp25lwTL5QspYf7XlLKUOVCSY0dnvhK3Dddl
         0xcwNkUCu+38hls6fOoVMhNZCbZ/fzB8Vk8MeAgmCLCUBwt5Tb7foz/sPpW8cdpAMNXI
         LfSJpmOqEkD109N2zM2Wd/N3+1pkIbX2oOE6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719956047; x=1720560847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1WgNk/YPEbRVNBSRfJrE9za+i3oxO1I0TjYFVdi7kY=;
        b=r+8GyrRlVpVA0wWYgSNANgAT0LjImQoeivN92LASFtV2pZ+DyTQ0uQfaYA8jAHF3gk
         ji47tF+rdP3P+5ofDQvCiOLt8WuN3UzwlOt0w3O9af1TZh0v6u0irFOEihOFe1EBj6xH
         2XcgVLGCOSxPUM6HQ3XhHCMNBjOVRf4HOwVW3ZBJ3CcYO6uTQJKwdWj0bY7pf5+StLjr
         x3409qOf9VHpCvnAX7j0Gg3Kvw8NlRzIYYGpUlkoBAtmyQeOcziEZ5sRMO2SYURQT9AU
         Zwf3zq5Vu2epfn8C3IZb0C/tfK9Hc3ZFAlWMH8+SoXeMUJWbBQpotcMJEkweV1rZSANW
         BLog==
X-Forwarded-Encrypted: i=1; AJvYcCXJcHiCmUVesMHm3ZT2efy52oZVdfavCmXIgv1gnOiCE9Whs3ZCZNtKAByZE3mPmfcyda+4gT45zo0+LJ5xwXtGwVOwAeXoLGUfbHkk
X-Gm-Message-State: AOJu0YwVOdt7UrS+gZh0TrHg64ik3YkVWaRBqxAgy/A81wUROEJRggpw
	w0wCk7NjKgyortFspE5Mqu6zuouQWgIEhwfj88Y4NuBOb3zrj1YFcBj7MgQTcwQ=
X-Google-Smtp-Source: AGHT+IHtaBQC52DDcEJ8qeKFFOsLfGso6U0Z9VOH3B7LnIkEUyY6IjpKReJg7jT8NZRnXtU9141MDQ==
X-Received: by 2002:a6b:fe09:0:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7f62ed686a2mr915246239f.0.1719956046707;
        Tue, 02 Jul 2024 14:34:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e08428sm2972009173.77.2024.07.02.14.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 14:34:06 -0700 (PDT)
Message-ID: <753c55df-82d7-4756-861b-62e4e59c7615@linuxfoundation.org>
Date: Tue, 2 Jul 2024 15:34:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: fix lib default installation path
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702-fix-lib-install-v2-1-9b84dcd3c22b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702-fix-lib-install-v2-1-9b84dcd3c22b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 01:56, Roman Storozhenko wrote:
> Invocation the tool built with the default settings fails:
> $ cpupower
> cpupower: error while loading shared libraries: libcpupower.so.1: cannot
> open shared object file: No such file or directory
> 
> The issue is that Makefile puts the library to "/usr/lib64" dir for a 64
> bit machine. This is wrong. According to the "File hierarchy standard
> specification:
> https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf
> 
> "/usr/lib<qual>" dirs are intended for alternative-format libraries
> (e.g., "/usr/lib32" for 32-bit libraries on a 64-bit machine (optional)).
> 
> The utility is built for the current machine and doesn't handle
> 'CROSS_COMPILE' and 'ARCH' env variables. It also doesn't change bit
> depth. So the result is always the same - binary for x86_64
> architecture. Therefore the library should be put in the '/usr/lib'
> dir regardless of the build options.
> This is the case for all the distros that comply with the
> 'File Hierarchy Standard 3.0" by Linux Foundation. Most of the distros
> comply with it. For example, one can check this by examining the
> "/usr/lb64" dir on debian-based distros and find that it contains only
> "/usr/lib64/ld-linux-x86-64.so.2". And examine that "/usr/lib" contains
> both 32 and 64 bit code:
> find /usr/lib -name "*.so*" -type f | xargs file | grep 32-bit
> find /usr/lib -name "*.so*" -type f | xargs file | grep 64-bit
> 
> Fix the issue by changing library destination dir to "/usr/lib".
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Changes in v2:
> - Enchance changelog by providing more details
> - Link to v1: https://lore.kernel.org/r/20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com
> ---

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

thanks,
-- Shuah




