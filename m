Return-Path: <linux-kernel+bounces-199243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F248D8450
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5551F21F00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16312D767;
	Mon,  3 Jun 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dzq24K5z"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1221E892
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422464; cv=none; b=JWPv6Ndr1egHQMtgCdv8X4zxFd7kT3fjV/A8K0TYBLZxqJ5naY+Q+S6peT+h/lRRVvwKE9VCpslKp7yfT+B/LwQLBpf332+WAI901mLwhpoNkIYbayHhPgcP7DVBu7RcsC2K7D693z9PxsgsVwOzRgLRj04L6Vl83SOds8vlsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422464; c=relaxed/simple;
	bh=V4gNYPIOvr3vp9kBnIw41mzN2xWatoVZRe5XWVHddHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzvZ23XoUgvEOEGq7LZkVcUfa357E5Y95PQHVmay2/hvbXMf022BrxvBcQzPJ6vnRes+jjQUocapGWDSpGeMpHGpEpyLze1kDvSeHrz4o8MBwrz8W0F2geI+jnnz7t/RwwdbR4Uo/cA5sfbSNJ2lk3FryGXPYnCmSxYJdLd50Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dzq24K5z; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa80cb4d3so29253831fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717422461; x=1718027261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4gNYPIOvr3vp9kBnIw41mzN2xWatoVZRe5XWVHddHQ=;
        b=Dzq24K5z6L0Nrj6AyaNIQpV7t+UKh8gEEx/Gmo0UcHQOWG//1djREDTIwKh3Dnh/Ha
         oR8+uXzuFSnyZLX/Tz7A7ieb/JHncjDXfZzj33lVnqLs3MX98ALkFk5pK91MheZCoQOa
         g7FECWPKbu+ndbljzbF2ZLYbs1BSuI/Jwv174xacY+8+8E7Nuh4GyrcYpHDrnyxMADkH
         o5hkCVos5+Sw0Be41Biihhf/6RPjldWNwtri2ncmjPgXOSVlyxK/X4HI7FEda7jxc7Tl
         gEZ+Ls+6cyQCRZKS3FHhlVYv9+v3Q8j5s3ycRQZwKZQvgceGKGvLAzmlutJAr09n9eig
         I0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717422461; x=1718027261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4gNYPIOvr3vp9kBnIw41mzN2xWatoVZRe5XWVHddHQ=;
        b=NJdZhNuNIx6DRCNMl7E3EyvljZpkLL7iWByLqDz/9TwWo7wCcVVCCo7a4H8hLa1cSf
         lrrpTrTFG4RAevtLnQ+3f27cPFmpoAD7BGWBXcYNQ0wdEksYrDlPTHprJCNDNiQsnGP4
         A7kG6wrVFmjKMVqt0u+eYd6Oh45Cn2D1dFb2EJ1U129PwFTLjL+Pw7TbtHtT/N2kQQ4x
         Rvnrjd3/xI/i+XAJiOnZnnubyhXY/YcQQZkHRZoeRVna2VHhoP0Q53HwfyGroNOfp8iG
         GNOXhEqVVjZQ+qcBzQcR9OQJLGMtYI53AsBYB58s5j2JQAJMhHsFXbH469+K2UoZ12XP
         OMZg==
X-Forwarded-Encrypted: i=1; AJvYcCVE9S7ZNdMKzlU0GznTaLVKLaVb2pfvZortnuwW0q0/F28mr1MA8Y2wECRACwF1MjEbX7XPBQJE3dY2QsiyXXsLGgzG+f245F+CwoO+
X-Gm-Message-State: AOJu0Yy1/YK0ZXidMtKmB/UolZOWhS7N2taGE0Jp/1lMUqL4Zwhxwqa4
	9T+xfFfV/VBovEL/lK6HAO+YItERi30rhQjkNGZMG49FUjFozSE5+b5esSXYFCUIQ2uI1pn3e8f
	6lPP1fXROnt+qfIzkQTRY+L62gGZ/TgsK9iTSIQ==
X-Google-Smtp-Source: AGHT+IEpt9mEiBwx462z0TwmxjUX1qgVhvoSqlvGl11jCcymt+zoNyZs53TnD26H6wj0K+z5S+kL0ZkfxX7Lsa7T18A=
X-Received: by 2002:a05:651c:2059:b0:2ea:7a2a:4d1c with SMTP id
 38308e7fff4ca-2ea950e93b3mr71996701fa.8.1717422460944; Mon, 03 Jun 2024
 06:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316023932.700685-1-liuyuntao12@huawei.com>
 <CAMj1kXH5bpbagOO+WFwxp4=U=Kbu9RVbPrEemt80S7My1jTEdw@mail.gmail.com> <a800254e-f305-4adc-9d8b-fea8c5926539@huawei.com>
In-Reply-To: <a800254e-f305-4adc-9d8b-fea8c5926539@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Jun 2024 15:47:28 +0200
Message-ID: <CACRpkdYJkyqc5PkwTEdC=inqFHvZS4J9AoJOnBzxDB+wU6bZcg@mail.gmail.com>
Subject: Re: [PATCH-next v4] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: "liuyuntao (F)" <liuyuntao12@huawei.com>
Cc: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Fangrui Song <maskray@google.com>, geert@linux-m68k.org, afd@ti.com, 
	akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, 
	geert+renesas@glider.be, corbet@lwn.net, rppt@kernel.org, robh@kernel.org, 
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi liuyuntao,

On Mon, Jun 3, 2024 at 2:55=E2=80=AFPM liuyuntao (F) <liuyuntao12@huawei.co=
m> wrote:

> Gentle ping

FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I see you put versions into Russell's patch tracker, but please mark
these as "superseded" (you can do this in the web UI) and put in this
version of the patch based on v6.10-rc1 and tested. Basing on the
-rc1 is usually best for development work.

Yours,
Linus Walleij

