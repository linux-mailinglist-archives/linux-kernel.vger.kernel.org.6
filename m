Return-Path: <linux-kernel+bounces-555224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8EA5A722
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6291751A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3751F8728;
	Mon, 10 Mar 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vzL5OshD"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B51F4C87
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645524; cv=none; b=H50uZkBxAL5KCdSmeHu50KLd9HMHJ02eGVUhfQAy59DCgzxpAkw9bYXR5Vm813DowWfAEPuM9sD+7HTiWGbtwbfFyB4N5+qs/XGFkXY97T/cY9n0pEG1Anyj4qkkSk9npIQ4JzUKEOIoInCZOH/vgJYs5iOPoBW9mIp2pCcLTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645524; c=relaxed/simple;
	bh=4Gif14H/WjRTUhe9bIvPv3YGVJEzbO92IfYGUIfH5e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfBRvq64NbCyLr8u+lCOZaCYiL2u6f1dfppO+hsbvlFFKPTleOaFwtWskSGYn/6xHY0ecilQavd+r7aIL+TshQkzM2+fg1X/3z0Rr4sU1J43/MJ573lNQMGVOoKgch7Iq1ij0juo7f5m2A9jDRcL8tb/xdFh43nhd6+AHCiFJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vzL5OshD; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85b5e49615aso84777339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741645521; x=1742250321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvP0SI37bvQbZpvOfs44QZ7UYY18+BQNpijliAFF6+A=;
        b=vzL5OshD0738l4LnPCXhYm4NuFce5rmBhJ8pvOMSyFSD4U7aKXhygPFXAB0kGKUorP
         FHffrRnuadeQecSWLo5CNyKQD1jfiK/0ywoPEUBMUhmOdQ21yDZguw9ROf3uiEb64w/K
         4FNauvy2qTzGZeNr7Za9vPorvmoG3YxJzCN+II8s3xXLh4RqphoMYF7svTZKx2bsfSdn
         lq7zY+ZKQb1L+pRh2j3GR2b6RofQWC6Xjgi5w6Vltvi4nDqMFlO2ACtt4MO+XNmOSwY+
         1OLu20ZpCT8LkBJlMAE4JGIurX/WyYlH6Nithy95M9JkZ2hsCcZmch5G0vfi3xIpzH1m
         CmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645521; x=1742250321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvP0SI37bvQbZpvOfs44QZ7UYY18+BQNpijliAFF6+A=;
        b=jB07bMpMpvP7ylsSQ4l/QncXNUZ9mLx9vVTdkKVv26Ul6RK9ETzd/80BAbaere9KNk
         jV0jlSuyXai2Qj5jGH5mFSNteoSsbl141M6Ph2cKh58zFq2FjfSy2oDhS5vt+yKkj2iP
         mh6UPHim/FpYRqR2GhjkcXsHvRoOHAfmVOBtCa/mmU4X0V1ycuYECQ+A3fc8KZddTz3S
         NE1MwguRVe9HMggoL75pomewTBLYBnhVmWNP/JWu9RR0Kl9e/pTOly6JLyBSjRBD5cYp
         D3l4ZEuXfxJDuW8fTcD1kGMUS8SVlCscxU+Q1yxTQfmcAWzmjStSiDm4tFXEkJql5xEI
         OcVw==
X-Forwarded-Encrypted: i=1; AJvYcCXZWg3wAGpmbOmdSNx6vlMNQCiHuJ1sQAph975S0yjvkDqj6Addkp9zweiemgIzdcBG9dOngu8SVNP6gIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVq+pjCyuktXjzwa/US1PXng7xPdZC0bKosAt5cGumaKMSI5Yy
	qPx7HCGQTh3d7pYdZvboeZJd+AXiNIOcW8g1FacydmL5Bwzsw1OP0pxzTpkNudE=
X-Gm-Gg: ASbGnct8L3pkSxXnoMWv3/esbeQpXjC9i0iQ+INS/dr3QTQEFnKA8l1QiTjVQDDmK7s
	jZp8e3zbMKhJQ7HOfI1pvptqCKr+HpzlPB6/2SIW3LUenSwYSUWR2CzMTpZ6Q5HYbCp61JerG3u
	lK6zFipvHzxI9LovMqDLRybzuP91fwTpnco2wfu8TWd/UjwwrMJFwflMSJPp1EZ4t1GoVvrvt/k
	/Tt0fjVAQ0AxzFl5iJ95dDbSuM53BFQyyIuzXxLwP5ohxAn4eBHgK40K+F9SYBZ2PVQAhzzyrQG
	zHPRux+GFAV+6JXTbIrgn9KFJqWqi5f6a7UAh57a2yJIq1kxEiq6
X-Google-Smtp-Source: AGHT+IEC1FD4xPR8qaXBgzUTsr12sjtLQhuUzilQhtXARZV+vEM8pbEhSrVmYKg2tFns2Z7qZDO+Xg==
X-Received: by 2002:a05:6602:4184:b0:85c:96a6:f3a with SMTP id ca18e2360f4ac-85d8e20578fmr152307839f.8.1741645521287;
        Mon, 10 Mar 2025 15:25:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85d9db4cec4sm2236539f.16.2025.03.10.15.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 15:25:20 -0700 (PDT)
Message-ID: <6ea84ce7-d318-4ff1-a03a-e6252a5c8130@kernel.dk>
Date: Mon, 10 Mar 2025 16:25:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ming Lei <ming.lei@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250311080946.64b06fcc@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250311080946.64b06fcc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 3:09 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   cf2132935639 ("selftests: ublk: fix parsing '-a' argument")
> 
> Fixes tag
> 
>   Fixes: ed5820a7e918 ("selftests: ublk: add ublk zero copy test")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: bedc9cbc5f97 ("selftests: ublk: add ublk zero copy test")

Didn't catch that - fixed it up in-tree now, thanks.

-- 
Jens Axboe


