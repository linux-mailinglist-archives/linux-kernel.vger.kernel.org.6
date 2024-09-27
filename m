Return-Path: <linux-kernel+bounces-341883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940F9887BC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3401F229C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512841C1751;
	Fri, 27 Sep 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dv+0+NW0"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83981C0DFA
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449108; cv=none; b=bYdkIcEsO709+lDgSpNI/AYBMzfhI+VrDQB5tvf8ZPM47HOIvnCLSl1cSQiBuAuJqVNpHRCBHzoYlDhojxSKAas/vrdbQZU7zaoSn+KK54p2fJsiZm/tMOdmg7WiQqqraTHT23RbHyNh5yy7Qu5YTT75PLhsIZz9PMt1hvvVInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449108; c=relaxed/simple;
	bh=gz5kgzblFEgVvHMM1++lDHMe6JbnFl7PORGLYZgFors=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuIhRgG78w/j864pZucPZTWuc8jbpC2AP9i1JLSPCB9Hz7cpHivGTYrcyRm9TCmj5m6lvvINVzpRKxkzy6CXnlBXZMKOwuiewytP5K2N5byPTjDTvUYYuPHWWHjAo5+WA2E1iXkIUHELCEudTlqrfRMjnz/d1xNNlTPkGNPms4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dv+0+NW0; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37636c3872bso7901785ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727449106; x=1728053906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozhasy6P2Xb1oYh5TEGfoMTGpcm94OU26cK0RFvw/pA=;
        b=dv+0+NW0QULYfi81OWyhYqPWI4A44jno28aPaKySMl+wBEuWQr7ebDMlOIWzeTnKre
         mrOj7nF9Jz7lNfC4P5jXtW7g/wDkTjjpEYQEsbY5F1UbUZ7+5N/+7e4XWf85c8IHCslO
         OItWbzEr+zVXSqC5VrkEJdZBZEGfaxZ/Pkoo4J6wCJW36wUSRfXjKTSOspSwBfdhj1kk
         WiKBK6oKRiJCzeXORgCHrhit7trPtmDiTAoS6r02sFSPXslMaQO58MfxM+XOVLvEzd2R
         48eyHuM70pcBz7ORNrVVL/d4lXwqc2Sa5CNAU5huebwTnZ3oPJrLOO6yUDuDu/wBUMcz
         5bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449106; x=1728053906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozhasy6P2Xb1oYh5TEGfoMTGpcm94OU26cK0RFvw/pA=;
        b=a+VC1HUYdPPe8hJKCuzlW7wxYILyZs+QkR1CZc48UYTyHs6QMf1mgGFFc1PLJDFEtg
         LqNyzws0pkGmHq0qeWV7TrH2IOeR3yyWumfSqS77SQkpzDHvES8Kv+VMOk3ZE2eKP7PA
         dEyg9Y1ggAKIC/ffcWzKkoKZphIQR88Os9pk/9mlN8FuFMfDBY06n3YEjgZBtZgU58sS
         dpoN5hpvaeMvHPYqEyBHnhFMBQ9+H51GOywmhlkdO0TXXzECZ0Hdka2Ua66pd6Sifb+i
         o5q4/co2feZohuQ1qYo2ObJ9JxeBdYpxvG4uC4Zis5LELGF80Exa/T0OK4c8lKrzwgxY
         Td+A==
X-Forwarded-Encrypted: i=1; AJvYcCV94Nl2AvcpSuqg9T3N24R0OCAeU6fW9KX8aEsXI1TEH8m4oRDx6QqB7JbfDHtZk4mFyLbt7cFher07AJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Yc0+z01y8YBxdaOBYe78QGkxr/oUU/npLTYSjoLAbFBJzbYD
	++Xm8mkJxbeyVkhCnnBaOEe84NSl4B1LxRWTtCOUw3xYjKTDP7IdTLLVViRJR4Q=
X-Google-Smtp-Source: AGHT+IH8vraAyss5dfiMI4UgXMfkbfey2C1HTqAO3BTHkbK/0W8GSVWuzGv0+TFXbW2pP7mY0lBEFA==
X-Received: by 2002:a05:6e02:1fe7:b0:3a2:e9ff:255a with SMTP id e9e14a558f8ab-3a3451b4b6emr32273115ab.22.1727449105798;
        Fri, 27 Sep 2024 07:58:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d81fa4sm6237075ab.20.2024.09.27.07.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 07:58:25 -0700 (PDT)
Message-ID: <0bdce668-5711-4315-ab05-1a3492cb8bf6@kernel.dk>
Date: Fri, 27 Sep 2024 08:58:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Sam James <sam@gentoo.org>, Kairui Song <ryncsn@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: stable@kernel.org, clm@meta.com, Matthew Wilcox <willy@infradead.org>,
 ct@flyingcircus.io, david@fromorbit.com, dqminh@cloudflare.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, torvalds@linux-foundation.org
References: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
 <87plotvuo1.fsf@gentoo.org>
 <CAMgjq7A3uRcr5VzPYo-hvM91fT+01tB-D3HPvk6_wcx3pq+m+Q@mail.gmail.com>
 <87y13dtaih.fsf@gentoo.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87y13dtaih.fsf@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/24 8:51 AM, Sam James wrote:
> Kairui Song <ryncsn@gmail.com> writes:
> 
>> On Wed, Sep 25, 2024 at 1:16?AM Sam James <sam@gentoo.org> wrote:
>>>
>>> Kairui, could you send them to the stable ML to be queued if Willy is
>>> fine with it?
>>>
>>
>> Hi Sam,
> 
> Hi Kairui,
> 
>>
>> Thanks for adding me to the discussion.
>>
>> Yes I'd like to, just not sure if people are still testing and
>> checking the commits.
>>
>> And I haven't sent seperate fix just for stable fix before, so can
>> anyone teach me, should I send only two patches for a minimal change,
>> or send a whole series (with some minor clean up patch as dependency)
>> for minimal conflicts? Or the stable team can just pick these up?
> 
> Please see https://www.kernel.org/doc/html/v6.11/process/stable-kernel-rules.html.
> 
> If Option 2 can't work (because of conflicts), please follow Option 3
> (https://www.kernel.org/doc/html/v6.11/process/stable-kernel-rules.html#option-3).
> 
> Just explain the background and link to this thread in a cover letter
> and mention it's your first time. Greg didn't bite me when I fumbled my
> way around it :)
> 
> (greg, please correct me if I'm talking rubbish)

It needs two cherry picks, one of them won't pick cleanly. So I suggest
whoever submits this to stable does:

1) Cherry pick the two commits, fixup the simple issue with one of them.
   I forget what it was since it's been a week and a half since I did
   it, but it's trivial to fixup.

   Don't forget to add the "commit XXX upstream" to the commit message.

2) Test that it compiles and boots and send an email to
   stable@vger.kernel.org with the patches attached and CC the folks in
   this thread, to help spot if there are mistakes.

and that should be it. Worst case, we'll need a few different patches
since this affects anything back to 5.19, and each currently maintained
stable kernel version will need it.

-- 
Jens Axboe

