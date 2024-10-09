Return-Path: <linux-kernel+bounces-357865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85899771E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99FD2B23ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0631E1A17;
	Wed,  9 Oct 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISxUQcYx"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88041A3BDE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507623; cv=none; b=jobC+UiJE+Z3OkC245Ps+T9eY3ijlGH+yc6aU6Ayrp0WHxLsZQeHKTmuNJqEWHeqeKq4bKguSxtFE5spr0RhuvBDJo8jj1IrDFZQyx6gx0iPwJZzITSERy0R14+Ly6frqVTta3lixrcNvyZv8MnFsAjbgWwmi1lmEPyF7byGsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507623; c=relaxed/simple;
	bh=quI890ksGiqXNH1rYbAaqlJeRI1+XEwtVJa9OjJDJkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FywKVzWE8dRc8ijsZgoRpTeUzCUSZBw/Akwsr+KThy84WguN0AhW4gxo5LchlprKIFtVyj99AGMhJc04ZN/M1OVUU120HYkOYg7BaeYrP3f08H75T9IszrGtbYk1Ert8YXuwnwlcYF2XNkkTIFWeubcc6LWrNkILkRVFMtA3Vm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISxUQcYx; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cd872755dso8815739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728507620; x=1729112420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zINN3iZzRZJ0xbXZuWjulTszejXrwevNaI0bh4OztJc=;
        b=ISxUQcYxRwbZhsROwz1wOAE2MiEtoEurGiwRgtX8YUMQ1PPPYXEeOHyYJOrxQDXqvK
         EGEwdPTSO+ygVvvC5i3dmYLvo/cbvxV6tnm/UrEP2NHKOEFJktpVWi13p7HzcBfvVTnZ
         a1Vm+zm6pXFrXTcyGB9dPwiugq1CPIGo05Ny4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507620; x=1729112420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zINN3iZzRZJ0xbXZuWjulTszejXrwevNaI0bh4OztJc=;
        b=VeVVtGq5ERcw+TXzf8m40LuUrhZHN87Z2RK4fliJ/ocqF0cdcwy74yFXHohjYh3TDE
         QVfXcstLLEjGDqZUrwvsFGYATVzJRnfGEyJS31s27Mamf+zdP470MU2M7fKRiFdkWyP+
         fWWe06sX9+Co9VkYLk63xPZSPyTxgALEQsWdwFD5UmMUiFRykcmJEV2dJgBeCzv7aaWa
         UcpHzKuzw5N1mpxIz2CD6sa+rF01Nh0xCyj2GCh/t0m3qZ1Bz4Prz4DNv876eUVdUIg4
         faJM5U0lSfOgk6XBK8EpheELoT0TbQM3d+FvgjgVJN1EyAKWcwvplB6UOva3Ch8wCXAe
         gTRA==
X-Forwarded-Encrypted: i=1; AJvYcCUSy4b3BotHQMiKOlu17+bqIjRTi1UfO6LOKWC+uaubFdKvX9EbzGWKnWXnHCcHjpd3slORtxtuVfiS4SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TWgO9GvSvDn8fT2YpWKb+nhKVaqfO7EmQZSBnDFQXDJBsz3t
	4gLE/B/2cBYrsJaFKmZ+hWdlG8qdyvCcTJSy9s//gHQr+4eqpdZxaq8PtC3iDZc=
X-Google-Smtp-Source: AGHT+IGyYNs3bWMLM3gU5TNi7rwVu+BFafc9sxHpnqCuT6rRhpD+QYd3VTN5oSNO5tc0NONkLuNd8Q==
X-Received: by 2002:a05:6602:13d3:b0:82a:a403:f0df with SMTP id ca18e2360f4ac-83547b4fd10mr135930839f.2.1728507620573;
        Wed, 09 Oct 2024 14:00:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0da0sm2164978173.110.2024.10.09.14.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 14:00:20 -0700 (PDT)
Message-ID: <2dda047a-199f-406d-9998-fa85939e8106@linuxfoundation.org>
Date: Wed, 9 Oct 2024 15:00:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kunit-next tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Brendan Higgins <brendanhiggins@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Gow <davidgow@google.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>
References: <20241009162719.0adaea37@canb.auug.org.au>
 <b005d39f-2b75-4a26-a78c-5cd8f7076399@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b005d39f-2b75-4a26-a78c-5cd8f7076399@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/24 10:28, Shuah Khan wrote:
> On 10/8/24 23:27, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>
>>    lib/Kconfig.debug
>>
>> between commit:
>>
>>    0f2016a962f0 ("lib/Kconfig.debug: move int_pow test option to runtime testing section")
>>
>> from the mm-nonmm-unstable branch of the mm tree and commit:
>>
>>    f099bda563dd ("lib: math: Move kunit tests into tests/ subdir")
>>
>> from the kunit-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
> 
> Andrew,
> Another one related to move from lib/ lib/tests/
> 
> If you would like to take these patches - it is perfectly
> fine with me. If not I can handle these.

Andrew,

I dropped this one from linux-kselftest kunit branch.
The link to this patch if it isn't in your Inbox:

https://lore.kernel.org/all/20240924032200.167622-1-luis.hernandez093@gmail.com/
> 
> Adding David as well for feedback on this

David, I think lib/ kunit patches can go through Andrew's tree.
Renaming is causing merge conflicts.

thanks,
-- Shuah


