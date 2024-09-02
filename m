Return-Path: <linux-kernel+bounces-310695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD125968036
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D71282A00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0C1714BD;
	Mon,  2 Sep 2024 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNQlXIfV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B92156C6C;
	Mon,  2 Sep 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261173; cv=none; b=fHjrLhz5Rax2ReniHLpgMgzFEr1e2ZHLXztwEkmddv+eVm2JSvFmn9XwtbwVRoFpXcfDQZDcU5kv3xa8Qa9DpBLhj87v4v4oiIOsN9vtiP8Td55FrM1gNXmSNahD2ngiPbBnXgYaVuIrphL1aHkStGcnwUO01NmFdd9KLKpIG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261173; c=relaxed/simple;
	bh=FKep8l+oV7HR/Wfto8Gbg+6ucFn4AA0TMQUicSzBqf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGTEZgLO3pt2jMBwTUVGV95MRKicJFY5iqDYCaKEJFHY3vNC5t0e0CHTDCKEmbAv0B/5lR7qh5WvOFgpKv7cYbA8IUKMRjXqb0h5fN4ofQlWJQFFWK1Kp9bncaMgOtgp1ZLC9VDWtmXjePPWFFNlcjMmI3z8qy49dIr3WeSqhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNQlXIfV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2025031eb60so33056395ad.3;
        Mon, 02 Sep 2024 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725261171; x=1725865971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPJjH6wjnaMmhjF7ajp9QxgpTUkbKcRgs08eMqfuzp8=;
        b=LNQlXIfV5NOzafIKepaN0C2kqiWX0H5VW2W4TrXP6i3AgEln/Umjw89St1qu1TgfMN
         8daeYC0d/tJOP1+vf7/0ZqqMqajCxZ+/n9mGcwOOgUHTUUEKw1pXbOQfo47PHf+vZaLM
         5mMMqOn68me1T6wCoW44BDYT69S+xFUhRfdK4H/MFTITHsl4y5Rs6rvVGTZ1RZKig6ks
         rh5/vvcJpDLUm8GhVFrFFzCnPwn7C6fI01CUmuKM2zjxSwrvVph+vo+it0vNBSB7uj/L
         KgivD4htT7XY5wXEnNj2xssZQgfKbKbESwargjtWuNefB69ee9KY+NI/mXO3VJXxE1Tm
         poLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725261171; x=1725865971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPJjH6wjnaMmhjF7ajp9QxgpTUkbKcRgs08eMqfuzp8=;
        b=EWhmulq3AfWojs6ijpDG5cZmN2d7H+VUkR1MoKQQ9yCJI9MV7r/hMQbLVKyaXlWoYm
         ex2nZlhwR11dMaQGtshqFR9atXsbxCtsFhQWz+AQmG8Z1I8AQ00C00icWMFxQo5f49rJ
         zY6Mg1/E9Dsf8wjqhMdM7b5THQ5cw7Gxu28/h7pTJs4QIpjqwDJ7JmpfIW37MzUOQFOH
         VYj4l55E55fUP2vL63ztSbJWLiX8fW9jC+zDh4/XeXPDsNSmlg3q4R0eKjUsqv19Xmn8
         fRv35PJuoEYftBgvHFH0kwNXoJuqTqJvEVmysMy6Miav4p7wViol4vXgLi6vV6fgWySc
         /+kw==
X-Forwarded-Encrypted: i=1; AJvYcCUhF39YxOa1Tdi/CpmLZkEeeiW9SxoQWKc0oUGVdBqDPeb61flNfNCAJL7SFRgonFRGc1IJ/cXccHnJ/+Ri@vger.kernel.org, AJvYcCVP9UaLyN4QwEKsv3Vzu5uXVaWx8gxXbH+U55yMNzTlxLMULe8jOFkT1SIQNUdTNs2xliY3DfaWAyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LC1iRLTrKCsBxJrGJh7reYWk9gOsuA/GQxGGUxkuAcdIllZG
	ms5qigTBi2i2ea1buDz1TABxAjQj2qgi1NhIf5EaRHX7OAKutzQY
X-Google-Smtp-Source: AGHT+IFXZKM/8IqDv+Gbczy712NDtwg2wdVmlEzcNwDgfNYlgvz4awzr7Hob1IucqFMlqVTHUdpKaA==
X-Received: by 2002:a17:903:22c7:b0:205:6f2d:adf7 with SMTP id d9443c01a7336-2056f2db09bmr32015405ad.21.1725261171328;
        Mon, 02 Sep 2024 00:12:51 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2055553958fsm24736575ad.99.2024.09.02.00.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 00:12:50 -0700 (PDT)
Message-ID: <14c9d71e-e953-493b-a581-141a58a15b49@gmail.com>
Date: Mon, 2 Sep 2024 15:12:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240831034924.3729507-1-dzm91@hust.edu.cn>
 <0a434542-b207-4bb6-886e-74eff6cc9f39@gmail.com>
 <35904aa5-9851-4894-b953-689904bf33ca@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <35904aa5-9851-4894-b953-689904bf33ca@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/31/24 5:34 PM, Dongliang Mu wrote:
> 
> On 2024/8/31 12:11, Alex Shi wrote:
>>
>> On 8/31/24 11:48 AM, Dongliang Mu wrote:
>>> +目的
>>> +=======
>>> +
>> there are still a lots of sign incorrect. Please be sure everything looks fine in a web browser after you 'make htmldocs'
> 
> What do you mean by "sign incorrect"? I check the html rendering in the vscode. It seems fine to me.

vscode isn't good to show the correctness of the doc. Please try the thing reviewer pointed out.

Thanks

> 
> Dongliang Mu
> 
>>
>> Thanks
>>   
> 

