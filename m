Return-Path: <linux-kernel+bounces-295429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2269959AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5471F24334
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5595F1A4B92;
	Wed, 21 Aug 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPRW76Ko"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9F1A4B84
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240410; cv=none; b=jj+g1p7agl4KQVdBE40+ykOBa7bMlLg/Bw1fLg63QXmvOLcjWiykyNnYPqc5dW5Kt4nRW/kTy6gVcPPvnnilDXZHpBh+hi8qryxUYPDcptZXrY6z0oCM1rlP7MJTo4nStSsAK1Vz7zg1Y/toFZQ+Ec8hcljanaILy/4PMcFfjts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240410; c=relaxed/simple;
	bh=TxdPXmFR5vjV3UXtB2DcKHBS9FQbWYVADGjWJRmGmK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTLuR4mmQT0/tFB3pXpjv+AY5Z9GECWuSDEgvF0can9L/N/aSMhgdoUKlFx1BpyRcFpzXGbI+eKQU3zuhAcRnrtHSGCCEc2CZvVWaxSYs9bXqwe3SLH5bCBfK/mL3Kuvn41747uGExJubhH9Wh3iGwJjthkZyA1ZX/EHItW2rTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPRW76Ko; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e09ee91eso990635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724240407; x=1724845207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQy9LBwp51k85doIAWOjWZXnls3PlfVEFpR3aoQxmj8=;
        b=MPRW76Koj9agrc4TKSLqXbPt186JqyVQ9GibaRI9uUIEZH9ywwY2G+BYZz87EP7Jfh
         eApyWuLcuqQXoMJe5p/yWXCN5SWhLXUUo2Wxv4XmiDdzcuQTChIG5nX3iaTnHDjP3zBf
         UXvIfxd1tMLu/+vH9LsUDQXZhqzM0w9tuNCMRuyZ9bhqLNOBzl47LVYe4P3Gr1q/NniN
         2EacP4aAg7jTLALrXvC1rYbZqKZB0CLeik7/ndzS9v4DKLLzNvbZcmBgsQ543dPFhdYO
         2w4ONecpBeQYJNUlrh+Y/+ygf1sz2jgN2UY4DrzWFgvIL8BNIMDTRLf7Fm3VbLCTdYXb
         A84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724240407; x=1724845207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQy9LBwp51k85doIAWOjWZXnls3PlfVEFpR3aoQxmj8=;
        b=fexLf7AhQjV7ODx1ley/WmpkvtNRYpzlNWRNqsGvlgLO6pyU5DHg8sDBfJt7TYkDhK
         lwA315vOa08nhSE4vGXxKswDSuhzCANCYTVkivjwKRyyZJN2XtNYZi6b3qh2NUNpYhog
         OSkLmyPX9ukPGvv03wSGiN8ZAdCnureQlH4tJVDql+fMMn+UGzv7Lh2jcChn72R2aS1m
         HNlG//Daj8vOn1sW0NDtL8TcHAAfOmXPV6Mr8Qtcbq9wTyTIfPSHrZzZszhZRncqmUyA
         n4ymLUxCVoQG3CcfevolBfX6M0S2npohZly1D6/u5ThGO0uU9w8QJXI7fV8x3DXGfeuE
         Pbcw==
X-Forwarded-Encrypted: i=1; AJvYcCXcb54HhpzAxQ12cD0ioyf9zNml53z0ZjtEBdTNQF1jBOvs5KjfIEnFFEhD25grUDrVVPV0KDyM+w4GJ9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWypSdBT+Lccyos+9EEyoso6Jdpaf+bNaC4m3pKqhH1E3EBnj
	i4D+RFrCIyE+bq4n7NYCLiyfShWGzKy6YdjO4ElCwtm0Fz2yFIZxnXiH6KB9pLE=
X-Google-Smtp-Source: AGHT+IFu+co3QmulLWZnBNYh0+MKW+hT0OnXrUqee+tKbGDEErfOYOQtHNV/NVXtiH45oA614+eEng==
X-Received: by 2002:a5d:5846:0:b0:367:2da6:aa1b with SMTP id ffacd0b85a97d-372fd710240mr685060f8f.7.1724240406292;
        Wed, 21 Aug 2024 04:40:06 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2036fbec3c6sm8908245ad.124.2024.08.21.04.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:40:05 -0700 (PDT)
Message-ID: <25f2be6c-3e9c-4484-a44e-d26e9c4c8a74@suse.com>
Date: Wed, 21 Aug 2024 19:40:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in
 ocfs2_set_buffer_uptodate
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>, joseph.qi@linux.alibaba.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <1a063827-5cf3-42df-a690-f3c644c10996@linux.alibaba.com>
 <20240821091459.681136-1-lizhi.xu@windriver.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240821091459.681136-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 17:14, Lizhi Xu wrote:
> On Wed, 21 Aug 2024 15:58:36 +0800, Joseph Qi wrote:
>> On 8/21/24 3:37 PM, heming.zhao@suse.com wrote:
>>> Hi,
>>>
>>> On 8/21/24 14:55, Lizhi Xu wrote:
>>>> On Wed, 21 Aug 2024 14:23:08 +0800, Heming Zhao wrote:
>>>>> Where is my "Reviewed-by" tag, and where is [patch 1/2]?
>>>> Sorry about your "Reviewed-by" tag, I remove it, if you don't mind, you can
>>>> add it by yourself.
>>>
>>> Good answer!
>>>
>>> This patch issue was found by me, and I also pointed out how to fix it, then take the time
>>> to review your code. But in the end, you removed my "Reviewed-by" tag.
>>>
>>
>> Seems a misunderstanding, take it easy:)
>> Lizhi may think since this is a new version, it needs a new round review.
> Yeah, the subject and comments have all been changed.
> Thank you for defending me:)

OK.

> 
> BR,
> Lizhi


