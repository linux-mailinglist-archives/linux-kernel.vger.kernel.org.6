Return-Path: <linux-kernel+bounces-186620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FF8CC66E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5976B2186D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62D146008;
	Wed, 22 May 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py7Ap97+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D7145B34;
	Wed, 22 May 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403150; cv=none; b=ldKu7JkjRV6Syxnb8U2f0DdJ9YV96GtkjhhFQCCFF3u8oM4OVwID2aO/XoeDBBUwXCgcAUQ0jznaxxEzZp7xHqvgNSL7iInyVPlBkCDekik+S6uok8sx4XN6T4WpkHAVt4loLQpNUbd0+Iv3z3ro85ZSB04r0weNOz4m+87I6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403150; c=relaxed/simple;
	bh=zBORLGfwEDM1w4TyfaRsoNqVkhOG4wegvCBhB3v3QGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaybZYiN3GXMshjhwx5OaDg4At17eram2VtTnNRdbEvi+zVXRssxj3todNV6J65eypOkE2vw2x3CAmz4Ix9rjXkARNwgzKydRc6XRhMpZxSLnm+/0pEXJl27LMnGjDBb/eLF1clB5SR2G6wk+3OsWCH3cqLNak/1aA5F2Qf6PzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py7Ap97+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e724bc46bfso45183011fa.3;
        Wed, 22 May 2024 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716403147; x=1717007947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WowmymhSQgb7aeMuyb2EmWdDvfH/2EO855oEziB1Qzg=;
        b=Py7Ap97+5kTm2tq7a99i5soGS+TB56wo2SQIhxd5jkDOA6P72rhYbY1PY5O48OxcMp
         DPPVqa6TJXrvp4DEMcXJs9cAkExczRcGwdifou6Eyu6Q4dVYWoOHa9K35OjwGJTZj/B+
         RDDRMWhTHfNv6FtQIPyZqO8u6exSu2Q7A3IedrLtZTHFHlaCy0CQxVkHQGg8fHBX4dny
         rpd8iie1KdAF472aBS0eO1po0nAVC9ZB2lwZ1IvpTOVfvZ0oKaYocRD/Dacb3/aFbkOB
         CVa0atbH8c2hqurRBG+rp2b1yD71McidKL4oZkEJjN1c85ZLDjsIx+xgECpCd7dRWISG
         aTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716403147; x=1717007947;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WowmymhSQgb7aeMuyb2EmWdDvfH/2EO855oEziB1Qzg=;
        b=oKxGgJncXWpEdGRVVWifFhCX/rA8OaCDWo2mE5DwGE6y/O3dN36Rn+WU96Si9yqJS7
         7Ey4OkjH6lcX8zsSfeQnNL3setCg5b1X4hiqDWADIthxJjQkx7A52yCw1XAFtBbi4/ve
         kgLn/EhTf+cpg68g9zmGmSJkBXR5Vjo/mdMTlAhgUYOglyk8wSj3RLJKC7+INL+Lp5OJ
         bmanHhqq/f/41JgIJoicsKFxrLbjrAb8KMWQnLBQIEh0UMvZ8yVdElQTHX6atdZMmaP4
         4Wnbl4QBj/ozbcdGgJQ8sivgidUPucKSce351VJq4z69f0gXmyOpuoN49GZjfnA06edz
         UieA==
X-Forwarded-Encrypted: i=1; AJvYcCWvQeENFCi8aPOknVV5E0oEE/CCwcajIE/mpIOkSg6pLTZ/b2Xlc4ztBkp5YYrBg/5msYwlQ8V7A5fMD7Fzjpmzm5pblH0M2coNyiNOp7HNFvV+TtZJKF0ZdG55tvyLQlxzPm5ssXhr544PBPn9L3vDC/7GpCgJL2Rb8A8NSxl6Ao6nvVmb
X-Gm-Message-State: AOJu0Yxm+mWIxAPJsqvEf89HLVqoO+M7cGdsuYmk+OGjVLF3nwi96QTa
	ky+dTEBmyhW2a1SperwtEccfrm+nuQgNF29TxDtZEYTTLG3Pgixj
X-Google-Smtp-Source: AGHT+IG4RBP0BkzL05EFItPmMq+sTkT5KD18CXqpi+UCTb8LIu1W9femaNsd+zD6c7pzhoWEn3+j7Q==
X-Received: by 2002:ac2:47fb:0:b0:523:ab19:954b with SMTP id 2adb3069b0e04-526bdd47d37mr1714892e87.17.1716403146853;
        Wed, 22 May 2024 11:39:06 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-523aa2645c7sm2535372e87.167.2024.05.22.11.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:39:06 -0700 (PDT)
Message-ID: <2d2b0047-ae08-4a76-bada-6bc92f443544@gmail.com>
Date: Wed, 22 May 2024 21:39:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>, Mithil <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lopez Cruz <misael.lopez@ti.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
 <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
 <CAGzNGRm5i8zvnXiPzMg5=+tr9oyBcRA8LFvnmgGzE=MzSNTXug@mail.gmail.com>
 <e384272a-4dfe-4653-8983-6426f8803c84@kernel.org>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <e384272a-4dfe-4653-8983-6426f8803c84@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/05/2024 20:07, Krzysztof Kozlowski wrote:
> On 22/05/2024 19:02, Mithil wrote:
>>> Yep. And testing DTS should clearly show that conversion leads to
>>> incomplete binding.
>>>
>>>>
>>>>> I assume the DTS was validated with the binding. Isn't the case here?
>>>
>>> Mithil Bavishi,
>>> Are you sure you tested the DTS?
>>
>> dt_binding_check did not give me any errors. Yeah the example is
>> different from how it is implemented in the kernel ie board specific
>> (omap4, omap5 etc). Should the example be changed according to that
>> dtsi then?
> 
> Binding needs to be adapted to match DTS or DTS has to be fixed to match
> binding, depending which one is correct.

Normally the DTS is written based on the binding document and the driver
is written also to follow the binding document.
However in this case we have a broken/inaccurate binding document and
the existing DTS files and binaries in wild have deviated (there are
boards out there using qnx or BSD and use this binding), or to be
precise the binding document was not updated.

The existing DTS files are the ABI, so we cannot deviate from them,
unfortunately.

In this case the DTS / driver needs to be reverse engineered to create a
binding document.

To note: I'm also guilty of not updating the .txt file.

> Mention any changes done in the
> binding which deviate from pure conversion of TXT->DT schema.
> 
> https://social.kernel.org/notice/Ai9hYRUKo8suzX3zNY
> 
> Best regards,
> Krzysztof
> 

-- 
Péter

