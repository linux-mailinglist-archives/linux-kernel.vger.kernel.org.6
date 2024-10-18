Return-Path: <linux-kernel+bounces-371387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553479A3A70
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DFB1C20CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC139200C9A;
	Fri, 18 Oct 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhsZHgiq"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665901FF7CC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244896; cv=none; b=lui3dQeS3wmDQZCOOz+j4MsTP949lnDCOWudjyRtfLQaOYL7z+ik1cntQmq16JacGeoWLrmicj2vgjxNsI04tYfjsAa2mfRvjCwujVMymZLKAdkBVvK7IlcR9FOYjzYTM7kGLp/2TTFk68reMKU+82p5C/BaTZZfgmLhK9zYTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244896; c=relaxed/simple;
	bh=BmVeZmCmcwklSJUf1iPn7T5UqzICg/V+X8zVLiMXQTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3VpR3fRG1bN9/oczMJ6at7NX+VAOtiRsVwOZQycZUCGgpvEveY3f4lhPpwX5gllqvU/lE9X3+Dgn/30kSzhA7Wa/YVhtpiZbNtqU3+xqPgeDPnWBM4PxMozj2dx4FhxQ9Ppbs+2uXLJvWVmuR76mgKRMZWKT/6r0Gx/mzA7U14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jhsZHgiq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so2661346a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729244893; x=1729849693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Soh6jH0z+eTQKtZFMIbLZG9/1ikoWd+mxwUaxhi1Ds4=;
        b=jhsZHgiqFp9M7z/aHzWz2SRXBsr9nubV1teEzQAqhm7vMaoTavtAeFhw9Rg5/Ys4Md
         gKJvf0qIntm0gfmIeguvhl72KsX5waW6HbiK72CWKAYwxrUVdXBs5Z29Y8q8G+Ft+hg7
         t+Dnro1q/w3hSclKh0i30bgxeUTGIduqU9THlXZBQr8ojK/KuKzd/R6xAgNUJIRINeKl
         MDxjtj0ncQsLiE1zDzQ+L0ZLRw/kAw93jz2g4b/3CxpuQ/G1mcRneQAEza1tPGzCCbUk
         ajrIEwQgNMlNScjuOaC27jpmIYYliXCh5llUMm70I1OoqtWYaWj/Cbrc1v8KqnwLge+U
         MKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729244893; x=1729849693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Soh6jH0z+eTQKtZFMIbLZG9/1ikoWd+mxwUaxhi1Ds4=;
        b=XG+wtvVDCdRonw855gSrmRbPBJRH3ZQG3KTCLy/knvkgACW98z71R/g89g0DnWwDiv
         x9o2EGzBS1p4WqCh6cBOKGGMGB137SyigfMsduBJfdOzr0m9rFfKDlLaD6Qny5ZwIG04
         Ai4NJ+hDh94CFX5L23Yz/0VMuvJAcZ4XoKszkSxLPQ5dhyEPVgpMNVhN3wMy7d30K+ZQ
         9eMzyfCfo1guVrhV4+5hXdspWXJ1e8PUm6rqeCLJHCI0MM2k59sqpODOL7aevOz4Jizp
         f/X8w+ms2vchOpo1GseDfd4yhBlps/Q/BkFs00oVlQgKkAtvD3hviPrPC0eZXugT4hkZ
         cHtA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQ7UCJSIs71+ZiLW1zEVm1tp3iw7hCsrNrKCQV61nz4qt8W/4iDV3/xXAkwDAH3MRIoF/ZY4k8DGhpNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCr3SWixz7SzXo4CklzDvgygAmkArG/vmfUB252aTFh4JcRqvk
	XkoR+5TYsaGI1R88kUrQs8xQyMirP9w95I5l8WJeyXx1C+dXonSHHdfFn+QbreVTUb1chz4qJ7U
	6TMxv5cxDTNcqtsZEa0UqWocUeVh00WCjDrtuyg==
X-Google-Smtp-Source: AGHT+IGwkBnt8S54HV5wpTluVRczh/eHb/pg8v+8S1HtQBQwTQ9hgVMWZh3zivyvuxuChXefK071wuCB0YFmrafJ2jY=
X-Received: by 2002:a05:6402:40d4:b0:5c9:3389:bdc3 with SMTP id
 4fb4d7f45d1cf-5ca0abe8729mr1177178a12.0.1729244892751; Fri, 18 Oct 2024
 02:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
 <871q0daglh.fsf@draig.linaro.org>
In-Reply-To: <871q0daglh.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 10:48:02 +0100
Message-ID: <CAFEAcA-39GRpvy5LOZSJL3=9FMspAq9c8GUtHv9CP4jU2uFi1w@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, qemu-devel@nongnu.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>, 
	Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 at 10:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Naresh Kamboju <naresh.kamboju@linaro.org> writes:
>
> > The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
> > The boot log is incomplete, and no kernel crash was detected.
> > However, the system did not proceed far enough to reach the login promp=
t.
> >
> > Please find the incomplete boot log links below for your reference.
> > The Qemu version is 9.0.2.
> > The arm64 devices boot pass.
>
> Can confirm it also fails on the current master of QEMU:
>
>   #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3D=
signo@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
>   #1  0x00007ffff4a3ae9f in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at ./nptl/pthread_kill.c:78
>   #2  0x00007ffff49ebfb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdep=
s/posix/raise.c:26
>   #3  0x00007ffff49d6472 in __GI_abort () at ./stdlib/abort.c:79
>   #4  0x00007ffff6e47ec8 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>   #5  0x00007ffff6ea7e1a in g_assertion_message_expr () at /lib/x86_64-li=
nux-gnu/libglib-2.0.so.0
>   #6  0x0000555555f45732 in regime_is_user (env=3D0x555557f805f0, mmu_idx=
=3DARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
>   #7  0x0000555555f5b0f1 in aa64_va_parameters (env=3D0x555557f805f0, va=
=3D18446744073709551615, mmu_idx=3DARMMMUIdx_E10_0, data=3Dtrue, el1_is_aa3=
2=3Dfalse)
>       at ../../target/arm/helper.c:12048
>   #8  0x0000555555f4e3e5 in tlbi_aa64_get_range (env=3D0x555557f805f0, mm=
uidx=3DARMMMUIdx_E10_0, value=3D107271103184929) at ../../target/arm/helper=
.c:5214

I investigated this yesterday when Catalin reported it
and sent a patch:
https://patchew.org/QEMU/20241017172331.822587-1-peter.maydell@linaro.org/

thanks
-- PMM

