Return-Path: <linux-kernel+bounces-514406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA8DA356B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5673ACF43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1891DB924;
	Fri, 14 Feb 2025 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="l0fXq3aj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075861DA2E5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513110; cv=none; b=WSEQ0+IlNIOj8kBpm3aFscn1ysIVcEhs0+2Rd+4eUtoCvI/8cd621TtTB8CdRJc0dwPszjiKn/G6KxhvMSYRpvHByL806crziWs89qTQ/aeaMQSbW9IJqx6BhnuISSLqoAmd10Sk+yVS7Ye9m7ZX5y5uIjzx1mg1a6l6XU9+CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513110; c=relaxed/simple;
	bh=ndId1pfdmdppe+vinRGhG7FPx1KDq7IukSOVgVM2E04=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kwdaBdJ5rBlOJwcYqJbxEEal/7jsQUMb7ZuMCXKiRFytu9RXZAUpM/cpS8l1t5G72WgqcXBZHYLxXAq98og+YgHmn70IHZEotkRrCGjy+s4eYY3ry1Oi4gFCAGpNsUIdgzfmIXvZASQzn9DhHsdxnoUEOgaubEkgIbBL0xMD6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=l0fXq3aj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so285349f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1739513106; x=1740117906; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GL1+uMNBu0SazZFpMvaXEzpnl+GmzSPEG+r8Eq9ugU=;
        b=l0fXq3ajdw/Tvtp14ONsc6Rw4Xt7EaJRcJNmTBdSdQt4jyt/+gY0ftLeOU3ZMnXbw1
         BPLgzeebqbgGDKQmyN7Q6uQn82mD9Vf3FLu189jqf7jCXTJTagAE2y0glJ+XaMOrzduk
         z/oSs1wX+VjHR9OrK/0yHq4kP0GCVMOTXK8xqGAOAX8YlfkAdB45wOk6uT+u83xpZXhH
         LEV4jLpPH6gR8ck1nl0spOEIf8Tu2ytNpXjDOb4C+bZ/4TGb7j25yv/MR55Pr92q/2Ix
         X4RfYeuOYObnKdxUkmtLCy0HfZF4uzuZAvaA4uhPpWIxdxFQcAt2itoJoghTnkKNywqc
         jhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513106; x=1740117906;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GL1+uMNBu0SazZFpMvaXEzpnl+GmzSPEG+r8Eq9ugU=;
        b=dGnr6P2vw5gR0/Zd6F9mTtYBoP5lqNhZoF+7Fdy61JQbuT54QCuHfRnxp3eqPL7/kS
         xzxAzBGB/LqydgGKNbQpC+YsE6F0V+C9SHLqIYY+NXyDUNoc7qaks+S5D1b7D+JUfak0
         outkBb9soiKdzT4oDXp34EO+iqnPLyUbZd2bOUdATN4hS5YjkJuFqd9MyG2S7HUwKiUW
         HAXEfqV7bdEnkgzFXYVckfwu3ajaAan4kC72LkJis/QZ1m1j481CEyjv/OyFSBQS+3/Z
         Dh0fp5uwUhlauNp6SMxfQusKcpqy9T8UKP7SHLu51/M9DBNskD0HSXW3KvKmA9V36SKy
         hLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJmA1KVXRrZ5nYaWwXL1GOlTFyp6TxLMEX82QRYso/PMJiy9261GdGPTz9nRiGuuaQxTB0c9e3IujbFdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucN29Ta0uGdVQpQ3oO0rmkyRPJY7hZLf36YXJpul28Ni3SzFw
	OUJwOhBQrfKHZm8DMNiwiHR1MY7iBWMUsZTgBpI8hsv/6lrEcm4B9+HRHc1P9WI=
X-Gm-Gg: ASbGncvUX6fM0Xco5TvnkOYmUE37nFVl6AagZMyB2B4lZ+tFyW0mdgZZJYWDcP9Ubr8
	MlQZdVvYjbqYuWQ18u6I8cX1l1ulGIcEv1bpqek7+fuxn3X5gzRm0Y3XZBKaNbJZxQOPBL0v7CH
	KZzNFZ8lUuUt/gNLYf8WajybsT8E5zX0JuTQg/XPqmpGKoODuMFOOhArCpYih8E5BJvooJkPqGz
	CGVCW/ggIY6COnWGAq1fcsjRqpcPC9d6jW+00nfRSQohkDFO4aJujkcT3PcpMlhZ0DWPB00ELFG
	gghbgZTgTe62AuJQfGqx7/ywN6ps
X-Google-Smtp-Source: AGHT+IHd25u3Q2I6jS80Y+yh5R9GFpw15aq+J7xqJ2e+hhm2TKf+u8x4399qIS2YV+1Txeq2km5rqw==
X-Received: by 2002:a5d:5987:0:b0:38f:2401:a6a6 with SMTP id ffacd0b85a97d-38f2401a738mr6402658f8f.12.1739513106090;
        Thu, 13 Feb 2025 22:05:06 -0800 (PST)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b431fsm3657389f8f.2.2025.02.13.22.05.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:05:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [External] [PATCH] riscv/futex: sign extend compare value in
 atomic cmpxchg
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAEEQ3wmH9MCYCfLL4Q7R7BHWbiQso+xr=zjhizY+kA5xtNzEzw@mail.gmail.com>
Date: Fri, 14 Feb 2025 06:04:53 +0000
Cc: patchwork-bot+linux-riscv@kernel.org,
 Andreas Schwab <schwab@suse.de>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C823738D-8FE1-4746-A8CF-627DFB596365@jrtc27.com>
References: <mvmfrkv2vhz.fsf@suse.de>
 <173947144178.1330575.8179936961826705707.git-patchwork-notify@kernel.org>
 <CAEEQ3wmH9MCYCfLL4Q7R7BHWbiQso+xr=zjhizY+kA5xtNzEzw@mail.gmail.com>
To: yunhui cui <cuiyunhui@bytedance.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

On 14 Feb 2025, at 04:11, yunhui cui <cuiyunhui@bytedance.com> wrote:
>=20
> Hi,
>=20
> On Fri, Feb 14, 2025 at 2:31=E2=80=AFAM =
<patchwork-bot+linux-riscv@kernel.org> wrote:
>>=20
>> Hello:
>>=20
>> This patch was applied to riscv/linux.git (fixes)
>> by Palmer Dabbelt <palmer@rivosinc.com>:
>>=20
>> On Mon, 03 Feb 2025 11:06:00 +0100 you wrote:
>>> Make sure the compare value in the lr/sc loop is sign extended to =
match
>>> what lr.w does.  Fortunately, due to the compiler keeping the =
register
>>> contents sign extended anyway the lack of the explicit extension =
didn't
>>> result in wrong code so far, but this cannot be relied upon.
>>>=20
>>> Fixes: b90edb33010b ("RISC-V: Add futex support.")
>>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>>>=20
>>> [...]
>>=20
>> Here is the summary with links:
>>  - riscv/futex: sign extend compare value in atomic cmpxchg
>>    https://git.kernel.org/riscv/c/5c238584bce5
>>=20
>> You are awesome, thank you!
>> --
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>=20
>>=20
>=20
> I applied this patch, but it doesn't seem to take effect. There is no
> sign extension for a2 in the assembly code. What did I miss?
> GCC version >=3D 13.
>=20
> ffffffff800e87e0 <futex_atomic_cmpxchg_inatomic>:
> ffffffff800e87e0: 1141                addi sp,sp,-16
> ffffffff800e87e2: e422                sd s0,8(sp)
> ffffffff800e87e4: 2bf01793          bseti a5,zero,0x3f
> ffffffff800e87e8: 0800                addi s0,sp,16
> ffffffff800e87ea: 17ed                addi a5,a5,-5
> ffffffff800e87ec: 00b7f663          bgeu a5,a1,ffffffff800e87f8
> <futex_atomic_cmpxchg_inatomic+0x18>
> ffffffff800e87f0: 6422                ld s0,8(sp)
> ffffffff800e87f2: 5549                li a0,-14
> ffffffff800e87f4: 0141                addi sp,sp,16
> ffffffff800e87f6: 8082                ret
> ffffffff800e87f8: 872a                mv a4,a0
> ffffffff800e87fa: 00040837          lui a6,0x40
> ffffffff800e87fe: 10082073          csrs sstatus,a6
> ffffffff800e8802: 4781                li a5,0
> ffffffff800e8804: 1605a8af          lr.w.aqrl a7,(a1)
> ffffffff800e8808: 00c89563          bne a7,a2,ffffffff800e8812
> <futex_atomic_cmpxchg_inatomic+0x32>
> ffffffff800e880c: 1ed5a52f          sc.w.aqrl a0,a3,(a1)
> ffffffff800e8810: f975                bnez a0,ffffffff800e8804
> <futex_atomic_cmpxchg_inatomic+0x24>
> ffffffff800e8812: 0007851b          sext.w a0,a5
> ffffffff800e8816: 10083073          csrc sstatus,a6
> ffffffff800e881a: 01172023          sw a7,0(a4)
> ffffffff800e881e: 6422                ld s0,8(sp)
> ffffffff800e8820: 0141                addi sp,sp,16
> ffffffff800e8822: 8082                ret

The calling convention means a2 will be sign-extended on entry to the
function, and since your compiler has not done anything to change the
value that will still be true. So it has (legitimately) optimised out
any sign extension as a no-op. Are you seeing any problems that you
believe to be caused by this function, or are you just inspecting the
disassembly to satisfy your own curiosity?

> Should we do it like this:
> __asm__ __volatile__ (
> " sext.w %[ov], %[ov] \n"
> ...

No, it=E2=80=99s unnecessary and prevents optimisation.

Jess

> Thanks,
> Yunhui
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


