Return-Path: <linux-kernel+bounces-373062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15769A51A3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 00:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A961C20D01
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106319307D;
	Sat, 19 Oct 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J9T4q1FM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02454192B6B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378231; cv=none; b=sG4EQwrUKaixBkLOIk7yL3epeEuoh5Rfh7AQ8J+hKBTNauvJhcFYzwr0eUC7xr4jPy2kbfj2Nqv+A74RDedGkPTwOXMj0+7yrvihgAOVXQDOmKBA6MMNQwR8PzFcC467U8T6LDsFEtvrUAuikjY9q7/A+F1xltm/5sMZp0Ah5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378231; c=relaxed/simple;
	bh=GWtLMRsLZGe4E3r+R/+P8YYa7gW3X+2YsqwO7F/RACA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f2laulG2EamtWLgDh5r4JmmnvRKwjnEU7nMRL389oEXIGa4CwH4ZrlXgDrQSuTJ3P7bZQdih/W1fEqPrtLeAR6zWST2hnrKH5+CcGT7rv2aT3Nj3PTScm5a5h+ig4foc6g4aod5bwreFYp8oiC+Vd+8p3B6jtmpk5H2P9Bk0CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J9T4q1FM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c805a0753so28259545ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729378228; x=1729983028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=26D6YfFHB6mhMnWiMc1xtXuTg1J0SpdP4FmHa6OeheQ=;
        b=J9T4q1FMkkeUOuyS4kqh3Zv2OOSboClfGFSpC6jAIixz2f9KNR6kl723zJvhjkydQZ
         /Vt3pk8rIoSF3SuWdjR4UjYoKop0DZInd5jHJuuY+Jc4ykJOqJDW5bdzyBxKAE/1XkNf
         CafyFSCH7K/7qoSXE0Pmm5r4E8Qb3Jq305TiRaZEmQv+xnp1TWmihq06CfFT7W8o64AJ
         q69TmcSb4QoTzdqMF3S/nkRnViCJf8GOKqyOmef019Y39RnDBaiMaG37hPmiPKIHas0n
         VoujHkQ5HxToaoAMLEaqcVgkCkCQBkFO0L+S/JT9t5o5040DGf2pll2nsScOTIKIgfJl
         jmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729378228; x=1729983028;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26D6YfFHB6mhMnWiMc1xtXuTg1J0SpdP4FmHa6OeheQ=;
        b=kXFamnUYVaFl25/Ep68GWSVk7y1C3mrht7HJRU5Q/GFT3JpfNTDY29TEYW/Y2Wcem3
         UXptn40L5Nh5uV8lC2D3OjtX6IQtjC/F9b6MHGOZVmoDUc1T178ajMgeqBT/yQET/ZX8
         izb6ZhRO0qWJX+xKKbgPITP9YCvDgNyyMd9YoJpdWDt/iAvuGIAWjy+eU8m4YSoJfj5H
         C3xtL/pUZ1V744A43aORmDNp9+csJmmg6IUx85Rk4z9h4E4qIAJ8giLK7WDClWYz8NLy
         0EnbkVO3IEmDL9mXjLbUk4P0KfZcVMvH7ZpzAnEaAPCWPMRBrvm0yYGKFCfqxbH2iaDf
         aWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpn5tl/6r0l6IthgbKGIKnDetalQDaqZu70EspQ9AXM9GPUO0E8CVMtmw55CCLcP4vrlxwmVROwegtcXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMbdfA0q6KYczafdSQ+pwZkwvNTKUabxj2fMkeOr6/785RVWO
	OLJtT941vHN+R6FPN5zeGpG+SUUByfI/8Je5wNITc2B+Eza6apNd7XtLVstnNrE=
X-Google-Smtp-Source: AGHT+IG/SdolPDBlJgQXRSOz40RufwW0B9RRmCWWNyO7f6sAWOxABQs5hjD2LfcfSRzPBkj3obJ9KQ==
X-Received: by 2002:a17:903:2301:b0:20c:9eb3:c1ff with SMTP id d9443c01a7336-20e5a94b609mr89438595ad.59.1729378228212;
        Sat, 19 Oct 2024 15:50:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd4bbsm2095375ad.155.2024.10.19.15.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 15:50:27 -0700 (PDT)
Message-ID: <d6d920c6-9a8c-49b7-8d4a-fbeacd6906f0@kernel.dk>
Date: Sat, 19 Oct 2024 16:50:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 0/8] block atomic writes for xfs
From: Jens Axboe <axboe@kernel.dk>
To: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
 martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241019125113.369994-1-john.g.garry@oracle.com>
 <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 4:49 PM, Jens Axboe wrote:
> 
> On Sat, 19 Oct 2024 12:51:05 +0000, John Garry wrote:
>> This series expands atomic write support to filesystems, specifically
>> XFS.
>>
>> Initially we will only support writing exactly 1x FS block atomically.
>>
>> Since we can now have FS block size > PAGE_SIZE for XFS, we can write
>> atomically 4K+ blocks on x86.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
>       commit: 9a8dbdadae509e5717ff6e5aa572ca0974d2101d
> [2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
>       commit: c3be7ebbbce5201e151f17e28a6c807602f369c9
> [3/8] block: Add bdev atomic write limits helpers
>       commit: 1eadb157947163ca72ba8963b915fdc099ce6cca

These are now sitting in:

git://git.kernel.dk/linux for-6.13/block-atomic

and can be pulled in by the fs/xfs people.

-- 
Jens Axboe


