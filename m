Return-Path: <linux-kernel+bounces-514328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F10FA35599
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5291890837
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D715746E;
	Fri, 14 Feb 2025 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bAjzXBEa"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938A14B088
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506280; cv=none; b=KtQ9WqQlBOzIbKogs4SzFWVLo5JYM94n8debyMvl/WgfVcQaDGSA3eN289jP4y17fI8lBPyosJSiRy4Rw33gA0J+cqqe0+QoPKABBmKtJiOlcxjJxCYvwQI58jn0BOAN5r0Yn32IbOwBWykQfhcHE36yhnENEsJ4TtQSLKGtwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506280; c=relaxed/simple;
	bh=3q/DDqT3RkBTiUoMbnfyp4QNU85lhijUQO0DXx7aajo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoCxPCdhxGti3E1zYWNyA6QD8e8RX3hBeGdRSEbxqyvRLW0yUq8nro6Q13Hpm8vtgOk47P4gt2BDhCw1r4UbAWKNqa8MfObhQtuAgorWk+M5uska9KjKDIsb5wizHQHDGA9Yu1iKMeYWacnbvdv8/niS1uhicbjro54sLDdRyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bAjzXBEa; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f3dd2069cdso585835b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739506277; x=1740111077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1KWHf++8W5fV1RbAwQTM4zcz6/lfxxSV1aIdBKY9Yg=;
        b=bAjzXBEat+UCShGAY4vJHTUUflvXsJIANWQYUmc2CtwiZ2JovlSremH5pp0lVe0S5r
         nraQjMA+45Ta8M8sy5gVNj3c/8tBZiuc7izP4OMEjBLiWHh1eGDEcAsucDMs9C/ymg8A
         kCdH14WuCwt0u0pUUo7uoESHx9olXw8ypgsZeUNtq4WCeWszHLAuvYUXc/+68E4i7qSw
         8pFmgA8OSJXHPacmL+J8YuXMos4Cn2Lne8FsqtMNNsEGWjAo/usu2tteSlPXHGoViPrQ
         y4CZEkpAABFgZK2EcVZpRnbBT7DIxq584FtykscLLdm8yerIfrbeqzvxmOKzKVp7GzpP
         jL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739506277; x=1740111077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1KWHf++8W5fV1RbAwQTM4zcz6/lfxxSV1aIdBKY9Yg=;
        b=tsIH8emsw0Umaf4ioxf8ZWaJEFJBu9Kg20V4FTZgbrjQ+aSAcmn9DUDoK0NxXxN1+X
         sHDiNjDsXumtrWT1NDK1M/jqRP6lYc4Co8O56EADVLeVj5W7lq6kGjUcgnE4KP4kXKlH
         iWm1CC2bGg0kF0iNKAZULXpfxTAl9Pm6KlKzkkCZhwb0GKJ/WSIxDpgGtIXMYJ4NHkv1
         kgIY/GGcSme91uVfZ1N5KfTLMXkUcD7nE2ilAj0pRC6RoSm4t/S9tcYdnXJNXOnEIRLq
         LgCdOZ9GLQHukBNK5YjcjGE6ALfk3Vhbd7YtVXrIVkngJuwabmY0XOp4SYsY7TI5dHlM
         KeyA==
X-Forwarded-Encrypted: i=1; AJvYcCWFuCa9Z2U2bLNdEzExw+DcQ0UYY+xhRVUoIZta7BPIiw7RRG4u13vsc6zXdUBLRXw7/tUSNQ8zl/DlHHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE68g2iBBuZuMPZJQh0PS7DVtxqkKHt03zeDZDAxBuYAb0M4wY
	gaFCBRnOVr5M12E3Wp+4r8lAAacrABhSlNaJLX4wqwWTMvu2bgY2aW6qJOfwR4vWlZsFx1MTkT9
	+ZWv1VToJv926y0j7ESfJdtI1N2SdIxxMMWhCjw==
X-Gm-Gg: ASbGncsg0S4w/PQhiRv7jHLR+7HHe+wDRPxLRCff547EMf663xLbWJ7e3uljOVM0pXe
	na40mGC29PPxV6ZeulwO33jmlZ+cnOBxftNqn45aETILw73nOuI+/CHjGTmgja+LoyoZKIhDQwc
	/HoMXzag96QA==
X-Google-Smtp-Source: AGHT+IFOhXxP+vRbGYo35IgATS71rKERSezvT7bJC7RWvfp19qLtfzZg8hIdvVdo0XYYtcZD2GR9bgJ9Z+G/NRzjAK8=
X-Received: by 2002:a05:6871:aa09:b0:2bc:716c:4622 with SMTP id
 586e51a60fabf-2bc716c48c5mr1595038fac.38.1739506277383; Thu, 13 Feb 2025
 20:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mvmfrkv2vhz.fsf@suse.de> <173947144178.1330575.8179936961826705707.git-patchwork-notify@kernel.org>
In-Reply-To: <173947144178.1330575.8179936961826705707.git-patchwork-notify@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 14 Feb 2025 12:11:06 +0800
X-Gm-Features: AWEUYZma9x3xG5BVCVj1l1hGgrFkApgPF92BQSPSOpWUewA9V9CltP2eB1S4OR0
Message-ID: <CAEEQ3wmH9MCYCfLL4Q7R7BHWbiQso+xr=zjhizY+kA5xtNzEzw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv/futex: sign extend compare value in
 atomic cmpxchg
To: patchwork-bot+linux-riscv@kernel.org
Cc: Andreas Schwab <schwab@suse.de>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 14, 2025 at 2:31=E2=80=AFAM <patchwork-bot+linux-riscv@kernel.o=
rg> wrote:
>
> Hello:
>
> This patch was applied to riscv/linux.git (fixes)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Mon, 03 Feb 2025 11:06:00 +0100 you wrote:
> > Make sure the compare value in the lr/sc loop is sign extended to match
> > what lr.w does.  Fortunately, due to the compiler keeping the register
> > contents sign extended anyway the lack of the explicit extension didn't
> > result in wrong code so far, but this cannot be relied upon.
> >
> > Fixes: b90edb33010b ("RISC-V: Add futex support.")
> > Signed-off-by: Andreas Schwab <schwab@suse.de>
> >
> > [...]
>
> Here is the summary with links:
>   - riscv/futex: sign extend compare value in atomic cmpxchg
>     https://git.kernel.org/riscv/c/5c238584bce5
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

I applied this patch, but it doesn't seem to take effect. There is no
sign extension for a2 in the assembly code. What did I miss?
GCC version >=3D 13.

ffffffff800e87e0 <futex_atomic_cmpxchg_inatomic>:
ffffffff800e87e0: 1141                addi sp,sp,-16
ffffffff800e87e2: e422                sd s0,8(sp)
ffffffff800e87e4: 2bf01793          bseti a5,zero,0x3f
ffffffff800e87e8: 0800                addi s0,sp,16
ffffffff800e87ea: 17ed                addi a5,a5,-5
ffffffff800e87ec: 00b7f663          bgeu a5,a1,ffffffff800e87f8
<futex_atomic_cmpxchg_inatomic+0x18>
ffffffff800e87f0: 6422                ld s0,8(sp)
ffffffff800e87f2: 5549                li a0,-14
ffffffff800e87f4: 0141                addi sp,sp,16
ffffffff800e87f6: 8082                ret
ffffffff800e87f8: 872a                mv a4,a0
ffffffff800e87fa: 00040837          lui a6,0x40
ffffffff800e87fe: 10082073          csrs sstatus,a6
ffffffff800e8802: 4781                li a5,0
ffffffff800e8804: 1605a8af          lr.w.aqrl a7,(a1)
ffffffff800e8808: 00c89563          bne a7,a2,ffffffff800e8812
<futex_atomic_cmpxchg_inatomic+0x32>
ffffffff800e880c: 1ed5a52f          sc.w.aqrl a0,a3,(a1)
ffffffff800e8810: f975                bnez a0,ffffffff800e8804
<futex_atomic_cmpxchg_inatomic+0x24>
ffffffff800e8812: 0007851b          sext.w a0,a5
ffffffff800e8816: 10083073          csrc sstatus,a6
ffffffff800e881a: 01172023          sw a7,0(a4)
ffffffff800e881e: 6422                ld s0,8(sp)
ffffffff800e8820: 0141                addi sp,sp,16
ffffffff800e8822: 8082                ret

Should we do it like this:
__asm__ __volatile__ (
" sext.w %[ov], %[ov] \n"
...


Thanks,
Yunhui

