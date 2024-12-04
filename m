Return-Path: <linux-kernel+bounces-430383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814379E303A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FC3162360
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278D63C;
	Wed,  4 Dec 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g0wGDd2n"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A136D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270704; cv=none; b=rTRNEK6vEHdoKkkm0n/rvalmKeCeW2Z9XkiShXmVHTHTnYmli8Wxkd7vz+5jXwosFxtvnJ+6AX7YlKZFM5kBTrQov8WZ7BQh9hA8Bkfa+35YG/UdDcazcetkLp8mpgR8OiPlwjzWaK/wWvZNIobBsxUWWb/QxnVDT0IlryW0A4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270704; c=relaxed/simple;
	bh=MJz5Q6WP36oLbDCYEDo9s9YkT5LQztLrq5XVv/x2PuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hELCe3P3Lw7P8Ojpx8jzDRfMvoeGlmdfpdnIdgFKcBOZRdoYIVlZeX5kJSHYvjM9gat9z19EwA5OX64lFZByzz4INDtABmpEM+a5+mn3/ZcL9KEkx2lIVRLcfa5STKGHWL/jdd06AuGYpVNWKfiDsoAHytkn73Dw8KgItM1y84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g0wGDd2n; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8419f5baedcso196552739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 16:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733270701; x=1733875501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcQiqQOQOLDzcbxMsNRL6FHp793XZtkKmMGhhmXaiEQ=;
        b=g0wGDd2nq7ATini0lk/TOpiZ00R7XW7bGj47kvOPgT12qTYsiMMUN92WDE/8U4SBv9
         F3zvyJPGKnEeXulPxG58kUB5WPZZfWkLogEV1DY/YKH62DiDJGQfIRB4xmNu3DsGmXX/
         4neE7GVS26cwzGSPE5DKsCVQT9l65pdSdn9UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270701; x=1733875501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcQiqQOQOLDzcbxMsNRL6FHp793XZtkKmMGhhmXaiEQ=;
        b=lXJZHNKScCEarlxWL3NuY3o5TMFIGiVN2amMiN0czn1qHSBQSekPodh/YJ+Ydx7kWY
         IfROqdpE6lBDBaOOF0nk3BPUqiPQc40/1IIChHzqho5YvQWK9M/Ce7ZbNpNhrdmD5nIQ
         txBTbracjU9UtSPm9NiNqALrZmarREXYzgvM4TMDWuAiPx9Aw5IQGs+kurYDf4Q87yhe
         jWLkX4xEEXS5kG19kiiQtjYTZNNkmjZLQcFGxcUAkVjYkpOZmWFOdbJ4YOoiXCheBm+h
         A7RqUjqUMpYDcR8xvv3QhE1PPJ2kikvynj9Yk2Xk7kbIv/oY5MSDEmrGEivrMOrZi0YM
         8agA==
X-Gm-Message-State: AOJu0YwxbZbaeMHlPALkXkDvp9pRA89St7ou7TYodeXTJ1k3+SkyXFan
	Ak9hHK5dW2vA3TXvt7u1RohSAAYqTxATyxlmETsqzSX/sTceVbNaeZsTqGlMgAk=
X-Gm-Gg: ASbGncu0qJyQRtaktzXsVu5txjhVvw1/ZXrXNQQRMKtrYJX9HFn9dFVMk4MkLNLIUmu
	BU0ejQMhArpf8dBsPFg6LcX/3OeA9elvQjMk1Qm1C0IFviTt4z3rt41zXgkiqIx+xJ/KeSTwUmm
	7UP37R1KC0mj2HTBa8tRn6UAHcrpMH2uf+PuPDWodzDmAmYHwU9OMF2cm0fGTgH2w3EBWannsXQ
	X3mchGcAc+b2IEAN5reLa3dIOlz42mdGot83+Fr6U4KYjUu3apwbDuQeGLtvw==
X-Google-Smtp-Source: AGHT+IEuBsfvLAIn0B2ch1wXp59X/LnGAMGWoWpDRa905GI3J8nxVMtFYz9+kA6MT1Q5jhAPDjlNzw==
X-Received: by 2002:a05:6602:15d0:b0:83b:5221:2a9b with SMTP id ca18e2360f4ac-8445b444229mr637981039f.0.1733270701238;
        Tue, 03 Dec 2024 16:05:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230dcc3fesm2851291173.61.2024.12.03.16.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 16:05:00 -0800 (PST)
Message-ID: <b2723ccd-bf0a-4d9b-a545-f9e3dc336539@linuxfoundation.org>
Date: Tue, 3 Dec 2024 17:04:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: support DT_GNU_HASH
To: Xi Ruoyao <xry111@xry111.site>, Fangrui Song <i@maskray.me>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240915064944.2044066-1-maskray@google.com>
 <f229fbad-731c-4dd4-8c66-ff8829c2c958@linuxfoundation.org>
 <c828b254fb93bd136b36d3a06ab1d9d29ce13d88.camel@xry111.site>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c828b254fb93bd136b36d3a06ab1d9d29ce13d88.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/24 04:44, Xi Ruoyao wrote:
> On Thu, 2024-09-19 at 09:37 -0600, Shuah Khan wrote:
>> On 9/15/24 00:49, Fangrui Song wrote:
>>> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
>>> obsoleted for more than one decade in many Linux distributions.
>>>
>>> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>>>
>>> Signed-off-by: Fangrui Song <maskray@google.com>
>>> Tested-by: Xi Ruoyao <xry111@xry111.site>
>>> --
>>> Changes from v1:
>>> * fix style of a multi-line comment. ignore false positive suggestions from checkpath.pl: `ELF(Word) *`
>>> ---
>>>    tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++------
>>>    1 file changed, 79 insertions(+), 26 deletions(-)
>>>
>>
>> Quick note that this will be picked up after the merge window closes.
> 
> Hi Shuah,
> 
> The patch seems forgotten.
> 

Thank for the reminder. I will pick this up now.

thanks,
-- Shuah

