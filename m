Return-Path: <linux-kernel+bounces-208348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B972F9023CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC72E1C21462
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F39824BB;
	Mon, 10 Jun 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eklAzWs6"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4284D2A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028879; cv=none; b=fvL1VvZi7k3bGGQf6hmucaSa07xr9Vj/r5FSKkJuX/714yg702Fs4SZFBn3hwb21RjGm0m73ZbZbTXXYdEy1YiGThOvLEXAm95aEKDc+Xq8RhUo8XxxJJOhlGD7YjwSKwAvUr3jUXU7gVtEw/vY2p3yEyH44BSE/tjOT2TDLjZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028879; c=relaxed/simple;
	bh=iSnVyc5rIKp9U9gURqLfc2X2iPJya+QsFKOAdHSHUeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMv/mpziPbeoSj9mRnH2S2jg+jGgl1Jdve5+vJtTuzTwQihhw4tYpLVHzniTdXelIXlnJkgm0Gab7Dq9X3YfRTGJKpPVfpBniJ+37bhvzea1SYexgXS9pvZxJ0Klq5eHLRtgLa9yllvEr68SRHZ/vsi0HKGc08HSULOfHQKRDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eklAzWs6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eabd22d441so71763241fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718028876; x=1718633676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otgxqPSAJXSRGAj15fYyDevd0a/nXgqK0lL4xZTmNjM=;
        b=eklAzWs6HL40gNpemT+C+YUN+LM6R46G3jUKb574XWFs6i9g/WYFEh+Behqaw9oSUE
         mGdk3TOeceHP+8iN2D7V6BBkdIpGwHdtUumwhzTrNlDzgrSryqP7ZLuN/0703ZkGGPoq
         iScG7KMyQPTiFY4CiX6yQFD4BN6tZLRjGDlKsdpV2KtlSgUUjrXmInNVXLZfcwJduHr+
         EIU+7AZMPGdld0BcmNi3xxSP5+KNruqBcYUYPtt0YgOPZ6quSHwU6xJBV4w2TY4Ldv+8
         J8sW2XH9gOanfkVOseq7rUOtg+qnAh3r+LFHUvASsOnQybndj4UAQWE1auL8TDErH27/
         ykYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028876; x=1718633676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otgxqPSAJXSRGAj15fYyDevd0a/nXgqK0lL4xZTmNjM=;
        b=wQxSggwQlV2fT5ZELaPlJxSZD18PBAiYFAD4bxj3mhWcwR0tOg53akSymDgj/4QlX0
         DFtRa7nb4dJnf5rfRalPhaAgp2lHoD+V0FL3cxwOvqf2NZtQ4YLnsoqF/p5L5fXPtI0u
         j8AycTOMAaqoMEGGNv6ZeMAH4hG46oLPmSUb35PoPpahgmZTsXHk6YgG3E1mlVhjRX5v
         /0iT4tGS2jNQPdm8zqKMfL9+moW3rTXZcX9gm4BM/jf+LiVnYKJmCEy/rXJr5yxug3s7
         NcNRm9Q4IlzUkOjZ/fqiLCSf0bjyrLIuTQbMIShV0nOcLxJLdVnMrHFsHtPgggAU1xlX
         VLag==
X-Forwarded-Encrypted: i=1; AJvYcCUsaFId9pVL3+TtZTbdnLTnQCl8WxFgcGxGgZCzLZR9WdR7s6Di10LYQHGS3POKluQRoc6ag3FPOHf0NHxRofaqcKLW4w8G1b5CHGM4
X-Gm-Message-State: AOJu0Yxx1EWONBtZVYuGmOQYa170tEU34G5l6zTMB/zc1qtVHAiO46ui
	Bak2eKAHDOBklFs1W8Ja58XgVerDxDJ5H5tsPtlNtWjM7445+rKG
X-Google-Smtp-Source: AGHT+IGgbfdPUdapCE4c6qvjFTT17cbQeOyfvRh2FapDiAmnGcnDYYFEqEcHG2m+PPHIPzPo2C9z1w==
X-Received: by 2002:a05:6512:b1c:b0:52c:80fb:ee76 with SMTP id 2adb3069b0e04-52c80fbef32mr5558127e87.58.1718028875838;
        Mon, 10 Jun 2024 07:14:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:493])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0e450681sm308036466b.139.2024.06.10.07.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:14:35 -0700 (PDT)
Message-ID: <2d52b1a5-4c44-4cea-bccf-57972ca79f04@gmail.com>
Date: Mon, 10 Jun 2024 15:14:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Matthew Wilcox <willy@infradead.org>, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com
Cc: akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
 hughd@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <Zmb6r6vrP2UTDQrK@casper.infradead.org>
 <acb76cdb-a54e-48e0-ba18-a2272d84f0ab@gmail.com>
 <ZmcITDhdBzUGEHuY@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ZmcITDhdBzUGEHuY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/06/2024 15:06, Matthew Wilcox wrote:
> On Mon, Jun 10, 2024 at 02:56:09PM +0100, Usama Arif wrote:
>> I am guessing what you are suggesting is just do this?
>>
>>      if (is_folio_zero_filled(folio)) {
>>          swap_zeromap_folio_set(folio);
>>          folio_unlock(folio);
>>          return 0;
>>      }
> Right.

Thanks! Will change to this in the next revision.

>> If we have zswap enabled, the zero filled pages (infact any page that is
>> compressed), will be saved in zswap_entry and NR_WRITTEN will be wrongly
>> incremented. So the behaviour for NR_WRITTEN does not change in this patch
>> when encountering zero pages with zswap enabled (even if its wrong).
> We should fiz zswap too.
>
Will send the below diff as a separate patch for zswap:

diff --git a/mm/page_io.c b/mm/page_io.c index 
2cac1e11fb85..82796b9f08c7 100644 --- a/mm/page_io.c +++ b/mm/page_io.c 
@@ -281,9 +281,7 @@ int swap_writepage(struct page *page, struct 
writeback_control *wbc) } swap_zeromap_folio_clear(folio); if 
(zswap_store(folio)) { - folio_start_writeback(folio); 
folio_unlock(folio); - folio_end_writeback(folio); return 0; }


