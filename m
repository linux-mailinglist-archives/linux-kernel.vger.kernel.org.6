Return-Path: <linux-kernel+bounces-327221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BC977283
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0113A1F21D74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2497F1BDA90;
	Thu, 12 Sep 2024 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxXOU41C"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4D2BAE3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171315; cv=none; b=MBKM9aWmcaUOBNf8oksQGKO1893E6lxIyqhL1cCjurfSw1pGOuWiEv5hN8DC1dULbrtaB8rgyTObfPld6GWaeaH6jtKhmYWfNIW7whX3D6uuFVw/eVIbZjOj4OrUptKHr65kKCU7EM4nxTt9X3Y4n79JdNTP9/Bm01bGYhVgAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171315; c=relaxed/simple;
	bh=Ey2P+BxTqsyXNaWPXh5IJdJm4Mnu9yH8zF90c2nP8SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKq/oaXoZs2UqUJi5jgqKA9dp7PT/7OZ4jovTHtAXCwHpNEbIQer8u0TWRe0OwGhgstHSAhE72dQVlefHu+tlY7T5UbX6Glt5w5/uafzF+kjFxNxJjV5hxkAeEvCjKA2aezB0mUJBSfv8zZEr+R2R0oRYnY3u7N30XpKXw+HS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxXOU41C; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso203351a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726171312; x=1726776112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAf/DfuxZvgtYHDE/S0MWY4m5gBjmAwHzwNyNROY3Ik=;
        b=mxXOU41CSQr66iY/cPGHaRAA2ossFsOjL89VOq9tvb6Pk4rrqjDPPumVjpWIQGmLrU
         69fFBqAr/pJaVnU6jtI/t558Ez+k6Wfx1+y6jasTBW0ibxHrEC7cX3du1c389CRuPuc2
         kF+lApHiaxHq9I5xojkD79WHzRkXRlIJitdY4cimIJOAUbfSCNogclxXCzkWyhffsh6N
         Hi+4CvMXPvD+ygUfZJVgn53qhJLjTBG6WILyfJWqYlBsmjKCQhctPJjjoiYYkQnviRnd
         WBGtG0+XmkW81VIpssu1OV4rhLbzr7i6MYhqT5bYNcBOqoXHdp83aBKmSQJkSTPYRHa8
         oYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726171312; x=1726776112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAf/DfuxZvgtYHDE/S0MWY4m5gBjmAwHzwNyNROY3Ik=;
        b=j3Y1Adys9L6zpoNaVCumHRuF/EXHYlgKIttSMhqpWRO+/Rh+S+zFESTSMr3Wjs4+hu
         6GDPLrUdjWMNdNTERcBCNassflClpXYV1esUrfi1x/7KgCK62lkgFT+S9owWBv6NbwSa
         DE9m4dcCqNYBybbxu+5yuT4Hj04JMBupx16K+7At919KEBLW1AatBMOrOOuy07FbjSN6
         pLl63aJ2SgiXVq5ChJ5qZ82G2gMEU74LHXf4kftSkG/Ec6D/5JSzNx73eFqWH8IT+wU8
         lCFSLjWHmI7Duuux9/aPuhoKECgneDfzwswYXY3wGv+vIBWhU11jRDWuJLnnAw+mHPbO
         ndUw==
X-Forwarded-Encrypted: i=1; AJvYcCWATqKrkFJppUJOisUbD7Vw2rQEFUR0rNq8lAhZ5VZKyaQNyLc3cOcw/oF5H/g9krLr4C5QacTumLvHauw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTur/KjNJUGCoCqM3OBXCmwNpKOpPth6Us26+jmRyGo/v8xBw
	0HLT5EajESogLfn7hR5wZJFga8fff5DioYEfqL2zkSbha/D2ZfrK
X-Google-Smtp-Source: AGHT+IHTiNZeTK4Zp3JYzocD8ZX2cdqwHwAHdVlMn32NxqMq0mvcFow9h610BLE4NIGxBizZrMNMiA==
X-Received: by 2002:a05:6402:2114:b0:5c3:cc6d:19cb with SMTP id 4fb4d7f45d1cf-5c41e1ac9bcmr327377a12.24.1726171312318;
        Thu, 12 Sep 2024 13:01:52 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8557:476b:8cfa:99ee:514e? (p200300c78f2a8557476b8cfa99ee514e.dip0.t-ipconnect.de. [2003:c7:8f2a:8557:476b:8cfa:99ee:514e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5212asm6913821a12.57.2024.09.12.13.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 13:01:51 -0700 (PDT)
Message-ID: <974c3e9a-c0f6-493a-a865-4f01f41c4087@gmail.com>
Date: Thu, 12 Sep 2024 22:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] staging: rtl8723bs: Fix coding style
 incosistencies in rtw_security.h
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org, guilherme@puida.xyz,
 linux-kernel@vger.kernel.org
References: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 06:04, Sayyad Abid wrote:
> This patch series improves code readability by addressing coding style
> issues in `rtw_security.h`. These changes aim to enhance the
> maintainability and clarity of the codebase by ensuring compliance with
> the Linux kernel's coding standards.
> 
> The coding style violations were identified using
> `scripts/checkpatch.pl` on `rtw_security.h`.
> 
> ### Changes in v2:
> - Split the original patch into a series of 8 smaller patches, each
>    addressing a distinct coding style issue as suggested by Greg's bot.
> - Fixed indentation issues, placement of braces, and removal of spaces
>    before tabs.
> - Improved commit messages with detailed explanations for each change.
> 
> For reference, here is the `v1` submission:
> https://lore.kernel.org/all/20240911133549.2664372-1-sayyad.abid16@gmail.com/
> 
> 
> Sayyad Abid (8):
>    staging: rtl8723bs: include: Fix open brace position in rtw_security.h
>    staging: rtl8723bs: include: Fix indent for switch case in
>      rtw_security.h
>    staging: rtl8723bs: include: Fix indent for switch block in
>      rtw_security.h
>    staging: rtl8723bs: include: Fix use of tabs for indent in
>      rtw_security.h
>    staging: rtl8723bs: include: Fix indent for struct _byte_ in
>      rtw_security.h
>    staging: rtl8723bs: include: Fix indent for else block struct in
>      rtw_security.h
>    staging: rtl8723bs: include: Fix trailing */ position in
>      rtw_security.h
>    staging: rtl8723bs: include: Remove spaces before tabs in
>      rtw_security.h
> 
>   .../staging/rtl8723bs/include/rtw_security.h  | 124 +++++++++---------
>   1 file changed, 62 insertions(+), 62 deletions(-)
> 
> --
> 2.39.2
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

