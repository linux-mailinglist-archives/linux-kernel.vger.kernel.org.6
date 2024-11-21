Return-Path: <linux-kernel+bounces-417070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E09D4E91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F37A1F25845
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322CE1D88D1;
	Thu, 21 Nov 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpRH4+yu"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD6433D9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198829; cv=none; b=T6EZuruHLIuOpjVggGKn8PDkQ39FNcVH8Vjo4e9jx/t8mEQd54jsV/FSevp3/yL+Di32IMtyPFlreIGJx534d8nPCmxZX4LCHVgoE92qzTSHFqADVhX7qyS/WjO8bjyubegXEXBhjA8q4wdkG1jGLXPUCf2K4dlfctG2d9MC50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198829; c=relaxed/simple;
	bh=Yg61T25n0JyEDgajFQezx7ulax+BxvUMrjfK61A6WP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6EfOtVQI8QkOqi+O9htGXZuRaV7svp9RMrkBVplwKCwRxwosiT+Azqgb821tIekpnXBPoN/SG8XTeI8QVT0cgekuRGz1ws79JNB91kqSWvN3Zi9vfiui0ydtfrcjCeWsBDgBULK08UckHR0ts77MfPdLGCuBHee4TgmAnwyWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpRH4+yu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724d8422dbaso228935b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732198827; x=1732803627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg61T25n0JyEDgajFQezx7ulax+BxvUMrjfK61A6WP4=;
        b=EpRH4+yuAGJaPEUmzoRSOqPX4YQUHyxXUMFzZ8h6HSYwKo7H9osVPTaJltJd2XSf/k
         xVZGPU+4Oc7/zbL6uqR/Yx/QupOe0IFgU2oL/u3hiKfQ8AEnm0BYHY5rzgDQuxnZFm/6
         X/NPx5S8s08XKrUruM+1oWADVFqpg01JP9Xde39GHBF8zJR5lAjUbzqUkHaIpazL8CoB
         y+FT8sTGuTvjMlzxfHIDv5l/puCnDO/9LWtH2zxRNQsxqjEFYgnNRYVK3yWC0RaDnQdA
         Q9AfL5MF1ODtnBLMUHk/B03RqEA9UN5UwYRJ+qmxLRNKeJW8GblweygPubiYqgRI7eo3
         CWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732198827; x=1732803627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yg61T25n0JyEDgajFQezx7ulax+BxvUMrjfK61A6WP4=;
        b=YwbqarbF8jCFOnNFdg3VgV9m2oejJWLc7u7vrWhCsRQ6cWIBt0G+RVQctJGqvbHImf
         7TN1hZiOSseFK846deCXJxNfjJjEpk53zuG0tBuCTpiV46p3v5o4Yf7FTbigIkJ8oJF4
         btnYxRrfgTrXQqJ8nwr6oGpbaOLfHieEc8a9HcvkLpjZ98yOhSrWZgFslPfuDxBV3Jtc
         0B8Nj7rxR6Q9bk8Wkvpy1L53c16TAtGsBrABErLFOsl8qE5OUDS8xI5pTUH4qmmyddnZ
         OP5gVDWOL0/yYDDTfgR31deZ79dnWXK/G2aBqRRwMUhUcK+BNu2J7PlSW2Cw2YEp+Fby
         UXYg==
X-Forwarded-Encrypted: i=1; AJvYcCXFbMPMTRSLTUTSUrjpDoND8/3NO0RkJ6LQeYPPmk0mOCZf7YIlq6ATdTXjXZRKGFKObr+7bwzN+5BCPrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzRyO8fTQ+JKJrWOxJ8rH4CPqxalA5HIqvPrSa7JOvvd3iezqU
	KL04wdBqhgS3lDALmnB6JFiFj3HJKV+C3ExLOd69L+Crp3ebN2VGBeU0NzcbwZJltlmfleAglww
	DCBUhrKM59yBAxVvW+BoTEXGhB1O0ScjI0JhE
X-Gm-Gg: ASbGncsdPEMVBaF6OtS2Ou08VUxxw7I2EqlStNs/tv3zU9r/0cBC2GNU3n491KKIsRK
	j/VwDyPfXfn+FCkbMjFJnEBd2vqBzXb8UhgfjuS5HQLVpf43VARWBVUf/vQw59Q==
X-Google-Smtp-Source: AGHT+IH6DAzp75Ub4R9d9M9MJco9pUmZ9APNot+eAB22u1Roysw5MqTYRjVhwyyCf12LMYer0D9VhLOwlaxYrNoULmw=
X-Received: by 2002:a05:6a00:997:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-724bed16a4emr8978740b3a.19.1732198827162; Thu, 21 Nov 2024
 06:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121141412.107370-1-andriy.shevchenko@linux.intel.com> <Zz9A59XQdiHJ8oLp@smile.fi.intel.com>
In-Reply-To: <Zz9A59XQdiHJ8oLp@smile.fi.intel.com>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Nov 2024 15:19:51 +0100
Message-ID: <CANpmjNOQpQdjipRQn-H=noPhDW1pfR--h5hQ+DVXyHTZcKhoJg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] kcsan: debugs: Refactor allocation code
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 15:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 21, 2024 at 04:12:50PM +0200, Andy Shevchenko wrote:
> > Refactor allocation code to be more robust against overflows
> > and shorted in terms of LoCs.
> >
> > In v2:
> > - collected tags (Marco)
> > - added patch 2
>
> Okay, it seems I have to check the Linux Next for the current state of
> affairs...

Right. Please double check this still applies after 59458fa4ddb4
("kcsan: Turn report_filterlist_lock into a raw_spinlock") in latest
mainline (or -next). I had to rework that code to make PREEMPT_RT
happy, and at the same time got rid of all this old code. I suppose a
side-effect was switching over to kmalloc_array() and making it look a
bit cleaner as well.

Thanks,
-- Marco

