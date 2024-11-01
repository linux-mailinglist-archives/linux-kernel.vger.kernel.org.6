Return-Path: <linux-kernel+bounces-393025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F49B9B10
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706D21C210FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E71E260F;
	Fri,  1 Nov 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSzep9K3"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42BC156C72
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730502076; cv=none; b=Gxfx1D5dcEXOBXhg5FAuy9PVIn0anGnGadrTBNOxR7Qhmrg3tmndlzqSdm9WFEk50Ja4cmNbwyy/UicppzOkmDt+Sf9TKEcgd8GLzURNu7EcxS3XlYYWXWROkdG2NscIT4ia7W5UDlgttN4wXRExhN2t7xThRQbVDGCiJmkxM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730502076; c=relaxed/simple;
	bh=/VzRJaN+NnnqiUSxsGtBb31nGUad7BtmeUsMPMIuqsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE3PMlWxavXnngZwrWxUAYQtN3pXLv/0LmcF3qEb5/EyjIT8Z43s5GYSgMgcCJdRruDrH9K4jEoqUAcXoeERGp7zJDw7xxhQ66abFjY5DIRdYwn6iWiRNTSNNK9mQGIz2DnsjRkw77+59g8nUyz7rKo4KEOC+BLRNP8JQpfa27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bSzep9K3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so23911411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730502073; x=1731106873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VzRJaN+NnnqiUSxsGtBb31nGUad7BtmeUsMPMIuqsY=;
        b=bSzep9K3nR7zvzXDAEfBUieJUSTUCRyuBHn6iI6ED7evXTdywfVJIpzKlORHQlABk7
         1nDyfFV8J1PRG3QzkaWfTs5AfX78/HBa4wTbgWOPnwty54QeHL6cSD53cr2co5v1VCcb
         Ye2z2nV0jExn07aq4cMd5OTg5jqN9t6SI+jA29tTaBz7QM9+5ev9iKuU2bmDDSMV0PRQ
         KQsPM/AyCIRVjFd29Oayxvd27hbQjkC2B07O88Qyfmfikm6HfastThmSD5FSNAY1NFxc
         PtlCcj7NtSnThf8HlNXeAlC6Tr0NkngCPTsYtetSakr7ieSr77Nsw691BPmBmjCNXbtC
         Wnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730502073; x=1731106873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VzRJaN+NnnqiUSxsGtBb31nGUad7BtmeUsMPMIuqsY=;
        b=QmQItBv10UEyOVAD/cTu15VQTAw8qDO9dEH61rjOD3qp6BVA2ArBDx/Uok4DHjejBw
         04kGJ0Ua2Hkfx1i+A80wOpuZP5cUjDPJXG/VPU1+JECjozcM/m0w2q+04R6a9Uj2ney1
         xWvNE9hXfNb8GMrdVpuPd6ToYuZzyeDueHWZXIGbabPT8mF06phRBChTEZM31PauwPWG
         qjjgaYdUO5Ud5V/gfr0I/SMrwe0b2bH7RnFHmoKELm3Clnjq4kyjceVn7JaBDWoD6q8s
         a+ia7m53oAmflnHjWWltdknZEpXJzBLKNJF3eUcN824/o7pkd6wRmk8JpQo0WCHbzZ1u
         FB1g==
X-Forwarded-Encrypted: i=1; AJvYcCXTQym8+QVo1zMaHYbzQXRyEmEll1yU2M1YqxEWfJGHWlBWNOGsOSf2OB+EF2J9ZeLwCKgmrvotU8aqxmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKedqWvSfkiT4OHCroqGNurCU54OzeacOd9b827LbbjtPFGN4
	cfAHyPkxjzlJNG6h6CKAUFGf7eR85Yw+s+A8uACfUgGm0wQDDBDgfiVXVO261TKUwrZK7fbSfjS
	Ooi9On4Ef1zhwqYqY/uc7lZAY7jfR0mTDt9DPOA==
X-Google-Smtp-Source: AGHT+IHUrFtSs2KoJie/ag5U8LaXZwywnsQh7l2YsRqtTFXJcYBaKb8KFr8549S9dDV3k+hWD/NftGFkeCKXktgctEU=
X-Received: by 2002:a2e:6112:0:b0:2fb:599a:a900 with SMTP id
 38308e7fff4ca-2fcbdfb978emr106638791fa.15.1730502072547; Fri, 01 Nov 2024
 16:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com> <Zxevfe-PZgB_Z8hi@shell.armlinux.org.uk>
In-Reply-To: <Zxevfe-PZgB_Z8hi@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 2 Nov 2024 00:01:00 +0100
Message-ID: <CACRpkdZjRpcA92FARSXLNHdSBLxaNwvG6N2ZJPg8NK8cprh7UQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com, 
	will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org, 
	luto@kernel.org, kees@kernel.org, wad@chromium.org, rostedt@goodmis.org, 
	arnd@arndb.de, ardb@kernel.org, broonie@kernel.org, 
	rick.p.edgecombe@intel.com, leobras@redhat.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:59=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> So, I think it's important to always quantify what the impact is of
> any major change to the kernel entry/exit paths - it's all part of
> properly evaluating whether the change makes sense.
>
> If switching to generic code causes a significant degredation in
> performance, then that needs to be investigated and fixed - not
> waited for until someone pops up and eventually says "hey, that
> change to use the generic code resulted in our systems becoming
> much less performant!" six or twelve months down the road.

I agree, I did some measurements for the ARM32 patch which is
in RFC v2. I ran:

perf bench syscall all

This issues 10 million getppid calls and measures how much time
that takes (on a system with some background IRQ noise). I issued
this three times (which takes some time to execute) before and
after the patch set, then compared the best performance before the
patch with the worst performance after the patch.

On ARM32 generic entry costs some 3-4% of performance overhead
(increased execution time).

By chance I discovered that PAN (privileged access never,
CPU_SW_DOMAIN_PAN) costs around 400% increased syscall
execution time overhead (two orders of magnitude more than generic
entry) Debian apparently turns PAN off, maybe by mistake, maybe
for this reason. I was a bit surprised by it, I don't know if I made
some error in the measurement.

Yours,
Linus Walleij

