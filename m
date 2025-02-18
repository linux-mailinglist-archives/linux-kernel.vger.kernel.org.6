Return-Path: <linux-kernel+bounces-518532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9DA39087
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17FB7A3808
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BD13D28F;
	Tue, 18 Feb 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDkkeLIX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093241E522;
	Tue, 18 Feb 2025 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842969; cv=none; b=C84xn1zgnUGp+/r5dCJXD9uFsAVmajKhCzVztDGv4ljst3xalGN2fuiCSXpnXq1uNANZl4dkL8eid+5lQoglCh00o5GIsUp7XAocOMMjiKr++LHCIINRKxmT6QjKKq+DbCV2cJQXzuZKpqFCNVvWwG6le5ePdv/obr0LesCyE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842969; c=relaxed/simple;
	bh=41IQ5FEZdJBaYMK9dcKB5QnMXyvj/mEgL5YbHXvJnE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQKwxE3sUtiSHfD0q3PVH0yadSGBKs1iN5jiGsAVg0yjhpM/IwKvBpTPRvtbXjnnxpB6sinnPKQpOP6l+oQW2Pva6UShvS7jHhQM4/1w+lWbUtZqjWKFsYRbAeEDxAyvtt2gzIt54jjMcovt/u78ckzY+UXmYA/D0UmuROnYN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDkkeLIX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso2681429a12.3;
        Mon, 17 Feb 2025 17:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739842965; x=1740447765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dg0cV9YMuOzAAw8bH2Nl8pZMkp2PyRYW0a0TFVz7OKY=;
        b=XDkkeLIXSIcpTfkhcPKDbY/mSGu0OsxzRyozuiZMLpCInrZApctTXoADKhzKEfLWmb
         bSAtd8phCdOn8hxpu7Avn+t8M2RYDFqC+aT/dB3NNM/IwwW0PC2M35FqjfQgkuQWJeQa
         ScHqJBjomBwp9mVvTX8tB63lxNHBLnDmNYt9BEhAdBI9JhCVsfVPi+npaivMu9uJxZpi
         3BISrlbRL9w9Iwfuo7fI/YzhjSkayl3NoQ2ogOYbKOMrhM8qPYGoMjHaP1ioLjwPW9xb
         lSCYUZLIuy21ERX4RNOCCjIkHy8LImXt80adZflkYAIBtvHVA6MMUm90wPIQq2sZUW0g
         iRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842965; x=1740447765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dg0cV9YMuOzAAw8bH2Nl8pZMkp2PyRYW0a0TFVz7OKY=;
        b=BujNh5hTviwLvI9IcMKHVRujUkUwWCJhadtCu1HKwZ/LWfnRXH/oVy2nyGw43dlIb5
         Tw9TeylGqnFQysd8/FK0Rjw78fei+EHnwsZpIOGAFQwJE/EKYEx8CSIR3MjmByq9ZXbx
         F8cAFA2d1VG6onr/qKWPzWmeeSq1dhDRaR6papTVddRlt6XPnSSOZBaidam8Gv9pHTSD
         XZFCAvDbKIHEwsu8aDgXcV20VRy6mdkXBeEyM1qyPi4Wzz9Eq4L90AosAM9FK96dyFSg
         hykn3TMulZAjMvwNR1KXxWY8wdBEqiplvNF2Ow3onYgXjlw40E6w6TdXss5Os0/mX5uV
         kCsg==
X-Forwarded-Encrypted: i=1; AJvYcCXWf+1yLFv+jpZDgoVGKY56+mJsiwmzIVcrFWpnH9LSKAUZQwXXKP8gRqu7JOAoC20ILX5mv9ay+ZVvpcQ=@vger.kernel.org, AJvYcCXfaCrdG5kxNjR7T6hYKar+FNOHHGNz3jcYqCiekqzn0xb6GCDA7mm7q+W+IUP1lN+myS2hzz+iBopO37nrHLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOu7N67CU0ROMxX5IxN1934DyTt2JRlekCRjd2AMetld6MIK3o
	svzyEx9yLuaSwVDk+aL/3y0X4XvgktSRPJax4vt9YvSyRQyDMFBHeRbyvzPsAbCxFRz3GXky4Sp
	2x40Sxfb5+hs0XnXGPd+xpctjt7JjSQ==
X-Gm-Gg: ASbGncvVivIVtiIXPJ9SgevGa9buFE/iDGYCiG4l1aR/+XWmM6LaWEZtdGdlWnfP4oV
	3AWScF/GSGd8qY/tLNvzv4+4tL3s67Ld3fY0GolzxH1mose4LmW8TIlMoPBvjmkgBhQqSKNY=
X-Google-Smtp-Source: AGHT+IEeHApHMoptLuAc4Sh8QkrdHNF4nURGJyV/v17P1QinqcSyBeMUyDJ+iZaOu8uDHKmstlunWglE8DOr4O4H1IQ=
X-Received: by 2002:a17:907:1888:b0:ab7:851d:4718 with SMTP id
 a640c23a62f3a-abb70d77069mr1256620466b.36.1739842965028; Mon, 17 Feb 2025
 17:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
In-Reply-To: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 18 Feb 2025 11:42:33 +1000
X-Gm-Features: AWEUYZkI8CAF9HGjNRmIGmfPzQ6uc3IvLD4mpYKZjq3NUT2hjYZo_v2S68AaTYQ
Message-ID: <CAPM=9typO2VQYDmn8LE+aEfsymqUjQZLrY60mJ30_oujyDD9ig@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice implementation
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Ben Skeggs <bskeggs@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 00:04, Alexandre Courbot <acourbot@nvidia.com> wrote:
>
> Hi everyone,
>
> This short RFC is based on top of Danilo's initial driver stub series
> [1] and has for goal to initiate discussions and hopefully some design
> decisions using the simplest subdevice of the GPU (the timer) as an
> example, before implementing more devices allowing the GPU
> initialization sequence to progress (Falcon being the logical next step
> so we can get the GSP rolling).
>
> It is kept simple and short for that purpose, and to avoid bumping into
> a wall with much more device code because my assumptions were incorrect.
>
> This is my first time trying to write Rust kernel code, and some of my
> questions below are probably due to me not understanding yet how to use
> the core kernel interfaces. So before going further I thought it would
> make sense to raise the most obvious questions that came to my mind
> while writing this draft:
>
> - Where and how to store subdevices. The timer device is currently a
>   direct member of the GPU structure. It might work for GSP devices
>   which are IIUC supposed to have at least a few fixed devices required
>   to bring the GSP up ; but as a general rule this probably won't scale
>   as not all subdevices are present on all GPU variants, or in the same
>   numbers. So we will probably need to find an equivalent to the
>   `subdev` linked list in Nouveau.

I deliberately avoided doing this.

My reasoning is this isn't like nouveau, where we control a bunch of
devices, we have one mission, bring up GSP, if that entails a bunch of
fixed function blocks being setup in a particular order then let's
just deal with that.

If things become optional later we can move to Option<> or just have a
completely new path. But in those cases I'd make the Option
<TuringGSPBootDevices> rather than Option<Sec2>, Option<NVDEC>, etc,
but I think we need to look at the boot requirements on other GSP
devices to know.

I just don't see any case where we need to iterate over the subdevices
in any form of list that makes sense and doesn't lead to the nouveau
design which is a pain in the ass to tease out any sense of ordering
or hierarchy.

Just be explicit, boot the devices you need in the order you need to
get GSP up and running.

>
> - BAR sharing between subdevices. Right now each subdevice gets access
>   to the full BAR range. I am wondering whether we could not split it
>   into the relevant slices for each-subdevice, and transfer ownership of
>   each slice to the device that is supposed to use it. That way each
>   register would have a single owner, which is arguably safer - but
>   maybe not as flexible as we will need down the road?

This could be useful, again the mission is mostly not to be hitting
registers since GSP will deal with it, the only case I know that it
won't work is, the GSP CPU sequencer code gets a script from the
device, the script tells you to directly hit registers, with no real
bounds checking, so I don't know if this is practical.

>
> - On a related note, since the BAR is behind a Devres its availability
>   must first be secured before any hardware access using try_access().
>   Doing this on a per-register or per-operation basis looks overkill, so
>   all methods that access the BAR take a reference to it, allowing to
>   call try_access() from the highest-level caller and thus reducing the
>   number of times this needs to be performed. Doing so comes at the cost
>   of an extra argument to most subdevice methods ; but also with the
>   benefit that we don't need to put the BAR behind another Arc and share
>   it across all subdevices. I don't know which design is better here,
>   and input would be very welcome.

We can't pass down the bar, because it takes a devres lock and it
interferes with lockdep ordering, even hanging onto devres too long
caused me lockdep issues.

We should only be doing try access on registers that are runtime
sized, is this a lot of them? Do we expect to be hitting a lot of
registers in an actual fast path?

> - We will probably need sometime like a `Subdevice` trait or something
>   down the road, but I'll wait until we have more than one subdevice to
>   think about it.

Again I'm kinda opposed to this idea, I don't think it buys anything,
with GSP we just want to boot, after that we never touch most of the
subdevices ever again.

Dave.

>
> The first 2 patches are small additions to the core Rust modules, that
> the following patches make use of and which might be useful for other
> drivers as well. The last patch is the naive implementation of the timer
> device. I don't expect it to stay this way at all, so please point out
> all the deficiencies in this very early code! :)
>
> [1] https://lore.kernel.org/nouveau/20250209173048.17398-1-dakr@kernel.org/
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Alexandre Courbot (3):
>       rust: add useful ops for u64
>       rust: make ETIMEDOUT error available
>       gpu: nova-core: add basic timer device
>
>  drivers/gpu/nova-core/driver.rs    |  4 +-
>  drivers/gpu/nova-core/gpu.rs       | 35 ++++++++++++++-
>  drivers/gpu/nova-core/nova_core.rs |  1 +
>  drivers/gpu/nova-core/regs.rs      | 43 ++++++++++++++++++
>  drivers/gpu/nova-core/timer.rs     | 91 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/error.rs               |  1 +
>  rust/kernel/lib.rs                 |  1 +
>  rust/kernel/num.rs                 | 32 ++++++++++++++
>  8 files changed, 206 insertions(+), 2 deletions(-)
> ---
> base-commit: 6484e46f33eac8dd42aa36fa56b51d8daa5ae1c1
> change-id: 20250216-nova_timer-c69430184f54
>
> Best regards,
> --
> Alexandre Courbot <acourbot@nvidia.com>
>

