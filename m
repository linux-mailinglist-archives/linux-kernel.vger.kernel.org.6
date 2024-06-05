Return-Path: <linux-kernel+bounces-201729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1998FC243
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3781C226D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1660263;
	Wed,  5 Jun 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es9xhEq2"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B8637
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559190; cv=none; b=tX6wv5A4xYXEtSqcUDY4j6CDy/2q8FI2RPfUTa6erKycPaezT8usuBCiXzv7AsDT4Ffu6UwMcgALjDupat73Q1ncykR0FXhXU2jcjsqPG+e6rEppI7VFDPnXZizBBTo8RxtgqgfUjzcrM21zx3LoU0avrtUaSRvx3efiqFqTDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559190; c=relaxed/simple;
	bh=wx+Kh6eLoQ9vsFrEneKngSlDo6F2I6E2/rmFJTF8Ob0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SdcvfFvnh7IwxUFE+p/ErgrHOrFUHIu4NR2AANFpX5yvfivg9XsDHlFNPt8Y1s3T4D9ZyXOfDGl5q7FeJG+k1XekFJNcJcI6Aj5IG6fr43pTI88tRqnFegKWHfYJGgr+/ngzsXz0OOaoVE75oozhuCEIVloFIUYiuzqiUy1JVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es9xhEq2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-701ae8698d8so4760716b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 20:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717559189; x=1718163989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PX60psgZsJq8f8a6q8y+eYps4ToV1E7xz8xso3US6o0=;
        b=Es9xhEq2d2f3JI6ALvt/FGBc1/ilP9oq0vAADLIg0K1aEnG3991Hbv+tHjGqRXBMPw
         WsA8ANQQDhEDt/PeaBYw3jXu/Zm+XV/GpwIoiZcAuhFcGVFsKnw7Yiem1m41m+gZdUrP
         ZdDURG5s/2duV70vxn/qYNOMg7jja9K9mdEHo83M9gyZrbVB8w6hT/J+ds+/c2zL+zV8
         3B0ZzVWwSk1nNz55qM638G2L3J585r/QYwdflX279j0X2VHBjDFtvnzbTD4ZkXzCNnCP
         7JO7rbhSXyHo7p5HH9ekXicu4UIn2haJseddR8jcog72Qtvs/mGVoprw6zYJ3GTG0eLP
         g1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717559189; x=1718163989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX60psgZsJq8f8a6q8y+eYps4ToV1E7xz8xso3US6o0=;
        b=lOy1B6BOWqt079kgnkLHk/8ic1sAXz2YTzxcWkvX17JVexVysNYHLY2GKBaeY4Lmvg
         w9t8CuxXSjek0yQiXFRToWeJlYDTQe3bOCo2Xbyq3kpYUUiY6vvifOnQwgMsH1jYN5Ur
         2SSM7V5fuW0gAnm0zw8xZsTGOLcNuEJHJ1Ztr7WXXHW/lUqYG+oJSWN6KHjTDLHsCoIJ
         oPpkCrT7NlbnXmwqUeos3brpSDRzwU0WBX5SzL5e1NLXBd3wNGqcnusJaVBrPnmD8Crc
         BWWAd0wjOSWWDnWSsT3ssFTvz4eiN5n69HZY2wcDOlUgGDE3SzH/2FzL0enUbSqBJNon
         eSXA==
X-Forwarded-Encrypted: i=1; AJvYcCWHoZ/zWDKRv7NSJTu2BDqVg2LmmqQquXeg0LAbicTrPX+fdwxy8xS6MZYTjCIMpgi2KPPC+MMeOc9nqbjjtQPybEqDm+mtTEKnY1x3
X-Gm-Message-State: AOJu0Yz2VoLC+JKy19FUNaNpOypOR+Qa/fCgo0eHaiAxRkmTY/uTJf7G
	MhFVrZad9lYlvmJ/McTgV9bLGvI0ZBwREGXfriA5CeQk2IrKaUTB
X-Google-Smtp-Source: AGHT+IFrWYR4dmEbB8SzW2qSluedSo2HfnH9zcP2BEozUSBwlRpjP7meKVaGNZmd98HHG+I50vq1og==
X-Received: by 2002:a05:6a00:4b14:b0:6f8:e442:a28a with SMTP id d2e1a72fcca58-703e59e479bmr1436573b3a.21.1717559188603;
        Tue, 04 Jun 2024 20:46:28 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423e0132sm7755792b3a.67.2024.06.04.20.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 20:46:28 -0700 (PDT)
Message-ID: <b86b27dd-b500-4e32-8edd-179e0006836e@gmail.com>
Date: Wed, 5 Jun 2024 11:46:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] use folio in ksm
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <9bc7eb69-47a7-4565-8672-636273967dc3@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <9bc7eb69-47a7-4565-8672-636273967dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 9:28 PM, David Hildenbrand wrote:
> On 04.06.24 06:24, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> This is the 2nd part to use folio in ksm, it saves 82kbytes in ksm.o and
>> passed all ksm testcases in kselftest.
>>
>> KSM still split same folios to single page if they are good to be KSM,
>> but will skip the rest subpage checking if a folio couldn't suit for
>> ksm.
>>
>> Alex Shi (tencent) (10):
>>    mm/ksm: reduce the flush action for ksm merging page
>>    mm/ksm: skip subpages of compound pages
>>    mm/ksm: use folio in try_to_merge_one_page
>>    mm/ksm: add identical_folio func
>>    mm/ksm: use folio in stable_tree_search
>>    mm/ksm: remove page_stable_node
>>    mm/ksm: use folio in unstable_tree_search_insert
>>    mm/ksm: use folio in try_to_merge_xx serie funcs
>>    mm/ksm: calc_checksum for folio
>>    m/ksm: use folio in ksm scan path
> 
> I skimmed over most patches, but I'm afraid you introduce quite some subtle problems.
> 
> Part of the rework should not be do convert things to folios that really operate on pages (of possibly large folios).
> 
> We really have to be careful about pages vs. folios before we have KSM folios. Only then, we know that we have small folios only.
> 

Thanks a lot for your reviewing and comments. Let's if we'd do it better with your comments! :)

Thanks
Alex

