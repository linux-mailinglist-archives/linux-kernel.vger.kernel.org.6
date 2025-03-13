Return-Path: <linux-kernel+bounces-559243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC05A5F13A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95C77A36EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF60265CCF;
	Thu, 13 Mar 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmGhsliZ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A91EEA28
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862851; cv=none; b=WQ/ScFpKwPP/WfTlScVoXkbaUvOqpOSRY76/pOPJNKiu3gjgV7ALwIHmWWZFYLCAQNOoEpNHzeeb2Tk+u0o69Vg3jdxRCkwtFNzcOkyBFiJJlqU6HrfHQORuFXXGKMiFjN/u8QpHKCN94AfAJ5vsYsRKOhjj7EOWMMIb4nRIrVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862851; c=relaxed/simple;
	bh=LP5eXeugNTen1bBkv90xRuq2BmM2qnVG2bEcP7+53GM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hEIh2O7CbKa4WONGWKcaNpGJ+ntkd8V5K7UH7fn4dUNUYfDJoN6Uyq8dgEN32MHdUK+rlBV9+qQwQXI2tVHYZVGgKzWgjXJUK1Lo/67M1ONu5i+KwJKLuOxC2JWJ5bXNdbKAP7Y47g3vNmfzDV5TXcqEybsd0Gu0JILfXA/sg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmGhsliZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43943bd1409so5992875e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741862848; x=1742467648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ9g0Gaavw77PwDpx2+pgwcbpRIgEDZUZKLzgDfdqpQ=;
        b=rmGhsliZCZqPCaiYS6tHSdiOm/EPUha9hftpT4t5EWat5KRYalCcH7IeD0XbFd+TVE
         DkvgSneZohPcQOPnR0m9jvkUFcSBuQOoVv3Mu35P80I83DUrOBxru+A1y2bO5vV4HjPk
         rCRlEyLJbNvltl8hoe1+m5GnY4jDgEc8deVhNOtjQ8zpHpqTmdmwx4zI9wkP3N1axX98
         J9r1Imv5Ck+H+hREUqtE/aGjGYwOgO9RSMoEZU1LV61G4Uw1niKn+hvGQ9gyss98oa7L
         FrYmTxho0CrDVSoJWog31TBpEc67fpKro6wtlKXZnYjLOhcvoLvlqPPDHDXkNTp9febE
         eGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862848; x=1742467648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ9g0Gaavw77PwDpx2+pgwcbpRIgEDZUZKLzgDfdqpQ=;
        b=k00pGTpUFuRWIIkLhtWS3IS03lO5ny2JlD3OJ/BXxV7jmaCE2EL7C+NXPLR82V7Jce
         vHc2C9Fvv11duV4CaqzAbUPvU5YKYW/AdyMz88JnY/QQgRSzJZvdcoiZdwmF95FK5L9c
         cpnSpUmWR35Vim5o63ZVsfKnwYeq42Xf2BPPCHGeir8cOnry49v8w8Ejb9dcop1fGZOj
         HSahuZIaIwv2ZZlWUK9/BvtIn/5NwzB13eSnCMRea+LMgwonS6jl+gMiNBfPoYD3t0+4
         gVFkc7u1mhfenC/TEyMyvjD+2pKkYuaMUlGLDcbGc2OLdI5aw94X5jnZtYH8ldXO1iDB
         B6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrQG4FhU25aVm7PKuCvHyL5bGa9FLqjKr38eXfzXLWRYSCCsYy7repwenA/XzxysAXWIyzfnrzfF+OsPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTwe3Q/Xk/cjNdVHIItT5M5zAcXkt32mra/0OiZacI+UGDygl
	RCO45hSC/EEBXItvLgJw+iKUMnjrRkpXVthea9LP9GpSuoYf901Qj5gK0ifkxRXi17gnK840EaZ
	00+qKPcXhR/pMYA==
X-Google-Smtp-Source: AGHT+IFnP3JhBHMfVAgiBjDgec8Dj8Ys+oEmuI/lcu/U/vWhF0K6dANq8oFHYUxugoP1r6AAO5LgIu0hY38u4Vs=
X-Received: from wmbbh12.prod.google.com ([2002:a05:600c:3d0c:b0:43c:e9df:2ecd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b95:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-43cec97779fmr192265835e9.11.1741862848323;
 Thu, 13 Mar 2025 03:47:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:47:26 +0000
In-Reply-To: <20250313084525.773620-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313084525.773620-1-kunwu.chan@linux.dev>
Message-ID: <Z9K3vokYu5osMCwh@google.com>
Subject: Re: [PATCH] rust: file: optimize rust symbol generation for FileDescriptorReservation
From: Alice Ryhl <aliceryhl@google.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Thu, Mar 13, 2025 at 04:45:25PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $ nm vmlinux | grep ' _R'.*FileDescriptorReservation | rustfilt
> ffff8000805b6ef0 T <kernel::fs::file::FileDescriptorReservation>
> 						::fd_install
> ffff8000805b6e60 T <kernel::fs::file::FileDescriptorReservation>
> 						::get_unused_fd_flags
> ffff8000805b6f08 T <kernel::fs::file::FileDescriptorReservation
> 					 as core::ops::drop::Drop>::drop
> 
> These Rust symbols are trivial wrappers around the C functions
> fd_install, put_unused_fd and put_task_struct.It
> doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
> 
> After doing so, the above symbol will not in output.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>

A few notes:

* Your own Signed-off-by must always be last.
* You're missing Link: and Suggested-by: tags.
* There are some grammar issues, e.g. a missing space before "It" and
  the phrase "will not in output" is not good.
* Let's also add the marker to `reserved_fd` to be on the safe side.
* I think it is easier to read the symbols if you list each sybmol on
  one line like this:

ffff8000805b6ef0 T <kernel::fs::file::FileDescriptorReservation>::fd_install
ffff8000805b6e60 T <kernel::fs::file::FileDescriptorReservation>::get_unused_fd_flags
ffff8000805b6f08 T <kernel::fs::file::FileDescriptorReservation as core::ops::drop::Drop>::drop

Alice

