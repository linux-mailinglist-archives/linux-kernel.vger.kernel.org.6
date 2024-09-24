Return-Path: <linux-kernel+bounces-337586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331D984C14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44301284DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABA12D773;
	Tue, 24 Sep 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJ3YEeJJ"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C817993
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209122; cv=none; b=DBnx3XbAcPN2L8p/gDM4PQsuic7vrD8B0jNBfhEqrapJY8T84LR38Fzhvi1yKnWdc+qo0w23+hwHnRpfMq7FQuSfD/P67bIAmOhQk65oNkn4D8w41werilddEaWFO18XGqlxiOew5vRjY8g4nVNdwuIU/RxGxPb9pmiJPcNtu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209122; c=relaxed/simple;
	bh=SrBgLPRQ82YyZxvtZv6GaCCzeMBnTPqRnOZXP8HZACM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZgBmbu8wXjMgwkUnmdMCCmVzLGe48piXGuPULH1L09btq+ReZL46KYlRiX8tePxWhod+AJBfvS4Ag2W7ktnyJKpJbkvTQ55UnfLiATkgsGqyDZEvrr/hpHDqaASpImGMcliPzwd5stDaldWAZKqldZiBvz4VfqZcfTpyE+22eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJ3YEeJJ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82aad6c83ecso230965739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727209120; x=1727813920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8btDET7b+EX5EDpFmZ3uK2hIiue2KrZCo2z4LaICAFk=;
        b=LJ3YEeJJ7IW1/XbZlmlyQrx/pZOKpNSGjsDe38mHvgxdWZ6iqdqABt3nYpSHsQLLyg
         931yJIJ13Hx+wRHmf653Kn2oStqeQqsY9c8lcw5VreiT/pKMXKpouZHBf7VWUgnkqheE
         7HCJs15tN6ZPnb47kHnrn13KiyBQ8QH+Iuxk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209120; x=1727813920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8btDET7b+EX5EDpFmZ3uK2hIiue2KrZCo2z4LaICAFk=;
        b=YUzXHAf0UuQ8kvmv2sFDY4Dx01wmdd0EykGP47XA/8b1y4oB1XLNhd/0nx5yfil7Hm
         FBaJQNPkILIRzqP+HGwduqMkjqIEPSJH6PhEdDIh5iVjDL7TnA4xu483iV4+Ex545CrE
         CjxGxAuN7/Lil+W8BiqOApiDOVtburxcKVDp4HIJAthu2vZF6rBZ7y32cCW2ON83cl7F
         txRUwR2+xm9Ltlo49QH6e1m9XtcSEi9neBcHeuo0fO4+5eGgMAqSr0n/irESXUJiFThW
         Z2NnovvHsCpVWkJap+fxVWuO1/kK5NAcmuadsDSiP/rPXpLvJxUEYXcNO1IY6O436sdz
         CzRw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNUwKk6fGkN1EvScB1MZHISP1UzdNEgsi9VneCo2vHuVUxfzuNJhT8M/ktwsvmEeNOy7pRRe4H5wFJ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxstd1AKQuslXEsUhM5fciYAsTNwXb1kTd/mGE9kdYtbIhVtJOj
	1/P3Ba9LcxkkOTCRpEHnZ0F2H6jt55SyxpTRJnCCH7Fmlhj3nzMbJNXLlPLBRyM=
X-Google-Smtp-Source: AGHT+IF5VKt88HSQv+0zYUV7HXMLh2V4BwNMioy9FgvhZ2Nu/M//OjS8nhpHihv1YreE6Ub3f1MlzA==
X-Received: by 2002:a05:6602:1691:b0:82a:a8af:626f with SMTP id ca18e2360f4ac-83247cfb73fmr91382639f.2.1727209119675;
        Tue, 24 Sep 2024 13:18:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f2fa302sm598552173.155.2024.09.24.13.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 13:18:39 -0700 (PDT)
Message-ID: <122176aa-4948-4e90-88d7-1fc77f4156e1@linuxfoundation.org>
Date: Tue, 24 Sep 2024 14:18:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] [GIT PULL] cpupower fixes for Linux 6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
 <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 14:01, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 13:19, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Please send this up to Linus if at all possible before the merge
>> window closes.
> 
> Bah, I took it directly, since it was in my mailbox and was lit up
> like a christmas tree because it triggered my git pull search
> criteria.
> 
>                       Linus

Your git pull search criteria got some workout looks like. :)

Is it all good after the lighting up or should it go through
the normal channels through the pm tree?

thanks,
-- Shuah



