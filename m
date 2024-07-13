Return-Path: <linux-kernel+bounces-251271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7219302DF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D28E2844BD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334ACFC0B;
	Sat, 13 Jul 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COFWUYvi"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609DD2F5;
	Sat, 13 Jul 2024 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831731; cv=none; b=K8MtGOSAX2RCG7m8qckudoQ2+3+kHvUjkLwiZ1yqV2FiTStHn4Vs4RlcSGTkVgRZSnrNhaJT1wLvXoe6I3XOe2LWz+pI4Uf3OUFkL9S2v7ThT6PCt6iVr5tKirqKDIVoIbhlOOM0fALiqS5UUgnv9fIZHusKLD9dpIKcnU+EG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831731; c=relaxed/simple;
	bh=6HsKtFDDgviwQH1b4AdwR89R/oIpdTxW9lu5rBhyzP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eM7Mxe94Acv9/yUqYrg2ZsygxiH8EYzG3/bJYXwbM2rZ27arJH4TJ5xp1TbxOnNixY+O1s8d/JAGOJeGFKDdZI4o9TdVpwnRCO58Nx8j0aHe8+Dv9G7/p7PjeAduO3aHpAaxRdMNVG/qWI/fmMZLFPvsiTWdLjrExtu+fGEZXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COFWUYvi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-59a47d5c22aso1296203a12.1;
        Fri, 12 Jul 2024 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720831728; x=1721436528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HsKtFDDgviwQH1b4AdwR89R/oIpdTxW9lu5rBhyzP8=;
        b=COFWUYvixkhRX0/u9grV8jo3EjbiesoRyVUOIpGUR6yyZ6QgYFzEQOxNDL6c4lR5HO
         h/F02hhJjbnM6NS4L8Er0mYx5jaaEUgCFVHd6s0Fk4Kk2U6hYz+LMBYVPA7EYVFgHMks
         t9qwS8p0Ure20gaDSUoGSxG9rL/6fRv2MK1H9ygDdUAnvanjeLisky+Ltjxmgy7bUWhP
         DKlkrM9b9f26FvcLcKsxyNe9MqEEWxisGV1HrOyA2GlrGxEFAKc12o8iT5WjJFFHRPDF
         ijjKPH82nPHK/PTh+yRb+kPbqSZLT00/vvz1pFRAAhGyhv/KTCT/WHgTL0xxjKPFx1xT
         GZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720831728; x=1721436528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HsKtFDDgviwQH1b4AdwR89R/oIpdTxW9lu5rBhyzP8=;
        b=DgbB2nuSexdRNCA2F8ApeOVkxVgu5uKrc361EYxXLecxnz3/Y262Gxi2cCosvUEwuj
         qcUnkVFBPVaq1D/Q5AFTzYN2kV1hYdi/mvXV1aAlnvrtGo4VkAyNdEC7+aHfwHHYlqE3
         o14bOL2DsjNounFFf/3zfbW/8cu/TnGnbK2o7zFUrBu57QLp8TwDGioCKzl8NOGdz3kf
         d8Woe0NRnxh03dU1sTzLBWo9L6mIBZ6QVzPx/LUkT6j8/11WXQakg1cW9HCin9n9WIG1
         3z+qBvbTBZV24Bo326/UcIerNo9WgWFPuGtsGqnENhGPc5vaI85vd7rd2SayRDs73UiO
         tqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVctJj1+1zWTaHSF1NeG1apxh+eR/MtBIUHzd9IEmOd5uKb1ApAu4BZB0j0CLD06wAoGzR6dhZbrO/ew2XyprTDx74JiiLVN1eMJO2pXMmmFxlts4DQz2t3bw9tqG9Z1+Zc/faT8Eo5WmEvQDE=
X-Gm-Message-State: AOJu0YyqvUJLGDvScSLS5v0wy9VEoGAfTJJTYyZB7iYRBofqQJD/Kpy/
	qN4GHZu8h9N4yoW19eLaFHSpGkEmEPU3cF5eWrQmRid+2GESc3kfzNO1Cxdod9bGKCI2Olon2JS
	gFHfsSRNJuQxoEJN3jVCNr0YzsXQ=
X-Google-Smtp-Source: AGHT+IFeeJ3/yWZLz9nMde/4bWSuZg18FBSHV/qNjaFCrj/uBC8/sAe66xVQO4ioF4q/Ni373euOM4ug9j90dYFf/so=
X-Received: by 2002:a17:906:195a:b0:a77:e48d:bc9 with SMTP id
 a640c23a62f3a-a780b68a472mr741456766b.16.1720831727888; Fri, 12 Jul 2024
 17:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com> <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <ZpFDeajsuVONbSYJ@cassiopeiae> <0A0C1EFC-29A1-4D73-8B02-CC1C693D6A7A@collabora.com>
 <ZpFMmAEdqo1dhj0s@cassiopeiae>
In-Reply-To: <ZpFMmAEdqo1dhj0s@cassiopeiae>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 13 Jul 2024 10:48:36 +1000
Message-ID: <CAPM=9twNU3Wm02zCqzipSt4mDU3UUF5AyVycpBkPTGqv7fwPAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
To: Danilo Krummrich <dakr@redhat.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Steven Price <steven.price@arm.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org, lyude@redhat.com, robh@kernel.org, 
	lina@asahilina.net, mcanal@igalia.com, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jul 2024 at 01:32, Danilo Krummrich <dakr@redhat.com> wrote:
>
> On Fri, Jul 12, 2024 at 12:13:15PM -0300, Daniel Almeida wrote:
> >
> >
> > > On 12 Jul 2024, at 11:53, Danilo Krummrich <dakr@redhat.com> wrote:
> > >
> > > You could also just define those structures in a C header directly an=
d use it
> > > from Rust, can't you?
> > >
> >
> >
> > Sure, I am open to any approach here. Although this looks a bit reverse=
d to me.
> >
> > i.e.: why should I declare these structs in a separate language and fil=
e, and then use them in Rust through bindgen? Sounds clunky.
>
> The kernel exposes the uAPI as C header files. You just choose to do the
> implementation in the kernel in Rust.
>
> Hence, I'd argue that the uAPI header is the actual source. So, we should
> generate stuff from those headers and not the other way around I think.
>
> >
> > Right now, they are declared right next to where they are used in the c=
ode, i.e.: in the same Rust file. And so long as they=E2=80=99re #[repr(C)]=
 we know that an equivalent C version can generated by cbindgen.
> >
>
> I'm not sure whether it's a good idea to generate uAPI header files in ge=
neral.
>
> How do we ensure that the generated header file are useful for userspace =
in
> terms of readability and documentation?
>
> How do we (easily) verify that changes in the Rust code don't break the u=
API by
> due to leading to changes in the generated header files?
>
> Do we have guarantees that future releases of cbindgen can't break anythi=
ng?

I think I'm on the uapi should remain in C for now, we define uapi
types with the kernel types and we have downstream tools to scan and
parse them to deal with alignments and padding (I know FEX relies on
it), so I think we should be bindgen from uapi headers into rust for
now. There might be a future where this changes, but that isn't now
and I definitely don't want to mix C and rust uapi in one driver.

Dave.

