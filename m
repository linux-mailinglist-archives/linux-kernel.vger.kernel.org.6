Return-Path: <linux-kernel+bounces-522020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D859A3C4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889D316B4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6E1FDE2B;
	Wed, 19 Feb 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="amoyWiAd"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C591F417A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982320; cv=none; b=D1tFUWhaaIOxCvPLJrr8aEB9IOuBpKXGFl3jUsn+V2zyTVgNaYMd9iQoWdh6ZMCc27jlT4QX1IpSpgbWl0Hzd8RZ4sce4DMSTHhZ7xtU9C4cr8L2ubWR0W08Ay5zP2OTULaYKmTN6dTw9DMBj0zJIBzxQVj95NmB9mavjvqqxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982320; c=relaxed/simple;
	bh=BLb3NN4Wc3NjC9QD2aqtccuB2Nrk8sU0QdbLHt38a14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOJJopBphWTkdqO0MHzauq2CxeWt28SVFuprIR9UNOucPrpbkxNTQbhqwBVa+t73asG93/fgi74Cl/RzT0gEaT45Lo4e4tbdpkTlV9QrpEY4sbv7Z0AQYSRf3oUYJJ8+tnyuaN+AihD1Vs3OuDuoGdjNebBOR9Mg8fZqZf0DhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=amoyWiAd; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so476231239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739982318; x=1740587118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5K4FEOaAuj8ZRtiYP0BTVitcPLRr2Kq/PgjSQHr4YSI=;
        b=amoyWiAdkYTuzw89o0ZTwWEJ+a6WhcsnAzwGpynpD6JH1XL+CYXOxTGwNoGu7567pu
         uKsI3zA5Cq+MjhjZVOCoq2jEpyuHTuL9y1pJrHtQpPhT6wphh5VBUw87+liLQjyi3rOO
         Wtdtjd6o1UQCqoa9YvJMDeRuePdAW5vBKfNU3kKpiJZGMfTFXcFsvvf9H7SHWOGok0CQ
         NAK8H+F5E/j2aX4FmD5Y4Q8wW15TbEfDnjkmffJrq/tkUrSgp36dgMrMueRyLCms1zar
         7nX8vdNLP1ex+nT7Od8LzoFCFj0BOYa+TNLj1SezZe4mSXVmbDbQ2PuA0TFCPbeVdh5c
         SQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982318; x=1740587118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K4FEOaAuj8ZRtiYP0BTVitcPLRr2Kq/PgjSQHr4YSI=;
        b=nK0qlfuMzTmWd1lEaBr3QP34WUdO715mp+MTKkmzZOZS2Qh4dusOEh8ZbUMvC4Nj48
         5wSD3Ocpz3AFVksRHxr4XvmOCm15cQ+74xKoojZVG0vLy6TB+LQ0vzk/+568sUaxZmRM
         XQciBKJVgjRIhzZCFM30WKgEjzyJ3GGUQMk+RcEU8/dkCdaXWM6MOukaWVRVwEnPmD7Z
         XY5S+l4nYI25xUTs0hIE8xfjfADhDfRscOLB5R7pX4ICQLFtkHkO8WcxABiRNlVlEKto
         ruUJAaba6iNpWfCwuogzIkUJjp6YARsCPb9TAa5haj0k4zZPHs4DNvcB+XCybp0WZVPL
         q9cw==
X-Forwarded-Encrypted: i=1; AJvYcCWAOwa9rMjehlHWT2+qdc3ADDKzyHFRk1STYya2VMQehLZIoQNH9mxxbo1AjfU0fn6liZFmnqPvF1XCYQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6U+V1svFCjhGdVheATx2XkaS1gSQ01jiWSjntYLt6mco9i6qA
	WVRJ2QjTGMQRXl1frDPzpgUyu68rSqqfYF5xlwdpJTAyAP+kguasgm0sRqvbMwU=
X-Gm-Gg: ASbGncv5efygWo/ahq+yJijpsi5C6QVcvtpY9yCOwdg8gITwOz8oAICIfFiasWcUTdN
	wnkXXTZSyI+1KYjSWFIf9r6s2fHW8hhO8deObTAYTbRwVM3UsdT+QujAgWTjP2afc7fyae3GFMN
	IkCavFQ4UWht+4fkGfNg8qobPfwZaz5a1hhar37+m5pRXB3HsTE2L+q4EPKAJEWAUdthDq+zgD0
	xAjl6j6UjX4poGyn/a8Waf9Wl7zheov0h8Gm28RW3XSlXLKDffy+mK1axMri0taBSNWvhhRCagj
	WFby0fC326U=
X-Google-Smtp-Source: AGHT+IGzDMxDRSO7tIzCZYHTeRIrYyJDa2dEbxHA0GLL6as5GUtS88pFw3LkO+acUE2TeDls0mZXYQ==
X-Received: by 2002:a05:6602:6d11:b0:855:670a:e687 with SMTP id ca18e2360f4ac-855b396d596mr408445639f.3.1739982317377;
        Wed, 19 Feb 2025 08:25:17 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee903b9375sm1887506173.54.2025.02.19.08.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:25:16 -0800 (PST)
Message-ID: <64379346-a39b-4903-b861-0e25e9e79821@kernel.dk>
Date: Wed, 19 Feb 2025 09:25:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/filemap: fix miscalculated file range for
 filemap_fdatawrite_range_kick()
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-2-jefflexu@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250218120209.88093-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 5:02 AM, Jingbo Xu wrote:
> iocb->ki_pos has been updated with the number of written bytes since
> generic_perform_write().
> 
> Besides __filemap_fdatawrite_range() accepts the inclusive end of the
> data range.

Fix looks good, this got introduced because the logic got moved into
generic_write_sync() rather than being a separate helper.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

