Return-Path: <linux-kernel+bounces-531757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B4A4447A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AD018828CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B81514EE;
	Tue, 25 Feb 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywZM15mn"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84B3F9D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497569; cv=none; b=I+fFjKAyYeHGkVveuYh8UKPZvYo5zHzyHBW4Dut/b603NsmunBTyN8V+Z/4+M0xe2eGbNAGwLFDtC9ubK42uuDg3gtxDaiFGJ2q0d96yorEL9Bz71uiofIcQoIVWP2/bnBxuRuSIr9RBwc5jrdZZstKRHzJbThganFeD6XP7YOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497569; c=relaxed/simple;
	bh=kaGjkAopaAQGIONFxxCbjojwL121uVVm+SlSEpngTxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKj/rMuJD0WEziUevW+Bfd6ictWKTg25Xewrppexcc6k/v4s+03tCX1pvyjL9m4NJU8CLoR3Yu209W6qaajazeoJX9Ut7fc6zUMEpnLxfGLhgD5PDKMc9+dg01dbhr8sQCVZuYWbiNUcP37jU4szX0Qgt6ZN7fJs3CvYVOSzqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ywZM15mn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30737db1aa9so55913001fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497565; x=1741102365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaGjkAopaAQGIONFxxCbjojwL121uVVm+SlSEpngTxQ=;
        b=ywZM15mneWg0GoSUwPAEpLr0BdcoHXXD0hZlv9Q/m3rS9QGAQn2FWm6Jjun5zbSYfQ
         MN079WhhWwcPtQ+ypAnpK42q84vxdjTOIBINAmVZ8rY5AUknBM+jFlz9IidduMqqHSvy
         aOtMhwTG7HdqoScaBywSobFUdaS95BnM6kA1+gqRrjgO2DX8iiNAoP/V51KywXe5c2cO
         VLh6SctS3I67XYS1GXu9teuJUnHGIIDEPs2tRthLf8CRFHpl3dBnOOfrT842ZF8FMl2r
         gAyEPF+5av8WFU3E6g9xEbJMpdIem58eyxEEdQns6pvx1iLR4keKE8fzbnK8Fm5Jmd1j
         87CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497565; x=1741102365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaGjkAopaAQGIONFxxCbjojwL121uVVm+SlSEpngTxQ=;
        b=CvFelDkiA85XkfK4mM4LrutCLFhgjmxUPul/39/93abidvqdNCodBeBkMpQ35eVfEQ
         FqwaVyhWwnhv94RYhVLI+1AUlfOXAEfcvtuahlfi40VfAFJfmurm2odX6dzAsj3nWYSG
         xC56K3iDNLhLgXQCInaikiZOu7ga0ITC2tt9tD9MfJAtfRlbF5OqRuzbWB8rB3eh+X39
         XsE452JdMff8DUwC4ogpplErnThrGuX0g5R6YVJkJ2sdDSjjHAd/qXmFy9ChfnFXkhuj
         kkwNHHHhW5sb6DohZRhSRONbKseh37r9/XLTiXGJXfJlseXFD0c/fnyZ/d18W55lzNW5
         6oiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0oyEpRU+RYZRcyqix0/iHRQ4hu55tdif9nbPIfQc49SqRXAzLB3lYrLKkaG1SFwHVWocAjJQvgylaOnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+hCRU3czorulo9UXrsixl75DD6ly3xGNocT8tCBCZiwgRTNz
	JxZqhHTekjt0lBU6VxBeNR+FfrAP1D81XZoiF5SjeSWnZ5H5ecXcIwOHEOBABse5px6DuEQ/2+f
	GSU66S44cfOmy6GNCigUrk/uLxOtuYHTkFQBW4g==
X-Gm-Gg: ASbGnctODCQebJE6MkKhExn17a/wAfkZaBGE9lCJQZ5cl1u/z4g+F0zfhEHVE43JzXk
	QOMNSF2EbAscnQeg4huM/os7xLM53cvFALy8Ed8efhmhWnIXz1EpOLRs+bygUik2ZgLVSvK4X0z
	DDnd36jxY=
X-Google-Smtp-Source: AGHT+IFPvks1R+N+fJTEiOsOCgQ3Uu2uCdasHK1zA3TfJnFONKyVeOK09rw3k8OZE9RdybF4r8mkRiLMaKmtj/CzaGo=
X-Received: by 2002:a05:6512:ac4:b0:545:ba7:26f2 with SMTP id
 2adb3069b0e04-54838f7b2e2mr6507774e87.53.1740497565136; Tue, 25 Feb 2025
 07:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com> <20250221180349.1413089-4-vincenzo.frascino@arm.com>
In-Reply-To: <20250221180349.1413089-4-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:32:34 +0100
X-Gm-Features: AWEUYZngCJXkldRqEiu37vm6Vs1F2om2wUYZ7-KT8x5LplRl6N4turQDfjA0U0s
Message-ID: <CACRpkdayJv5Js0trEgHbV1nM6CS-Og-eab00AFC7JWxuk9daTA@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] dt-bindings: arm: Add Morello fvp compatibility
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> Add compatibility to Arm Morello Fixed Virtual Platform.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

I see my v6 and v7 patches are mingled. Sorry for any double-review tags.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

