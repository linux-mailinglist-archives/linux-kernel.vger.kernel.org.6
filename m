Return-Path: <linux-kernel+bounces-243665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A49298FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4A4B20E50
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4F4DA0C;
	Sun,  7 Jul 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgEh20o8"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A42A1B2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371384; cv=none; b=jaBRSo2udTeOm7HFam+WfOdv+wuQnHw7ch0JYiR6KLWFaz59yeGlzNxY/q8jrI1kISD/dsx16sKKr3OUNOrseMKXfEgmDG/lo3RVUnYaLuMg6oAylvm1Hp0fWinFSRePwNnn64OszTdsfRQUBuE6v4gnlF0FmNdUGvazKfgI5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371384; c=relaxed/simple;
	bh=5DfE6f6Oqj8wdfsRshtMNGXDLkc9ZBAUahy/lkVZypY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NoiR97iCjSxwj/JS2Qb4YxVkpC+PpHuLdv2602V5YtpJb/Ap+CdZLP/LxqdbuJmGe0i5u5kIISObsyAunIpRj7gUk1+eBBAF5w03gzaL1JsBbC5rqBU96IiLBrD4qTBgH3XIiQYroOEq2+qfS7T3d8Gu539NwiR9gKe9rtyqUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgEh20o8; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d925e50f33so731012b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720371382; x=1720976182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3POdzJNyO55ZAiRYuTicBz7Q4S3Y0xjkX8NRlj51LoY=;
        b=FgEh20o8OXuryggpyGl7TjtGoZHz3Hm9DK5lL5MxTwtA+pHJi8DD1jsVYxY8D3myL2
         /jAb5XpRriLWCABUgNy/0+cOeNW4fWn7I6ICDMoK1TXEZ2O9tv95sYx3mfSLhxp/5Td8
         Sto7/23ZBkhnyEG5FcE6+8A9G51E6trDiXWvTKBXPHKLlf0Ny2eCBplyuS2ABgBLAor5
         KKDgJkG0L3O3CDuxgj1JLnDsevgJdO3Cckr/nBH3lH38YK1kIdE0DH9HPlJ/LQ7e2ta4
         nq6WMVYDMBl4H/cndyNxfuRG72+3YMv/CsEbqVzQckDTUuYy5L7SnBL5a+sJUuueHSXj
         AxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720371382; x=1720976182;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3POdzJNyO55ZAiRYuTicBz7Q4S3Y0xjkX8NRlj51LoY=;
        b=PhOnnMQL+jlJE6Ce5cHccgWZqSWcPPEPlVviTRiJBo5FwflDV3yVHOHnx3guaKfA21
         6R6cScvF3ypu7fmR0+1uhwTacQYTX0odatQ51OsIzbJ3y0nknCtSnJ0vtA7AbgJGJGi8
         FFAx6/yp8LdQlRw1Rx4at7mSUF8xZJlj0QhJwbBqVrWZtzC0Ta6Rm6F1Zlo04GYvzyEO
         eJx81OvPwml+M1iZ1L0AQXvxCg9C5crvap9yVkIr5+Lk2iX2kS3YFMbN3Ok2ogeWHCMr
         b4FoQ4v6W/hTfSHeJA/R1+oiq6oSXfaDkyD2mRJk81yNyehkjDYNQlzcoBESTGVcVwVE
         rBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTxHNLVVzZgD9GcHcc5h13UyvywMEX+sNlYyPO+UBMawGcpo/nkEdyVON3sPmZGF5MtEiZGg6Eyxkc3+B6Hfwb5UVXJYulGRMAmQBz
X-Gm-Message-State: AOJu0YwkN8o4pf12Sr9KuLWa2J8hHKj/aH0ZtgymU9QYa3OapYY5IvXs
	CrWmJtSMmNlg++8M+Vr4XkBGkxbVoNhevl4O4waXEcvw8UvHOvIV
X-Google-Smtp-Source: AGHT+IHmxN4t7exVxHh5z9R5U+tDjCe7anp+einTNwkmy/qTnqoiaGh1YcFhaj2/CNdjrmIfYdfI5w==
X-Received: by 2002:a05:6808:1692:b0:3d8:4603:e79d with SMTP id 5614622812f47-3d914c94352mr13987554b6e.32.1720371381773;
        Sun, 07 Jul 2024 09:56:21 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3d62fa3bb0fsm3418036b6e.35.2024.07.07.09.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 09:56:21 -0700 (PDT)
Message-ID: <c33b3a21-b996-43d5-bc52-992bf3444ac3@gmail.com>
Date: Sun, 7 Jul 2024 11:56:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jason@zx2c4.com
Cc: arnd@arndb.de, brauner@kernel.org, cgzones@googlemail.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
 torvalds@linux-foundation.org
References: <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since any PRNG will have the concept of re-seeding, I had to think
*really hard* to understand how a pseudo-generation number that really
means "reseed advised on change" could restrict future kernel
development, so for anyone else following along in the peanut gallery,
here's the scenario I came up with:

Suppose on some future CPU, RDRAND is improved to be essentially
perfect, with the same latency and throughput as a load from L1. So it
acts like a HWRNG, not a PRNG.  On such a CPU and with a command line
option that means "I 100% trust my CPU vendor," the kernel could
statically replace getrandom() with a function that just uses RDRAND,
and statically disable all the machinery for gathering entropy from
events and re-seeding the PRNG.

*Unless*, that is, userspace potentially needs to know when a
reseed-necessitating event has happened.

- Russell

