Return-Path: <linux-kernel+bounces-179134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A280C8C5C35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA1282796
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B5181B82;
	Tue, 14 May 2024 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0a1zuzJn"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EB18131A
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717976; cv=none; b=jmvSJ5/z6vCqJBJOwR7fw7Ipoduwh3LjPZ+yB5yjCtSNOSyrC3mP0Vmtg7aPhJ723UqhDLCgclblCtrhuSrvCiDewvQ33bsUdArLwwKtP6a2Px6zq9rWrTOO6PJinFxMFwII0nSAt5dLGMna5HOuwP3a7qeEBtjcE1k2TeaJ8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717976; c=relaxed/simple;
	bh=VaHu7rKqUD82QxgHYz6hkdvHYjYa2IRHOTNhh/K5VCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3qYxm2y2ABnTM7Sj64Y4GmO5UpW1jfk7Sc4IN3Jy7iaBLnoStkYUbvaPaGyVDRpWWJJpL3wX+bkO0zKwe5Q2zXyFI0Tx8Nbw3XZH2iAmDZMb6MEARCHfuP2fg0v0laqwPEPLG5LYZeKs08tElPnTvCGv5fr5+VT01tFILAhwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0a1zuzJn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-622e32414ffso30440307b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715717973; x=1716322773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hb7xfSX/VQFjXuNhYy1AT8FiF40Meq6UrJ0Q9OaWSI=;
        b=0a1zuzJnVTED5zaBjn+vneejEbKjifynYTHZTlnVvJKgSHH0FmJ1Bkn3TIS+l5/1Fr
         7NbcjAvEqVEWRplugA6jaRTfJGfPU91IqxQ5ua1BqzAlAnXHIcZeQbwh36eH+HrY/GST
         kZoW1w7PDM6ndbkwbCdg+S4B9E6WtIyn53TkzQSHwaMIMYnXC80MnnzqZhcWHH9emoyo
         tE/Y2rNZCaH7VE/zEmxSMNyxI7x+qvLgApVmmo/zHocyfjYSqqNyW6Xnzfkdzi34Kf5+
         tILMfTM8IjYU5bggzvkRUy7e6LTeKynROC0y2vUCYxU7CkBeXgiJsP2fo5ZBHNle3+Vf
         lA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715717973; x=1716322773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hb7xfSX/VQFjXuNhYy1AT8FiF40Meq6UrJ0Q9OaWSI=;
        b=MhUWbQE3HG0lPhTK+89Xz17c/ArHYdeeqG1LcTxm6J+JKkfzcLEiAgAvVUBhou5JPS
         g99ocg7fA1B0/dwFQI5qnqxfMHtXWeyyrpBaWXFCMFQRj+duWWLC7GEdoQanSAxs9qVr
         AGn5Y1FpIP+GAMW3faudS6jX6HE8oB4GkyJSy3+Kv+LzJF++cg3hEs+nEDvgRg1biGGn
         aiNZI3ININAI02qI7M39wmcEcXfh6iTvRr9EGl3kwORsThsYAjMx6O5AgWxPFH85oxyU
         RnPoDwRxpF4nHC+bGuXZA2dA1MzAw0N1kU9i5JIvn29bNGwJxLxM4skFf6oP9nUeXLNB
         rCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+jMLWPihKRxJCU9uUiGAIasR9nC6blEe9S8Tq2AQSE8ebCOieOENMbf3yWlgwuZk2QJv1ue/d0KN1v2f8FJQyJYM9xJjCOuBAXTbO
X-Gm-Message-State: AOJu0YwRXVYMlXaJNmV4XNxoQW5t1zZypd8vFn+dmHLET5KCqFTEbNLF
	J9XGXIFBE7ptqkd/PZfUd/p6HVLjRJsVSQxbQoPip9QYmHMgB19miKRw7Od0+onhhe7Uma6Ou8O
	ntAMfhi3cAd8MReXaugpZ3BZ70zbY3YQUIRVQIYjFz04Cs0zxcw==
X-Google-Smtp-Source: AGHT+IF0OFILt+I7s+gtnueoup30JC7tJkxqSmt1mTfiiTyFdrB2xvE1WcfGDmSBB02xHb0OOmS8gf0eZcoIH22ncJ8=
X-Received: by 2002:a05:690c:386:b0:614:74ba:f91c with SMTP id
 00721157ae682-622aff93dfamr216111377b3.19.1715717972903; Tue, 14 May 2024
 13:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514163128.3662251-1-surenb@google.com> <202405140957.92089A615@keescook>
In-Reply-To: <202405140957.92089A615@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 14 May 2024 13:19:19 -0700
Message-ID: <CAJuCfpGjRtL4nrOp2fLVM2=Yfg2WH4DXjkTK-y_1q4uwAxFDHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] lib: add version into /proc/allocinfo output
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	pasha.tatashin@soleen.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 9:58=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, May 14, 2024 at 09:31:28AM -0700, Suren Baghdasaryan wrote:
> > Add version string and a header at the beginning of /proc/allocinfo to
> > allow later format changes. Example output:
> >
> > > head /proc/allocinfo
> > allocinfo - version: 1.0
> > #     <size>  <calls> <tag info>
> >            0        0 init/main.c:1314 func:do_initcalls
> >            0        0 init/do_mounts.c:353 func:mount_nodev_root
> >            0        0 init/do_mounts.c:187 func:mount_root_generic
> >            0        0 init/do_mounts.c:158 func:do_mount_root
> >            0        0 init/initramfs.c:493 func:unpack_to_rootfs
> >            0        0 init/initramfs.c:492 func:unpack_to_rootfs
> >            0        0 init/initramfs.c:491 func:unpack_to_rootfs
> >          512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
> >          128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Ah yeah, good idea. (Do we have versioning like this anywhere else in
> our /proc files? It seems a nice thing to add...)

Yes, /proc/slabinfo has a similar header that includes a version number.

>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

>
> --
> Kees Cook

