Return-Path: <linux-kernel+bounces-403729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4419C39C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B8DB21D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D0E16A930;
	Mon, 11 Nov 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eTgZGCat"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE2158533
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314407; cv=none; b=gOj76Itn3IvtaH9MOX3nukw3EtkuZ10dzGRsdAdUl3ytg4nk+0VIA1Krbc3EEZB/G7xpXezqior9ejEeU1IBH8gBxUNi1j+rhcrI+6xt7JKF8HIpCVbt505HZjQPsNjSQ0YspVvgDpZ7s0o3Qee0XVT21WgQGoXVZfvXzsC0BTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314407; c=relaxed/simple;
	bh=0TMlo/1M8pZzt8wgzxGNWdRDANNk60XXJly6Ts5W8zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH5mTFRESiwFJ9vG049w6jshsnJy87pdGcEZe4lFmTJl9bhn+i2zgTyrAFfuWb27UgR5S0WzD2ekPhpowLyKwPqUo5poKUOVicbjDx+xdOqKiubGqTuy8hzeP64AKXn5sYhzDTY9nhHanwUCdvE948eonk7YCpN5TgesYG4Cy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eTgZGCat; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3606666b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 00:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731314403; x=1731919203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmVlHwTvUCQZE9KPsrgpDC1tNLtWbhTIHRQ7dvfrGVg=;
        b=eTgZGCatF9cCjPZRIX8ctOVuIqcUqgXQB5QSxWBBJykKitqQBCr5DWqKQKLZOVszZ5
         kVEbvhilA+uraXdb6e+wkv2bxeiHY0C7nr140i5vS75pfFD+KX4k2+nA5VWdlGq9X9oA
         F3mZrZwTsIXFIf9RC9itKA2rv2D/kdQnvWbmR1cbA6D8zkU707i4ng8AZ4mFd609jgJY
         mEDtwCfQ6PS32WTyZfng4mVW8s9dIPcU8kb2bNEAULPowakEsQX+cuU6f3pAI8fjS44r
         DCjGyY8XKt4KD+4JH3nGGhO88iC1kYdXWwCLmXALXEJIhxtod7ERS+3bUfXOQxEDxU/h
         OE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731314403; x=1731919203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmVlHwTvUCQZE9KPsrgpDC1tNLtWbhTIHRQ7dvfrGVg=;
        b=QKWd8YFlR9UAJ1V/pCh5gek4VyJW89SVzE/FHsoMBoR+rTdE0ryJmMMwsUD4eeJQ25
         F1vI0o03nQUOhcLwA/7knrQlyD7zcks9LpwuvZS3Koyx4HAVZV+lHqazyl+6CIfKwSyG
         cZzHQyKLBQuqK5zbKv5GKWlK7M1zYKF0S2s/sX3uguQHGYd330+cJeEG/ROUq8nE0eyp
         0yP4NLSuj9MNG8IK3zFhNf/nv/25wTKZUHy2vO0BmfJdJPAn8r/9mJrOIoS7CgUPfL2B
         ThjzxJ2c3QRlBECMV9rh4UZUn5FgNUkUJ21F2v8BxsJB0rHQXIpgMMwaXcz1+h8eyBnQ
         OGHA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXCK2UWq03Oi9uVNqUGp8fgeuqu2+lla0juEEHAP22PXw6wPCgndnO9k4UpTmtN8/KTdh6lBCKxtuFx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZR+JtnnD4KkKxxYA4mUdXRctPgoZcg4A0SmYQXcsKIQxEOmCV
	jD63lWbbA4uK1bVjtYwdFLkvi0o/MX2dNtdSsOPslGwPFxnd4UaAfDFjQHmwmKA=
X-Google-Smtp-Source: AGHT+IEqi8Zzo53EDLQgkbshFItq7KP14ICwi1neU9DQh0SL40H9eZsefl555LkYfSNJKXXktPJHUg==
X-Received: by 2002:a05:6a00:894:b0:71e:cf8:d6fa with SMTP id d2e1a72fcca58-724132c04d3mr16972946b3a.15.1731314403597;
        Mon, 11 Nov 2024 00:40:03 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a571ccsm8425130b3a.196.2024.11.11.00.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 00:40:03 -0800 (PST)
Message-ID: <cfb6ef05-5ee0-4d7f-a0b1-c35826603351@bytedance.com>
Date: Mon, 11 Nov 2024 16:39:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, Hillf Danton <hdanton@sina.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, SeongJae Park <sj@kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/8 21:57, Lorenzo Stoakes wrote:
> Locking around VMAs is complicated and confusing. While we have a number of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documenting
> how locks are expected to be used when it comes to interacting with
> mm_struct and vm_area_struct objects.
> 
> This is especially pertinent as regards the efforts to find sensible
> abstractions for these fundamental objects in kernel rust code whose
> compiler strictly requires some means of expressing these rules (and
> through this expression, self-document these requirements as well as
> enforce them).
> 
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and relies
> upon us handling these correctly).
> 
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardown.
> 
> The document is split between generally useful information for users of mm
> interfaces, and separately a section intended for mm kernel developers
> providing a discussion around internal implementation details.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

For the page table locks part:

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

> +
> +.. note:: Interestingly, :c:func:`!pte_offset_map_lock` holds an RCU read lock
> +          while the PTE page table lock is held.
> +

Yes, some paths will free PTE pages asynchronously by RCU (currently
only in collapse_pte_mapped_thp() and retract_page_tables(), and maybe
in madvise(MADV_DONTNEED) or even more places in the future), so the
RCU read lock in pte_offset_map_lock() can ensure the stability of the
PTE page. Although the spinlock can also be used as an RCU critical
section, holding the RCU read lock at the same time allows
spin_unlock(ptl) and pte_unmap(pte) to be called separately later.

Thanks!

