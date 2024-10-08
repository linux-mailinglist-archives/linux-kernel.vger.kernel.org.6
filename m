Return-Path: <linux-kernel+bounces-355282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCBC994FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AC6B25D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C91DFE04;
	Tue,  8 Oct 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FR/gX1cE"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368231DFE21
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393887; cv=none; b=ug7jIAOfopVhHmGp5UIWxnxDQDDc0o96yBwWLT1prhe/tGV72YguxJ8QXzu9IU+tt9NPo3Hp26fDTchFiGZ8dRQehwYccFdbqLzwRjDBv+nUKtCsnWde0zHjIKpAXCxy90nKTMFET1UJ+eYZIT+QwZhPrzGwZK9GjAx3cdNHJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393887; c=relaxed/simple;
	bh=1JLses5T18eVEvY7yJFIthwSZIRfibQxel3VlN8/p1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQ8hrzCLy0Z9XP96hu7EHIdC09agen1xLPErXxBkm4SQJVVf7pUvpSpmYVUH8EhF4p24NVzTZz/quQEZPTYjyEe3TlAVzvJXtaKja3SAhjwWvigSp/j3uqHEkWJ6HnKu1IpUX4RmmzhUtd4QPIOq+x3164tjybWMTFeDDheSbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FR/gX1cE; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82ce603d8daso206437639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728393884; x=1728998684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28072l0Erbe4n22Upxqml8PWOL8yMC/7DRp754ESGqE=;
        b=FR/gX1cE+Ua4vk1IVYUdrjsVnIp5UNRU7l67u1mcqoJ+oSNhFlsSwHFHnCfYDFZcLX
         +9CLd3aLqq1o7wrQX3CJcdFv4AEWawoLsiv4R3hJa8z+ULU2PUv/ZWcPhrsZjVw8pCzW
         8hZjoQNJM+AFCzoNAqxWNKgjb3gmArLRvMe4Z2sTD7raLHSKjFVT1fVf1PZ1gHM5/OI0
         oMeuZQ662oBWCQWhlrZ4VUn6Sl8y7/YffDfPlK9Zd+Hj3k2QGCfI0/SiE46sxF4dbNle
         hAqBlSXTbHR/gBndJ4YEsSuVbxUpAaoGHXJFRcQhVSFShiy0faYRRwYEzj6jTO+aPENp
         M+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393884; x=1728998684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28072l0Erbe4n22Upxqml8PWOL8yMC/7DRp754ESGqE=;
        b=YwvVD6JrZCoO+0pCfFz4n+hS9rtZalt36Lul1Fm0mg+QriIL4Tu73rCdQryGuMM63J
         1mKaiC/w/BMG2lt0zvtpmu/cPlVC3Bmxhj+1+UuNMF2MYAzsF8mpROJSWSnZN+ZOXSwj
         ACKB4PRxuWTLQ7Me/eqquTJH+R3f/5Qs96axYQqqdnFc3GHlumVg4IZTSYUh4EMgy17r
         4bLJRwIUfIjajRsRjNgn9Pg57PCYQosMhZjFyZNfTVG4gTvipd1aLDJcvh+8EEbl4KHO
         GP2d/tdm1L6xiyiKzT4yVL9PBtWAXdIsVZfrebVcPI+A1SFyg2ncB0KVDwGKW55bDd5m
         056w==
X-Forwarded-Encrypted: i=1; AJvYcCUDyJcy8dAwPx1+tfyN4+HRggEQ06FgP+FbNc0OB17fa0QxU/HcybQzlp/QxP5mtdHmPhGIDpigRaoYw0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtp1rqN7EROnIU9szdaYG+jnIZWhIlR9x8d74Xys4B/deQc3+h
	0JAkPQO6xog6QKjJ8UznRp3iC0NPkgoa7mOQzmNunG/7xi8i7fqlUXkHfVaLYqM=
X-Google-Smtp-Source: AGHT+IGfOZKIuFNdtMdRAw3DEguCQsc9zo5vlP2DhGPcapergjoIAvlXruUxK0+QvW4hpGWp34IswQ==
X-Received: by 2002:a05:6e02:1e0d:b0:3a1:a57a:40a1 with SMTP id e9e14a558f8ab-3a375976f0bmr148548075ab.5.1728393883943;
        Tue, 08 Oct 2024 06:24:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ec2a7c8sm1649767173.128.2024.10.08.06.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:24:43 -0700 (PDT)
Message-ID: <fe10ee8f-1220-4a1d-a25b-efaaa314699a@kernel.dk>
Date: Tue, 8 Oct 2024 07:24:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] block: partition table OF support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 INAGAKI Hiroshi <musashino.open@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ming Lei <ming.lei@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Riyan Dhiman <riyandhiman14@gmail.com>,
 Mikko Rapeli <mikko.rapeli@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Li Zhijian
 <lizhijian@fujitsu.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com,
 Christoph Hellwig <hch@infradead.org>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
 <172833255295.162249.16483920948700467749.b4-ty@kernel.dk>
 <CAPDyKFoueMwVfN+P+tG7zT+-iUs=hghsRu+i9mNiHGw_9tcwBw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFoueMwVfN+P+tG7zT+-iUs=hghsRu+i9mNiHGw_9tcwBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 3:10 AM, Ulf Hansson wrote:
> On Mon, 7 Oct 2024 at 22:22, Jens Axboe <axboe@kernel.dk> wrote:
>>
>>
>> On Thu, 03 Oct 2024 00:11:40 +0200, Christian Marangi wrote:
>>> this is an initial proposal to complete support for manually defining
>>> partition table.
>>>
>>> Some background on this. Many OEM on embedded device (modem, router...)
>>> are starting to migrate from NOR/NAND flash to eMMC. The reason for this
>>> is that OEM are starting to require more and more space for the firmware
>>> and price difference is becoming so little that using eMMC is only benefits
>>> and no cons.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/6] block: add support for defining read-only partitions
>>       commit: 03cb793b26834ddca170ba87057c8f883772dd45
>> [2/6] docs: block: Document support for read-only partition in cmdline part
>>       commit: 62adb971e515d1bb0e9e555f3dd1d5dc948cf6a1
>> [3/6] block: introduce add_disk_fwnode()
>>       commit: e5f587242b6072ffab4f4a084a459a59f3035873
>> [4/6] mmc: block: attach partitions fwnode if found in mmc-card
>>       commit: 45ff6c340ddfc2dade74d5b7a8962c778ab7042c
>> [5/6] block: add support for partition table defined in OF
>>       commit: 884555b557e5e6d41c866e2cd8d7b32f50ec974b
>> [6/6] dt-bindings: mmc: Document support for partition table in mmc-card
>>       commit: 06f39701d0666d89dd3c86ff0b163c7139b7ba2d
>>
> 
> I think we may need another merging strategy for this as I quite big
> changes in the pipe for the mmc block device this cycle.
> 
> Would it be possible for you to drop the mmc patches and instead share
> an immutable branch with the block changes that I can pull in, so I
> can take the mmc changes?

I mean we can, but the mmc changes in here are pretty self contained.
I'd rather avoid rebasing the block tree for that, given how small the
changes are. If it conflicts, should be easy enough to resolve.

You an also just pull in the block tree now and resolve the conflict.
There's not a whole lot in there yet outside of this series.

-- 
Jens Axboe

