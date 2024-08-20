Return-Path: <linux-kernel+bounces-293721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D620195839D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950D1288768
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0EF18CBEA;
	Tue, 20 Aug 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmfj+oZ6"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1318E37C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148405; cv=none; b=phYzrtojqykPmHTremKGT+AMXXGQrp1z/LIXdZaMxi/HiAVDKkDFkL6/InNzuA2qYZ0UtKtQ3/qjOU3IKUfHs0x4N9vimvD3uquI+ew4Y67m79Yj/8ovEMASLNn8tSpc5BRZ4HYpfyULJimKF9j6cSwJHfrAW23YVYGtsjB5JAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148405; c=relaxed/simple;
	bh=JUr70QEmTFFx9tlSrDy7lTKbTZeGSA1cMd3/UZTZzK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7h+nZYBgBdNuCOSGHniM/rWWr1D04fw9pBqANnqt667mE+D6xD+iX3nJY5n9y3RbiGNL2ydd+16pTm+o3072gV638p9aIlKhQqSFmNvb+Y6BV9b9luSb9+Wd+A/wuBSsMmv1Qh6J7PuvhaR8fOWhQMzodlp3bs3mXChQriU5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmfj+oZ6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3e1081804so3467287a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724148403; x=1724753203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dT3naxXzpX+hovDe3WRsxAFnWg41LZ8s9Rrc3hrzTd0=;
        b=Fmfj+oZ6z2MAQYI9jnvfK9MHKz1LJSgKBUflt3gfWD/t4qQ2wXZTz0oSvS4rcFiX3M
         dnbFPn3yfnER+dKg8KEtNnbZ84h3jvMtX8SMLceDOPNVRzNeTntRmbkY4Ev64jhkadjh
         +BrnupQb7zXHPizWb9P096M+Q3eQywLCH1HBlwy2Lu1sI3XCm3NhYxhhQHx2r+G2UIXZ
         mhi5aqoOWVNgbrD+JYFjMqfa4KHaoRn4kiRctfDkHYbNxXVUFyW6TwPVjNAIPogZoxjz
         gHU0ctZp2i5Z4yKdedC6eb+rPwrfs4PAJrmsWXA0BDBX7jkQi0Oq8vsYsPWI39TFSTyf
         Sbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148403; x=1724753203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dT3naxXzpX+hovDe3WRsxAFnWg41LZ8s9Rrc3hrzTd0=;
        b=VvV1/KzJ3hpTxAj9wIMUBQYgrbdhq7w9oh2Rpn7FF9SptG3w0c9YsYd1dhgselFlIC
         /2D/a+0EXSxF0s2jWDkLfDfr7vqy3r/uHKoNWfqIHplMYxZaaxPufGhZk+wqIWqmFXWq
         urvIDD6nIj8kb1yUgSInBEsEC1WM7Lh3Adp7tXg77ZpWkqXikBwImbbvkDiUnIZXGpg3
         5maPFAX4dFNvJbMR/M8IGeXiFyA9u2F+fqRCHszCNykZFr+f6qRZPife30xrmNWkYMzz
         GoqvmdlsKHvgEw9gD7x9s336HqNjLp7RWZYSBESprZ8wSojoWXrh2HYssjw5QRFXMdTJ
         OAjw==
X-Gm-Message-State: AOJu0YzT4D2lg8XZmuF/R7J35Axl8u3yQ91kYi7qyhU8lpqCyWjYoPPp
	7iwK1UlBn3YAs9qERyEBT+fniAdXPDAcsQynLtgX+gyGdLKJckt7i7sIOQ==
X-Google-Smtp-Source: AGHT+IGJ2TEhCeQ4T6stmHuMptTexASfuExA2FNFId6sOB+IUIEs5Twh28uzGFa3MpzDMsWieKEUpw==
X-Received: by 2002:a05:6a20:e608:b0:1c6:fad1:c20f with SMTP id adf61e73a8af0-1c904f742d4mr14595485637.5.1724148403270;
        Tue, 20 Aug 2024 03:06:43 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3c8839392sm10484679a91.56.2024.08.20.03.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:06:42 -0700 (PDT)
Message-ID: <f67df96a-206b-40ca-8d28-42715c907f64@gmail.com>
Date: Tue, 20 Aug 2024 18:06:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: skip less than check for MAX_NR_ZONES
To: Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org
Cc: open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20240819112628.372883-1-alexs@kernel.org>
 <20240819214055.978b33eae88004d35b9ce634@linux-foundation.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240819214055.978b33eae88004d35b9ce634@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 12:40 PM, Andrew Morton wrote:
> On Mon, 19 Aug 2024 19:26:28 +0800 alexs@kernel.org wrote:
> 
>> From: Alex Shi <alexs@kernel.org>
>>
>> Remove unnecessary '<' check for ZONES_SHIFT assignment.
>>
>> ...
>>
>> --- a/include/linux/page-flags-layout.h
>> +++ b/include/linux/page-flags-layout.h
>> @@ -14,7 +14,7 @@
>>   */
>>  #if MAX_NR_ZONES < 2
>>  #define ZONES_SHIFT 0
>> -#elif MAX_NR_ZONES <= 2
>> +#elif MAX_NR_ZONES == 2
>>  #define ZONES_SHIFT 1
>>  #elif MAX_NR_ZONES <= 4
>>  #define ZONES_SHIFT 2
> 
> mmm, why.  I think it looks more logical (and certainly more
> consistent) the way things are now.
> 

Uh, then let's keep the current code if the logical looks better.

In fact, the logical is in preprocess, has nothing change in the final object file.

Thanks for comments!
 

