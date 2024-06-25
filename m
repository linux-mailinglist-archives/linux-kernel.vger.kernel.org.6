Return-Path: <linux-kernel+bounces-228964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCADF916925
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E331C223EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791715FA85;
	Tue, 25 Jun 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXF+8aVJ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF115F31D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322791; cv=none; b=O23ick0ktGTWQdbDRqGDHMRRBIr90MlJA+gLLBs3SqVpzY4qBVE2EDIizjhIayqEJvF5ZwQQlQY28zYMx9ge849mAWZ5hDZf2SBKw/h1hPzz1t7dtKvg4KRnS1muF7iKWWEC4CH6IfMJAoX69kgRMatRbW03cNAq+esi/820ewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322791; c=relaxed/simple;
	bh=bC5aqeCSuUQxkZxPIm8YDlEpP0auomcd4UVSOErV0es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0mrQ+rXIQWiyaim+puDBbIeqIM4ONsxWrquL/Wc+esQU7EC+xegRddI1jsoNi96nJe9kOGWF1CvGQDbDWCinWdljuEqbjKkuzQMAHJH772NqQ6Y8aC0/1LEmt2E2S/BwcHG8nt+cHgDJSAlX4SOqMwh8Z2eVM6w/2xHyfds8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXF+8aVJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70673c32118so1957377b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719322789; x=1719927589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okx95xZst8cGo3CSPKwHxlpOMmeoBKtVfjHswwqrNuE=;
        b=eXF+8aVJXDYoqtHMxlSSF88+PZ1A3BblaA08OzVFlpKdCNXwvNuDHeQBEdRLnlrdaG
         Hee7wIHilqIwP0QBTp2ZLBy/3+Y7W62SVQ+MtbTonkNR9g9i8NPkXsbiB+OuvkKU5m3a
         XbD22bTrvRFH6x4Gj1crRVV0XbV8nmjtKSVR1XwoQ9EZJkGSdkyEN5FMWn5mnISW/Xr/
         5cJCF2p2r1IRLZT1uOFAGlLc0CIk8XR9dx/4sjDweQ6NVNxZzY6gBnFmWPA2NzNmNyzx
         u2KHxsok0cQR/E653opxLoG1bq2Z2FR23VRN28x308JoF7bw1yPUAuGcIE2MWfBf4R5H
         8QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322789; x=1719927589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okx95xZst8cGo3CSPKwHxlpOMmeoBKtVfjHswwqrNuE=;
        b=vt6qKzGpHYQr2acxhhyL8STMJjsSIoENgclcSqzhL/N1Xweg1+y3D0ybOBJGHX++4y
         13Hd3NkkBBN0/pwTy5WQlDY6ih8b6EC4NZkHQnVxUiMWMG0WG89maU0ts+xfFE3WT7oZ
         EtBUZO2c06J/75p+biwgJL5xEK0hD1W13UuxdvPPrWxu1+nIWA6BmDg31YAepN4jH6y2
         Q8BrJxRj1/Nvpkao62Ywhrn4H7rJIgRP9grFWXcyVRX8l1ZfI3Hn/2UFUxCJwhEEZgvf
         bS52SqARE4qsI+iI5rA7FNbyaXG0w8Ia7+PIq6e4kz5ELazcp4KrajCZ0WJCmRN+wIp4
         Io2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDIAUvdjieNU2mzTNZKBW5yPWf3zVEomQAQ/kigA5cLUoYhC4JJeLaV67Qycem8K/XvBp2uIx42O+iXdlY8PIjW7E86fPVOCrdeiUp
X-Gm-Message-State: AOJu0YzkTF4Lm1EksdNaCKYRroG55sYLgWv0BTamh9BI2ATA4mh0dTba
	xaVmIjNUKThFaf4ww3SZkwJhw5RjRJv627bsR902WrjdNYRJIe0Q
X-Google-Smtp-Source: AGHT+IGOHUa9J0qmzxadXHeAmrAN95hKURVln+uldouq6Zs/fXZlbquf3YNRoiMkI/chDUJjduoe2Q==
X-Received: by 2002:aa7:8611:0:b0:706:375e:220d with SMTP id d2e1a72fcca58-706746fa56cmr6926185b3a.30.1719322788798;
        Tue, 25 Jun 2024 06:39:48 -0700 (PDT)
Received: from [192.168.255.10] ([101.87.0.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068b738d89sm3214471b3a.203.2024.06.25.06.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:39:48 -0700 (PDT)
Message-ID: <c48c4062-c058-4c02-8a1b-f60426cf96f6@gmail.com>
Date: Tue, 25 Jun 2024 21:39:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, alexs@kernel.org,
 Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com
References: <20240621054658.1220796-1-alexs@kernel.org>
 <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
 <2e9ce344-e25f-41e0-8ca4-b6d80e095735@gmail.com>
 <CAB=+i9RH9HQXHNM23frN_0_7VmpXaYPLLTyOw3ONYyER2FEMAw@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAB=+i9RH9HQXHNM23frN_0_7VmpXaYPLLTyOw3ONYyER2FEMAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/25/24 5:28 PM, Hyeonggon Yoo wrote:
> 
> 
> On Tue, Jun 25, 2024 at 5:11 PM Alex Shi <seakeel@gmail.com <mailto:seakeel@gmail.com>> wrote:
> 
> 
> 
>     On 6/25/24 5:46 AM, Yosry Ahmed wrote:
>     > On Thu, Jun 20, 2024 at 10:42 PM <alexs@kernel.org <mailto:alexs@kernel.org>> wrote:
>     >>
>     >> From: Alex Shi <alexs@kernel.org <mailto:alexs@kernel.org>>
>     >>
>     >> According to Metthew's plan, the page descriptor will be replace by a 8
>     >> bytes mem_desc on destination purpose.
>     >> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/ <https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/>
>     >>
>     >> Here is a implement on z3fold to replace page descriptor by zpdesc,
>     >> which is still overlay on struct page now. but it's a step move forward
>     >> above destination.
>     >>
>     >> To name the struct zpdesc instead of z3fold_desc, since there are 3 zpool
>     >> usages under zswap, zbud, z3fold, zsmalloc. It looks like we may extend the
>     >> zpdesc to zbud and zsmalloc, combined their usage into one.
>     >
>     > For zsmalloc, there is already an ongoing effort to split zsdesc from
>     > struct page [2].
>     >
>     > [2]https://lore.kernel.org/lkml/20230713042037.980211-1-42.hyeyoo@gmail.com/ <https://lore.kernel.org/lkml/20230713042037.980211-1-42.hyeyoo@gmail.com/>
> 
>     David had pointed out this to me few weeks ago too. This patchset hasn't updated nearly a year. If Yoo don't object I'd like to pick up from his left and update it to latest zsmalloc.c.
> 
> 
> Hi Alex and Yosry,
> 
> Thank you for mentioning this! I still believe the work is worth pursuing, but recently I haven't had the capacity to push it further.
> 
> I'm on board with you taking it over and updating it with the latest source code. If you have any questions while bringing it up to date, don't hesitate please reach out to me.


Hi Yoo,

Thanks a lot for generous offer! I will update the patchset and send you for review ASAP. :)

Cheers!
Alex 

