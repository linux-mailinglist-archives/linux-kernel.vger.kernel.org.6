Return-Path: <linux-kernel+bounces-522562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CDA3CBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3F189C57F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8662580E2;
	Wed, 19 Feb 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UiyrZ8jd"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711823DEB6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001964; cv=none; b=W+0Yrz/1CDwTaaNPTwT6v2VALA+5KQtnVDVQnDCbGHbJVUKJiej1XZBB/xZMfAgaElREAqg7SHtI35eMPnZDWaJyJb7Jdin3zdMqOBdFRtLiATV0NJmrBaFsD2dhhHSA+eOVSUNG4GFk1be8aHzC8ISTgzrB8PSNnzsWx1pS8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001964; c=relaxed/simple;
	bh=fh9ZVJ2I9C5CQ5kpkV5A2PRiDffiKTGkZaaK1WWz7/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjmHL7FffP0swtOvcWthkjtqzzTAzxdJmRldaI0IB03VLPM0T2LhWUUFWUKiFHIRlltDQjtekFgKaxDgU58b+5WHZSEOGfDU0I7b3B89di5qkBD1qubkTFdneRQWTkYMJcbLcaaTzSO1hX/lbQ7cwG0bAG5hIQWDFvtV6Q+58XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UiyrZ8jd; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d04932a36cso2453795ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740001961; x=1740606761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fcihMsF5MEa3PMJJpw5KAMRg9ye+pHOyIpzaUV9zkY=;
        b=UiyrZ8jdTZX4V0zETE+4MLrb3JPUoj1xRrhke3vBGNGDzU3CMizWcw8kaVn3S4g31x
         hGIqk0em7smlwds/n0DQ2OCCB6ouYV+57jFJDYiFz+dWR/eLPbUwnXhYkeKjXZkM3KCA
         viK1Cy102SBVLexYhwPeCBJwls9VNgWtupRiMMJH5LMrjHR9pmdGO9Ei7Lg0x5vzPCWO
         VXuZy/HVPHhb9+1unqRnCxhnQzJHa0EY85OXrTvMCRrEVC5de2wXl8cyzyq0oNTnOuni
         Y7P6tDETyiX+WDSotuOl4BmAdt5Fc7Gicn4RXG88i6tGmEbNgfVSabcGYXbrHSaXqNJD
         urvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740001961; x=1740606761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fcihMsF5MEa3PMJJpw5KAMRg9ye+pHOyIpzaUV9zkY=;
        b=VZrmJ9RF1gyrCYQg/Nv9wZ+zoJtQhLN0i3+QozdWPSQEyt7em7Vm5qudUAYHQiib/2
         9AaCdrCrGA60/acT4RRo05qiMXGf9QP6gBRF6G+ifrwuiNPSCOTgzkWESgjFdmQtH0hr
         I09eSKi5+xCRcN71DZyRzgRRqJgeA8l2eqdWUYCmj0PAjLYUWcVKXFZP7ZY+/8rKWhaf
         0s+kMmRxN8wPdp4CCg+lRR6tJ7rENsKDq4ecKeJC6/kJxZFBVBmNiis246xyIwABU4pD
         39AbQyNxGJvd53MUm9C2Op6rOWnH60jgYYYLq/J4xxGqc15Uz1cJg/Vx0JgAwbCiSUMq
         fKVg==
X-Forwarded-Encrypted: i=1; AJvYcCUSgvg9fE6BT/ghH72gkUbZxLYE9XhC12Lq/1GUElN1Jj8Az76XWwWmZCaZum7vqDonmzJz70NxL271mPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2sFk5RWBme0TdlceTBynXvyB7QH4bcyK18M0NTosiI66pS84
	5PwwNN2Oe3hsygrBY1G/qUbGmreoxNBcytBAYn77vEWl99kuzNJ9D/TlwEXae1c=
X-Gm-Gg: ASbGncvE51YTOSZj75kEfDR1izQCX6MOEdJ3XZhrRhSLlP1F9t3imNzXdMuz8h7Tm7p
	GOn/NsPxud6nNHCPywZaeFsBtujY8vXLBZmYcs7UUREHRAO+4/ZXbX0IhQ9Jlumr6pfyYmOJari
	CVWjYC2w7D6pTS16Gy0omgOIgUtqM4wD8bCPawJZ1XRCtqLrMo/Hemj9/YwiGWvO78/3gE9apM6
	1bvxnfj1MU26tXTaEFMT09RfCQ279mNm0GedF/0eiNgZUcXOLZunFAin5KB9O8htDwQAWxvXqXJ
	aErD/fl0EtQ=
X-Google-Smtp-Source: AGHT+IFLt3AeBJ7f+PdPJ1liHm+gk3zN+nhOjD4Dv+4rd5YKqbbfrdRTWVg6WMFJdTceMOCut+5tDA==
X-Received: by 2002:a05:6e02:1a4d:b0:3d0:164e:958 with SMTP id e9e14a558f8ab-3d2808feacemr188569535ab.17.1740001960871;
        Wed, 19 Feb 2025 13:52:40 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee7d9653aesm2608219173.16.2025.02.19.13.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 13:52:40 -0800 (PST)
Message-ID: <9bf2510f-9a04-4199-b626-a27c4e4425a2@kernel.dk>
Date: Wed, 19 Feb 2025 14:52:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250220085120.149904bb@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250220085120.149904bb@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 2:51 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   f6977b06c598 ("io_uring/zcrx: fix leaks on failed registration")
> 
> Fixes tag
> 
>   Fixes: 9fd13751abf5f ("io_uring/zcrx: grab a net device")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 035af94b39fd ("io_uring/zcrx: grab a net device")

Oops, I'll fix it up.


-- 
Jens Axboe


