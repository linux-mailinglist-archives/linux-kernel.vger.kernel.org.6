Return-Path: <linux-kernel+bounces-537504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29562A48CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7E2188AF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413D276D0B;
	Thu, 27 Feb 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFtgo7zU"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46B276D02
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698572; cv=none; b=WziUqPQHbWdlOGQL3kzcNT8x2iS2pf3lZstjGf3esnRNJ9dRjPwgGqCNxK2x4aLGpzM1Eh73G9+R5ozIOdxSzNiIW/RuoO6RIG+X43Ok7XhFevWecOq56L3x4D5NYf6GpY6NYttew7GkMHflXQQgquzZBfK6u6nSjKuSGY0+nKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698572; c=relaxed/simple;
	bh=w91c9SXP4CEfZA2fCyoem4LGS9FB0rOu09k3Soc7aEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQRc0OtKu9Y4g9e9HdktTUomZVvvGrAQP3Oz8iW569H0rhReqJ6M7P203m54l0qxy6GLMiJ8YXm91sFOo/zHNxdZ46ND4YYCySidVJ2f9rFpR1EKCivFba9deqV/4u2yoKIAlwSdomjXWXhZZnfgUrFJZaaGE/ulgdaRsle8n4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFtgo7zU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54943bb8006so1523815e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740698569; x=1741303369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00gtyCYqXrSE/b5izDUf0f21xEdhdcSgRFslmdAQqPQ=;
        b=EFtgo7zUCcyFJNP9aE/j5jDuWVBXf1PyCcjKsPhY7OFxeTA7+Zw5DEn6UghkvT41wA
         rCyuuebeb5Q4UrmMYADNt11g6NurT2WerB/kise8CHF8idcKFzLczINoW89vMw7MIGPk
         p0zgi3JWSXHgZ1RRxIywFhHhNCRTI+aUZuXGqrovzyDcgKTYFoNEDa810TzIGaMT9NAe
         93Uo55i2W6Y0xdzsmmsEl1hFUyEOK9BaRbfKmfKekrY3TCNnpo2rwT5L4q7MA8thSx6n
         vND21ALNYcrortFDgpuhB3SGzZw3FJeHnsF23moPFHesU8aUBTS4PTggLSnEvBKadyx4
         nl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698569; x=1741303369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00gtyCYqXrSE/b5izDUf0f21xEdhdcSgRFslmdAQqPQ=;
        b=iaPSFv0ZDx77/+iNrszN2mFgMKl63iXrAoPhDigmX72lipS1PxzsBKkDNCsiuzYV6H
         QMgKBlriKS+4pS2On133s6KBaZDNooYgEvkhNi+sMalSTkJjL2qj85zWOXG60BMqmkit
         7hVITfx76Vv7GqyZtbB0XZHKvxNEbYj1MyNvdQ3lfMZVJJZz7CES6cKZb3UBLPLVX5bs
         GJ6yKQcaxjFdJ8UI2DCmpgRLmE2UFsk1ltbQzhYorITJ6noGi3WKM/x1X15ygv0VyI/Z
         VNMt5QawvxfM8KzC5DmJU13TiW0PkR98FgPYJ3fQTjvbSOFBQ34EWuSbRwBmlXshjtOv
         Bf/A==
X-Forwarded-Encrypted: i=1; AJvYcCXBZh/S4SueXMogWgScJLX2gDx6DWkIkC7KoiuZK69UWBOKU+Pfe8etyqhzKl7wlaevK9EHiqEErImGXt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/iLfnrg3++zhLyQyN7xu9iskqjVLumScREGMSww4n3ioi9HQ
	aEsvbXhZolXKmxthG1BbKRFyljcc09rO7hlYVd4aG/mwXxMYdHlN4LBrqzM15C6KzMxgxkTPtOR
	9n+ULb0xoyukAMMOx20y4QF0d9QAMK291FCk2dg==
X-Gm-Gg: ASbGnct8px/Zz36u33X6q2vL6WRkP1pn2EQi9HJJGW8AQzF3K4x3qx0L8E57gQRUGVT
	WO3kU4HnnAE1WaUezscUd57IjBMDGJ1FLOY6LD3lmPtTvgVbBUx83T4T91UQ+ufCRhdZM9X4+GV
	MEOWDVrMI=
X-Google-Smtp-Source: AGHT+IEQkWRbl/rqTGPZWE6RWd1+bUR4lNwgs9fA64RyFVNEkrdR+tkoe+YfJ+7HwPOazZ+bfaaXCKna4jvoNXdJt58=
X-Received: by 2002:a05:6512:3ba8:b0:545:81b:1510 with SMTP id
 2adb3069b0e04-5494c10c90cmr386304e87.2.1740698568904; Thu, 27 Feb 2025
 15:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224125414.2184-1-ceggers@arri.de>
In-Reply-To: <20250224125414.2184-1-ceggers@arri.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:22:37 +0100
X-Gm-Features: AQ5f1Jp46qVZUb2P-50a9KhXsYzlOeRhxfka-eek84I0uZFyIaa4wogc1XO6a0o
Message-ID: <CACRpkdau2cYA=+UOprqj7n9HCf5xQqpZWxnX1gMmuntr95E+fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker script
To: Christian Eggers <ceggers@arri.de>
Cc: Russell King <linux@armlinux.org.uk>, Yuntao Liu <liuyuntao12@huawei.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:54=E2=80=AFPM Christian Eggers <ceggers@arri.de> =
wrote:

> If linker garbage collection is active, we must ensure that the vectors
> are not removed during linking (by using the KEEP keyword).  But it
> seems that the LLD linker doesn't support using the KEEP() keyword
> within an overlay description.
>
> The GNU linker manual shows an alternative way to accomplish the same
> result without using the overlay statement:
>
> https://sourceware.org/binutils/docs/ld/Overlay-Description.html
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502222158.UhwuvDZv-lkp@i=
ntel.com/
> Signed-off-by: Christian Eggers <ceggers@arri.de>

Looks right to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

