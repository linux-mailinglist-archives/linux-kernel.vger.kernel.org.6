Return-Path: <linux-kernel+bounces-395266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBF29BBB15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3671C21C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA631C9EDB;
	Mon,  4 Nov 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sJl92RWl"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE201C4A03
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739812; cv=none; b=E4dTliJ/CiKGv5FuVXZQ4a8AG8vaXmEMuA5GRpRcgYaVsfJRzK79dm92hJQE1VlrBSXsgjQDEPfHdrvEQlseXcYSch631IuS8lISu6La/DBZ75Pvs4sRRk8OMzZa1p5W10AXVj/HylsflXG4vrSrAfasa2OX0jmhhGOc71F/HRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739812; c=relaxed/simple;
	bh=S3067AYJCL7+zWWBtRRJXJM7xFuhAe7lTXvAMCqmVcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=elH0aK6Iunc9a+TIPDABzB6yt7nrN35yZy/modFm/3r7BPZ5CCtJN38DT/quPzx8G8Pi21y+UwLIa0m8UIwMs6gx2US1vhsbSEXYhjd0vGW9K/DAEYhculyIhkC2mo7R1UnKzspbCfqsmfsuHLqVLohoj/OgOza+A6yI2sompak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sJl92RWl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c6f492d2dso48274625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730739810; x=1731344610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GbXAjjC0DVPcEq6ZRD3tE7cOIMA2QAqAk8s8hpGLEus=;
        b=sJl92RWl0a0WZM7srfebtCNFcWopi2oeW6mSCX7IaY8LGAi5BxiazGNUVSnbPqg2zh
         c8rMiuAxG3qIeePGpDS/Gi95J68212zGx3ZldvQlJ1z60qgtvFWbgWOLXdkOxmltRFTH
         4aIpcf/t4aTZdpAJ+4th2KNtT3zjxZLps/J1lCbj9JEkIeR03Q9fu0yom+yqa39s4EdK
         zfOFnhXTm5LzQxrFiVFFwg/g02XZOZhvU7en/C+psxvmxGONfxeTUmkDe/M9cyEP9Sls
         Is6MkidjZp3at2lYqlRWr559fRK2LD5Y+6eSs/XCqOSbWaTU8P6y/OWtDg4UjUD38+Uv
         VtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739810; x=1731344610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbXAjjC0DVPcEq6ZRD3tE7cOIMA2QAqAk8s8hpGLEus=;
        b=kgzG0fdeNbP60npnp0ou/cc7a0rxZzsr2qxnu2drwXI1wzRENqVWCWjpzAQojAnCiJ
         VhWWyL+jUEZh4cz7SEoDWfOJTCbqYkylh/g0SsarrEAg1MIgfLapscgu8frokeeCj9Ga
         DAtazLtArB6DFrzhtkkTMohd5KZFn5ed6tAQa+noSuxWznDPgRYkgkYRkq9Xvklpwb3r
         y4hfi2XcL1mSCYpHftfriHeG+Hx0NJMfNrW+hHM+dXmbew5vJaWZokzGtZRDZCFNq7GU
         E2YpJEiNf9+afrpRRpLPEhQI6NmtCUwmfNrLOwtpmz50ZgN/G8nZGUvA0/pH3214pvrm
         /CGw==
X-Forwarded-Encrypted: i=1; AJvYcCVLCCg2oa8HfOVvjsK7xsn4ckp8YJ2JE8Vy97+7HLFCVfD8tKM+YrTFxYdRoqxivHC+GFGVk+iJj5DzYDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxdLJLl1Ura56USYKfTNQfT7jZXh2go0fiFTRe3K5Ji1Ks52b
	AGj7LeJnH93NLpg1WQcb+GqCn8wstrT6PS3tSYG6g7y1Sq6Vad9cTtuRMK6fVqw=
X-Google-Smtp-Source: AGHT+IGzTAJhBsc8WGoF9SF4SkHI7Sviz3GueVYb6UBifwKMkxwAE3woCCg7phGOKPAi7mQO7/dJJA==
X-Received: by 2002:a17:902:e84a:b0:20b:ab6a:3a18 with SMTP id d9443c01a7336-2111aee4349mr190732225ad.17.1730739809422;
        Mon, 04 Nov 2024 09:03:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04977d7esm2008543173.99.2024.11.04.09.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 09:03:28 -0800 (PST)
Message-ID: <0daae856-a3c6-4eff-95cc-e39674f24d41@kernel.dk>
Date: Mon, 4 Nov 2024 10:03:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] [usb?] WARNING in io_get_cqe_overflow (2)
To: Pavel Begunkov <asml.silence@gmail.com>,
 syzbot <syzbot+e333341d3d985e5173b2@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6728b077.050a0220.35b515.01ba.GAE@google.com>
 <13da163a-d088-4b4d-8ad1-dbf609b03228@gmail.com>
 <b29d2635-d640-4b8e-ad43-1aa25c20d7c8@kernel.dk>
 <965a473d-596a-4cf4-8ec2-a8626c4c73f6@gmail.com>
 <16f43422-91aa-4c6d-b36c-3e9cb52b1ff2@gmail.com>
 <e003c787-71b5-4373-ac53-c98b6b260e04@kernel.dk>
 <09b7008b-b8c1-4368-9d04-a3bdb96ab26d@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <09b7008b-b8c1-4368-9d04-a3bdb96ab26d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 9:54 AM, Pavel Begunkov wrote:
> On 11/4/24 15:43, Jens Axboe wrote:
>> On 11/4/24 8:34 AM, Pavel Begunkov wrote:
>>> On 11/4/24 15:27, Pavel Begunkov wrote:
> ...
>>> Regardless, the rule with sth like that should be simpler,
>>> i.e. a ctx is getting killed => everything is run from fallback/kthread.
>>
>> I like it, and now there's another reason to do it. Can you out the
>> patch?
> 
> Let's see if it works, hopefully will try today.

I already tried it here fwiw, does fix the issue (as expected) and it
passes the full testing too.

-- 
Jens Axboe


