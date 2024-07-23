Return-Path: <linux-kernel+bounces-259969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A5F93A097
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E68282B61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0EF1514EF;
	Tue, 23 Jul 2024 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLQhEicG"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C713D882
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738839; cv=none; b=cutXmZhbJSUI4wrA+/TrwYu72Kd1emCe23JOaACw365a1Lnc2U0BUuX6oTIWDbH+2m9JeGbpAEpTRaqeL9cV4hFjfMBYz8d4rsUjHFev/+y8Z/cAhBe7zfxkIjvQTqcBqLJnlyztxSstmCkwQnBqGZhMI6cRaZixyjKyEPkkPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738839; c=relaxed/simple;
	bh=YEHgLym2+veongj2phCCEB8suXBp5Yuu9PdoQFXiQEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0WWb9FUfzWEAyjw0gVXlqVKSDzbfdMulrWMUBH7WGvWAfWoySR7cdlmCQmZula2A4ph8Ss0vqMArIML9TCiN++V9He0pNhf929/lVomFe9po9ZwOo8nhPJxnFghbb6ZpyYyYmRxnehdITWLXZx5ZR6nDsbDg3n7oSZravhY5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jLQhEicG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a8cada97so24059676d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721738837; x=1722343637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx5KF5sp0dGpt+UkFUhZxV/sTMJd4jMn+u8I+WkrEl8=;
        b=jLQhEicGB8ojKzhyWae+5Pc8kSCsdLIHSmb7fMct7oXMsi4pGa26eybKKz4Vod52y2
         iOdrUrVr+eMzQ/QLPoGdBRzs2LFdpKSb5DGFSNbea3uEcZez/w5stTl1S2fv89ZLzciL
         Qt3m2TGmOtwgOH8R7+Ei26FtCF14CR/fVFMRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721738837; x=1722343637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cx5KF5sp0dGpt+UkFUhZxV/sTMJd4jMn+u8I+WkrEl8=;
        b=PNNXZskJIsGbbIXJSjYnpEcuyqyP3Jd6lLsy+dDuwnZ6bcRSm0DkhTK/VtcUmB81tE
         PLNONs2y3Uu71ZYLmGfTd0TZuwaQWoO17AyCjMLmduWu8rI+zE5gIaGcjmrVxFkxhGun
         5ySQ58bjHf6j1VGfBZp4U4PFE04gqSYIE6Xt9IDkW11euEF4xVTelQAD9p27zoqEZ98z
         FRiuv4VOwD6htL814FUF2tkXsxJIBfmw5ecEpNgfzng5K2Gf9LCB5BLv6nArvubpozO5
         vDrmkq+bakbpPPnEmFcRV6BGMKjUWSjnUX8rVsKalPF0aPYZSfYt/a2GGWOnhRzBN6xr
         hOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkjrl7D3s9nlb772zbJUPBiUqti83LQo63PYIcT9CfAcyLd0gg6y0tC+AhXCRai4eVp+lwLi3c+4Ggtbov3fqCK2on3b5yBzJ2DKx
X-Gm-Message-State: AOJu0Yxpmcmt4UE4CF0uYIjNgfsI6zjrJwdSjdyWWfavjt0gB8Dt4gNx
	uweezlUrATJZipJlXnzjUHzLRdYZPPKR/MsoB8fkdOm6HYLOmKxOVuns7L1OH3OdpDTvOQij2sw
	nWBIOtpJ13BaIEnR2Obo7jd5kT1tBqpAgsyaJ
X-Google-Smtp-Source: AGHT+IH8KIrGbar8Gk0MjUCMNhFZfoCliFFLNO2aXE3mIqsfzJsBBRTqGdYennfWuzCRxew7Q6RAszahqV1ZHqMEZE4=
X-Received: by 2002:a05:6214:224d:b0:6b5:4e07:2a55 with SMTP id
 6a1803df08f44-6b95a6dffbcmr170409306d6.29.1721738837011; Tue, 23 Jul 2024
 05:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721133633.47721-1-lasse.collin@tukaani.org> <20240721133633.47721-16-lasse.collin@tukaani.org>
In-Reply-To: <20240721133633.47721-16-lasse.collin@tukaani.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jul 2024 13:47:05 +0100
Message-ID: <CAFLszTifgP3n_S1Rd6TPdntoC0d3R4qs4akj=LQm+prSVWP2_g@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] arm64: boot: add Image.xz support
To: Lasse Collin <lasse.collin@tukaani.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sam James <sam@gentoo.org>, 
	linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jules Maselbas <jmaselbas@zdiv.net>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jul 2024 at 14:37, Lasse Collin <lasse.collin@tukaani.org> wrote:
>
> The Image.* targets existed for other compressors already. Bootloader
> support is needed for decompression.
>
> This is for CONFIG_EFI_ZBOOT=n. With CONFIG_EFI_ZBOOT=y, XZ was already
> available.
>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jules Maselbas <jmaselbas@zdiv.net>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
> ---
>  arch/arm64/boot/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

