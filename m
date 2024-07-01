Return-Path: <linux-kernel+bounces-236179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F191DE79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEC21F20F78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224141494C4;
	Mon,  1 Jul 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R6/TngPm"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45882D94
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835000; cv=none; b=DJeKsjbKuxz00/EYSPL5lUnCVhE5A3Sm3acTlvSa6EPGPWSbZTr5QidiagUhw87BCJhfhTzzhpZXz0Ss8LK7N13AokCHlEQ4TzYBk7tox0xIabFXUCCumWY4jRdNyvSOF5Xvho+IcNfgWL7tQKyQWXsX0JivNULwTkzBTUlNYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835000; c=relaxed/simple;
	bh=Jpl22aqYGSxIo+qDQFAsqVJLvtdunm/X7rOU7kbj6Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zz1saF6YMhgRAsL+Dk4W/4GzkxFEC6StjjMnRzqJF1xrYfM82cod0wrYcBBa1er0nhovJoibKREbId0aa1q/WW8H7maxuBnLJdtOHh6IH/CHgU8VsfXSM7Fc04T20Ou2+I//vmtYOK/16RbjyYPWuk6gVoEZG9dKSYfwWD0zBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R6/TngPm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3645e9839b3so1711287f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719834997; x=1720439797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2+exavIfejK38TBkftpQIKDnT/YCEYLfkFpQAOqMrA=;
        b=R6/TngPmQnl30Ku6Rc1iyNvQZEc1Gz1WNCrAE3m13ju5+QnzybSYZIMbC4kBgnEfik
         SPCLcY88gTcntYaB4IgT1ctPlCcXrEBvx5KkCfiU0QyRSfI3aNtO8SqZxujcNfqpujrm
         U2vc+Yr/52g5+KQnr5D8FQZv/Ge3MBJfUpQN3iCR/fagjvRtQ9H7yt60f2v2viOM/IfM
         clwtOQfLc6kul40ttpG42S/ksUJWOrCRFz3q+Sr8IXrV0yG/3YNOYvFJqa6Iys319S2O
         eHR0/oC4OUEdY7ScXg4aJtQ+BYoS15O9TqmNU6+bREgaC5RjrLHOvZXO1z8jdNwxTb+y
         8zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834997; x=1720439797;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2+exavIfejK38TBkftpQIKDnT/YCEYLfkFpQAOqMrA=;
        b=V9ozfpY9pOVfkdEb91N1P1jt6oChQxBksorBJVM4Ri6o2DK403vLpRxr3HUQC0vrMs
         3cnZr2KkzFe/8/NNIzjnRrCZuEzkKWuuGkkZliSudsj8VNa/R5Mzs3hi3nw0ebw55jEf
         v+H7yCvv443OX59e1Rz/Zf/g2x92FKXdutZhcSoVxpX04RM11SGQcqRKzwHwTT1PPKIa
         ewQh9bzXIAgLh9bidd9klk4D8h9+8UFwkFxAMmOfROjclyoAPUuxEApQby2/0nJRtzbf
         0UbWy8Xche+wPzvz9/aRRUnQhWk5wYosavs4yM0sqX1lkjgiR81a/1x3ydVEzLIZZJ1k
         AniA==
X-Forwarded-Encrypted: i=1; AJvYcCXiZToewQR3fA9S3I6K6DpBxabfgHgFlt1pI7WTp/Mgb5TrpEXKTM5YfAJmBNj0UiVqcNG0Z9pcLeOB9S40acKsk/7KbCauo5UyoZ+m
X-Gm-Message-State: AOJu0YywtA1Vuxklbbdo+X7PL1VxVtyM1DyO0uyo7uboQAItiK7XP7gA
	riJ3oNoLIZHxw2twMnGIhQdnX3fMWU8tmAy6YcmUagSJWkae91pMWzcBSoDrB8Y=
X-Google-Smtp-Source: AGHT+IFpMs+kMYQhye2xH/ffra8GqlPW6v2h0K68WUFUlcoi1nV6+1EteASUbtPqnC+84XbNqh3VqA==
X-Received: by 2002:a5d:410f:0:b0:364:d5af:3460 with SMTP id ffacd0b85a97d-36775728ddemr3086296f8f.61.1719834996788;
        Mon, 01 Jul 2024 04:56:36 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb? ([2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb836sm9852925f8f.81.2024.07.01.04.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:56:36 -0700 (PDT)
Message-ID: <b6289862-48e4-41fc-a6e8-0e21c90dacd9@suse.com>
Date: Mon, 1 Jul 2024 14:56:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] x86/cpufeatures: Use AWK to generate
 {REQUIRED|DISABLED}_MASK_BIT_SET
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
References: <20240628174544.3118826-1-xin@zytor.com>
 <20240628174544.3118826-5-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240628174544.3118826-5-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.06.24 г. 20:45 ч., Xin Li (Intel) wrote:
> Generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the newly added AWK
> script that generates the required and disabled feature mask header.
> 
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Reviewed-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

