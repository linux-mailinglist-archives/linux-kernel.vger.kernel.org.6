Return-Path: <linux-kernel+bounces-303751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899139614B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46034286D56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A211C27;
	Tue, 27 Aug 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMzDnPQt"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578B1CE6E7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777690; cv=none; b=cM3vzze0kYFw0cFAlo/QClm6DMGgWt8JJrHefyNCHVBDK1ZSdXF9QFcc6Sq3JpznkdV8C0Y6mc5KietmJiQoXksz0S2d9+utjaESwe551mGfFe1XcuRhYCn3JcBh5K46Fprs196Fw7IC2nYSSMT23HEKqj5V+1q/h/luIiU8S4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777690; c=relaxed/simple;
	bh=Kh5uwhThs9nwoOn3AOzyE5Y4+zLLyobYmzrOmotESss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDZvVmBxCunA62WkELEmuVFwkAr8UN7sbLuGvUfnPtRPK1dacGqU3RUQKazUQI3OMfI8RUt/ZC+FDsN77jRrnatenSYdX42V5HZVDAx737Q4dVUwwR/lIGAKfx6yq1WwovUvcnIj8qrMSX9CAJU6mKalE1YGSDzc45OfzI83phA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMzDnPQt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f50ca18a13so32344961fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724777685; x=1725382485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eb2QWgFjgHyzTInDHeCmDGITmXg3uxSmkR/8gVOEr4=;
        b=WMzDnPQtjS/tQRuu8t3n3zIGRjooOuleopJj+eztOv6tgT5k5Qqsh6R2kpK6ecUyxF
         XwMzF+DJaxD2XesVWM4bBjFnL4Y6J8G/EBJ1UhchuhHAN/P5GbE5NYV5pgxg0uUHi01k
         51Wzdw6NfeEDEtyrBqQOOOpIef1aDoED2rHaT/R+0XaW2HUW1NA7KBg9PvQHmxIdkBzu
         L2S2R94asC7Dn0n7qr+2dMga8rogZTYj3U2RbNFnoV/WhHkmUWKnqrKQovRud6dn/Rni
         yLeievhsYqsS443fc4qFmTaj0kk9ziFJp2OOYQCkS0/LC9ozi0srFcuE22XUZ1eK7Ldy
         Z3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777685; x=1725382485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eb2QWgFjgHyzTInDHeCmDGITmXg3uxSmkR/8gVOEr4=;
        b=wcQnUiAYmE4PpfwvFz1aVoNjgtRZV7vG1X0zkiNJ/w0Seyymgj7o6oPUgrEYNe00/3
         e5yhXb4s2qmqWVR7PC5+CqaFAafXVpuDFING4ZPyAltaQduc9XiSGRXn1S0Lt/fDHjcn
         cA8ziOAJaBMw5XY2TLjVwS1vSqunCfXfa3P6FT8BLjyCyzZUvhDxbIJ0xm0ahsX6zFqK
         460lhUdAA91b6ci+YBn0V0XcsmRjw2P1j7DoWp8Ej5ms/a+Na6crIXjGZ91dPreiLltu
         YO2gp7lqLtq8Z9z7xj7wIhlY79KrE0mBO6PYTYCAb75MtjngippEA0LkVYys5IfD24hG
         yMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/kTJlR/O0qJN7Fubs4QEes9y21Rv71BVLqGlG9LDQvdESQay83cy4zucLShQ+d09TjKmW5sezDC0d+9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMsf8LZfx8jmjkacHaCjDzH01cQWXGJQV7gDjoJ7LvQsfqqsG
	PiRe3QaMOtNlCi2It4x7XOfe/EB+uWf1YDPUyzeJHnVJvcCabF6yOPxX4G6ifHRsU64/AXjdpD2
	D/4t3C/n9prtYIM9zOHK5Ntx2v00=
X-Google-Smtp-Source: AGHT+IEWmSkDqqcpudL+qeabHRRdGN73leKg2ewiSqympFDcYlaA6AXEBVN2n5bPd3N7145iXT4Kma+Sh0sbZxXVllg=
X-Received: by 2002:a05:651c:545:b0:2f3:e2f0:fa8 with SMTP id
 38308e7fff4ca-2f4f5728ec9mr94339371fa.9.1724777684568; Tue, 27 Aug 2024
 09:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826171546.6777-1-robdclark@gmail.com> <20240826171546.6777-3-robdclark@gmail.com>
 <20240827120205.GA4647@willie-the-truck>
In-Reply-To: <20240827120205.GA4647@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 27 Aug 2024 09:54:29 -0700
Message-ID: <CAF6AEGtFg2D=4RVQC=YT9OsqdNwwsuJCyi=hu8Box0A6psecQA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:02=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Aug 26, 2024 at 10:15:39AM -0700, Rob Clark wrote:
> > @@ -776,7 +775,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgta=
ble *data,
> >               return 0;
> >       }
> >
> > -     if (WARN_ON(!iopte_table(pte, lvl)))
> > +     if (WARN_ON(!iopte_table(pte, lvl) && !selftest_running))
> >               return -EINVAL;
> >
> >       ptep =3D iopte_deref(pte, data);
>
> I still don't grok this hunk. If the selftest is running, we want to
> return -EINVAL here rather than dereference something that isn't a
> table, right?
>
> Suppressing the warning is one thing, but this seems to do more than
> that.

oh, that should be

   if (!iopte_table(...)) {
      WARN_ON(!selftest_running);
      return -EINVAL;
   }

I did boot with selftests enabled, and it didn't _seem_ to complain
about anything, so I overlooked that

BR,
-R

>
> Will

