Return-Path: <linux-kernel+bounces-531462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320BA440BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E57E18843ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755222690F2;
	Tue, 25 Feb 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ex3vM2lc"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6970268FCD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490034; cv=none; b=kO7jVlzsXTAwVyh9VWhcsPVV7HO0aow/7RLpOAnTuHT9uLu6BL+5IZii/gFp6DIZD2O5mgI8NVYvyfWwfz4eDNCDsOByBxRY/eHYsOAAwzepeRl5amg/Kc/rxC9rEuQ4usRiIc9wOcRMdi8pS4bzq/SmpQzFk4dVbmnFU5pKJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490034; c=relaxed/simple;
	bh=II9MWiGisWH/BazFUrcH1O4fvwrPAe3UCEwVGwyXy4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUvaeTVqhUgkgChBLkq3t+TdHmxTJZpShsuWAFLPIKx24+jRqBVXXtJQ+As61vC9Ea+wxb2ZyJNLfx67sluRhJp/bJRikciGhfSHNBLDs20hDyASFUE2YEfTUw3mmFGlNS1INQiUU36dJVquYP5M5mktjNFyLDET3Ql7eYlknwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ex3vM2lc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fd28093334so1883913eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740490032; x=1741094832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ2IplcBO6Wt9ORsHg89Jo3ShjOFNhdLXDKK/XmSsr8=;
        b=Ex3vM2lcSX0vTF/SNpFlxdHauaALbbRsXUKPAeM0JDaul4gXn7iHyPkZaSoXtkDM2s
         O/JXerLC9gvYgxuhOUsLfa9tH11Plkux33R0qscs6uMk9b4fcrDoBJi0vfHqcQQ20GpQ
         khDI1ajuoUgYw7DOj03XZYany8MTQm9GptQ2gES00fRD08RGoKH2CY72xJrNH96sL48b
         gDmmKmSHotl2lpavNgupCi919AGwei4Wy4g+bq/f4W4COJ0WbYwVTe2dCQl088N+HrIb
         8Ct7T1rtLbZ6flIF1QlAYC5byCiAf5exEWRLcWo/+k7xQk8cbTVLt2YYI7DXgqEihCgG
         mk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490032; x=1741094832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ2IplcBO6Wt9ORsHg89Jo3ShjOFNhdLXDKK/XmSsr8=;
        b=knm7JUBygfym9jHksos4H7CQQwY6O+Ld4PMCtzC3dQt7gFzw3lrqY+AzhXDQQoh0J3
         3AOvqf7hd0KNoJlLr1F//MV0kgHEstiSctuSSEf7k0ODTTFtSNLk7FBDqotep3Z0on2H
         q2ysMN8KjpwK1pGk/R7psMmPi8D6+QI+0VU2Ajnm7H7065gnOgZLneUSEDAUwStD5lVu
         kkL5QML3ajNq/GAaoCqLAYkm2j3yBLfHHrjOE63WtdH0MnI8B2PG6Cky6zdVxbfPSrNi
         RG5PFIFPv7973HmUQ7NWc1T3M+kzncMI6/L3+BNiz08QROEtmHosWeZ9JSicZK1IPwhQ
         8ykQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2DkSPCsFWm8haKD4BzsijcaGbcb8uzXR6BpEBOYSf6MFbFGDsi6TruHeVtIqanRErzQViLQiMznQzAgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+jVpIdkNFkUAGdjBMHlqiqo9vZtmXCLwvgPMApVjnaLw96+A
	NIv/DOLHbUbFBVE2Cr3M/7U1MrhJu65910nykMJYum1gSVNNlWu9eWqP4DvpaVBpLMw+BFW664N
	bC/6b5qjfZaHiRc4bguCBDruv73UrSJbOn3Cauw==
X-Gm-Gg: ASbGncthC8P5anbDBbjLjZ1tSxUpD16+4AYpV3VhW+YWkHgVQhVBlyuwk7gSRZfJv/M
	bl+KcdfR/qJ7ctlnPA7JTWK5ipNDfZq7DVij5ANeUJiQOUpt7RBmbaekhKs03PPTHhYBXjbxPSd
	RXmgN+c769bA==
X-Google-Smtp-Source: AGHT+IGCYFeFsD7WGV356badMoylqjRk/7L+ck4H3fwlwJNvLiJ10J44Ay/xWN6OXmGF8Zq2ohZYK5fZI2twS/y+Qxs=
X-Received: by 2002:a05:6808:3a06:b0:3f4:1738:f804 with SMTP id
 5614622812f47-3f425a5a053mr14822684b6e.4.1740490031753; Tue, 25 Feb 2025
 05:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115024024.84365-1-cuiyunhui@bytedance.com> <CAHVXubhapunBD_+cZ=WeEp9GPJec795xOWSnMKmh_iSH09r2Yw@mail.gmail.com>
In-Reply-To: <CAHVXubhapunBD_+cZ=WeEp9GPJec795xOWSnMKmh_iSH09r2Yw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 25 Feb 2025 21:27:00 +0800
X-Gm-Features: AWEUYZnBrHwWk1-NR_0_zzRZ-hclxJae0XrHpGmrq4kc_cdvQEhDUpQ2xjlpHLE
Message-ID: <CAEEQ3wkeLrTFVqVZEAYSsROSLHzkC-EeKvuPHmW=qH3CxamwhA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/3] Enable Zicbom in usermode
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: ajones@ventanamicro.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, Feb 25, 2025 at 9:21=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Yunhui,
>
> On Wed, Jan 15, 2025 at 3:40=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > v1/v2:
> > There is only the first patch: RISC-V: Enable cbo.clean/flush in usermo=
de,
> > which mainly removes the enabling of cbo.inval in user mode.
> >
> > v3:
> > Add the functionality of Expose Zicbom and selftests for Zicbom.
> >
> > v4:
> > Modify the order of macros, The test_no_cbo_inval function is added
> > separately.
> >
> > v5:
> > 1. Modify the order of RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE in hwprobe.r=
st
> > 2. "TEST_NO_ZICBOINVAL" -> "TEST_NO_CBO_INVAL"
> >
> > Yunhui Cui (3):
> >   RISC-V: Enable cbo.clean/flush in usermode
> >   RISC-V: hwprobe: Expose Zicbom extension and its block size
> >   RISC-V: selftests: Add TEST_ZICBOM into CBO tests
> >
> >  Documentation/arch/riscv/hwprobe.rst        |  6 ++
> >  arch/riscv/include/asm/hwprobe.h            |  2 +-
> >  arch/riscv/include/uapi/asm/hwprobe.h       |  2 +
> >  arch/riscv/kernel/cpufeature.c              |  8 +++
> >  arch/riscv/kernel/sys_hwprobe.c             |  6 ++
> >  tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
> >  6 files changed, 78 insertions(+), 12 deletions(-)
> >
> > --
> > 2.39.2
> >
>
> So a v6 needs to be sent with:
>
> - the fix for hwprobe_ext0_has() reported by kernel test robot
> - a rebase on top of 6.14 since patch 2 will conflict with
> RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0

Thank you for the reminder. In fact, version 6 was sent out almost a
month ago. Reference:
https://lore.kernel.org/lkml/20250124035959.45499-1-cuiyunhui@bytedance.com=
/

>
> Do you think you can do that soon so that it gets merged in 6.15? The
> patchset received a lot of RB so it would be too bad to miss this
> release.
>
> Thanks,
>
> Alex

Thanks,
Yunhui

