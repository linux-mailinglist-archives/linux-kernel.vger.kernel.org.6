Return-Path: <linux-kernel+bounces-310152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78809967596
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE27B2128B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990A149C6E;
	Sun,  1 Sep 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxXn62r1"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F01494D7
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725179772; cv=none; b=oW1ZWLettQlO7sym8dWjn+3eiesRz5QJQCWGYvNb7EvWX0s+bF5ScLCkkbdwypiPEQKXCyB6Ov+OGWEB4HAc75VS0pz1T8Oz0lyh6Fmlmc3B9uiFEPBG0NQokMBaGjBhNdyXfJejzBkMbhQzJOd+oEHamNVM+6JzdMaN0hi+gVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725179772; c=relaxed/simple;
	bh=QbBEdKifS2tOI33APgnmB2ZcsdBfFO56TLOize1XCwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4L43RL7PYllviIEMFI0IBuqqkUAIaVavFhDbOV2tYalbRf0Bnm4W3JvGRr8pAcbPO1bAIrgcYd1vTey83pdTT86o6QPVrjLlba9C+wc4eCb3gMv519rbK4EZ8O5lbbR/48YzK0HpDrUBC6Utzyp0Lj7rW/+zRlwPftaFnaVm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxXn62r1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714302e7285so2967556b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725179770; x=1725784570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Azs5s4P25m/mANSWWi6d6fQJ0c1WDqmoYZPZDMGlZO4=;
        b=SxXn62r19uvJU5PnX4fUryP/7+nLFgKxgblC/JHnWk7t+ZcnfykgPCDU8adymM78St
         HxviuzNvkHreoQrEML3cVkANq95puXUSaVug+jKS/t1vYm4rptm/fgmJFxtxmE4Mril9
         2xT2KlxQTmwLW8DI31PQucgMlTzphSj3bVX0ncxrC/bpDwojfJ9IRJpwi3xne2KUr3UX
         k04sCsl0P2gSRJ8F/g1M4cV7rNASqcAJ7YCIx+8/kxgAAtmASglA5GI0tL6Dc+76W5MA
         8dq+waoI70m6wgQfELmvJG8Xq7idhiMn/wtFpXNz3uzSI0iyqA2Ak0pN7aTItnVoEs0J
         dpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725179770; x=1725784570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azs5s4P25m/mANSWWi6d6fQJ0c1WDqmoYZPZDMGlZO4=;
        b=ZfiG/pmZ+sSn+hXgtNvm7NJ2Kq330kuCAb9b8rbBh8sxA8ruSuDW32WIJ/5rwFOmT/
         hH0ZV0UxKK/mir+B5ZArFT/ECRLI+AYtqv7dLgiH0KeX/7Ig92Pi412u0prMFIwYTyYu
         U8jIa8CrMQre4/EM+YnQP+C+/9lc+9Cs3yyQQNan5sMhIaXhp+2i8Vk7hrENCOBZQUbC
         DfekEv+XlHGlABumnfpbJZU+zf/VUeEKft/YlyNhnBSZzkuB1dFKsbbmvz2hr2RXNPPD
         WbOXHikyQs83ZKcCjcLOQ6AlgVQdjylLfYhQ57BTD/sJ73An/VPDhnpuBLk29nHYwQB8
         987Q==
X-Forwarded-Encrypted: i=1; AJvYcCV634LwRd48ArFhnBB/Pjm3ySiPVfk13w0dZYHYSHaY/vk69heFAF1IbUedaxX4P4snIYMaFLT34Wr9z9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJEFVNWQmqbouZ444hsi/hi/tto0DLRKB8eBLoRuZ8goTETcu
	VwCGGCaawaPDCAewBqLTodxf7Gblnl9gPDvVOPwYtDPt2ZHqGh+W
X-Google-Smtp-Source: AGHT+IFCabq3SaDSGwkEcIuRRxq+D+GB2U4aejlXDGAtojy5j031ba9+t5HzVNjZ5pxACQXwGMY+Fg==
X-Received: by 2002:a05:6a00:9165:b0:705:6a0a:de14 with SMTP id d2e1a72fcca58-715dfbab54amr10851686b3a.1.1725179770112;
        Sun, 01 Sep 2024 01:36:10 -0700 (PDT)
Received: from [192.168.79.9] ([49.207.51.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b9d11sm5248804b3a.90.2024.09.01.01.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 01:36:09 -0700 (PDT)
Message-ID: <16d3e588-b092-47ff-99e2-ec943524d2d2@gmail.com>
Date: Sun, 1 Sep 2024 14:06:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828204552.26790-2-masingh.linux@gmail.com>
 <607b86cd-d89a-4072-af36-ce2ce5c1f7fe@gmail.com>
 <daecc634-4faf-4dcb-b03b-f57f24673a88@stanley.mountain>
 <01183b3b-b8af-4451-8b52-e7acd0b4a9a5@gmail.com>
 <497fbcd8-2984-4be5-b877-1dec6a8d7bba@stanley.mountain>
Content-Language: en-US
From: Manisha Singh <masingh.linux@gmail.com>
In-Reply-To: <497fbcd8-2984-4be5-b877-1dec6a8d7bba@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan and Phillip,

Thank you so much for your guidance; I really appreciate it, especially 
as i am new to kernel development. I will make sure to consider all your 
suggestions in the future.

I apologize for the delayed response.

Thanks again,
Manisha

On 8/30/24 01:04, Dan Carpenter wrote:
> No no.  The v3 is also fine.  Let's not stress too much about minor things.
>
> regards,
> dan carpenter
>

