Return-Path: <linux-kernel+bounces-516756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F10A37702
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9461C3AB46C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E3419E826;
	Sun, 16 Feb 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwbvq/qM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937732C8B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732139; cv=none; b=pP/PcU8PITql2nUseMUtVT/BmB7ZlFmie2D6grv7uyzBA6Bua+5VpclgYEGJYIfTJsf2kqRI8RY1RjrLIFatHLNYqEQow2Q4ozIcJ5wpvC4xocQOjdZEtz5WBHlGvMyj3k0DLCevy11pRN0WxwYrOJAF2lJRmFv8p+KrU/rWjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732139; c=relaxed/simple;
	bh=IKpPF+jBmDIT4Sot/gf+UPfPlLbYFzYrpayV85CmsbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNivegMV4Giw/Z/i3YoPlNNPCqSRC03J6uiWKmBFaE0f0lISjBUVpy9oxkEi7kzgzklory8yhu7UGayFAf1SoeOyRD/eOewTjQHRb0qfp53Alb/kq7dSq/DArMHNvynwlv7dVTjuWH2FNwRKyXyZslX7sjigFgfp/C0g+zcDvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwbvq/qM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab78e6edb99so548834566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739732136; x=1740336936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hC5pjueK3njHG+/S0PsoYfxNvXRhtdE6Y8ckyHhZnt8=;
        b=Pwbvq/qMHZFTkaZeS2cZG42hClI1lgGmwluKIS50w4+K+BBhMzz1GZ5TbyZTgPbHfJ
         ll4xwYTBGp1qmTBoksH25GaaLHExwsKLsZMYQU5oOhA6xG+IwJknjAXxl7fQEFOg+Yxc
         joMpAfZwld7f0puaiIbINBSVfCCl93hyzydhve80/phnj/tBoPArhGktsMiw2ZfnMClM
         w72eJNVnoNiIhPgiYROaiXw72MCbH8YiYpE17iQelfkxid8x43HzuxlofVeA+o9iBYx5
         4rfXtBUcl/b2M54cKCZA40ymSo5Z15tC52x8jPC+t5tHn+qRI+WKh/KCuXW6HRs66Sd6
         7q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739732136; x=1740336936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hC5pjueK3njHG+/S0PsoYfxNvXRhtdE6Y8ckyHhZnt8=;
        b=M0kBv0YVE4NBb2Zco2uDC1p764SjXkAUX5cw/Pt809ZSuC+Q0l8J6torXj1P+92E0o
         Se3fO56LkgMtvYEOVM+8diT8sklln4gNvnP8fjKOGeeaW3mD4z/7V4KcgNFAQT1dC+5l
         H0V1plUkBSjhC82zgd37UKAvF+2Ci9I5ExKptLUrn4ld+rcO8nn/ypFWwZh33LrT4Cyf
         NTyhf/PQwhOHL0vgm5UKEuSN9u9ifMkCZFK9ha02msCvqywrxrY50tohBNPtMuqxG6zA
         g0Z06av1rOtQfZnE7JYMRFUYLUoT6az5NwINjDDIzwo56zXwvy8HdU55YzSgCRZdBqmd
         9Kpw==
X-Forwarded-Encrypted: i=1; AJvYcCVSm3/lAWJBRIaJYA8G/yHLKoH0SSV4BIuFKLmXjuWhh2+mL9Zw8V4/v+dR/5QPglHyuB4X8qhFjjQODZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4+IqxeYElWh7qUx7HcO9VNwZwrA7yd7hUySfg2qEoNBVOxnw
	9fM3mmkCiFpfK+CVhmnktU5UlOeb9nl8LcCIZNwxNieOItYKm/aZKPjfkLU1ZkKqGxp0PvbaxJy
	EN4gukiMBKEL8xGYlYMx9WPjALj0=
X-Gm-Gg: ASbGncv849X6swNx3sFgE3KJGVO3FbH3qHsgPZN9Ig6VESxpl091XLUG1um8NFSJgax
	oBvlT9DUuCETpUzkv1s2c8knsddM1uw63K+IMo2IVuAvBGs+5iF5XX/8BGE3Zoggi220pnDB4
X-Google-Smtp-Source: AGHT+IEMhW69OjMic/GlsnphTy5HjgljXL7lYabt3t/KZP5dlB7Z7axgQFJTFGXD1Wtre/ru3ZMNXPSCNMU+4lVJMnc=
X-Received: by 2002:a17:907:7f27:b0:ab7:d77b:43a3 with SMTP id
 a640c23a62f3a-abb70bdba40mr717236866b.32.1739732135933; Sun, 16 Feb 2025
 10:55:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211143910.16775-1-sebott@redhat.com> <20250211143910.16775-2-sebott@redhat.com>
 <Z7BoydkyT_h0gwOV@linux.dev> <CAE2XoE_8ihJZQF856w-_F+cgJW7fLWGz7M7Ztoxzw2vE51_m1A@mail.gmail.com>
 <87v7tb17os.wl-maz@kernel.org> <CAE2XoE9=hjP+qpsy+FcYcSDectDajiXjtcMCVpacSo4cFOo=tQ@mail.gmail.com>
 <86jz9psqwd.wl-maz@kernel.org>
In-Reply-To: <86jz9psqwd.wl-maz@kernel.org>
Reply-To: luoyonggang@gmail.com
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 17 Feb 2025 02:55:23 +0800
X-Gm-Features: AWEUYZk3_EEMv5D6Rj82ShfmoPzBCN_NwGOjAGxgYCLPZKy3POf8ciw95cVy4Uc
Message-ID: <CAE2XoE8i=jPgSea5jXY0eOxas9Y_2pa7QheqS1xuw2qeTQDNyw@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 2:09=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Sat, 15 Feb 2025 19:04:20 +0000,
> "=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)" <luoyonggang@gmail.com> wrote=
:
> >
> > According to this, the MIDR EL1 is updated properly, but the MIDR for
> > aarch32 is not updated, and I don't know how to hook the update for
> > MIDR for aarch32
>
> It is the same thing. The AArch32 view is configured the same way as
> the AArch64 view, and there is nothing to do at all (that's what
> VPIDR_EL2 is all about).
>
> With Oliver's change, I'm correctly getting a different MIDR using a
> hacked up kvmtool, see below. I suspect you're not running with the
> correct patch applied.
>
The applied patch is V2, with writing vpidr_el2 disabled, Is that the cause=
?
The branch is here
https://github.com/lygstate/linux/tree/main
I am not applying your patch

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

