Return-Path: <linux-kernel+bounces-416019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376EB9D3F35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BA9285B34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7824B28;
	Wed, 20 Nov 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="IKSqd4px"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D5A939
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117077; cv=none; b=A/1xs6T+kjR6efqxPJ+iVk6Pepws+txOkcxad+UqeCFKnL8NU5tpTVW9z3SiriZ3JIiQncXzNvqK0IvCdWpsJhV+J243W93TxPFFBbmQpUK3ijvKITGenRhXuoFZ2GkVIMZTQylMAjxPJyFTZk2HTg881Ruur8Fgq2gXWgt8kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117077; c=relaxed/simple;
	bh=0JOaf6Fc4oX3EuXWi7wZzlKsXgXLXWdlqYqGsC+CHqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ec6Byf/Rv6CCop4s8yRUTdKkCOwvMdE5EDu/FM+sNqqrdMA7u5aRwYnyiLB3jMftPyfqUk5dYZImpzUKLhDMVMV4y3mNZwHg1tO0neMUmN35W0iNQ4yZzHfSWc75FfNWO5QMydQJso6dzrICPnVs56MbZgDjh4rqw6fhXetwlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=IKSqd4px; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a76df43746so12827915ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1732117075; x=1732721875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ns+8qgp8ihemUk4LALEfrdrF/V/lndEQMLbRy8TsQuE=;
        b=IKSqd4pxegVL2TPPzpxXgninTcvoFe2aCB62xYdmwWF7D3rm9QYgCgAmqZf1K9DKiB
         PEBHugY+tSpzg6SG955LzPBz5sQl3mHLjxhwie03mlRkRur01J4+79hyqlIUc/5B1tZU
         rPWq+KnkOHD1jbc9/3atcJE5LBNpMBWDYeGM4GyDw5a+bNPZe2csvGDulNfI0KK0FywQ
         4a3JwRmMBAH1Uo9pAoYUiyL1zZpfFnMDrDbfQKDPlfmzF4x2dIxGM0hzLrasHbOiihET
         P6SC6ss6aybg1iPMaXmA5mIM2fE/SvN6kfeCPmH+gtvXeBNU04W62P2wVqsu8g9BZfhx
         6bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732117075; x=1732721875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ns+8qgp8ihemUk4LALEfrdrF/V/lndEQMLbRy8TsQuE=;
        b=M+EMkyea4VE5iGDdkSqyLm5trD7H96RCG6ZMpmouNVJbndn3FhZ0RR24RT+RDW6sQJ
         Pv7JzrcotfDDK3Gk5BWjvij3CHg5hHUlKGXKlbJ567yq0/Uf6u4hVJfsOYnXtPV4Sqld
         hHY/d++bbq6R08/vbGmKmqtEDuPq5uXNkWGSnsOFCbxhBdeM+c6l0grw7sLVOOcyiXFG
         /UGsv/LTTIl6qC5n11KbAK3IhEQw2mriwMeFs6Y9AkBXISY2EYfDgRPwf9mPw6fruc/+
         xx//lVboeQl80093zRiFT4Tfsu1WNfvcYOI8uVRV/BIDTcjztLv2vrLFuAlLEB5q2M5+
         zvqw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRhMAR5ee1+g0SE7X3EAy47efpAFeEw3t4mesn1vF5xRZPpPA/eSuIZjij12XUVWCMr6iaFviqJACEbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj22WQwyyAKjvAhd1wJ0aJA3e+TuUB0TrzvPj1fh46lF9Vqad0
	vE2TwZP0PE0Dgb9+WgbKEnkloSKMHiq/sRXwmUXBLj1qJfNqf3eQnwS2CBVUsdE=
X-Google-Smtp-Source: AGHT+IEhzzdiy3jkiDuHkj5iHET4WmAI4DlalGu7KztQOSaRQf09JJ91HJPq6IG4dJV7oNVePnYCTA==
X-Received: by 2002:a05:6602:3c6:b0:83a:b3f8:e517 with SMTP id ca18e2360f4ac-83eb5e364c5mr383922139f.0.1732117075090;
        Wed, 20 Nov 2024 07:37:55 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6eacebsm3349176173.25.2024.11.20.07.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 07:37:54 -0800 (PST)
Message-ID: <1a9a75bd-d946-40ec-8307-10fa04672300@riscstar.com>
Date: Wed, 20 Nov 2024 09:37:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: Use xchg() in xlog_cil_insert_pcp_aggregate()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Dave Chinner <dchinner@redhat.com>
References: <20241120150725.3378-1-ubizjak@gmail.com>
 <ad32f0aa-79df-41b2-90d0-9d98de695a18@riscstar.com>
 <CAFULd4afgt7LtqzZ_oFDz4wtMe+TZKGX3E_XpSo2HD5rQEvOjg@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAFULd4afgt7LtqzZ_oFDz4wtMe+TZKGX3E_XpSo2HD5rQEvOjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/20/24 9:36 AM, Uros Bizjak wrote:
> On Wed, Nov 20, 2024 at 4:34 PM Alex Elder <elder@riscstar.com> wrote:
>>
>> On 11/20/24 9:06 AM, Uros Bizjak wrote:
>>> try_cmpxchg() loop with constant "new" value can be substituted
>>> with just xchg() to atomically get and clear the location.
>>
>> You're right.  With a constant new value (0), there is no need
>> to loop to ensure we get a "stable" update.
>>
>> Is the READ_ONCE() is still needed?
> 
> No, xchg() guarantees atomic access on its own.
> 
> Uros.

Based on that:

Reviewed-by: Alex Elder <elder@riscstar.com>

