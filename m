Return-Path: <linux-kernel+bounces-241810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1469927FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A77E1F24EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7E101F2;
	Fri,  5 Jul 2024 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3VtvCB5"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100D14F62;
	Fri,  5 Jul 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143416; cv=none; b=TNRZsh3zPb7LmEqUGreuZ1E3YJyXOSTk5ELQd3PbQUkvdRYbbh1WE2gXCz9Lm007EUhnEUIRH3fsvNK7t6/b3yzpd2USqGpMPf1SxT9qb8H8VrpHW5a30IgIynX/7y5Kk3ntGmxFPb01Awp93BdelUrnXli8/Bk5qVfJklwgjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143416; c=relaxed/simple;
	bh=yL4v1Bf8aCwKb9UKKB0bystqSxkid6nBK70ezd6/cOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmKxdu4/vFgFXLPpK4QqfYIP9FztH6DSNXWIVY0e5Ph514DwU49pkJjoyoTvFgXOs0lhNyCDQysjv+HMF4qQzQaCs0ao6QwAUDPcgUNoK50zztFfP963pHPdeqqSSORbBYKdpb0ziZxH2v0POwd3YGXz1wOZFwDCIVwHHYWNks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3VtvCB5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso770242a91.1;
        Thu, 04 Jul 2024 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720143414; x=1720748214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=797MGZh4pKMji8G0g384m17buoe/FTuQduxYYUII8eo=;
        b=S3VtvCB5Ns+KDoed8SlvC6sFxY9TmSBv9AgKeRLosplnv0XmxQICNGn787cNwLEHTd
         3fctBJ+McJbbl5kiLHtoPPB7R9tLuHZseV1WMeOLPG5PksZJXKCevLMskKL6lBY1oaX6
         gvuGyfRuQYuNFfKwQ8GnLBvPTPouPZe8nWGNmcNLbeROpRG73h0mUhUDRu1d5xmHKKBf
         EVcm2aSdad2vmU7gu28uJKkNQOZwpaScycz97B3f8cq+IP2cr3Ez+tWn1y1spxjvevRm
         CDkmnCoCrjuZRLqMTDIH70qKXlODYNNE7LGKE+O6n6ofP0vqJohV9m/fh3L+8Q7zPsl4
         q2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720143414; x=1720748214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=797MGZh4pKMji8G0g384m17buoe/FTuQduxYYUII8eo=;
        b=oJKM5jthqi2O0wRNZGYVSVEU8+E1iGAEfleozrwTiG9g3wFz7rLw8zN86UlcCCo8FG
         8bb7LcsOcHBYY/eklruCk763QFnMCCflSWx07MIcdL/EpiEGJgSWcc6efOLfcqW2TCFh
         Ul2BRwTBP6NSSoLmGB5apCNFl2/v48rb69Z9N3Snds2aDyS1XfB+I0/A6W92SnG7xB35
         RZX058i2nVuUbRpkEgog71o/PQFDPX6nL/BiX/NTEiLpQ7Pubg4pRHv+2U/GIIrP1J8k
         w1AlKJ7EdG7N3KkA+hFQvpckLXpLvngzY0LjVB5CAgDE2VhDGOA8iY4vkIzePPQgJ1An
         HIpA==
X-Forwarded-Encrypted: i=1; AJvYcCWrDqGckJG39fY2AJo2s3iZQT+9nCREbBVqzQ6SDh3c9E/cK5poSOE1nNh19r83lTn6JW9Kmguh/I3i2nMCWv2tWu6TxKqdvkGKfpOwEUsnnhn9qIqREAbs62feHQyroh/cZbNwPyil
X-Gm-Message-State: AOJu0Yy1HSCDYPbrojFGnXl+bLADMz4S7XCnb1w1PzMo50fq6I68RVZK
	O3ELDBQYQXkLIxPcceZyH4ntG1wP0y9UUKRsZcCffTtRQ/R98ME1
X-Google-Smtp-Source: AGHT+IGxqw3fE8YVHzHCegO8Dx/0HJUFwEnbLxnWVcQw78MCYrxJWbdceUNPyNT2cDz1rdHQ/QfO/Q==
X-Received: by 2002:a17:90a:df8c:b0:2c9:984d:958d with SMTP id 98e67ed59e1d1-2c99c56b640mr2480022a91.22.1720143413822;
        Thu, 04 Jul 2024 18:36:53 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa621e7sm2193861a91.41.2024.07.04.18.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 18:36:53 -0700 (PDT)
Message-ID: <dba1d0b3-db90-403d-adef-b048681e1deb@gmail.com>
Date: Fri, 5 Jul 2024 09:36:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst
 translation document
To: Tao Zou <wodemia@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240701064153.62303-1-wodemia@linux.alibaba.com>
 <87v81mrs5f.fsf@trenco.lwn.net>
 <27A4A1D0-AA90-4F36-9F34-FA92E1B4415D@linux.alibaba.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <27A4A1D0-AA90-4F36-9F34-FA92E1B4415D@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/4/24 10:02 AM, Tao Zou wrote:
> 
> 2024年7月4日 07:07，Jonathan Corbet <corbet@lwn.net> 写道：
>>
>> Tao Zou <wodemia@linux.alibaba.com> writes:
>>
>>> Add translation zh_CN/admin-guide/numastat.rst and link it to
>>> zh_CN/admin-guide/index.rst while clean its todo entry.
>>>
>>> commit 77691ee92d4a ("Documentation: update numastat explanation")
>>>
>>> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
>>> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>>> Reviewed-by: Alex Shi <alexs@kernel.org>
>>> ---
>>> v4->v5: fix one typo error
>>> v3->v4: replace "在有无内存节点" with "在包含无内存节点"
>>> v2->v3: add space in origin commit tag
>>> v1->v2: drop the useless label "+.. _cn_numastat:" and unnecessary "=",
>>> add a commit tag of origin document in commit description
>>>
>>> .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>>> .../zh_CN/admin-guide/numastat.rst            | 48 +++++++++++++++++++
>>> 2 files changed, 49 insertions(+), 1 deletion(-)
>>> create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst
>>
>> So I had applied v4 - it seems I neglected to send an email saying so,
>> apologies for that.  So if there is an additional change to make, can
>> you send me a separate patch?
>>
>> Thanks,
>>
>> jon
> 
> I want to ensure that the separate patch only contain the change from v4 to v5？

Yes, I guess so IIUC.

> 
> Thanks.
> 
> Tao Zou
> 

