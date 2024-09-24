Return-Path: <linux-kernel+bounces-336466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176DF983B35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481331C20991
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21514286;
	Tue, 24 Sep 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mib6P9mW"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF2DDC1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144814; cv=none; b=Ja755LOOA80CR7p7TGRS55zpw9fgV1DY1vE4dE96xQBUi1Nq1im3OhFK6X/SVdiGXNRPm4KHcs7HzlGyTdezgqNgn6TeFBjDvS8beiBVG1LZWx/abpDbxdTu61IPIgl4KiJauUiN3oc8uwSk/QYAY8fZ+JROGYdrYyRz3Qlv6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144814; c=relaxed/simple;
	bh=bxOnn9+awkw8sN8GOkoGhDOBqS/M5kXNIzc8Ou4SrO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/crXpSHJNWDnRcAGGt3Ptd5//T4uQrlVBbv4F/JWpkZ6WfwEqMKEw54WM+LI9RqUtl9HPDEvLyf4qBfbBdINifPHFSsgik2NWc2VkTFnsD7rZYS5lBDeQnQJpLyAnqfBqLHYExmAR+fmLycrG5TIWSYq8W4q3HU7lzJRJe0VFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mib6P9mW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso64448041fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727144811; x=1727749611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rzKZqwNvBPW3pytUWUsUv/7tI4XFMgW7ZP3i5FQGL2s=;
        b=Mib6P9mW/eQzgMkGI8g7D92CP0SWshZSQQNTawKYca2pDS9erj+WsYKcm5FhNVXphJ
         LXq5U3iXGt1IFx/lVUDOoN6Qrl+uj6AGk/Db++PIG9NXsvatXOXs5R5zoFIWWI8Qxxue
         6tWrs/5lveI0f5OwFWz3Jd/U4zLkg9C/G7eTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727144811; x=1727749611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzKZqwNvBPW3pytUWUsUv/7tI4XFMgW7ZP3i5FQGL2s=;
        b=o/STYocaFgr+wnMiID6sMPFiMNH3EPureCYVlsdt4f2DldPcz2h8lnOKPs7bsMH5YG
         N3Pm/qOHTXasdlYjj9lGci4RcLzJ3JcRfASado0+hSLFenA3v9O5wGgjBbKe0FUFUEEq
         sA/5hLedHNSwBbMQs+zPEH7HlmwgNmpoTdq6RK8YfZnLc8wxSa05vbtrOEc48Dax1a/B
         /CIP9yfr8BCn9625Tu3+sVibaWxJuVgVNlXSpJc/+dmgGpqj56QJBlFvVyEbx80iUhJW
         Oe+xKguEKsooPLi48S+/jSA14LoNwintMhFjEh4DLMIaqPVr/vB52YkVYiJf1PetCESQ
         2d9g==
X-Forwarded-Encrypted: i=1; AJvYcCWpDqgniC7U4OCrKVPayeoMrZE1f2b+b+/Nmf64LBEhFgv6Vp4qn7GPQCnBFQY+G4fmvuc20MCGQOUO4UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKqeanDmFg4gIPXcAAul3EQatfIkw6ydLSPzVyatv24bURXyC
	8bxqfNSgE637/mQswSBQqyg2//LXxBWWQInEitiH04ztCQ0gCkVL6zw/LuZsUp0jW6FFaVE73Sq
	o83ApBA==
X-Google-Smtp-Source: AGHT+IEZq4pGB/+ddYcr5cFf8IlDbJkr6nkBXUfIejYQsEMH4AgQps0ljuSFrUcExhDeaWPjzv315w==
X-Received: by 2002:a05:6512:1391:b0:533:47ca:9773 with SMTP id 2adb3069b0e04-536ac33b2a6mr6253933e87.57.1727144810328;
        Mon, 23 Sep 2024 19:26:50 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8648c19sm60853e87.201.2024.09.23.19.26.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 19:26:49 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-535be093a43so6062544e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:26:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbWnwNlp0t/VFR4jNhEZcuRr4WDCF0vPTCprt4hkfnF+HZxjO8xg58DY30Z5bSUqzZgEII/hMFBq1by84=@vger.kernel.org
X-Received: by 2002:a05:6512:3f01:b0:52c:dfa2:5ac1 with SMTP id
 2adb3069b0e04-536ac2e51c8mr7222689e87.24.1727144808378; Mon, 23 Sep 2024
 19:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg> <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
In-Reply-To: <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 19:26:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
Message-ID: <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 17:27, Dave Chinner <david@fromorbit.com> wrote:
>
> However, the problematic workload is cold cache operations where
> the dentry cache repeatedly misses. This places all the operational
> concurrency directly on the inode hash as new inodes are inserted
> into the hash. Add memory reclaim and that adds contention as it
> removes inodes from the hash on eviction.

Yeah, and then we spend all the time just adding the inodes to the
hashes, and probably fairly seldom use them. Oh well.

And I had missed the issue with PREEMPT_RT and the fact that right now
the inode hash lock is outside the inode lock, which is problematic.

So it's all a bit nasty.

But I also assume most of the bad issues end up mainly showing up on
just fairly synthetic benchmarks with ramdisks, because even with a
good SSD I suspect the IO for the cold cache would still dominate?

               Linus

