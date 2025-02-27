Return-Path: <linux-kernel+bounces-537505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D9AA48CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3922616743F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5BD276D0E;
	Thu, 27 Feb 2025 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEeOFRqL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1C276D0A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698593; cv=none; b=aDjJe39qRiMLXFSGWUxTjJOgsNqzX9E1JnX6K8yEq8re4yWKLTVxjhmsszNc7H4CPr+WyPPoqs5pgd8J6sQlbxVS+UmkSbdmSAI8Cw+Vh6X6DxJ56CqDPRk+8nTgCXSxdc24q7th4+cBoZtN+kWDM446mZcSqN1VlAc/gcxi/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698593; c=relaxed/simple;
	bh=BMtw27u91lIUjXR5BSaUXMJPd9zqjgeKaC95Un75ZhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXoOvQiwdSD20r3KrjrtiZPOZzDxm24+1fkeAt+UE4sO38yGOy2Urz1+fqZfapfP71xicqPWvxa2qXjAheENXSbzWg3HQ5bSH78HA4l8gbOo+tyXqa5aae4a0wflnSMzmV7nD6v/7gy84LCaxThFjZmkn8svo3J/aTAJi/i6IfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eEeOFRqL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-546210287c1so1446907e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740698589; x=1741303389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlklntyFMEqSXsC3eULyJeiHZfsmoGMdS5ODYrUKghY=;
        b=eEeOFRqLKtxkIT5T06FHC9X1N/9sFVHDK+vih936Nrj9jBbzpqn0RHazHp8kP5qzsX
         TK2flLwnJpHD+al680JSbCH+D4BrSNjwFzkrI3vnuug+obM7/fjWoPWN0iduazJpVbZJ
         NaLiUyTjkQgGfWYtDra8GK7rpJmA5tU6uC/tMpYanY7N5Gr8lKcndnRnOTbuWkelIa//
         VHSgT6Xa2RC9Hgl5wNq1qFafBW+QJFLvqvDAaM3KElY7oeMdUXKUtCRAF3rYEQSf9YDM
         b2MI968oPW5cQC2zE9kokz8Ml8hoWBR0T1lcbXLu4pq8CkgMfqrhZNrrJqSniTi0MeZ1
         we0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698589; x=1741303389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlklntyFMEqSXsC3eULyJeiHZfsmoGMdS5ODYrUKghY=;
        b=VlrT6Sd/kqCx2szX4Rz0yb9fjdIhandfX/HTa5nfBEUIgeSM9uZG1edzcAa/IL8OVc
         T1JiTLhZHeTgkWCWR6bTcBoit0IcUyulFKI6ZYN4MOdVZ2oweweZ4iI4HrS8fiMiasIe
         kXRLmlNV95B/jMdp7dtEx3Y91QvhraTnexzRwQg6juJQBm8biQzIj9lEOl2OwRRZbdiI
         RFygJ5QyknNgqJO+D3NwNHUHKo4tfs47xL+MLZNhboFhLSk9dZQGhyeMbzRZ8xUABTQc
         5Fd8RzsftHdYNGtivYN3YJgtz1tOLBJ5eUx/KAep6IAnN0yS9Fa+TLwvJPWdKLFxok+q
         nf8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM4g3bp1NC+RFy7k7WCWolesimxPPma6UWqVmqRBNnE/SpnxtjptOLRBAwBhSKrfJq8L1zbKi5ro5Q+88=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4SQUg3bVGo2IuK8eRH+2U5335gtagGsOT4H6bxEnc/ekdZfB
	Xa3Jc6VVr7kKzrxxu867Ud0gRtS173CLwwWOgMp3YZH2JISqmJwvV5I++R7AG05B9G4qBM0xl6a
	mgu9fsU4SQNRVgoVcyfULDNi+wTXKSWe+ICAUVA==
X-Gm-Gg: ASbGncu16NBuiHQKRJfI/Ws1MngWw+HOUr6/29gHEcSNNGT0bCWoZoQeYzZ2BoMQnsB
	wLUgce6uywLUZIewb9mr8EyUYQsWndKdHNf++WtRZv+eYiHaBKjV7GOw7wIvMESDImWmThG6KB/
	Qp01NBlhQ=
X-Google-Smtp-Source: AGHT+IFDwS0trh7wVv751/LNhm0ayEYAE6zWRl6h4UBlSzx9IILpD5bXrhXjg2DoYRUQ5K7XRe7cIuqbmqjCkUb809I=
X-Received: by 2002:a05:6512:3a90:b0:545:441:52d4 with SMTP id
 2adb3069b0e04-5494c33089emr429126e87.26.1740698589257; Thu, 27 Feb 2025
 15:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224125414.2184-1-ceggers@arri.de> <20250224125414.2184-2-ceggers@arri.de>
In-Reply-To: <20250224125414.2184-2-ceggers@arri.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:22:58 +0100
X-Gm-Features: AQ5f1JpP5no5eM0Ohbj9j2qqCMlr1sH-HO2M7itlp2WyMF6MiNode8u_9sdDNZI
Message-ID: <CACRpkdYZmC7yg7fcYEyVhxioDObRX-RR35skGBxxFxzHHOnt=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: avoid that vectors are removed during linker
 garbage collection
To: Christian Eggers <ceggers@arri.de>
Cc: Russell King <linux@armlinux.org.uk>, Yuntao Liu <liuyuntao12@huawei.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:54=E2=80=AFPM Christian Eggers <ceggers@arri.de> =
wrote:

> Without this, the vectors are removed if LD_DEAD_CODE_DATA_ELIMINATION
> is enabled.  At startup, the CPU (silently) hangs in the undefined
> instruction exception as soon as the first timer interrupt arrives.
>
> Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_E=
LIMINATION")
> Signed-off-by: Christian Eggers <ceggers@arri.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

