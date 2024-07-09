Return-Path: <linux-kernel+bounces-246668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28B92C502
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76946B2156D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC517B027;
	Tue,  9 Jul 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLrdNL4L"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51413EFF3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558303; cv=none; b=p0mT7duX11cZX45szibjYXDVAOGIHIzM39AvmT1/o+878J9bVYQbuZ0teDPZwkWI8NBADsD6tTA8xy1AR19DMnUl5IPMoG9HtIAo2OfWNzf1np8Kq18HR1MGoU/PueArlxozgg8RUzaV9AN1lnZNEk9pfQ29WGWdhwwPRHu2qt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558303; c=relaxed/simple;
	bh=UIhfklEojLDQfKqDzlwiV+qYzjKtVVw9UeAmeQy8piY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAIn7Tbr3XeKRhFJtWB0t4E7/SieSuG9zusnTSOTMhK0w8DDyct7h7apUBDaUtkOToJNuA1/Xj8xgefoqVffYlarfdE6eD5+/FbcljtDhIrILTUXYCs52VYxBl9ycpzl5QLWhHkY8IJFVB8neNoQGrm1GcRIheK2fA/PFJ6ywiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLrdNL4L; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f7c41f1bb5so9067039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720558301; x=1721163101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIhfklEojLDQfKqDzlwiV+qYzjKtVVw9UeAmeQy8piY=;
        b=cLrdNL4LBwexBw0Rf2vbE8OdTGPXW7q9388zZGwNYv2BfNP8zrC2KZkQU7yag8aJ+R
         l27pDZHQLvIzuRdpilZEf1WfP3DHlPF8VPUBA42f+QMjemKrAl+gqxJq214a4yh0+RdV
         BFLDujoMUkXA+P49BWhjE3zx1R5TGPrK+3W9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720558301; x=1721163101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIhfklEojLDQfKqDzlwiV+qYzjKtVVw9UeAmeQy8piY=;
        b=YMDkrEPUXwqivlCGYzdKzNUvkG5x7204Y8XQWuMIDVSjfDjod5bQXdOkhXUIwAPpIm
         X0z0LJd4Zacf1eVQ9ZUkcvKIb/hYP6X7ggb3ZRiBsZwtYZqq4hAxBFAa9nxg1tUYLSi8
         aplcmFFJGs9P1vTR28hGSvI9w/87B3WbKGM0NVLMHHF+238y2JVQ8d5rBOfn0tv8MZGj
         HvVt5GBMeoR6E7ycR2stC6qyEynsygAO/OU2skpYU5Jaah1Cr0JvAtsn7LOEDG5DqUvB
         CsPC1N6MzE3IgJenod2XE+QHPicFn7u9L73Gua280dwXc92IMV2+ZdRydxL9VJgYmx46
         Q0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBolSM6IZ9uKHZGM+0/g0gNnAddtTH71AGw7S/QLWlMTi3xryVd/RsXl7RyeEzbtvyZ3wfW8IqsezEiZcqwyGZeI9k5aZM4067XV0U
X-Gm-Message-State: AOJu0Yzx0kCiAESfKV8nOkslCdD5mrmFjJ+F3dcrlJe8+fHcrH51Oo2s
	LBI3fs0eGd8NXN0wP3Wm0a6b2O+xHa+Tb6vodAR5Quyx3z6NFYUdn4S0qx5vHSc=
X-Google-Smtp-Source: AGHT+IEqMVN2v6iXfRRRelBibAQXZalOQUm9pKB32R2RN8hexYBdUR2mGYYnXtQP1/9U74HqyIxrgg==
X-Received: by 2002:a05:6602:3413:b0:7f9:90c5:4107 with SMTP id ca18e2360f4ac-800023b5fdcmr489122939f.1.1720558300852;
        Tue, 09 Jul 2024 13:51:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c138f9sm690522173.148.2024.07.09.13.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:51:40 -0700 (PDT)
Message-ID: <78c3ed1e-32b2-43aa-9979-0479fa524018@linuxfoundation.org>
Date: Tue, 9 Jul 2024 14:51:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
 <a08e6846-2f9e-4fb4-910f-b33fe779fa01@linuxfoundation.org>
 <49c14f8f-0c08-41e0-b987-7c4253edf6de@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <49c14f8f-0c08-41e0-b987-7c4253edf6de@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/24 14:40, John Hubbard wrote:
> On 7/9/24 1:34 PM, Shuah Khan wrote:
>> On 7/4/24 01:24, John Hubbard wrote:
> ...>> Muhammad Usama Anjum (1):
>>>    selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp
>>
>>
>> Usama and John,
>>
>> I am seeing checkpatch warnings in this series.
>>
>> v4-3-7
>> WARNING: externs should be avoided in .c files
>> #210: FILE: tools/testing/selftests/x86/fsgsbase_restore.c:46:
>> +unsigned int dereference_seg_base(void);

This one looked new though.

thanks,
-- Shuah

