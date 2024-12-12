Return-Path: <linux-kernel+bounces-443849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4619EFCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FD11885A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6971319D074;
	Thu, 12 Dec 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vl4+AByU"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541F25948B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032580; cv=none; b=PheafNZ48ElR3mHjWVL2rkOEVTeSD/LkRDxHsp33rT+dzGIEhigxLu0i1o0nvVyr6tUFSm9jrk3RwpH0AL3n/ah4+YRS9ZeWxGJsJY+jTlu9NeFxRJ4mpp5x2grP2cv4QnncWAUYFq114iuDYlJplCkLsHrp3b5FzkeunYBqnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032580; c=relaxed/simple;
	bh=ilGzeqQgwKDqInE7XqZppmifWO6c18qbaF6m9OcdXDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMg9AHyTavB8EeZya6ZnYy27QWk8zMBudgRDBN/zrW4baH9rAvUtC3jVxbpNSRTFdCNMcN3JS/DeKZaCMYN5yvIa4FaZ6TP3NE+y5G8K4LyPcbsSBdindbEPipjBP5TLuglBPeQ0M6Y4mznDoURLZUFgC4cj6dMmuYN4AWb8YCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vl4+AByU; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844d67eb693so73706939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734032578; x=1734637378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhDmuOv8D0FPGG5XFhKNfHx/yrYt1RrFNY2Fyj/oQ9Q=;
        b=vl4+AByUpelQwsqaqwxQ+WEvTryAifjEe7wgRSxM1X1XRdo62CAxhHYj0Z+Bcypxo/
         B3KZdSDh9RvV+UafV+1Q+G3CDBFQEXcc/mHVZXmSUzT4nqUU3riGJLSe0NaLwJffQEEK
         30vUl1uKD79N0jdaQ2/R/UIudxsLiPkFP0EEtaphHedw3gWam+TtpLV1lSr5SHZkyD4U
         PRG6HrYqx350XnDOyMcow0JJBUqKsUYbx8+YmBbiBbrIVkEoB/rjqNs8f2vP4WPxbqtX
         Gm09pUZDQ/TT+v0CMdLOPEEG5qyM1i9nHNygyha97K0yysMGtD3si2lKMOCATXqpepL7
         VLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032578; x=1734637378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhDmuOv8D0FPGG5XFhKNfHx/yrYt1RrFNY2Fyj/oQ9Q=;
        b=pUoJf5f9Pu5J/5zH9kGrSqYyKXug5OfvzNSufCWsU5XyF83QHoloK7zNE3aWtpi/y7
         eNupLew0fAit51bErpwv8YAjPbSAqm1Oxj9JmJcWFUpBvS8xJCBvAbERgQzKoV7sLfoe
         W/fXs+UfeD+dskFROMll8tZzGobEh7RkNTYzP57aSFtZ+pIAPftMAmC9jExhKxtnrkVi
         xgubKiyTnxlts7f8VU0egotEOTGpQcbI5AmbVr924nEIlwelyIJ/itPAcZ4nptVE679L
         lmLJqdFXQrbUNZnnatfMvq4Gy/fMoPCU2RyF8nsKQ7N6uDPdP+t8RYvX/nIGD7VbvHiG
         CEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwWjhS4YzsLrSnFY0Bk5BAVTUJ+KyxPQBSTbeb+1Ha4y7ngM2qVnmZ/DleYBpnfm9qsT8j0nyIRwI+RhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ44gMz8yfG5/ECsAhbev5PNnq9KqRA7fpEqxgQLeM0EYYFkS1
	0k/S9ty63qGujOW6HGbVtuOjxcEmXgFo2wV+sCO600J0Ei14px/qacW2Sv7sTEA=
X-Gm-Gg: ASbGncsdVqo6VMobky1g7NVB4ZRGrKmehN3jgozEUwV/8tfmYNubb4p4o2n2nhrYFRj
	BSjd+GN7HWh5PikoPS7NleJiwqK9F5LLQxvI+ODeVzpuXKrX0Gzvf/ukqq8kNPUj2EsLSl644mr
	bUYOKA/rOW/48By7oOpfnh4iWSoy0cTMitKayviPkEjlXZe/NDnI6YR0N4Y2/c2FgxPnEsCo04f
	xq3ZcnIub/CX5oTApft8VCgxuI6GMAkPhx8O+mx1nljndlTT5Cv
X-Google-Smtp-Source: AGHT+IHQ9OAQ1Nl/Tv0zs0jea2OTSq9Ds0NCEUjCITYW+rg/1DwzcINpTvE/QeiMM9NbTcw8U3uY5Q==
X-Received: by 2002:a05:6602:27c6:b0:841:984b:47d2 with SMTP id ca18e2360f4ac-844e88eb5b8mr11787639f.14.1734032578245;
        Thu, 12 Dec 2024 11:42:58 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2ce6fd116sm1623110173.134.2024.12.12.11.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 11:42:57 -0800 (PST)
Message-ID: <47a26818-8f15-4189-8d53-0fb11bdcb03e@kernel.dk>
Date: Thu, 12 Dec 2024 12:42:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] fs: add RWF_UNCACHED iocb and FOP_UNCACHED
 file_operations flag
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-9-axboe@kernel.dk> <Z1gkg68w-G9151cC@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1gkg68w-G9151cC@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 4:22 AM, Christoph Hellwig wrote:
> On Tue, Dec 03, 2024 at 08:31:43AM -0700, Jens Axboe wrote:
>> +	if (flags & RWF_UNCACHED) {
>> +		/* file system must support it */
>> +		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
>> +			return -EOPNOTSUPP;
>> +		/* DAX mappings not supported */
>> +		if (IS_DAX(ki->ki_filp->f_mapping->host))
>> +			return -EOPNOTSUPP;
> 
> I'd argue that DAX is always uncached and could just ignore the flag.
> Same for direct I/O.

It's more of a safe guard in terms of the invalidation requiring extra
work for DAX.

-- 
Jens Axboe


