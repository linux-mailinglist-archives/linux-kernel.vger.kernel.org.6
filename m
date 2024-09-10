Return-Path: <linux-kernel+bounces-322962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D279B9735EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0254D1C242D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DED18C327;
	Tue, 10 Sep 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Flu6vzaT"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1E18C324
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966445; cv=none; b=HZYCz6sSVyusoBkALdwPcWU+GxqbGfPggahbMp2a/ZzOxwf1QLlPHrWdgidCk2ocpVCddF+A+70bPxEuHaIyMmJqr/vK4XIHzsxrvosDD6gED1oHb5YCh0dYUPe2mRQRbCImeZapKdaezAmlVVExMbDEX7ykNup+iAjuP9AqIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966445; c=relaxed/simple;
	bh=eK4uMeRBoxgv1rnMmJ+cfL9Tu7lz3Cz/AV8ulzpHM8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSLNId1qbONItZNX6xDY/h55sYUBCA33zA0qlHw3dL8G8nD4stILNhARV7Dx4mVMyTsGXJWNbY7mFGolBEbHfqHT66RsKA3zBFbMGJZkfoLaX7PUzy2epZOF1Juma49DqqhPcpzt6X+jwDQVJqDNj5jBkoM1fGpmpnfvKfRAJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Flu6vzaT; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-277f35c01f5so2493364fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725966442; x=1726571242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9FpI4bl+ZGfp9SIboAslOt3vHYJy01BUP4KB+ndZUo=;
        b=Flu6vzaTaCSheOOpMFHFOPQBnUrcyhbxxLLCXEjjBUyqBScy83w3qBCY4hO4xhjLRb
         uu+cepq4VtlreTQRFOcHtpbreOPJ7EJEhzNl9tCIze19tkT1NYi32BhHm5azeROHrhO6
         Mu2s8FVkHH3qdx+vxJcUDSlLCbWwYiC54CGr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966442; x=1726571242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9FpI4bl+ZGfp9SIboAslOt3vHYJy01BUP4KB+ndZUo=;
        b=oYNcH8NfTBtSFxdqyTJRHnEvXemmeC8KmIzVMYcTuqao4AElZtMbm0ZqWJR1QD4hvh
         osw7oZDd4I41TYEpPnaMfm3P1vGxxuTjn+vUA8GWNKcosKwttfqeM5OheNXGrvNMBqKJ
         /LWa3ghql0KLVYmKnw3ZtMZ8QLwXp7vepMslAsH7EVwUn2nCCg+NfD+RaaxmjV00LYjS
         wgJlPB/T7r0LOxK6A0+IuYAolHn/gaqbD+LFcMZzFTfI/nSkl8r0/a70mtLD3fDRTHil
         jcQ7CG7xKT0oLbST8OEFcx9grb7AgsPKUExR8jSjfsiQyWN5oTCW6SS9I81o2iWzMfjd
         7Bow==
X-Forwarded-Encrypted: i=1; AJvYcCUj2IWD/KaUMpDns5u9UdF4wYBI1ZSHORG+SIyT1wV+Qu8UxbY5AwTxNwbF/g5cK7avS4jsY6doRZLyACk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmE2j67wImODtRjMuRZftyXMU3q2VCBclftjFPIC5ROu4yjsx
	PEmrN/WY0tWOdd0argELnHZsmqc3RlF0yN8+gVjabORaphpo3ac+VOiiZyMN9LH/tIMeX5A++7N
	wEA==
X-Google-Smtp-Source: AGHT+IEqr9lUQcH2qY1xD/Q6iRV/7+9czdV3LpSOa7q2Jw2Z9RUZsCmhOXxOM3pv8Zn53dZhaY/2/A==
X-Received: by 2002:a05:6870:170f:b0:25e:1ca6:6d09 with SMTP id 586e51a60fabf-27b9d922589mr6845903fac.8.1725966442024;
        Tue, 10 Sep 2024 04:07:22 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba3ea0684sm1990321fac.13.2024.09.10.04.07.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 04:07:20 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e05a5f21afso163326b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:07:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIi5+DUpJMX8HmTlfB8XvDmjs3Yp0FH9FfBd/KTOrAwjkzUQ7WK4DRcu0G3p0K1+qjbQVgO/q0XauVI6M=@vger.kernel.org
X-Received: by 2002:a05:6808:2dce:b0:3e0:3ead:2480 with SMTP id
 5614622812f47-3e03ead28efmr7407710b6e.12.1725966440393; Tue, 10 Sep 2024
 04:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909111535.528624-1-fshao@chromium.org> <20240909111535.528624-7-fshao@chromium.org>
 <11bc2522-bc10-4dcf-8142-708b57d181cf@kernel.org> <CAC=S1nhiJ=7yAucJsaYKUUBrwrxOVBMB2CF=bFwyLa2o-5RmWw@mail.gmail.com>
 <64cc35c8-30df-4882-a933-f42119270f48@kernel.org>
In-Reply-To: <64cc35c8-30df-4882-a933-f42119270f48@kernel.org>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 10 Sep 2024 19:06:43 +0800
X-Gmail-Original-Message-ID: <CAC=S1ni+pJJZhbjvVqhba5u1JqGv=dZTv8+KH4xburea2AG4Qg@mail.gmail.com>
Message-ID: <CAC=S1ni+pJJZhbjvVqhba5u1JqGv=dZTv8+KH4xburea2AG4Qg@mail.gmail.com>
Subject: Re: [PATCH 06/13] arm64: dts: mediatek: mt8188: Update VPPSYS node
 name and compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:19=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 10/09/2024 07:12, Fei Shao wrote:
> > On Mon, Sep 9, 2024 at 7:41=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On 09/09/2024 13:14, Fei Shao wrote:
> >>> Use and add "syscon" in VPPSYS node names and compatible to fix error=
s
> >>> from `make CHECK_DTBS=3Dy mediatek/mt8188-evb.dtb`.
> >>>
> >>> Signed-off-by: Fei Shao <fshao@chromium.org>
> >>> ---
> >>>
> >>>  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
> >>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/bo=
ot/dts/mediatek/mt8188.dtsi
> >>> index 2900d78b7ceb..14e51a11f688 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> >>> @@ -1799,8 +1799,8 @@ mfgcfg: clock-controller@13fbf000 {
> >>>                       #clock-cells =3D <1>;
> >>>               };
> >>>
> >>> -             vppsys0: clock-controller@14000000 {
> >>> -                     compatible =3D "mediatek,mt8188-vppsys0";
> >>> +             vppsys0: syscon@14000000 {
> >>> +                     compatible =3D "mediatek,mt8188-vppsys0", "sysc=
on";
> >>
> >> If this was working before, it looks like this is not a syscon and
> >> bindings need to be fixed.
> >
> > I guess it's because the binding was later updated in commit
> > 26bcd8a53098 ("dt-bindings: arm: mediatek: mmsys: Add VPPSYS
> > compatible for MT8188"), and the corresponding DT update was unnoticed
> > at the time.
> > If that makes sense then this should be a valid fix.
>
> Not necessarily. Why not fixing bindings? Prove that bindings are
> correct, not DTS, first.

MediaTek's mmsys doesn't merely control clocks, it also provides
display pipeline routing control and other misc control registers, so
it's appropriate to categorize it as a system controller over a clock
controller.
As for vdosys and vppsys, they are likely variants or aliases of mmsys
introduced in their newer SoCs.

That description was updated in commit 1a680aa888d6 ("dt-bindings:
mediatek: Update mmsys binding to reflect it is a system controller"),
so I just assumed it's correct without thinking much...

Regards,
Fei

