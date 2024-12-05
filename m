Return-Path: <linux-kernel+bounces-432559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58FE9E4CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A00287436
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CFA1922D4;
	Thu,  5 Dec 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MxvsfHJF"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2E1917EE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371171; cv=none; b=S5RXPGTXlvjP46P02i2fJJAhaifWzIwcaN2LWJM/yNmeIwIgq3Ah2V1kWinmNzLAR+8IuEfbQ6qr8MX+7pyiVhN0drYd7zZPwOyre0tNqifjRvHyooj763crZGly2ANAuZUxRfXISgXvpaVPEs8EPs4tZB9p1q19iqHqrWHXir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371171; c=relaxed/simple;
	bh=I05OyK3KNpgpDr4PIRlliY+mK8Xs+DiFCUODSZKeiRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOE4nkMf+agGT0DB4/QAZoCzh2rigzb53j9ojwHhaXYebXGE40wpa+vm5d7cKFg/i7VN/anMQy0PA5mkFANFHs+9fPTI2P3q3HzkX0bWUntHCOVIhqLMEtbyRr3cPw0n28pkrURNDXh4T0oGVVsaoB0irirxmkay9vz1c/oRcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MxvsfHJF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215b0582aaeso3169065ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733371169; x=1733975969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhB/vC8+9l+LSkpwcpFHyYm+bgXUrU8fCpH1bzC2dVw=;
        b=MxvsfHJFSl71lIILKNhK6Q4Ehgpd2KB2WrjLvhZzTQ0OZPL7A+LmwFGLv4cZyLP8vm
         lzuq1thoL6f+s0cueAJN3yhceLEQNEVruw2e3RRGF8VVK5oaBnHKPyvsEpACHr7pnDe+
         b7Qjr9JreKpHJNBJyTIOwbLQlrpAVPnfFEh/SX0/vqz8pXtUuShdzWy9xaVnXDJpiyuX
         5rVy+NmA9pi7TjAsCJgUfkAEmm5rA7kKPQZ0BC29EPe+FWucYjvSZd88N4DQaik/pztc
         90hirx6JeW3mylGsmxvubQn+Pkr0La43LqUPLd0fS6HfPWxv0RgNY6lEI9Q2503ty0lP
         E7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733371169; x=1733975969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhB/vC8+9l+LSkpwcpFHyYm+bgXUrU8fCpH1bzC2dVw=;
        b=cFyX4HTdJxtgArk7xu6aVfTMN78U4BJp2xY3eu3obcYG5Xg6LwIwvLnIYSW5MBoQPD
         FBqNElnfxUO1P2jXZt6oo6nveMZBkaX5xSU8W1/NdfJX+amSxeAF2mqdFaVqWOZykeZE
         RIT5BYbI20nMCC4kqeVWIkI/vV6k5b7DEPeoutBbXQKxsX8B/wPcYccpHWd4D0uxqSoL
         VgkqcvLPY+frWfI9HQwTzliPYNJMKt2mudHZsC3dnbyEbFJUHcRqWYaH/gj4dPXnrMdH
         euJ2G3vcIoQlmU7mh26lwUxxncapRIz74qixPox3KSyBx3MNiKU8059IUjUOMmYkcJ37
         5C8w==
X-Forwarded-Encrypted: i=1; AJvYcCVXKPQDJvzwwbldEF4uwuGj7QGnjm7gkj/hAYMqDzSA9OMpo9C4M8tDthUex75cRQSQ/XZBLjyTMusshqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MhLHPdt3OGnUup4HiuxNWFEQekJjYq4kTXzaMAQW77nBb9Us
	p69nkkTYEZ4d4V9P3cEl3od7xWWspCuCObetesVWF9Y5ibPF6CvNsD5gMM/F7BY=
X-Gm-Gg: ASbGncvI5VbNJRfRojHJ4l9qU2RpJ9ecr0ZHG4fCMhaXyAwJ+PGmj8/inn5oRXobQhy
	sRW4t0QhpFAARCUgQugODJnCFvPXL1+MfZt4aRsLDzVSUKrCr2ohTNfspQDENqM5ButZA2KGR5M
	e9yF6h4/Q2gNT2kDk7231fTmKArkCBsk90bOk+FtxWKPP6JYkEa4lbRuX1+MmDw6geZYGxkfw79
	Lbw8i24dUXJJm9ErSzKFJerFqJu/z2IZA3BmXvS4rWfCJKv+0N+OxOb1xT0v2siCN9mwbSzCg==
X-Google-Smtp-Source: AGHT+IFfg0OCwWEMRYUiPQizPXRO2o7YEs0wKqKtPO7zo8D7aVRbDJ7EbHqqYSl0XTUs+TZh4jOOVw==
X-Received: by 2002:a17:902:e743:b0:215:4a4e:9286 with SMTP id d9443c01a7336-215bd0e66b0mr128507385ad.26.1733371169518;
        Wed, 04 Dec 2024 19:59:29 -0800 (PST)
Received: from [10.84.148.23] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f29b4csm3059085ad.245.2024.12.04.19.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:59:29 -0800 (PST)
Message-ID: <4d3f1078-0938-4920-9a09-805a54643419@bytedance.com>
Date: Thu, 5 Dec 2024 11:59:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, peterx@redhat.com,
 mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 x86@kernel.org, lorenzo.stoakes@oracle.com, zokeefe@google.com,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
 <20241204144918.b08dbdd99903d3e18a27eb44@linux-foundation.org>
 <CAG48ez19udcgNARKsizFbbnO6ATFGTSX2KEd2D5aC2Wnxy+Jwg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez19udcgNARKsizFbbnO6ATFGTSX2KEd2D5aC2Wnxy+Jwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/5 06:56, Jann Horn wrote:
> On Wed, Dec 4, 2024 at 11:49 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Wed,  4 Dec 2024 19:09:40 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>> But this is not enough to free the empty PTE page table pages in paths other
>>> that munmap and exit_mmap path, because IPI cannot be synchronized with
>>> rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table also
>>> be freed by RCU like batch table freeing.
>>>
>>> As a first step, we supported this feature on x86_64 and selectd the newly
>>> introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
>>>
>>> For other cases such as madvise(MADV_FREE), consider scanning and freeing empty
>>> PTE pages asynchronously in the future.
>>
>> Handling MADV_FREE sounds fairly straightforward?
> 
> AFAIU MADV_FREE usually doesn't immediately clear PTEs (except if they
> are swap/hwpoison/... PTEs). So the easy thing to do would be to check
> whether the page table has become empty within madvise(), but I think
> the most likely case would be that PTEs still remain (and will be
> asynchronously zapped later when memory pressure causes reclaim, or
> something like that).
> 
> So I don't see an easy path to doing it for MADV_FREE.

+1. Thanks for helping explain!


