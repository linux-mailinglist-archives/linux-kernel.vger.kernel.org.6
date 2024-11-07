Return-Path: <linux-kernel+bounces-399907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2329C0626
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DE81C20F70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB820F5B1;
	Thu,  7 Nov 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PW2wWdCi"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766B18FDAF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983762; cv=none; b=N5aj3kpRkZbU4/mq+IwGs1h8pW9CA/QFrIPEQYvmEZoXXY97Va9Viwu2MmolMxehEaxxWPmLPiH3h+Qarf4pZwkwiEyOpFc36x7hq9l6aUOwVVURZue0HN9acM9hvrVrowrp7v3sny953KVByx5WB4WwK7zD+RHALhDjOFumWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983762; c=relaxed/simple;
	bh=YaluIJlgoCCuBdHgOKc7RYey61qon8eAc7qQZACWI6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJ/4gjEemd1xUMw5jYI8nABAcWTyIUD/g4gQLhqVmyp82F0k58afvN0wg2on8ZW7mQ3xVIeCFai8vi7pVLzEkEOG7gF3fg/QnVsFui4MXmpAT/ouYFBIHyXMt4Plq0PtStqykxd7VbGbH+JJ3vzc0CbdYcDIAgPlb0DUH6oS77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PW2wWdCi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so673193a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730983759; x=1731588559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94jLGAE/7l0i/fZSh0MjmULEecf21MaMbr8LKDkqjrs=;
        b=PW2wWdCiGYFR3YAnjIgbVNOebgQCC/2Qaxgvr/BYfuiYaaqrS9U/csDt9DAvPCNWMg
         m/aSzn6/3PHjqh3YVBSWv9F4Y4anApYyqTk2GtgZppszeUIbY/zml7Q6sX9uFFxYldmb
         O8us71BeryylIXg/yuRaSAEM0hcQBvrpRiaUY5+IhwxsbjCRgQxJqAyBexGViykh+oZZ
         Jc/J9Igd+gCJiWDDBJDuTIiB8kQpC/lN5+3c4CIJodB3fOg82FTb/ht7IBjHiKMu0Ixe
         loPXSgZU6HFQ89UmHf83Xj//SEJ2J6QSpF8ICmKZhyvAT2FrqvM3y1I3Ti0Rk7fjSjVV
         tB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983759; x=1731588559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94jLGAE/7l0i/fZSh0MjmULEecf21MaMbr8LKDkqjrs=;
        b=dV26/8gk1PY7JFwE1IaX/kdMMU64hWUg0yZTTwvKtf9Rvd9K+yKqPUK81i7kAvblu7
         rs/XH71Ngt4ow2p5xwIxgdq2JX+Ioxf9Xv+94tykVjdFvJiFqv6by2TdJA57i9VmkJJN
         Uc5h5xlQQObbBGS93dlkyU8Ug14Hpgio1It3gHqak3H7GaKceFLvLXhTrfl/Jv70uqYT
         NcforAmSmonPsOhwsBMyn/Eyd2Pn03An+Mo5Jt6ou22rl5zuT+l1pCLvuyk+mGue7BTe
         WjvzocKXddeO2gf7WuIyhA0M5ubNMBsBQiGwarQ72mD58SO1qn1CXshXJ5iHi0xc/jyt
         /c4w==
X-Gm-Message-State: AOJu0Yzu9kuvVcBdGnBSfAWuM3+QmYo3KaWM3V3dmTC7qMAe7WKEGzHl
	jxmnWrQM3KfksHFpUU1rqnAQDfNbVklt80X+2XoOk/9/Mvl3JqHuybXUeC046qE=
X-Google-Smtp-Source: AGHT+IHX7sxlTETvpS+WLgqZfj1rC52dnNzvMfoR3p6xBcHaEDdnd4Ruh3GT6l4lurUPhTyFKlPYvg==
X-Received: by 2002:a05:6a20:4c9b:b0:1d9:3b81:cdd3 with SMTP id adf61e73a8af0-1d9a83ab2d9mr45744337637.1.1730983759535;
        Thu, 07 Nov 2024 04:49:19 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a56421sm1444525b3a.185.2024.11.07.04.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:49:18 -0800 (PST)
Message-ID: <fa092ae5-d15d-4f53-9de5-d06ebd985b33@kernel.dk>
Date: Thu, 7 Nov 2024 05:49:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the block tree with the pci tree
To: Philipp Stanner <pstanner@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241107162459.71e0288a@canb.auug.org.au>
 <71860affadbd3efe72edbced28b3135924a28594.camel@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <71860affadbd3efe72edbced28b3135924a28594.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/24 1:13 AM, Philipp Stanner wrote:
> On Thu, 2024-11-07 at 16:24 +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the block tree got a conflict in:
>>
>>   drivers/block/mtip32xx/mtip32xx.c
>>
>> between commit:
>>
>>   5080394a8fcb ("block: mtip32xx: Replace deprecated PCI functions")
>>
>> from the pci tree and commit:
>>
>>   91ff97a72259 ("mtip32xx: Replace deprecated PCI functions")
>>
>> from the block tree.
> 
> Ooops, that should not have happened – I must have lost overview over
> my branches when submitting the latter.

Ehm that's not good. I can't drop it from the block tree, I have
merges sitting on top of it. Can it be dropped from the PCI tree?


-- 
Jens Axboe


