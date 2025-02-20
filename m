Return-Path: <linux-kernel+bounces-523222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59DFA3D3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33D03BD741
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324831EDA09;
	Thu, 20 Feb 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ibRQdlT7"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7A1EBFFD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041411; cv=none; b=LdQBLeH13HePVXyj7lmXQnSEVGjomJU9tRDlgDeDt+Ccokswq5rhbiovt9CsIFJ00PA2+TBTHZ5h9G5VIrYJlfYpoG/4KKGZ4Vl+ZvkMRzMD+NINDEaGAYh0v2Hd//klERvc7HZQMR9dEVnYapBJa2WqvaQjVQpoxzieBSz3QiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041411; c=relaxed/simple;
	bh=GgaM6vvIOpqR7NE3Jr5ncvGl66QjYPZHcGTUZgOMyR8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eh5Y8TEMKFIWep7ttGPt+SGLQaEDqHifO/2hWdgtg0yqK2u6EpTbTLITZWUb/R/ipwyNCRLqynqTYHhp2+2SNDm1ilEwozAPptTmsdxtZNeISQbTqXb8MMKWp5wt0dKLSwekJpqyn+HlatLAkvaSp7Vd7gk2p+QS1WhWJ2zOSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ibRQdlT7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439990502bdso896335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740041408; x=1740646208; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4cSnvn9ljr1+95vro6JQ9OboRp/UL3qAMCfprqMPPM=;
        b=ibRQdlT7UpoqfFO6a0krzGXimdbtF2N28m2BNujdnNIWSNpIObUg7Wf3TNeIp8sUMh
         zG2p6/vMw1wSlTAjqx7YcXABJPXQxmwLXVSILL8D3jI4gTfz6AdT/T8tu2oOTE+rAZn6
         f6cShWOzYuKZlwl2bEzZWoVwlsn5KyQoMi+/MhF/Li4phLTLn+2ScRG/woXuvX2QirF0
         Hg57p0/yzU6O87CqInpeAi3ZQhdr1mEMwYCDqNGl1J98nULLRvJ636Lic76Oe9/hzfJJ
         85jYqjnINNIpMw0bnA5LqOuPrb78hce44xb68eabcQp/I3gzITITH83COahMiZo+bICA
         X17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041408; x=1740646208;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X4cSnvn9ljr1+95vro6JQ9OboRp/UL3qAMCfprqMPPM=;
        b=W0MROk9/psv3cSuGfpd3aF6mbqqQdLQ6q156J4lKP8kNdZjRKmz1bmqsGgs84Qv5z2
         4xj43k8/1c/LL6bJN43aREi6TTcmn/QgvJu26epnb5aBRFFRjdPKjOvN1i/m1XWyAfjV
         L6qlGAOapDJoTOXyea2xjKmvsS39POpsxBE+n3BZ3aXTxvItUpIJTewY/SXR8AHtC7CV
         nG5IAsgo14ZamcAlo8+r1Td0qjHGARrZmNvdJWd6fH1tHV+i4khDIKprjwyDHOnYffHB
         X+k6NjCMuFXON8ENr6BwMnJBeyq6zJ0PYM9+D1LFi8+a6rl35k7+nPjRfnVp7LOl8Kix
         yMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcOZXULxNIq6oAeZn3pWH0Rl0U6/CUoP5oW91CJuF+1aUxKaaDNxQCgN8fnSEv05ng2VYj9cMadk6Gd98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGoc2SG4k0OifcRSqq0/woAUnjd0RlS5IY5ZqwEwTr69kPe0F
	Vqd8iYWcWTmKspq0XzjekJFQ3Abv7nYdzI2AnRgIpLkBIPx2YvJDMjrcpBc/Yso=
X-Gm-Gg: ASbGncupFhn++qmG/sy2HgPQ7RO728STV497o6V9wvVMLK5LhH+fm7VP8qVW8FzdP4M
	mEqHZBwIJPtHI6OxjzPcBG1eS4avaMYPcIgzHoCqn+nHyxnuPtyVZA8Xnp1YQm6vUPIpOie/Gib
	rP4a1zP4gBaZ/X+Tq5L7oPmpY7GZaJlE2JwReMx4UQOwyjF7KPy0UKKy0e2p8c2tDbuL+D3DXmW
	/LxidP3lxvOP7mxIv8+Kt+ICZsxbIEoh4hfU93f2+QJ0xZWF1NIPPu9H1mLmk0AIekd/3SspB71
	RHvOf7iRdsH+OGzAheub03WCte9ls3ExSp9OGIDiftEnjAJJH0s=
X-Google-Smtp-Source: AGHT+IHfThnNuH0h6beaOQ5rYMykdsdyrSk1TPSC2gmbY63W9HKJJCP1ryph8gsbU1Jj4BNeY7MpCQ==
X-Received: by 2002:a05:600c:2d04:b0:439:84d3:f7fd with SMTP id 5b1f17b1804b1-43984d3fb0bmr51487845e9.4.1740041407801;
        Thu, 20 Feb 2025 00:50:07 -0800 (PST)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439918273dbsm81894325e9.20.2025.02.20.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:50:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 09:50:06 +0100
Message-Id: <D7X576NHG512.2HBBO3JLIA1JH@ventanamicro.com>
Subject: Re: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
Cc: <anup@brainfault.org>, <kvm-riscv@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <atishp@atishpatra.org>,
 <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: "xiangwencheng" <xiangwencheng@lanxincomputing.com>, "Andrew Jones"
 <ajones@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250219015426.1939-1-xiangwencheng@lanxincomputing.com>
 <D7WALEFMK28X.13HQ0UL1S3NM5@ventanamicro.com>
 <38cc241c40a8ef2775e304d366bcd07df733ecf0.f7f1d4c7.545f.42a8.90f5.c5d09b1d32ec@feishu.cn> <20250220-f9c4c4b3792a66999ea5b385@orel> <38cc241c40a8ef2775e304d366bcd07df733ecf0.818d94fe.c229.4f42.a074.e64851f0591b@feishu.cn>
In-Reply-To: <38cc241c40a8ef2775e304d366bcd07df733ecf0.818d94fe.c229.4f42.a074.e64851f0591b@feishu.cn>

2025-02-20T16:17:33+08:00, xiangwencheng <xiangwencheng@lanxincomputing.com=
>:
>> From: "Andrew Jones"<ajones@ventanamicro.com>
>> On Thu, Feb 20, 2025 at 03:12:58PM +0800, xiangwencheng wrote:
>> > In kvm_arch_vcpu_blocking it will enable guest external interrupt, whi=
ch
>
>> > means wirting to VS_FILE will cause an interrupt. And the interrupt ha=
ndler
>
>> > hgei_interrupt which is setted in aia_hgei_init will finally call kvm_=
vcpu_kick
>
>> > to wake up vCPU.

(Configure your mail client, so it doesn't add a newline between each
 quoted line when replying.)

>> > So I still think is not necessary to call another kvm_vcpu_kick after =
writing to
>> > VS_FILE.

So the kick wasn't there to mask some other bug, thanks.

>> Right, we don't need anything since hgei_interrupt() kicks for us, but i=
f
>> we do
>>=C2=A0
>> @@ -973,8 +973,8 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu =
*vcpu,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_lock_irqsave(&imsic->vsfile_lock, flags=
);
>>=C2=A0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (imsic->vsfile_cpu >=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_vcpu_wake_up(vcpu=
);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(iid, imsi=
c->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_vcpu_kick(vcpu);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eix =3D &imsic->=
swfile->eix[iid / BITS_PER_TYPE(u64)];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(iid & (B=
ITS_PER_TYPE(u64) - 1), eix->eip);
>>=C2=A0
>> then we should be able to avoid taking a host interrupt.

The wakeup is asynchronous, and this would practically never avoid the
host interrupt, but we'd do extra pointless work...
I think it's much better just with the write.  (The wakeup would again
make KVM look like it has a bug elsewhere.)

