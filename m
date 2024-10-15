Return-Path: <linux-kernel+bounces-366172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044999F197
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D741F2870F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711B1B3945;
	Tue, 15 Oct 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aTxNGW9U"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F63BBF6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006698; cv=none; b=lWI+ETAayfxfogEkAaKPCtVHcSvgzN2KD/cDbqoPM6Tgt/bzRTWGQoSKmIHXknJ9J5lzE94uSAqQy6z8d+B2YgdZbY6SGeTXxApeR/CPDgKaCxctRkqaQprqra7uPUDPHlfJWmo0T/4dGDk5bAbklDE1yrReOxX0HXKehPdMytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006698; c=relaxed/simple;
	bh=9IkhJfc5QpSe5Ycfce/KQFACj9NqrvLWWWTPi1poHG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neowmhh0fUHdrkB7fgBSxYMEBGSUWn8652zCNQXHkwxci27xNgeB0SxoVH/YcisJ/iE07kfk6BltzBlKajNDoxgUkVmVT28vlbxtKcuW6E93AsqJGGi+wmMdv/WG73WO/5ev3CUPl5tyzRSDe+1GyGbYNpaOKOeqmV5P/5PKmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aTxNGW9U; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b3f4a48bso15161245ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729006695; x=1729611495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O06eHSDldhgqjot2xYme05dEKvAtgQt5byRk6hWnnBA=;
        b=aTxNGW9UZGUjWwuZH9x2wnax0VhH5t6NGU+ns5fa9AYeGV4Kd0r5grLj8feowJnLeV
         UKvxgiX06vqwuzTshJA2uxonczI9saqF6vlqLjtpxOkH9iPXZQd+C6unUmKRBoE/Bdkj
         jScoeFd+6yZ0ovhcUTqUh8OOvQHk205I+zqao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006695; x=1729611495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O06eHSDldhgqjot2xYme05dEKvAtgQt5byRk6hWnnBA=;
        b=ioteXqbm1b8lGcSZcmpWI85vjVma2oUlRKDzicuVbdF/u7nRtSXyafA7X1vNFfEnca
         LHrvpqMDdVyaIjaMS1HZdJ9g2P1R9oQz2z8zDkpApKXB9UijYW7XXYYVK8gm5SMGvmZB
         7w0bFxxR01mZN5xQvAj5/X2c52lUAZR1yFfseuLP38tjINW21W/4do0fM6wHeg49RkAz
         KMM2aQy7Rha2fjneRdI6s+NDmzysKZayXVZWbTjubaDP5kNj0qakA7NA8W6axSIy+RLt
         Fo1cry4Ciupq6R8XqX3qzBBKfZZRNvim63tmCFyj7I7IBjUJZnmFCxvv6dnkHTQex9cv
         EZVw==
X-Gm-Message-State: AOJu0YzhBQXqU+gsH/n/psZqUlBiN4Cz6VBwBsouEMDMYXQC3si3TOMo
	YOZCilH3tThKbYnIy2NJEIVNc5UQ7q4RaJcQyfyXhrIsrqPhb9Kx+m7sdl09r1MKDGnpDcVsJ+A
	Z
X-Google-Smtp-Source: AGHT+IErPoDY07cdU2Id448bxhTqRWglwEIUN25E7c/G0ifwlsCN+ejFyw+wLlbVN7TXikNgqGav6g==
X-Received: by 2002:a05:6e02:1389:b0:3a2:6d54:33df with SMTP id e9e14a558f8ab-3a3dbe7bcc1mr7401335ab.4.1729006695432;
        Tue, 15 Oct 2024 08:38:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec963450sm362850173.12.2024.10.15.08.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:38:14 -0700 (PDT)
Message-ID: <087279ce-7fd0-49f3-b578-2d1b82852e3d@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:38:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: Add a few missing gitignore files
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015010817.453539-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 19:08, Li Zhijian wrote:
> Binary files should be added to .gitignore
> 
> 'git status' complains:
> Untracked files:
> (use "git add <file>..." to include in what will be committed)
>       alsa/global-timer
>       alsa/utimer-test
>       filesystems/statmount/statmount_test_ns
>       mm/hugetlb_dio
>       mm/pkey_sighandler_tests_32
>       mm/pkey_sighandler_tests_64
>       net/netfilter/conntrack_reverse_clash
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/alsa/.gitignore                  | 2 ++
>   tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
>   tools/testing/selftests/mm/.gitignore                    | 2 ++
>   tools/testing/selftests/net/netfilter/.gitignore         | 1 +

You are sending 3 patches without a cover letter and you are missing
key people who should review the patches.

Combining several subsystem changes in one patch leads to merge
conflicts.

Run get_maintainers to see who all the patch should be sent.

>   4 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
> index 12dc3fcd3456..1407fd24a97b 100644
> --- a/tools/testing/selftests/alsa/.gitignore
> +++ b/tools/testing/selftests/alsa/.gitignore
> @@ -1,3 +1,5 @@
>   mixer-test
>   pcm-test
>   test-pcmtest-driver
> +global-timer
> +utimer-test
> diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
> index 82a4846cbc4b..66a21f289453 100644
> --- a/tools/testing/selftests/filesystems/statmount/.gitignore
> +++ b/tools/testing/selftests/filesystems/statmount/.gitignore
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   /*_test
> +statmount_test_ns
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index da030b43e43b..2ac11b7fcb26 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -51,3 +51,5 @@ hugetlb_madv_vs_map
>   mseal_test
>   seal_elf
>   droppable
> +hugetlb_dio
> +pkey_sighandler_tests*
> diff --git a/tools/testing/selftests/net/netfilter/.gitignore b/tools/testing/selftests/net/netfilter/.gitignore
> index 0a64d6d0e29a..eef8d5784e94 100644
> --- a/tools/testing/selftests/net/netfilter/.gitignore
> +++ b/tools/testing/selftests/net/netfilter/.gitignore
> @@ -4,3 +4,4 @@ connect_close
>   conntrack_dump_flush
>   sctp_collision
>   nf_queue
> +conntrack_reverse_clash

thanks,
-- Shuah

