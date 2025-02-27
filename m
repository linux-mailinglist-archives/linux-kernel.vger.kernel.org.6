Return-Path: <linux-kernel+bounces-537336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7FA48AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E732B3A9E40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F413271289;
	Thu, 27 Feb 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIgsVSNz"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2C1A9B2A;
	Thu, 27 Feb 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692239; cv=none; b=lfnYZWqWhG4C3nrj9V1DH5JG1uhaxAMcFsfpINspbE9wiDXN+8Rw1H29IHtJv2FYIjCkBjc8h7ceDNR1nBO1H2PzJJgYo2bPTSQgRbtVf3Ojzlmj1xSOuLHQEN3BWgQtaaZUWahn8KIqTLIocxH0FRvvjAa68fqKZKYz8mUZwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692239; c=relaxed/simple;
	bh=btlCW5mLLVIYYk2nX4RAZ4l99i17M+CnwyEwJPwKI0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckv6/8PJOY6UnxZxxgRbXNlIKJQ8vOl0/Ld3/38nf1WdKuTBGIR5vTMMjCupEHrC9U+1qnF1oz+ftihMy0fyugWBr+7BrU4T05knEQ8bp5D1B2294ALOPJ8zwE942jeE8J2fZIdjOX3sdsD7800VgGZAljMUmM1bK5J5vgZkYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIgsVSNz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec111762bso246643666b.2;
        Thu, 27 Feb 2025 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740692234; x=1741297034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OPiXI+rd/MrzDn/nDWKXlSzbv1AQvFkOB93Td3FkH4=;
        b=TIgsVSNz9L4Kbjueip7ew5hK3syQCFSmvpG0Vjwq899o1afTQ1u0h5JPVTlq/SI+Cu
         4N1N5zYkQZbOZQYDHStBVwd5yct7bECM++R2oEhiuaMoKDWvtph/JJl355cfcq67EP/q
         EVQVPh3pLpsE3SsqHAsbOg3N9Xh9MON6+HJLBZKMGkdGfw7epUj02TxqBtuLScEG/0LV
         CdY3R1omLPdgClxmKhbspa7FWWfd1rz4JYaXOC95dpFViJP1GUDaWrvIefxLLepKw6F5
         iefzdbY9R2pmsybKKqWqxvhqdc6aRNjjMhc+TjVyheuPoav3jDYGIAwD0fEitwUkmNEG
         nnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692234; x=1741297034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OPiXI+rd/MrzDn/nDWKXlSzbv1AQvFkOB93Td3FkH4=;
        b=IizW9ybSJTrB1UqYKhsHAj9G4vYAWapzzUUCieNCLx+V5hnBx0AP8jjx8Itu4DHXcu
         hVf35IlRRuVVBQfdaRI3MBzKcUzVVqp3cyAR+0mp9QYbYq4QkHY01xR2Ry7RB6liCmVu
         2YZ9hbgjAh5SEucVkLZWPLsqY3NLNIHrJUHWZfPGTvWcDsQkln7amL7AaPS6yQuvhuJ/
         GAKXVgfox4zh4wahSgoVfD42oiHsK/9yBxogyLapAvCv+O18RHzNuxeBzT/UEyUbilq2
         DelJLZEWZOXJQko5m0hR2onEiGx8YzfVUNPztOYhByfZwrlx7QNhgWO8aSsD3yOmfGKl
         Mc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8Onpt5Ktq0gXTcvbFiE+kd9E9Y7s9BWDKA7Ue0BPhpPv6Q4vJvIHaH+vj0bKM8pNQMf1/wU00PhT7NUs=@vger.kernel.org, AJvYcCVODgIqoA1ViPwb/z4VcrAcVBcXPeiXrX6q0mA0K0jndUrTi3v2nWfvzhgt2OJWabpJ4fC/DKohYSVs+bbbG8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0NGcu47VxDZ+U6IXq2rQ/nh74tOw1rI1OO8lmjoHJgpTrdtX
	zjr6sO6l8BgBJCDturfOw+93vqDijxm5tmw3Bt3z90IJ3jNm2JjHm3i0GsyGRumSJdFCgs7BnIn
	T5jZiS8InJ53DTkuEh/Sm8EPehjs=
X-Gm-Gg: ASbGncuEFro/HN1Qj9DQt2UI3xVl7/GhNefLlmH+O4N4hAmjycwKPjN7ocjPoKAJoz3
	jXaOqQk2wJ+l9yfDLsXNRZ72UbXMqMfQtdyccpv94WPLLMgYW+XJLhtCZ+Av5upTQYdqoToypWr
	eCMQixYg==
X-Google-Smtp-Source: AGHT+IGdlWC7jyxJ9UtgZj3x1oxVxEs/GQ8X4nwvawPLmqnQBdoM5j8QxGLMU77XPGVkRIdrYErK0UE7a6Dq68dnnT0=
X-Received: by 2002:a17:906:d542:b0:ab7:beeb:d1f1 with SMTP id
 a640c23a62f3a-abf26837fcemr115485966b.51.1740692234080; Thu, 27 Feb 2025
 13:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <Z7OrKX3zzjrzZdyz@pollux> <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com> <Z7xg8uArPlr2gQBU@pollux> <D81L5PE1SPWC.O56MB6SRS0XK@nvidia.com>
In-Reply-To: <D81L5PE1SPWC.O56MB6SRS0XK@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 28 Feb 2025 07:37:01 +1000
X-Gm-Features: AQ5f1JrqDxEQ56EhqKKjLvOBDjGfULXzUH0GjV45l8xFwzjJgSzflFTOZ8R4_g4
Message-ID: <CAPM=9tw=8WtR9093EThr0aY6yTYtef9SBgjN5S1xZUXaWN8aWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice implementation
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, 
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 00:11, Alexandre Courbot <acourbot@nvidia.com> wrote:
>
> On Mon Feb 24, 2025 at 9:07 PM JST, Danilo Krummrich wrote:
> > CC: Gary
> >
> > On Mon, Feb 24, 2025 at 10:40:00AM +0900, Alexandre Courbot wrote:
> >> This inability to sleep while we are accessing registers seems very
> >> constraining to me, if not dangerous. It is pretty common to have
> >> functions intermingle hardware accesses with other operations that might
> >> sleep, and this constraint means that in such cases the caller would
> >> need to perform guard lifetime management manually:
> >>
> >>   let bar_guard = bar.try_access()?;
> >>   /* do something non-sleeping with bar_guard */
> >>   drop(bar_guard);
> >>
> >>   /* do something that might sleep */
> >>
> >>   let bar_guard = bar.try_access()?;
> >>   /* do something non-sleeping with bar_guard */
> >>   drop(bar_guard);
> >>
> >>   ...
> >>
> >> Failure to drop the guard potentially introduces a race condition, which
> >> will receive no compile-time warning and potentialy not even a runtime
> >> one unless lockdep is enabled. This problem does not exist with the
> >> equivalent C code AFAICT, which makes the Rust version actually more
> >> error-prone and dangerous, the opposite of what we are trying to achieve
> >> with Rust. Or am I missing something?
> >
> > Generally you are right, but you have to see it from a different perspective.
> >
> > What you describe is not an issue that comes from the design of the API, but is
> > a limitation of Rust in the kernel. People are aware of the issue and with klint
> > [1] there are solutions for that in the pipeline, see also [2] and [3].
> >
> > [1] https://rust-for-linux.com/klint
> > [2] https://github.com/Rust-for-Linux/klint/blob/trunk/doc/atomic_context.md
> > [3] https://www.memorysafety.org/blog/gary-guo-klint-rust-tools/
>
> Thanks, I wasn't aware of klint and it looks indeed cool, even if not perfect by
> its own admission. But even if the ignore the safety issue, the other one
> (ergonomics) is still there.
>
> Basically this way of accessing registers imposes quite a mental burden on its
> users. It requires a very different (and harsher) discipline than when writing
> the same code in C, and the correct granularity to use is unclear to me.
>
> For instance, if I want to do the equivalent of Nouveau's nvkm_usec() to poll a
> particular register in a busy loop, should I call try_access() once before the
> loop? Or every time before accessing the register? I'm afraid having to check
> that the resource is still alive before accessing any register is going to
> become tedious very quickly.
>
> I understand that we want to protect against accessing the IO region of an
> unplugged device ; but still there is no guarantee that the device won't be
> unplugged in the middle of a critical section, however short. Thus the driver
> code should be able to recognize that the device has fallen off the bus when it
> e.g. gets a bunch of 0xff instead of a valid value. So do we really need to
> extra protection that AFAICT isn't used in C?

Yes.

I've tried to retrofit checking 0xffffffff to drivers a lot, I'd
prefer not to. Drivers getting stuck in wait for clear bits for ever.

Dave.

