Return-Path: <linux-kernel+bounces-517070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA21EA37B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F86D1688E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425F18FDDF;
	Mon, 17 Feb 2025 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2ceBBCA"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742A18DB3A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774466; cv=none; b=TVdg1P8SzynN5cPdvzRjQCzegNwfse2q9zweYI2LYs9Ard3J6GlRkJImfFAx9kNpypSR4USUdIK3S8SGto8MjLNw313Nzb4Gdx2f+fyqfRaPDe+UhZIuSPaMDA0S9xCBQGsuaPsuCnmPrfNWmi51u7e83o2rGsIaSYzO0SASZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774466; c=relaxed/simple;
	bh=QyVtFU0xdpInEPYan+aOJEYUTEb5vp2F9nMoL/TtoMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNggD819tVBySihiM9PcKx+9G6knhm04BLMVskUBTW1rzCXsyJSI8xbtQH39tp7FnReHu7aYdWMJd5Fa8wXiYCAhtTVt112rEgVfzD3t6iUiKJXGSjwm4nAu9g+NDeDn9krxIYRYKcd1fxfTifaTuDOS/ODu22GlFE+7djV4X/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2ceBBCA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb81285d33so247381666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739774463; x=1740379263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9BlNWjMvH32bt0VwRarRhttzzRaU06jOP281HprHsXs=;
        b=G2ceBBCAhFSd+DPf1GQ5rwb1jvZOuSXSNdhk9U3+11FpL7Is5WJGaE20lRNSsJ9zEa
         jdbevtcIjojhe4rMXtxn9E3/HE0JfPz+zvyf01KrSxR1gd6z5i/k95ctzBNDvn32DFF2
         g2Z8vdOIOP9wWsRSN3TXfSo7z8a950M/j4ltLp8w1/pO2j7c6F2NpXUMZzsRFIEJ7Glm
         LlKiIL7SRx984Bdhm45FuFH0r13zIWM1bN7h4Xndc5gLXMu2azkLsbjjwdUfMCzAr1MC
         PJLP4S5/PcqhL77x58SMXh0FT0FUkLo2ocpwlABzV+xSbA3t803wmom1z5qCfQkMqMFo
         Y9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774463; x=1740379263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BlNWjMvH32bt0VwRarRhttzzRaU06jOP281HprHsXs=;
        b=gs68CyzxWyDKHjCPJwge+PLiVpAjR3pbHDfEJvO8qDw+pru00jKrEiCyqGddic9lhr
         hIyTDU8SCx3q8GV/W+DmFVijMFZKa7vXTMs+VcG2qHwLggFoFELxQDVvRGFec1g5xnRf
         /RRJTxf0oXJm8U7Qsmb8lzZ2+aP+vpSv5BorgaoVjGBle+RQ4r+AAvrO7s/lLS4tYLRk
         foieHU8eCp4pqE7O29LRymggEwv4d4fdtt+S44+7X9/jjf0EVcFQ85q0AgaXsqnxImPe
         VSDCR6laGAkhWtpprV3ieQ7KzhioGh9n0VsOh8O20xFfrlguM6O6+KBX+ESeFYZovVMo
         6g6w==
X-Forwarded-Encrypted: i=1; AJvYcCUD2Po6K5lFIBAukBd/0lzqn+UK6QTmSSgyBJUYI2iuI3ByjU0vs4nZAAIefLUB/aKkJT5C7Yyl0qALE5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJV8iRl1cwc0BdfmiDnYAaXkHJKcgMYtkkVbMEguuLiLF4gWe
	22cRjJ4DqHTuaLhZlNyRfGSePCgd69NZrNduNzxn8IXGN4/bR/fW6+gnVfg9GKZC3m0X8QRCpQz
	YkZjrKWGENx8YEkfC+dNQn5hrHTc=
X-Gm-Gg: ASbGncsZ2axc/9dRjdJWc5wN8928kEv63/DzfMcPG2HZqzUq8NyXzid+DEJ5g6ghbz1
	C2XIxjI0JTf9J9uCEE042jHiV67O8KWiIZ/AaLe00oc8ufW2VkUCe/vgWDsQiaHOCMJL3OFmU
X-Google-Smtp-Source: AGHT+IHEblpWy0E8o/GwtXXK/ARtPn4+t2mJ/jkAoJv43EWaA0zUoUZ//XGdmh3n9p1/b1WAK7vkij5W6JHPpq2qDSI=
X-Received: by 2002:a17:906:7312:b0:ab7:6c4b:920a with SMTP id
 a640c23a62f3a-abb70a7a67emr862003466b.6.1739774462705; Sun, 16 Feb 2025
 22:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211143910.16775-1-sebott@redhat.com> <20250211143910.16775-2-sebott@redhat.com>
 <Z7BoydkyT_h0gwOV@linux.dev> <CAE2XoE_8ihJZQF856w-_F+cgJW7fLWGz7M7Ztoxzw2vE51_m1A@mail.gmail.com>
 <87v7tb17os.wl-maz@kernel.org> <CAE2XoE9=hjP+qpsy+FcYcSDectDajiXjtcMCVpacSo4cFOo=tQ@mail.gmail.com>
 <86jz9psqwd.wl-maz@kernel.org> <CAE2XoE8i=jPgSea5jXY0eOxas9Y_2pa7QheqS1xuw2qeTQDNyw@mail.gmail.com>
 <87pljh1zgj.wl-maz@kernel.org>
In-Reply-To: <87pljh1zgj.wl-maz@kernel.org>
Reply-To: luoyonggang@gmail.com
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 17 Feb 2025 14:40:51 +0800
X-Gm-Features: AWEUYZnfZwhUG_EoRZ2LP7nC3OQtiJSnvldFjppzrrBppJQq32TWm_4wX3cJYI4
Message-ID: <CAE2XoE9Xc0CeNiRZnwANU2Q9Mbg6f0hCOyrkNA+h5Jp-2mrsBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: arm64: Allow userspace to change MIDR_EL1
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Sebastian Ott <sebott@redhat.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Well, there is no magic. If you don't write to VPIDR_EL2, not much
> will happen. You need to apply Oliver's change instead of the first
> patch in this series.

Thanks, after applying Oliver's change, it's working, my concern post
at the beginning is to ask if
 Oliver's can resolve the issue:)
Now after testing Oliver's change, it's working, thanks
Sebastian,Oliver and Marc Zyngier:)

My test result now is:
```
/home/lygstate/work/qemu/build:/usr/local/sbin:/usr/local/bin:/usr/sbin:/us=
r/bin:/sbin:/bin
/home/lygstate/work/qemu/build/qemu-system-aarch64
+ qemu-system-aarch64 -cpu host,aarch64=3Doff -accel kvm -m 1024M -smp 1
-M virt,gic-version=3D3,midr=3D0x412fd050 -nographic -monitor none -serial
stdio -kernel /home/lygstate/work/debian/arm64-kvm-hello-world/bare-metal-a=
arch32-qemu/hello_world.elf
Get MIDR EL1 origin:0x410fd083
Set MIDR EL1:0x412fd050
Get MIDR EL1:0x412fd050
Hello World midr:0x412fd050
```


>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

