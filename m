Return-Path: <linux-kernel+bounces-371464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F049A3B68
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C11B1F266E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E24202628;
	Fri, 18 Oct 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzJY4w50"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36D201102
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246966; cv=none; b=SSk2G/ZFVf61gnZ65AloBqu/RjhFlltuATHN7SiutCzjx2u29H6jGkznchw9NRmh4is2S797OFpUVTZe1CV/VMbWmAAgM7VSgaI5P7h1tUUnJD1fsjUB1VFksBkLU5PMiUreL+oBkFX391KXLNbZ3r+65M3eo95nfstBqFHKrNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246966; c=relaxed/simple;
	bh=hENYqMpWSl5cgEjc9ivpwcBWhkrp3Y1gODvqXV+r5zM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIeiKKDGkc1kN4kHZ7d6I5bi0FgDx5cZnREuqlwR/Z5oUJBgO2QouG1H9a4kji+xaQOoXMz7wbIwkJ9epw3URvbIRTTb/vMG2tlOSGqix0RNRxaiTDRMkrG84UV816oyc/6r0FjEL1H/iPqvD1/Rk+MFJ9iESwxyfF68uxykwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MzJY4w50; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so1424375f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729246962; x=1729851762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvdD1zvR7pitmvPu5UIzdTzIQaO+R+2TKdsKCLTLB+w=;
        b=MzJY4w50YOoZHYWUPDT4vttN1/KeUx9EFHhvPltq6TCzvafCYm5YM6wEYFU8skwbGN
         a6c9S4O+oEubCCIg2DXWXnHbgi+Olb/SZ5RKu50yQ4qoe8oevYdy4WozhbtByhMkcTig
         t9oYuNF20aZRX+M7itwHJfT5lVbVc/kX5R8RiFoiSPaRZ38NIUpYzBBYm41tOUTpfxOV
         Cb9+tZlbnyhXSC8cqYDo/wOvlis+y47JGPVy0yB60CmJ1AID3Iigb/2iElgs7tphI5+X
         qDQMmxA/E8t8TA1vdK82yDVjFVKF5Fshgtv84bqmK5l0y6Z3hTFZWTE4+7qqqZxmmzSC
         +KWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246962; x=1729851762;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JvdD1zvR7pitmvPu5UIzdTzIQaO+R+2TKdsKCLTLB+w=;
        b=f+dQr42MchRyq93G5ty8biP800TtmdfZ7vP/Ht+bpGr7ZFTM+ud+a/yI9UC/pf+fkY
         6fEV9q7T6+ZJt3st7Jf5VGUytGL6sPAsqKGOCIq+6EGDnC5AerPxbnIx6beH0v1JGiY9
         +pEbkwMrkFz6PLjWF/qQCpAni58FXw3S6v9pHRJ9TTf6F+/cf8D/p77lQCYwneD1vWaH
         /FFPLqg1OeQE9k9QV//bzDFWr0t3mmV0sVUuALz5en5BtLqaOWvyq6BIhh989j+06oaB
         mh2bQEI7gtaXO5kZq8Uu5gMR0ymfaJe/wKnypgZFP+Qlt8bycg4n3YoQ8QawU/gxPdFf
         LgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFqA09qApGKI6iQlqHqCBbX9uUBQ9SDcBpA8esEgpog72VQtgObiOGFr0w3JcYiv0I1W8OsPIzimMg1qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnj81t9TUX22muLzyoyVtKde8fQ2ajYSlSLRoFtD3VrJuZcSdQ
	ScArltxlCoNI8UGgmwP9tw52P6DiCsSGJ2uvqypGBGg1txzvtod2JeYW+DERR6k=
X-Google-Smtp-Source: AGHT+IHCQcQAOeIFmFjqShlV5pLAgzEU9dc7dJq9mnMndfU3VrQtYqTb6xx9TFAcF6AySuy6pyE1wQ==
X-Received: by 2002:a5d:63c8:0:b0:37c:d2ac:dd7d with SMTP id ffacd0b85a97d-37eb48937f9mr1160741f8f.30.1729246962430;
        Fri, 18 Oct 2024 03:22:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed5a5sm1543061f8f.74.2024.10.18.03.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:22:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 18E825F863;
	Fri, 18 Oct 2024 11:22:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,  open list
 <linux-kernel@vger.kernel.org>,  Linux ARM
 <linux-arm-kernel@lists.infradead.org>,  qemu-devel@nongnu.org,
  lkft-triage@lists.linaro.org,  Linux Regressions
 <regressions@lists.linux.dev>,  Catalin Marinas <catalin.marinas@arm.com>,
  Mark Brown <broonie@kernel.org>,  Anders Roxell
 <anders.roxell@linaro.org>,  Arnd Bergmann <arnd@arndb.de>,  Dan Carpenter
 <dan.carpenter@linaro.org>,  Aishwarya TCV <aishwarya.tcv@arm.com>,
  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
In-Reply-To: <CAFEAcA-39GRpvy5LOZSJL3=9FMspAq9c8GUtHv9CP4jU2uFi1w@mail.gmail.com>
	(Peter Maydell's message of "Fri, 18 Oct 2024 10:48:02 +0100")
References: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
	<871q0daglh.fsf@draig.linaro.org>
	<CAFEAcA-39GRpvy5LOZSJL3=9FMspAq9c8GUtHv9CP4jU2uFi1w@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 18 Oct 2024 11:22:41 +0100
Message-ID: <87jze590cu.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 18 Oct 2024 at 10:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Naresh Kamboju <naresh.kamboju@linaro.org> writes:
>>
>> > The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
>> > The boot log is incomplete, and no kernel crash was detected.
>> > However, the system did not proceed far enough to reach the login prom=
pt.
>> >
>> > Please find the incomplete boot log links below for your reference.
>> > The Qemu version is 9.0.2.
>> > The arm64 devices boot pass.
>>
>> Can confirm it also fails on the current master of QEMU:
>>
>>   #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=
=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
>>   #1  0x00007ffff4a3ae9f in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at ./nptl/pthread_kill.c:78
>>   #2  0x00007ffff49ebfb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysde=
ps/posix/raise.c:26
>>   #3  0x00007ffff49d6472 in __GI_abort () at ./stdlib/abort.c:79
>>   #4  0x00007ffff6e47ec8 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>>   #5  0x00007ffff6ea7e1a in g_assertion_message_expr () at /lib/x86_64-l=
inux-gnu/libglib-2.0.so.0
>>   #6  0x0000555555f45732 in regime_is_user (env=3D0x555557f805f0, mmu_id=
x=3DARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
>>   #7  0x0000555555f5b0f1 in aa64_va_parameters (env=3D0x555557f805f0, va=
=3D18446744073709551615, mmu_idx=3DARMMMUIdx_E10_0, data=3Dtrue, el1_is_aa3=
2=3Dfalse)
>>       at ../../target/arm/helper.c:12048
>>   #8  0x0000555555f4e3e5 in tlbi_aa64_get_range (env=3D0x555557f805f0, m=
muidx=3DARMMMUIdx_E10_0, value=3D107271103184929) at ../../target/arm/helpe=
r.c:5214
>
> I investigated this yesterday when Catalin reported it
> and sent a patch:
> https://patchew.org/QEMU/20241017172331.822587-1-peter.maydell@linaro.org/

And here was I thinking I was being efficient ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

