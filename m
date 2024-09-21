Return-Path: <linux-kernel+bounces-334751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A3297DBB7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463C7B21AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76844282FB;
	Sat, 21 Sep 2024 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tmZPrOlQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691C1C693
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726894580; cv=none; b=o/UBmWrfJEJ1ipeaTMddlQLOjHT5kcqcPYwaVyY6BFOn82iXEwjfg9Vxom16oPd4WCmFFQYpfE9M8pcLQOlCJFBCFCbN24+tO0WabcpJChNcE0MvOLV4qn2aRmlbCTr8pBME5o+WU39wOXy4QRKM38eYh+0UB10bwIrwFrN5ZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726894580; c=relaxed/simple;
	bh=Hn4fReQotENKNmRSfo2n2nLfnja9kCI0SETHuXmadRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iri7HDfWr5hjQbpsQUhFVJ87x15QPyDVvBGLZA4dlqU8rzK2mrnPgmS19cRGmDHjGQ1iGQHmvu8OeB/40F+ZFrIGNoDCQ1bAypkiLkUsHsW45YjKfw2Zhwdy0T61rdK4Cr53icwweKL/sYRANook9KHNFmlFnZBO6btUXfJCJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tmZPrOlQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso3196416e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 21:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726894577; x=1727499377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn4fReQotENKNmRSfo2n2nLfnja9kCI0SETHuXmadRw=;
        b=tmZPrOlQ0qV/sAovR6H7NfVaU3693v2U6zrkzJvotvmnFeKCrPkIOOaPnN6gIBQuyV
         xFq6+hX9SDh/grUAjhh7LaPt1qLqmSfa4BJJButZwzVobcVKBMBkw/t/XYJw9QAFihQj
         jACngkda70jLOl/vH+A844P08cz2AgE5GlB4fFlOre96nj74w24Xj8cdlEJvXx0MRi1S
         FKG5q5azo7NDmuurujbiuaI1Zh6t8wga3SH53S5SRM6EIoDibFRuJgjYueIABWfc4c8V
         IzVmdWEk4Or0r5smfynbJravtmFkg5ZljLvi/7YGoV6Sd6CFApKIiuhnL8IOkjnXXz+W
         3VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726894577; x=1727499377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn4fReQotENKNmRSfo2n2nLfnja9kCI0SETHuXmadRw=;
        b=qyR9aIod577616UWjwXzid9GRGV0yeq2PrlFxd6s/Jzb+B2bcm1RJZPE57pFALCalb
         lewW1d5mMXxjJ3FUjjT1DGulTZuQQsV2PHy0QGY5GFHoEOBWg/l2OFY5ZW14ifMidyFb
         2D1IRotiZt+xsYVPmRubV9MZbl+dDgxW+sk3U/NXqAuBkc0/Oxt02Z6QWkkslezveO8d
         o34wn8dRxaxeac07yhp+P3sFNOWL6P/aGmg24EbIkg17XLeSlpCFFPrtAr40bWN9em0h
         1oW1JSeQk0P+xI6nxXFId6Jy+bzIaL9xeVJW70tiog2xpCiK08iccUGyxxlN9C4+0Wxo
         b4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWltaVsoVAz9V4/uz+1ggTthKOLktmr3x382U6eOILaokrdBWnsXC9PybRjF/gBSXhHYHvTub78jPDzhqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzirlldLt8gw7TfKFP/B6JQXLXgMpBIIvUuAfFt0tFnr82CmQ6
	R2t+nUXe3Dn7Mz8rBHwSiOKNMrmp5Y+z1dzpMMlQliZ4l5jv6LEzujnpreg+/jnEVnPn94wYLwh
	hwaIw+u56Q8YGr0/cqvUlmxizW/ua52O+7tvNRg==
X-Google-Smtp-Source: AGHT+IGA+v7LGeKCraVVm2W3WnYjYpCsEiYRqZiZBxxc6iUgx4AERJeZIH1YVuoDb+oq4aKfLjDqUP1XyHd4Vib/la0=
X-Received: by 2002:a05:6512:158e:b0:52e:fdeb:9381 with SMTP id
 2adb3069b0e04-536ad3d72c9mr2962459e87.43.1726894576446; Fri, 20 Sep 2024
 21:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
 <87msk49j8m.fsf@kernel.org> <ed6aceb6-4954-43ad-b631-6c6fda209411@kernel.org>
 <87a5g2bz6j.fsf@kernel.org> <CAMRc=MeLick_+Czy5MhkX=SxVvR4WCmUZ8CQ5hQBVTe2fscCPg@mail.gmail.com>
 <b7fdafd6-5029-4b80-b264-11943740b354@quicinc.com>
In-Reply-To: <b7fdafd6-5029-4b80-b264-11943740b354@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 21 Sep 2024 06:56:05 +0200
Message-ID: <CAMRc=Mc2sbTrORZr4K4NgdyofNTipR1-QEqNK9mmNT=sd1myHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 11:02=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
>
> >
> > Let me give you an analogy: we don't really need to have always-on, fix=
ed
> > regulators in DTS. The drivers don't really need them. We do it for
> > completeness of the HW description.
>
> Again, since I'm a DT n00b:
> Just to make sure I understand, you are saying that with this change any
> existing .dts/.dtb files will still work with an updated driver, so the n=
ew
> properties are not required to be populated on existing devices.
>

There are no driver updates. No functional change.

> However a new driver with support for these properties will utilize them =
when
> they are present, and the current ath11k .dts files will need to be updat=
ed to
> include these properties for pci17cb,1103, i.e. the following needs updat=
ing:
> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts

What new driver? The dts is being updated in a separate series[1]. It
makes this platform use the new power sequencing subsystem for
wcn6855. All other changes required to make it work are already
upstream. There's no change to ath11k.

Bart

[1] https://lore.kernel.org/all/20240905122023.47251-1-brgl@bgdev.pl/

