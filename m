Return-Path: <linux-kernel+bounces-414737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF09D2CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DC828133A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901EB1D26F3;
	Tue, 19 Nov 2024 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TmEqkdsc"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345B1CF295
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037352; cv=none; b=bXlNv2QDFBplvGEMc1a+ypwjqCbGiWQ7xOCivXIutJ+Nh7kKhIpm1SKoAW9v+ytVLuRqae2oN9SVLTtBbzxZnvTHbwiexMktbR8csTT5k8J5RRtQFApLfbqX0/jR7VRqWxMP+MUocxgQ5vp/wbQ1vYCBPwy3Ncap2/H26vNtTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037352; c=relaxed/simple;
	bh=NAR/nYD1ONObW9M5Y6Nu7xBND2z6aY9gheHLZ5QECSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtKVe4X0AHuTCYPeOkmvvJrDwMHqPUkt8/VmbHnDtN1KYiJX9gjaeWSFEABCd62JXGLdXWeF2o48SD/2rc+qGNPBPBB7tA3jpMiNUc3BR4nBes5rI5/0MRlaM6UCkSF6MY9z7JNx9E3IwzsB3qcXXdtn39V+HdRH/TYBXkXcWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TmEqkdsc; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-296252514c2so4046971fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732037348; x=1732642148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZqf/rzV/enyEQoKu+qG5C16+XBOSUGmk2XCOowBhkg=;
        b=TmEqkdscN0C10IKLN3NqGqyBSGuEVQPafNARpri8B6+16briaoGzrE84zo87hkkerk
         1RyYq3QuveKf9pSlGcPWudRdIYQIP+P97Hu23Z8pjP/ULPYaOb1iz8soWi+v7lpBT4uh
         X6mLK1raxJh/aoWD3r7iQP8MmlNY9ydvjYSXqGy6In+SBrHaU+x+TMcdt9IzIQ2p3NB6
         9h7t3GaCa8D2zAn/DqaazNc4WA1dioB25t52MSitKa+8X4+tP0a5YvpNfJh4lpvOnKJn
         yfgWmVjVBMwLLJR7PbuwZ1ZceECZvVb1aVvxzAnF/V0uzAO2NEmVBDtYV79BhKMomZs9
         dx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037348; x=1732642148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZqf/rzV/enyEQoKu+qG5C16+XBOSUGmk2XCOowBhkg=;
        b=QIxExm2M/z4RjLhBSe4pMUk6xfxKxfJ9e1DghxAtifJwigqtZX1ulekEVnnhGHwwej
         ZDr4fZ0g2ziumZbFQzZApPI5OJ6o/ctqVC42ifbxxIZQEZLXva8zy8//gp7cOXCNaDiG
         idnBdPXqHGFvZPDF/m7kNSmGNDAkjxmGJ1O5E1iKrgfLDhC8vESIKhHQzPZHJy7CMtL5
         ysUEcNdyUbU5OfX5I/Ftezw26EKhE2Uj41UX/QwlKRUsgFfu4yJrk0nMdwvkvyc8EYt/
         PVk2yLndzPcATXQDiUuW1VAnixJb1w1GMNdNndAQwrRA8v7gSnSzEf4RiVQGojkZZGi2
         KAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEsBxkqzZG9Ckvhd0+HpJEC0m/eC33h3YgZNkYjyH4E0genwOpxN+SAJY5TjZ/4sGR7wzOOwxJgm8KSTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+6cZQAfHaoURTNSUaaX2/FtC9pktCM1M5CC0yAtmF/rTAIxU
	r8P8Qdj1EqM6aCrxL16DWf/nnBWMBaewDbaLmFVi+k77JfoK3MmiFRQonpvfVSQ=
X-Google-Smtp-Source: AGHT+IHJ6klaCz+cZRMPU55WfhGfvbrqxerpIOI/Kc/FHDZ2o8+OUXcPX54+5uCKm12FYPvc3lDXEw==
X-Received: by 2002:a05:6871:7b03:b0:296:a888:8bc7 with SMTP id 586e51a60fabf-296a888ad79mr5001318fac.11.1732037347947;
        Tue, 19 Nov 2024 09:29:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651945b8esm3640928fac.31.2024.11.19.09.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 09:29:07 -0800 (PST)
Message-ID: <4daaa186-14f6-4d25-939d-90b9b2088051@kernel.dk>
Date: Tue, 19 Nov 2024 10:29:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] RAID 0/1/10 atomic write support
To: John Garry <john.g.garry@oracle.com>, song@kernel.org,
 yukuai3@huawei.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, martin.petersen@oracle.com
References: <20241118105018.1870052-1-john.g.garry@oracle.com>
 <ef021fd8-1cfe-49d6-a6a2-c9745cf61441@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ef021fd8-1cfe-49d6-a6a2-c9745cf61441@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 10:05 AM, John Garry wrote:
> On 18/11/2024 10:50, John Garry wrote:
>> This series introduces atomic write support for software RAID 0/1/10.
>>
>> The main changes are to ensure that we can calculate the stacked device
>> request_queue limits appropriately for atomic writes. Fundamentally, if
>> some bottom does not support atomic writes, then atomic writes are not
>> supported for the top device. Furthermore, the atomic writes limits are
>> the lowest common supported limits from all bottom devices.
>>
>> Flag BLK_FEAT_ATOMIC_WRITES_STACKED is introduced to enable atomic writes
>> for stacked devices selectively. This ensures that we can analyze and test
>> atomic writes support per individual md/dm personality (prior to
>> enabling).
>>
>> Based on 88d47f629313 (block/for-6.13/block) Merge tag
>> 'md-6.13-20241115' ofhttps://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.13/block
> 
> Hi Jens,
> 
> In case you are planning on sending a 2nd batch of new dev for 6.13, I
> think that this is in mergeable state.
> 
> If not, I'll repost for 6.14 later.

I think we can do 6.13 for this one, I always do a later pull week after
merge window starts. And this has been posted previously as well, so
probably no reason to further delay it.

-- 
Jens Axboe

