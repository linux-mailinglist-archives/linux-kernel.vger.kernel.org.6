Return-Path: <linux-kernel+bounces-379197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB09ADB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBC528183A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1DE1741E8;
	Thu, 24 Oct 2024 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu3EZcnp"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71615171E73
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746996; cv=none; b=VwgCLyhfzFK1mOebDP2ETaXBgu5zlZS+hykSB4ciMdzMXq7W2rDP3JkYKm76csbnVxTQ/mlzbn0KQn7OdP2eDpFxmGgZM43FB1XOeb+VDJmPpEj7F5syEiZWINtqsZn63D/W9WE68pg6L2edQOcYjGHHCgB4wBW1t3S5AmnTXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746996; c=relaxed/simple;
	bh=guo4gG8zzQbso7DG29WLf8GmQIz+TMhoFasiPtggq9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+QV0OWIaxXX+MeB6BWwfWdVpNWZc+Wuu+atbTVXE9MLXVLoSW/36DVNQ8ME0nXJqvxLm3YgoVAjIffwrIKvJjxcwitYWa9Hrun09OdEy87XsFMWZTW8a8011m5FiDQCDNaEIOeOgYlQkEUhqL37lXZb6B71nm78cu9jQGmr/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu3EZcnp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e31af47681so432104a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729746994; x=1730351794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wlWv+xw7f9omZ+7yPyeQk0RsJVXCNGM70USTVV24Wa0=;
        b=iu3EZcnp5nsshHPQWatKpjnWixKotyKq81Mr7S+ucNEqEYeQMrZUT2B4BF8jcqZ6dW
         hplkRyuukJaEgeuUJnX7T00UZVa0e59CiNM3Bcsm6KQ3Kenj9ZsDkVCXLZn6q+FJ+AmC
         8WsFDXrH7+oUM1GaYgv/VX0+IIOxdR6oZq9spb/nO9BmlT9usBebiwMHbCYg850knoDs
         AB7c4VzKsO7Pl2x/PnNP5VzK383SO9mfmwpUM87ONNW8sBPVtsApJD7jZ7UOD1Gnss4K
         0FSnEdCV1cHCCMJNj4gU4kF0RkbvYOOKdrTeq+4OiC9vX7qvdW34JnrJwHriQm/uLgit
         s+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729746994; x=1730351794;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlWv+xw7f9omZ+7yPyeQk0RsJVXCNGM70USTVV24Wa0=;
        b=UAOXxUpneDInBR7Qc4SkmIlOAP6RAvkmkF0O/4rDA+vSJ57TlOxlpIC7GFTRbIumHy
         50NMM5sxlid5RAJg7Hq9hgbswF+05U4FPMjj3JgV9YV5kbm5vi5mx9UuW29q5IDwdZoM
         4F6cMbI/rwe45nir3Eatf+m8S7G/TTjszPYumtsVBS//0yDHjyvn4fvqlxIf0pOD62OF
         8d/zw4JHmoHnUiH1BclPHuEFLdbFOahu+RsjkqEbns53VyFaGM86apqp/5ax40tfdFfe
         hR4Eaw/Psxb341v9tJmObskxuuiqf6L/E8aCDhPXEoCxzLZnCXaKLNs7MKxBuAKs8s2F
         d7Og==
X-Forwarded-Encrypted: i=1; AJvYcCWfNb1E1Zby1vOEy971P21OHM992QJKslxcR+FUCrmojLLZOYsIF3hLuAw08311glE3wKb4VNNA5NbE9T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyWW80OPg7ZFrmEMykMiN4U0Ro1VxuDjUzQzbgDSaiFiddeNG
	E4nD52G/XqEXLKc2wCJhQjqKrBUgmE7hQLNfTp6mT/ihaHVFYMK6
X-Google-Smtp-Source: AGHT+IFSVRvkUZphGQpvdUOUJ3K9oD/IJMkSsot5xy862OfndVanuFo+YvBW/+1vOfmn3gcbDczTzA==
X-Received: by 2002:a17:90b:17c5:b0:2e2:cfef:86 with SMTP id 98e67ed59e1d1-2e76b5b6773mr5178515a91.4.1729746993743;
        Wed, 23 Oct 2024 22:16:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df7ae90sm2472999a91.35.2024.10.23.22.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 22:16:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
Date: Wed, 23 Oct 2024 22:16:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
 Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home> <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241024010103.238ef40b@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 22:01, Steven Rostedt wrote:
> On Thu, 24 Oct 2024 14:59:16 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
>>> But pushing to linux-next for a day or two, what does that give me?
>>
>> Several thousand build tests, across pretty much every architecture.
>>
>> And a few hundred boot tests, lots virtualised, but some on real HW.
>>
>> A single character typo in an #ifdef your testing doesn't cover can
>> break the build for lots of people ...
> 
> I use to get that from the zero-day bot from intel. Does that not run
> anymore? I noticed that I don't get notifications anymore.
> 

I do get notifications, so it is still running.
Its configuration is (still) at https://github.com/intel/lkp-tests.git,
so you can check yourself if your current repositories and branches are
listed (and send a pull request to update it if needed). I see

repo/linux/rostedt-kconfig:owner: Steven Rostedt <rostedt@goodmis.org>
repo/linux/rostedt-ktest:owner: Steven Rostedt <rostedt@goodmis.org>
repo/linux/rostedt-trace:owner: Steven Rostedt <rostedt@goodmis.org>

so at least some testing should still happen. I did notice though
that "notify_build_success_branch:" is only set in one of the files,
so you might not get notified if a build was successful in the other
two.

Guenter


