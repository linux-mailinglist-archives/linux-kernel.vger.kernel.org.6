Return-Path: <linux-kernel+bounces-183751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097228C9D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7138286AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA75644B;
	Mon, 20 May 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q6vBVsKK"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC0657A7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208734; cv=none; b=dbnK7oDQmdsfWfajOxhUm1/dTnZBt9HH6oPLPpg75vtlDj4o4OIJ028UYasLCbalS+je1GCzYKUWUrj53ovAKos4UM2xg8d1KmFvKnOdgV/TqXqy/MTc/Bo3V+qb2DfGeIFtuCzqPCvcJ6KWqd5ndVHBeyEs70hsP2TAR8E/4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208734; c=relaxed/simple;
	bh=NPNIeApQkTP38bbMexQfGxASjgvXMMuexlRTRZEIvXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgjjkIu80/VkRUWj32kQxaBbNpKTc2vgBhipJpyCBJoH4XfweWJ5hvrSfEDpe+54ai0zLIgQqb0qQ0AGoacHecryLRnR0DyK7QIVYmWfOyLHa7X36fWdThpQYcy8vJxkx7DIqWNmMP3C4k0eHPML2bMT3FlDcOBTQ2Ee90oN0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q6vBVsKK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed5cbf7b49so10538025ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716208731; x=1716813531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bo/G+8nnOMat7xurVFhAlkVWwon9h/q0L1+qoEc1F20=;
        b=Q6vBVsKKDWqfJM94tYNvg+LUB+eQbrG/JSgu4AgNFbKBIJ25TZn8Os3o8VWq0sEfHg
         PeCkg+6o13P1OeTMhfxr6qm3CKkHA7KzXo/8B1UhE1a0Jw4yBBJ8MY0g4n1pdsyegQ0E
         cnA9mXulE2SJeSGKBR2oLzxySnDZq+L8iPPxNuoFuFjsGZj7W6AkS2Z+ZWv/Cj1/ej8k
         kWn7ePPcOW4vCMsdTGwwrosEui3GXjxhAKX4WM2lPpbteqKtGf9wGgswwhNhoqBuMjjC
         OTgz3SEqlHc3YqDH+reywDtI7fFSsKBjw7J/S4UklqRGLm8lPMRTQ4PMnGTsrN/W8dTi
         //IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716208731; x=1716813531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo/G+8nnOMat7xurVFhAlkVWwon9h/q0L1+qoEc1F20=;
        b=BZhxs9M18p9bWq/OKGsy3dRjeHOnfcWpEKAdsZ4oKbvtxcM3EEZY9KDvkN3sTn8XcC
         Slg1LLEDJMcMEvkI/XU7MCEsiIccghIyCTMZlLXsmNVg/w21LJcvjrgk7eYY8jEpKOUh
         62QgmgX6pBL++VLDC7oSV8PS2CJP0em6bhLNviYYVg7m6jTkm7/X303JGdgV3ZMNCoBB
         ue9oqGYICgjtCzCr44AJsytkLaeytREOUZkAWi971jBL/MtiGfX5p9QrYYp5WZzg2lVD
         +BOHSvhO9Ln/kIXPGSFha4//io3pR4F+bbuDM2xS6mwB6RqDSJkE8AmM5BPUu+dSM+Do
         7GUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiBbPqideS+Y2RPOaOn0bEWmwMroNl8z+F0X1K6YfENdGZFk3+PLQ5GJdCq0t7M8xvbJrWWAvVacGqT7qt8nlfPOsWLAOsBirwouB3
X-Gm-Message-State: AOJu0Yyzkv5aVOvUQBDjuakVqk4kt7dfKsBr0hzhnf+VpUmKGm5Nd/N4
	pejKx3oSwukqvU7LUf4xS2MSwXKTAJ6cOL/kZ0uEG1Wa77XvTv58dbG0q4dbYKA=
X-Google-Smtp-Source: AGHT+IEj4WJNROlYb/yO972JMvwOypAjnVuorBG9UAYWGg4hOoOGWTZThXsmI8SyaQBiAm/zlKINYQ==
X-Received: by 2002:a17:903:11d2:b0:1e5:1138:e299 with SMTP id d9443c01a7336-1ef43d0fb20mr323181575ad.1.1716208731178;
        Mon, 20 May 2024 05:38:51 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c16093fsm202054565ad.281.2024.05.20.05.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 05:38:50 -0700 (PDT)
Message-ID: <5041977d-0d22-4cbb-89c3-b950c7fb1a21@kernel.dk>
Date: Mon, 20 May 2024 06:38:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] signalfd: fix error return code
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
References: <20240520090819.76342-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240520090819.76342-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 3:08 AM, Fedor Pchelkin wrote:
> If anon_inode_getfile() fails, return appropriate error code. This looks
> like a single typo: the similar code changes in timerfd and userfaultfd
> are okay.

Oops yes, that's my bad.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


