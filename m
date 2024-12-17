Return-Path: <linux-kernel+bounces-449540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60229F5090
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D096E16BE00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134E1FDE1B;
	Tue, 17 Dec 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gavZpxsf"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49901FD7AC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451133; cv=none; b=jnCEns/6cu/08FPIx+yVXlZxlK0Uh1PAOV1sQ5INAeqmWM/lvOOHAuL3RbsA+jkTS064ul5AXvScQRXR29QNl7oFUk+xyD6OwP523oF6rk7giqfpyQcgsuzAvIyb0l4mRDksTqqlhRWCHsOXw+ygb5M/cQiIg768zIptTHzJHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451133; c=relaxed/simple;
	bh=gsA5pAyjtX0qVT2WbTkVDtu22GuA7Mebo18DhBH1U0Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GKc6v9LBw5elrNT6Q5TOYf73p+pzciem+8swgKi3cXXaJmimxqWK515CLIqfTdGkW3h89zz69L6f3Qtu8yYUpgX6xahv2FC9wd84jKuPVvu36DQjYPLT9B7LtMyNhzxt4EmKQX8tiZshBrJeYZcG6sqRH4CWi5VVMXZzCPqzj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gavZpxsf; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so193936439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734451131; x=1735055931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZJT06ty20H6WtPaauact9KbtRVZiQjgmvMtjzhq0hVc=;
        b=gavZpxsfNI0TJlgmt13LrvQVS+6Iu7bvdt2GB/FyO9IJqlKGzQU1kSGX+9JN8EH2DX
         a5MseuzzeXVRZA7Uvi7iXDjw7/5iuJ8axH5VyYwaWizMo/wTwrByMfBLDKEr4L8yS9i7
         1FL07joLEHAIRy0MbBF0ArTTd6tGxzbskNQgxBsTo8qmiZI21pV7WcB4pWESLC1eXHJc
         uHncGniVdlGhlot8ps4EEm3tILCrYzrJvmNHf68pX2RjVzr/7iZw+mKlXKOSCKWhy+Ha
         pGu6/O/rW5zvV/7W+fCGdI+Q8alIkekjgCxuoEpPscCPFCWDgcxUrTa+noNmAojlcI/g
         5/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451131; x=1735055931;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJT06ty20H6WtPaauact9KbtRVZiQjgmvMtjzhq0hVc=;
        b=ABdOYcoqXYsvJDsqSY/PbbJbFoCCwNTw9bzXWb9A8hLS6Ko7mfbfCnbzdnvUU0lkVU
         c+k4KI7NtNMxso+cU/fGg4lFRD6KKutEIWndwiHmiEn4tjxWEM3ACuNSnBqL/e2+3TOL
         dVVsAdUK5W1u10WnjaoWJMdI1xN4NpadXXyMZKlNTdmVF26Fkldt0CSZPSbm8DwTcqp4
         yJ5Q9nHDQVup6NlbI2PAEva78nNEPTklkSLcbks05+mLxwm/DRFkbweU6W+pHuKLv+0+
         BWZU4WVpWnmmTibrS6S8vU3SeKc7YZ8Q6M2pNNxOAJQnldcIVnG8gLlGVuEaoU1a+Dc7
         u0PA==
X-Forwarded-Encrypted: i=1; AJvYcCW47WVg8hvwXlumeckhbAsYF7dTgij6d5JDtnlcNdwLFKly8aFRItAkNqX46t5LXJOwtGORj9rwZhRS/gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhLs4jtWbjTAArEs3ff9bMpzwGzq3e6KmKeBOesrF7mW299pq
	UCRINlRn8nEhYZg8zCY3uJbeeGTyL6XDbforsWOKIzexoSLHzjDpRYR0mJJQoEg=
X-Gm-Gg: ASbGncslv/IvU8kOvgqOLSI1CSiIkZjBMZm5Q93OozJc98J0/3uq8ln8UAg1sPRTO0L
	j8m4Sxe0XgrmCDJ/2aY4Ly4LbvVN91zs8o3k7mS5J1qi/EYlnCKJZQsbmGXF1x6DFIMpZLQKv2S
	wux4lEjx0uEsxol+k+OVLaelyQ95i1RPudzPamxjrjdIL0XJoaT1+C/uw5/VzJqq1aaK06XMsex
	uJj9ikXkjnFBrvFx7PosJEeLjlYAfCxHbZWHr9IAAmbiBa9hjyA
X-Google-Smtp-Source: AGHT+IE65wyIeAPpjgOmu8zfqSd7Oth34NZ1pDfThXWwJjWL1Am00bD9KAdAU8o5NaJjN1gi6luqAQ==
X-Received: by 2002:a05:6e02:1d83:b0:3a7:1dcb:d44b with SMTP id e9e14a558f8ab-3aff60208c9mr140556935ab.11.1734451130910;
        Tue, 17 Dec 2024 07:58:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e036866fsm1751445173.22.2024.12.17.07.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:58:50 -0800 (PST)
Message-ID: <9c5149dd-c901-470e-8696-ae84e0bba975@kernel.dk>
Date: Tue, 17 Dec 2024 08:58:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v7 0/11] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com
References: <20241213155557.105419-1-axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'd like to move this forward for 6.14, but getting crickets around
here.

-- 
Jens Axboe

