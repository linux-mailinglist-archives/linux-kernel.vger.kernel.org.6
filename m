Return-Path: <linux-kernel+bounces-211129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6EF904D83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59738B25800
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034316DEBD;
	Wed, 12 Jun 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnogSzHG"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E916D9DF;
	Wed, 12 Jun 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179396; cv=none; b=ZFB8U6MjsU0dpyRuk4VdLXGlKHuM0rtpha+T1QEWQ5T0Qo31XMeVj62qD7+snfZDTeJyDigpg4qXEOz5hQEsr0ddum33HgZPWVsL0Spw0GAoN+yFm8OiKij+5nm2zRMKTxmjfwxKwaCCZqyqZYHpW7Ud8X9f2uu9sZ6i9Wj5Zwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179396; c=relaxed/simple;
	bh=cUHTjyITmRjwDRYP1z4q2TYF59JwA17+NnVNYZKppiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJ2hoP7C3dMRqlzW1z5hJmHnWg1u5Efo1Nc7OiogQdwSEUpJ87VUGyF1U1TW9GDMO4I7z3X8oEvlc7CoW6CH2wPdo6PC5B+avv0bW08653xDkN/aF8Hnu6YHnKcIWAIPyHDoQ8+FO5w7XsTxcmPqzWNnLi8DEW4Vn9oxFZHRzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnogSzHG; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b96a95c5e8so3574598eaf.3;
        Wed, 12 Jun 2024 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718179394; x=1718784194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0peaNZhLAYYlwx3S6SyDRjFOc80oijdq9uefxoNUiC4=;
        b=YnogSzHGbD7nX9+qN0zRyecjnLa3wU+bAqDRu+coaUBeK7C397ZmbA+pQ5uWnSjP/i
         2cFIqxmuiojD8lNXB7rhZG7cPyZl2d9Hip80zuJrKZ7JIDAQvhlQbV20Qy6EP2cpOgsY
         Cvu129lLQ6OQw5hzHjN/fm+2qx/sZUfgejSY6VLMT0ZdqY8IeZn1ups1m51vg4Wtktee
         dVovwOTnPcTbk4hJ3J3DZm39V0ccdTOV1VgWf77NNRposDaLtj4DE+TbclVlydMm47u8
         h5RKnRTMbQ49HfzoD/nFSIFurUmZy2ZMenpWYMwIt79bY5LOw+pflNLVQUEcjTqEZVdV
         rmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179394; x=1718784194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0peaNZhLAYYlwx3S6SyDRjFOc80oijdq9uefxoNUiC4=;
        b=daY0WMgRPNQOMSoQEWAdTLG6kny0bd0F7z53VtggUt83O0Fn0iq/6LYMv4M8bPmezI
         1Qm7L1G3c1fNqmhY5s1l7eolbBjg1RBMCbUl3ssSFxPnbiS9L0SE+vh05h6G5zY0Mvbo
         c2pFWu11at99piRke34Mfex3ch80K0Z0In3AepuH8DKK3HzhDhr+skijlslrydI6T6oc
         CpKnbeCh06LvU9GI6rkN/yLOulc9jeykq0IBoW5my9oppJRvUkEpn0kE2uwd4CIJYZZP
         cek8Rxf+A5DcDaaTeYGUKtHJvUosRJTT0rC0ijiCtKqxQ84XduPZ7r8yxrMlym9IWWRM
         rlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbNnf+wwZO2vMpT383/GL5uF5xBzh+5HP+hmhGrfPJr8OTCXSOUzHAjrZTjzkQayRqxIVZYCits1l7ba885PPO8MQPylUxFqzm1H0Y89Vju/qePkfuWyruCxRdfrdmnVvv86sG5toK
X-Gm-Message-State: AOJu0YxIlZ+H1SolyQvic1hwNc090hnLD+RsHeY8wk1VlBKI4YWX+doQ
	yVhy+TdcIOpPWDSWrGnTQ1/7V9bDuYnSBxKBXWHxG9PCjTrikmu/
X-Google-Smtp-Source: AGHT+IGqMMyBtHRJLtcZfeGgT+w8f/ckFpg5TXSjcTXDhlFiQxD6VagNzyt0dNCKSs0kJ4g9cJex0A==
X-Received: by 2002:a05:6358:883:b0:19f:4fda:4163 with SMTP id e5c5f4694b2df-19f69cf6be3mr128981555d.1.1718179394223;
        Wed, 12 Jun 2024 01:03:14 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de2886034csm8831226a12.88.2024.06.12.01.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 01:03:13 -0700 (PDT)
Message-ID: <f1d22f8c-50d0-461a-9e7d-3d74a286adbb@gmail.com>
Date: Wed, 12 Jun 2024 16:03:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Update the translation of
 dev-tools/testing-overview
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Hu Haowen <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240611044358.25689-1-dzm91@hust.edu.cn>
 <1c3c4698-c70f-4b04-ae96-a83c3b9bbc4d@gmail.com>
 <CAD-N9QXY8frJmxp+LWM9g2_8UdubzMushMEPGyM9Z-UFEHfN3A@mail.gmail.com>
 <5961a584-dbb5-40e7-8e25-69eb7aefcdb1@gmail.com>
 <CAD-N9QV-LqraTPVgt3CayyPKreVRR3S4SvFkwkqPKkVpuegJcw@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAD-N9QV-LqraTPVgt3CayyPKreVRR3S4SvFkwkqPKkVpuegJcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/12/24 9:54 AM, Dongliang Mu wrote:
> On Wed, Jun 12, 2024 at 9:36 AM Alex Shi <seakeel@gmail.com> wrote:
>>
>>
>>
>> On 6/11/24 2:50 PM, Dongliang Mu wrote:
>>> On Tue, Jun 11, 2024 at 2:36 PM Alex Shi <seakeel@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 6/11/24 12:43 PM, Dongliang Mu wrote:
>>>>> Update to commit 42fb9cfd5b18 ("Documentation: dev-tools:
>>>>> Add link to RV docs")
>>>>>
>>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>>> ---
>>>>>  Documentation/translations/zh_CN/dev-tools/testing-overview.rst | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>>>> index c91f9b60f9f1..d89d0ec1d4cc 100644
>>>>> --- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>>>> +++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>>>> @@ -99,6 +99,8 @@ Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每
>>>>>    参阅 Documentation/dev-tools/kfence.rst
>>>>>  * lockdep是一个锁定正确性检测器。参阅
>>>>>    Documentation/locking/lockdep-design.rst
>>>>> +* Runtime Verification (RV) 支持检查给定子系统的特定行为。参阅
>>>>
>>>> Why not translate the words 'Runtime Verification' here?
>>>
>>> If you translate it into "动态确认", this sounds like a very general term.
>>> So I keep the original English.
>>
>> Runtime is often translated as '运行时', so could be ‘运行时确认’
> 
> How about 运行时确认（Runtime Verification）？

That's fine.

Reviewed-by: Alex Shi <alexs@kernel.org>

> 
>>
>>>
>>>>
>>>> Thanks!
>>>> Alex
>>>>> +  Documentation/trace/rv/runtime-verification.rst。
>>>>>  * 除此以外，在内核中还有一些其它的调试工具，大多数能在
>>>>>    lib/Kconfig.debug 中找到。
>>>>>
>>>>

