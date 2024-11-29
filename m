Return-Path: <linux-kernel+bounces-425991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7009DED76
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2982163427
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B4198E69;
	Fri, 29 Nov 2024 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3/mSAQc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B9166F0C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921671; cv=none; b=EeA5JKYaLuYZJYYXfYeTQAJnPdDZvoxLYbjznxUQjYbKfes6HLTXgK+zXEgoZEhJGeXvdH5hVAPZT235lqe0GX/p17kKPChC2dH+0fk9iF1ZRUDUVUDomV7ri4pdQGzSAylLTzvY/HlJrH5s2TfCWZN0WkYpiJJ6VHSPUD4GzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921671; c=relaxed/simple;
	bh=eWpZvg/efTDewEn5gJPGAr3VSGlXZwYFXcc6TQ2LfD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhS2LcPn1tMdLI6H3vnCGKRuUV6FVqsVEkXbSQYsnhgFSC+rRDRSfhWEfDeOnOZ0+pWlqtUOX2uWACZjGEJet9lvr8HnUWqkRW6hdktvvPgh8kfCzReZ2jf1IQBsYhvoWiSExQD6sGYcqJRf+VpyLrLYH48RFjCsZlIg8e9+tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3/mSAQc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434ab938e37so15161275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732921668; x=1733526468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxtbZr91YGtlqlkH7gV3tkH9u1Viq102T9XbHakKTy8=;
        b=g3/mSAQcC1YqYdq2F3cFsdk3H2iwKKqoXDUVUWa7SvktUxl8UAQLKbCosGgzcok46z
         k+kAwozrSAL1bQQ0cZGZuI9M1lhtLIvTFJxatqgN50rlD1Wth68BxtwPr5rS9+uFNpG6
         0kjZ632I5FDq1sqJl8QM7GZqytSB1TuMF0QwaNiaIvkHGxdbv3yYM4xEW0t3+43Z/UQU
         XlOGZjuEXAMFigY567Nd+BTRykt8kRY3o5TzOIGSaYSJsXHDQ25d6iuPqKWbKJHo5B/h
         3019Z+7SGvLfqAJYkKoBJo85jyDPEY+gmmlqj9R5KzQtqvM/NTFNNLAirMIgkp6fpli6
         4EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732921668; x=1733526468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxtbZr91YGtlqlkH7gV3tkH9u1Viq102T9XbHakKTy8=;
        b=g4GHtl7UCuK5YsnXzGA8NL2o+T7jDNAT+FkdEofbq8pkOf/gOIQhzAP8xmioOnPU8A
         TKcpyX2iG/zpSA/EYBjJKxrB9M6fRtW/E/Qu7g0cyAV/Zs1VYL+/7vaCpUoQRMfqugjJ
         /WxAGbPOO/Z/6MkAbrDHXh4RtLgCfJgf0+1Q+Imf9Sg8u6BULSoEsBhPzW+EOOUYbXnD
         aLt+s40/MYYKvlCHOM7OuiFltuZ2yvGRbkjTeOaBfIRT00J7xKSM9tzf1sHeVk148ws0
         80Jsb5oLyqpcESt1F4M6RsXQggkMWBsziMBf+wVCJpzoVzZw5wj47k/CjUOXdBUpe2sw
         iWjA==
X-Forwarded-Encrypted: i=1; AJvYcCWLoqSIrQa1PjOQ+MG4uGEVVHU2VIyJ0ROQ3eC7WV0B3uq/pvnRCRIbCShMPKKV/W0TDi9+ukFuegh6Qok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdFusAGENP2X8EmZt6JJWOoB4lAQxDcGHjq8J1Y63DAfONoT7v
	CwD3WspBujQ1B25FtrxpEF9BduSI0lwXOvKuDLnmzSx7mlop1xxmWKxbTMbDGWU=
X-Gm-Gg: ASbGncs5xd/HIt4hgJOcag1IH+3No8HGaEHdfbdG6XP6SQR/CgTz6rdSNzj2pgrrNHs
	zV76qCrf/xfOLIV2jQ6niDZbdsemxlPSkApH1k71r+MXcnAugmDu9ZdXCf98msz6PMAltU22klJ
	d2tQZoRLOxdlShGCJjL026ALiJj4hLSSeXyGskvEBlvNba4lWJFTJoKPNEOcgIqH6WmUSM6O9gT
	UusMsBU5aWFChPAQ0ojbn3qAwhfkKzru31PCzhFBwNKIromTRcBss+vHFYmV7M=
X-Google-Smtp-Source: AGHT+IFd7WhsLpuxR6ev9R6lOkLb/XIzYSOsYe8y5GrsqtDNgDKIwVga4QcvXADtALaKY/6YuFKTrA==
X-Received: by 2002:a05:600c:1552:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-434a9dc36b6mr134078445e9.8.1732921668271;
        Fri, 29 Nov 2024 15:07:48 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68cccsm5761558f8f.79.2024.11.29.15.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 15:07:47 -0800 (PST)
Message-ID: <93028653-9919-460e-83d3-84bf5ade56d4@linaro.org>
Date: Fri, 29 Nov 2024 23:07:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: qcom: camss: fix VFE pm domain off
To: barnabas.czeman@mainlining.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
References: <20241128-vfe_pm_domain_off-v2-1-0bcbbe7daaaf@mainlining.org>
 <3a5fd596-b442-4d3f-aae2-f454d0cd8e5c@linaro.org>
 <5cccec71-0cc7-492a-9fb9-903970da05c5@linaro.org>
 <d3a8d38c-9129-4fbd-8bd6-c91131d950ad@linaro.org>
 <a08e95fc03fce6cb0809a06900982c6c@mainlining.org>
 <8dfd2ee1-9baf-441f-8eb9-fa11e830334a@linaro.org>
 <ac765a062e94d549f4c34cf4c8b2c199@mainlining.org>
 <f4e47953-5a68-4ec5-860b-820b8eff2a2a@linaro.org>
 <05e91ae70902f0cd9c47bb4197d8fef1@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <05e91ae70902f0cd9c47bb4197d8fef1@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2024 22:45, barnabas.czeman@mainlining.org wrote:
> On 2024-11-29 23:08, Bryan O'Donoghue wrote:
>> On 29/11/2024 13:46, barnabas.czeman@mainlining.org wrote:
>>> On 2024-11-29 13:25, Bryan O'Donoghue wrote:
>>>> On 29/11/2024 11:44, barnabas.czeman@mainlining.org wrote:
>>>>>> The change does not describe how to reproduce the problem, which 
>>>>>> commit
>>>>>> base is tested, which platform is testes, there is no enough 
>>>>>> information,
>>>>>> unfortunately.
>>>>> I can reproduce the problem with megapixels-sensorprofile on 
>>>>> msm8953 and
>>>>> it can be reproduced with megapixels on msm8996.
>>>>> The base is the last commit on next.
>>>>
>>>> Can you verify if vfe_domain_on has run and if so whether or not 
>>>> genpd_link is NULL when that function exists.
>>>>
>>> I have added some debug logs it seems pm_domain_on and pm_domain_off 
>>> is called twice on the same object.
>>> [   63.473360] qcom-camss 1b00020.camss: pm_domain_on 19842ce8 link 
>>> 42973800
>>> [   63.481524] qcom-camss 1b00020.camss: pm_domain_on 19840080 link 
>>> 4e413800
>>> [   63.481555] qcom-camss 1b00020.camss: pm_domain_on 19842ce8 link 
>>> 42973800
>>> [   63.481632] qcom-camss 1b00020.camss: pm_domain_off 19840080 link 
>>> 4e413800
>>> [   63.481641] qcom-camss 1b00020.camss: pm_domain_off 19842ce8 link 
>>> 42973800
>>> [   63.654004] qcom-camss 1b00020.camss: pm_domain_off 19842ce8 link 0
>>>> That's the question.
>>>>
>>>> ---
>>>> bod
>>
>> Could you provide this output ?
>>
>> index 80a62ba112950..b25b8f6b00be1 100644
>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>> @@ -595,6 +595,9 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
>>   */
>>  void vfe_pm_domain_off(struct vfe_device *vfe)
>>  {
>> +dev_info(camss->dev, "%s VFE %d genpd %pK genpd_link %pK\n",
>> +        __func__, vfe->id, vfe->genpd, vfe->genpd_link);
>> +
>>         if (!vfe->genpd)
>>                 return;
>>
>> @@ -609,7 +612,8 @@ void vfe_pm_domain_off(struct vfe_device *vfe)
>>  int vfe_pm_domain_on(struct vfe_device *vfe)
>>  {
>>         struct camss *camss = vfe->camss;
>> -
>> +dev_info(camss->dev, "%s VFE %d genpd %pK genpd_link %pK\n",
>> +        __func__, vfe->id, vfe->genpd, vfe->genpd_link);
>>         if (!vfe->genpd)
>>                 return 0;
>>
>> ---
>> bod
> I think logging in pm_domain_on should be placed after device_link_add 
> because only NULL
> will be visible.
> [   83.040694] qcom-camss 1b00020.camss: vfe_pm_domain_on VFE 1 genpd 
> 000000009bd8355f genpd_link 0000000000000000
> [   83.049293] qcom-camss 1b00020.camss: vfe_pm_domain_on VFE 0 genpd 
> 00000000bfb65e7c genpd_link 0000000000000000
> [   83.049353] qcom-camss 1b00020.camss: vfe_pm_domain_on VFE 1 genpd 
> 000000009bd8355f genpd_link 00000000ccb0acd9
> [   83.049641] qcom-camss 1b00020.camss: vfe_pm_domain_off VFE 0 genpd 
> 00000000bfb65e7c genpd_link 00000000348ac3c1
> [   83.049654] qcom-camss 1b00020.camss: vfe_pm_domain_off VFE 1 genpd 
> 000000009bd8355f genpd_link 00000000ccb0acd9
> [   83.241498] qcom-camss 1b00020.camss: vfe_pm_domain_off VFE 1 genpd 
> 000000009bd8355f genpd_link 0000000000000000

Could you add

+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -786,7 +786,7 @@ int vfe_get(struct vfe_device *vfe)
         int ret;

         mutex_lock(&vfe->power_lock);
-
+dev_info(vfe->camss->dev, "%s vfe %d power_count %d\n", __func__, 
vfe->id, vfe->power_count);
         if (vfe->power_count == 0) {
                 ret = vfe->res->hw_ops->pm_domain_on(vfe);
                 if (ret < 0)
@@ -823,6 +823,7 @@ int vfe_get(struct vfe_device *vfe)

         mutex_unlock(&vfe->power_lock);

+dev_info(camss->vfe->dev, "%s vfe %d err=%d\n", __func__, 
camss->vfe->id, 0);
         return 0;

  error_reset:
@@ -835,7 +836,7 @@ int vfe_get(struct vfe_device *vfe)

  error_pm_domain:
         mutex_unlock(&vfe->power_lock);
-
+dev_info(camss->vfe->dev, "%s vfe %d err=%d\n", __func__, 
camss->vfe->id, ret);
         return ret;
  }

?

---
bod

