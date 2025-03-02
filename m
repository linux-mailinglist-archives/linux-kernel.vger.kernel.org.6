Return-Path: <linux-kernel+bounces-540503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAEA4B164
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804837A74BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48F1DE4DB;
	Sun,  2 Mar 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIqG+LXX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDA4C85
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917136; cv=none; b=dmEzRlZHr1hChqzhacOyT71gRTfTOWX2BtHxwnm6Or6PnLUZDD7wsb86cKrlrC9GQPjLEzUwz8xml3jQA7QBPnSmhxGqlRZmv0+FTZAhl0Sa6lNDufL2oRfFF5+UhURmK0IyAsX/gXem2t4DMvC4CsaR+dZZKM2vFT1uOVm5Zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917136; c=relaxed/simple;
	bh=WqlKFQcVw+Lfm9hYhhqS23MfZS8h4pABQVvw5R895RI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=METVN+326VNxWrMjv+T0qX5pDwZ/nPfF/YmhC1DXAu/V2NlqWzfylPNsRZVwwqBthhdg4w5gp6NFEpxWZq7DV1k6G6+9jx6DMwiItQBL8gj579YnJrXoprlsli5JeVcPQw+gCAXvYsDoXg/dShcLq8FLlPJXE2PJcaC9u2FSCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIqG+LXX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439a331d981so32509875e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 04:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740917133; x=1741521933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fjMLeo04bIYhQ94Fj02g3fKCePES0s/2xaBjMPeWzQ=;
        b=lIqG+LXXg0DkIqzgdbsfWzU9lXqtnIV6MkvklR1caDf01UCORo9Go3pOXZ2Gs9RuNW
         9BeYbbYMa4sWe8bB6Sv9NGwHIo1HFFvk2ZI6KiT7UETn00FYLov6i6A/ar2Pt26h+EzN
         GPsXsTOU3k3SDXlA4UfutEkupDdgcs5ODp869xHyfjETFcVRNY8FjnhT20KSp6BPelxo
         W0zqsa41we0LBhUwmA9x/79LeIvfIPVfoqWJ+nrZPmP2IMEIcL+i8YksQ6vIoULK+7Vk
         skxEkOx8dVfkoxhzrNi/5JDCr3w3oXPsKNPz4Qv/Yn6VSY6AUIbBXZg7UhwJ9LioaAoh
         7PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740917133; x=1741521933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fjMLeo04bIYhQ94Fj02g3fKCePES0s/2xaBjMPeWzQ=;
        b=YVzbfh579DFpteP+Ss4+CjHTHt1q1A2fAzNWIQcRPE5qaAPYc9wydx5ej8Rl8AvpWi
         jc5Gyqws88f56fiZWaBWVxWd5pGQhC63SFzx5nYmJa6Uhlc7MxvwMmHxIPb4KZnTqLyo
         cuVpWLKg2ailWhU/+9E7NAj5wz1oTtpVtJqpym/XtnuoXIXA3i/ixZlbsOcdSVouAC8M
         yAJKIBEveUZbDm1HM61E0K5uD4gW7Rre6qxriOihKy/uQJR0ydi8GKyftywqadZ8t3AR
         NNTeXNpGiAttOYtYteZZhM/4pzqtP4knqyiHempI2tWk2nguqde1yZUnbX1dr/gcM7+8
         Abeg==
X-Forwarded-Encrypted: i=1; AJvYcCUOOdaJ9J0T/wt36PqEbHHHbeEKj+3V3n/LXmddHfHO+/HTW0S/MOdEetOktgBKdwBsF4Hwth6y9+i4RMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy19IPC+orXo+WElKWiOwdXtrzeD3UbNGaYCNxu+axQ6ZKMQEY
	pEfPB+wI4nZxQlGN1SsI65YfvY5LWbSKIkqUxICjweMaT5iX7Rz1
X-Gm-Gg: ASbGncsdoeHh9tOXZpmaGmzGxj9+mY3UV1tj4aWU5vnRVkWZUz/K+aqYk76L2B3YJuv
	MldzlLjg1SAaU+HhfjPNmERd5jxe4zCq+mZuxen/iiOcBZYDmvWWAJC9GgNCdkQzr/A/d6kE1c/
	durxI/URl5hs8moESaY7+B4wbhm46LLsbCRqUENEkxcOztIN5C+0xganXoW73Xy/xZJyrAcCbmJ
	wrXFCWaFTNcy319drJFAimtgFYj3VfXOCTiSaeEJvEpqJUJIHyIV3pAd6HvY4smcBVHDkmiPv4i
	LJUuc8F38rDhwRMUgDN1YhIHauxgf+3UPl6bgGV8JL2OfgAfk9sahXq3qxyYS7/v2YuV/1zT03g
	8lppwsgY=
X-Google-Smtp-Source: AGHT+IGY0hUG4zVDzWm2dkE9A/l3FxJe8HuG4Cm9vUxX7B+CpWy/LUU44R7Xq+9khhnKmqWTTo5FfA==
X-Received: by 2002:a05:600c:5494:b0:439:30bd:7df9 with SMTP id 5b1f17b1804b1-43ba6703bd2mr78789305e9.9.1740917132236;
        Sun, 02 Mar 2025 04:05:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbb15841dsm16541775e9.1.2025.03.02.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 04:05:31 -0800 (PST)
Date: Sun, 2 Mar 2025 12:05:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Attila Fazekas <afazekas@redhat.com>
Cc: qyousef@layalina.io, dietmar.eggemann@arm.com, frederic@kernel.org,
 jstultz@google.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
 mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 saravanak@google.com, tglx@linutronix.de, vincent.guittot@linaro.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <20250302120530.1e742e06@pumpkin>
In-Reply-To: <20250228103304.302289-1-afazekas@redhat.com>
References: <20250210001915.123424-1-qyousef@layalina.io>
	<20250228103304.302289-1-afazekas@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 11:33:04 +0100
Attila Fazekas <afazekas@redhat.com> wrote:

> The 250Hz was set as a middle ground.
> 
> There are still workloads which sensitive to cache misses
> and to the time spent in ticks.
> 
> You still can loose ~1% performance with higher Hz,
> It might not sound much, but if you are running thousands
> of servers 1% loss can be a high cost.
> 
> There are many workloads out there where 100Hz is the better choice.

Are there are real issues with changing HZ to 1000, but adding an option
for the timer tick interval (in ms).
So 'jiffies' would always count milliseconds.
That would make is easy to make the actual 'clock tick' be boot time
selectable (or run-time if you get brave!).
The 'timer wheel' code would really need to work on actual ticks,
but I doubt nothing else cares.

That would allow HZ be the same for all architectures, even though
m68k might really want a 50Hz interrupt.

That is much better than any plan to make HZ a variable - which will
bloat code (and with divisions) and not be valid for static initialisers.

	David

