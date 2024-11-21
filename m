Return-Path: <linux-kernel+bounces-417115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958BA9D4F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B035B2548F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95A1DE2B8;
	Thu, 21 Nov 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dKhQmlsN"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25511CD1EF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200524; cv=none; b=nBJylHmtFkMTYliNRs0CG2dRoLpXD4rQguhzJ6uxBcLrOlyx+jngMdcoq82LXvJl1jIv12SDbWu+rDcyZf6stTjo3fS4ShLDweIdkNSmGiwWHFjcKAU+6vfx5TvMXG0O+cVCROoyET1qlD7Ab78r++S0qJvvj3Yaba+6KrfeCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200524; c=relaxed/simple;
	bh=TkBTKpH3aXj0wtalhRKKWC1rCMI58nmYToz/lj46LcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIMwtX4NmL5QbHjv/OqrKjwMdh3vLgf6OTQhrRf8F+dX87RnjPG3Nw8BBvBow9MEe9/FtK+MbXrZjnmd8dIwlir0KgROtVzp8jDMwLEPWT96KStPzBuYv66V2sPbZE1iFl8TutD4xK45nEB5NaeeYrdaPKzXDAT6Jr7bd3GwXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dKhQmlsN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71808b6246bso484078a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732200521; x=1732805321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/yyPh2gYADep3K00l78HVuhtV1AcQLAqad1spZDG7E=;
        b=dKhQmlsNmeQ7L+gqljTfmAeE4R/uO4rpKlPebt5DJx2GYlpLWVer5La8QFOOtq5Udk
         OCmoT5Xnccba/CZlx9atotU4GjTQB2BOLXLt7hI9eAujTCFaloyCV3B3uzIvfh83romi
         7nRmXrBV7xz53tVdHJJvEw8PPTQb6p92vPX3SRORmn/6oR2M+bIKyRR7p5AoAjqOzUS+
         B4rnW6LNrmEJ1h3EwLJp26RShDFH6ubI1xf0nxmai2WgI3LJHC/EZbP4SXfJhvNMiYq5
         UQItt6hK45pnh9FiTPa9FaPasjN495/UKfKGFm0bZZ8fS7gy1JrII8lPlVesWjasYmMv
         kNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732200521; x=1732805321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/yyPh2gYADep3K00l78HVuhtV1AcQLAqad1spZDG7E=;
        b=qcd/ufAYd+VZN1r/8TqiJwntiGC0CMG0nWAg3xPy7Ewv9Blb6U3T0KLqYmgC/cCVAP
         WLiDX1PQfCcWtGV9RTsVMPBg4SBfG0CA1ixTbebzAe4c+KNm9FzF33X5NSNEmrcEf+O9
         yPpKGb+wPwe/PBTJPJ/WK/+7lUNo3GdnjRCxEvhhNgzT2tDLfnD5AC5XJPUvyOpmuCID
         /iyX4ioAU0Ibjc242IF97gQhM+Zdx7PkQsoVCvZQfzApSE9RrN+5AInEpYe876V+lBMn
         ACR/uCdG8XgjCBG68bh0DHtyaQxXaTU3MlWvI+v3Qa1Wvj/EfusoRhXpOpld/R79LTOe
         8nNg==
X-Forwarded-Encrypted: i=1; AJvYcCV++Uob5bNzGh2p3QzdvoxHEFcyqhN7KB1IJRsWniOoDMGER9upUOnJNMNYqonVt5DDnnpbQ/eWv/rbYt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRU+/OLuJ4tIcUFJRNs1dZBpelZ/teXBSwcbIDSOjLgk2Rvme
	xwLE3iS7JSJMTJkTEO8L5jBX7XWzNRJ2JE12782T9of2TVy7teDr2sX1X8XjciI=
X-Gm-Gg: ASbGncsWcTKAxTEgUS5jbiyTXDa2aKbNRYkBTyuUvPs6kmJzQsm+lRhfF2H5svb9emw
	KaAYM2iSEI6VExNR2X30NxcxNg/2Uo8CyizTPrh5lAvg4HLBJvjsFBEVKqZDpQkYYP/YagYeFQV
	BtmoRiQWARvuvBUoIMdDjEEky6E4Y59Q759tE/hi/7DBJlNJTy0l7J1W0GsSwU4GOvY+TGhhimU
	6zJKkDXsgEQDIPYlIsdJ7p+wVuyzp15ldlV+4Dv7HYJYA==
X-Google-Smtp-Source: AGHT+IF3WISUvOR5rP2S/JXDHKW/JnR6H6H6uTHhtXKPM58Ro1f2seFsCNDFThU22eEt1VyFmpXGbQ==
X-Received: by 2002:a05:6830:6e85:b0:709:4757:973 with SMTP id 46e09a7af769-71ab31c0cd9mr7422132a34.23.1732200520971;
        Thu, 21 Nov 2024 06:48:40 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a782138b5sm4471379a34.65.2024.11.21.06.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 06:48:40 -0800 (PST)
Message-ID: <2d7aac9d-8c47-45e1-a058-35e1de80db22@kernel.dk>
Date: Thu, 21 Nov 2024 07:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Webb <paul.x.webb@oracle.com>,
 Keith Busch <kbusch@kernel.org>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121045714.GA20680@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241121045714.GA20680@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 9:57 PM, Christoph Hellwig wrote:
> On Wed, Nov 20, 2024 at 06:20:12PM -0700, Jens Axboe wrote:
>> There's no way that commit is involved, the test as quoted doesn't even
>> touch write zeroes. Hence if there really is a regression here, then
>> it's either not easily bisectable, some error was injected while
>> bisecting, or the test itself is bimodal.
> 
> ext4 actually has some weird lazy init code using write zeroes.  So
> if the test actually wasn't a steady state one but only run for a short
> time after init, and the mentioned commit dropped the intel hack for
> deallocate as write zeroes it might actually make a difference.

Ah good point, I forgot about the ext4 lazy init. But any test should
surely quiesce that first, not great to have background activity with
that.

-- 
Jens Axboe

