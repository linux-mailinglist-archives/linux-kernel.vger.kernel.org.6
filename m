Return-Path: <linux-kernel+bounces-545490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62EBA4EDC1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DC1174333
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0425F7B4;
	Tue,  4 Mar 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h50HTGRH"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB31FFC5F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117532; cv=none; b=joISHOVwk7wnpRR9owtRFPLFbimzDAuQeZ0Z6HSwjY6IRBB8hva0ZpuWTXrOIOGGTPKx+t0z19xMvjSex1YQ8JwzdRgdJPD2COF1nyvWCw6ImCQKdwZUJ2t1+FUuyIV+GAuMzXf2nKbUtnmPBna5UYbPJRx0M+YPIoadOIWtgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117532; c=relaxed/simple;
	bh=cRxreIV1tABCpL9fRZfH6KzlR/VZYK1SWoxTM7CPHC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf9Ja7R1kTqWY6wkFP/VuI9TRegVXuf0HW8V+iUkYpiQRTOnpag7zOjCfW/x/A4kbp+tGYQZlFeoKJPLc/3t6oxg6Q6yuyPBOuDi6oruV9s7AwjYzBV/Pd2D/YO+gnPF1sYeaMC5HbC7XreOKgsd/olq1sBeZiUcdWNb3flvZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h50HTGRH; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85afc05fc40so20069839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741117530; x=1741722330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wlj6wsu/JSvBM4RPZykaf7UYl5o6YxQI8N0Xp4ZZi8E=;
        b=h50HTGRHn++xPcga7XKV7ytlYY8x5eYFCWtFqy2mTTl0YViEl/LNWPbZnXbIqB0W6o
         lB5O/3f+Q+XNPGomBlX0EWuYtZMIPiG8JWAp72QOcGx5oN9O3iZLuUaGWOOOX2ogM9Ww
         oajmw45dFoNY9fLkyuotzestgQh1PErUkrwlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117530; x=1741722330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wlj6wsu/JSvBM4RPZykaf7UYl5o6YxQI8N0Xp4ZZi8E=;
        b=tBBFNBIu5mPfMMGgRRbmsQg256oKqeBctF/qZnJ5CggcqilmnCY14pcHXvAUwhk7Gm
         o60AiOxGStc0mbr5kr2+S2HoMDal8fyNXZXGFzoVEbzzHH4TRYaeJDjmxPJifIIFdBtO
         chO2u0xVqo0hQZNC5n6NQqJWzvbvrdc4EsjcAZvZP58txmhwrnmTNws9TCHqSI93F0Zs
         zLbOR5e4+4aBbMLJs6E9tctKta8zdRw+Ec3gCF+YXqv8YWG4lO46OZa1WzB1Byzj9RiI
         R7SGbH8UD+z9Yuv2+mf3ncsmngkJBTcHmEBzEcCfTkk+GgJ0cDefJ11ycRcapelfNScG
         +grQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3t3ncQ9aXQG7BthFCx5qgHtzjTVnaGTTWe7TOrX/mRlCJxlCNy8xLeFoSiMSAFyRbA9av3z6eaLfVzfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoMNW57zyZEvPRBNp7bEsnY9mufgApeAiirc4++y+eZVmVso7
	emc0kOu6JWnLDSPh7FBycp5HpVkH5boPPOxNMesIGw7b5naEjC8dH0ndhTf3mzU=
X-Gm-Gg: ASbGncsNteGffZEgb504dFjbK/uVy9yYXy+9plSD6fMeh0gGjRBl0egoCF3VInKm/Nl
	YqhnW1OWw31ENrCRPsgGhOQFNdm6bR3XDRLF1VayHptDnzEfhZECTPP3ZSzRhru77m+dX1klPH5
	jUvxnz9OAwklGlFUwYFBRrrx+nch0LoNMD5/Xk8jveSv5F3HD5v4CrlBH9Z0H/6e0ztLc4XFvn6
	xJpCsM3Rl8xY24GAsUCECxes66SWSUfionD9IHHzijiAwN30YP7wSQUsX38sGvo8f0UtMEDu3zn
	esv/H7ZH8fpi6Og2CrrQ2jbyXKEX1MmZlN45v7JyUUalZyTlNnmo+9k=
X-Google-Smtp-Source: AGHT+IGkXVbMrjLGRFRcGTX+Z6vuj8MvARSqYVSsiUwnZt/gjJ0RAXPrIhj1KuEyYDn119fg33fmwQ==
X-Received: by 2002:a05:6602:b84:b0:85a:fdf4:f429 with SMTP id ca18e2360f4ac-85affb97f71mr40405939f.12.1741117529977;
        Tue, 04 Mar 2025 11:45:29 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85afc905722sm22022339f.13.2025.03.04.11.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 11:45:29 -0800 (PST)
Message-ID: <c49917d2-5157-4878-9866-be6053b5124d@linuxfoundation.org>
Date: Tue, 4 Mar 2025 12:45:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: Fix the error limitation on max_hw_sectors for
 usbip device
To: Zongmin Zhou <min_halo@163.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219092555.112631-1-min_halo@163.com>
 <88b2fb4b-96a4-4d29-bf92-4064d3572fa4@linuxfoundation.org>
 <5a41d6c3.8c78.195371996e0.Coremail.min_halo@163.com>
 <247c7e15-bbff-427f-8315-ca463f8b933b@linuxfoundation.org>
 <4d4035bf.26b9.19556dcc23d.Coremail.min_halo@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4d4035bf.26b9.19556dcc23d.Coremail.min_halo@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/25 05:37, Zongmin Zhou wrote:
> Dear shuah,
> 
> 
> Yes, I agree with you.It would be better if there have a more simpler fixes than This patch.
> 
> I can just think of the two possible solutions that mentioned before.

What are the two possible solutions?
> 
> 
> If SWIOTLB disabled,dma_max_mapping_size() return SIZE_MAX.

Right when CONFIG_HAS_DMA, if not it returns 0. Perhaps we
can ignore CONFIG_HAS_DMA=n for this for this discussion.

> 
> Only if SWIOTLB is active and dma addressing limited will return the swiotlb max mapping size.
> 
> 
> The swiotlb config seems rely on many other config options like x86_64/IOMMU_SUPPORT and so on,
> 
> and the configuration on host and client side only use the default at all,Like the default ubuntu release version.
> 
> It seems that switlb is enabled by default on most platforms.

If understand correctly the problem happens only when SWIOTLB
is enabled on client or host?

The following combinations are possible:

SWILTLB enabled on client and disabled on host - rate limited?
SWILTLB enabled on client and enabled on host - rate limited?
SWILTLB disabled on client and enabled on host - rate limited?
SWILTLB disabled on client and disabled on host - not a problem

thanks,
-- Shuah



