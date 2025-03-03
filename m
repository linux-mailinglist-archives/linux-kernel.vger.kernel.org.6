Return-Path: <linux-kernel+bounces-542673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14690A4CC47
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E507F1748F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58415234988;
	Mon,  3 Mar 2025 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmZEoDlI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8223496F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031615; cv=none; b=c1/pv5u9tosjeGi/uz6ul8JlmvM9m0WBv1Ej3Ssr3huD/xM0pyrqHQ+DcUVyP1K2EbSc1uTzXiZxn1owrb7a+9jhnY6nmrfkoj5NxW0BMfvSMGtIac1qIXWvz6O+6LBvJf+EqmVXthJbC87pCkVkj/4ZFFrQRWtl/qnKAosUkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031615; c=relaxed/simple;
	bh=ebLFxwasby+0vy/UEwHWyrdVE+EomoFlc0ADafqoeOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZqhs9OSCm6aDNoyAWmCDCaBtbUcwBekC+VMuhYBj0LO/firRkdeeOgX9I3WFxKOt/jgKRKjQgIZInz0+kKp5OQfzRO3FVLcWMdiYHsF4ECxlW7beXaGtTYUKLpX7NAkmuAifYOTUUzZVoTw1QVoH25mYQPbDUgvkjo9f8aJgjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmZEoDlI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bb2fdbb09so16831971fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741031612; x=1741636412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D1DyltNW+PI34ENcPnpcF+cPTNvsSjlyJmcdiDHRck=;
        b=TmZEoDlIy+dAQ2d/g/7wwE/waAdcu7Qt1bC6gk7tJ0C9DAAFklZdVTbS3rjoSXyuzm
         qYYtjQ0PeD32/wLU64HPJ/5/GqfgOJXxK8MxN4+kZzjW7b4Dc42YEsckQYv9C+g5YcKC
         U3916USh1TdfTqU61huWRoCbAT+MyJXajTeMFX/n0F1JdzTL8t3EbTLyU7DEHP+kCM7v
         TWj6lVIgtNQ4MyoKrL/OBdnl5knTCuFNidUtW21PCxAJV4HeydDYG0otv4rRe8vdZnsU
         oFq3T+UnSUFucrf2sJ9h4qevCWZJdjNMWAd6OTf+KjjaHmSiY8pubnrHmiEsA/pe3L6L
         c2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031612; x=1741636412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D1DyltNW+PI34ENcPnpcF+cPTNvsSjlyJmcdiDHRck=;
        b=NlLZOmwy8qru7TYfmgfZcMMkJbqybTwzxslY9l8MXa8i9Wq50uuPdYkoZS/xF33U5t
         3+pTB86tYIlDvr7zGq/T7mtl6Q915xxyjpjQPDcwJ5aYXVEF6fnIqnoI7Bzs6HtB/ei9
         nkiBw1r1yIzmGN9MhNtdbA2E/Ae66voiIJnA4OQhTDe09qOQKR5lRrkv/SwOO2ZsaDD4
         0sryLjRT1PQUQcbtG+HlvdL8qeKUBy+9vowRkFVhEPYtC+Q57n5x5RBdpczlTHcMIXJr
         IW7t/P2cUVOtH6MPag6CR2MFY481Gc/v7dAWLAroqw31TJEIZ3eOrjLUIYyRCGKFTR86
         1ncA==
X-Gm-Message-State: AOJu0YzZYilZMA6M1n+SQhq3vaDb231Hkv4tNZhx7PfHg2L1UAHBUXdh
	div5pCYMCTuIDkqjCLrC+zNZpJGg/Vx3qRpNIgaiFiTHyzP0Flp0mZRHnUkFQ+qWJg0tCry3RWu
	0z+vC1CtYrx9TJvg8F8DLtGarbTJp9RcTwX4=
X-Gm-Gg: ASbGnctWL1OTxslmSyfUsSC5GbcAx0+1Kf0++tA5jYVN1IM2UBwzW74jwyL3v6CiF8E
	tR6qy8KKWi6QM5pQpTA8bC2lCKdUw3rKoYwEhkMZt9jpyIOMmOvEtn+4JVC+8nB+ygmiSR/l5Vg
	ukbAR4iYaypF9yEmp3epFnsBCJrg==
X-Google-Smtp-Source: AGHT+IEwrd52A/W2iEO3rtSs7+OU6jAMHR6O6QgEtegbG2eAScmAPJsDGfeMyXqYloD3Uj4YAJSfO9NoGPQFjvsAUlQ=
X-Received: by 2002:a2e:91cb:0:b0:307:e498:1269 with SMTP id
 38308e7fff4ca-30b9330796fmr50024251fa.37.1741031611818; Mon, 03 Mar 2025
 11:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303165246.2175811-1-brgerst@gmail.com>
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 3 Mar 2025 20:53:19 +0100
X-Gm-Features: AQ5f1Jrcb1wmsDFssfYJvdAuvz5DGokOmnhRqtbrCS7TVmStL3lz2GgZmFnVV6Q
Message-ID: <CAFULd4bCCxa05zn=vSYQQNtw+-WxBs2VEBb7phRRKFzpc4xSbw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:53=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> Add a new percpu subsection for data that is frequently accessed and
> exclusive to each processor.  This replaces the pcpu_hot struct on x86,
> and is available to all architectures and the core kernel.
>
> ffffffff834f5000 D __per_cpu_hot_start
> ffffffff834f5000 D hardirq_stack_ptr
> ffffffff834f5008 D __ref_stack_chk_guard
> ffffffff834f5008 D __stack_chk_guard
> ffffffff834f5010 D const_cpu_current_top_of_stack
> ffffffff834f5010 D cpu_current_top_of_stack
> ffffffff834f5018 D const_current_task
> ffffffff834f5018 D current_task
> ffffffff834f5020 D __x86_call_depth
> ffffffff834f5028 D this_cpu_off
> ffffffff834f5030 D __preempt_count
> ffffffff834f5034 D cpu_number
> ffffffff834f5038 D __softirq_pending
> ffffffff834f503a D hardirq_stack_inuse
> ffffffff834f503b D __per_cpu_hot_pad
> ffffffff834f5040 D __per_cpu_hot_end
>
> This applies to the tip/x86/asm branch.
>
> Changes in v3:
> - Fix typo of CACHE_HOT_DATA()
> - Move hardirq_stack_inuse to irq_64.c
> - Add __per_cpu_hot_pad to show the end of the actual data
>
> Brian Gerst (11):
>   percpu: Introduce percpu hot section
>   x86/percpu: Move pcpu_hot to percpu hot section
>   x86/preempt: Move preempt count to percpu hot section
>   x86/smp: Move cpu number to percpu hot section
>   x86/retbleed: Move call depth to percpu hot section
>   x86/softirq: Move softirq_pending to percpu hot section
>   x86/irq: Move irq stacks to percpu hot section
>   x86/percpu: Move top_of_stack to percpu hot section
>   x86/percpu: Move current_task to percpu hot section
>   x86/stackprotector: Move __stack_chk_guard to percpu hot section
>   x86/smp: Move this_cpu_off to percpu hot section

For the series:

Acked-by: Uros Bizjak <ubizjak@gmail.com>

Uros.

