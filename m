Return-Path: <linux-kernel+bounces-364862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3534799DA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C681F22112
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3811D5AC9;
	Mon, 14 Oct 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BdwIzKmU"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6251E4A6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949759; cv=none; b=DaCBBNke0/79j02y6R/+8bxIqR0FG5DmrsFauQnow2Thmw0WtiNImmlgd4OJRpqwFk058pZsfvpihGwroT/pvSynLtVIiGfGK5jiegXQ7fhacVVM62dtf5XzOR9lOEX4n/9KBf9MHBflH+eOrpdmyMN0WD98sNgdUukoeCV/Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949759; c=relaxed/simple;
	bh=XkFMW9qqXhz5NcztJxtsGEGFvgG/+6XjquMraVD2O0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEB7c/ZlEFFN/BjfMWgT4DE5meLQ5dJOPB/ObaZVM/vvxxF/6NjDBC/UaXNTc86d3aiNCxhtzuEIPcy8ebxSoDRJtp6Lh+3zXzneT1H9ZMknrNkdJ+E31DvE1rv10Np7dKBtMCyYxBjDdsD5nTfzZw0tBWWzMqy8sjhV/Ek/Nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BdwIzKmU; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a394418442so14186065ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728949756; x=1729554556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWe6IuexOe+i8ZiAj9oB5+f9OBLjXk23n/ktjCPYH4M=;
        b=BdwIzKmU/SGKbpQEOfjxdjjo7tUqDfL2srO8GdbLxo6iqUu1+0udVNLP4GWPVt2U80
         vgnBpJLjTZnsj4i9ggDFKiImYeQ03f8bV7zH4eQOQm/Snn4TYbigHFEtupT/HkTuD9KJ
         HQW7uQQfFaACbtxmlIs963fx78mMW3d1fXKXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949756; x=1729554556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWe6IuexOe+i8ZiAj9oB5+f9OBLjXk23n/ktjCPYH4M=;
        b=PD77QZ44ottHNtm4Xll76dfKv15n3jp0v86Ko/PdQaNjlblvekKG/jL9SAsvvWBE9b
         aXyYiRo+NTPvl33q4aizEX87ZOecZdH4pBjIjdXbgKYrlg3Lfot166w9SfQIHTfXRb8x
         3JZvK1Ob37Ez9/kPW06fZz4N1azmQLiEFEjvenwDM8CCQnuM+RVwj1434WAnzfBFfUvH
         uzMBUpq1DMFbRmUbBECt9WB5uUPhXEzf470rfVH7BG6R1XmW4BZN3ODCAohj2OUtk/eA
         dMnn6rQniFBnecxQWwL/CzLxSW6ZjHpQ8tsTHn9Mtg3ETPWpr1wU3lurNK/1sjVb3KH9
         CdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtxmBeS8CRYVpspy1m0NUtUAsGN6atc90IYW3BVkf2fnvIfjHtCPN1/FlemkD5iC33spO3in5f3afK6Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYTRqbS1a8YqXVny17LJD3pYIdXrhsPdGPMGV/aHRep90Tm8V
	r9XACl5CJHrnWXm0Ytk9qPrlqgfdeluH2GHP5PhMxWzELCe2DpBJSYRuQq7feIUAdF3lcDPJtmG
	K
X-Google-Smtp-Source: AGHT+IEZ2NSeBe5voVSUCeq2HBwOyBsJZdeZRWIdx0WeoToxCr6cKneZoX9cuIrjRGj9g2KdM9SDDA==
X-Received: by 2002:a05:6e02:2167:b0:3a3:9801:b668 with SMTP id e9e14a558f8ab-3a3bcdccca0mr70458855ab.15.1728949756084;
        Mon, 14 Oct 2024 16:49:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d714ed16sm386205ab.64.2024.10.14.16.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 16:49:15 -0700 (PDT)
Message-ID: <0ca380e7-3913-47e9-8cde-819ff90223fc@linuxfoundation.org>
Date: Mon, 14 Oct 2024 17:49:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add Chinese Simplified translation
To: Candice Cheng <ap@linuxfoundation.org>, Kieran Moy <kfatyuip@gmail.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240522165745.76561-1-kfatyuip@gmail.com>
 <1f4dc3b7-f05d-487b-b22b-5f0c37921672@linuxfoundation.org>
 <ae0cf2c8-4e90-4575-b69d-67234ea47dac@linuxfoundation.org>
 <CAJ1P9G7BGo0NOHxAc3xX63PR+W2i=4mXvi2fkV8+eOmpS6eOvw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJ1P9G7BGo0NOHxAc3xX63PR+W2i=4mXvi2fkV8+eOmpS6eOvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/24 10:25, Candice Cheng wrote:
> Process Core C3:  处理器核心 C3 - changed to 处理器 Core C3
> 处于睡眠状态的包: changed  to in sleep state.
> 
> PS 包 and 核心 are confusing Chinese people. Everything else is understandable.

Thank you Candice.

Kieran, please make the suggested changes and sene me v2.

> 
> On Mon, Oct 14, 2024 at 8:31 AM Shuah Khan <skhan@linuxfoundation.org <mailto:skhan@linuxfoundation.org>> wrote:
> 
>     Hi Candice,
> 
>     On 9/30/24 09:35, Shuah Khan wrote:
>      > On 5/22/24 10:57, Kieran Moy wrote:
>      >> Add Chinese Simplified translation for cpupower
>      >>
>      >> Signed-off-by: Kieran Moy <kfatyuip@gmail.com <mailto:kfatyuip@gmail.com>>
>      >
>      > Sorry this got stuck in my Inbox.
>      > Adding linux-pm
>      >
>      > Also I would like Chineese speakers in the community review
>      > and give me a Reviwed-by - any help is much appreciated.
>     Thank you for offering to review the patch. Please review and
>     let me know what corrections need to be made.
> 
>      >
>      >> ---
>      >>   tools/power/cpupower/Makefile    |   2 +-
>      >>   tools/power/cpupower/po/zh_CN.po | 942 +++++++++++++++++++++++++++++++
>      >>   2 files changed, 943 insertions(+), 1 deletion(-)
>      >>   create mode 100644 tools/power/cpupower/po/zh_CN.po

thanks,
-- Shuah


