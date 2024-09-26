Return-Path: <linux-kernel+bounces-341170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CF6987C05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA0A1C22B28
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C81AFB3C;
	Thu, 26 Sep 2024 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA8W376s"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78D4B5AE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394884; cv=none; b=MdfYIUNYGhPXmYxuR/7MQkN0daM/EKSvoIDP0WhMi9vey80hG+xUOAXaS2Mbgq/W7NZ+mC/upPV1nC4goYYc9wc3iCSn2C7fXirYJRSYCZcG4weSoLQ/RBFHqsHPy4doWfl+OsoPeijOY+B2rD+eMlWBDKmmfdrKC1xuEzWfYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394884; c=relaxed/simple;
	bh=mwcB6EAt9llzywll8WI/TcnwcfT0SnH60qxlKbWx8T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GV4XjT07xe9Hkt9wKJCdF1WmCcdfEAYxw0dtnSiRHJKHpyOWO5quOblBIO/J7QutQAE+CgSlFg3pG/cb+8HioRRvG7C3/tU2pgiOZ4q7Rhxx/aARLa15betsP7IPHO+TMqsVGraZhvP1A8oi6YszWoFyz9xtA49i/Z4sYIvudAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA8W376s; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0789a36a4so1347548a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727394882; x=1727999682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KOA95npmQyIWIF1V9ZfvzK5GZkeut8g1aAH8JM5dN8=;
        b=nA8W376svIC/rXt4D11yup4Gus/5SDk1M/XYiG33C+cQnVVTiXWoXUAtSICVS9gmK8
         NkwVL48DePV3graGgNSgy9a4y/Nb2r9otn6Cqax7dX8Pr1VnK6UBR+oqC0U/HWYz+nqb
         L8OP0+VDHT1jaJLNcdw1fR/+zKmj0EBCB6MYWSKbBp7bCNPx2gU9bHgECyBWPb3xdefz
         QJ+FGj77XFUghOiZ++RXEYgRvpyPCi1lMAPcdwR9f7q7sMs4I8XM/lekChlTuz76mRCm
         Gxf5cU/NOmzKC2FBZysilOaXxhZISTv0aRqtAPvK9a7vKhpnLlWdTbd2bJGlM/hz2ed5
         iIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727394882; x=1727999682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KOA95npmQyIWIF1V9ZfvzK5GZkeut8g1aAH8JM5dN8=;
        b=TL4F7xPN7LuY02dguGcGkAk/ffUla4wrudsqn+rSFsgRza7q+F7MVvXibR5VgT7/MB
         Qil1WuDC2bfgftorEEY4y9A6LOW2hgnxfG5n5MxSSBuh3DBTh8Xdnc1OWqLyPmnHn5im
         MKW6ew7tMEQCcbGFodUsiHp92/xkQn85ODLtpXk+xdl/a3kACa7WYFTlbQbyRdxeKe5O
         lcka8FOmi3VwVoHr+7SOR0HO322GpOTcC7gUtXmcqKZsWZTA3goA8zorUONVSJBXPnz2
         kH6d4YbyKYyHocKob1vyEMY2xL+h0elYMaA6nzDuN0ka0E6ni+NjkyfDew8Z/Nrr6wcV
         B2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXy0AA9c4hhJSl0+ptOmajleNJwUIGhhSY8w3Ld972RijrY4PrKhpjNqeOsxq/yifJeM1ZEwTz20YWMYSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqcF+kP2tGC2P/WnQU6T5Cu06PspfqWjhza/JZ/8FJ72FxM+6
	oldOeywA1tX+FFLygVUnXRwNgq6A6mDadtRxMh2Uln3WWHQTvNk2iKyPkA==
X-Google-Smtp-Source: AGHT+IF92zyeR8gUlzUdS+GrC8shOERDNOBpkeMLc5MX+nnVgoD9NyZw8VJ1zUrpsXrN9R5vf0/KtQ==
X-Received: by 2002:a17:90a:f2d2:b0:2dd:6969:2096 with SMTP id 98e67ed59e1d1-2e0b8ee06d0mr1451390a91.38.1727394881801;
        Thu, 26 Sep 2024 16:54:41 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e22cb0sm630322a91.47.2024.09.26.16.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 16:54:40 -0700 (PDT)
Message-ID: <bd675500-f418-41f4-99f5-b3d21fc02d27@gmail.com>
Date: Fri, 27 Sep 2024 07:54:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] rslib: Bug fixes and improvements for Reed-Solomon
 library
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
 <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
 <CAHk-=wgs70xZ_F=3+52cuhXNsK3eDWVp3PJtExbCAQrUdhcRwg@mail.gmail.com>
Content-Language: en-US
From: Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <CAHk-=wgs70xZ_F=3+52cuhXNsK3eDWVp3PJtExbCAQrUdhcRwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/27 01:12, Linus Torvalds wrote:
> On Thu, 26 Sept 2024 at 10:03, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>> If I were making this patch series, I would send it to Andrew Morton,
>> but if Linus takes it, I'm certainly OK with that.
> 
> I don't feel like I have the expertise of something like rslib, and
> would actually suggest it go through one of the (very very few) users.
> 
> It's just pstore and some NAND chip drivers, afaik.
> 

I will try to send my patches to these rslib users. However, rslib users 
and rslib itself are different worlds (although rslib users can give it 
a test), and many of them are not under active development for years. I 
will try to send to Andrew as a last resort, and I will probably invite 
somebody from, for example, GNU Radio, to give my patches a review.

Thanks, and I'm sorry to disturb you.

Zhang Boyang

>                   Linus


