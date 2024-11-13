Return-Path: <linux-kernel+bounces-407399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB69C6D08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732A9B26AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75971FE0E9;
	Wed, 13 Nov 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fj4IeXX4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC01FB3D4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494149; cv=none; b=jEXpzAekm6eAZ3l9YTTvvqLscY7cdtq3j7HeULX/Pud39A5plxgQVxzOxY17TRBAOgimmUKr+nasyv/4yrjKfNWaoq/sWOjAK1YJuPAqM2Exu+KZPfCrmR6Xi3LXgP4d2bWzW8Mfyx+VrQR3K5mNBwByRfTrSpZ+Ny3gq2IK5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494149; c=relaxed/simple;
	bh=tvSQveL4ZNKaT17R19YRy4ou5GvUrxgvspZno4PsLPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5hgXhPsLGEoLF2C+qrUoPNTsaR6Xb5hsw8r1hhavHzBZStznybNr3hfqEeIRYWYZEpoKY5yDDgDn4Bko2GomQyK/iRcFGLjJYFy/sQ5ZqHHaBwjr1aBoxuQnriICGdPLsGVe37G+vaJknT9tck/F/fzNJ8Rs8abqKa9Fud7z0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fj4IeXX4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso59022461fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731494145; x=1732098945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvSQveL4ZNKaT17R19YRy4ou5GvUrxgvspZno4PsLPI=;
        b=fj4IeXX4XiBLvuA2rPdndYu80VmdUg09rbAnv+dcr7MGhyAwjSLzWInBkUUJld+HEK
         WuboBVHh2ZgcyFGs1A720iiqtC5roOZwoBeg66N5NwlnYH1hjR03t/X9oAglYlE/+fLX
         D8GAvSXCRg/AMRvs3Xal0PTTM+ZYOj2uPZPbPviTuViLpkdyAzcFSMFesj0haErXCn5Z
         beDfu1GgfOCY1a7zevuQjC5O/0Yy2BLW3Eyl3mCMbn3PZIAIYJ4PZLu+Lxh1mVz+gSO6
         qdsGzbmk9XqCDBEAEdUYaPntBsuDY72/GFsgnSOqIxZv97WGvHWCL4REpf5DTHpTq68G
         bhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494145; x=1732098945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvSQveL4ZNKaT17R19YRy4ou5GvUrxgvspZno4PsLPI=;
        b=bVmXAufHKefN7qpYf2CuR5Kup7cL7/u7Li+xsV7F4a0RV4GIOJEhUq7MyqN9oA7FUG
         n6kGm8R7UCV4uPL7JaGj8E/0l7fykcpUaJOK/hF1spaFEhlUZ9Ou82LUX+VMSgRmWWol
         4X72S8M9PYg3ZAFOyMisG1cARsXWZ/fcO0pwSTDo2qNc0euFhJebqRgiecTFwL/TrR8i
         6pBJu9ic6t88ZQpKcQbCTuLBGOv3n8xbeT6Ex/6EWVpIfDGbgd6CiT3q32168I8NSc3G
         DXTJ3rm+BCFBvz7gZ9CO4cq0t8Sh4ChDKOxdfNVITHlnzIaXGKcFYZJWGGAvCmQEF3dD
         UHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIr0zOFZENZsI5n2STBqUcW9B9VcIhBi9jNLZa66R5Xx4XjT/rsWTrrm5nJAnJyAap82sVucRA2Me4XBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaL0Zm+aVhpcaTHRHCo6Vi0cw2792cGMmRRmXVijjcMFmFM5dy
	reS46ebGbut8Z7IqK3Pib1tcEPwIBi+zzCW+ATAWZV8GRMdQuGTYx/InJhm7n+XEnOi8HRSWre8
	ufv8E6yQuhyD0b7fUyGpI6IQK8jl4vSQvYUQ1Hg==
X-Google-Smtp-Source: AGHT+IGO61t/piOQ54Ce2aHGK+yl3sQvYvS7vWigZwnBMLRlsxtH474c/h1XAYOCKrPLFzb2ccMr1lF7r/2+NuZ2ju8=
X-Received: by 2002:a2e:a913:0:b0:2fb:5d2c:7509 with SMTP id
 38308e7fff4ca-2ff201824damr96451511fa.14.1731494145249; Wed, 13 Nov 2024
 02:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-sa8775p_cpuidle-v1-1-66ff3ba72464@quicinc.com>
In-Reply-To: <20241112-sa8775p_cpuidle-v1-1-66ff3ba72464@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 13 Nov 2024 11:35:34 +0100
Message-ID: <CAMRc=McEjDbhuUV9zEBfT+OUHLS3ARYFvSMau=eXsomh2yiavg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: Add CPUs to psci power domain
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_lsrao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:22=E2=80=AFPM Maulik Shah <quic_mkshah@quicinc.c=
om> wrote:
>
> Commit 4f79d0deae37 ("arm64: dts: qcom: sa8775p: add CPU idle states")
> already added cpu and cluster idle-states but have not added CPU devices
> to psci power domain without which idle states do not get detected.
>
> Add CPUs to psci power domain.
>
> Fixes: 4f79d0deae37 ("arm64: dts: qcom: sa8775p: add CPU idle states")
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Which reminds me there's this comment from Konrad that needs
addressing too[1]. I'll try to make time for it this week.

Bart

[1] https://lore.kernel.org/all/06895dff-bdbf-4dfd-8f00-ee850297ec12@kernel=
.org/

