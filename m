Return-Path: <linux-kernel+bounces-242243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C2928550
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5311F24A7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94D146A8E;
	Fri,  5 Jul 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJM8UTpo"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B171448E9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172501; cv=none; b=A6iUL6b4+R8uB++OyZMTK6zYqU7le8xWQlmsk0hj02g6KaDtpv1hN9EJ3IKro48pcXDlcaJsWVq2oG3xoHQXsrWPiwsYgZHIzGzmct13JEfOTAXbe2ihtSSA09KvjdY4/X2xc0RE5s98oE7by1GUFGyVAhF0qTnCnAAambmQ574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172501; c=relaxed/simple;
	bh=qcEniU896ql9bR0TYIg049YAiVeZdNXDkqEzxv761YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkTTbL7EnQqRhRTCMDD+jjTpK2z+f0R1q+bW730pvx3vArOgAW6xjrr48jML8H+DmMqOZPLzkFMzpFUKeCT6XatwhmdD8bDOlkLcZdIJ6dcGt1APrdQFm8dO+iiRfZVq81cRlZSPgxJPgchGtfsuZnyXnOFnaLbFkmmLWFjTI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJM8UTpo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7541fad560so163137966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172498; x=1720777298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibRuZtrZZMgYrymHUI421xN3Rf/Vq9uiSR3JQWnYUpE=;
        b=MJM8UTpokH83WpWljFDZf63bhzB784ZKZF1fR8v+d/7MsCTOGGUCNsg/x8eea5XRY5
         kC5H6ZTEeAAur/RMLGKctDwlaX2LdYtRO64UcanTlgEWuLZZEpDSmO1i+Cp6I5E1Kcv/
         YlwZbcX/Su2FUdf49+Mf0ZLgnlVDvHb0drLg22rk967lv1FqNagz5BeAYjO3dxGZMGsY
         dXbHAJ1cxWfZJZmvA7TGbfCEhu37vY98MtJ6AsNTQzveHeTxHWXAxh/b7DpYm/u2RU00
         f72D8ngkUo23vrpnZetfuhClX+BD2KIleAVFlCnnPqovP6bY11JC8iK10Jab0XT4a8ed
         L+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172498; x=1720777298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibRuZtrZZMgYrymHUI421xN3Rf/Vq9uiSR3JQWnYUpE=;
        b=XYW6UTukYq00hJa73Hz5epQdQEBvgJHk1+iY9CfWboza7zcj5+Ae+Hh02Wxcu5cG6S
         6TtMo3+vR1na9U201IdgcZ5Cps14lsFBaLJ1Sl4y6QTRav2AOH+5qg6O1tBGjVnFBAAG
         XkqIKpbQCIX/TDA10uKFBAJ1I0g4hkKdyo4g1Nh38WKudi0zC71kTwhtU/SkZ2vyICg+
         yZMu/AVbWY+UgRDGqEjPp7g6Qe86x1p3VbFDluYmzi6mraThte8iQ6rMWTDbLkrGUa+D
         hgcGrk+3xtnXQXtpwmqwPN6zXl0/wgBC0skIMOlpM6yZTgge6P2BXX0hgOZyJT2TrP8x
         /baQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCUQaTOSsPDlLugDKe2RIoOFKOd+YcbqDniLr7dDrX4GjVRy/cvsdnjjbBtwyqj3Y9v5kDZKr3mMl7zCc4mTc7HHkQ9hIruCy8jNtR
X-Gm-Message-State: AOJu0YxfvA9f5LumkX32X4YqJjXCvQ7/qwFj5sbAGVA3UMMgA4un/mIS
	YzB9LEeac5+oalKMNuUZR+4WIgkJWqaVgFXGt+YX62rGNz1saQeE
X-Google-Smtp-Source: AGHT+IG0eaX32YQsM5Si8AqpWLnDXROtFypWQmSnHANlq0N5+MIE8QkDxw3b2jmPa/HPo+5iQU33cg==
X-Received: by 2002:a17:906:6b19:b0:a77:c9cc:f96f with SMTP id a640c23a62f3a-a77c9ccfaaamr110873466b.7.1720172497452;
        Fri, 05 Jul 2024 02:41:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:f496])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c978763bsm53234366b.109.2024.07.05.02.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 02:41:37 -0700 (PDT)
Message-ID: <3d56d422-8d12-4ba7-9aec-704f08ecf07d@gmail.com>
Date: Fri, 5 Jul 2024 10:41:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] mm: store zero pages to be swapped out in a bitmap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
 david@redhat.com, ying.huang@intel.com, hughd@google.com,
 willy@infradead.org, yosryahmed@google.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Andi Kleen <ak@linux.intel.com>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
 <20240627105730.3110705-2-usamaarif642@gmail.com>
 <20240627161852.GA469122@cmpxchg.org>
 <44a57df4-e54c-47ee-96b8-e2361c549239@gmail.com>
 <aa573e39-8d27-475d-a3a1-27fdcfdcef56@gmail.com>
 <5743d4e4-3e34-4ac1-b4a9-0ddc4f0e624d@gmail.com>
 <6f8b64f8-b7b0-42f4-a1d4-bf79624cff1e@gmail.com>
 <20240704162256.f64fa9b6752d0d5e003f9c18@linux-foundation.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240704162256.f64fa9b6752d0d5e003f9c18@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/07/2024 02:22, Andrew Morton wrote:
> On Mon, 1 Jul 2024 20:15:46 +0300 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> Changes from v7 (Johannes):
>> - Give overview and explain how locking works in zeromap in comments
>> - Add comment for why last word is checked first when checking if
>>   folio is zero-filled
>> - Merge is_folio_zero_filled and is_folio_page_zero_filled into
>>   1 function.
>> - Use folio_zero_range to fill a folio with zero at readtime.
>> - Put swap_zeromap_folio_clear in an else branch (even if checkpatch
>>   gives warning) and add comment to make it explicitly clear that it
>>   needs to happen if folio is not zero filled.
>> - add missing kvfree for zeromap incase swapon fails.
> 
> I queued the below as a delta against what was in mm-unstable.
> 
> Can we please get this nailed down?  

Thanks, yes its finished. There won't be anymore changes on this anymore.

