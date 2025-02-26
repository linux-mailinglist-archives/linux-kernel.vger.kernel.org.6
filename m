Return-Path: <linux-kernel+bounces-533999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A713A46153
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A47A2F05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D922068A;
	Wed, 26 Feb 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kECxJz4l"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D4218858;
	Wed, 26 Feb 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577981; cv=none; b=C7YMWR8xZ912a1EuHQQArp7ss7upBKXn/mwQZhxfp2DHK0AToB1Um4t6HN8Ykn8wD+1Ds/Ce74gVgBChMGuiVrw3daJ8I2uxSgqIReQhgvB5YVj1/HRp8MF/I3+IPpO1g8ApNse8e3/GnZsipbtkL5jvCgZAh2wbRCqMt69OWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577981; c=relaxed/simple;
	bh=JIQw7BJUPcwv3MicIWTcVIfMUs8AGxVyXTCLAcwQkQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OthfjH/GJeP43ZkRdh6vYjyudvP9wbdgKOvJUQW9AcjlmsmEB7TZJhRkrTwpUzh0Jy8K9GaxFM26aOdPUojq7LmUpqWHhnDF1xpZRFwBlYrPQiIC7sRTlSrrAHuXbipaiFOBnlXJWRqdPi7fQIvFmnN8ZQnepzRA4KBkvBiPGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kECxJz4l; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22333fdc85aso1074285ad.3;
        Wed, 26 Feb 2025 05:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577979; x=1741182779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIQw7BJUPcwv3MicIWTcVIfMUs8AGxVyXTCLAcwQkQs=;
        b=kECxJz4lBWJRTV+KWkRDIceDoqmHBMDEZFauCGpk5COAghl6hX42FQDyleEOml0PA2
         7ngypTHR9loQl/nK7iD4u0Eosrq2yHq/tVeMz2t0UdCdnjNJWwZ3nxoqQU3KNTrRIiPG
         5sV8tpuKbg/sz8rKUrBAXc+zMRBySPYmIfwigtZaM7+jZORfo2nU1qJkpa4UWkPFwHGf
         czAU2RwMBB5lXjfEhadqFssX7QdkjK5qpzq7q3+MJoiOqDzizpSRlzsaibzJZbyd/IaZ
         noNGaMeYZZwYoBhrRQjztlEAOQHok4fy0vYz2p8XHTu77tfSq9tyEY2sl2LqDPIQrJ1k
         UdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577979; x=1741182779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIQw7BJUPcwv3MicIWTcVIfMUs8AGxVyXTCLAcwQkQs=;
        b=C7fmf3S+i6HZVonkmhlD3bB6/pS2aMrU5cg8j4aqUUZWrsii9a1G1NXUuTHfy5RnxB
         J09Nx9ljweBq5l0b9VwiRVOeplu/zwNwt5/WRnRlnfESTqo3mflJkgiQk2uawy3g5703
         2aMom4QwSroWBwv5AMHhqv2K8R4BD3EWy0zS9C7TsLO+M5YkRZ4STc4ANKrwMGmaZxoJ
         xOnvnsBNYECoBFQsdbqaNLQg1dgb7Di/Apn2uWJVIHcYo6aSM+lDK1EqGp3784tRqnnw
         1ll84AgNap3a1MZJEDWi+lbsehHVYecR4h39DrYmAEmvHXlUaXrS/LvfPN5f6xROFsAn
         7CSw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ilgk+5B9cnWB5s/4bpBYRacf7Np+fYa5Iz5CvwfRdjrjjEABvcAHvwINeTj8Ni45ZsWTm+8jJpHzOvBASrg=@vger.kernel.org, AJvYcCVG/KP6KgZbM8kF62/7AAb+8V28LollJiS4p+3I5UESHKZhZ9WrnSV/INEi+yXKvXcKCC0gegCde10WXaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjjfoiTGMBEr9qAsk7bHlaIpURsW02kCGbwkAWtwu3YWDptgO
	/V4JiAn2IzN6P0WH1rFCTXMzn4m7tnkAMGPwgufBQrXD7Xt0+WE6f2hpyC/QVv5U55pkndCKG1E
	4ukqYsbEo4ZO5oQO7BYbLZgvbSY4=
X-Gm-Gg: ASbGncsUf/s8N4x2g8T4kLnWWdKUH347AffyrSllZy94jP3ORCWgYNAnOPEM3b0W4PC
	wYvzwKBeTUiDHeasINr1ADtaNYdDTAdx+NQnO6m9gDJ3/lHChNVhl1eaVzfS0V217kZHcj3ZE1c
	grIAr0D30=
X-Google-Smtp-Source: AGHT+IGyNP7dmuRW0tYnk3XLWBi3p+ESw1dXk4s/7QyJ5jvUAPUAW4M9pIGB3pYT1Jc+VKm/uOZMy3RV5rpaubS7JAw=
X-Received: by 2002:a17:903:230e:b0:216:30f9:93c5 with SMTP id
 d9443c01a7336-2219ff56b99mr134581255ad.6.1740577979041; Wed, 26 Feb 2025
 05:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com> <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
In-Reply-To: <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Feb 2025 14:52:45 +0100
X-Gm-Features: AQ5f1Jrt6D-MHqK_yymi1qP2f2dLOB4ls7cibDYNXeHA2afziYghxadGGv1x-Sw
Message-ID: <CANiq72mA4Pbx1BeCZdg7Os3FtGkrwx6T8_+=+-=-o9+TOMv+EA@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:36=E2=80=AFPM Ventura Jack <venturajack85@gmail.c=
om> wrote:
>
> In a preprint paper, both stacked borrows and tree burrows are as
> far as I can tell described as having false positives.
>
> Are you sure that both stacked borrows and tree borrows are
> meant to be full models with no false positives and false negatives,
> and no uncertainty, if I understand you correctly? It should be
> noted that they are both works in progress.

I think you are mixing up two things: "a new model does not allow
every single unsafe code pattern out there" with "a new model, if
adopted, would still not be able to tell if something is UB or not".

> The aliasing rules being tied to a specific compiler backend,
> instead of a specification, might make it harder for other
> Rust compilers, like gccrs, to implement the same behavior for
> compiled programs, as what the sole major Rust compiler,
> rustc, has of behavior for compiled programs.

It is not "tied to a specific compiler backend". The reference (or
e.g. the standard library implementation, which you mentioned) may
mention LLVM, as well as other backends, but that does not imply the
final rules will (or need to) refer to the LLVM reference. And even if
a spec refers to a given revision of another spec (it is not
uncommon), that is different from being "tied to a specific compiler
backend".

Moreover, if it makes it easier, another compiler could always assume less.

> I am also skeptical of the apparent reliance on MIRI in the
> blog post and by some other Rust developers, since
> MiRI according to its own documentation cannot catch
> everything. It is better not to rely on a sanitizer for trying
> to figure out the correctness of a program. Sanitizers are
> useful for purposes like mitigation and debugging, not
> necessarily for determining correctness.

Please see the earlier reply from Ralf on this.

Cheers,
Miguel

