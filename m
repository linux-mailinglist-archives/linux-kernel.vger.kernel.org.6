Return-Path: <linux-kernel+bounces-365549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5499E42A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A6C1C21A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C31E412E;
	Tue, 15 Oct 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqkFfq+h"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9164683;
	Tue, 15 Oct 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988675; cv=none; b=pPJTzi77ad23yBtqptK1xcQxL4r+U8JTc77p/sh9NBsUT8fg4O5JXSDrq6byLJBH6w4Xep4yLE3pb6F7T0aHmnFhUfAJTpkuvhbBn1A4kzuitsDGfSM+JT0QD1hhfqQG064uFariWEiEsIUF9RXs7ksKFQ70sSw6fp2IMVxPMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988675; c=relaxed/simple;
	bh=aBIFc3mn2Yyw7WY57qzWmLmE36O5AfmAOWS8LLIgvJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgJ2dIPZ3RlrKNAB3+kb4RhXiz1hFIqicbYnx8ZArmriVBtCN43SvxiKDh2IQcWSx7o8knPPCayUqQcDeb7sC0zlhktLb8HG+PLuBj4FdVxsRimRgzVVnR57ysFAXyDHc7Bl5/WCc/PPrNChAIYOfkvVf/UUksseGL2fElSspwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqkFfq+h; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e38ebcc0abso20552997b3.2;
        Tue, 15 Oct 2024 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728988673; x=1729593473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sBy7h5zwRXpi0YLT+GwChmFeJpLQsTIcdwsyDjq51U=;
        b=EqkFfq+hSp4T3YNE/ca8xfWrRC3YHYTk1oUVpuXkvtIF40nN8bvZ90VMfGbUjHUywn
         RE2LaK2MfnF2PfgyJa2FV82MknBOQmihEaZBMAZHdA/i/qzqbzWopqhSQZqESU3difAJ
         YFB2Vd+79Q0mHCf6FOiye4h5Scy4Rk1vrLiVBltTqCVmlbGQO++RsxRMvSPpjdpMqDyj
         da+nA41jVpyuF1lWcUrgZJCUaehlLHHhWJqQ4SjsFWveSaRYkcdJvHT5D4YQVJVcFQUv
         SHgVwsiKKhgwddO6uje4//Vmi7ga+bQvehlSbBeYua2fpHxFca1j7MogcuiNK4NV3k9k
         QQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988673; x=1729593473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sBy7h5zwRXpi0YLT+GwChmFeJpLQsTIcdwsyDjq51U=;
        b=cE9k6mLeL4zMGiLOty6DRHaKR0qTrF8tsQ6wlnKoVYR4xz+fkEa7N7BNDewmD91mJa
         0m8kUc9kAxHH47Gk17MB/aAlqW7AEEMIbvqk6qSXLTySNYaTMZYU4l7P2i9e4/NTq+C5
         sIRGJb4BHRuLaWMMWWKgEI0CV7WzwrUeQ8IKRTB+A2IWr2ojvxRaT8ND4oV1PrUiAdZK
         FgYJ0CqW/EORKEIqqhB3SGeDbUKFSOgH0ILYUWJcNfSe8L4ArNJGu6LxtFCT9yDJIYxs
         4sCcdARqqbJVlf5gBJHsip+UibcXc1Y4k5BgKwKyAe3QCgKdNA6nk6jPRQE3Mgs0VX+r
         R/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUy43Kt9Kgt91SXNO2a46mPg7d+BD3pDmxpXoo8rsvK5zBJVyRQBYdcC6gH7jZWT9Y0PR+r+TzmbgF+YdlZ@vger.kernel.org, AJvYcCX6tdi9anNUt9zAc1MA3ehfNWU9BeVY/fUqo4QzCgNKrA3oLdWcek7D0jipBwWPbJ3gkISwSTh7qBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjHjDE/Bg7xFiWM86ogAKqVl2uzKInAgFJaf+Yc/fisJF2zDm
	su6/JQeBHlBEAWGFzIhBRmeWnXgWPvVeANMPdmDlzK1qdYoHx/yS
X-Google-Smtp-Source: AGHT+IGEz5YR74xcvrUNnXsKm07qiR5SgHWWZyTGRmt+znubipd9asVA9EoCreMM02ebRCz2Qv1IIQ==
X-Received: by 2002:a05:690c:5c12:b0:6e2:43ea:552 with SMTP id 00721157ae682-6e3479b5fa2mr100881787b3.16.1728988672941;
        Tue, 15 Oct 2024 03:37:52 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5cbd608sm2150187b3.81.2024.10.15.03.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:37:51 -0700 (PDT)
Message-ID: <296d5c58-2713-44c7-a253-c1cb9a11e56e@gmail.com>
Date: Tue, 15 Oct 2024 18:37:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
To: Jonathan Corbet <corbet@lwn.net>, jiang.kun2@zte.com.cn,
 alexs@kernel.org, siyanteng@loongson.cn, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
References: <20241012171357153parWX6Has5WheQyGlP0kP@zte.com.cn>
 <ecdc7672-965a-4bc5-8e0a-a407de82407f@gmail.com>
 <87ed4isd7b.fsf@trenco.lwn.net>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <87ed4isd7b.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/15/24 03:21, Jonathan Corbet wrote:
> Alex Shi <seakeel@gmail.com> writes:
> 
>> Hi Jiang, 
>>
>> Your patch format is still odd in 'Subject':
>> Subject: =?UTF-8?B?wqBbUEFUQ0ggdjVdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBwaHlzaWNhbF9tZW1vcnkucnN0IHRvIFNpbXBsaWZpZWTCoENoaW5lc2U=?=
>> Content-Type: text/plain;
>>         charset="UTF-8"
>> X-MAIL:mse-fl2.zte.com.cn 49C9DsLB077233
>> X-Fangmail-Anti-Spam-Filtered: true
>> X-Fangmail-MID-QID: 670A3DD9.001/4XQd8n4BCPz5B1DK
>>
>> It should a English word. 
>> You need to send patch to yourself and apply it to check if
>> everything all right.
> 
> I think the formatting is OK - the patch applies fine here.  I would
> appreciate a review of the actual content, though...:)

Maybe just my git has the problem? After a unchanged apply, I got a subject like following
" [PATCH v5] Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese", that includes the versions and a extra apace.

Yes, we could do few modification to align the format. But maybe let's thing all right at first is better? :)

Thanks
Alex

