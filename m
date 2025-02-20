Return-Path: <linux-kernel+bounces-524687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF2A3E5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42643189FC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC2221480E;
	Thu, 20 Feb 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZkozQZe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687B1F03D2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082999; cv=none; b=sgrgFVX3ZTSq5Z5NOvCzQ4y+VeHT71JE8QuLQ8U9Op026ErbhpanUIAT2V+sRwzpKj976rS+sZEWeLOTmJznU3tsly8JMKeoDpBO42WLZGMn98dp2TDvmjIgvo8I4a7We3CasY5Yf4gB7fwd5ZWMq7rSLIIxTqn4dSMnMzaKNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082999; c=relaxed/simple;
	bh=Tn3ltmrCxawUI1Yst4yWhjhBTDRLbuvLwKeLfTVzezs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlcDy6FOMLjyCqb0uC5kDAMZMq0N6ngIgDqgxknWIVBYYvTGXKznmjV5q3BeYaD6e+J1Ad/28VfywgNJ0Gyy/p3YmDakShVPYiC52PjeN5CQ8l9SU/nqu7/qvj41K4RQyiMNvWd6khktQtIJMdMmXaBmWlxliIEGONADCL8wXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZkozQZe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740082996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+QcFCOh+Hoz1nFZL9FYZfySC7E2K87mswG47ZWAA04=;
	b=fZkozQZeGauXiG4PBpVW7+uHxCLIl538FSrDKDoeYlJVDVy+H08g+YEu17gg6qa8ZzvYLH
	+ZpaMcxFTP7syf2XgSRGOIY04gzuZtK8ZiXYLiBxPIKWQTZYYaxBmD70LAsTDaPzPrEyEk
	M8AuK04PAB/XFlFpkgYm67DInPT3WYQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-w2klRnGfP7aGcemkvAD24g-1; Thu, 20 Feb 2025 15:23:14 -0500
X-MC-Unique: w2klRnGfP7aGcemkvAD24g-1
X-Mimecast-MFC-AGG-ID: w2klRnGfP7aGcemkvAD24g_1740082994
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c09a206b3eso251345285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082994; x=1740687794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+QcFCOh+Hoz1nFZL9FYZfySC7E2K87mswG47ZWAA04=;
        b=amRdCe6Na77dfWp9YQzL0jMQBoC4dlmfLbMHCk2yDbtwkfyxZ9B2OUsQOaoRz87433
         yO8AsbDQZDwrw7ZSAUBkKOjDWkQ3wr8nUR7vv3PRiRsmcq94YPaGCMGUGuwtT0gu5cIu
         N42B0TGMEACZsFRoBIKugEkLAcvm4hkrfeEyGJ3jMJ5PgCWQfx3mg6vbr8W5wnrIHSdX
         sXkisB+gIwoSOxBeOUMNst1/3jKTMRdJBibW5/NPYCnCm7xLBUw+m4tA1eX3huHjekEk
         ZyWo6aq6n+jxpUlcmp4k6ktzzvCJe6gCmTdXiuQXEkWmU6gA5n15cwf3O305O+INUBat
         a77w==
X-Gm-Message-State: AOJu0YzcyW1hjHhVnV4oXq/+R/wNiuCDDa20sjIK/DqR3UeJAK8X0ytI
	GfrdEoGmLMA5UvPe+MvHIRT9orh0YmHHE4svF/WsxLwyQ1gmwat220gLN405pfbXyNq0YLz91qN
	EkZYrIeqy0fpyG0PDyUc5iTN27NfdrYykJSxzebNXb0ZPw24ouLgsKWtu+x2m8A==
X-Gm-Gg: ASbGncs28xjO5IBwScEvvXzmYrl8SzK+bsH8cZEtL5ubHyYwTs7mzAZHWw6wchwNxyn
	FTQyn9zcU9cvp1zMdFQXR8Qb21qVppV7SHGixYS0I2HfDsdbMtdEcsEwrrpkhTdhVfoxxjLcPWs
	hklQT4ej0wtToFWJAXcKzIV0ngJe6344H5VZbU8eY8UzLMtg+JhH2bFUwtn26v3nJpsauXYnQR6
	8nJpzNfSfKGWsxAaPI85aDthBrUcKXW3WMaM/2nNZTZhUoMUGtbcaaEAqlaLBmtaImgMPcR+PbL
	cCSM
X-Received: by 2002:a05:620a:28d2:b0:7c0:a3bd:a77d with SMTP id af79cd13be357-7c0cef66cbcmr84578885a.46.1740082994244;
        Thu, 20 Feb 2025 12:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuIPV5XAd2U9v202aThWE9PS+XWLBByNvESCnnAfFIfyuynmEXFSHb4tYWOlH590wsDkhAbg==
X-Received: by 2002:a05:620a:28d2:b0:7c0:a3bd:a77d with SMTP id af79cd13be357-7c0cef66cbcmr84575185a.46.1740082993852;
        Thu, 20 Feb 2025 12:23:13 -0800 (PST)
Received: from [192.168.2.110] ([70.52.22.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fdca4cefsm38651631cf.45.2025.02.20.12.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:23:13 -0800 (PST)
Message-ID: <fdc8fbb3-0d2f-4422-8437-078cb2ce1a9a@redhat.com>
Date: Thu, 20 Feb 2025 15:23:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: page_ext: Introduce new iteration API
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yuzhao@google.com,
 pasha.tatashin@soleen.com, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <20250219155212.9474b8c44bd58780a54c8a6e@linux-foundation.org>
 <b80a15a7-f9ce-49eb-b721-b59f20bd6fac@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <b80a15a7-f9ce-49eb-b721-b59f20bd6fac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-20 05:49, David Hildenbrand wrote:
> On 20.02.25 00:52, Andrew Morton wrote:
>> On Tue, 18 Feb 2025 21:17:46 -0500 Luiz Capitulino <luizcap@redhat.com> wrote:
>>
>>> To fix this, this series introduces a new iteration API for page extension
>>> objects. The API checks if the next page extension object can be retrieved
>>> from the current section or if it needs to look up for it in another
>>> section.
>>>
>>> ...
>>
>> A regression since 6.12, so we should backport the fix.
>>
>>> ...
>>>
>>>   include/linux/page_ext.h | 67 +++++++++++++++++++++++++++++++++++++---
>>>   mm/page_ext.c            | 48 ++++++++++++++++++++++++++++
>>>   mm/page_owner.c          | 61 +++++++++++++++++-------------------
>>>   mm/page_table_check.c    | 39 +++++++----------------
>>>   4 files changed, 152 insertions(+), 63 deletions(-)
>>
>> That's a lot to backport!
>>
>> Is there some quick-n-dirty fixup we can apply for the sake of -stable
>> kernels, then work on this long-term approach for future kernels?
> 
> I assume we could loop in reset_page_owner()/page_table_check_free()/set_page_owner()/page_table_check_alloc(). Not-so-nice for upstream, maybe good-enough for stable. Still nasty :)

I think Andrew wants to have the quick-n-dirty fix for upstream, so that
it's easier to backport to -stable. Then we work on this solution on top.

> OTOH, we don't really expect a lot of conflicts.

Yes, I was able to apply this series on top of 6.12.15 without conflicts.
Given that -stable does backport a lot of fixes anyways, I would push for
having this on -stable.

But just to answer the original question: I can't think of quick-n-dirty,
but I can think of easy-n-ugly:

  1. We could add a check for MAX_PAGE_ORDER for the first function in a
     call chain calling page_ext_next() (that is, bail out if > MAX_PAGE_ORDER)

  2. We could replace all page_ext_next() calls to a version of look_page_ext()
     that takes a PFN

But all these ideas have regression risk as well, so I don't see the advantage.


