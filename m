Return-Path: <linux-kernel+bounces-199346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA57F8D85D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC93D1C20BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B71304A2;
	Mon,  3 Jun 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7Z4wSA+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357072566
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427632; cv=none; b=F2+dF0TPeUXSho5jEcHC4ZSxphmC2va0CroMGB6GAJ1sXHTOk705wfj5nxLArGqlAJSd8TgWGcQt2LJY1aclmxv5JRZUA/of7YQT117vEZPNjdiiYgH5p83x2OJwe+m7EjZcTxN/WVDPfJxM7nXS60T016iZ9sael/olVori60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427632; c=relaxed/simple;
	bh=k13MWYRn4rywxvrD+TS2aLB+mXifXkz0yc8cNBRMw8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcM3qYTpr1WvXJ/NODQk20cFYut4M9451LZqDnMir2SDMyl1mksgEUHnQJEHb0DmuKXOBcDywzg3RjF8ViXLgK6cMSdr13POkRNzMy/UEIL4q+IKn/j7HJtdY83UhZAGyK+6QQBuecM9yAxWr0F2fomOVSBAaOWk8cmmfIrZemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7Z4wSA+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717427630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RGr3OiNByqA746VAB7r+MtAa90GReZ3yy6ZqYyS84Y=;
	b=c7Z4wSA+uWQ/EZ6OcUEOiRQldxl6GBiRCtaavi7x8YSycAUxlKEdo9yKq31EG330SGItJj
	1BKqZAaz5B+8goSql52Ike1yrc5prdMnq3DfEaUIaKer8wcCNk+GvzqRfSskaDh/KxAzEt
	GtXtOxuawrt0J0D3hE+tJeW5LRE+z2w=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-IQCXvlFfOrO7tz8TjZn13g-1; Mon, 03 Jun 2024 11:13:49 -0400
X-MC-Unique: IQCXvlFfOrO7tz8TjZn13g-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb1d659c76so130038239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717427627; x=1718032427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RGr3OiNByqA746VAB7r+MtAa90GReZ3yy6ZqYyS84Y=;
        b=oN8EehxVk2WuTa/EFVrOp9w9xrfjpNxTKKbFQz8+opNZKlko/R1/lbnLhCgZtbOEgU
         +Fx27FYOYKAThg5p8GkMz88ndk/S+PuO1Ci8agVSHx/IQTMP4b+ldCfz4yU7GuhrGvQw
         ln6M9HHTlLzfd2JlDJ1xvihJPzR0Ysk2ytI460Vzm0U6cr19mayYRTtJNaUIZzaTVvUl
         6fzfaY9XA4m1a3Wp9CjozEWXNksuUv9opG6oQpNZvX8Kni2JntbsX5usWcXJEM8YGeKH
         O9C5iC+fB7C/UYLkB+gg5yaTBRQ66ImdDf5xBekEc+UcI3OP3uGjNwtvDzBM4WGGWrV/
         56Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW/FQxtBznNbZ42/aMaa+DZ4wth429H78DuGmhGCmhNfrhE3f9w8kPeK1u7oSUKAcrsDldaRfzlhtTQdR801RIwl0LYB9Z4/vf45WND
X-Gm-Message-State: AOJu0YyC26cpIDU0ZIAL3Wj2/0ooWg8w9lrae7R1XqgL6WirJqf2kjKx
	q2ouwC7TsWY/nb+xcXa02NNyr11WcU8YFyo8CcK6koajMw3q8CzCt32ROOhjKm52tetPT9aMREg
	4P0AYbQ/LbTxSDsKu5qDA7aDoH/7UyTNNTZL23Qua02ZCb2alzdEn2eKkBh5bYQ==
X-Received: by 2002:a05:6602:27c1:b0:7e1:b3fa:6470 with SMTP id ca18e2360f4ac-7eafff254edmr1168242139f.19.1717427626382;
        Mon, 03 Jun 2024 08:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBxDvtFv5AIBCKC8eC8LS4yo/KVyqHTSZm/yVbm26pabAXTp4n+GMy/7B6FT6aNuqxToGQDA==
X-Received: by 2002:a05:6602:27c1:b0:7e1:b3fa:6470 with SMTP id ca18e2360f4ac-7eafff254edmr1168233839f.19.1717427624919;
        Mon, 03 Jun 2024 08:13:44 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b5fafbb3aesm44683173.19.2024.06.03.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 08:13:44 -0700 (PDT)
Message-ID: <934aaad0-4c41-43d4-9ba2-bd15513b9527@redhat.com>
Date: Mon, 3 Jun 2024 10:13:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
To: Christian Brauner <brauner@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Howells
 <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
 <20240527-pittoresk-kneipen-652000baed56@brauner>
 <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>
 <20240603-holzschnitt-abwaschen-2f5261637ca8@brauner>
 <7e8f8a6c-0f8e-4237-9048-a504c8174363@redhat.com>
 <20240603-turnen-wagen-685f86730633@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240603-turnen-wagen-685f86730633@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 9:33 AM, Christian Brauner wrote:
> On Mon, Jun 03, 2024 at 09:17:10AM -0500, Eric Sandeen wrote:
>> On 6/3/24 8:31 AM, Christian Brauner wrote:
>>> On Mon, Jun 03, 2024 at 09:24:50AM +0200, Wolfram Sang wrote:
>>>>
>>>>>>> Does that fix it for you?
>>>>>>
>>>>>> Yes, it does, thank you.
>>>>>>
>>>>>> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>>>
>>>>> Thanks, applied. Should be fixed by end of the week.
>>>>
>>>> It is in -next but not in rc2. rc3 then?
>>>
>>> Yes, it wasn't ready when I sent the fixes for -rc2 as I just put it in
>>> that day.
>>>
>>
>> See my other reply, are you sure we should make this change? From a
>> "keep the old behavior" POV maybe so, but this looks to me like a
>> bug in busybox, passing fstab hint "options" like "auto" as actual mount
>> options being the root cause of the problem. debugfs isn't uniquely
>> affected by this behavior.
>>
>> I'm not dead set against the change, just wanted to point this out.
> 
> Hm, it seems I forgot your other mail, sorry.

No worries!

> So the issue is that we're breaking existing userspace and it doesn't
> seem like a situation where we can just ignore broken userspace. If
> busybox has been doing that for a long time we might just have to
> accommodate their brokenness. Thoughts?

Yep, I can totally see that POV.

It's just that surely every other strict-parsing filesystem is also
broken in this same way, so coding around the busybox bug only in debugfs
seems a little strange. (Surely we won't change every filesystem to accept
unknown options just for busybox's benefit.)

IOWS: why do we accomodate busybox brokenness only for debugfs, given that
"auto" can be used in fstab for any filesystem?

But in simplest terms - it was, in fact, debugfs that a) changed and
b) got the bug report, so I don't have strong objections to going back
to the old behavior.

-Eric




