Return-Path: <linux-kernel+bounces-382141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4569B0A01
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB61F24D87
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF717DFE4;
	Fri, 25 Oct 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="G96IXDc6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CB21A4D0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873959; cv=none; b=N2o/QaHhfxGv5MSTY1heHSwyhUkJQl4cXIqSaJzrdvZa8Ahpxi9BflbMCDoJLcgKIFYHW0GAQMXRhFuncPKlTXKMgP5q1epZdMksXCmK/yWuF4+Ozedbj9dhtyx9c5o7cbp2YHoBQ6kwDuhAc2Gw9pUc/gr+SNBhkfgXBPSeWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873959; c=relaxed/simple;
	bh=lXeTo7Ai0eUmikHGglFs9Z6xKx+weNQarzYjxtYNU8s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Em3zukyB4cvY0qo4SGkaiyzsDwkaEjSjTE4+uDYD0V3PxvMPdpCXFNp8gr2MPyvs608Q/U3YfLuac9th6SdHzMJ46BXPICfxi48GbQyuAszNUsMRbs1+XeALjJeaKUwsg54rTGjvt8djds75bdipJOenn4xt9ZgbfCFAg55Spfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=G96IXDc6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316cce103dso28668175e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1729873956; x=1730478756; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXeTo7Ai0eUmikHGglFs9Z6xKx+weNQarzYjxtYNU8s=;
        b=G96IXDc6f6cwgtgof81zLaXFo5GpgHBftraFOGzG8BCkDJSHojyMiusWgIG7EbFYU+
         STqHo96sBbTMAWvicrKqeURx0L7YE5pUN7GeJ9q+TmIM5AVGEvlAcl3poq19EESg4QVm
         I/XC5z2h3jEm6Jdhe8lurfyPD6kSTh/YF+wKfTPTu7jQPpVH9JCfVSC+eMSdR/uip6NW
         Nrf2MsPu9V4HblObn4mPDwq/BVV9pSCEZna4h60RSxJI1lTxR6X6+QdnsxHLK1wkqyOs
         BeRIIiE4TjpvmyQlqmggzsO0nL3ftwClp6uNyhW8Xs7FB5Gov6zcb6hlciMZb9b6bI3f
         fZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873956; x=1730478756;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXeTo7Ai0eUmikHGglFs9Z6xKx+weNQarzYjxtYNU8s=;
        b=lTAClVT/NFIMibJzIPDeUteGlZ7V8v64eH8w44JWPu/r5p4YMc+7RNfDcPso4z33oc
         +50+yW5hR00CWu83j/40wBrDhh4hFbqdIyQhIxh/91uURk/uT13fJ8gK2OdAM1mTNIZX
         NdggB1ZMsnVUi242ywUVOyj2dX80oNzQCgRqGR7mA+IOF3Z52mUjgM4foRFyT1EjmqCu
         RGpQxzb+8K8F8tmXzva1LJc6m0TLJHtSrgjf3hgaD66KBOEYi7bMcufp85bNp07OuBBV
         zJC1z/WAYr7eh2cKCgKezwKeALvM1TWcG8EWxSAkxsr2sKbCyPCd/1Aw9gbQzgEsFmo3
         HjGg==
X-Forwarded-Encrypted: i=1; AJvYcCVr1C63mnFuYBxqG2GCTZR+U18tmjz2M2l1SEkS3m46L8YpeOBwvVr0HL5IDwUTfSEq5n/LKZmg0OO0ED0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLPQpJsSvX8stD6t6dz5w2R3Spb5CKRCByi+hJMOGovvT1O/h
	iNvmYPrwkGPrwMZ1QhqbUM2PneG7V8lpFZIAhoPLjvJgqeQolj4rWVnK4vmJDNI=
X-Google-Smtp-Source: AGHT+IFzsde/CLy2eKazkH1v7HLp95coK36e2ucRf+AtuaN3885jE1bDkPSHOXdWnud0uPfx4xpq7A==
X-Received: by 2002:a05:600c:1c92:b0:431:604d:b22 with SMTP id 5b1f17b1804b1-4318421133amr122043805e9.16.1729873955703;
        Fri, 25 Oct 2024 09:32:35 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360cc2esm22175455e9.44.2024.10.25.09.32.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:32:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] RISC-V: Enable Zicbom in usermode
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20241025-puritan-sank-b8a828ef5872@spud>
Date: Fri, 25 Oct 2024 17:32:24 +0100
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
 punit.agrawal@bytedance.com,
 paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 cleger@rivosinc.com,
 charlie@rivosinc.com,
 evan@rivosinc.com,
 samuel.holland@sifive.com,
 andybnac@gmail.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CCBB0AB-169D-4677-9A44-53E4148908D5@jrtc27.com>
References: <20241025091527.57825-1-cuiyunhui@bytedance.com>
 <20241025-puritan-sank-b8a828ef5872@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

On 25 Oct 2024, at 11:16, Conor Dooley <conor@kernel.org> wrote:
> On Fri, Oct 25, 2024 at 05:15:27PM +0800, Yunhui Cui wrote:
>> Like Zicboz, by enabling the corresponding bits of senvcfg,
>> the instructions cbo.clean, cbo.flush, and cbo.inval can be
>> executed normally in user mode.
>>=20
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>> arch/riscv/kernel/cpufeature.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/riscv/kernel/cpufeature.c =
b/arch/riscv/kernel/cpufeature.c
>> index 1992ea64786e..bc850518ab41 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -924,7 +924,7 @@ unsigned long riscv_get_elf_hwcap(void)
>> void __init riscv_user_isa_enable(void)
>> {
>> if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>> - current->thread.envcfg |=3D ENVCFG_CBZE;
>> + current->thread.envcfg |=3D ENVCFG_CBIE | ENVCFG_CBCFE | =
ENVCFG_CBZE;
>=20
> I believe we previously decided that userspace should not be allowed =
to
> use zicbom, but that not withstanding - this is wrong. It should be
> checking for Zicbom, not Zicboz.

Allowing clean/flush is safe but has the same problems as fence.i with
regards to migrating between harts. Allowing invalidate, unless mapped
to flush, is not safe in general unless the kernel does a lot of
flushing to avoid userspace accessing data it shouldn=E2=80=99t be able =
to see.

Also, ENVCFG_CBIE is a mask for a multi-bit field, which happens to
have the same value as ENVCFG_CBIE_INV (i.e. really is making cbo.inval
be an invalidate). I note that the KVM code, which this likely copied
from(?), makes the same mistake, but there that is the intended
behaviour, if misleading about what the field really is.

So, with suitable caveats, allowing clean/flush could be a reasonable
thing to do (maybe useful for userspace drivers so long as they pin
themselves to a specific hart?), but invalidate should only ever be
allowed if mapped to flush.

Jess


