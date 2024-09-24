Return-Path: <linux-kernel+bounces-337440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15A984A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCADF1F23DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593B1AB6F4;
	Tue, 24 Sep 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNtK6BQV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261812F375
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198023; cv=none; b=tAIgABA/GLnsfzQHden8RgnL94XZ/OwEUTbwxjBpnqJbgsR8sp0Ln+kjhJfOUHb/TaFFIA84Z0TnmYPqVwjQLNTMFd1SkyzXlpEXmnbKZNEBwA+Ni5DRhuTFtVBKwfhYhaBXdL0gQTP8K3ePiXpUqDJSa41UdVjomnjYDxi19GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198023; c=relaxed/simple;
	bh=u622AMHZgaxSFFWoIXFMiij+zJsLgzq+uZoEeEOVu08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q75k3vsciXkEUiCOm21i9he5iebVTS3aqsJyH/GM2Xec0Rox2On8iD3sxCdzud0Qg/Zrnv6cBt7InyRl5IGKyrCdwXRaK2Evszom3GWghqpBKJfeS6zTQC9q0h0BRDlRj/Qu1Bg2OqjDt5f8oxCHPRK1edgQpbrQNSy1/BY3n3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNtK6BQV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71790698b22so1267674b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727198022; x=1727802822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj/V12T6EfI+QI2wyKU5Kn73QQVj+zol6mqHjdblGto=;
        b=YNtK6BQVfanh/uRm7EArNWnKVn/mFcA6/1O8i0jvlAqdMef1dq4NfdW+EoUaQmJFYY
         9az1hPCXYKSDia8FAYrS6Fcv7aTX2L2FuhgORMazAHZ2Uzw6baGLm1mbKrsorjgQYwLx
         Q9U21LjQ7lFrjjrfRQ0sjURsCgrYWjPx6ofOKaFzu3OSBypZEmOUVFccJITSufBhNbqU
         yIatzFeA2Y60atR/GsQpHfIdM4Qyj+8uEL/nq9k1QPU6i902AgU+ariRNp8eI2nSxtUO
         BdfkI8WjSDdZIQeY6pU0pT3WTIKO6jBwZojkqasrpcWt45+ZmZMK/skm/DNG+6Hwt+Rb
         FNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727198022; x=1727802822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj/V12T6EfI+QI2wyKU5Kn73QQVj+zol6mqHjdblGto=;
        b=RNr7u85cXk8RCWFBDiP/0PstOGdIAxseqkO+e7m3rCtNhHAXsJ5KLeBBWxbKre1FPX
         2MsCg/UckkQwbf9BQg2Nr8wyjIvCR3uESdR4iRqZ7X5f/RC3CbXKzHzPT/MC6vRThVgd
         c7fJhYLkgOD2GteIJv+6T97DKbQupxvtivSda53z5tWSKPhfyYf/O0A1ahiXjpQ4y1UO
         CYJtMa1ripR7IZTW+eeyb5yw3XRlGrXvwxYBa/vCrdHtWeFAvPRUqVCZUWFZt9XvqIEN
         +9KpVPdQn/8hDZ1LDoNsKi51N9DCFs151MGusN4SNIxETRxVqvGupeN5FWaNu4cP3YfY
         2vQg==
X-Forwarded-Encrypted: i=1; AJvYcCWQBU5JqVaQPKZCXdeKnYRv2XJKdZs7oG3EPBcToZG4apGOqSnF5tyNEW0UsaQEG0bDo9DVa7M0H8j2RUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRPrZ01VZWCrmR6w90gIbEmgZg/TalUX07rTICQL/LNU4CvoY
	OUcH45s+9RO6BfSpw2eD5QMGR8EbJ/6p/Il6r4uKndd2mc5DBaABNnfp6Q06+rEb4lKMqTAoSZs
	NdEadmu4B/BHMkjmPOxD6vVsroD0=
X-Google-Smtp-Source: AGHT+IH4fWFHQoJUk3/SiGUatRb9npkgwzfKLl7EBZNw0zDkLeUu/FDrWRYEvcJCfKvnWWpDFqETUvN5KHGUUPeQ/us=
X-Received: by 2002:a05:6a00:1149:b0:70d:140c:7369 with SMTP id
 d2e1a72fcca58-71b0ac5a8c4mr2343b3a.3.1727198021598; Tue, 24 Sep 2024 10:13:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923012446.4965-1-linux@treblig.org>
In-Reply-To: <20240923012446.4965-1-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 13:13:29 -0400
Message-ID: <CADnq5_PxBfpG6C80Wcm50wLzz=4eEKsscuZXiQ=ZsG8=gULhRA@mail.gmail.com>
Subject: Re: [PATCH 0/5] AMDGPU deadcode
To: linux@treblig.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 9:43=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Hi,
>   This is a bunch of deadcode removal in amdgpu;
> some of the functions are ones which were previously
> used but haven't been for a while, others are functions
> that were added a few years ago and haven't ever been used.
>
>   There are some others that I've not removed, which have
> been added in the last few years but not been used,
> I was worried maybe there are patches in someones tree
> about to use them (e.g. amdgpu_lsdma_copy_mem, amdgpu_mes_reg_wait,
> amdgpu_ras_unbind_aca, amdgpu_seq64_alloc, and
> amdgpu_xcp_prepare_resume) - I'd be happy to take those as
> well.

There are patches in flight that make use of at least some of these.
For example, the seq64 functions are used by the user queues patches
which are being reviewed now.  Feel free to send out patches though if
you are inclined.  If someone has plans to use something, they can
bring that up in the patch review.

>
>   One other thing I wasn't sure of; I removed
> amdgpu_device_ip_is_idle
> which has been unused since about 2016, but does that make
> the 'is_idle' methods unused or is there something else that calls
> them?

They've been used on and off in proposed patches over the years.  Some
of the IP specific code may call the IP specific is idle functions
directly rather than using the callbacks.

Alex

>
> (Sent from this kernel booted on my RX550 GPU)
>
> Dave
>
> Dr. David Alan Gilbert (5):
>   drm/amdgpu: Remove unused amdgpu_device_ip_is_idle
>   drm/amdgpu: Remove unused amdgpu_atpx functions
>   drm/amdgpu: Remove unused amdgpu_gmc_vram_cpu_pa
>   drm/amdgpu: Remove unused amdgpu_gfx_bit_to_me_queue
>   drm/amdgpu: Remove unused amdgpu_i2c functions
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 --------
>  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 12 ---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 24 ------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 10 --------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 12 ---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 25 -------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h       |  4 ---
>  9 files changed, 100 deletions(-)
>
> --
> 2.46.1
>

