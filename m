Return-Path: <linux-kernel+bounces-227033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B24914773
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84231C23361
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4013776C;
	Mon, 24 Jun 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="G7X9nyXL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5313775F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224679; cv=none; b=d4EJ830SHaxGHEHY8+rhAeP3hqI+pLVdT2iNmO2+O5/en6Z6SB4eXflVlZJC/pE7PQDWYdgCBgarLCJMnQeQ+lRMERjD4lhbn/2MAVZt2gIcZTZT4+YwYvEl4e9hw9rBfx3wnghxY13df4bLwmpqU/qjlEEAWovcX6Eq97N5AAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224679; c=relaxed/simple;
	bh=/m9L7qerUaV8wEh/4Zw411vTKvDT4ojY1dU0W8U2VkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdbyApM472M2jWlrB/91+kva7vSy2d6Mhv/mBOF5LePjLGESJf/kJ+4gHW4R3SYj+IBJm0DqF1UQ6p2Hf3ByMum1wZPHiFnzifkiIa36P577W5k8KsSYmEGsGlFO5R4gJEfmrbqsMPlXuG83kpi4MfRExOJBg6aMM0JJ+oQY95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=G7X9nyXL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217d451f69so35277045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1719224676; x=1719829476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/m9L7qerUaV8wEh/4Zw411vTKvDT4ojY1dU0W8U2VkM=;
        b=G7X9nyXL5W/dBPflDu/nLVHSgJodJwSCGhLhvb+M7qYbMSMRVpL9QK1odQD+X19xaI
         4vGWPX9mjD6b1QudjrQ1nsP47zYNEs4uplWJZFT4pNlNz6vYXqLGI7atftFjSbx/fpu6
         ySHkTXqhy5uxgxhCB7+4VN/336g8/CjmWXayk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224676; x=1719829476;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m9L7qerUaV8wEh/4Zw411vTKvDT4ojY1dU0W8U2VkM=;
        b=v4+FqqQG9tHgyuO6XrnSl3aVXOW5BiCHpz0vuN/vUswIDyjgisDlUT5AZTzPNPTI/M
         s5L3bpMiq3hR6XYZerIcEHWepxpq0absKZnHswQ0H6lMV0X8gCUEFbTwUNUx+0ZjtzCQ
         yuszT68Qg15aiNCFw97uDh66E882dkseXhah9xdcX5Ss+A3PryCUjACah01G8XSRhfl5
         1KwHOQbdfyqOYKDxGlkPicPexvBCQWW9xF8F46jd9Fb39gAZ6SFyH8W7WdNIzAKXhYUi
         wGjEORzU3GIEfoAUnCXIPW+wW/DYp7YyyQ/eHAx4UAQ7Q5WI2zD0UAB2gFHXV26AGgxF
         HeLg==
X-Gm-Message-State: AOJu0YxPopWL7uGinyazqv2YY9cieKsA8uPquBsQmwfky6vMTntl2c1Z
	DUo6YnYnxiaBD11dwE7OCePfBTP/H/+tDUKKg+CkmBBfqdM7g+rHYSrvAtzFD1ADjBWErwryAki
	m
X-Google-Smtp-Source: AGHT+IF+r7fQ+vh1ZrvXhAWL3z8FrRPmClycdK7BAyh58SFOh4v/xZMM4Xf5ridN+ipRIRBenI/S2g==
X-Received: by 2002:a5d:59af:0:b0:364:7f42:1b66 with SMTP id ffacd0b85a97d-366e948faacmr3187423f8f.16.1719224676087;
        Mon, 24 Jun 2024 03:24:36 -0700 (PDT)
Received: from ?IPV6:2a00:23ee:1630:2367:cdfd:357d:df51:2d81? ([2a00:23ee:1630:2367:cdfd:357d:df51:2d81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9633712f8f.96.2024.06.24.03.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 03:24:35 -0700 (PDT)
Message-ID: <d0083546-f945-45e4-a0c3-96794ef76caa@citrix.com>
Date: Mon, 24 Jun 2024 11:24:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] x86/cpufeatures: Use AWK to generate
 {REQUIRED|DISABLED}_MASK_BIT_SET
To: Xin Li <xin@zytor.com>, Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org
References: <20240622171435.3725548-1-xin@zytor.com>
 <20240622171435.3725548-5-xin@zytor.com>
 <CAMzpN2hMP8c9PXy=0YV4Ln+u_1n1spJP2jaYXKzEABWLh0+hkQ@mail.gmail.com>
 <bd08fb59-600a-4dc6-8157-2c432f209df4@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <bd08fb59-600a-4dc6-8157-2c432f209df4@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/06/2024 8:29 am, Xin Li wrote:
> On 6/23/2024 1:28 PM, Brian Gerst wrote:
>> On Sat, Jun 22, 2024 at 1:14 PM Xin Li (Intel) <xin@zytor.com> wrote:
>>> -               printf "#define %s_MASK_CHECK
>>> BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
>>> +               printf "\n#define %s_FEATURE(x)\t\t\t\t\\\n", s;
>>> +               printf "\t((\t\t\t\t\t";
>>> +               for (i = 0; i < ncapints; i++) {
>>> +                       if (masks[i])
>>> +                               printf "\t\\\n\t\t((x) >> 5) == %2d
>>> ? %s_MASK%d :", i, s, i;
>>> +               }
>>> +               printf " 0\t\\\n";
>>> +               printf "\t) & (1 << ((x) & 31)))\n";
>>
>> The original macro had 1UL here.  I don't know if it is strictly
>> necessary in this case since we're using 32-bit masks, but it would
>> probably be safer.
>
> I did notice it, but don't think UL is needed.

You do need 1U, or you'll trip UBSAN every time you test feature 31 in a
word.

I'll note that the hypervisor bit is one such example.

~Andrew

