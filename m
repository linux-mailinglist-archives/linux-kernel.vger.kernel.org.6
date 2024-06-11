Return-Path: <linux-kernel+bounces-209514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E46903717
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB16B287CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC943176227;
	Tue, 11 Jun 2024 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZxDRYcU2"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D976174EEB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095927; cv=none; b=DIq0dHNdyinGm45omQXgRsVYTbe0jtrHki8rubtLKfdKN21m5GkMznixLFo/u8SMPu7Lv0AjmEXq+JV6wDFl94cGZMhuRA5cDDhSpMIYEDPW9twdBEGxtNZHaXP2CrFWLS3PjL5TA18ppu8KTMyGTLdrTDHVBe1xHKMMc5lQ0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095927; c=relaxed/simple;
	bh=UjgjmN27tt3nv48wIRQoWCn7PMmqaFPrHmBXuiyw5aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVzE3jIQx1bWVsFUbKFm5j+chOlvkhiSjLzEShqQ8x9oaDpFx/okRPbXKEUuhBGjV6Y/SJ4HpbY4aWnYX4IMdaCfGcGGoZQSYOm/WGrqMcd7o0mvFNJ08EMeKahFtydYtIXOhZADOVvN+4weBidcqR7lMhqJzu37neR+F8fXWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZxDRYcU2; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c9034860dso1598126e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718095924; x=1718700724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXby5sEGwA50yL3eB9wTqqKrctF2MCwrds0R1QAOu3M=;
        b=ZxDRYcU2CkNzT40Zdb4slamu0BLit6AUEuExyhcJevVrynilKB250GKUyOmMrJ2ced
         oaGa2ic9eucO02HDGBeJ6HnRxWDjm8ovj+rGR9Q5jxmztaqbx9rLQCz6hD9FdyitzWiQ
         0JtZhn2xo8PYa7UHIiEk/Q4qWZC2ErbxVGVOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718095924; x=1718700724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXby5sEGwA50yL3eB9wTqqKrctF2MCwrds0R1QAOu3M=;
        b=BK5qI7P+18vIu+wp6iVOgNSERWH9yvlmx2vIBGQOOnn+3ri7H6WhV1inpPKtoUSHLN
         fInmtmurHO3tACChEyhG8xgieGR+PSrigWhl0VfjY2QEXcMDcSR73gMeheq4Lv4gFmP5
         LsJSPbASmmo0p1SrPzmgVKuouk4hMQP+TQfdOeaUu6YpOExorueTBsz+4/GNhbLDH+30
         q+7zLyNSxJU5e5sBpUrmONuvWy8IaeM7w5cAmC3RPl3eMVyHYKNwhwUIURKaPs5DeajW
         LMalpeJ91bsg2WVyno+o6fMcOV3DLvLiJTym291geZmjIaAu5XgYpQ25Qv7WPwHYz3K/
         s0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUxPehco32o4Zn7MaqexWI3gZg3EF4n3yg3CZqZZ4E10jCORRdSntUInFXPv0C1vacYZ/wy5Hezg5Sa+A0T5o/EwJnqgqXOaoIg/66m
X-Gm-Message-State: AOJu0YwkVEHKoRBObs3YsKPL5Rc+iigI+AudtviVz+QaJO4SyWbnU04I
	RAJ+C2bJ31qpBGP7c3Owe1kCCMPagAxOtGfXfKITnVtNRHffQ0Mq1iRKB/YtwRok1eNkyjbFOEl
	fAWIOSXs5lFw9wvTXnSOE2TeHmkcE6iT7M1Ss
X-Google-Smtp-Source: AGHT+IFYphUGlrZqZKQrrag+fVIY0jtcRvcW+sNPtwLMe/Wn88bbM8NqjFo1Hi5FWlCxfkg3SgG5E80CLD1Jx+yy7nw=
X-Received: by 2002:ac2:4a69:0:b0:52b:bfa7:66a1 with SMTP id
 2adb3069b0e04-52bbfa766f7mr7667867e87.5.1718095923707; Tue, 11 Jun 2024
 01:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605094843.4141730-1-wenst@chromium.org> <CAFLszTjX=ixC3pRRGJeaP=ie_yc+KcCRyQ06MBFeSZnBepaXaw@mail.gmail.com>
In-Reply-To: <CAFLszTjX=ixC3pRRGJeaP=ie_yc+KcCRyQ06MBFeSZnBepaXaw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 11 Jun 2024 16:51:52 +0800
Message-ID: <CAGXv+5EcEYGqXq2C1OCK4J4t1NusV7nWp16zb74P6_tCeLnSGw@mail.gmail.com>
Subject: Re: [PATCH] scripts/make_fit: Support decomposing DTBs
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Devicetree List <devicetree@vger.kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:16=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Chen-Yu,
>
> On Wed, 5 Jun 2024 at 03:48, Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > The kernel tree builds some "composite" DTBs, where the final DTB is th=
e
> > result of applying one or more DTB overlays on top of a base DTB with
> > fdtoverlay.
> >
> > The FIT image specification already supports configurations having one
> > base DTB and overlays applied on top. It is then up to the bootloader t=
o
> > apply said overlays and either use or pass on the final result. This
> > allows the FIT image builder to reuse the same FDT images for multiple
> > configurations, if such cases exist.
> >
> > The decomposition function depends on the kernel build system, reading
> > back the .cmd files for the to-be-packaged DTB files to check for the
> > fdtoverlay command being called. This will not work outside the kernel
> > tree. The function is off by default to keep compatibility with possibl=
e
> > existing users.
> >
> > To facilitate the decomposition and keep the code clean, the model and
> > compatitble string extraction have been moved out of the output_dtb
> > function. The FDT image description is replaced with the base file name
> > of the included image.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This is a feature I alluded to in my replies to Simon's original
> > submission of the make_fit.py script [1].
> >
> > This is again made a runtime argument as not all firmware out there
> > that boot FIT images support applying overlays. Like my previous
> > submission for disabling compression for included FDT images, the
> > bootloader found in RK3399 and MT8173 Chromebooks do not support
> > applying overlays. Another case of this is U-boot shipped by developmen=
t
> > board vendors in binary form (without upstream) in an image or in
> > SPI flash on the board that were built with OF_LIBFDT_OVERLAY=3Dn.
> > These would fail to boot FIT images with DT overlays. One such
> > example is my Hummingboard Pulse. In these cases the firmware is
> > either not upgradable or very hard to upgrade.
> >
> > I believe there is value in supporting these cases. A common script
> > shipped with the kernel source that can be shared by distros means
> > the distro people don't have to reimplement this in their downstream
> > repos or meta-packages. For ChromeOS this means reducing the amount
> > of package code we have in shell script.
> >
> > [1] https://lore.kernel.org/linux-kbuild/20231207142723.GA3187877@googl=
e.com/
> > [2]
> >
> >  scripts/Makefile.lib |  1 +
> >  scripts/make_fit.py  | 70 ++++++++++++++++++++++++++++++--------------
> >  2 files changed, 49 insertions(+), 22 deletions(-)
>
> This is a clever way to discover the included files. Does it need to
> rely on the Linux build information, or could this information somehow
> be in the .dtb files? I had expected some sort of overlay scheme in

(+CC DT folks and mailing list)

I suppose we could make the `fdtoverlay` program embed this data during
the kernel build. That would keep the information together, while also
having one source of truth (the kernel Makefiles). Whether it belongs
in the DTB or not is a separate matter.

> the source, but perhaps people have given up on that?

I wouldn't say given up, since we haven't agreed on anything either.
Elliot had some concerns when I brought this up earlier [1] though.

ChenYu

[1] https://lore.kernel.org/linux-mediatek/20240314113908471-0700.eberman@h=
u-eberman-lv.qualcomm.com/

