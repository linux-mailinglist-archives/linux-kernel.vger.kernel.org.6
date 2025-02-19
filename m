Return-Path: <linux-kernel+bounces-521172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E7A3B61C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E24189B772
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F931DF260;
	Wed, 19 Feb 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bgN1B5LU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F51DE3BB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955070; cv=none; b=JrPkg/vNsqa5RANRP/8kwgvYJ36R+uJ5bS0N7cnhmI3lA01yMEM6EJDOWGRVk6N8a7IMqE12p9E+5TAn9dS+g4VGV5lHBIw06ywCWyG89q70+jW8/9WchkrZPtFS5/SJEf1LAYZIyWW5hwEvG8VNVEGAXyuhfYuR8tV9RF/q/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955070; c=relaxed/simple;
	bh=aB7wbo6LJoP8fuqHyehR1qLit5d+ohfBtEaefLRZGSs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Sxtczq4DaOKy4BFgdYrBTDASsROs50rc36TYLK2scEKl/XtjYmwMVqd7aBpIl7pez7zkC4Oe9ZZCD+xj61Mry/Nma2LYbubB4/Gisu3wfm/amC3pgkofwIUpYIRt8q3jAbPXLzIvOd5C6RRTf//C1ySZEYC+QVOVYenlRxi52/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bgN1B5LU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399509058dso2194425e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739955067; x=1740559867; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyOr3ZD32WYQ578+kdBxZIoR9hORXh2QvsH9UB3Wz3E=;
        b=bgN1B5LU3P2E5gi+YoAnACHUGWg5tz6LQ4wQXKu7ycAUC/E0YPPd4Bh7y+ofcrefz2
         4wQmOOmxSYtbakVZnUBgmrF0+Kqc8WwHDmEejlWp5r8v3mB92JYibBIWCMuCl9KkatS2
         xSLHsJZsdQ6JBz5v1WNZAocsi0onG35oXx+mPIChBvh8jzQKPVw6+ZXrjWTIarkF54vI
         hJ437QoKXXP9stCkAFPcMiiDg7xVYHGAOO95o0RpZ9I+G3xUjVqCu3rSbd2hLpjgh0Hz
         vo9ayxF+bW8uU2xardh+S7h7OF4XYdmVT13evYfYBTnPgZsLD5/zrT5VVlz52ALDyO/G
         SPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955067; x=1740559867;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cyOr3ZD32WYQ578+kdBxZIoR9hORXh2QvsH9UB3Wz3E=;
        b=ufFLT0ybUOy2hNBtgZedMMmZNEhSNGjg4CikHBELoVBrpLhQQEgnaWrjoXTAHQbWkB
         mKje/sc58eGypDKSl8XmeUSkF0p1Wkf6GRKaAal3lObbQFkEdsc7HmwJsqFo2muOIdef
         XkLA/dvWgd8sojya+Mbm87Ldhmuj2fzSO2jlKgN1o9Y83tLMokS9pVraLUOc+zdad+iD
         pbU30LheTb1r/+pj+cm+3qc0a7YIwLFQwuqX7IWpLRl3XiGmOISEFC8LHgHp9w+uIFzm
         n3QWxZtLZ88p11lJr2jVuGF0hHbNe+RCbhhfRXQwCV5tHUwRVb0oyr5cu/xDOIGiVn6Z
         HYEA==
X-Forwarded-Encrypted: i=1; AJvYcCVAIE9rqpnYnVuYGkxummNBE1MlDuvDzXHIe5bYJJ9vbZWplpGrxMBfjfMWli0MoeI1o+Ko5snhJRNsCUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBl5jQVNLm/U0qfVRnFp3wpn3M+1h+qb7qKAfvsdTJ1muPBbIJ
	+fGxOb5kMvJKR/2I08pa3Xoklutss4FSxU+iUXqX6KkllIdOLNkzkxrxva4kLfIH9ktrN+Dkpkh
	i
X-Gm-Gg: ASbGnct2zjf4JYA0fqVGGU4QSdMg+kPHi2yazbcOZGF+L+Mq2gwMVtBe/HMiR4aYJUV
	EDZW13Gl4ns8od22ckl4Iy5b5OySf3BXdb4Z9/E50SHAojZd8KzEUrQlqAYHF5SPU0rjoHZTep+
	hwPUE9/BIuwoptjjcEHj3aqlQeL8a0+z9zxIXI3a1azUrcCbeAmQQpNi4wkk7BchrruyA9mwxO/
	1rWTaGAw7U1aQ75dvyTjpEwcus3+U9lqftzQUyrEEFUUctbPctXDxZV1FsDc8ajubGnf2rD9/uZ
	LL1mS5T3whXCnSzBygIrBONq83lQCUC9f3wJ3PXcUsnZZ8u5bn4=
X-Google-Smtp-Source: AGHT+IH6D4plZNYfuEYjbGdATaVAlFztkIrp/rClPpYzS5dL67Gt7zhXEE8RN1q+8mV+NLcuY45v6A==
X-Received: by 2002:a05:600c:524a:b0:439:4d1c:bf72 with SMTP id 5b1f17b1804b1-4396e77b89dmr62388815e9.6.1739955066877;
        Wed, 19 Feb 2025 00:51:06 -0800 (PST)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8730sm17632219f8f.93.2025.02.19.00.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Feb 2025 09:51:05 +0100
Message-Id: <D7WALEFMK28X.13HQ0UL1S3NM5@ventanamicro.com>
To: "BillXiang" <xiangwencheng@lanxincomputing.com>, <anup@brainfault.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
Cc: <ajones@ventanamicro.com>, <kvm-riscv@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <atishp@atishpatra.org>,
 <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
References: <20250219015426.1939-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20250219015426.1939-1-xiangwencheng@lanxincomputing.com>

2025-02-19T09:54:26+08:00, BillXiang <xiangwencheng@lanxincomputing.com>:
> Thank you Andrew Jones, forgive my errors in the last email.
> I'm wondering whether it's necessary to kick the virtual hart
> after writing to the vsfile of IMSIC.
> From my understanding, writing to the vsfile should directly
> forward the interrupt as MSI to the virtual hart. This means that
> an additional kick should not be necessary, as it would cause the
> vCPU to exit unnecessarily and potentially degrade performance.

Andrew proposed to avoid the exit overhead, but do a wakeup if the VCPU
is "sleeping".  I talked with Andrew and thought so as well, but now I
agree with you that we shouldn't have anything extra here.

Direct MSIs from IOMMU or other harts won't perform anything afterwards,
so what you want to do correct and KVM has to properly handle the memory
write alone.

> I've tested this behavior in QEMU, and it seems to work perfectly
> fine without the extra kick.

If the rest of KVM behaves correctly is a different question.
A mistake might result in a very rare race condition, so it's better to
do verification rather than generic testing.

For example, is `vsfile_cpu >=3D 0` the right condition for using direct
interrupts?

I don't see KVM setting vsfile_cpu to -1 before descheduling after
emulating WFI, which could cause a bug as a MSI would never cause a wake
up.  It might still look like it works, because something else could be
waking the VCPU up and then the VCPU would notice this MSI as well.

Please note that I didn't actualy verify the KVM code, so it can be
correct, I just used this to give you an example of what can go wrong
without being able to see it in testing.

I would like to know if KVM needs fixing before this change is accepted.
(It could make bad things worse.)

> Would appreciate any insights or confirmation on this!

Your patch is not acceptable because of its commit message, though.
Please look again at the document that Andrew posted and always reply
the previous thread if you do not send a new patch version.

The commit message should be on point.
Please avoid extraneous information that won't help anyone reading the
commit.  Greeting and commentary can go below the "---" line.
(And possibly above a "---8<---" line, although that is not official and
 may cause issues with some maintainers.)

Thanks.

