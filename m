Return-Path: <linux-kernel+bounces-443842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343719EFC95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50D528C8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6A192D8E;
	Thu, 12 Dec 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mDLSo9B4"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CF748D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032213; cv=none; b=ldSQ0dkv8N73mW4aenSgWDlQcOnAml54Bywyz1lxrZJlepN29k9QJeltyOekW1i2nY8MQWiwjn4BNOPaiiWtdTEAg26/NsLsuHbopMekQ4XGfST2cDVu53Te0rNNRZdCwZFBkZfG4O/hDaKvRhACaS3aDRqGFjKr7/se6I2HeOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032213; c=relaxed/simple;
	bh=hN40wVujLck1OPcPBoMWv5wRDTLaKdwuOj5RSFQsQxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAwniXKURCA+5zVL4icGCq10+mIOjmigT0k75I3BNG9M1Xd8+F3goJvo27KazA3HlXc3McCrCb1QS8lb6+5ApOrtRclQC/e00lZBwFe3Ev1nouaKRTv23R2eRbc2hJnAq5fcEF3zct2ILOAmXAbuPVwdX8sQhOeGblsldhFF5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mDLSo9B4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844c825ab4cso30649039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734032210; x=1734637010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9NetkofdTc3tauCZ/TmBHJ2OFlOWg9pJutokK1isp4=;
        b=mDLSo9B4UGopirAQy13jM2sHlQUc+XCYB4YKRLTcFKkRwQ1ycvWofqQnQ/FIVD+GJR
         BCVM1jFxp1zn4LAbdUXDqvH7voRDZWciNY/YMwHmDTZBlWE56bmG4cDtlcprRwoWaP43
         YURZvlV+Fs0u1fAQbZJha1zDIwu/hC7WhFqBppA3iidBidms3BuA+2SHx1NupYUaZWln
         wWS6yjRLLs+TDKUHhu0dviB+z/FPJfMBWhT5fMm+X48MTqH/L8XC91nd8Owobhg4IRnQ
         Uk9UGi3UTMuJk4JFI5fRmC07JGk4i7gDGBYX1L5RMXVQ5k7OiQ+LLjk96eHGGLQYy3A6
         65Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032210; x=1734637010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9NetkofdTc3tauCZ/TmBHJ2OFlOWg9pJutokK1isp4=;
        b=b5qZR4/dJR2s5aoMLfC3/LW3Mc51K2mNlDW9t2lYY8P+xVtfSxBPGI+s06DUFujaXK
         ViNPmkTcEiRZKzqFYB/ZiytAFSzyoEyJH9YtpsCh1RBKLNJy9K7axYya+OW/7W6RY+ak
         ShFjQhcemwvSJ4No3p9aEL0O5Yvfe8RVI/i9D0VtBCOhm7X2C7sbwYDOrvSYeazAy6Yi
         ZjxKUK0kJ4yF3tGXnspLdbyxiG7vHjwaLGR9yMFLVDRLkUddEww23f7r3nQp/bG3RA+7
         yF4iEW76oHBuaqKl10Q/nQIt06AT3g2YNbug25+h31Z4gMqDbSbzE+eIXW/lnoqze4jD
         1l3w==
X-Forwarded-Encrypted: i=1; AJvYcCWjO5hMew103mGs94+WLi0KRPhF3OkfAAmYd8RHRoz/z+HwWzBBCJzSxJYB1qJ1Ct5bucVs+uSkJvMwy7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+9j+QWQd2d/6nl6kVec6yiCd4RWaBF1cmXShxR8uzbRiHQ/U
	PsQRd4UolZ6efGxyrbKaFFDB+HG/ptCzNP3S0I8OC3DAIEhACnxnme+FQeg2ye4=
X-Gm-Gg: ASbGnctGJelqn86R2uJm8dUV3XteLQMEThsRZbs1ECZlTNAYDiMTZ3LkT+J8yEZg36k
	9f6S44/cbBBS2dZdV2TAlqfUa1tcwd8XH+hWGn9gaWHumzQDdQLifJo+xw/anuZmXwWIXmJ2IrR
	0Wrmg3MfY9RXFeg8VXYdyG06xCRiUvHK9ha4M3MAHTaMLGrOCV+yqfXzfW2ne+tvU4g4a2jhoxO
	kX3ef6+3g5UUp8ymNZ8p88VR+htGY14keY8wmlJn3vAZv2kREAd
X-Google-Smtp-Source: AGHT+IGYXaH6gW0H4DnJ9sYH8avclTqtNpIW4Ov9pR/4ZeyaZ0uX5YVu7ZLP35uMyaDy9lriE0bidw==
X-Received: by 2002:a05:6e02:1a2d:b0:3a7:8720:9deb with SMTP id e9e14a558f8ab-3aff5b520damr412565ab.11.1734032209886;
        Thu, 12 Dec 2024 11:36:49 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2be15f178sm2311129173.142.2024.12.12.11.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 11:36:49 -0800 (PST)
Message-ID: <64b0c304-221d-4d8e-9bc7-dfeaa49872f7@kernel.dk>
Date: Thu, 12 Dec 2024 12:36:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs> <Z1gh0lCqkCoUKHtC@infradead.org>
 <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
 <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
 <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>
 <Z1s7AGxZKhK1V4qv@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1s7AGxZKhK1V4qv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 12:35 PM, Matthew Wilcox wrote:
> On Thu, Dec 12, 2024 at 12:14:23PM -0700, Jens Axboe wrote:
>> Like I mentioned earlier, the fact that it's cached for the duration of
>> the operation is more of an implementation detail that developers need
>> not worry about. What's important is that it's not cached AFTER. I still
>> feel UNCACHED is the best description, but I'll change it to DONTCACHE
>> for the next version just to avoid the overlap with other in-kernel
>> uses.
> 
> Regardless of the user API name, I like PG_streaming for the folio
> flag name.

Sure, I can make that change.

-- 
Jens Axboe


