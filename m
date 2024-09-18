Return-Path: <linux-kernel+bounces-332918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9197C0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED671C21298
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389181CA68A;
	Wed, 18 Sep 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsFJpJBm"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08094175D20
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691123; cv=none; b=k0PQEbMBq0JkiD0ViFsvEUS23Hm8B9MyggT2mRkjnYbfiCdOQbFRuQC9a+lsOzVF1cIgmOqrxayZ7Y7sWhUua91eVBPleL6l3EmLOQjHKMBKtkD7tDVZHWDd73yChBIC71mE2V7RtfFPS38bTgaeciiJfnbz/qwMkU4LwFJ2fL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691123; c=relaxed/simple;
	bh=00IIivnKHCyYj4kMwZxliiaTyfljexgRYW4vAMt5Bdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4ZwS0B9CNjEn/k2msD3eKamVqexvo9XLB21RYno+8L62v91Yz2ST8/RQiVONAjEZfGM94XYUJycywuBVulY/UBPl6KKgErjlCw8g3Dvsvo+nYL8/RqlrQX8V53z/I13w7HKTKFrkP5FYV6gHxsYfH1eXAnZeV3/qW0ACLJqs78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsFJpJBm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5356bb55224so140988e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726691120; x=1727295920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00IIivnKHCyYj4kMwZxliiaTyfljexgRYW4vAMt5Bdo=;
        b=KsFJpJBmQ6VaV280RCpzxExuSSilJ70rJLO1vKHtBtPUXRGHFGtXObrl6s3oQFQa5A
         Iqs9LZN3juuIRnIa86kOGPRd3kZZ6x1L/UeI27EyhlCdE2sUZuTDYzAaJfZ+b8qOA/w4
         nSoerrbz8a/TvgjshwQdz0hJapwQFrwhPqmvTYHb5POUoawWSC3ECMkZuajT5Vm3y1Tv
         S/R6HUDVZ/r4YpuyZ6SjiDrwDDZdRd3yHw1KL6MURrx2tyd1D8ZKl0MfM+/hkGVpW193
         drEZm0nOutaiGBd63j4bWmltYtdQTT+ZT6t0WcvRwode8j+Nvj1vklXz5t91Sw3tsxhe
         dNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726691120; x=1727295920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00IIivnKHCyYj4kMwZxliiaTyfljexgRYW4vAMt5Bdo=;
        b=kRfLO3yD4bYoPP3/9S0Ko3WI7ZzKq1b8rJavWJK0FBgB8r/DuFhqo8YGRlhFd/nzL/
         LYhEjhwfFpU8+IdW9UYs192VamYhT6NdHn9JcFHr9C4E5rVItdep7erUQ1DKOSOegWSq
         hSswT5hDJgdy6IhzXXwIV5n7xruIGNAwv39gzI2oxII8LEMNdNTC5vpoq4T768Sf4kzb
         U2F8IqSrzW/y0ozK+/l1w8j/qyaXsH5nXCWdmR0UrURP4iyAY9zfQH32UZGqzLuqSrXf
         czAaUMprEHyPFObQRCaxESFH4Fo8uy4rvLLi8EhOS7sSSlgQNKA1gX+IYShRP5kPYB7A
         OMdA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Mbbf2A9pSoQfBlhAzStMGZnd+BnXIixbsbaLqGAZEZkXZgGmuLacdjdBrlHqx/8Xi8CwFEHLZCjGI4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1D9uzPpb1JO54nkqmWeUePMyq4y5lZ1O0pgpbXyPskEnjOqU
	Cez68wH0tT2odXXkHqdQK9Wv59kmr+D9CTAPeu5HYnsdaTxsM8dy
X-Google-Smtp-Source: AGHT+IGY9P/tvzF6SQi/FRSjzyqlTmH9aGTrZJHlJfQfV6A4DlEuYll7a4/ixIgNcOHdfTGS6an/KQ==
X-Received: by 2002:a05:6512:230d:b0:52c:d9a3:58af with SMTP id 2adb3069b0e04-53678fec3dfmr13139452e87.49.1726691119350;
        Wed, 18 Sep 2024 13:25:19 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a85fesm1610116e87.207.2024.09.18.13.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 13:25:18 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <96f609c7-f185-49c8-a9d5-a26bfd093b09@gmail.com>
Date: Thu, 19 Sep 2024 01:25:17 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
To: John <therealgraysky@proton.me>
Cc: Borislav Petkov <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
 <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local>
 <90d5a756-e534-490b-b451-7c855183ebc3@gmail.com>
 <JDkDAyklisK_zhy8Ecsw8Z6t4ALDO1Jzzza2DZjWefD5erI-tTPGD6GhevyIp1Ee1xoWg1ouqkMCOqcylaqwZg2YBO7h9USi0qzCIRotUBo=@proton.me>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <JDkDAyklisK_zhy8Ecsw8Z6t4ALDO1Jzzza2DZjWefD5erI-tTPGD6GhevyIp1Ee1xoWg1ouqkMCOqcylaqwZg2YBO7h9USi0qzCIRotUBo=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 00:02, John wrote:
> Yes, that is my git repo.

Oops, I didn't realize that.

Even better then! Could you please explain where the performance gains should come from, considering that the kernel force disables all SIMD extensions?
https://github.com/torvalds/linux/blob/4a39ac5b7d62679c07a3e3d12b0f6982377d8a7d/arch/x86/Makefile#L67-L80

I.e. if we won't have them anyway, what gives?


