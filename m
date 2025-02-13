Return-Path: <linux-kernel+bounces-513540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23AAA34B68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A72D1624CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96953221700;
	Thu, 13 Feb 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="VdA8mVjE"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9E214A69
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466429; cv=none; b=V4QGXs9iN5u6d0/rGKohHo95m8Hxt84nQ/tCWnwFDX1riCs6cIqTetcFvn4onLmLJCbyGODZn2ZQIOdLH9V1t74ccIKC4tg43taO+ssSYGjtg4SDvcdfqkc1NUlYEliHylxPGCpW7pn8EOc6FPwGSJXJq3/f5medGfOttvf7n7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466429; c=relaxed/simple;
	bh=rB8KbwGPwVVprGssZRAa1SZhAKnXoGoYh27vDNsmwDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtivS6ZEWZJKHxicwzDz57FgWu0WVqQgPdZwCte9uyTtmCYD1p2YAU48/t30K8sG7B9obkZXuU38YunCFygvFS7XJ5zrllttVr+m9ktxcnIOnliZcS6fOqWWgF7fMaJ65RCVO+MuOQMbYMconEd8rgAE3OdPE219aQNMlsPuV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=VdA8mVjE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c05f7d9ac0so130078985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1739466426; x=1740071226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlLNOt9fP+kEnliAil52DiLv0in7lZUPZKbD7Kg1MnE=;
        b=VdA8mVjEI0FrfpknUEsm+N0DvN0Iko0/xAGNzYZp8kAiONdU6bLcSz7nIHJxXB13xv
         OwQwozB/esfM4fnJ2MEumr+av7e05yCiTunCZtsH4DdDGWgPhKOx3MudTNzkL/izcXKN
         xxPwlIQ06DMUGf+nNTufHNgdse4oMnKde7gpq4y4IZBqPsc5yRPstFE3i2uDNVSUU+LD
         FPtXMpH3TyqrakwPPp9KjuYsiceku6obbVP8B5TWAXOfSNI7MMcCxFOhrc+wHRyGDVVt
         3HyyVq+ArZxMJXrvYDVOjAlifEfZrov95umeX8KNMEMH5ICl2vdhdzoWr3tAJemXCtoW
         IcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466426; x=1740071226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlLNOt9fP+kEnliAil52DiLv0in7lZUPZKbD7Kg1MnE=;
        b=r5czw4wV3BKMJoLaq0Nw7Ty2u4hwbfLw7eWEaq6yPuCReL1ZmLKuVudCe4xnUkmtrd
         VlNZx9gYGvvWVgk3p59azJJD4AHwdx9mJdIZG2FWuD9R9sLkMhSd54xlcCOUFZ0qAJ54
         +vGVRePbFmQKn8W/WKFunvnfkJOaRJPuLJrwR4O8hD7ojox6srmsVvwe2IwzEe/bILbe
         s6Uud8Ra22JUVdqTKg8Z/Cg5vpjEzYKXWueIdI80zlDrnh+HyYyiYO15+sdZB3F0Lpwk
         1ZoSrD1ebR6LTKsGtpxoOiF59w4TcYPkZcEWUs6QW1w/3lD+ACqzVNPhbnxIyQKeAEmE
         YbsA==
X-Forwarded-Encrypted: i=1; AJvYcCWY4MNpE8Of4RXZqc2FzNPR30Jrh7XSTx+lFflU+e2hDAmgCE97M2AmYp2oVDj8/7VYerb4BHqsp4I/hs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUnv6KXGguJygEakvf0+9qtxdoN5cuvVV0czE5xiAgJdLB6bF7
	dmp0e7TrJqe53z77RBQ9naUScV8zSGKFgEfYRVBixemRN7wqmN4yUZWV0Q2C8g==
X-Gm-Gg: ASbGncs5EsvCjFQKZvigptHsYnhYOJ9w173qzTWqfOfVVUw6LlM55VmmZpFDjmxpwRd
	IlyfByaDVX4vuZyU3FnYI/AzUWlX4sx0dFTHyz4727P9oj7WH2EHwO66sUzHcHeB21rT9q1XFwu
	WaPtHpjYHykDOS3LPJFzkUM8d6LkroEwxwqnBFL0him/qP51O39vhEvui94S+oGRf5XM7+as7wK
	aLFWljzWaIiFmkV9rgacSEl4NOQujcCoZNe2HrjgMS9h9yrIkUwUBB8Uo/mfeCjOoBsCZxMl0m+
	2qs6PhnHVQII8OoCzqs/lzr/tlHI66evpA==
X-Google-Smtp-Source: AGHT+IGsMfgrhffZotxEBPAkCoKFxM2e4MJHynAIf4UclWxtnIYSVF6Pzff8nHgCVhV2dzf3/QqyvA==
X-Received: by 2002:a05:6214:2a8a:b0:6df:97a3:5e76 with SMTP id 6a1803df08f44-6e46ed8a47cmr126158686d6.27.1739466425747;
        Thu, 13 Feb 2025 09:07:05 -0800 (PST)
Received: from [10.200.24.228] ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2a12436sm9719841cf.23.2025.02.13.09.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 09:07:05 -0800 (PST)
Message-ID: <e4a4c688-b78c-468b-8196-68d2df980167@tenstorrent.com>
Date: Thu, 13 Feb 2025 11:07:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] riscv: implement user_access_begin and families
To: Ben Dooks <ben.dooks@codethink.co.uk>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jisheng Zhang <jszhang@kernel.org>
References: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
 <20241118230112.2872978-2-cyrilbur@tenstorrent.com> <Z4rl8BgoV8tygCn9@ghost>
 <b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/2/2025 1:08 am, Ben Dooks wrote:
> On 17/01/2025 23:21, Charlie Jenkins wrote:
>> On Mon, Nov 18, 2024 at 11:01:09PM +0000, Cyril Bur wrote:
>>> From: Jisheng Zhang <jszhang@kernel.org>
>>>
>>> Currently, when a function like strncpy_from_user() is called,
>>> the userspace access protection is disabled and enabled
>>> for every word read.
>>>
>>> By implementing user_access_begin and families, the protection
>>> is disabled at the beginning of the copy and enabled at the end.
>>>
>>> The __inttype macro is borrowed from x86 implementation.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
> 
> If we're doing this, then saving the STATUS.SUM flag is going to
> be more important than before. We had this discussion when the
> initial user-access with syzbot stress testing turned up.
> 
> We partially fixed this by rewriting the ordering in the __put_user
> function to stop the 'x' argument being evaluated inside the area
> where SUM is enabled, but this is going to make the window of
> opportunity of a thread switch much bigger and the bug will just
> come back and bite harder.
> 
> If you want I can look at re-doing my original patch and resubmitting.

Oh! Could you please link the patch? I haven't seen it and can't seem to 
find it now.

Thanks.

> 
> 


