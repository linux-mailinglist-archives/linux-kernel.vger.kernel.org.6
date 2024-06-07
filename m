Return-Path: <linux-kernel+bounces-206439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0705F9009C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A6A1C22031
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE519A29F;
	Fri,  7 Jun 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2odiTsw"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84119414D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775903; cv=none; b=dqgyvhSDnoBpN4k4ZhP6HkHayTyQb+yHgXnkVWBLdQ4UIn1nd16Jp61t2yVRsCTuuUPBQHP6GhPk9Mj+Zrds3PdkBXeEPWCXVDfW3uG68LlfMAgy7fsb5OApwK6e9wyx80A3dP7Li4Tfp17FtV282/7gnUOHNZ73aIrcKm7Rffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775903; c=relaxed/simple;
	bh=s1JvENtGfwCSbl34GscOC+aW3XbtXE7cv0+2CV0e8uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDm+daHkNUTOVfy9FaZ0+6p+stG4gWVgElrXE4iNIohaMe+/PEW+AU5bwTFNfdSoY+av/WtRGAI2MrX7YCyPzfwE6a4NMAmSjzM5RLbpU3uaFI7lh+yl93XMv2XoIscdBOAkbGanISWULntXivxmo8z3dRw522OaktLxhbj/cvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A2odiTsw; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d200c45db5so1273958b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717775901; x=1718380701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEadrKSLCgbuFYvra79wv6BZ/tbvq8SfRbQUE/5o6is=;
        b=A2odiTsw9WFX43GAf7A9LjVbjJdaFzR84DJqUae0HCzxhGNwD43rmMZmIHfC1zpb3j
         1+yc2z6db0GsA+Po7fstjDRkYnOb/HDQk6RrAF3qSvOlAq1JaOKiSG+EGQBjY/YnxL/c
         nv/i0lB4AfcSBRl95ur9XjHYLbTvrN9/+tcIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775901; x=1718380701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEadrKSLCgbuFYvra79wv6BZ/tbvq8SfRbQUE/5o6is=;
        b=vgEbfRZSBYdFG80FgCMnCPtkh293vGAHj6RCBkRyqkarrsgVxAXgWytIp6noToXuQO
         kFxfszd9wURrFFILDE4eNgafQTZDz5/k2C281xio32E9EobJlmGR9ommgxzaf6BsjZ6g
         y+xcnPep++XYtyyR3zQXoeVkec2H/LjHI9gCvqC7YvWFVFRtCKe/3JBiPLCgNYMVdFF3
         PUK1y3im/zpZZ19w1cNSpnWVpt+uGdzbwKe7/iwuBEYPsMDbwIXipxqekfcwRFxpAUVW
         yH1O5Iwo1ySk7HQD1ZmEpoDzYU4RQ6ownINuIkKH5yxUE75gn5r74rJt6I00dQPykCsz
         2fNw==
X-Forwarded-Encrypted: i=1; AJvYcCXC3w7hWps0TJGGmtE3S6K7tW6qrmJCWpVO9enLr/u2j1hssVmzDHkMte8UNYWkZHw/cxI7b81vNYjopLk60o0A0sVDJpj6CqNvQIG9
X-Gm-Message-State: AOJu0YzPLHMzpTUbncOhObz9tsF31fSW8w17bMP5VeixPGVvA4g6GKp1
	K8H/wAltFK9ZfXr6feYyi0e0/kP1dACQD3XmUr7/KhVs/CxdyiblpzRASCcpKvjEw9t40xfif28
	UBaitsIvki9VJYBP8ZjimqNYmlQPA1v0v9p6lDWYOX4e9xDA=
X-Google-Smtp-Source: AGHT+IH/nK4F4tRexrZp1VOlLuPeWYKcpRRXCgXdkWdzR5d80ML7hH7jCR2Ex7YNQ9Ay6MVBijqvI9/8yMfwBjsXrRM=
X-Received: by 2002:a05:6871:289:b0:254:8bb9:d0c2 with SMTP id
 586e51a60fabf-2548bba70dbmr376857fac.33.1717775900892; Fri, 07 Jun 2024
 08:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com> <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
 <CALmYWFtedtEnfGFp5DYacHYOE7+GB8yoQC-iyw7JAxySmgQ7vw@mail.gmail.com>
 <f880562e-9521-4270-82e2-c6fb14dc853a@app.fastmail.com> <CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=uO9OewMhGfhGCY66Hbw@mail.gmail.com>
 <1e1edbdc-f91f-4106-baa6-b765b78e6abc@app.fastmail.com>
In-Reply-To: <1e1edbdc-f91f-4106-baa6-b765b78e6abc@app.fastmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 7 Jun 2024 08:58:08 -0700
Message-ID: <CABi2SkUMppyL_LRKJV6BfgGu=1GpGCEOdZ5VHCENMUtzHcRTkA@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: David Rheinsberg <david@readahead.eu>
Cc: Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, 
	jorgelo@chromium.org, skhan@linuxfoundation.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Jun 7, 2024 at 1:38=E2=80=AFAM David Rheinsberg <david@readahead.eu=
> wrote:
>
> Hi
>
> On Tue, May 28, 2024, at 7:13 PM, Jeff Xu wrote:
> >> > Another solution is to change memfd to be by-default sealable,
> >> > although that will be an api change, but what side effect  will it b=
e
> >> > ?
> >> > If we are worried about the memfd being sealed by an attacker, the
> >> > malicious code could also overwrite the content since memfd is not
> >> > sealed.
> >>
> >> You cannot change the default-seals retrospectively. There are existin=
g shmem-users that share file-descriptors and *expect* the other party to b=
e able to override data, but do *not* expect the other party to be able to =
apply seals. Note that these models explicitly *want* shared, writable acce=
ss to the buffer (e.g., render-client shares a buffer with the display serv=
er for scanout), so just because you can *write* to a shmem-file does not m=
ean that sharing is unsafe (e.g., using SIGBUS+mmap can safely deal with pa=
ge-faults).
> >>
> > If the other party is controlled by an attacker, the attacker can
> > write garbage to the shm-file/memfd, that is already the end of the
> > game, at that point, sealing is no longer a concern, right?
>
> No. If a graphics client shares a buffer with a graphics server, the clie=
nt is free to write garbage into the buffer. This is not unsafe. The graphi=
cs server will display whatever the client writes into the buffer. This is =
completely safe, without sealing and with a writable buffer.
>
> > If the threat-model is preventing attacker on the other side to write
> > the garbage data, then F_SEAL_WRITE|F_SEAL_SHRINK|F_SEAL_GROW can be
> > applied, in that case, default-sealable seems preferable because of
> > less code change.
>
> Again, the threat-model is *NOT* concerned with writes.
>
> Graphics clients/servers are a good example where *ANY* data is valid and=
 can be processed by the privileged server. Hence, *ANY* writes are allowed=
 and safe. No need for any seals. Those setups existed way before `memfd_cr=
eate` was added (including seals).
>
> However, when windows are resized, graphic buffers need to be resized as =
well. In those setups, the graphics server might call `ftruncate(2)`. If yo=
u suddenly make shmem-files sealable by default, a client can set `F_SEAL_S=
HRINK/GROW` and the privileged graphics server will get an error from `ftru=
ncate(2)`, which it might not be able to handle, as it correctly never expe=
cted this to happen.
>

The graphic buffer  is a good example for shmem-files of
not-sealable-by-default. Thanks for the details.

-Jeff


> Thanks
> David

