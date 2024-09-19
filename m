Return-Path: <linux-kernel+bounces-333767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDCC97CDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0561C21976
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961681F95A;
	Thu, 19 Sep 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRQ8Vrjq"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690E200AE
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771146; cv=none; b=jd5wpxKCLDSlX3nzWQxTG2CE/OJgQjO7lu3/bB0He1ujkzZHD/W3dfjRnjxJn4lUFVNouU/QPYYK2kJjKtDbjw/Vs6iaJKJdd33gP/6E0Yd0qRlmD6PUc30dDUNOz4lM7EQJ4PjsFesTz/A9Arfqnx5CGMYNm80+NmMTNHYw+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771146; c=relaxed/simple;
	bh=11xZIjKNQ0UVk03B85El9Ld2IY8eytZtUo4DOnK/XRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6dLC+2OYGha7lNzudkNluyt1SkvWNX2umdBRqmOplD2cbhN+ymwDLvnz4KBkmo09LzcdtZKeo0rDkxdA/4tk0IPETNzCadVmx2yGIErIrIGMbHkXMEpNxr1MXUOcDe2QT5K/XHrWqxljKYOVHcH54QqO694bXchTHeptFD+L54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PRQ8Vrjq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cdada0f21so55880939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726771143; x=1727375943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRyKNx2jUNgKj4rHJ3yEyyNhXDGHWD1bthxzVxSAiQg=;
        b=PRQ8VrjqhCNMVKhDbeNHS4X4gaUMGWNJ2NrASoTB+qif2NBz4dhL2RhkBLAsTLysTi
         ftlpQ4gRItDZtiZAw8BngYJtaX9vm6ctyVA++I+JLZEsOzirKhwUcFBQekpJVw3MQGC8
         t+JggG/LaICTynD8Yl4iN+j61+aksk7Vti3y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726771143; x=1727375943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRyKNx2jUNgKj4rHJ3yEyyNhXDGHWD1bthxzVxSAiQg=;
        b=pOQp1apfOKZ/VKNCYWR6j3hbm4+fpIFhwhM1PjnPjotxrFUMM7/LLJ64vA9Q/vv1Ot
         kYhJQf6DQM8UV/c4N/iWcIA+NJcbW21s9IB86Q9JdHqnABtqINlAiYOuyN4fv8t2jCQv
         LrBhu+uOP6CaC3HmSr968LOf4wwIf6lPwOqIXdLOyn+2gji4MT0u6gDAqxN0mBBzK0F1
         mMesbmu00Rde5Al1uzW8f2G6wlG+ldR46NJJtEdh//eUPcXEMIDiPRa/rGTVzrXyJoFb
         gZRJBrcbYWJ1Zs18YrCML88pZYXNulW7DjEAFB8vnqYUfyQVTyQ4aANl07DKabe4/UES
         Mn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCrjZL5ciL6Xgmw/T4oc2YYY7Ztq5a3alZx2vWqIxk9uAmYC8wschlnOuDKyuGlfLLQu7dUJFbUEc28X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLrrvgbEwNxzLUpkqKQo9/mV8+jRxLitr3YNoTnP7k4hkq9hI
	4Nakd9HbO4tkTUqnMwF6q46mmz4n9ysYwhbjyJ/KWZeYTvniZ9f66DOvrhNzrBM=
X-Google-Smtp-Source: AGHT+IFiLbB7COufygh2ZrdMKfDaWHmEzlqXMoaF0ODyh+JInGc9s5TK3WvqOPyzSjOegwr5CjfbEw==
X-Received: by 2002:a05:6602:6016:b0:82b:c712:cc0d with SMTP id ca18e2360f4ac-83209e8d53emr40192539f.15.1726771143404;
        Thu, 19 Sep 2024 11:39:03 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec17e90sm3101385173.52.2024.09.19.11.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 11:39:03 -0700 (PDT)
Message-ID: <272b9839-f2a0-4090-be41-cf0ff8721808@linuxfoundation.org>
Date: Thu, 19 Sep 2024 12:39:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Clean up bindings gitignore
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919180102.20675-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240919180102.20675-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 12:01, John B. Wyatt IV wrote:
> * Add SPDX identifier to the gitignore
> * Remove the comment and .i file since it was removed in another patch
> and therefore no longer needed.

Don't use the * in the changelogs. There is no need to write this like a
itemized list. Simply write it as a paragraph.

> 
> This patch depends on Min-Hua Chen's 'pm: cpupower: rename
> raw_pylibcpupower.i'
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>   tools/power/cpupower/bindings/python/.gitignore | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/bindings/python/.gitignore b/tools/power/cpupower/bindings/python/.gitignore
> index 5c9a1f0212dd..51cbb8799c44 100644
> --- a/tools/power/cpupower/bindings/python/.gitignore
> +++ b/tools/power/cpupower/bindings/python/.gitignore
> @@ -1,8 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>   __pycache__/
>   raw_pylibcpupower_wrap.c
>   *.o
>   *.so
>   *.py
>   !test_raw_pylibcpupower.py
> -# git keeps ignoring this file, use git add -f raw_libcpupower.i
> -!raw_pylibcpupower.i

thanks,
-- Shuah

