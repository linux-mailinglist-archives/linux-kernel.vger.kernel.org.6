Return-Path: <linux-kernel+bounces-252345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1E9311E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E457CB20BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A9187323;
	Mon, 15 Jul 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuCIzNO9"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31F1662F7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037701; cv=none; b=o0wgeGuT5QH8tjtqscV3v0cG1Dp8WpymKvSFTKEaKynPAn8seTFoXA8QZTAkIIrBeJjDAieGOy+b7h6JzzIhkH+1ChIo+0h/fkew7JYKN8ZKlCNJlYYhz3Yrvaw3d6HM4fxdycl/uZb/MqjpO9y5B6Qk8BmBkp/ucLYLdymOFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037701; c=relaxed/simple;
	bh=cajlA+vgDpioAubObn6T5GgrQG+WNLj3rbBXgaw1bhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NajnUhoKfcgvL0Poy/Nv+GupapQfZAkA5kV5JAAV5JxnsYJfXgYFlQH1pyE2wsqVwe5gC59hmRAMesL9HBOkUl0lP4DbhYM9lQSX1KjCRrgDcwlRk5y8EpSJWnEzy3IezrirnmATOaLoFho3dTqT5o4LDHVhKmBZQFqiWCWPUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuCIzNO9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65fc94099a6so15204317b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721037699; x=1721642499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cajlA+vgDpioAubObn6T5GgrQG+WNLj3rbBXgaw1bhE=;
        b=IuCIzNO9eYkJwaXq5I9PZFaTLiEiee679CB8qCB/n6Dh7xOaH8sWBsXa4c3rWbEMXY
         iLeoKeLEVxUu1gCH9Y9jPSKDD/oqVGDqfNy5rpiNy5oXr83ne4WNM9HroRl7cd+HsFus
         ByzvCt4m9BcsKjjS8eK6toFZzkjZumJ2RpovACDCZZDU5qqcgcUEnGqv56iNZzCjpxZu
         4oXe0XsvkChcryWeenuht3cLJbhD6xsIRcPx1XXt5ENrCKTpvm+FqPASgnpPykuMIKXP
         USrFSw4raFOzhb5doIXn6+CYr3BhOB8RfcMoq7kBJC9e1kPAs3ecTXr6eOLLL+Kt1kbG
         3lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721037699; x=1721642499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cajlA+vgDpioAubObn6T5GgrQG+WNLj3rbBXgaw1bhE=;
        b=LC1Jx79b4C58rPaWGB98cYQPjOtvdJU7CdL2Jzs1jKCF9zYk3Pa0b+dEUzF72aBucB
         sM/54s2Jqqm/8+E+m5CLr8jSfS/4jlDGFaiSb+H0SYK6T0V08A4dAEsfOBbx1nLw756q
         uX5Vf5GBxA8rT0Qb/kg3qFXbIfHfYCwMgCx3QZTUPcrEw875ZUs1PxrGJXzga4vBVXv1
         cltNkg4hG+SZPlFDgKHUENuNBvBYt1VAJjAA+qoGoqX55SVvLTiyKOzesQEi0tkCwEzM
         z6GnV1Jeljv0rM+tgCC8LFM23DPxWWOVfABg5AxzWFn8xyXWtLtarK0K7Zhw1LYMRWKA
         R52g==
X-Forwarded-Encrypted: i=1; AJvYcCW/MYqJbDt2vucYPHJFdqFmBbzcrsyLLk3jePPm3gmDTmF9x2O3RxkxHZePzNA4t1xo/u2NiOe9BYtAg6GEp/V1Jfqprh8YgxwiLss8
X-Gm-Message-State: AOJu0YyUy6lCO8nBFmpvgMTUXaPUcM0SJABtV8ZeacdBDfeH2sXoz9z5
	p+6ZlPFDn2Zjl0CZh600Eofz//fssVenNANQ0YMVQMSm95mfJYRXHIQ7CAaYeJDIYi38cvEZoNo
	2NA/5y3U1zcjfPWs4CzjAzHyyBrQ=
X-Google-Smtp-Source: AGHT+IFWNJx3WtUkEfz0ZHA+7EOK2L8dF4CP247LCsNp3VO5lyp1a53c6ww/5zKQmZdXFnL3vtzosyPY+qwi+1YdMnE=
X-Received: by 2002:a81:b144:0:b0:652:5838:54ef with SMTP id
 00721157ae682-658f09d2b66mr201932267b3.37.1721037699219; Mon, 15 Jul 2024
 03:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
 <ZpRjDDKGq1F4cSBr@archie.me> <061e0f4f-2dc0-45c9-b407-020120047d24@redhat.com>
In-Reply-To: <061e0f4f-2dc0-45c9-b407-020120047d24@redhat.com>
From: =?UTF-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>
Date: Mon, 15 Jul 2024 18:01:28 +0800
Message-ID: <CAOpXEOwSg_PC+D-dYsHspAnc1jw9b+gK2HSU3EE8AWmQSQ_qbA@mail.gmail.com>
Subject: Re: A new spinlock for multicore (>16) platform
To: Waiman Long <longman@redhat.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, 
	"ccu_cs_oslab@googlegroups.com" <ccu_cs_oslab@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Here are my explanations for the two issues you mentioned:

1) Each lock requires a routing table of size num_possible_cpus() for
the routing table. There can be thousands of spinlocks in the kernel and
it may be problematic to manage this extra memory.

We have implemented this method in the Linux kernel.
(https://github.com/shiwulo/ron-osdi2023/blob/main/qspinlock.patch)
All locks share a single routing table, and all locks share a single
waiting array. This Linux kernel has been running for over a year
without any issues. Currently, we have implemented this method on the
AMD 2990WX (32 cores) and AMD 3995WX (64 cores).

This is because context switches cannot occur when the Linux kernel is
using spinlocks, so we can allow all cores to share a waiting array.
The space complexity of RON executed in the Linux kernel is O(#core),
which is the same as the space complexity of qspinlock. Since the
Linux kernel operates on all cores of a processor, we can allow all
spinlocks to share a routing table.

2) Beside lock contention performance, the Linux kernel also has to
provide good uncontended spinlock performance. The unlock code currently
scan the routing table to find the next one to allocate the lock to
which may slow down the uncontended spinlock performance.

We use a bit array to speed up the unlock execution. The nth bit
represents that the nth core wants to enter the critical section.
Therefore, the next core to enter the critical section can be quickly
determined using __ffs or __cnz. (page 29 in the document.
https://www.cs.ccu.edu.tw/~shiwulo/nxt+sh-RON.pdf) The new method's
(nxtRON) unlock time complexity is O(1). Under low contention, nxtRON
performs almost identically to GNU's pthread_spin_lock (TTAS).
Similarly, under low contention, qspinlock's performance is nearly the
same as GNU's pthread_spin_lock.

As shown in the pdf file (slides 56 to 59,
https://www.cs.ccu.edu.tw/~shiwulo/nxt+sh-RON.pdf), there can be a
3.8% improvement for the levelDB application.



Furthermore, the issues with multi-core (#core >16) processors and
NUMA system are different. NUMA-aware spinlocks assume that data
transfer between processors is slow, while data transfer within the
same processor is fast. Based on this assumption, NUMA-aware spinlocks
allow tasks on the same processor to enter the critical section before
allowing tasks on other cores to do so.

This approach (NUMA-aware spinlocks) has two main drawbacks. The first
drawback is the issue of fairness. The second drawback is that
NUMA-aware spinlocks do not optimize data transfer within the same
processor. The RON algorithm adheres to bounded waiting and can
optimize for multi-core processors.

