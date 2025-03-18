Return-Path: <linux-kernel+bounces-566193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E435AA67498
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D87B166496
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689292080C8;
	Tue, 18 Mar 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdkv8eDJ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866C2F37
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303552; cv=none; b=sqZK0+MIGfxJMTLrESkLXjaNLXdVurMyuVnNraOQjhpohCt/LMTdHYWiD7mTnVfm6RcXeCiDEd64y6QMij4Xk2suBYr5FDWtnnEBs1Edbpudealyl/lgRrHZhW4bAK4dFHaakdVGZor4oppHuogjZMnmS7fM0V50LTxXZJGkGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303552; c=relaxed/simple;
	bh=m+JW0GxcOfEbsGUMfY3A4UKcwqPXUPjKGZHsNwYr1cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeBmxVNeb9er3ji75Z/uuidNTn0Qc2R5L4G5STpXU/FTsea+QENl9GeLy+3GIjTPjO4VAPelJNPqqSuyU9tfiDNSXzHqoNfZZVgKdb5ONHgHjPKheTHzT+NmhGb7U5nrP3CLEWshDqV8wNj16rCrdZVrwXW8xrbaNgboWGbaD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sdkv8eDJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bae572157so56643491fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742303549; x=1742908349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+JW0GxcOfEbsGUMfY3A4UKcwqPXUPjKGZHsNwYr1cc=;
        b=sdkv8eDJhwZeRpMV5aMTB94I8+zdACtCEeOGDTcPh4byCH+J1VNCso0V3HGRLGnTBw
         MBSiu1ICGRbJaMNKEeH2RUmqEgVzzrBhrpMI3R10RcFWv6J4yM5bGVD/pKQIJRRrdViZ
         FxgBcfhfEfIFpfWMuB5zlrVjURPChTBiJPZSqNskZcd7wOa9C5cSUy/6/3uvuR+bJ/As
         lFqC8Fxi4vKUSV2nF6mS6hyvdqY4tKWx1v4k6EkEARgITOktR79I5Yxya/wICtkZWXkl
         H7p/c4fmHEqYGRdqrG5boWEVosBAa+DvWwr2WD5x3ZpuZgJcxpyr7iynmUQWyOW8UKo0
         sxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303549; x=1742908349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+JW0GxcOfEbsGUMfY3A4UKcwqPXUPjKGZHsNwYr1cc=;
        b=woBd0ISuS2c4Pb2R9aaUi/BZty4mW7kmYIkCIXDPq1ylIGguKsOA2tCHsDu2lUCaCt
         KrvjughfMWhS7vjoxksnR+O5eQ9kuaM2FT3EuS/wc2TXERThv2NReSGsU7SQ8OiLZiS/
         ApKi69PQtQgK+G4jGBKMuJelcYuRQ35EeOOUVCaYDjTSaH//qfWdZz1yvjR4EXp1QN4g
         baNyNFQK4qK2GlB4+LkLF7EzwFm0rvtCCgtSoPmCaj4+alnKmtKk8yZTRwKcQVWz3Nk3
         baIxy4StSDAKSQRvcVnk2chm1xAaQwjSpv4ag8UANG0sMq9a4DiDgNssCyh3pTif7Ce9
         baTA==
X-Forwarded-Encrypted: i=1; AJvYcCWxbBvOe5lmc4CR5AA0Ujsm1sqI98LYaz69VkEtb7PkEsP8ShYhEvUAjKjIV5hfFbu90UBW13eGDb3kmiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHq30OEBuqJVLDGsgy+haYMwvoYI+BpTJH/uABhebr9RImxmc/
	RXIn0HmP1jC+/d2bnGYwojXrst/pDzC0BkVhV46k7hZ/j3EyTcPo66fZk2tcLvIkaYXc0zUd/UG
	fG5kK6dPp2Xqem5AEEpsmUiws3JZoUTSQdHNHrA==
X-Gm-Gg: ASbGncuWTlsMkR1Tij8zUVGdJ7OnVQpzQ0i/Nkjcv+tanhDZqYKuOwAXYAuE/jpGvar
	jpJLLaO/jrSR4qBmtpw2x+pLb5erpBlwMamKVkewaa9CqXqCSWBMgpcoL+t6ldGUIX2DOY0gdRc
	mZQ9yJX2KDXRx+UvzkYoag0bHf9w==
X-Google-Smtp-Source: AGHT+IEIZJYLChZDkVJzp8GGSso6tmjT/EGUHPEz7J1GeVHCZp3JY3gZqnIFRPcKetE4CFJOoQCHjU6fqzqdaamtiwE=
X-Received: by 2002:a05:6512:158a:b0:549:4de9:c23 with SMTP id
 2adb3069b0e04-549c38f2271mr7000190e87.9.1742303549003; Tue, 18 Mar 2025
 06:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6881b8d1ad74ac780af8a974e604b5ef3f5d4aad.1742198691.git.geert+renesas@glider.be>
In-Reply-To: <6881b8d1ad74ac780af8a974e604b5ef3f5d4aad.1742198691.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Mar 2025 14:12:17 +0100
X-Gm-Features: AQ5f1JpKtqBl6_xNyjaCM0IP-W12FrKeGTp428YKCDaSR8qMk0mTF6rf_odJg14
Message-ID: <CACRpkdaOv8u1yCLyZs+hKv9h3YDk5PMD=HVpgABMpm=kwO35Sg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: spacemit: PINCTRL_SPACEMIT_K1 should not default
 to y unconditionally
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-gpio@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:06=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Merely enabling compile-testing should not enable additional
> functionality.
>
> Fixes: 7ff4faba63571c51 ("pinctrl: spacemit: enable config option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied!

Yours,
Linus Walleij

