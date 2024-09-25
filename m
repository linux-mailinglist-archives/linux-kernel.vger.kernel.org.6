Return-Path: <linux-kernel+bounces-338424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E4898579F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B4FB24898
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB1E147C79;
	Wed, 25 Sep 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FK3mlRDx"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C0482D8
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262429; cv=none; b=NZ/IRgcKO4hittTNDfHrvrNDcO3PN9k+/NJcHOI+HeZvugn5ggpPsSoRoVAT4JWj8Gl3Q6Z4eIB8HeqmN4xU9xsa7jfDJ1jXdxBXfGG3k4phC8AMcvLGurLq5B116z4zV2B/RNbqz5uQJGqesxmny4kwkYC1kpala0o1ziAJXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262429; c=relaxed/simple;
	bh=yngx82xgIdWukmGKi/xseBo9teitA0cjSgQBreiIuxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9qcdiQbXjR13ZEl4Z5imxgZhWdiy6+8G+erfA2OkPIh/YmiNguvHaIIsyh8Yo2Y/3z424fq7x8ihXlywL6t0DcrbA5Ns1/zV741G8X7s/qiGgh8az6maFE+UyibaIQE4VSeemDyLxl+nHZ4L7fo0adY0HX0BBJsLK+jNJhKn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FK3mlRDx; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-502fdbc6ac2so1951362e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727262423; x=1727867223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmGZlGs+csivCGtXApnSxfbFdZdlXt+4aKJTW7tsJ8A=;
        b=FK3mlRDxwSlrkVBB+YMNhyrAztHFndU626Za8vZb70x9u0rH8zHq/xQK6xIyAJLzGU
         9yCZaMYxxhXAc6MEqM7ZtJN/SYXzn9vQhdMyJZasLtxboSsrO+1YkPw8eyvqV0hdaqKn
         SZp7D2IzOlBGvGVGSQ5aTzwJ2Yk9QCWvTeMFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262423; x=1727867223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmGZlGs+csivCGtXApnSxfbFdZdlXt+4aKJTW7tsJ8A=;
        b=gVsFDivNfl7HPg9yOxOmI+Ec7Ejpr1QEaLNXwTcKdOftC39WdM0TAbxLdA99UssLYT
         qqo4H44gqcxJNJO86VTv5nf0LOR3UaKp9q7qja9LNc5DZAeuoyy+YcOtovh8+Jwp76pV
         NkWJu0H7aJBfIUCeMXdaFm9ZH9TBGloAADm+sHIEN5yoIfKhBGuhIiEEAZK0+NcVQM8g
         JR63jbyKH+eMPxnCKlQMa85uCTY+DwU24+0V6lMV0kwIpZM0SYSO9pzSHSzlvrMVbYvj
         QLFFI4y/yoSw/tIkTark4eHEv/EE79jg6MvDwuNQp/ugGhGG/Zddo1j7XbJVPxJs0Sh9
         yZtA==
X-Forwarded-Encrypted: i=1; AJvYcCUQASbFlbIjvORmPLqvTjBXUU6OPisiZ5RQKaHlz+19T9hFDq1QOlfJ7F4SwtcDTL2cZbLL8B1Me2xITPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFULgJt904Yeim5KlLsNjKvXwzJ81EFkYmAU5MSg17TjYpyRZ
	RAhTb2bxTiXMeXqnjvi1VOCGJEHAUx/3Slny1KbyVbG/Ldb1DOKl6DYBvTFFzZ1gQW6Rw0E0ZxT
	Pww==
X-Google-Smtp-Source: AGHT+IF5+BZ/fLltw0Rt1jDUbhATLb1weu6I2XbJ291p5XRI2EKeXvGaCEMUFMdas2PCT7PdR7Nxag==
X-Received: by 2002:a05:6122:32cc:b0:4f5:199b:2a61 with SMTP id 71dfb90a1353d-505c20922a8mr1814179e0c.9.1727262422774;
        Wed, 25 Sep 2024 04:07:02 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-505aa19e6besm1828938e0c.55.2024.09.25.04.06.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 04:06:52 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84e8aa83898so141805241.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:06:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCvlPwzjaYhrElgF4rfc2lShDDH63xpz0d9BniAS1j+GYvV6G5ORydIUJnuPtI0+xhI9fsAa1/Qci6bwU=@vger.kernel.org
X-Received: by 2002:a05:6122:32cc:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-505c20922a8mr1813469e0c.9.1727262405347; Wed, 25 Sep 2024
 04:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909111535.528624-1-fshao@chromium.org> <20240909111535.528624-7-fshao@chromium.org>
 <11bc2522-bc10-4dcf-8142-708b57d181cf@kernel.org> <CAC=S1nhiJ=7yAucJsaYKUUBrwrxOVBMB2CF=bFwyLa2o-5RmWw@mail.gmail.com>
 <64cc35c8-30df-4882-a933-f42119270f48@kernel.org> <CAC=S1ni+pJJZhbjvVqhba5u1JqGv=dZTv8+KH4xburea2AG4Qg@mail.gmail.com>
 <a9a7038c-4478-4366-831a-81dca8fa5afc@kernel.org>
In-Reply-To: <a9a7038c-4478-4366-831a-81dca8fa5afc@kernel.org>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 25 Sep 2024 19:06:08 +0800
X-Gmail-Original-Message-ID: <CAC=S1njoAwU+7aveWziJBD760k2LGD=D89Wwb9FmdaPp-sA5nw@mail.gmail.com>
Message-ID: <CAC=S1njoAwU+7aveWziJBD760k2LGD=D89Wwb9FmdaPp-sA5nw@mail.gmail.com>
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

On Mon, Sep 16, 2024 at 6:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 10/09/2024 13:06, Fei Shao wrote:
> > On Tue, Sep 10, 2024 at 3:19=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 10/09/2024 07:12, Fei Shao wrote:
> >>> On Mon, Sep 9, 2024 at 7:41=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>>>
> >>>> On 09/09/2024 13:14, Fei Shao wrote:
> >>>>> Use and add "syscon" in VPPSYS node names and compatible to fix err=
ors
> >>>>> from `make CHECK_DTBS=3Dy mediatek/mt8188-evb.dtb`.
> >>>>>
> >>>>> Signed-off-by: Fei Shao <fshao@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
> >>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/=
boot/dts/mediatek/mt8188.dtsi
> >>>>> index 2900d78b7ceb..14e51a11f688 100644
> >>>>> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> >>>>> @@ -1799,8 +1799,8 @@ mfgcfg: clock-controller@13fbf000 {
> >>>>>                       #clock-cells =3D <1>;
> >>>>>               };
> >>>>>
> >>>>> -             vppsys0: clock-controller@14000000 {
> >>>>> -                     compatible =3D "mediatek,mt8188-vppsys0";
> >>>>> +             vppsys0: syscon@14000000 {
> >>>>> +                     compatible =3D "mediatek,mt8188-vppsys0", "sy=
scon";
> >>>>
> >>>> If this was working before, it looks like this is not a syscon and
> >>>> bindings need to be fixed.
> >>>
> >>> I guess it's because the binding was later updated in commit
> >>> 26bcd8a53098 ("dt-bindings: arm: mediatek: mmsys: Add VPPSYS
> >>> compatible for MT8188"), and the corresponding DT update was unnotice=
d
> >>> at the time.
> >>> If that makes sense then this should be a valid fix.
> >>
> >> Not necessarily. Why not fixing bindings? Prove that bindings are
> >> correct, not DTS, first.
> >
> > MediaTek's mmsys doesn't merely control clocks, it also provides
> > display pipeline routing control and other misc control registers, so
> > it's appropriate to categorize it as a system controller over a clock
> > controller.
> > As for vdosys and vppsys, they are likely variants or aliases of mmsys
> > introduced in their newer SoCs.
>
> Nothing like that was in the commit msg...

Just for a record, I've revised the commit message in the newer series:
https://lore.kernel.org/all/20240925110044.3678055-7-fshao@chromium.org/

Thanks,
Fei

