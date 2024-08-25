Return-Path: <linux-kernel+bounces-300509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E160395E498
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867C61F213E0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D901B15B108;
	Sun, 25 Aug 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EashDiwg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA75210FB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724607348; cv=none; b=ipUEJ9DTgd3meUUJEn2TD2lVbMkoBsAXNWJt7Q42ad2XqcTmn4iaZwlEwYpgNZ9xhEigWbNqAJJMWfp32bkOB8D2kAb9YhCrfzmyp19+oTUFQWhZEncfNfLaE/copjKmsgaOqR/UshTu/yiWrVad8z9vg9vBTJWbDm9YAFxTs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724607348; c=relaxed/simple;
	bh=XhM7xFZ+HD+CLl/hPjKrMMP5PPL2J3uytRBUBMI1dQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mRiOm2s9peA1miw4ByWjj67acVMBX4Vv9FTcExHUE1SdDgCkb+JqfcMPE7ib6rWVl0VrYd2893nBWfsYbCzHi86Gs0VUiK2FyVCuRpuf166JeVnovHXq1emjyb+JGQsE9fRExYWW896I/nVlMlglrdc31oe6jRdCttwRzv5nt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EashDiwg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428119da952so31581645e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724607345; x=1725212145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=he266uKSoBPrnIX/bWlKMDUsonIDnd3kNbR3Ld/RGFs=;
        b=EashDiwgs+BhaFVMKFKB3zTyi1QswNudYjGpugbIIu3boOgQIp2dQfa4cjL4QdVpfK
         yguIYEk+2KvPMBczSyhUHfp0fkrLm7Aab3EkGlWWmrk7CkdsHqypAhpvT8UDY5S8fvKd
         /6o+kX0eQ3k0kvncLw0q5ityReMutNVcmPfhFQ2wzOkUa6bVPvyqVSY7ceYoNBkzZ0dl
         qk4JadzbZJ3aDLdtzmV2sY+GlG28CsrEUNtJD2/2glaV8IHg+Wr203MY29wNOxojcnlC
         PljlKFV4STzQeuI5myWzzg6nRICk7dykPlH+iqU9Ha7Fodiu/6tCCaxaCd9PnrOHc0Zu
         YXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724607345; x=1725212145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=he266uKSoBPrnIX/bWlKMDUsonIDnd3kNbR3Ld/RGFs=;
        b=XP8ea2dsjed+fO1GY5Ma3T99LHGZtDBsA+3rbm1Jpmi0kY5Ad8Kf3osye9Ab9ZR21N
         XTgL3lBr9PVn8RCbkQocf86vIC6wHZIa8xb+Upsj/0HLHcB4H1FecV5noTCpbtSnaJGI
         GmNWSxfG3ZSPE68ROTo5qTusdqtVS8zp8ryovK5rpsZtVLe0kcFJ5EDyeo8XeA3UqNcb
         T9dOeF+rTraWIvmaZfMb6jQOyvmdrw1kdbFf7jY1QYtq53A6ZEsHl0EvBEX/VJTpBJnv
         T6N1I0Rdcunaj0zfR3acFKJgScZuW3AQxyhKTAJvh+FD2xRS0Fzb5gCWWrxf7u2lQbfA
         Tsgw==
X-Forwarded-Encrypted: i=1; AJvYcCV7O80RtqlqENyhewJoSEGCYQYUr4u2bwxNRHv0omrJjHEiMT01Wl5LsbZ9ePYvMMHJ++PFnJYmthHSgZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKp015ase6TJ10OvwbYYe5x/nDzviTQw25zq0AsvScZjvr3jqT
	q9E2QnLXbdurEk3Cw2e6pcpyhIUqESQCG8sfaTgNjpwfrxcDvGxu
X-Google-Smtp-Source: AGHT+IGpc9bnz+HeiZS/6uM9ho+rDI+SqxG4iviCjK0mfY940mefKA1OhPp52DXQiXZPB4v7fP6Arg==
X-Received: by 2002:a5d:48cf:0:b0:368:3789:1a2 with SMTP id ffacd0b85a97d-3731189af72mr5079832f8f.21.1724607344586;
        Sun, 25 Aug 2024 10:35:44 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8562:53f2:85f6:2f59:f97d? (p200300c78f2a856253f285f62f59f97d.dip0.t-ipconnect.de. [2003:c7:8f2a:8562:53f2:85f6:2f59:f97d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f4a67sm552304966b.214.2024.08.25.10.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 10:35:44 -0700 (PDT)
Message-ID: <01f4337d-baff-4df6-9367-3e9cf2fe32d1@gmail.com>
Date: Sun, 25 Aug 2024 19:35:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Fix multiple assignments in
 rtl_wx.c:529
To: Alien Wesley <alienwesley51@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240825154557.17912-1-alienwesley51@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240825154557.17912-1-alienwesley51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/24 17:45, Alien Wesley wrote:
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
> 
> CHECK: multiple assignments should be avoided.
> 
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index fc8e7f73b2a4..47f1adf30ab4 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -526,7 +526,8 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
>   	mutex_unlock(&priv->wx_mutex);
>   
>   	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
> -		ieee->pairwise_key_type = ieee->group_key_type = KEY_TYPE_NA;
> +		ieee->pairwise_key_type  = KEY_TYPE_NA;

This line contains two spaces in front of "=".

> +		ieee->group_key_type = KEY_TYPE_NA;
>   		rtl92e_cam_reset(dev);
>   		memset(priv->rtllib->swcamtable, 0,
>   		       sizeof(struct sw_cam_table) * 32);


