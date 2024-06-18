Return-Path: <linux-kernel+bounces-220004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C332390DB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1391F22C95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D24815E5C6;
	Tue, 18 Jun 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Urcbkf9Z"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C315DBC0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734585; cv=none; b=dp9s4UUesWtPoy+vLw4p+atrw1CO8cLcODT5kUri1klHDM5Y8PBvLZR6gv/uwstWtawerGw3OrOQ+hkCNB7eWR8rt5WUdUUF19ErGhntmCg5LS6kxnkTsmDR5K20RT9/J9MY9IDozr+/rykicNe+OKlwylUsHgziFB5Efr5f538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734585; c=relaxed/simple;
	bh=Xd9LdCiuXzzrLb/1qhOQ/z3e3gMYk8tNFBwJ3qgTDjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFl8LAc+WMW48z4ue607h/ylo+Q0Bl0VSRO24t+ik+JTVMOnlW2bKt5Tz0A5RIrPkSGYgMEzyD1yIfEuAb7cf/9w3EOSa2Uvb5JPSxnrZVqYpzebGp7tIVG0DdqDjNsnQ6ycc28od15YufA0VMraleCRcpqG9pSKiJPRI+aLNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Urcbkf9Z; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eb8889a0baso26335939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718734583; x=1719339383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ihGEwptJ7lzmt0VyV4WSE4aCrQ7bj97SuSjjG8ijr0=;
        b=Urcbkf9Z0VW2v/rHY3clFjTl7eWtNYbTk1qtg4uANGDdQtbV/KZl4f9FPIyAVAzJYo
         4j3JW0mHcUOL4YcjQSTaWxu2wRlxj5fYfTwuJsSP/7zI85W+/ZPiIyjWvs/wgDMkh2PP
         5uqpdBOKANLlomtBBR+mpHP7h580JdL6hAnvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718734583; x=1719339383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ihGEwptJ7lzmt0VyV4WSE4aCrQ7bj97SuSjjG8ijr0=;
        b=aXa26M5VPFCtLG3iH6/jS/YIIecydxzWrL/woEy5kJQv9em2jl1eps/dU0A3nqE9mL
         QzR3J+fOXAYBF577wYBkPcnouQLZ4e9dKsMnt1O/uuv0CTSwhf+nNJhnsmKxI3bT3O0k
         DcvDYNXQFRRmrjZfvgijveiK4Dq0Lje8eNAkEWyV1GpS41ik4yhxyV7WhJhFm6GB14Sb
         cWpmTpFOfLb7Eeb6tFRuWK2rcGepPvcxJzFM0Qb5fCU/0WtVUb4Kaoa8gIMMwCdxikx7
         FbIKTrfV9mOHX/gMTK4y+fLx4Nv85QT+s6SsFJOnjJruiJxKktuA9qmNjOWj6AGfC5Uc
         /fYg==
X-Forwarded-Encrypted: i=1; AJvYcCU/78O56No9EyBMZmBA/OKHqdT+/3wnddj2HG6igNzV7Gh6p9Mr5mVh3ZwRCwBC/0U5mlyg0nEJANVPB/LZM6XgPzvjWi2LEsAW8SLk
X-Gm-Message-State: AOJu0YyVXbOsVPHp25/zNbormUIWaiXuLl+VxSmWCNqP0RCx+QNVZoAt
	YYcRvAzRgz1VrswcIbrNof9k1kl0uR2gHaT5asf88F7OZBnakbmKqNlBPR6ngcc=
X-Google-Smtp-Source: AGHT+IGb+rQjGNQfgCnAjxZWwwQu1kCSqGzROd8BdJkx/6xx0wvnNPwoHeYLw3mTO4nln88oA0f0SQ==
X-Received: by 2002:a92:c7c7:0:b0:375:a361:c796 with SMTP id e9e14a558f8ab-3761d6e5e34mr4173475ab.2.1718734583376;
        Tue, 18 Jun 2024 11:16:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d86aad59sm22095535ab.24.2024.06.18.11.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 11:16:23 -0700 (PDT)
Message-ID: <bffea670-8062-4d74-af47-26ef17c76fb0@linuxfoundation.org>
Date: Tue, 18 Jun 2024 12:16:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Add 'help' target to the main Makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240615132613.182899-1-romeusmeister@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240615132613.182899-1-romeusmeister@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 07:26, Roman Storozhenko wrote:
> Make "cpupower" building process more user friendly by adding 'help'
> target to the main makefile. This target describes various build
> and cleaning options available to the user.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> V1 -> V2:
>   - Enchanced patch description
>   - Reformat patch
>   - Link v1: https://lore.kernel.org/linux-pm/20240614-make-help-v1-1-513118646b71@gmail.com/
> ---

Applied for Linux 6.11-rc1
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

