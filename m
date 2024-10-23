Return-Path: <linux-kernel+bounces-377218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBAF9ABB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D79B22CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F377B2D047;
	Wed, 23 Oct 2024 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U89Esz8j"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F8381BA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650274; cv=none; b=nF6eQWK8RorYGb2FOkrVLJPAYr1wQCinlCd351CzKcR4a9ijabH9fpkP5+uvpEaCVMQjRG9lTlQ3vvVbYQh25sd8tpvo4GIWTPDjqPIe/IBAFmo1b5wO4KbiEQxo7yxnpmqy+cLduMaq5BEbtJFdgWjXvV1rCxZ+61cW0goKySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650274; c=relaxed/simple;
	bh=ZwzRq8DU40AU6YTVw/wm3MFqVO9e6+tJzixeQ96ZuDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrVBaJuljBnj47eqloUdysJP85YUUsEp32Jg0aTw3cAW4BZZVvE8CeGUH0BWQhy57d3afLaj/x16KJuf0Dy9lnLN9U/C6aRQ7TNwJZioYkJ9PWEYyoRvGAh2gl+e2BYmMTEL5b2DHkGP9eyguS3xFAOus8f8CYKV7/KeFn6XGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U89Esz8j; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso4489430a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650272; x=1730255072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qUE+EwGRVRenwbJByPFzBpBmvOXt8zZGJpxmg1tpEdk=;
        b=U89Esz8jg5SFl5wodTcQ8LrjRXVLLhRQtfrGTVICRiRh4t61wTY00FJ5IN9nEi0B44
         aX/p0FcHgIRJM2KpYKJkw8d8Sr9wN+jqolTUe0MKfYDin9X3UFudq1m6JXTQu86JP6Xg
         q+RMx0eFqQypQDY2W/7i5HJ/J7eccfZehzqR3PdBWK9TlGUw7D1KxuWrfM1f/ojYN6HV
         Y7oAd+umLoX5shZUEA0/3zX8hluc3EfKqraKeMaMJwDsd5TzW8PpoyIWxCAQA0ok2CRy
         GPMisiWOUKsTZW2mF4LvUhGHHCDAIxxVbQ2xp2b4B6NSDMWptUZ7DCU3iG6Td3jTxkLZ
         TF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650272; x=1730255072;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUE+EwGRVRenwbJByPFzBpBmvOXt8zZGJpxmg1tpEdk=;
        b=aibWU24GHXbd40bldc18PCPe4WM5Jj5ZT6SJ3Q+DmotJ6AVCtRbvz/jeyIZXn8i9O2
         BzoPXuRVRvFLBOGt+UqxJpFdQrOBxxwC5y++kL4BhgcGKqrJPbWIdnnKjvAsV9jUuERR
         PCA+pYVgaXX3UQrkla05l8Jpgwfnxz9Lwpslcx/5qebnEH6awmUqehcfS/fIHq21k/z8
         NNwYXpwsh1UCAjq8MIBy/7R4W80DfdcAA3dRrE528seI/ajLJlYBRoR9D4V3iOUwgOSi
         AmAEESOSFYe1qHruCj2TtvHkrOVf/XBUhkc5WqjCWeQvv3LyAW3imtwOOuROO1KvIqfS
         ErdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvDwzwlHdtAz7x1FWRAJqppOewQwDxiQ5Ssog+nKNi9hNVeIecrJjftvfq6x6pXtPPo8j4dYFF+FCcZQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3c/6M4fME078pNWT77AAsuX9hIEcGeAlDdGtbHh/VGBJqOt12
	cPFbNpIRuoBlNCXVS3y6bcIlwYFFFax0RHxy4PCL9X17z5xJI6en
X-Google-Smtp-Source: AGHT+IGk3wjKCQ/DYXfaKL9xVY97WrdfPLEeK7mrL7cczDyz9DDn6Eub/NVhhnVVnoCqIL8ClJVXew==
X-Received: by 2002:a05:6a21:710a:b0:1d9:1c1e:238d with SMTP id adf61e73a8af0-1d978b1cfb5mr1335523637.17.1729650272014;
        Tue, 22 Oct 2024 19:24:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfbfeaesm196882a91.47.2024.10.22.19.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 19:24:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2a2f4de7-ee32-4a71-b470-cf155e1097ee@roeck-us.net>
Date: Tue, 22 Oct 2024 19:24:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <202410221231.55C03584@keescook>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <202410221231.55C03584@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/24 12:33, Kees Cook wrote:
> On Tue, Oct 22, 2024 at 04:12:43AM -0400, Steven Rostedt wrote:
>> On Mon, 21 Oct 2024 23:48:34 -0700
>> Christoph Hellwig <hch@infradead.org> wrote:
>>
>>>> How about this, instead: no one sends -rc1 PRs to Linus that didn't go
>>>> through -next. Just have a bot that replies to all PRs with a health
>>>> check, and Linus can pull it if he thinks it looks good.
>>>
>>> Not just -rc1, otherwise agreed.
>>
>> You mean have everything go into linux-next before going to Linus after -rc1?
> 
> It seems like the most useful signal would be for the initial PR for the
> merge window. After that it becomes a lot of fixes that didn't get tons
> of soak time in -next, etc.
> 

FWIW, there is also the pending-fixes sub-branch of linux-next, but from my
experience the build and test failures observed in it are pretty much
ignored, just like the build and test failures in linux-next itself.

Guenter


