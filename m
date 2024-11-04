Return-Path: <linux-kernel+bounces-395204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F29BBA41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DED8B22A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B011CACEF;
	Mon,  4 Nov 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wXh7YonW"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9E1CACE9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737282; cv=none; b=Oql5Yx4jvduKUQ/qz+aM2m8ZOMO53KIsI5FW9Gnx1uxBVXPTXCUsgUoPiKslL8WDRr+E0vFt8tXIzBBP6wAbCJZPrPJulGTYVxPqVkNl6C76LfsW/7dmkel4BGaqE3AO2MV1IeWTGLgWh0qC9IP+7dcMHeUG6oCCfayBp4WlENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737282; c=relaxed/simple;
	bh=dBAhqXHq/slcTX9bzaSb/SxdvhUAiLVaNKzH65NStRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrPXXn/sAbp68iNqhkr1urH+h5j3wYcufELWRt8sKNefHl4xSFZVDrMma0tvDNkADJnXtUJwbg+p0ZiZfprWxL8t1m6QOnAf7mUeUQRN9LWttlaVvYPfr7LEcv9HF+WtoRNRm9GBGpmsNceVTP32Mjz+hsVYG80IyaEsuazDCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wXh7YonW; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83aad8586d3so185650539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730737279; x=1731342079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCkzIY8lvwR9jW+wCfLD+cI8Ga+TdeAOk0nkkCBQsQo=;
        b=wXh7YonWbrtNdBbfjrQhlyskOVGRK+RJUFVABt1yS1YbNy4b51uyLZASvfcTyRS9aD
         fZEhPpAaT649ZRcNS06qqJMY5DA96W5UuCyo4Yt0MWhjk/mvllOR6K41lvSinr8ouhtl
         erxIU8HO3Q1zc5AwrCSpT4+krmhxbCQY4p1JXhIEAdAa2OYS3m/RrTLt2LTnNpvm0amp
         zgkOlY4bZePBDqopEmFC2vEMmQiIxSCdoz7RoiPdwysHBkf5wIYbOfceitQD5jobQN5v
         e0nHJ65NfKuqUjvdcZIDzGzi6ukitkBLrXg+3y0mEDQ1FvmBQ+qXEbMg+q1y54zG9GoX
         GZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737279; x=1731342079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCkzIY8lvwR9jW+wCfLD+cI8Ga+TdeAOk0nkkCBQsQo=;
        b=qr4Zddl6C84NQ3ZJNnJ3ESDfR7Dpp52rmWhoKBHYZjlM8mZF2vnREnVcQT/cqbEgCC
         yVk19zSxuYf4SGXIKutAjRipLwyzPxX6PpZKAxFMpjmK1C/ut+o/IAo43odwo1R5BI6j
         lWQu1WJ+AkztGcP0PDr6eq7kWYclwS/Eib/bIKiNqFP64XjCmXPhh5Tdkn+mt53oyCzu
         iiJqIg2q6v/gvDwoDUJhayMgw9I49NMAjA3q4lGMorXzhT2vQM6qG0D61eihsY7+rAAN
         LcDxrhugY05LyEXWj2uLB/IpPa78YWc2bHC8NGZQvZoVuBikDhWixSUyqfuYE1AIWUUV
         Kudg==
X-Forwarded-Encrypted: i=1; AJvYcCUUMHKRD74slfFGyaPCFDcmeQmkVvHeg2sSkxXTEjMg5dNcBHs6L6W/is+HmuXD0VM9ONepPh8Hn9gAM1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEG4JvZBE6SRe/a9J6xX1tGo7D6naLGS0GUeMYxTTismyetSa
	0WAAmTzy3DCKNZz37JLss29f+5nZ3Xo3wNQefBQ+fbkg2l0u0fqlqkYVGuEvCaU=
X-Google-Smtp-Source: AGHT+IGJL1lpTcBtghGCDf7hbxLLzoSwJTdYMgCJ1xLFvofscrqNrruIJpFPUg3EAiZP+n6NS61KYg==
X-Received: by 2002:a05:6602:6405:b0:83a:a96b:8825 with SMTP id ca18e2360f4ac-83b7180abc0mr1338147639f.0.1730737279382;
        Mon, 04 Nov 2024 08:21:19 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67cd14casm224576239f.46.2024.11.04.08.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 08:21:18 -0800 (PST)
Message-ID: <ebb71378-7224-45f6-b47e-3f89eb446fc2@kernel.dk>
Date: Mon, 4 Nov 2024 09:21:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/1] io_uring: releasing CPU resources when polling
To: hexue <xue01.he@samsung.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a9b7a578-cf47-474f-8714-297437b385cd@kernel.dk>
 <CGME20241104072914epcas5p2d44c91a277995d5c69bacd4e4308933d@epcas5p2.samsung.com>
 <20241104072907.768671-1-xue01.he@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241104072907.768671-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 12:29 AM, hexue wrote:
> On 11/1/2024 08:06, Jens Axboe wrote:
>> On 11/1/24 3:19 AM, hexue wrote:
>>> A new hybrid poll is implemented on the io_uring layer. Once IO issued,
>>> it will not polling immediately, but block first and re-run before IO
>>> complete, then poll to reap IO. This poll function could be a suboptimal
>>> solution when running on a single thread, it offers the performance lower
>>> than regular polling but higher than IRQ, and CPU utilization is also lower
>>> than polling.
>>
>> This looks much better now.
>>
>> Do you have a patch for liburing to enable testing of hybrid polling
>> as well? Don't care about perf numbers for that, but it should get
>> exercised.
> 
> Sure, I'll add some liburing test cases and submit patch soon.

Thanks! Bonus for also documenting the setup flag in
man/io_uring_setup.2 as well in the liburing repo. If things don't get
documented, then people don't know they exist...

-- 
Jens Axboe

