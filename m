Return-Path: <linux-kernel+bounces-569499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846A3A6A3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF18887BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264921C187;
	Thu, 20 Mar 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjmC1h6+"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C831DF258
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466826; cv=none; b=u8WsPTduvGLGruqkWdtQ/5/K8L7/niL3Mh9Kr7Av7dDN8qh/fSuoRMZEZK6sgZ8YSOICP65WIMUfJLzog1DXGDv4Rllt2o5MeGMJNUEH7w7YJfXvp6lGwX38RsOX8KgTgpWsaIR/aEBjyb9XetsEJVlCMQUkHJaLnz1p5QjjNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466826; c=relaxed/simple;
	bh=xJY57fFKt0geDFWUIjkhpA/COD633fJgusXPp3/Xy2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEwX1e/jq6N0KTVI55zohJ7YikezLBODq5e1JO/bsEplFut/BIhHXOIT/q7ukeBnJm3L5GAbytB5svNh2Vj0EMLS6G6oh+F4QIVFdf7nFzt7ZEDdhje12WkNtBF+E0uIx8QvHzXFy8ldMAph5gzfx5IlyT/O9j4hVSVLTbWRfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QjmC1h6+; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86715793b1fso228413241.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742466823; x=1743071623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BKKpQAQ6JgcOkfxottrkVvBcXRW0On7hjY41tdShDfI=;
        b=QjmC1h6+5JLh8Hd0/nfpYNYec+INirSsV0Jj4WPhKYC6dR0hcOFfnTtZMqu+I+PetZ
         3+h+u3IhrL3SIzcGIDy5i1Xjvznn7GJOQiKvvusu2alzp5tiuw7BMHkFccZj+SKCj8uB
         qmmDjY5S1SfakT2kxW4XCPIxgKW0CwailMadruAaBJZ7BMLvlkbtbCmUnHb7mmSHsH2t
         h/xGWWxJFOhUFovERdAahKLTvOzaPu1r3LIPgyaORbRwCWg6l0HtqxdrY9E0fiWDcZOD
         ZO60I5WS3OlTVZbeKQenSkUG/MIuAAfwRqZhPhw8cGmZmtqN2QUhkowet2UXddd5q6SV
         5Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466823; x=1743071623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKKpQAQ6JgcOkfxottrkVvBcXRW0On7hjY41tdShDfI=;
        b=pQ3eSlejrvz7XbU+j7uAo5u02b8bTiFxATmUU5JEFH5yQ1Iizg0w4C8jz3nekO3ieY
         Yecu3K/5aq1SIk2YVK1DmN7u91zq0cC9iQCV6ZPmrnEy+UolxdcXYl4vGZama0CbBubU
         rR8Vvcem8PjhKC/ke/FSAFPv+A5SKUkpb/A2Wznj1od+h6AvN9LuVx5kEH2Wg9Mg8VGD
         auhPKyeWLE2gcIxY4FB/gV/mru3s+RkJH9E2gy13ZMRYA897PgVz3jDNNFTiMjDcSSTs
         Vy1lP5M5cjckKTQQTOiZ+1Z4b7WeoEb400t3Jcnp53PP5tChU35XgAdGJDKsycuuQVUk
         OCBg==
X-Gm-Message-State: AOJu0YxvcZcllSs48fRBltttATG+YPdD/Vob9zdAsYv8PFiM+Q+FomLZ
	49ZP8eHORniKxETqYAc8F0MO4NphAXzamZgqLCauyCdRU/z8UzpgRoyazGoL/t2TQkqC5HUf1Pq
	tTExXyOeG8to/n6v4cyLDHYPZsuRPlDDAYJAEoQ==
X-Gm-Gg: ASbGncumf9S2fdwOwSWHthq+YZphTjQt9s2LbRMwNqi/2+WcTC2S85IF7wYsXtm+BSN
	n917ZnCbRBvk/K4wj3EQz/DkgEpG5db6VqcJe/xCuwhJ9+wzpy4h9rjmfLRmcnKa2qDXJRoRxoJ
	8UDYsYkLzJqUHnanZ4irBysDfuioFeSKSC2FqGxcFju84tyzWrRBGrAILl1bbFz6PTvg==
X-Google-Smtp-Source: AGHT+IEL8RynGDkzUn1M8qBaw1QSAu13l5oOS82op5r8NMWrFV9NMAszQoaAc7xxXxzXjG7O12MUPb/cR4HugdfzEyg=
X-Received: by 2002:a05:6102:26c1:b0:4c1:9526:a635 with SMTP id
 ada2fe7eead31-4c4ec82702amr4521750137.17.1742466823418; Thu, 20 Mar 2025
 03:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvPu+MQKhYyPZSSDpAn-zhRGmeHQ8hJksT_cdDdxfbB-g@mail.gmail.com>
 <Z9ra3I2axii2HRVb@J2N7QTR9R3>
In-Reply-To: <Z9ra3I2axii2HRVb@J2N7QTR9R3>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Mar 2025 16:03:32 +0530
X-Gm-Features: AQ5f1JqkKZULx7GkLi5GllTgOKMVJsQK1_wwFux-C6kOWnMYdf-RK7BCgTRrZ5A
Message-ID: <CA+G9fYuw_jXCz07Dsk46QXQr3+y5-NfkC30ZNh+XmyeWgibQhA@mail.gmail.com>
Subject: Re: Fast model boot failure with Linux next-20250312
To: Mark Rutland <mark.rutland@arm.com>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.linux.dev, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring <robh@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 20:25, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Mar 19, 2025 at 08:07:47PM +0530, Naresh Kamboju wrote:
> > Regressions on the arm64 Fast Model (FVP-AEMvA) caused boot failures starting
> > with Linux next-20250312 and persisting through next-20250319.
> >
> > First seen on the next-20250312
> >  Good: next-20250311
> >  Bad:  next-20250312 .. next-20250319
> >
> > Regressions found on FVP:
> >  - boot
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducible? Yes
> >
> > Boot regression: Fast model boot failure with Linux next-20250312
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Anders bisected this to this commit id,
> >
> > # first bad commit:
> >   [858c7bfcb35e1100b58bb63c9f562d86e09418d9]
> >   arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
> >
> > NOTE:
> >   LKFT is currently running FVP Fast Models version 11.24.
> >   Planned upgrade to the Fast Models version 11.28 in this sprint.
>
> What firmware (and version therof) are you running within the model?

Fast Models [11.24.11 (Nov 29 2023)]
Booting Trusted Firmware
BL1: v2.9(release):v2.9.0
BL2: v2.9(release):v2.9.0
BL31: v2.9(release):v2.9.0
UEFI firmware (version  built at 22:31:25 on May 26 2023)
UEFI v2.70 (EDK II, 0x00010000)

We need to update the firmware version at our end.

>
> For example, if the EL3 firmware lacks support for FEAT_FGT2 or
> FEAT_PMUv3p9, the kernel will trap to EL3 early during boot and die.
>
> It would be really helpful if you could capture that in the report in
> future.
>
> Mark.
>
> >
> > ## Boot log
> >   <No crash log on the console>
> >
> > ## Source
> > * Kernel version: 6.14.0-rc7
> > * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > * Git sha: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
> > * Git describe: next-20250319
> > * Project details:
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319
> > * DUT: arm64 Fast Model (FVP-AEMvA)
> > * Toolchains: gcc-13 and clang-20
> >
> > ## Build
> > * Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/log
> > * Build history:
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675685/suite/boot/test/gcc-13-lkftconfig/history/
> > * Build details:
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/config
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >

- Naresh

