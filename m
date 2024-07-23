Return-Path: <linux-kernel+bounces-260116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419193A33C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD78284C16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C86155C90;
	Tue, 23 Jul 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1E6tJUE"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03368153BE3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746324; cv=none; b=piYkWvEkj7gtcQ3z++uzbGLYHPv6TMr1Coh3M3ILLrws7bTIX7IEAvED0Aw7KJsC/0W4c6a6fFNSemzTgSxwTiM7Ou9t++8MMT6uJEjtKX1UE2zRizdKAHzGaM7u3YuHCUsTrRPzP5DEZdmowHPnXC1t70F5db4NTqzFOXhB60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746324; c=relaxed/simple;
	bh=2BXRuhNjs+Co9wLYEOxSxxGquWpSDN79Re2KWJsmqjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+11C/3ADSyY4GfCWNMjh1yL3n4h1DHKLb3RHls8BBPAVlRw4/ZPhlPQPZfZD4291Gkz6In+a5begA8MJrpgWrNLRxGS7AlWsqshKEdkgb2ZiO1VYn82iApK46lW70wcKyV0ABTqGj84Sgc0Jn1jKYIg8JWChViG7EBtiQiUt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1E6tJUE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6659e81bc68so57776427b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721746322; x=1722351122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BXRuhNjs+Co9wLYEOxSxxGquWpSDN79Re2KWJsmqjU=;
        b=N1E6tJUEKY/skZErHhf8gzlkEBrluMxXMiWfke5AvrpyzV7YK2Q8wr8XZ3WLEA/qed
         JVn/eJOLl+QAFlRleGJnM+T9+9Th0QfHa53RUVHDA0YwKZiaxv7L6XN6HPA89hVnMQqt
         fJrPRswZDBkrgN6VCOij7giX8e/y8WXkaHzVTl0UTn2RcfzU3dhRGjO8y2zQqxSyfbC4
         bZeirOJwu1Uk2/LuRTG9UKp/XA/gufruBPXKeIpuPy1Uoha+rD/mzVmldTB47wkgJzTh
         11TYEzNz5BrVH10n03UTJ3ZhNfT2uDX8miPrZoTN9Ctse1tBhMw2z3IF3B28LDN8qdIb
         BB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746322; x=1722351122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BXRuhNjs+Co9wLYEOxSxxGquWpSDN79Re2KWJsmqjU=;
        b=QW0s7QzHGyUMoFFCKyS9dLA4hogX1My1+5z+5+hL+CYKfGTijT2tw2Yv9vZTnBDcDU
         bVS89Gmkdu0fWi8ji3vrhiut+4mu5KN7++nBA6g51XycC2mH1B4wyiBxc2PzHl5H4qkF
         6RGYhhboptjZJfCA53nVNi7RM/ePj9tEDTucinWOmjXJ/+sYsJIJi46ivRgZVxKdhEyE
         ogqzIgp+7OQZ5AqONWtANA9pvm3nd/tE9Lr/glBv5k9J9emWMWt+qe1Q2BaD0YZB7QNg
         cwy4zSeiB96JTzr/4Atpq89k1fC5rV89tjixiIS9zaP/1RV07+k9SIQ2FQAz1QPX74iV
         qUmw==
X-Forwarded-Encrypted: i=1; AJvYcCXJP+x3k0r/2mVxqwzSqD4gKSMo4qnEIg/EKs+HjXCi/Kgz1TjZTswfpIPreDM3NuPXUOOm40gxuWg/pcFYhgEuGWLExxBWDhYzTjM6
X-Gm-Message-State: AOJu0YwC6++X99bR31CAyiJMVZVeVh5nrokW274S0vECpRZYDCJnbDFM
	JRt2hVIGJJq1bLxlsbQ9KBB9DbBIYbqHCJIM0s7pH6MpnslNxCzSRJfbIoZKe7aao+SEuOvoyrD
	SRFJmXgQG+QCe+i+4EDgXxSB1r/H30rZCPaZa2g==
X-Google-Smtp-Source: AGHT+IFlCYWvugkp/0qD48zXiVq5n8nEZGFk6f2+A30UMKsCFyXnu4uqalzH8462eajzoCxDB7GJwx/vhyVo840NBpk=
X-Received: by 2002:a81:d101:0:b0:627:a757:cdfa with SMTP id
 00721157ae682-66ada1fc200mr104933947b3.38.1721746321994; Tue, 23 Jul 2024
 07:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240723141714eucas1p1de8e11114883d4dadbffec2a102f92fc@eucas1p1.samsung.com>
 <CAPLW+4=NnmSNp30mm04-38j8r9Uy2MUbq28Ua7=aT13uo=NH=Q@mail.gmail.com> <20240723141707.374772-1-m.majewski2@samsung.com>
In-Reply-To: <20240723141707.374772-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 09:51:51 -0500
Message-ID: <CAPLW+4nVY4sJtFp56A271pEqd0n1ZuQKY0JeUbPcWDW6FNY7fg@mail.gmail.com>
Subject: Re: [PATCH 3/6] drivers/thermal/exynos: check IS_ERR(data->clk) consistently
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:17=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> > Also, if it's only optional for Exynos850 (and not optional for other
> > chips), maybe it would be a good idea to use *_optional_* API only for
> > Exynos850 case, so that the driver's behavior for those chips stays
> > unchanged.
>
> Probably should just set the clock to NULL in case of 850 then?
>

Ah, you are right, there is not much sense in doing both. I guess the
canonical way to do that (please check the drivers I referenced) -- is
not to check the chip, but just run devm_clk_get_optional(), which
sets the clock to NULL in case it's missing in dts. Less code this
way. And while at it, maybe consider reducing the code even more by
using devm_clk_get_optional_prepared().

> > Btw, from the downstream kernel code [1] I can see that the only TMU
> > clock present in Exynos850 is
> > GOUT_BLK_PERI_UID_BUSIF_TMU_IPCLKPORT_PCLK (which I was able to
> > confirm in TRM). But it's not enabled in clk-exynos850.c driver right
> > now. Do you want me by chance to send the patch adding it?
>
> Would be very grateful :) If nothing else, it would be useful for
> testing.

Cool, will try to do that soon!

