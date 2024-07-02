Return-Path: <linux-kernel+bounces-238096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886F92436C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DA61F2498A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EC1BD039;
	Tue,  2 Jul 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ir52Gvz2"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C01B5838
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937116; cv=none; b=OpyjieNIJTS+qpvS2Eadn1YTkYGH91/nJm961+6doBnRFm8lZmQs36mKttat0XP/HwV2Tb1G6mlmGfWx+UodQBbSRqfffDMYJ3pvcGWn34rtuhW1Wov5mT7BfZbpq+eacw6YUnmqO5x6DS/ZR35k3C0DbxMyVTghxh2PQG+rkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937116; c=relaxed/simple;
	bh=AgE9FQGxGJLTJVWx55pmmSppZoMtGlA6Xq23h+emmxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2xGN3QYvoItROnMwXdRiqYT1vjwNbzP9ydxs8DehIdg3Y6acBQW6T5/QPMJ+Zf07wTFXaO/2QkzitYW0UZAriK2zmWhxapLFvNxpE06fOyGFLqhat6it4JLcwP2TQ9jfITUOSxovip+wZxQbk4zvK/gW0VgnJQmAtQ5fh8GU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ir52Gvz2; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f59854ace1so10305039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719937114; x=1720541914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f++KokYJIsMEcn6psVzWi3mhtO0eFnkLSGycni+7ewA=;
        b=Ir52Gvz2vnCk2m95LUZoeve/FIGcE1wNZ0PxZw4/SfC8couEJI4TMAsGg7ndIaelWZ
         iUDBe8Fnek95l7Z1w83wA15Ka/vodZXCtdBll2fMA8eSsr1zrRntHpYFlwHXT8tNQcuG
         eXMWI5NjZQvG6OOqXxCkmc3+H2Xdj7UZwCjjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719937114; x=1720541914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f++KokYJIsMEcn6psVzWi3mhtO0eFnkLSGycni+7ewA=;
        b=XAKiCip2KlsC2yaGmLd+wm7EsrSy3DoTdz8Xf6WIBewMK5G2ahg8xz6H6cCDAhoALu
         ay3ZU1evKBHaH20ZmFJHIbtdZ4hf9n7Akj5YECE6dqRO3f7ib5TjX9GfrYSI3VM0O049
         0Dgo/1vJRfubpnPBVs/3QnmwUwM5BrZn+c1hhj2eAc2JWteb01a+TFHm5y+MklJRFBCX
         VUCbwl23aaFw516RD1ACDKqqL9DqXVvjTgFdBv7R+4X2AR9RydSC0G9Xd8YUkh4fU7TX
         KBLdDxOXvq7NfO4xT7sElR5lmXeiaV8yiKKQVWvXL6dPE+1zqPFcvHkfAjHLZPtETLgV
         AW7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1EWbTyGcARm3a0t62yQy5gECizjA5+NjZfEfoeZDXe7zhiWVZHesblOnzLEarLg0oYteBVdBYMBQBos+zwWJtekOQBTvXh6hsP0yw
X-Gm-Message-State: AOJu0Yz3SSxsL3+eD3ibLMi+sr5TLJHl5FSE4x3TX/d8NmWiTlz3Di7m
	rEsWdQO80nAxKRjhMqwTYBkQp6t3gToDddubDICZVvpbEYONP0dpUA+nkGN712R+DsCgfLbgjjA
	J
X-Google-Smtp-Source: AGHT+IHZnMx5g9NW1e1RoZwZPcbUtmjlUGCxfhAaVxw/3os/XLw3MU5JXoUSSBLT0QRg8QjaO0HmOQ==
X-Received: by 2002:a05:6602:42c5:b0:7eb:69ec:43f2 with SMTP id ca18e2360f4ac-7f62ee5deaemr843037239f.1.1719937114541;
        Tue, 02 Jul 2024 09:18:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f90cebsm2845555173.93.2024.07.02.09.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:18:34 -0700 (PDT)
Message-ID: <3298ef84-0404-4608-9e7a-887d8e30a5cd@linuxfoundation.org>
Date: Tue, 2 Jul 2024 10:18:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
To: Kees Cook <kees@kernel.org>
Cc: Rae Moar <rmoar@google.com>, kernel test robot <lkp@intel.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619202511.it.861-kees@kernel.org>
 <CA+GJov5ZpFxKxK44SAb_B8SzWUF9uQV13A8BcVPijo0CV0mStg@mail.gmail.com>
 <202406271005.4E767DAE@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202406271005.4E767DAE@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/24 11:07, Kees Cook wrote:
> Hi Shuah,
> 
> Can you please add this to your -next tree since it fixes test failures
> on non-MMU systems, after commit cf6219ee889f ("usercopy: Convert
> test_user_copy to KUnit test").
> 

Applied to linux-kselftest kunit branch for next.

thanks,
-- Shuah



