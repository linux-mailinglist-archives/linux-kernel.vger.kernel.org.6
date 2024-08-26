Return-Path: <linux-kernel+bounces-300616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A829895E61A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4201AB20BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844121C3D;
	Mon, 26 Aug 2024 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkhnB3Ty"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB981C27
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724632960; cv=none; b=cscXMH7xYo/t8cunwlH8uRY2H3KCLvXoeWajmRPiutEPX5mx9e1kd2wahysbvoIt+i69co3itrNELwmawKW/Q5qGzGsOUDuWdQ/tR59UKWJ/q+OQoedhXtBQhW3jqQ//m2TjwQYQZYZK1y3E27SHuDP++0IuIlVr9zqruwH/fao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724632960; c=relaxed/simple;
	bh=dRrFyLibUX2s1c2Q5YvYvEou9Jt+u7PSjsVGlx6ERl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mMCj9CvwqDqOcesq0Vld9Zen+dOV12lQc0LLd0IPJXyFn2IO8YljCbTT4D9XRsJyHL9LmhhF+NYkzw1iTuFDD59TlWyLlJlQokIBaSlAHaZdviszwcRhVJMI9U9CeOeFXIMskloO50/3Q7FVreqknEBBQmHf6L6wdMgvVo2OuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkhnB3Ty; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bed05c0a2fso4676202a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724632958; x=1725237758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTKOsv1W3Txl3mLD3qHMeGT5uYDW0uAn0LWfSNHb39g=;
        b=kkhnB3TyjvvbBrOfQAVz/7/Ixk5zE3KcEnsisndLCs8bBa55W51rtQ/ILkS7QCLGKQ
         Q1WexoqvxvUKGgkiVgxVLfgR9ivuqwNW0EVM6nIHka7amJA2n6URcYVsBSU+n51pSQyL
         ra6p7wpRImYu0xB6UySd7JuPBboOGrrbbpvlFI/U8MR5YjDtnt5c4jZ8MgYEDNdfPE7I
         6BZpUgcH3Ck/DxRmFJvhfjnVZLAedRBu6DzcrSu0pwysEXQVz1ddDEDd8iWyQcqkeIwL
         AHnq9bpsfqJ99/XJfE7+PDRmr/GwKJ7d2msMOJoqk5/6rwjnqOYd9HZ1XE2mMDdFMvwE
         AlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724632958; x=1725237758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTKOsv1W3Txl3mLD3qHMeGT5uYDW0uAn0LWfSNHb39g=;
        b=HpG+RU4LmeD3FWccoQ3gz76anextm5RoDByxaHB2iR3Irvls5JClMMIDLSGuQ6tns+
         Q2H0yXWSgq49+kNbFdonCPTg+qKuxeqBxXHxPJp+xEsb7YGQcBD3EREct+QyelLSi2Z8
         kL1JAQWRu/KQ7vtWvW3DWNSVQbgWhgHGfNDxspezVe0Ryl5ZOInWnHPTKTsGHwJQwEOG
         yXozNrzV/a2zvQ7bUDCHBCrqrOae68T3XBnWMRBCkj48SDcLcSgWxoKysBmNGqKfKBnX
         t1EHgJONMSq7p84LXE/bBoRjqQzy2jnxWmn6xQ2r4LjMKlFZJxGlI6cor19nE8feIiK/
         zQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVwHuoxM8NG2BtNXqOYxCKAfhygy1h/K17tCS3gDsXn5XOQDQsI7FYQhoV40TkmVqcZPaeM9AXA0XjyBHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2SEW8ZiGECo525uyNEWD0sH4B3za16pt9WUIPfAppBdxcfMt
	JNfypCqn8lQJ5s0prOLI00rXeEayNWWtKnbnHUJGAMPAURXT1KP7L8bwxmfq
X-Google-Smtp-Source: AGHT+IGKSbzY/T503e7BF47y+O/i2UF18xes1Ww4aU6CENcTvwTjd5LesvywQlb0mE/fBYQFx1yA5Q==
X-Received: by 2002:a05:6402:3895:b0:5a1:c496:2447 with SMTP id 4fb4d7f45d1cf-5c089175af2mr5360187a12.21.1724632957339;
        Sun, 25 Aug 2024 17:42:37 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8562:c260:909a:b5d5:f661? (p200300c78f2a8562c260909ab5d5f661.dip0.t-ipconnect.de. [2003:c7:8f2a:8562:c260:909a:b5d5:f661])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ea610sm5079443a12.51.2024.08.25.17.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 17:42:37 -0700 (PDT)
Message-ID: <a289cd79-4d48-4ae7-b45d-8b8da756e373@gmail.com>
Date: Mon, 26 Aug 2024 02:42:36 +0200
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
References: <20240825214612.49254-1-alienwesley51@gmail.com>
 <324c34e3-3471-4cbe-aa6d-b14244ca48eb@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <324c34e3-3471-4cbe-aa6d-b14244ca48eb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/24 00:43, Alien Wesley wrote:
> Sorry folks, this was supposed to be a v2.
> [PATCH v2] staging: rtl8192e: Fix multiple assignments in rtl_wx.c:529
>> Separated assignments for pairwise_key_type and group_key_type
>> in order to silence the following checkpatch warning.
>>
>> CHECK: multiple assignments should be avoided.
>>
>> ---
>> Changes in v2:
>>      - Removed two spaces in front of "=".
>>
>> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
>> ---
>>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c 
>> b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
>> index 47f1adf30ab4..67c4793e0fc1 100644
>> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
>> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
>> @@ -526,7 +526,7 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
>>       mutex_unlock(&priv->wx_mutex);
>>       if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
>> -        ieee->pairwise_key_type  = KEY_TYPE_NA;
>> +        ieee->pairwise_key_type = KEY_TYPE_NA;
>>           ieee->group_key_type = KEY_TYPE_NA;
>>           rtl92e_cam_reset(dev);
>>           memset(priv->rtllib->swcamtable, 0,
> 
> 

Hi Alien,

please make a v3 with correct subject.

Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

