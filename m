Return-Path: <linux-kernel+bounces-418156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07A29D5DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2382833BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FF1DE2C0;
	Fri, 22 Nov 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e12pYOA7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8781DE2A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273933; cv=none; b=PIIEUHj8VUYfgkEtbYLPwDOlhmlnuB6Ck2yQRzl7oUc775uu2PF+vrdQmXAca5leNFyFoo+JFW4gCf2+94ikjw338S6ta2V9M9u5VZ4XhU5RJz0NcdPDS6Z1Zp/VWEJ08IHZiV1NZVcrqKk6q9gxrJXxVPDc6GnGYl+9Eh0VzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273933; c=relaxed/simple;
	bh=kq+Vy4XfgluKsDSw0ZxCi+F/MBPF69h2NUx9Usy5KAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMrhO/FWBKEZcX53KwNYPJPjlKvHmuGffOdSrMzr2b1b6IMJe919JwUKhlDwEpw51AJUiYr3TTxQHcQu77MNHRkEUaEmuVVLjUk//yGDW0Np27U75c6ah4wF7SEF0CkazEn0aqn+fX/9Bs3vfAHgbE7a+ujSZ6cYkPEE421VLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e12pYOA7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TOpetZnj6l8IA8tXWUK05052L8BqmqO0c3Iy0AXDoZg=;
	b=e12pYOA7Zzlm8kpG9kjO5UCJFKznLJnwpy6rTdLBs/i3gOS5MEMGlPafSGocgBErie2gj8
	yistP549d8ynOlO+M+g6nVghMXDwZefeWXHQj9AjZR8ilJ3UbNk5Qad8pKLDJ+TExSyq8v
	UXnekgQBqcW4czortAtbdzUtM0uOnao=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96--AljGT1KMBiVhM-LwswQyQ-1; Fri, 22 Nov 2024 06:12:06 -0500
X-MC-Unique: -AljGT1KMBiVhM-LwswQyQ-1
X-Mimecast-MFC-AGG-ID: -AljGT1KMBiVhM-LwswQyQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3825a721afaso1139769f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273925; x=1732878725;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TOpetZnj6l8IA8tXWUK05052L8BqmqO0c3Iy0AXDoZg=;
        b=C+GWgWijjNlAwlpYtdlHryIMdKPygY3VI0pMmHfUIHDrDyhPXbB5+Qmi7tFcP/nR8s
         CAZ6IA/msnUWRj00jhajBMD1mRZR68xGM0OsIqMwaCRj36TcIdA5sl78RlUVy8yrRkwe
         7AScFsBNDbequRhuyZdD5HrobI2R93eGgXGh2vUce8TLjZaLOn3s3MJTp9dUPG/+RRUh
         0GYlsVvDZC20MzNyJYszNvvbunv9fyobbPE0t4qhTRqhID+t8iMYBNC3Mg2RbgAkzUr9
         fSUYkgHsZuFLwC2xmQqNfoyvEF3YKDydsgOU16xoGp/HQJa+n3jlD+0FN3UcysL/Y0Rp
         47wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUFjqJxDxrKVpxOXNKBRKwsxKKQ8NgOGgwJpjIyPDFqiYCePDThBDs+XDEZmdJsTEgWinZctHzVaxQtuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5qWxmadDEfpiJ62daw+QiO/+YO4UGuyyMWhHmlDGq6o0raE6
	mZGqyK7/+OObqvf2CAQ7+NKemW1FpnAlL1dUxTyjpJ4P8JrlVMk3Gl2oIgRhbHOaIFfAKFtq7va
	aiPsizXLnltvXto+iVVlcb8IuHcL2r1llMguab09Q5Od7gFO1sFRCnae5fpvHYA==
X-Gm-Gg: ASbGncuT1KX3W8Gl41rhElIVvR+D9E/kLGbPo7CiYkNhFlmOBBfjpV26LneJO2yURh6
	gVq9lmwicTgGlIaw8Cd8xoz/S0+ESEyU6Jz13PTNqeaVLFO5aiMG7I5ZwRONKjQJ9lxuM/S4MFB
	NoBb6tYeMU362IMO4w1NMKzkfgmareAh0d1wnJyIKwNBkwpXuyuuVjRWQyvLcEq6DHWVVuh8XQS
	BSKG511vjU2Yz1DQQhrHhctaBhLF1RtUW85FOKqo4/va96uUvoF9glLT4YPtlgVyh0K5q7gDL3r
	8TaYUVYj/3QfA7HhwKnsRwyvWdWXzTzkFBAl/RmUcBs3F1r30enbc8a77CzRxUEpGFjM4UuSMkg
	=
X-Received: by 2002:a05:6000:1a86:b0:382:5112:562f with SMTP id ffacd0b85a97d-38260b50796mr2217510f8f.11.1732273924931;
        Fri, 22 Nov 2024 03:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkQWu625fiETX7HZO+ArulzhRC5BBLI7GAYkG7xBhmNZuo2qmJjNBMwwRh/GGPPVaOaWuXeg==
X-Received: by 2002:a05:6000:1a86:b0:382:5112:562f with SMTP id ffacd0b85a97d-38260b50796mr2217486f8f.11.1732273924583;
        Fri, 22 Nov 2024 03:12:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2609csm2131053f8f.44.2024.11.22.03.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:12:04 -0800 (PST)
Message-ID: <f196bce3-585f-47ab-8937-8d9e71f40c4d@redhat.com>
Date: Fri, 22 Nov 2024 12:12:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: tmpfs: update the huge folios policy for tmpfs and
 shmem fix
To: Barry Song <21cnbao@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, da.gomez@samsung.com, hughd@google.com,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com, wangkefeng.wang@huawei.com, willy@infradead.org
References: <c6a2085278292be8ccc24635ad75b0a59f3cd7dd.1731397290.git.baolin.wang@linux.alibaba.com>
 <45509f49416849e6708a4fd57c988b8b0921210a.1731480582.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xvkcB6_g+RENBZ-G8aY7HZ4bdVGVgs2f8H7PSACtJrBw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xvkcB6_g+RENBZ-G8aY7HZ4bdVGVgs2f8H7PSACtJrBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.11.24 22:35, Barry Song wrote:
> On Wed, Nov 13, 2024 at 7:57 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Drop 'fadvise()' from the doc, since fadvise() has no HUGEPAGE advise
>> currently.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> 
> I couldn’t find any mention of HUGEPAGE in fadvise() either.
> 
> FADV_NORMAL
> FADV_RANDOM
> FADV_SEQUENTIAL
> FADV_WILLNEED
> FADV_DONTNEED
> FADV_NOREUSE

Probably it was forward-looking, and that change never happened.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


