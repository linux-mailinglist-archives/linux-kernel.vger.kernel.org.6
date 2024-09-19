Return-Path: <linux-kernel+bounces-333658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84C97CBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F96C2854F4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B021A00D4;
	Thu, 19 Sep 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nbn3ddoZ"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26519E7F7
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761717; cv=none; b=Y4IPt94Bwjmi7JH+tAyoew0BkGgxHo84EpcBgO+iapftdjXD2DyPEsavyGYzfFNc/E3G0eidah+BQ77eWWvxzcqLeb1oG7rPwRcBln0di4aN9Oy5YcWYMwVA8ouM/cz9aRkvopKIlion+tZeBF2NRyD36csQtNtAQRZdcV7U1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761717; c=relaxed/simple;
	bh=cpJFeFr3Q9I7szQagFKASX5ieMYKw9TQeZYUEZA6+Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvLOIrYg+NyoxTHWMDLe4D9PPtPzHPNVmC+pF9lb8GJ+x7iXZuuoJ/U64yKHWqgyhlLQ5bG3rFipI5LCDU62aXmDVQ3vCbZc61Bd1CiuAVtvGRYqrKfR/PduUNFjQ8uBlKGo1aLD9NLi4HkS47AMHbEIjj3nKlNX6UMXf2nl+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nbn3ddoZ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a08c907245so3914235ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726761714; x=1727366514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hf+LsicU5kfxn2tpKhkFH/ZcN5QJYed0eVtFtXBM19w=;
        b=Nbn3ddoZzzBKImVr8EDmyVp1pcNrFBcLG9bIi5PEFTlfc5RhuUxLVbTN3Ew0d9uNVO
         JfEvHsD2PWZpzyp86lAxiLbduWFVI07hMLOBomYFDXPX5aQodGBC3u9ipYLxJTuWY+Nr
         NIc6M9+AdH7kvzvruHbSLVY+R2I9l9qeJrTKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761714; x=1727366514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf+LsicU5kfxn2tpKhkFH/ZcN5QJYed0eVtFtXBM19w=;
        b=fMxM6JtigcUxAEaUslNNa2evADf18i/jHM6i1WLPKZ6C5GmmXfmUJBpWa+W5GlQ/uT
         JhvBCFURKbH2KqswHdcujwHFknCvYLx52nokxaaVP1cRWooPp7k9k5xxIRUj1zgxnIDr
         B7yPY1VOroOUySAFl+GFQmHcPyQ8nBUiCVMpaFq/lS9NxE1+yqmB5Bh+fwg2XzpoRnzG
         SAUcZFvXPCtgmjj0Br08ixbYHieQPtV2XZf3IDwRmgbFV8FVCsvgue0NvDNxkhV4m9c8
         GGq8YUyJKIhPtmf63mDGAgK3ExIPG1Gp0wRrOwSUxyHW4qovQMdqlUmj854xAOovcrbF
         RzFA==
X-Forwarded-Encrypted: i=1; AJvYcCW/6H5rvFde+GqzGpNP7/aF/BR6S61uRXjOjzFZSj+Fc6jhWo+39DWnQYswErvJqy6Y2TJQE/I9/v3bWGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2NbYZ8Ipu2T0BvxQWYxt2mLGcCxApP8DqHlGbAVrx7hGN1QV
	qdHUcSb2NPJrQV8uSrAAWmlBSKaLbaNA2Uw1fT1VVGob0fre3tMMtK8urVBAk2I=
X-Google-Smtp-Source: AGHT+IHfDnCPZjd75IkE+J/Gi3J6YMDrXBv/k81CP1ouQYZ6tsGogqyqq6qhv3icghhWDzOT2fHdPA==
X-Received: by 2002:a92:ca08:0:b0:3a0:92a4:a462 with SMTP id e9e14a558f8ab-3a092a4a67cmr184506265ab.10.1726761714157;
        Thu, 19 Sep 2024 09:01:54 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec17e9bsm3017456173.53.2024.09.19.09.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:01:53 -0700 (PDT)
Message-ID: <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
Date: Thu, 19 Sep 2024 10:01:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: Artur Alves <arturacb@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240917005116.304090-1-arturacb@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240917005116.304090-1-arturacb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/24 18:51, Artur Alves wrote:
> Hi all,
> 
> This is part of a hackathon organized by LKCAMP[1], focused on writing
> tests using KUnit. We reached out a while ago asking for advice on what
> would be a useful contribution[2] and ended up choosing data structures
> that did not yet have tests.
> 
> This patch adds tests for the llist data structure, defined in
> include/linux/llist.h, and is inspired by the KUnit tests for the doubly
> linked list in lib/list-test.c[3].
> 
> It is important to note that this patch depends on the patch referenced
> in [4], as it utilizes the newly created lib/tests/ subdirectory.
> 
> [1] https://lkcamp.dev/about/
> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
> [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
> [4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
> 
> ---
> Changes in v3:
>      - Resolved checkpatch warnings:
>          - Renamed tests for macros starting with 'for_each'

Shouldn't this a separate patch to make it easy to review?

>          - Removed link from commit message
>      - Replaced hardcoded constants with ENTRIES_SIZE

Shouldn't this a separate patch to make it easy to review?

>      - Updated initialization of llist_node array
>      - Fixed typos
>      - Update Kconfig.debug message for llist_kunit

Are these changes to existing code or warnings on your added code?
> 
> Changes in v2:
>      - Add MODULE_DESCRIPTION()
>      - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
>      - Change the license from "GPL v2" to "GPL"
> 
> Artur Alves (1):
>    lib/llist_kunit.c: add KUnit tests for llist
> 
>   lib/Kconfig.debug       |  11 ++
>   lib/tests/Makefile      |   1 +
>   lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 370 insertions(+)
>   create mode 100644 lib/tests/llist_kunit.c
> 

You are combining lot of changes in one single patch. Each change as a separate
patch will help reviewers.

Adding new test should be a separate patch.

- renaming as a separate patch

thanks,
-- Shuah

