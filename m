Return-Path: <linux-kernel+bounces-267404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCEA941109
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24497283CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9841A01DD;
	Tue, 30 Jul 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMw9c+Pb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9FF18D4D7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339917; cv=none; b=LXfuD+147KLjIvOP3hfLKerVu6TeIP1N01j9oyKv64HPareUKUHgk1EqOA6oqOStE9Ltlc38v/jq5rTIEHn5QWyjHRitjpX1oZOfdcCl9yb5rzSxnBgx1MgC9r4v0TqbA2cKBbBetoG5p2jAZsm2RisomPuvK89lcte+kyZ+xSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339917; c=relaxed/simple;
	bh=YUx9OUipV1vbFsQmqqJGyeGXsefNhK038r4Nwn42cHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgdShz8BdzHPH9m2R6BFaFEdk/yT5HM/YwVVZJISZUnoKRjjXGFOtVJvwDrzLpMPi6rF+iUKkSSh86mIXbMcjdwTRn/M9JPrx35jdS9lY+A+uIJ4N0wMRG+ynAJnUTPDHTM/W4Boys1aQsbuKzCu7JNEmIajx6TOC/IIHJw4wL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMw9c+Pb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd6ed7688cso30460325ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722339915; x=1722944715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNzJD0ma/gBTaSASVGb5/XwkSpA3AAlbLA/+0vfLFQc=;
        b=JMw9c+Pbt8Xe8I/nMt9UKlHrZyxPZ+rjQwaWoIPVR+eWtiwxkx2vpEP9QbWycn8MnA
         NwFReyDsMZ+0b0UOw2jQlfmm0dixDwCY7xgezZpWIU2+nU6iuookeEZDJL5GG7xWsR8i
         zqBvvqBhBuh1IqJiwt8TjCZNs4qO+IYT14hOpyJXrxqZqiRMHGkg+CQ2WbwD2ZabjkwV
         5XEvL/ey5/gHBR5rdTKyQeYF2fTKsRK1zgKmjQOFSxtQ86wE0qoPnuJafLfCHkc0NPbp
         QWM7MKwOY8/xeVyUEi1dAxY2sJNhjc3AfD2ptL9mNdjwseaomnu3yV+y6QhFY8dXxmUD
         sFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339915; x=1722944715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNzJD0ma/gBTaSASVGb5/XwkSpA3AAlbLA/+0vfLFQc=;
        b=uo+cvw4eVAFnAf/l6rMiFRutGL5KFAlr10aVETTHYCUSDn7d/ThPiCIaBOC/MEcaXm
         KcdLTYQDYbC30cBgyTwqCwq6ULXP5GhMWQSU5IKjxLvky7wwlM4aKOa1xBsxjnaxE7Vm
         BkHHer7ZNtB3PixRUIsuZQ6ixMCCiAQgOqFpPv6+fAX0Csv0uSXiGFI8tMc9/VEYj4CU
         DJTDPNKPP99nInCLO2snoM+gC2fAIqwUtm3j5WtmD+AxbpyDkOVx3KFzom19+7fQy0zU
         zxXgS6Pf+PcuChg9oE8n0rmsPztzzBrIcr8MCUbsbRy4xvKm41Q5cOb9b/9GdVyosxdR
         HOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5emIMbAGnoNmajpq5opDByRYx63kRRAaTOW95v+AQmr/+EEMO2p0kwao7ZnCFiX7dFTCNamPJMJMsEu1ogXmpvLu0a+iqR6Uuv27e
X-Gm-Message-State: AOJu0Yynp8hxXv1a6NG3UkZ/rUR/dKQNrXwTfsU2+TqgX/3G7HQWQT+c
	4vqpHLI30ATLeQyDcPUEVcd5SmZJ3kUOXmoAKeppBGvgP7ImU8l+
X-Google-Smtp-Source: AGHT+IHNC6kZSL/TITGDaGP6NqoVN31waIeAHbmfkXY+IOiNOxXOApr+d1qEcXNjT/9MqN+A00PXhA==
X-Received: by 2002:a17:903:27cf:b0:1fd:7fe2:1f31 with SMTP id d9443c01a7336-1ff04861453mr72726095ad.33.1722339914974;
        Tue, 30 Jul 2024 04:45:14 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c80044sm99683555ad.14.2024.07.30.04.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:45:14 -0700 (PDT)
Message-ID: <8fc7939b-416a-4328-9df2-488f17783543@gmail.com>
Date: Tue, 30 Jul 2024 19:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc
 changes
To: Sergey Senozhatsky <senozhatsky@chromium.org>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-23-alexs@kernel.org>
 <20240730093726.GB16599@google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240730093726.GB16599@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 5:37 PM, Sergey Senozhatsky wrote:
> On (24/07/29 19:25), alexs@kernel.org wrote:
>>
>> From: Alex Shi <alexs@kernel.org>
>>
> 
> Usually some simple commit message is still expected.

Uh, my fault. Just forgive this part, is the following log fine?

    After the page to zpdesc conversion, there still left few comments or
    function named with page not zpdesc, let's update the comments and
    rename function create_page_chain() as create_zpdesc_chain().

Thanks
Alex

