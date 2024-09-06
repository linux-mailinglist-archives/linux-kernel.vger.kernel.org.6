Return-Path: <linux-kernel+bounces-319038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447F396F6D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3C7283081
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E21D365A;
	Fri,  6 Sep 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="drww67Qj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA831D363C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633090; cv=none; b=r5sa/kU8xV12Rv+spNHR3Y8UnU0AvkLyiWK7pypflhzN3TTQFahOBpcryIEvZqkXrPpMv++2K43fB7GeKjlRpG5funfXwFgHqHxluMGiwd5033sTXnJdlwLLyaaX/2jXmJU1k4WKnURx3ABDOKyjmEkff09zP5EiM92QTUfqzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633090; c=relaxed/simple;
	bh=YE/0rnSl4ZrAzn5Z2ufG5g8z+UdgXqEia3Kn68UiSx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUP479SnZ1yVLX//XaPdXS4ymICvT/Uh6H0+SrCP5ksyME+NknpYBh5geOvbeIt01WLph0u4Juyjim//y/8jcDvXVw5fayYRFARZlsysqivlF9II8H5pLg51s86hYtg0EHukUdD2Qt7cZENd/ll7VkFC+91xWV8w02mEddSkvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=drww67Qj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20570b42f24so26946065ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725633086; x=1726237886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7U0n4Pc54X9wROP7p7GrRRTyFQ6kR6FXGp+66jt8aEE=;
        b=drww67QjEi1g68UC6WyFWDKZZShaUBr2rpdDl5aQ51GAjYb+2kVSgOvJpuwAbzZ8t4
         XM+W5EjkDeTkblTjVoOvR2OS2Eoj2m5rSh8BCZWQTeC3Pal5mj9GXbLW5uVsdsuMdv8p
         1banzbnpzPKVKlD3EyABiP6lX3EcBoBIiqTK5+qQypsWT9s8xwlLagT1YD7+K2NJT9ML
         54OL9s/HZT4Bh9hlpMj6dqmwkP7ee6OjqhkYexQceQBRNFznMUBF2gwj0467kK5ygYVW
         zoXgcOKSw1Coe4jugXol4/yTQj0V2vl0q/9nX8ioUF9SpyBzTbmnVwZ5fU7sddTRmMS9
         bIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633086; x=1726237886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7U0n4Pc54X9wROP7p7GrRRTyFQ6kR6FXGp+66jt8aEE=;
        b=rxkg2hmScZmCA+5khXiGOcjwFET96Us64/vbtz3ndrNlQBtkUbOShxTCK2tAg1Mvwo
         wz4KTboJgO/up+01ln9xCWZQ1EfVmseU7MVs5yvM/YbSXmIC8LpNFVvDy2VuLOSF5TzI
         wIAQ65xL9OLpnYP8ZrFTZirLxfuSAW9fnfjDb2f+KcaQJXrWHYLd6UrOBomH3zq11Gmc
         m4FbY7gx8QCymdHzGdnG8Dz408NtcSO3S382ANZZrErObie10dz22N8nKFoADCu9n2Ic
         iJwLbwhSdy1sNUonsiOWGvxZYB/NVTRCd3zHkJvi+KsPxLPpT0jREIsnwyKOGHGF2HSM
         GJVA==
X-Forwarded-Encrypted: i=1; AJvYcCU2LDKtVqj54L6A3OSjXlRc7QPm5a6Q+o8RKGcutHCDWCBI9805qNko8GOyvK88L5oBCwLRU5WXyH5SyXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFqKW1gHTt+BDcCtLz+U6p3InHOxPcXgQbhpbjnKCHCC57sfP
	WIkWfSau8THhKJIV9cVOw11/5uUGOrQm94/ckZpDknSgLR/49D61V7H81noEV+I=
X-Google-Smtp-Source: AGHT+IEPfdmdEsv8HUYFO8clIbkuI6Sz6ThdFkSoyqPyPHneUf+Q1tqC+WbfE6fv2a9x6soILPKu8Q==
X-Received: by 2002:a17:902:f682:b0:205:4721:1a7 with SMTP id d9443c01a7336-206f05428d6mr26833875ad.31.1725633086449;
        Fri, 06 Sep 2024 07:31:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206b7ce6c47sm40861855ad.32.2024.09.06.07.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:31:25 -0700 (PDT)
Message-ID: <feb77bdc-512a-4f59-8a9e-1dc7751a2fa7@kernel.dk>
Date: Fri, 6 Sep 2024 08:31:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] zram: Replace bit spinlocks with a spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240906141520.730009-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 8:14 AM, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this is follow up to the previous posting, making the lock
> unconditionally. The original problem with bit spinlock is that it
> disabled preemption and the following operations (within the atomic
> section) perform operations that may sleep on PREEMPT_RT. Mike expressed
> that he would like to keep using zram on PREEMPT_RT.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



