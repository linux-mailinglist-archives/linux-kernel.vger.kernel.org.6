Return-Path: <linux-kernel+bounces-187319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C38CD025
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EA41F2306D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C413D286;
	Thu, 23 May 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HOdN/oWc"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD213B2AD
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459563; cv=none; b=JBkYBCBw+0PiTYEs6QmXzCVpzi7MHv/SpCzYzitylMQ2azSHZnhAfaN8U4nv8xTXJ228Ref4x2/yee/UBVKvkqfuHbSLXU/kqnlSD0hJXIpae/cD4Ae0lnaNrERpwhCWcirUzo6+T0f7Ch9ji7+JjLcMlDgAUWCIIH/uFrHjPKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459563; c=relaxed/simple;
	bh=SyFN9Uv+C28YdrBnkTzFLWT5CT91OyrdgYUPteYPkY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp4ZScIj58a1OXxDkC401idj9hWSTSE1s7S+8eRw8xP3te3LhF4dvk76fzhT2t0I/oV1Cli+zArhX5kHLW1TZWluZhRJ1YNRJ1WIGxflH9zUXA6tPefk5QqUiyusM3xTJ692l8DMX6C8UxbrsI8LphJORTup2jkKhZctjfEXiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HOdN/oWc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599a298990so1163502266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716459558; x=1717064358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ya7jFgACQ3+qVtk5Zmht58CiHygIAj42TtWKWPY5ihY=;
        b=HOdN/oWcss9F7Yx+ItA7qcSmBpV0bNsGP8DG/5i7u0GkeczwRoguYyx+Y4XI8G0Ir0
         E9KwhUVRM3HRu8BOWp6Y3Gf9bfxkppmFgE0AUjMWH10BRGw5fpanx7ZUEjWFNEiOtaEG
         1f98ZjZ866/RY3YMPkOdyXmH/5OhszehRP9fsb6d3TEdO+ua+gsKKBIasdFTx+UyWgjB
         bMbB4lh3emViT57Pgh3xyjV9tN6WpmBI4nB6/0Aol0S07JsCQ5AxXcwZKLMZBY0q5ISd
         JNoIF65rX7ZhSAXtQHYDTCltjcn7uru5y+JgaihflP8VLXgzxIZo9bJ8IFVbY6gUI8PQ
         OIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716459558; x=1717064358;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya7jFgACQ3+qVtk5Zmht58CiHygIAj42TtWKWPY5ihY=;
        b=IABZV02EygcFyTCSpNGxeaf7Ud7NnudzCQd09jnzV41+pl863RIMXpJEvAh6N4E0ut
         XGP0eaApjsy2IE82VY29FdMAFvvTY+TgoJExa0fKcaUXP1YTuj52lIGDgHPsCEasGOd7
         PC//juW+qS909QVdjFVqftmTUt9jIg27/FNHh9pafy5w5sKC6KJ6+W8pd/SuUT9NQFwu
         FUsk4ul+a68dowz+un200GVZWzJTHB1c76Yg0XEXn+dlJ8EoM9MvGXV4QiyB9qqaqvW0
         Cd115qmNWoxomMm76GA3XUEAoPEk8XrhxIC2o/7F93Szh/AIDej7LeaeNqaMdCZWNwrs
         7Ikg==
X-Forwarded-Encrypted: i=1; AJvYcCVQfrmhHeEf7KN+6VSAEcPhT9Wj0G0vlmWK4qD0ce+OBMyHcdHaEjSr973L3tKV+UVpzIET3ZgdjWT2Ke4JdqkQ95oLIYhOFu1pT91P
X-Gm-Message-State: AOJu0YxrN/0Fc58NUwvxswXGkNzdamug+oCgkkRZP8MawO7XPOP1sfpL
	c81NvnLKH+04YZ9uKjngC1BEVdg26RmcXJv6MCXUYVAWSzuV1IJvKcUFDPkQzvw=
X-Google-Smtp-Source: AGHT+IEZUSS//JGhCO8/n0ldR4VPZcty6z1l+JqM5UA5JTuohmXM4Ykzh+fy7MTqZ23PIONjiONV2w==
X-Received: by 2002:a17:907:6016:b0:a59:af54:1651 with SMTP id a640c23a62f3a-a62281646d9mr257236466b.57.1716459558413;
        Thu, 23 May 2024 03:19:18 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:e681:bab5:4646:cf21? ([2a10:bac0:b000:7315:e681:bab5:4646:cf21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm1184681066b.85.2024.05.23.03.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 03:19:18 -0700 (PDT)
Message-ID: <06570587-dc49-4885-83da-7a386f012106@suse.com>
Date: Thu, 23 May 2024 13:19:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2021-47326: x86/signal: Detect and prevent an alternate
 signal stack overflow
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024052133-CVE-2021-47326-fd53@gregkh>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <2024052133-CVE-2021-47326-fd53@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21.05.24 г. 17:36 ч., Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> x86/signal: Detect and prevent an alternate signal stack overflow
> 
> The kernel pushes context on to the userspace stack to prepare for the
> user's signal handler. When the user has supplied an alternate signal
> stack, via sigaltstack(2), it is easy for the kernel to verify that the
> stack size is sufficient for the current hardware context.
> 
> Check if writing the hardware context to the alternate stack will exceed
> it's size. If yes, then instead of corrupting user-data and proceeding with
> the original signal handler, an immediate SIGSEGV signal is delivered.
> 
> Refactor the stack pointer check code from on_sig_stack() and use the new
> helper.
> 
> While the kernel allows new source code to discover and use a sufficient
> alternate signal stack size, this check is still necessary to protect
> binaries with insufficient alternate signal stack size from data
> corruption.
> 
> The Linux kernel CVE team has assigned CVE-2021-47326 to this issue.


I'd like to dispute this CVE. Basically a process can pass in a 
wrongly-sized stack which will cause its own stack to be corrupted. If 
anything this affects the process rather than the kernel.

> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 3.15 with commit c2bc11f10a39 and fixed in 5.4.134 with commit 00fcd8f33e9b
> 	Issue introduced in 3.15 with commit c2bc11f10a39 and fixed in 5.10.52 with commit 74569cb9ed7b
> 	Issue introduced in 3.15 with commit c2bc11f10a39 and fixed in 5.12.19 with commit 74d6fcea1d89
> 	Issue introduced in 3.15 with commit c2bc11f10a39 and fixed in 5.13.4 with commit afb04d0b5543
> 	Issue introduced in 3.15 with commit c2bc11f10a39 and fixed in 5.14 with commit 2beb4a53fc3f
> 	Issue introduced in 3.14.3 with commit 5bc3ab30db9b
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2021-47326
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	arch/x86/kernel/signal.c
> 	include/linux/sched/signal.h
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/00fcd8f33e9b9f57115c3b1cfc4cb96450c18796
> 	https://git.kernel.org/stable/c/74569cb9ed7bc60e395927f55d3dc3be143a0164
> 	https://git.kernel.org/stable/c/74d6fcea1d896800e60f1c675137efebd1a6c9a6
> 	https://git.kernel.org/stable/c/afb04d0b5543a5bf8e157b9119fbfc52606f4c11
> 	https://git.kernel.org/stable/c/2beb4a53fc3f1081cedc1c1a198c7f56cc4fc60c

