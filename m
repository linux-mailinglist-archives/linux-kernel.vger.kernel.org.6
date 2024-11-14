Return-Path: <linux-kernel+bounces-409489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D99C8D88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6604FB2BFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6049148827;
	Thu, 14 Nov 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Re6wsiJp"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3301487CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596499; cv=none; b=HGOFtARlaMMJDfpLSo8mT/TpjqhSxjTBqHGuj83ypIkf2VvNIr0ZhMT6C9SESG4Ba9z3tPGZ1jHA7QCy8J02bz/mLpydeX9RS6Odl/mUmtGclZQDbSSqmlnn1cvGDOimLInbxjbybsvGUfCj1a7J6bFOTAYHDHiNHbaY2fIJNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596499; c=relaxed/simple;
	bh=4UUkiKmzly0OeVpf0QiuK3sDrCQWBp1r1pQik5CtFf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q38DU/JUOJeRAsDOZWSPruLh0IMxv53T3OYV5xgx27DFVaGeFs9jPxvLeMPBleyok/tMUgLS5P8C/RSFHGrL8fSDw2GpT6Ouf/LDbumSJqtNcWESFpIcT8nGCECarKvVuGKx+Vev25h0P+2Gnb4/6A7Ry+mYOP1Yo6BKfuwXO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Re6wsiJp; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so24556639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731596497; x=1732201297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAlff9bmpTU+UEhgxHo5EEloRRnZ7M6S5z4oitiZMxo=;
        b=Re6wsiJpi+daUSUR+VN5E5QIEZC+roDV382qaJ7+hVvn3gXTqiq6MAhrpbK3daGcJH
         l9mAy3hS1WfNFecb8oQcaDO2Rj42RhH1whRr/ejZL5Xl229D3na7NPzs5FfITyKYRcm2
         P9EXGorA9cqzEJQ3P3qxnmBumtg0Rya7fJc4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731596497; x=1732201297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAlff9bmpTU+UEhgxHo5EEloRRnZ7M6S5z4oitiZMxo=;
        b=RDI48Uihhk+7OyPeyVtxDkVN10Fom94cVEm6YXYjxYpf6e7C5CcmpKH1thM+jUFjyU
         g/6mndt70jy+c65KNMEj72AEese83q7Ig1Mp092R+bzHcG5K8yPi1v4xTy7nzgd0O0qt
         Q+BDt6hYE1HW1C356+/LK855FCU3Kr1V2nEfEoXSEtF1lheVKDHAUQ7JWjKfKsPL/KzZ
         4SsaktEaTvQW66jonIrj8L/n5xuGpf5gliWmkmqLnn2PUVhOS/92iq3CUpvQNMxRlEdR
         TRyF1zKVDCpkxnP7ayF5RokBui0FIfrhcqheosw9WhGMl6NK5C/8HOwTW7plUTdMei+E
         9A6g==
X-Forwarded-Encrypted: i=1; AJvYcCUWl1x2vya7spkBqU2Nek2Y86FsbiuR3hCDg0Hr2dFXn3lRa1Kh4EkCKyiYbFYEY5UGwH3y1Xbaqew/78M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQK5S55TDj5g6G+ikwz3961HVSw8IQYNE4vSkQmC/eTMbvIPl
	NA+UXmcmUimm6Cce62LLZUlNCXNyTcfmZ+CF/lAStwO5XycZ0ljf6QlkhBtVQgJwAO9YUX2J27r
	u
X-Google-Smtp-Source: AGHT+IF6veRv5ZTb4rF/6xullZcNRh/vz8AAUc5kClqwB0uhF1UaGwjqPrPpEBqCto1g6VtSb44D0w==
X-Received: by 2002:a05:6602:641d:b0:83a:931a:13a0 with SMTP id ca18e2360f4ac-83e032e0050mr2695903639f.8.1731596496579;
        Thu, 14 Nov 2024 07:01:36 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e02fc667fcsm302006173.62.2024.11.14.07.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:01:35 -0800 (PST)
Message-ID: <2dafc0bb-4dee-4c7e-91b0-01fa66a822aa@linuxfoundation.org>
Date: Thu, 14 Nov 2024 08:01:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation/CoC: spell out enforcement for
 unacceptable behaviors
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
 broonie@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Dan Williams
 <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241113232557.29854-1-skhan@linuxfoundation.org>
 <5rkn65qu2i3kz72hxbmcg25mrq5ehmb4y6xia2p3k4naiogi44@rcaoz3xnqlcf>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5rkn65qu2i3kz72hxbmcg25mrq5ehmb4y6xia2p3k4naiogi44@rcaoz3xnqlcf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 07:38, Konstantin Ryabitsev wrote:
> On Wed, Nov 13, 2024 at 04:25:57PM -0700, Shuah Khan wrote:
>> +The scope of the ban for a period of time could include:
>> +
>> +    a. denying patch contributions and pull requests
>> +    b. pausing collaboration with the violator by ignoring their
>> +       contributions and/or blocking their email account(s)
>> +    c. blocking their access to kernel.org accounts and mailing lists
> 
> Can we change this to:
> 
>      c. restricting their ability to communicate via kernel.org platforms,
>         such as mailing lists and social media sites
> 
> It makes more sense to phrase it this way, because it's really the
> communication that is the focus of this policy, not general access like git,
> patchwork, etc.
> 

Thank you Konstantin. Correct. The intent is to restrict communication.
The way you phrased it makes perfect sense. I will make the change.

thanks,
-- Shuah


