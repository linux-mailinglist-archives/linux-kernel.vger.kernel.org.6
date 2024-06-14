Return-Path: <linux-kernel+bounces-214744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6B908976
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B128A665
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48219306F;
	Fri, 14 Jun 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g2DAhynd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC1144D38
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360141; cv=none; b=akG0UAC8OSFMQ67MDK9vHLFsq+LeVUGIbhBIMQn/9iC314clMrS4pvDX+OaPoyN3V8YdD+Vw6Mad8na63/8VKHMmfhPOXPodZcVQw/evavDqPQR9od5X1Os1yFJucxGNtRg/L22IzOO6t2QcAJjIbGmJzubPuXoY7zEQwPLuIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360141; c=relaxed/simple;
	bh=H95pmbNj0ML+Fnqx6V2x2Ozfv9WQFP0tjgrUogpJDl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVL7tRlXVGq7W/U2Qw6jXTgN3jIepZM+uzYMP/89bMrvub9WonZyXivrWJv5zSP2FA77QTVZs50C2/ZL0G646n1rjytGJba0ai9uXahGDFCJ20Hmw81QQoEq/7Kv8x7StMb17CxarZm/HiUl3RcggBUHx1VAT7KDZRnLl8pFgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g2DAhynd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f1e35156cso1915133f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718360137; x=1718964937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnY/+74tWYlZxEsSqL+HDQLdC8+fmHiAEMhvpD2qAiQ=;
        b=g2DAhyndYiZtuDQl/T0+oQUq1E+q7WLi3BIgSm0rvcMMdvJZj+y2qcI9OxPLLPZlnH
         x6u1RLTFErfQMFu5iWPdVDlz39e7TGvT9/9ArkDCubBoNWscv/X7Uh9B0xcBwDAtoN5T
         FrSZCs0QjjrITb0gwAAK7/aLTbUwBOFBpltTtXE8vaGpj+Q+SaHkSsm9e1CCDqJxksyI
         LMId9Q+c8rCBbOx7NLcw6A044DrKo+9kX1fGWGexffCQTBor8+VFGPyFTT2p97Dkloes
         rKsRSWLPgVe2Kh7IEVyRqOHQoeA4UWxpWpDvVCDCwIpH8AAPvMPzFaVaenpF7qzwAR4q
         K8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718360137; x=1718964937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnY/+74tWYlZxEsSqL+HDQLdC8+fmHiAEMhvpD2qAiQ=;
        b=e6LsdMg2uao+PhFurzQOrQ17r6DHWIN9MtH64PJ4RnFiQtyuunoARr86INIckqi+rQ
         BIffxmOi+eQ7B5ily6RH4gJJTn0Mfber++IM1Qg7gJW4xPVtPvjRk7lvXghpUyMkxKqx
         lDQ3AjDBMHeE98Qe0xUPlsj/R0PK/ANkzyMDKklu9aahNEcdJV7FhCm/Zy0ZO8EKmaif
         suGg/IJzvob/hJUuB6CMITvIz0CejPn3Ko7MG6gulfe2Mv2YssKp2U+lw4bU/G4uSTFa
         +bTJr+2Lp98PRiB8IME9u/4uq0rF5WwLYrBUaOP92JtdO+Rny6/52kklMg0Chr8nbIoc
         cWdg==
X-Gm-Message-State: AOJu0YyoDvtzkj95UG+3Uxine7qvNqQsd17nrLTXiKdbxR7kxB797g0h
	YW6TU7Kupmk3MK7HKLO87W7r1Ohz1Ucjda7eYeDZwaUYnw42bmPqTjGyF19T8E0=
X-Google-Smtp-Source: AGHT+IGIvQCmkwnaeXjLDSm++FQaHtPzQYPDkTGLsPH1o0VHg9LXBUm8rlKViWgfL6ZmPCd/p5fi1Q==
X-Received: by 2002:a5d:5917:0:b0:35f:296c:27b2 with SMTP id ffacd0b85a97d-3607a7b6255mr1639807f8f.22.1718360137566;
        Fri, 14 Jun 2024 03:15:37 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c7e5sm4012447f8f.30.2024.06.14.03.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 03:15:37 -0700 (PDT)
Message-ID: <98af49ab-2d82-4ced-ad95-2a6fb24f3a83@suse.com>
Date: Fri, 14 Jun 2024 13:15:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Remove "mfgpt_irq=" from the
 kernel-parameters.txt file
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240614090306.561464-1-thuth@redhat.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240614090306.561464-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.06.24 г. 12:03 ч., Thomas Huth wrote:
> The kernel parameter mfgpt_irq has been removed in 2009 already in the
> commit c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code").
> Time to remove it from the documentation now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

