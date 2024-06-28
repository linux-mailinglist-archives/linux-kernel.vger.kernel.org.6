Return-Path: <linux-kernel+bounces-233079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C158B91B200
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11FD1C20F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68AD1A0B14;
	Thu, 27 Jun 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b9OkehAL"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41D1991BB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526306; cv=none; b=CrSW0lxC62Sx1oqsT+RR8B9pkHE5QU4nKf5nM3y0WN5Te12V4G7/zfKlaxW0IK/RLjGFi4AZVi2ORzwm0nOZ9Ejo9Qen2I+JqW2GrjhMYfQFERUmSM0JF/OI4PoBsbC67N6hm4Q7sWTe3tWEIvsT4LnlagSMzWsAq0movlqbJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526306; c=relaxed/simple;
	bh=Emf9Y4qkWJvQXK5TXnQxq6INKZNe/BS7lCqGovIdpmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqj5zYmLL3dWV6gunjGOfkJEGY85KLs2awXdu52zkY8irE4q6vKogM3dY+LO77xIeGL521GQV37EpVii6lRT8e/iGeVW1hUBxhdX9FICbSIZZMAkP/SLBhfG5AAvaeyg+XVTWSvIoyS7HvCypyPylF3edB1T2sx3I3WVWyI750g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b9OkehAL; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d561131a3cso1644b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719526304; x=1720131104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4odeY2bUcHpvVmHu40uzTeyeI8pCfl/yEFZTLH9pCdE=;
        b=b9OkehALEZEz85NmIDcVNucMXTrcWWr+dXvbFZrVz9xdvdInaYGEbPbSmBOWS/HV3W
         1p/IGlm9j1MAN5vei7XZHomoor2avPdWOifGeHWcL6246wg+a2WGN/nOiKjuYetn9/ku
         71eSvtjG6cOjlFypDj7kSPmSK6sVPU1drqH9twvOjV0ign0nNyH3OL6s9+1js45CvGJ8
         4H6k4ZWfGxtyAAa7RWcwVuY5wYT+9hD+CbhazjTbNaL+7vhJbU6IRW+wLZ9+1q9HzK7Y
         QTZyNZU9xhDXQjXujZwOErMGHqz4Q0rHSkMvaUiAoJNyIixVnq9t9thegV1BPiGTout+
         2ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719526304; x=1720131104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4odeY2bUcHpvVmHu40uzTeyeI8pCfl/yEFZTLH9pCdE=;
        b=EL/Km89aNd9Aehc4kswSsub5NG3Po+DlY4wjlju/Jb9OogWAr6a04Kc3rwYoU0npNc
         xJ3ghfGi0N2TxJD4hJ2TmG7B36IjEot3xzK6eJqBSUclJs5rrc5tKQuQs4Az1/vnQidv
         8fb5tPoE382BW4twu4NIXGhMLYHrZpZDBhzga7oRmFR+y+9OswrwuPiSK32rYPoCKmG+
         HfnDt1uk//wkhHDeDz4OyETKDiSQ2ym2DMBeKwXknm4AE2qVaN8gYQ2xinfrjpInaTJ4
         iTEMh6c765d13Wwp8E6YIfEVIsOyG04xYohE0S1f6rO+5zf/qxnDT/RgDG4qFgQSdQca
         RP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV22lSQsg0WE9L0r0tJSCGJ2GyTIlGXFItWrJGHS7ak80hG0+dsfQhfyQrEqiQp3SxhtxBFn7e9y9zqJ01G2Qb74XEJ7e7UPUnZUNto
X-Gm-Message-State: AOJu0YzJZO+lkjA0YbVBaaeunQDq65JRSx2BA2AWtRlu1k+Z+D/z7svc
	oRHZzTY4yvgIBDhzvrq+3fJ2HbBFQ7mMu2T7RKtmGlqWGB73mp7g1xl6ccAFVgo=
X-Google-Smtp-Source: AGHT+IGHRLOZ/wDYObVuVvsKIDLCADbAzHxRTDk74KxoG/IzlKZb+z3rsQXSpZIJkwvceWdGtnsAXw==
X-Received: by 2002:a05:6870:8a24:b0:254:cae6:a812 with SMTP id 586e51a60fabf-25cf3f17d37mr18234572fac.3.1719526303734;
        Thu, 27 Jun 2024 15:11:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246bc72sm219069b3a.60.2024.06.27.15.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 15:11:43 -0700 (PDT)
Message-ID: <dd7ab5dc-51f7-446e-8250-ddc62f6f66ff@kernel.dk>
Date: Thu, 27 Jun 2024 16:11:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
 Christoph Hellwig <hch@lst.de>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <20240619081601.GA5434@lst.de>
 <IA1PR10MB72407980A58E57E91F80777F98D72@IA1PR10MB7240.namprd10.prod.outlook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <IA1PR10MB72407980A58E57E91F80777F98D72@IA1PR10MB7240.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/24 2:13 PM, Gulam Mohamed wrote:
> Hi Jens,
> 
>      This patch is reviewed by Chirstoph, can you please take a look
>      and pull it if it is good to you?

In the future, if you find something not being applied, do check if it
still applies. Because it did not, I had to fix it up by hand.

-- 
Jens Axboe


