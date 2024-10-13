Return-Path: <linux-kernel+bounces-362745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76F99B8E6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0758D1C20C92
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B813C67E;
	Sun, 13 Oct 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQtbFA7O"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E113B590
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728810550; cv=none; b=KLLHVg0qz5i0zSSo/tbnMULj6Y7134t/3dKuk72UWjzKOx6a/CC5FtobEEFIw5pxm7NGpvF8DyH3b0Pa3RKCZ35B8h9IbJRkMfD7sMUjL/Kml5RCPlOu8fSRCr8glIrWvedTrz4x13R3k5094qDqu0hOaur9ETAYQKeTkHZp/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728810550; c=relaxed/simple;
	bh=2QFwAmINshp3nFb9f4R52q/8DsxqhGyQw+G+fI/kXEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baPjqP4Re63XW+58tvb9hY3B5kcKjFfbwNd68ZhXKe/XwItsN+MGTuA1GiVBCjxOx1rkLINhmidgB6HaQXaaD9a3bI3Yq4gG1fNrz0Q+o1vcZCpF5L2X2eb5QeVROtx25NCCdkmJ6GNQtUlWTNLhV18+qtG8L3VsFc4f4HSqKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQtbFA7O; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso2522311a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728810547; x=1729415347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BfrRcVJ20ZnXl/B+pe9Sl7RD9b+bmhTOEzMh+q3RBY=;
        b=GQtbFA7Of89DUBhYsRtblad5G8upsHQnMJSNWNJuEYcJbEDXd6fs4WDkoWfpATrB/X
         KT5K5g4jlfS6QxvmqWcXtVUTFvkTiyp/9sPvThWaOZAO6gE7GEvP9w0VSS5e8+8bLK5A
         fA5omak/cxMPHr1RXJBrZbLP9Zz3PsCFtwe0QmHWqQRL3hJYVdaegpsRiQx9iTM5J1O0
         NIu6Acvr6v5UPGKQ6pqlVypYnU1Qyke8pK6ZyOK5/mVh6JF5CIZ2vbAM6spi6aLXtfjl
         3BdzZUdZrkJWEF4wn74i5Srnru+E/j3cYDpKeLPJuBXyGXfl+LtGylsm05Mq3tJ2I+Yp
         eSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728810547; x=1729415347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BfrRcVJ20ZnXl/B+pe9Sl7RD9b+bmhTOEzMh+q3RBY=;
        b=efy18MgwGqrz3eGRSRqdQhS8dBRiYgjpy14L8ZKvrXvYrvsWhY8+Rr6kWh5KP5USt5
         trPt+WJ8+XfbnaqCsJobjrw2kWz4RzRDvgyopHtmsP2LjhtU00eNlhphRyqC94E6ZePb
         cYfBWBDx+4obJsIyI58eBSbL42098d9cMWXe7RNQZ2eW5X7rT29hctIN05nmwQNrGWrv
         RqKl5DDzZUagcBbxNbxAi+JJy77JW1qwd2oGXWjC9bZxxqYX/bfKr85vivljEHGp1cWP
         0s6L6nvBZSI5X5/TuENYonnNSUo9Pfpmz3AUproA/BmsnHruNQTXBZ8PDwbvrdphBAPE
         AO9g==
X-Forwarded-Encrypted: i=1; AJvYcCW9ab5M3uyETQpw1XA2qSEY24Yi2WRJtTOYAtrNjERWx4gwZFYcyY5rMxF6KEwibrKeX7w7SWmMHPtdUgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZW/Lz0eI57rV86SUfulqZo0AoDes6LXhpuHWdGRxmmXTFLxe
	cq1zGSCTC3euzwV/88blcdcj1qUdn8gZ0KBUtG6mtJwNZER4CPG+
X-Google-Smtp-Source: AGHT+IE6t+rDwJ/A3tHo7fWNZk2kIEa7LKUPQ86QgstwCWEnG9Zsqz3YDiE7FPIjIUYpxT6q8MCUrg==
X-Received: by 2002:a17:907:2da4:b0:a99:ffb5:1db6 with SMTP id a640c23a62f3a-a99ffb55507mr161462666b.24.1728810546894;
        Sun, 13 Oct 2024 02:09:06 -0700 (PDT)
Received: from [192.168.0.103] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm117128466b.92.2024.10.13.02.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 02:09:06 -0700 (PDT)
Message-ID: <0afd7977-ccee-4d03-9d26-f55822adcbf8@gmail.com>
Date: Sun, 13 Oct 2024 11:09:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] staging: rtl8712: Tidy-up *Algrthm variables
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 ayushtiw0110@gmail.com, dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.10.24 18:17, Dominik Karol Piątkowski wrote:
> This series renames *Algrthm variables in order to avoid using camel case.
> 
> While at it, introduce auth_algorithm macros to increase readability by
> replacing hardcoded numbers in assignments and comparisons.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> 
> Dominik Karol Piątkowski (3):
>    staging: rtl8712: Rename AuthAlgrthm variable
>    staging: rtl8712: Rename PrivacyAlgrthm variable
>    staging: rtl8712: Introduce auth_algorithm macros
> 
>   drivers/staging/rtl8712/mlme_linux.c          |  7 ++-
>   drivers/staging/rtl8712/rtl871x_cmd.c         |  6 +-
>   drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 61 ++++++++++---------
>   drivers/staging/rtl8712/rtl871x_ioctl_set.c   |  9 +--
>   drivers/staging/rtl8712/rtl871x_mlme.c        | 23 +++----
>   drivers/staging/rtl8712/rtl871x_recv.c        |  2 +-
>   drivers/staging/rtl8712/rtl871x_security.h    | 13 ++--
>   7 files changed, 65 insertions(+), 56 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> AW-NU120

