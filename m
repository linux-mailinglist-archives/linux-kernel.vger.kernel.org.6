Return-Path: <linux-kernel+bounces-514495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7EEA357B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A67188F549
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8EB200B8A;
	Fri, 14 Feb 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="Tek5H8Vo"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7113A3EC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517453; cv=none; b=G50ZVQEaoC4H8rQ1u7dyYDUbgsR3pwC8Rqmq7n3JgeuxBIqqJnGTQ0jKtYc7dQFkCByUBZtvOW0X/zkLw5uWMSGeevD3QLrOjCkrxv/Uni7NSE2LiyeMdLgReV/ArePt3wLVK6T8l7bQlzfBWB4E0UODgemiq29q80UFfS2HAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517453; c=relaxed/simple;
	bh=kcwmQi/xrmVqUYXZRm/Fr4RRXKWJ630VHeb11bmqOA8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gd/O129cNo7uqtH/IwQcF7b9SCl+gGTTI1Je1S1YlpO0YvnsHCR5K3YfSZRY0z/sioKwQW5JXyC2+BvhQfWyW+M5Y+wXZ8tXeCKaIeNSSFY6zc/OvclGnKUZ9vZz3+6ootFb/FOBXUGcYjjI26dyvZEH7g+0a+pR5SYHA9WN2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=Tek5H8Vo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f2f391864so74932f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1739517449; x=1740122249; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye1Tib2tWZsmW5zgjkgCTGuv6rt2ItTVWNUFGCvg7Oo=;
        b=Tek5H8Voy8Pry1MClCbmtQ59Uyzk6LO3NpHBgvqFjrT72hk1qk8OJTU6e1DroIksoq
         YZW42QXD3ZAaoM/UAIDU7IbVy8y4duRHsDECwLv+EY0n5Ii7YeiknaOakHnnqbyGChSM
         w5I7JW+PSwIMg86u8DQGyDCzaWK4/f+TUk5XumNMeGuQzwP27EkGNmfY2/mJdeM5hwG7
         Qh8nNixJC/pWhbupZQcVkLZhpPg25IhI83W1+h6Rgn+Ah8Uo10nkvX5epPgkX2bkNmFP
         7G9G7FHIGbS7ru0Bk9H4TIM3MtcroUfWcu/+uFwAPGkYkkkPpJIeJ2quXsUZDLgrJW+J
         lWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517449; x=1740122249;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ye1Tib2tWZsmW5zgjkgCTGuv6rt2ItTVWNUFGCvg7Oo=;
        b=Bzh+jVkNO3ANG1KUfcmsnb8QYrQja9Q2Iftb2nQk/VWrSvr20FfGAX6PPhUSfH4JjD
         Jvja3L+cvarCsbSP0jRLFRlp5VBqBhI7xTj9uLf2gSHhkjXaSuT4vxxUadmYXEjIF3R1
         f9gyUR5Yt+kTqmclaWztWeKbNYl9XCpe0CXASGRwa+XomfIUPgVP6tLzMqoW3QTohEgH
         sJ6MJx2tE/HFHNNiCYfIitFfYWod3X7X1cY5r3etYk5dktHsASdKjtkIKN8dk/fm4+1R
         ASU3TICLQh1LRUmFtRQPb6BmszNyM/XabFq6WsW+MyWxHTRrWNv5g/QIlvBKNOSKuL6Z
         JwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRpFVm2gxxMdq1F7Ikz3XjaGsuXdebvGSKmhPqdVY/Y689wNGV6/BlXhl7eL7hjk2KDMdrQkJxPxnkrkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bWlYHBLmeassge/HyrV4Qq7WbKJ4Ulq2aVLqq9cfYwALWSMo
	5jgUH78JGFwo1nMJWstb20EKkhqGuT4V38A1bCDsrtr9Qx/h6wZKLC3MgioO4qEksad/lNRAIPb
	B
X-Gm-Gg: ASbGncvvdpIrIqIZLABNAOQnu88ScDbcInEJyDkUzGNaOpJGD4kIqtmcpnZhpJEfIO6
	SLqJdGNyDWlYenWB0owbGj9+82bkDBtzZYt7QnB+El83Z3P1EHYaF++nI6pRRNN9D63N2WfcC+T
	/L1GDyg0MZq92iFu6UZQukbpkZBEDWpaloQFGxnQPfMQYQUKplv0vd0Mnmf3taMRYNXZrX8FT/Q
	Jle27YXSttOLT+BJ5DqZdTMjYgnghocGcMchXeicscVEEvB1g7ns4Ink+8pQdQpXjg9G20wUxoK
	moLZr3oweqHjZ0kaEB3swmZfnt3r
X-Google-Smtp-Source: AGHT+IH98ED1MQt+kXTrn4TTyXkyr/3xZ2tT9bqpiZ9IBP0om1XAAVoZrIOrdex21cUxdQCa3hTSiQ==
X-Received: by 2002:a05:6000:2c2:b0:38d:d997:5233 with SMTP id ffacd0b85a97d-38dea2ee120mr11503405f8f.55.1739517449287;
        Thu, 13 Feb 2025 23:17:29 -0800 (PST)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fdb19sm3924429f8f.95.2025.02.13.23.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:17:28 -0800 (PST)
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
In-Reply-To: <CAEEQ3wmOUyV0Ys0Zd=hbWr8Jn2yAy+KwuJahEgNFky+my=7Mug@mail.gmail.com>
Date: Fri, 14 Feb 2025 07:17:18 +0000
Cc: patchwork-bot+linux-riscv@kernel.org,
 Andreas Schwab <schwab@suse.de>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F55E9AA-B57E-43B0-8C1E-1803343085A2@jrtc27.com>
References: <mvmfrkv2vhz.fsf@suse.de>
 <173947144178.1330575.8179936961826705707.git-patchwork-notify@kernel.org>
 <CAEEQ3wmH9MCYCfLL4Q7R7BHWbiQso+xr=zjhizY+kA5xtNzEzw@mail.gmail.com>
 <C823738D-8FE1-4746-A8CF-627DFB596365@jrtc27.com>
 <CAEEQ3wmOUyV0Ys0Zd=hbWr8Jn2yAy+KwuJahEgNFky+my=7Mug@mail.gmail.com>
To: yunhui cui <cuiyunhui@bytedance.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

On 14 Feb 2025, at 06:22, yunhui cui <cuiyunhui@bytedance.com> wrote:
>=20
> Hi Jess,
>=20
> On Fri, Feb 14, 2025 at 2:05=E2=80=AFPM Jessica Clarke =
<jrtc27@jrtc27.com> wrote:
>>=20
>> On 14 Feb 2025, at 04:11, yunhui cui <cuiyunhui@bytedance.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> On Fri, Feb 14, 2025 at 2:31=E2=80=AFAM =
<patchwork-bot+linux-riscv@kernel.org> wrote:
>>>>=20
>>>> Hello:
>>>>=20
>>>> This patch was applied to riscv/linux.git (fixes)
>>>> by Palmer Dabbelt <palmer@rivosinc.com>:
>>>>=20
>>>> On Mon, 03 Feb 2025 11:06:00 +0100 you wrote:
>>>>> Make sure the compare value in the lr/sc loop is sign extended to =
match
>>>>> what lr.w does.  Fortunately, due to the compiler keeping the =
register
>>>>> contents sign extended anyway the lack of the explicit extension =
didn't
>>>>> result in wrong code so far, but this cannot be relied upon.
>>>>>=20
>>>>> Fixes: b90edb33010b ("RISC-V: Add futex support.")
>>>>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>>>>>=20
>>>>> [...]
>>>>=20
>>>> Here is the summary with links:
>>>> - riscv/futex: sign extend compare value in atomic cmpxchg
>>>>   https://git.kernel.org/riscv/c/5c238584bce5
>>>>=20
>>>> You are awesome, thank you!
>>>> --
>>>> Deet-doot-dot, I am a bot.
>>>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>>>=20
>>>>=20
>>>=20
>>> I applied this patch, but it doesn't seem to take effect. There is =
no
>>> sign extension for a2 in the assembly code. What did I miss?
>>> GCC version >=3D 13.
>>>=20
>>> ffffffff800e87e0 <futex_atomic_cmpxchg_inatomic>:
>>> ffffffff800e87e0: 1141                addi sp,sp,-16
>>> ffffffff800e87e2: e422                sd s0,8(sp)
>>> ffffffff800e87e4: 2bf01793          bseti a5,zero,0x3f
>>> ffffffff800e87e8: 0800                addi s0,sp,16
>>> ffffffff800e87ea: 17ed                addi a5,a5,-5
>>> ffffffff800e87ec: 00b7f663          bgeu a5,a1,ffffffff800e87f8
>>> <futex_atomic_cmpxchg_inatomic+0x18>
>>> ffffffff800e87f0: 6422                ld s0,8(sp)
>>> ffffffff800e87f2: 5549                li a0,-14
>>> ffffffff800e87f4: 0141                addi sp,sp,16
>>> ffffffff800e87f6: 8082                ret
>>> ffffffff800e87f8: 872a                mv a4,a0
>>> ffffffff800e87fa: 00040837          lui a6,0x40
>>> ffffffff800e87fe: 10082073          csrs sstatus,a6
>>> ffffffff800e8802: 4781                li a5,0
>>> ffffffff800e8804: 1605a8af          lr.w.aqrl a7,(a1)
>>> ffffffff800e8808: 00c89563          bne a7,a2,ffffffff800e8812
>>> <futex_atomic_cmpxchg_inatomic+0x32>
>>> ffffffff800e880c: 1ed5a52f          sc.w.aqrl a0,a3,(a1)
>>> ffffffff800e8810: f975                bnez a0,ffffffff800e8804
>>> <futex_atomic_cmpxchg_inatomic+0x24>
>>> ffffffff800e8812: 0007851b          sext.w a0,a5
>>> ffffffff800e8816: 10083073          csrc sstatus,a6
>>> ffffffff800e881a: 01172023          sw a7,0(a4)
>>> ffffffff800e881e: 6422                ld s0,8(sp)
>>> ffffffff800e8820: 0141                addi sp,sp,16
>>> ffffffff800e8822: 8082                ret
>>=20
>> The calling convention means a2 will be sign-extended on entry to the
>> function, and since your compiler has not done anything to change the
>> value that will still be true. So it has (legitimately) optimised out
>> any sign extension as a no-op.
>=20
> If so, why this patch?

Because there are multiple ways in which compilers can emit code that
does not keep values sign-extended in registers within a function. The
calling convention only provides that guarantee on entry to a function
following the standard calling convention. In the specific instance of
compiling the version of Linux you are compiling with the kernel config
you are using and the precise compiler you are using, the patch happens
to not be needed for this snippet of the binary because the generated
code already has the sign-extended value in the register used. But just
because there are instances when the patch does nothing doesn=E2=80=99t =
mean
all instances are like that.

Jess

>> Are you seeing any problems that you
>> believe to be caused by this function, or are you just inspecting the
>> disassembly to satisfy your own curiosity?
>=20
> No actual problem traced here.
>=20
>=20
>>=20
>>> Should we do it like this:
>>> __asm__ __volatile__ (
>>> " sext.w %[ov], %[ov] \n"
>>> ...
>>=20
>> No, it=E2=80=99s unnecessary and prevents optimisation.
>>=20
>> Jess
>>=20
>>> Thanks,
>>> Yunhui
>>>=20
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>=20
>=20
> Thanks,
> Yunhui



