Return-Path: <linux-kernel+bounces-379588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D4E9AE0C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CCD284F86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4D1C9B62;
	Thu, 24 Oct 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycxO4BaK"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B71C82F4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762078; cv=none; b=hyFE+YTagGUULe/U+uxV3v+FiPfcyJpFozd6jAjoNcGlEKT0oCMEpsCJs7R+N5zXncH/Cp3za/t2LEBcmYq8xYwe80UAv3ToATmtIsatxdBuAhQOoQRTFaFkGetQdDSu3Ee59N1ZEXh0ECWVuxivIPOXibi3VR/yt++oyUv1EoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762078; c=relaxed/simple;
	bh=OTTSL0onRwR6qnuOaToi0TOaX8bNt+SPYrxwG1+ZZ0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQYWTvbG8UCtB4ke8flDuBVX2L8Z0tGBye2KigRjp8bm0LRxx7t1/q2qaA796/jRn+dBrzquYbruCQEB2cQbORmAJMhKTfUEaTttTIJGqftC3aG3Wq87tVzVdIZl0NIRJfHnn5kHShf0Dk61GWg1JMCAiqDrBIql2P6+9Cs09J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ycxO4BaK; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb443746b8so6587311fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729762074; x=1730366874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vw44/IGDHGVtbRZSIkwW6dgCJnRfKhP9Fg+fqXK0gU=;
        b=ycxO4BaKKBS6aXBxPORIdAnjbabysnwLvZDgNYN1IXLOMcHznRxOhWQLyJ9XMZWigT
         uSsABTMNb/NCSb2GNOVeapRPZWY7WzQDjj/CAvNH8K8nA1m2oQbum2yNdSBn9u+kYEAy
         eWzHX9xCd+RE9XwEUjJrNcU7qLGMI2V+pklGEOnmQlZzpavb6XG2kT99IRtQU/SaqfT5
         MfocrG3cfHpo9PUXPQlwk+Qd+yBUdw7yopI6LsYc/R1P1ZJK4bLV43fPixKYhfpVgikO
         ZxfYA5Zo5YGtWkp96Pw5AAfACTK4sOnWkDz7LKABz/JEQbYlK5QZGijgcZkraH3G8ARe
         uFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762074; x=1730366874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Vw44/IGDHGVtbRZSIkwW6dgCJnRfKhP9Fg+fqXK0gU=;
        b=VCDcgFFvQJYEqsN6NGzU/bBM5depfYFEH0fUM0hfTavRb4lrMEMzT1fZnyOHgwsnmT
         MlFK9QwJb5nSLB8nSaNP3WeU/5DRGj6dgpEQ+ieakUOZ4ivGF6DB7QR1e2UR9m1s9X1y
         BcFHsM90U68jX6b9C7o8L5nPW9R96806GguM8D884RYllqrquQP7HkJ+bmwgFjsjB3vS
         idon5uxcF8afFFqFYSjlJWrXVacBou6yBThmqMUY8SHBSOYyKqmKmEeGbXdn1anh5KsU
         /B9IYL5E2CA2HkgFE4gYEC//BX6iNuRDKtzeCzOGse08/dYs2+V+KwyGHT2qk8cW5p8T
         x48A==
X-Forwarded-Encrypted: i=1; AJvYcCXI/E+JYQxsDpCxjl+RRY1PJHzAEEg0ckgrkANEnwkZdToBUFfir/8bgs7ucGrcwRqkTjSPy1KFvSVN700=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vf03wYdV+PD1xvTOy7/zdGiGNPUYKXG+1DVc8TfzY6Uq1+0w
	dLVOcf82DuuDTFPhi9iU+fVBgEJ4x/fhVl7c/7jFUeogjpiJZxHH1ld7WQ6ZLqo8YRXyS2a/EBZ
	T+fMe/BHfBUmS69+Bf9z91kh6PaoRTZ82ZsFU7w==
X-Google-Smtp-Source: AGHT+IHetJOx2pidhQpRaDpIjNHeL/hydkQIWL3Z96hrsPJKCCIgS3TJEmBSK/+jaQfDgZHeC3TUOPN5XVLUK3SwxLs=
X-Received: by 2002:a2e:6112:0:b0:2fb:5ac6:90f0 with SMTP id
 38308e7fff4ca-2fca8264708mr7213521fa.34.1729762074061; Thu, 24 Oct 2024
 02:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
 <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com> <87bjzalhzc.fsf@draig.linaro.org>
In-Reply-To: <87bjzalhzc.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2024 10:27:43 +0100
Message-ID: <CAFEAcA_+9gA3AqJseY5=5hHOA3OjuGS8bjbGMbpkzFyy7Ggzyw@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, qemu-devel@nongnu.org, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2024 at 20:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Agreed. However I think we were masking a calling issue that:
>
>     /* Actual RAM size depends on initial RAM and device memory settings =
*/
>     [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },
>
> And:
>
>   -m 4G
>
> make no sense with no ARM_LPAE (which the kernel didn't have)

QEMU can't tell if the guest the user wants to boot
understands LPAE or not; it just provides the 4GB
of RAM, PCIe window above 4GB, etc, and describes them
in the dtb. It's up to the guest kernel to correctly
handle the >32bit addresses in the dtb, i.e. if it is
non-LPAE to ignore those resources it can't access
because they're out of range.

-- PMM

