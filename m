Return-Path: <linux-kernel+bounces-514436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFFCA35700
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534197A58B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67591FFC61;
	Fri, 14 Feb 2025 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CLzH2AJv"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F11FFC53
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514186; cv=none; b=KjSoxGuZY4JzPxMHXVA9TXYvt9cbPASPkHd3K5QrYOyk6ZoZKJFBLtDQ8vWfL9osoeYukftfdsXrD8zMusDvONxauVmgAK8MvH9Rw93DB2S6cYiOyZEci233a8bTU0z94vTh/q2VHySqjOg3uYk7DeVSYtpZ4Zd4zD8AO4JQFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514186; c=relaxed/simple;
	bh=hvN7KAYmMlbkhSNl1XM8p0Sahtql1uTwKiaIiqW305g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAdCQWDioztONw0dE2MCBHdAUUHfXsCFDQva0IQPAueKqOcULy57tVLl/OF916mQf0bi1Vp9NHNdvik2S93jPj0CH/5++asI1Wx71DPyoK9ukA84AlVZmFkx5YQiL3UOhf9SPD2EkE91tps8zF8hrJznAlH9r8tXZnOtUbOaR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CLzH2AJv; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b5acf00c5bso784860fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739514184; x=1740118984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrLjx8sI4ymiLiWAMLyA4Ul5aLiPri1Yvb0JU43eu3c=;
        b=CLzH2AJvH+Q0CKkSoD8RMAi7txSN/SUwg3ECEip9K3/WHTsI3vP+nZZ7Vx8MygkA97
         2gTgLqEYj5hHH+f7K4MezJFNlKnlDGkSA9aK0XJBu9P+peN7nC4uy+bVNFO7KPD+fETI
         fzBrHTp40+qpgZmG7J54mZOZkb/z31hR63g/sIPDWPQhLtkRCNUhf0LloKWrmenwYnK2
         QAqPr02AiaN4UlMi1S1sAKNg2ar/0V0rTMcdV3paFGxCwx+sfCS90xI8lOGrLh87Pr4F
         ePYOCy/j9XI/4aVWdMz1a40NpSjmLqMoG5VgT7N8p2+yeStpwb5aHxIMbvpue4hlnRwF
         H1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514184; x=1740118984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrLjx8sI4ymiLiWAMLyA4Ul5aLiPri1Yvb0JU43eu3c=;
        b=wgUWc7ezn7S9rwGozhiOc8iRy0LI47N0yY6DVYctHV0djK+QJpCqBFmBtd6EMZr7C0
         sE+yVV9e8mtlPtKoY/EJW082Qavy50c9VcOLNE9vOOAGmvehQdQs/MA0wj0XZ84KsE3D
         lg4pw4NN/oVyJSp0JC29HGnKlJK9N7iDSKQAqI9TS9I2I+BcRDLUKIevUoeIn4w2z2jI
         UXqpNEcl8q04IsejMhSS/fI2hsTsgkQtVljt6kleaDml/MJktYW8uaWeVf7CMcn76XmJ
         8S5tjm0ik6CdLGaYVWNYg2dCOQzb1xsDzeJWNJgpEwLToIhGMC+p5MDRWN4BhNBjyhH/
         zP2A==
X-Forwarded-Encrypted: i=1; AJvYcCUEY+nM8XK9FbayPdJu/VOTciha8eMhdV9r3E5l5olzhu6bRJinmme7C4IZUwTC0ZgRKP+qOrirtdkLk6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGU8rq483hKHEVonJPUy2OF65uS5R4cLsCeI8qiMKsvfqvXixx
	NoS32VFP8KkYXF+MX65ZmcwqjZj6HcKNgvU63IFRTc6WrBETqBXAVjAVPuAe9PyDcLiPO8Xa3xi
	zn7u6pQj1oUTrvBOfnbzP0VFPhGeVJ4twnfh4dQ==
X-Gm-Gg: ASbGncuCLC4vxGDk/LobHm+fvmVa0ugTciTUXgaZOEtObpY+zYuwG6eRr4S2RLBW5ED
	QeQe0wjbq3IPkr8qqSCX20yJiJXlvaca6siHmta605qMZoc6p3weg8jrnSNogkwz1LTR+PjdQ+r
	dsoapJzzpiESqO7g==
X-Google-Smtp-Source: AGHT+IE4605vlHn1zIiQxF2f4ULWyjpbrJ1xQMN1h89Q/8aWkSJ7Lcxw52Cxk+fp5fIwgc5uTBVQJlRTbwXkv6S+Mzo=
X-Received: by 2002:a05:6871:7bc3:b0:2a3:c59f:4cba with SMTP id
 586e51a60fabf-2b8d659ba31mr5912550fac.17.1739514183816; Thu, 13 Feb 2025
 22:23:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mvmfrkv2vhz.fsf@suse.de> <173947144178.1330575.8179936961826705707.git-patchwork-notify@kernel.org>
 <CAEEQ3wmH9MCYCfLL4Q7R7BHWbiQso+xr=zjhizY+kA5xtNzEzw@mail.gmail.com> <C823738D-8FE1-4746-A8CF-627DFB596365@jrtc27.com>
In-Reply-To: <C823738D-8FE1-4746-A8CF-627DFB596365@jrtc27.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 14 Feb 2025 14:22:53 +0800
X-Gm-Features: AWEUYZn0iPKwrupWFG1GQNOwWt9ZWfpFLI7RdTf22_lZfp97wOBoYspyknLWZUE
Message-ID: <CAEEQ3wmOUyV0Ys0Zd=hbWr8Jn2yAy+KwuJahEgNFky+my=7Mug@mail.gmail.com>
Subject: Re: [External] [PATCH] riscv/futex: sign extend compare value in
 atomic cmpxchg
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: patchwork-bot+linux-riscv@kernel.org, Andreas Schwab <schwab@suse.de>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jess,

On Fri, Feb 14, 2025 at 2:05=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 14 Feb 2025, at 04:11, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >
> > Hi,
> >
> > On Fri, Feb 14, 2025 at 2:31=E2=80=AFAM <patchwork-bot+linux-riscv@kern=
el.org> wrote:
> >>
> >> Hello:
> >>
> >> This patch was applied to riscv/linux.git (fixes)
> >> by Palmer Dabbelt <palmer@rivosinc.com>:
> >>
> >> On Mon, 03 Feb 2025 11:06:00 +0100 you wrote:
> >>> Make sure the compare value in the lr/sc loop is sign extended to mat=
ch
> >>> what lr.w does.  Fortunately, due to the compiler keeping the registe=
r
> >>> contents sign extended anyway the lack of the explicit extension didn=
't
> >>> result in wrong code so far, but this cannot be relied upon.
> >>>
> >>> Fixes: b90edb33010b ("RISC-V: Add futex support.")
> >>> Signed-off-by: Andreas Schwab <schwab@suse.de>
> >>>
> >>> [...]
> >>
> >> Here is the summary with links:
> >>  - riscv/futex: sign extend compare value in atomic cmpxchg
> >>    https://git.kernel.org/riscv/c/5c238584bce5
> >>
> >> You are awesome, thank you!
> >> --
> >> Deet-doot-dot, I am a bot.
> >> https://korg.docs.kernel.org/patchwork/pwbot.html
> >>
> >>
> >
> > I applied this patch, but it doesn't seem to take effect. There is no
> > sign extension for a2 in the assembly code. What did I miss?
> > GCC version >=3D 13.
> >
> > ffffffff800e87e0 <futex_atomic_cmpxchg_inatomic>:
> > ffffffff800e87e0: 1141                addi sp,sp,-16
> > ffffffff800e87e2: e422                sd s0,8(sp)
> > ffffffff800e87e4: 2bf01793          bseti a5,zero,0x3f
> > ffffffff800e87e8: 0800                addi s0,sp,16
> > ffffffff800e87ea: 17ed                addi a5,a5,-5
> > ffffffff800e87ec: 00b7f663          bgeu a5,a1,ffffffff800e87f8
> > <futex_atomic_cmpxchg_inatomic+0x18>
> > ffffffff800e87f0: 6422                ld s0,8(sp)
> > ffffffff800e87f2: 5549                li a0,-14
> > ffffffff800e87f4: 0141                addi sp,sp,16
> > ffffffff800e87f6: 8082                ret
> > ffffffff800e87f8: 872a                mv a4,a0
> > ffffffff800e87fa: 00040837          lui a6,0x40
> > ffffffff800e87fe: 10082073          csrs sstatus,a6
> > ffffffff800e8802: 4781                li a5,0
> > ffffffff800e8804: 1605a8af          lr.w.aqrl a7,(a1)
> > ffffffff800e8808: 00c89563          bne a7,a2,ffffffff800e8812
> > <futex_atomic_cmpxchg_inatomic+0x32>
> > ffffffff800e880c: 1ed5a52f          sc.w.aqrl a0,a3,(a1)
> > ffffffff800e8810: f975                bnez a0,ffffffff800e8804
> > <futex_atomic_cmpxchg_inatomic+0x24>
> > ffffffff800e8812: 0007851b          sext.w a0,a5
> > ffffffff800e8816: 10083073          csrc sstatus,a6
> > ffffffff800e881a: 01172023          sw a7,0(a4)
> > ffffffff800e881e: 6422                ld s0,8(sp)
> > ffffffff800e8820: 0141                addi sp,sp,16
> > ffffffff800e8822: 8082                ret
>
> The calling convention means a2 will be sign-extended on entry to the
> function, and since your compiler has not done anything to change the
> value that will still be true. So it has (legitimately) optimised out
> any sign extension as a no-op.

 If so, why this patch?

> Are you seeing any problems that you
> believe to be caused by this function, or are you just inspecting the
> disassembly to satisfy your own curiosity?

No actual problem traced here.


>
> > Should we do it like this:
> > __asm__ __volatile__ (
> > " sext.w %[ov], %[ov] \n"
> > ...
>
> No, it=E2=80=99s unnecessary and prevents optimisation.
>
> Jess
>
> > Thanks,
> > Yunhui
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

Thanks,
Yunhui

