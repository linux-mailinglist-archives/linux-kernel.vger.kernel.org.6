Return-Path: <linux-kernel+bounces-266330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4D93FE39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82A01F21CED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3018734F;
	Mon, 29 Jul 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvaUuqao"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF10187322
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281232; cv=none; b=CGbM2smIxo8IspkePFcDPIBCD769YqAm0fS1uypSW7AWcqr2FylpwRaKlOYv8okzvme2md8/IUf9tX42c/Gn6xCWajFBxh4i0jS8PMR7c/ipi6lhGTMVSgtrcH9kD4SI1pCliiobsmgvFX0dEpb3n+oqflkdCZfieeqe5zFJ+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281232; c=relaxed/simple;
	bh=KPAl0JCyGgkO27w8Km3wJa2M5W0ST6/UnzvgrZeKc4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQM5uecY/FQ8/bVieQag4yCyH0UreufmkmrvwuBcOxSBdLmqiauS0p2d0EXoGxWaYSw4YI3+y68mfwTeejJfokoNJYVHhMI9UPxrPs3FM4ItTCri2DRNkioUV6Xm2HAn228S42aXuWR6Ki4g1t2+Tu/a7/lW+PEvYB5dMwQ7+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvaUuqao; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f3c804daf7so21560739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722281230; x=1722886030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cW8vdpmHZjx4o0iwoSWJOQySAtf51wBr3QE0Onm+KQ=;
        b=CvaUuqaoxvv3nNLioYdZQDv4ION/+4NRb1CIt0jamvo3hqqrRDpoR6h/s4ZhbPPxWZ
         kA9hp4k8ygjVVXqwg9JIZVCl32pWykBOwpnx3n3bpLi/aQ9ezF5FkIsTVrY2VuBSFYgR
         7XJ8ZknuOAsRS6yd5dKfkH+bfO3JRSbCAmGIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281230; x=1722886030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cW8vdpmHZjx4o0iwoSWJOQySAtf51wBr3QE0Onm+KQ=;
        b=sn2c+Hn6+A0WeR5htJlPjZHeEZjJHtIpqmbFc+dNUJ+SrdQqEI2z5OY8N54DW3/k0y
         QbEcaNFDnLjds0c7T16tiMwcEexhc/z0V2dBqwWK9VBRckfmrDeHMkTcGmu4+Q+D2mqM
         ITa/8GqH5Uf5p6cocVYjyazZGhDs7PtCMQ7apaHBfsEO2tuSES9C5Wz1SUIObrC5WNAJ
         0ahXztS45620soFo/OTGJvKsR+b755yrDs/F/vdFMXteE57BSugFY5Y9zDMSpXBLFHpg
         9gN20O+uKuLWL406Kq03Hu26KWAZlPi4PXmLFW1fCEyAYxHhHEUQ9nwGtuZTbn7wXvXl
         FhsA==
X-Gm-Message-State: AOJu0YyiCfxhedHowBpz0pQiAv9WH5ZBS/tWKwoB/JXhDV+C/6InHcnz
	8IJQD+J/a/S3sg/I4DrdfhT9go89OroN7qTfMyVnnl0WuIdr7tJKB9nVu4qU3xo=
X-Google-Smtp-Source: AGHT+IHUZkdFsVsNGpZDf2aO8T0ZaQZI+ZlmK97a9tJrrCNC6Ki8EhoG0g0kiTt63koA21WlEGn5OQ==
X-Received: by 2002:a05:6e02:1a09:b0:39a:f26b:3557 with SMTP id e9e14a558f8ab-39af26b37cemr28705455ab.5.1722281230233;
        Mon, 29 Jul 2024 12:27:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22f13f81sm41185415ab.70.2024.07.29.12.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:27:09 -0700 (PDT)
Message-ID: <abc8b199-694c-42b8-a2cf-7d34f45f51de@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:27:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] tools/nolibc: improve LLVM/clang support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <120ddb22-34c4-4d18-8238-306485680c5a@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <120ddb22-34c4-4d18-8238-306485680c5a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/24 13:26, Shuah Khan wrote:
> On 7/28/24 04:09, Thomas Weißschuh wrote:
>> The current support for LLVM and clang in nolibc and its testsuite is
>> very limited.
>>
>> * Various architectures plain do not compile
>> * The user *has* to specify "-Os" otherwise the program crashes
>> * Cross-compilation of the tests does not work
>> * Using clang is not wired up in run-tests.sh
>>
>> This series extends this support.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>> Thomas Weißschuh (12):
>>        tools/nolibc: use clang-compatible asm syntax in arch-arm.h
>>        tools/nolibc: limit powerpc stack-protector workaround to GCC
>>        tools/nolibc: move entrypoint specifics to compiler.h
>>        tools/nolibc: use attribute((naked)) if available
>>        selftests/nolibc: report failure if no testcase passed
>>        selftests/nolibc: avoid passing NULL to printf("%s")
>>        selftests/nolibc: determine $(srctree) first
>>        selftests/nolibc: setup objtree without Makefile.include
>>        selftests/nolibc: add support for LLVM= parameter
>>        selftests/nolibc: add cc-option compatible with clang cross builds
>>        selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
>>        selftests/nolibc: run-tests.sh: allow building through LLVM
>>
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

For the selftest changes.

thanks,
-- Shuah

