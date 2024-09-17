Return-Path: <linux-kernel+bounces-331397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932E97AC59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75211F24230
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD29714D71D;
	Tue, 17 Sep 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzncCB9I"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9400155A3C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559129; cv=none; b=NWfpjhri6nIn+80xkO7mc8F1zthWN6Jtcn3rRpkVsSesSGXsLrY9VLHqzhKd4pOBytqNM6CIODyieFr9g1zTyyHvYtnMuCKXicuQryDVt8Yn43L7xd6zHKGx0zkOegmhLq5TuW+fs76fTQq4k9z/5Bgp+SAAAmnu6mbj97qGYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559129; c=relaxed/simple;
	bh=h+3PzGTABqpaxtOHDAbZ8agKjW9SrxWhNuFXDsKyIns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+xy7evq7smU6JbJuSEi9+KY2NbgSo5/Q7BbHu3T/UnX32/qUGyF8NRws06xGYEpewfcSlcfQ/aBd6MspwAaqOtiPa4QGID7d2qslWrjXj3zhqDuuh0OVn/UD0b5543IODw0atNv0weYLLn0ULbLGaixVIk0ERNryaTXIbogGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HzncCB9I; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-846cdfbb153so1349260241.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726559125; x=1727163925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sea0zO9yqXzOHNC2U7vb09vPtmzyWkSBwbgBJxMPL7U=;
        b=HzncCB9IfHGlMRIzMBnbIs+6Pmo3gxkkxJja9AtFaVoxZ+m334vYqyh7DNHjKYnquC
         ee06YEKrMvkFo9cg+J/CMnkuy1WLmKKXRa6CipP44CuDpsiLuNrG4obFwO3/ZT7uJ+sf
         FNKR/7SLAV0FhF6NnR+R5lOGQ+1r0fAwZ58V+WeMK9uG120/JTAJJJdXOfMZCRn3jXSO
         Rf+LZ/ppsEPW3BRV8KvmHEdn1y/Wuw95kb6MbPVHSJoXRFtjYoAz3ZHjmHQ/msJoQXdx
         /Ig8c4nmsOZyt9FowEShIqL/gQHSQ2GiIj+tszkgEsGXnp95gC04HtwGI7BJRLw0DIE7
         B/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726559125; x=1727163925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sea0zO9yqXzOHNC2U7vb09vPtmzyWkSBwbgBJxMPL7U=;
        b=h+la2/TglCDxtCVP63tchtdVC2Nseb6nHcJImEWaQcLSF1nEfg3L6eSYJyWRkZGxCf
         0yY2gp1gF67C8ArfoN0umIjn8+KsaetboBn3j6fwP/PRbfky4U6hZnWZ/6EA/VF4zuag
         j+mMpZ/KX7Z3jmZnuomlOGhCilaJz5L3FBFolgFKXX2m5e/jajaRlHT49oZQo9gOnoJH
         vsBkDEqe1ZW9twDhQhv83tn7Hx05WOk4jCyN0ip5+2u1cc5lMW6dHw1rQv8+Mg+qW5xZ
         2HguXGrK9XW+Py35HGvJfqBVcPC5bXpb1T0q+2UGtTa8vFrscEcJ2hSyGobVbUUvrF3x
         lRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUunAuiMr0NrHfj6rOmwMnFDIZRjaLt7XkxAIb5mvTmTUR1P3VNO5ySqeTT4H8isgFCwViEKhJicNDQw4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPE4R1SbcTUE0PE8avAV2lu+2ivXdwHA4ufyEnENVFB+Vcvan
	bNgyp56YJclKaRs1l9pqWtXbn7/WhbsfueIWUdD50Gq4Zhnp5KRJQZhsmIbU4DUkZpd2ME/X55h
	gERkeRHABITChk9hdzm9Jm2WxvxGtpWuESRFuaw==
X-Google-Smtp-Source: AGHT+IEX9Fn8uP/lq3FtGxXPDYuASA4m6x9TeKuoaF5tVL8V7HXahk8wjLcJnvuYVKRilqNKDgiamUD2b/2xSH5KiPs=
X-Received: by 2002:a05:6102:290b:b0:48f:db40:99e9 with SMTP id
 ada2fe7eead31-49d41336d28mr14012209137.0.1726559124782; Tue, 17 Sep 2024
 00:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuaDUCxseqCW8BO0KhLKn6F0VHYaAhu-T9v-MJHzJebcQ@mail.gmail.com>
 <CANiq72kaAd5v+c+A3GHWp9riDtGTrKcCb3kraw2EaZLyp8asSg@mail.gmail.com>
In-Reply-To: <CANiq72kaAd5v+c+A3GHWp9riDtGTrKcCb3kraw2EaZLyp8asSg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Sep 2024 13:15:13 +0530
Message-ID: <CA+G9fYtghCMk_DiGJ=7pHoLhb=LUS1hXe0F0P5YFYJ-K+aUtcg@mail.gmail.com>
Subject: Re: rustgcc-kselftest: error: unknown unstable option: `patchable-function-entry`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Miguel Ojeda <ojeda@kernel.org>, aliceryhl@google.com, 
	Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Sept 2024 at 00:53, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Naresh,
>
> On Mon, Sep 16, 2024 at 9:17=E2=80=AFPM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > The x86 rust gcc builds failed on the Linux next-20240917 due to follow=
ing build
> > warnings / errors with rustgcc for selftests rust builds.
> >
> > First seen on next-20240917
> >   Good: next-20240913
> >   BAD:  next-20240917
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thanks for the report -- this should be already fixed in `rust-next`
> for tomorrow (requirement changed from `!FINEIBT` to `!CALL_PADDING`),
> please see https://lore.kernel.org/rust-for-linux/CANiq72=3DB9NmC=3D1eSaO=
rg7XutjueQsSXGcBQb7dQFPuL0SFjPsA@mail.gmail.com/
>
> If you can confirm it is, that would be great, thanks! i.e. you will
> need either to disable `CALL_PADDING` or use a newer Rust compiler
> version.

I will try to use the newer Rust Compiler.

>
> By the way, I think you meant next-202409176, not next-20240917?
 Right, I mean next-20240916.

- Naresh

>
> Cheers,
> Miguel

