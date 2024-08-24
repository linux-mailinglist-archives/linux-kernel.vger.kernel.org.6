Return-Path: <linux-kernel+bounces-300162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7295DFB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA0CB2159A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D827DA6A;
	Sat, 24 Aug 2024 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzPz+6ED"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680D7AD5B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724525250; cv=none; b=hIytjg/AYETiriqX1q9OQh5KOhn8y3ixaqzVkXXBx9PvHOKAVnoZWebKqY72/7eFm1id52tpz0bdZD0rgw8H9nNcFOVN4sn2xp/ybvVJatZb2fcokvs2UAdXbdJN3GrISz3ESMFYhWJQpGiXaHkWVkZT45sggOQlgACyWhJLHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724525250; c=relaxed/simple;
	bh=KRA1QXWd0p8QdSfpk+2DcyTOCyiaFYMzwY/XzQed8dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5OPjYGHZP9lCRwRjUfRXIdGovSVWj4azXwyab8d5qMCYeYRfJAYZtHaOWFqYi5wf5eQShHLPXVOwUAorTbjN/bQfDj4y1w7D+Vo3tNost4gpQ70qTtO5m3gX4pE7JvBekMXUbDANJFrnNoZNVyqZOigkquAQaHf5n6Nwgbz2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzPz+6ED; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281c164408so24627875e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724525247; x=1725130047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWQpfbbJ6jxjlCm34CwxuvkLw4VIhoEjNeevoBuuVrI=;
        b=EzPz+6EDc11nBhJ3kSX88BHbHPD/gtaQGbLJcjdeNFnmEz5iIlOeE2Ks0GN6X6YzVU
         pHCkyOn0gQD32maaDd+vFNYALv5E5+athSOIqIDS8tcJx6zk/1u2+zw9SDcaMQl4MGd2
         gFalhxIguhc2p3UZGEUywAKtUQHhVDWobw8tVyWPWvyZN5z5v8wAEGoVcGYlxHGhCOZi
         GjnnEq9/mKpZfVBM4kYREdtqn56D4TE+7vcyz6qPV2OJJVQ8/W68lipFxLo0m94yvOW+
         NtXV11XaYVH9Zqof7aY6KBMFBqgcKKc7oWzohIJ5RUddUynnssBYUhn8DZgVHMwgIU1W
         IcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724525247; x=1725130047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWQpfbbJ6jxjlCm34CwxuvkLw4VIhoEjNeevoBuuVrI=;
        b=V1vp3R9pAmkekDGApk3RQUijf2AVN6aHXDm9rHT/2DxpFWrul3AX18ggR+SXQWcdOT
         oTmhB5p5Fzn/EhaRYz64LeLkDdxVZ4/bOmXuGv5q7qFmX6bxVoi7NI4mSp6JoMQJszse
         eXrl6XFX48Ql0tLB65Kw4bi3Ww9FiIYS5lZ0o2UpXmh4WReXwuJiwtOi8gsvH5pz0byu
         KwMi2UD6WZo74vQRNRU85In8MDhqxdy3VqgqpE26wCu9MssKppPsGi92ZAUY3xdECDcz
         m4IcsgAKMn0ZTQcvub15CcPA34f5+UvAsQZugGvedoBm9Ib9xDJu7AdnpnW7S1nx/dI0
         XJUA==
X-Forwarded-Encrypted: i=1; AJvYcCWGlSOYIuVX0YWkiY4POpYlJGY/iY/KXi9CPkQIbIi/LE7WPzdpIskgcOqZJt4YodHt8olrBjFv+5mEbN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTX8qG/qE2DYxSE3N+rgqRubi4df6WJYG5fyZTt8z7qJGwzOy
	DsLby15rrNVGOngdFEqNvj5tXf1jZwxjJyHyB4lrz3hQAFOY7mji
X-Google-Smtp-Source: AGHT+IGaJ5I3jhd8u6Rc+VaLUDedYPP3Jk0XoOszt9byWbAg3IGV0rCzxmB/pch4l2jsRnaK3Uqj+Q==
X-Received: by 2002:a05:600c:3b26:b0:428:1663:2c2e with SMTP id 5b1f17b1804b1-42acc8e129bmr39780995e9.17.1724525246147;
        Sat, 24 Aug 2024 11:47:26 -0700 (PDT)
Received: from [172.20.10.3] ([148.252.140.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm7188375f8f.8.2024.08.24.11.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 11:47:25 -0700 (PDT)
Message-ID: <4b3e21e1-d322-49b6-bd72-598c15430c41@gmail.com>
Date: Sat, 24 Aug 2024 14:47:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v8 0/2] mm: store zero pages to be swapped out in a
 bitmap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240823190545.979059-1-usamaarif642@gmail.com>
 <20240823220648.081970f3fc9fb49f925f15be@linux-foundation.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240823220648.081970f3fc9fb49f925f15be@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/08/2024 01:06, Andrew Morton wrote:
> On Fri, 23 Aug 2024 20:04:38 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> Resending it, as the CC had "Huang, Ying" in one of the initial patches,
>> and it was rejected by git send-email because of the "," in name.
>>
>> The original series [1] was almost merged, but was dropped
>> due to a last minute bug [2]. Resending this with the fix for it,
>> by handling zeromap in the same way as swap_map and cluster_info in
>> enable_swap_info, holding swapon_mutex and si->lock, hence avoiding
>> a race condition between swapon and any point where the lock is held. 
>> This is the safest way.
>>
>> The series had already been reviewed and acked by all maintainers.
>>
>> Hoping that this attempt goes better than the initial one :)
> 
> Yup ;)
> 
> We're missing the [0/n] words here.  I pasted the text from the v1
> series.  Please check that it remains the truth, the whole truth and
> nothing but the truth.

Yes, Thanks! The cover letter remains the same.


