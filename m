Return-Path: <linux-kernel+bounces-338220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37481985500
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9495284141
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178FB158D87;
	Wed, 25 Sep 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO5xypmb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7315855E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251453; cv=none; b=G9PUjFtJ0V7E56y+IUpWvYJwrqI0y08AokhJ2OdRfJGa/RvtU2O7gmVmFXr5l0urYiYqokF6q6tyCd6+GNAHwie15Bbbmdb61P9KefsTtnMRuAXolvFZg6W5e9gGNAev7bMaVS0VFAFrmLDJ6FiGoT8R4zmr2TSKuouUFmAS4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251453; c=relaxed/simple;
	bh=VB9g9c1zujyx7vmfcbvXFPnE0OOYMVj4A7JsIXSIbf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl2hz5aEUqbivmxAQ1D1mKCaDl0XB2uTyncLuGMJ2wLtqv/RXE2b5qZzsF5enZbeSiDEvpcKCFmQ8Fjl/lJ/JcQ2UPxYvFEvT441h5ivlLfVLEEXWieRgrjh8e3q/eAHWvGWfRxO4JHByc8Podp0VEoH6SM8UX/4TbrgBA5PX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FO5xypmb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso63728625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727251448; x=1727856248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj+TfSlawgCc9Osig+lijT0zyXuRBIYW5Lo6S1CxHh0=;
        b=FO5xypmbWGQEGJPXkw+4XZs3V12jfyAEqqyiowyux+nAXvtBBYISbRzP0CDMAcE0gI
         H9Q7CGEVi78biivy7z0JByotLaky0QNzSARglaDeSA/EF3zgCh0hiJAK+ae3Rw1rRtY7
         rQ/Opb7oO0xNTrru2/i2xLRk8eTwsWnR+kvhjFA1eKmBanJmLGdOnmL2B95Q0OhkCwik
         MGUWreHQKmxtMoHNmXIXHjwMrS0PV2agYDN5G8U1NUEswdCcWNc44+CqsqHCNUhCcNQn
         Yo/Ancr6Hg70JaGMctyMQPOPFe2G3RzUPUlEjCNivmPfmUeVqnrxYLXdfyP5swPtxPT0
         RFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251448; x=1727856248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj+TfSlawgCc9Osig+lijT0zyXuRBIYW5Lo6S1CxHh0=;
        b=qIqtX59yiAi/DtRxRL72TSAYG7dyYW0Ty2407PXaL0T16ljvjADpaItF0nM0BNn1RL
         si9zS1GS3ZaDwOjo2bWzsSazUAm+PHq9t0QIg/BrqMjRijYRWzMflEDu2gA7m0/NCPHx
         r04X4IgbCmfqS0qLE5EMqC/HMHSKzeINo9GEMNwMO7dczs38+AihgG0Rs5PXxdJN2xEQ
         Lu/kfA2DcKYpmfGkAbyH3XmSzLSlGXMrfb/3Q/7H3ufgspaA3rycTo/5IUBtpSNFTI0+
         Hix1hT+8cCAzb+XanEO/dDBT5ekJPt2dfT69OmpGhUcxw4BkxNou3CCqJWyOVCbHXfXB
         5vpA==
X-Forwarded-Encrypted: i=1; AJvYcCWXGiYayHx1/dfL21+CC0NTvljpY5StKyW3voGNPEaC/+kDZxNuar20jnYs1ECLnoqyixhvT2PLD8VDKMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fwouGGZG9ZqGMRx1n4la7MFXql3jzvTtL/47BYEHk+XHnpB1
	qU1Y4z17Bc2d49aets2W8mW20KVdJOrCxUvxHAV0eEoYAKtic21Q6AMxIOi7WJ4fEWd3srTGf3U
	JH6USirycS2SPYYtGGrpFhtF0iS7g36PfrHSd
X-Google-Smtp-Source: AGHT+IGJUjYAV1NoP++0nFD187USsTcKM2oiOqdnaOcuM9TQvV7djhXHNMm870RitHPs8SUVyWCqox8ufG/44K/XXmo=
X-Received: by 2002:adf:fc08:0:b0:374:c847:86d with SMTP id
 ffacd0b85a97d-37cc2467801mr1164893f8f.16.1727251448214; Wed, 25 Sep 2024
 01:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-4-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-4-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 10:03:55 +0200
Message-ID: <CAH5fLggAoKssv+nmg54ibsdTtPF_kxU=WGHK6zQDRxaSd8dpdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] binder: fix freeze UAF in binder_release_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> When a binder reference is cleaned up, any freeze work queued in the
> associated process should also be removed. Otherwise, the reference is
> freed while its ref->freeze.work is still queued in proc->work leading
> to a use-after-free issue as shown by the following KASAN report:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in binder_release_work+0x398/0x3d0
>   Read of size 8 at addr ffff31600ee91488 by task kworker/5:1/211
>
>   CPU: 5 UID: 0 PID: 211 Comm: kworker/5:1 Not tainted 6.11.0-rc7-00382-g=
fc6c92196396 #22
>   Hardware name: linux,dummy-virt (DT)
>   Workqueue: events binder_deferred_func
>   Call trace:
>    binder_release_work+0x398/0x3d0
>    binder_deferred_func+0xb60/0x109c
>    process_one_work+0x51c/0xbd4
>    worker_thread+0x608/0xee8
>
>   Allocated by task 703:
>    __kmalloc_cache_noprof+0x130/0x280
>    binder_thread_write+0xdb4/0x42a0
>    binder_ioctl+0x18f0/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>    invoke_syscall+0x6c/0x254
>
>   Freed by task 211:
>    kfree+0xc4/0x230
>    binder_deferred_func+0xae8/0x109c
>    process_one_work+0x51c/0xbd4
>    worker_thread+0x608/0xee8
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This commit fixes the issue by ensuring any queued freeze work is removed
> when cleaning up a binder reference.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

