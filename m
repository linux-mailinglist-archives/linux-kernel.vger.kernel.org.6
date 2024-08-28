Return-Path: <linux-kernel+bounces-305555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0796306D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E290A1F22965
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515E1AAE21;
	Wed, 28 Aug 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSyRGA3g"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC947156F5E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870926; cv=none; b=bNJrgcC7RcYj5SkE14UCk59C4+URdU1Al+kkCcx/mDF9gnipq6PlixBhZvC33u81TXy27Vij2nI6hFT3LthVkBt/xKvNr5pXnbyVUhQxGQwq0Oka2mtATUQ5RnHFTW3IpdZdhJgMpYzvV0zQ3O4NNx+AxUuGf3PXwELrRXXLFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870926; c=relaxed/simple;
	bh=HfCYTyNwdb960/65HKXK1EAtTw5j0DpXyGeouZxsvdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SrIgUQIzcmxiUL6cepWq2YcG4trG76sBFDD6vfMJgibKHsW8fEARPtaCqIjfCEWxMUwQ0mcBxLtGVvxmqN0mEARXxC5yZDNJh7moJZj0/z84vEZ2PcdcaxnlENsEo3lMvRFHJuE3UFzzuCCyJCbc4pa5Yz5qzHue65lVcjfEfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSyRGA3g; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c0abaae174so4008052a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724870923; x=1725475723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4TuKTqviBGFP4ZDF4tveGym+O+ci2sBrO3pKcTbinI=;
        b=RSyRGA3gwJi/dE3BrIbM3BaB18yiR2tLuoc/VKrtZ5wwEkx0KsFZvNLfLRA5mWhBo/
         FeMhiyC1KC2zlKqY+BXrBFH9+IiKkgWNia72gt2ew9aX0tnS3GB1x674iAFw4DOvVd+q
         JJm+rQDZH5i9I6yEq8ZrB36t665pA4pplmGVDRnJmTIpMkESiz87kuHlN0RYUGZnFwqw
         qf7feBzq3GEjc0npSyUChk2gqDt7v1RhBnnufMxuXPfmIRDYuLh0V5ZB13xre7lpmtKT
         ZiocCUo3FRGVXPOjDuGtL1AV1UgUoBuPUY4E8AoSjIULkKCW6JoE6vlINAtn867EiacR
         wZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724870923; x=1725475723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4TuKTqviBGFP4ZDF4tveGym+O+ci2sBrO3pKcTbinI=;
        b=hfo3xkv/CuL5Hwq0PGgtKtZFm3zPv6qm58NwNSOXAweYawemFcuiw382m8S5GFoALc
         i0m+7YdmQAxFm2s4uapsWM9vzSXKGk2zkN5/lR/0JUViR+GcePGbcfARy9cBAvIlntfd
         j2LIh2kSVaBATSej6WnXPQqTbBJ2cNEvP14AFIOC1IK6VG6IYmuVhyzzOMQxwBA3uxMS
         yy06NMMOXE3fHHVHuJDei9XBRH0SbDE5iM77G3ANVz7xbKQx8+/at52a/NUUI0/aYU4t
         U7o1jfMXPDoYOivvB2YuebNaiQ/tQPggLYtdFAKFVXvTB0zP8vVlQ3TxtYrcxzWZ0ZO2
         shbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxAshmI4cBEpN4yr7IDaU2Oi2iF1lSW/zEyg92e4Bc6Ee/fA3M4zH7EKoOmtEG0R6zJTWvWLGl7IxSLYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrwk+xg5K3gN3qVY7QGwaWrxkPOfZQRR2604dftfKCTtU8Rw99
	/6ER58Up+B65eQ048g3BzTR5KfldXoIGg3f81rSXoFLF8eZMMyjb
X-Google-Smtp-Source: AGHT+IHXgURMRyqoUm9rXVpjQa5L4iWj1GJFbNm9sxmB/L4X4vYfdMRudEJqs1hy89hYWUPWSGMZ0g==
X-Received: by 2002:a17:907:9729:b0:a7a:a0c2:8be9 with SMTP id a640c23a62f3a-a897f84d369mr31594966b.18.1724870922886;
        Wed, 28 Aug 2024 11:48:42 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3? (p200300c78f2a85534dd47649c4c2f4e3.dip0.t-ipconnect.de. [2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594d041sm273783966b.213.2024.08.28.11.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:48:42 -0700 (PDT)
Message-ID: <9c1ab010-1436-4c54-9fa5-418472a9427f@gmail.com>
Date: Wed, 28 Aug 2024 20:48:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8712: Align parenthesis in usb_ops_linux.c
To: Dorine Tipo <dorine.a.tipo@gmail.com>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828082935.GA3815@ubuntu-focal>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240828082935.GA3815@ubuntu-focal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 10:29, Dorine Tipo wrote:
> Fix the parenthesis alignment in r8712_read_port() function to match
> the opening parenthesis.
> This improves code readability and adheres to the kernel coding style.
> 
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
> Changelog:
> V2: Edited the subject line to fix a typo and make it more unique as
>      suggested by Philipp.
>      Edited the description to include the reason for the change.
> 
>   drivers/staging/rtl8712/usb_ops_linux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> index 0a3451cdc8a1..4a34824830e3 100644
> --- a/drivers/staging/rtl8712/usb_ops_linux.c
> +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> @@ -221,7 +221,7 @@ static void r8712_usb_read_port_complete(struct urb *purb)
>   			fallthrough;
>   		case -EPROTO:
>   			r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
> -				  (unsigned char *)precvbuf);
> +					(unsigned char *)precvbuf);
>   			break;
>   		case -EINPROGRESS:
>   			netdev_err(padapter->pnetdev, "ERROR: URB IS IN PROGRESS!\n");
> --
> 2.25.1
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> AW-NU120

