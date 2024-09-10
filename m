Return-Path: <linux-kernel+bounces-322421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE599728C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F3728604E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC1152178;
	Tue, 10 Sep 2024 05:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DE9ypckK"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9F12E48
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945177; cv=none; b=uQ1l1M5pEDlTOV1i0osJdlRfZwlwE1bg/jj4kTrGNBcByMuxMI0pbrdMKpAgRYXFPzI+96+Kzei9rZpoKyBLMiqdeMgf3MHc0Szgh/s46V8bv45Gozjqlxnnstnee7wtYcWZBR/njUn0r2EYz2z2x/Kt9sG11wxxEVNSLh+SHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945177; c=relaxed/simple;
	bh=SRCKJ1TrkK26NnYDeLp7tM028WOKA5Wx4S7iWKHzP3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOP/7pVqBWqk64XYFbwPCgj307DRMwyOsw7wNbWF92ZEICjVbhm/sFpe45qA6xw/HpWY55jL+TwyvCRvMGLd1xq3holQl9OzZwKHGZQPjoipOzwzWgOW0sTx1a/GPaWoMvcHrr1BJ5HqlkMcBaVi8XgJwNFu8Pt7wZGlwqJ1IkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DE9ypckK; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-846cc83c3c4so1434591241.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725945174; x=1726549974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FftjutXCeiXVd5sNpriJUhOjNiXDvzsDr14ccTGO5ro=;
        b=DE9ypckK9zUcgSrj41oV8vFqS1IYzAcyUX1Md1DIJ1oUoI449dyRSYoK8IS5vm8wDx
         8VphXL0QZ0G4JgE/q0H28KrSXFhct3Qs6dCRYdtkyDAi5J2akfb9UdLqn7uJoSA6VTiU
         IntcXfbfV2SquMF8GLxH0Q8S/nrqTQil5lv6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725945174; x=1726549974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FftjutXCeiXVd5sNpriJUhOjNiXDvzsDr14ccTGO5ro=;
        b=cLyp13WMQN/+du+Y2s2zCmgEbkMO9YR1rJp8mjadszNa9deDUpyjjizndI3WVr8GK1
         1z7EdxJfM3a+aoSLf0QP9eyxlLsed2sFvVTq/QvsvU62vriOGBEK3MJrIk2NydvmaAGj
         xJ4ylkliHkTjdhdLY4lbh/1BoPYRRZK+uXwbaMKkxesioOFRNLKy241fJByi2Ql9wmuo
         nozYLdnQLZhScC2me0C6EKO8UvYtuLUPRBCgWbB2l+MPTa5G2CrioShSREajmYHqlekf
         lzkq2/ROtn6CW7aCU/EqFcZ4sCrd9F6GBC+0eVbEhFbLCHrXzsJgXA1Nwe2QtmcNUSEz
         QK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8tMXSPoXVCpnySdaQfSj83RzVzVNqZ/glN7uyGH+w57S6TEqB3N50ZUP2jbc/FrbgdgDVQ5G3SvZnEfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ofuf5q6+rReuCln9j1CSz50ANnklB5MtbDk9OAj9C8u5IODp
	reXojhPlDG9yENTdk26wl5cyg0X9FyW2iUIP7lezu0e+LMqyK/zoST62eBooTd6d+awJ/1hsLUl
	Rdw==
X-Google-Smtp-Source: AGHT+IFnRXh65XKo8dO87JaaZ4N+CHWD7QpwAAJilCC25YbRjkc+twgmCzZtMp0boCMTi6lQJ5gJ/g==
X-Received: by 2002:a05:6102:3750:b0:493:d325:4d71 with SMTP id ada2fe7eead31-49bde195c4emr15882875137.9.1725945173645;
        Mon, 09 Sep 2024 22:12:53 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49c16ced6e5sm147382137.20.2024.09.09.22.12.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 22:12:52 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846bc787b3dso1476456241.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:12:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxkuT87GpVycqB1GRFeJYjnUW9xT2BzinR5Di03WcZPvvd3OO+PRkGSz0+dEtuw7tvPbVzahca4FKl+48=@vger.kernel.org
X-Received: by 2002:a05:6102:304d:b0:494:4fdb:f42a with SMTP id
 ada2fe7eead31-49bde2e784amr16042770137.26.1725945172144; Mon, 09 Sep 2024
 22:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909111535.528624-1-fshao@chromium.org> <20240909111535.528624-7-fshao@chromium.org>
 <11bc2522-bc10-4dcf-8142-708b57d181cf@kernel.org>
In-Reply-To: <11bc2522-bc10-4dcf-8142-708b57d181cf@kernel.org>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 10 Sep 2024 13:12:15 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhiJ=7yAucJsaYKUUBrwrxOVBMB2CF=bFwyLa2o-5RmWw@mail.gmail.com>
Message-ID: <CAC=S1nhiJ=7yAucJsaYKUUBrwrxOVBMB2CF=bFwyLa2o-5RmWw@mail.gmail.com>
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

On Mon, Sep 9, 2024 at 7:41=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 09/09/2024 13:14, Fei Shao wrote:
> > Use and add "syscon" in VPPSYS node names and compatible to fix errors
> > from `make CHECK_DTBS=3Dy mediatek/mt8188-evb.dtb`.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8188.dtsi
> > index 2900d78b7ceb..14e51a11f688 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > @@ -1799,8 +1799,8 @@ mfgcfg: clock-controller@13fbf000 {
> >                       #clock-cells =3D <1>;
> >               };
> >
> > -             vppsys0: clock-controller@14000000 {
> > -                     compatible =3D "mediatek,mt8188-vppsys0";
> > +             vppsys0: syscon@14000000 {
> > +                     compatible =3D "mediatek,mt8188-vppsys0", "syscon=
";
>
> If this was working before, it looks like this is not a syscon and
> bindings need to be fixed.

I guess it's because the binding was later updated in commit
26bcd8a53098 ("dt-bindings: arm: mediatek: mmsys: Add VPPSYS
compatible for MT8188"), and the corresponding DT update was unnoticed
at the time.
If that makes sense then this should be a valid fix.

Regards,
Fei

>
> Best regards,
> Krzysztof
>

