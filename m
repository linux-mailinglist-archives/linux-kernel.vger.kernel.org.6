Return-Path: <linux-kernel+bounces-273544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBBD946A6A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC77D281D52
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0615572E;
	Sat,  3 Aug 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LswNW+9X"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F21ABEA7;
	Sat,  3 Aug 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699670; cv=none; b=KHIq77PltZjecQc+dP6j1umU6d40250xriupK7u00puMlVLlbZd6lZwQmRJ0xECgMzxNCgBxG2WOR5Ck9SnUJqGIuIt6bWlH8z93CJtPP2wFAsh6UQCrkPaaJHoZ13Vh4o//q7g8O7SfuCySsk3e/ykMmw2Ti5mA1oakea/OxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699670; c=relaxed/simple;
	bh=1Q3f3wAAfLeMS66M4Cd3loRGbCYGAcv/pxfi6hE+cjE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZKYobNwK8tvWofaEHpVlBwANiLNX5RplwoIIVp5PCKKJnmPrGBSIpc1LoYlyJ5prnhBOoFkfFOV1bbHH9kXsqSQqnQl+EmpjAh4C+N3EZLuJLJUOqwPi04l6lwTHDsX5lOvAVZzORz5sA0a1EWWfO+GRu61njBVyvXRUlJUnG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LswNW+9X; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so114339711fa.3;
        Sat, 03 Aug 2024 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722699667; x=1723304467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zpyY9ulRSc+ysG0wEaIajPO4aps8FLYRKBJNQ6wWV9g=;
        b=LswNW+9Xhy0py8pmEt38S1ejS2E4cIM8taoDuLnfX/uTuFKMuHE7mzAO2Exw1iPjlL
         mHSTfmOl/WXQFd8J3tPPzRfrkYc+GbnKABvtwj6GoW6n9SzMhVcLgBTq/DV256ecv4YC
         eRvc/xsMqg/QXXU1l7kJCtOhhZdS/2n1FF02ZcuKU4HmEBcWUlu+ZMqmIGgxrWr3lJpW
         wSSq9Me+0nwE2kUEA7TYj0Dk89S3+exUUwWbHtkg70yE/gUbaUns85wlMjIPVRBE39Qh
         rok/F6iTAt3aObyS4rNEQThG04m64J3xAOxE75NRlScj9wE2SYQo58YvAIXutWgsigmg
         zwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722699667; x=1723304467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpyY9ulRSc+ysG0wEaIajPO4aps8FLYRKBJNQ6wWV9g=;
        b=m1RCvj0aVoTcg8Nhf63FyfZKTJlrRZRIdcOMpS7HpL+XtY5/R7dkWnAo3aWGDyd5rE
         cELPsLzEgYmCtZb1bbPmpSiyTz6GaCw/daBW1/S5piQEmeNRoSfVbm1OuJ393lkDYlrK
         No2D5xzplhP7ea3smFd0T1hUqsbvzkv/XL9SC88k/D7b92nJ0/ZQndaoflIYQJ2BjasL
         MBVEoQk0Jp4PMiaVMERqsgaDfmVZcS4rmDgNw1BP0tu0RRqiaRQBvqgJ+vf5P2Ci+g0X
         RVrW5rJ9jQb1zoYP2t4oy94hlnOiu07UXdcgPxNaMM/XfX9d2WDOh6UC9l7oYDLfEmRS
         RJxw==
X-Forwarded-Encrypted: i=1; AJvYcCXZeINKSQDT0YxwIPpJ0HYIm1D5gm0uLrcK9zDdbBQh1hYrXWzAvTZCwtJda4lUTZA+koxVRi9qU+ge1+auzJPaGGqbo5HbGViWM4yPCosSXhosDEFZ1L7fLhRKRWtJFalDRwsLtR32
X-Gm-Message-State: AOJu0YwgPIsQ9FeWYh6N75tSPdkW3X8n+ombJW57mDp5rm+fhYH0l2xF
	sMknXkYmLAEj9Idu/YkvobNTTUnyZTq0QLyqYxuq5AhEZopMRrY62RWe6Q==
X-Google-Smtp-Source: AGHT+IHPCcQeLBzMwEA83rzwuJVJ6VJgDsq58DxK5LHY0YtltBQdhoBHkjzNBXE1VC7JYxAoykSJLA==
X-Received: by 2002:a05:6512:130c:b0:52e:8141:1b27 with SMTP id 2adb3069b0e04-530bb39b079mr4696932e87.43.1722699666294;
        Sat, 03 Aug 2024 08:41:06 -0700 (PDT)
Received: from [85.64.140.6] (85.64.140.6.dynamic.barak-online.net. [85.64.140.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm4596684f8f.44.2024.08.03.08.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 08:41:05 -0700 (PDT)
Message-ID: <81ef75a3-d884-9a0e-9fe8-a3e73d6b6bae@gmail.com>
Date: Sat, 3 Aug 2024 18:40:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] char: xillybus: Don't destroy workqueue from work item
 running on it
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240801121126.60183-1-eli.billauer@gmail.com>
 <2024080311-legwarmer-ricotta-d4fd@gregkh>
Content-Language: en-US
In-Reply-To: <2024080311-legwarmer-ricotta-d4fd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2024 9:56, Greg KH wrote:
> What commit id does this fix?  Should it also go to stable kernels?

The bug was there from the very beginning. The fixed commit ID is 
a53d1202aef1 ("char: xillybus: Add driver for XillyUSB (Xillybus variant 
for USB)").

So yes, the fix is relevant for stable kernels as well.

Apologies for omitting the Fixes tag. I wasn't aware of it until now.

Thanks,
    Eli

