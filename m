Return-Path: <linux-kernel+bounces-333633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA197CBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D732F285AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5019F49D;
	Thu, 19 Sep 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TIkJRVU7"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41F19CD01
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760227; cv=none; b=kw27AyFnzp35uPHvq3U+JMIwSf1cKzgWUCg5jh9hT+q7F3WqVaI5M9QH5TvvkS/snK7Gm79uyqQLl11Whtdqd6Z5o3cVV4JPxDK6gbg+bowLg/3fSYP19C+EMWd6CJ0Cm5j2Z5z1pslToOxoIOHVKlEMlMuY+2zZLAMmwMSx1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760227; c=relaxed/simple;
	bh=YYLtJpBM6YAItg6khmzBuREZLtA5kmVCxAx3WUuW4Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuYIzgE3+5Mm8G9gcPuuyL+E+4KceiU/u/psxw69nibyTYBZZe1K65xLYNJZgvo5wOLeLHcH7wcrzv1HC6+q+/RR8j3Yybk6g8hyDBml/hgqprAUaGZeaFJcFgeQnlTq+MsLbMg2jjiqYhbhsHjOq4OcRpsUHtgtE/TRlQIb/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TIkJRVU7; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso55214439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726760224; x=1727365024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qr9CFL6+Oph0ffMGoCXsVCaiSQKS0JdtRc9XXB0JbJg=;
        b=TIkJRVU7Y7gDjOmhIZMrvpOaC2WNbr1e+F7CRvMLJZ3qaJKzaPROrf/23CewhHsjPy
         X7LqcP+xtIAKaKiSkfngcDKQNQykvlIjoAXprcq+Py7nnO6qVK6FE3imn2ZSI4wLPEBm
         huVkeFIowEe6uyZFFAY6/GVf/0oKXNUGXvKNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726760224; x=1727365024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qr9CFL6+Oph0ffMGoCXsVCaiSQKS0JdtRc9XXB0JbJg=;
        b=Vpjc98ruxDdcmOX+QNERIFLCcQdN0JbqaFqtoCgpBhz64dMKeEH2kbLF+licD47kHm
         0OMuXdJwKM8u6cvjHmvv4AzdbkS3To3/BExA+ySA9qMj7nEn0aZaFWSoLITTcZ8jPO5R
         DVKkkwhoYZGpxTMsryR2WNYDKkEvdV+FRaY+I6vAE0ZRjgIH8/zKy+4k1rTevcvQvwST
         faYKsjYJbZe21lHcVT1uowmMxGRviqw8AKuGXIe+u/iDquthlsjlaf5YHmZHBpSxdTOk
         EyJ2Pz5oWbHNvMQYFk9C6M/ECdqgVM+WRm0b0LkWUMwKg36wGsU4xxzyzjjie2HpHx/C
         CYuQ==
X-Gm-Message-State: AOJu0YzheMm5+3njXnYkXnjP4ybIq0UytjfSK992pkxw2aSkvKj2h/xG
	tY+TzpurF4DXnUCLG6E1EaQqTEee/WFFLp8NB+vl0CHlUDCJYARlCKIbxGzICq8=
X-Google-Smtp-Source: AGHT+IHxAxPUAawM0ZALbnCA7+8vHIBZzxx0rPjHoGnk2o8G+KXuP0F/zG2tdHt6cXT25xmuCv8ECQ==
X-Received: by 2002:a05:6602:2dc5:b0:82c:eb18:ea53 with SMTP id ca18e2360f4ac-82d1faa20d7mr2739091139f.16.1726760223846;
        Thu, 19 Sep 2024 08:37:03 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf484asm3088178173.33.2024.09.19.08.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:37:03 -0700 (PDT)
Message-ID: <f229fbad-731c-4dd4-8c66-ff8829c2c958@linuxfoundation.org>
Date: Thu, 19 Sep 2024 09:37:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: support DT_GNU_HASH
To: Fangrui Song <maskray@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240915064944.2044066-1-maskray@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240915064944.2044066-1-maskray@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/24 00:49, Fangrui Song wrote:
> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
> obsoleted for more than one decade in many Linux distributions.
> 
> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
> 
> Signed-off-by: Fangrui Song <maskray@google.com>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> --
> Changes from v1:
> * fix style of a multi-line comment. ignore false positive suggestions from checkpath.pl: `ELF(Word) *`
> ---
>   tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++------
>   1 file changed, 79 insertions(+), 26 deletions(-)
> 

Quick note that this will be picked up after the merge window closes.

thanks,
-- Shuah


