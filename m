Return-Path: <linux-kernel+bounces-287443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB29527D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20114285E96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF59476;
	Thu, 15 Aug 2024 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cX4zwfkF"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2835CB8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723687711; cv=none; b=Pjk3imjmg+4GtBkpgh8uO7tsk9Dw1jmSTUSgJS5PohFPl+lLfoNn7nmnmKcTfHA+2ZTGu4sIpXamZbGROSX4WE+qabMnZGX0CIZxuS+90tyjL39GLStT6OL5TiAi1e71LB1NyS91Lq7Ul/xZuCHkqx5jV8QgL39iE4WRXEQGSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723687711; c=relaxed/simple;
	bh=Y3L6Qf4W28EfvaT6GAM1LpQnNeWg7TZKJstvkgJj/j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uJDPr/oDGRtWxmmxCkXBACxtRMaPjSPJXFCBAG8U0YkjTQT9yCK0TMCy/YSV56b4avCJwQK3emi3WP1nDPnXB8VIf9KJoEl11DC30/Yq9l3OK660kDTAuC8vsJPOLa5ttBAVSN8b6AUruuFZ5sARijcguaz5GBXyaAmBcDLumRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cX4zwfkF; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260f863109cso329352fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723687709; x=1724292509; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVeoMNyPHlWmE0m0EI3mUy0d/dKSh/ETD20e4TLytgk=;
        b=cX4zwfkFdU9dmCvctwd0sTPsRfhieWcwXsK1Lbcy244tVx2YyQViOCPTesmA/ziYDK
         SsVmoeJ9tIRLzXbreLjOhkdxA4lHw3Bfshclpxvbsb1kwCKOrM190rQRkG6kocjlaSSR
         KAYLds81ZmeebS0UDChrGXyGxZ0LDyRclGM+0SdPNJxdGjrA2+v2XNmw/yMGAkUNT+zK
         ZrHb3gqburgoEXnjBmRLFsMS7WcpVXlRibFfU8sO0YA9eRbnZS2NtiF+YgsttoUHoPC3
         B5yqy0PiMA8TnmnKyLQ4J70IkJKdxKtnL1KqmO3ViLwygczunPwOLX0ka7+63nMk6Uck
         3apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723687709; x=1724292509;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVeoMNyPHlWmE0m0EI3mUy0d/dKSh/ETD20e4TLytgk=;
        b=kSen8HO6oM84c74HvoeyQzuf9scJcjwswqfh92mhGnmqBk8u5EldpelKfQ52JH4HaX
         xbfQDVRkq38vBIeCxKr99QcXi+cGovsAMtfvXtae7lHbCFL8IxPjwkBaBurktX0xI7ue
         FK9ai5hn5KV1lk5W2YFVzMT3DaaGISqIJBsU56Rh5eDJlpuRxuYCGYFZyUWk9Bi3SciD
         Z9kIkPLNss6hD8qvpVUJUVJBAuh04gDvmZLuJDwWmFgUGbmJb+QDlcStVPFGEZDFzNJo
         cbQ6n6WhV5oyfNrT9/wiqVkDWGHtiz7eXmv9MlvdgWwHWv1waZkVrbCEvm9w69lcczD0
         /30g==
X-Forwarded-Encrypted: i=1; AJvYcCUtmNU6NF7Q0Vl6g4abKzeAeiJ6d72ERScgJaok9yZJTp24+nGKVrrW9BpnWiVgcZRMrMpfhMnBPUhL1TmK7xw+rfEive/2Oi9KAe0P
X-Gm-Message-State: AOJu0YwD7iTBY+N0KCDmAuyhiIvmKC3GAOoSX50b7c6QtEcuTuRbldXD
	Ga7FfLfMda7/9s99O7zWxzZyv/rBeq5ihuVSRM56IIweD9pmHR1/p8qYrfrMCzvGkxqL/AfH2Dj
	yW9R3i/kaHNuwzDwPtgCCXq+/EOI3SFgBU2xdPw==
X-Google-Smtp-Source: AGHT+IF3RLEksU6gvXHQ5kES+Sx5EEypfsUOJMnD2FR4VF5VbqO7yclIa2VnQpa36geQSC/Eo2E+AIotmAFdVhrbFnc=
X-Received: by 2002:a05:6870:b6a0:b0:25e:14f0:62b1 with SMTP id
 586e51a60fabf-26fe5a63926mr5872154fac.13.1723687709159; Wed, 14 Aug 2024
 19:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625030502.68988-1-cuiyunhui@bytedance.com> <CAEEQ3wnrdRcBdevQDGQ-5dr3aO1ura13_VskMYm8ySTZJTiYhw@mail.gmail.com>
In-Reply-To: <CAEEQ3wnrdRcBdevQDGQ-5dr3aO1ura13_VskMYm8ySTZJTiYhw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 15 Aug 2024 10:08:18 +0800
Message-ID: <CAEEQ3wkFk1bxEPH38yBH8wzAGhMB296B8knjx8nFKQYgrACSDg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Randomize lower bits of stack address
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, andy.chiu@sifive.com, alexghiti@rivosinc.com, 
	conor.dooley@microchip.com, bjorn@rivosinc.com, sorear@fastmail.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, punit.agrawal@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A gentle ping, Any more comments on this patch?

On Thu, Jul 11, 2024 at 2:09=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Add punit in the loop.
>
>
> On Tue, Jun 25, 2024 at 11:05=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.=
com> wrote:
> >
> > Implement arch_align_stack() to randomize the lower bits
> > of the stack address.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/include/asm/exec.h | 8 ++++++++
> >  arch/riscv/kernel/process.c   | 9 +++++++++
> >  2 files changed, 17 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/exec.h
> >
> > diff --git a/arch/riscv/include/asm/exec.h b/arch/riscv/include/asm/exe=
c.h
> > new file mode 100644
> > index 000000000000..07d9942682e0
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/exec.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __ASM_EXEC_H
> > +#define __ASM_EXEC_H
> > +
> > +extern unsigned long arch_align_stack(unsigned long sp);
> > +
> > +#endif /* __ASM_EXEC_H */
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index e4bc61c4e58a..e3142d8a6e28 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/tick.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/personality.h>
> >
> >  #include <asm/unistd.h>
> >  #include <asm/processor.h>
> > @@ -26,6 +27,7 @@
> >  #include <asm/cpuidle.h>
> >  #include <asm/vector.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/exec.h>
> >
> >  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_P=
ER_TASK)
> >  #include <linux/stackprotector.h>
> > @@ -99,6 +101,13 @@ void show_regs(struct pt_regs *regs)
> >                 dump_backtrace(regs, NULL, KERN_DEFAULT);
> >  }
> >
> > +unsigned long arch_align_stack(unsigned long sp)
> > +{
> > +       if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va=
_space)
> > +               sp -=3D get_random_u32_below(PAGE_SIZE);
> > +       return sp & ~0xf;
> > +}
> > +
> >  #ifdef CONFIG_COMPAT
> >  static bool compat_mode_supported __read_mostly;
> >
> > --
> > 2.20.1
> >
>
> Thanks,
> Yunhui

Thanks,
Yunhui

