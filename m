Return-Path: <linux-kernel+bounces-404543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C309C44ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30261F22214
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D11AA7A9;
	Mon, 11 Nov 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nv21CuEl"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE641A76CC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349560; cv=none; b=rrAyqDcxQb1HYPW/CpK/X+GiLCgu+KdAoNrHQZ9fX+Nn4GnCfBfzLdXyTJSR4Lp0bjAT6fnFppxug1lH1RuJAvCuN7HgcrRKC57x37XnyulYrPU+EgxC27rubX2W1Y6166OtquYOUHOqwqBytW6BPnhf7lqCk4p40fBl4wskhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349560; c=relaxed/simple;
	bh=fnzDxWMp9CMOS1eazCIx8lhlEPEwSHG3WR9E+hiAZns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ik4G6bKKJIRBCKtE1nwtb0B9i6r4GuB+gyROFZyKBwlyn+dub8NXIXQ8GvVlNnUrr28R/L+xUvfG0AMECffSzG0nCOWkY5lEI3iLCDN4lHCMgiEtMWe/BRJxtIzxJxQqD2gwzuAoA0W9rTmWmjmt6mHlwdQNmgkE4r73stRXCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nv21CuEl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-28893cc3acdso645168fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731349558; x=1731954358; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIugZACBY35ARrAxV64FdxGEKNH0eawpT0ZeCeQDLYA=;
        b=Nv21CuElfOsCfcbxV2qfPyvQhG6rnYrF8Gr32kpmIZOHox3EPyqbo3+zSJygxRSk3a
         LLySTTMYKIjtDjaJjtOkgO0PRFfYWirpWgOmzAgPnt/GXRGGwgZpBEb4fgZxd/codP5t
         V0AZ4P8LhcM71OGGPIH80l/wVFI6r4U8FAe+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349558; x=1731954358;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIugZACBY35ARrAxV64FdxGEKNH0eawpT0ZeCeQDLYA=;
        b=Gi2su92i0qReiPqtIc4dYBhME2kF5zYX2uVDD8hiZDLM6hziFkQXS//R9WTG+uKpCa
         6sBIZHJkwZTwFSvOV7Ulu4RQWAQgn702ftVC+XSeW59fz1Z5D7lRWmWFZ8HlaSXCICYM
         5OjvYV1zfWTdjV4VzHT1mKpvPh5EP1nHkFWeQziKn4Ww0sKRq/9Vigg2Y6pSqpsaVk0P
         gsY7YvvuJgOmIN5bSrfNtqmlgBYxPgu8BAfU9ReFkfLu8zsZhu88aTTaGNpOESfMbdin
         +kU3y/QqFeyw+TPujRc7VHa8UcLa5WO4rr7KffJjZ28iOZeiXXX4eApkgjbnRxzUCazn
         D+dw==
X-Forwarded-Encrypted: i=1; AJvYcCViF+uW8BCJYw4rq1E0FvNcPSDN2D25oce52VoM56m8OubpdLOz53z4c+xBGm2Vwen92qHHou+U/V3uugM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0PmwMep0pCp/AUhBbX40k4oREw33dk/KJLWEAQEcM/0oZ3gU
	OAKh49pTSo4u1+lRn+YmYUsaW8oxqkxIvUbKGyhuhfyDGoYKSUbF9bDp+IMpJTQjejkuNxc1/C7
	pAltklunTntT73DQbNGhfubWIrclUg+D+mH+y
X-Google-Smtp-Source: AGHT+IGINJOlYvlfLyt7mLWJ3n/o76rolNATTWKhMQnkpmtm4qs2hNQjgN5HblvY6bRR60Kk05VRIZUHSOWOeWNhuXM=
X-Received: by 2002:a05:6870:2a44:b0:287:2cbc:6c9 with SMTP id
 586e51a60fabf-29560128cc1mr2879916fac.8.1731349557747; Mon, 11 Nov 2024
 10:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <2durheir3u7uv7y5d3zsuxgkxbfhyj6gbef6xiktp2nybf7os2@zppt55ut7f57>
 <CABi2SkX3YjU-soYqRahjV07cAw1bB0ukUNiUFkc-APNN3DvJ6A@mail.gmail.com> <whsms76xkf5yzec5mlt4gq2jq6mkb2vj2uunl4k4ka6i3r6s2a@piv6weghxco2>
In-Reply-To: <whsms76xkf5yzec5mlt4gq2jq6mkb2vj2uunl4k4ka6i3r6s2a@piv6weghxco2>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 11 Nov 2024 10:25:45 -0800
Message-ID: <CABi2SkVbETo3ZYS+M9u8EO-5+r+tsPnXE+0CKz8o3eck_HVtDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam

On Wed, Oct 16, 2024 at 7:03=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [241016 20:59]:
> > On Wed, Oct 16, 2024 at 4:18=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * jeffxu@chromium.org <jeffxu@chromium.org> [241014 17:50]:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > > >
> > > > Those mappings are readonly or executable only, sealing can protect
> > > > them from ever changing during the life time of the process. For
> > > > complete descriptions of memory sealing, please see mseal.rst [1].
> > > >
I will mention unmap  in the above sentence.

> > > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > > generated by the kernel during program initialization. These mappin=
gs
> > > > are designated as non-writable, and sealing them will prevent them
> > > > from ever becoming writeable.
> > >                               ^ or ever removed.
> > >
This section is about the mappings (vdso, etc)  created during program
initialization vs later time as uprobe, I will revise  to make it
clearer to the reader.

Thanks
-Jeff

