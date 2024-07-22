Return-Path: <linux-kernel+bounces-259158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D8939200
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005D9B21C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0A1E891;
	Mon, 22 Jul 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7JO4+ph"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F716D300
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663122; cv=none; b=n9SsGqK9uXfgFj8g0GBUinuAqlcOeiDHvcTvmlZCXN3ZKSRcIdrk5MUvZ+9N4lBk8Miila2L2e0OFeh2Jpkax2+XYiNTKsXUJKOuzh9y2QgYbnClnIaxpgEaqonIe2NbkkY9k2R6/Hf+DaBtYzGstQmUY7nG9QCiqc2ZCqg0fGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663122; c=relaxed/simple;
	bh=cFDJr/xGdVyJXbvejmGK81i2LvDjiM0dh/CdKN8HWuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3BHkTpsPi9e2dNaMLqdm0ushVdZcOXpDZck6Ye8hXfrffslCc8tuJGnzHVRX3fNUBYMFJdqUO1j35P2A+8Kc+W+28j1yZzc6hYTb7ShM9FQHCjqUelshMZZFpeXQe0+dHdMPt6tllmHZKRfZrglFpcOSdkmGfu7a3G9KFvhnG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7JO4+ph; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7acf213a3so17758686d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721663119; x=1722267919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDPtwwC5v8WJk5FRYY3avsIqqV6M4bWCFDqVrNinJ34=;
        b=H7JO4+phUOHzd+Pt1z4hxDYGS1LEChwF1VhJ/MBmO1UypK/taoywjgjGwpQhIhwt2F
         9gaEzHuOWMlY85ybRWu7v96ffzLxcCYTC/2dEZCob6eV2PT7gIKcCWArROIXnf06ARhw
         z0ZaX5p0K4XoBtyflzNwYpEVSqH9/6zLYQYPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721663119; x=1722267919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDPtwwC5v8WJk5FRYY3avsIqqV6M4bWCFDqVrNinJ34=;
        b=xTcxowzXO5UPqfz3ZoJsVhZUR6QGFv4v5RH8INRjadFB/P9aWrIXGlZWPD++K3qDhT
         UNKqPhHhuCWHm80AFyKvN3u569l2BaSArYfw+AuyLz7UpEC3dR7/ZSTdTnGn8U6pWSk4
         n23v9KgQRrJfNRQhodLTWqnAVWkOBfO009ss9blM28aaXkD8eyRtptsZ0O46Eg8ECB6T
         +fUxB1wqKoUkssi/bXcgC1BIXsKGfazrq9z87F3CDd4zFhYDNMDs5riyj3Iz/HRSabv1
         LrDn2axmWefhlgfsmZmUMHdtk8EzZ8VhCx3XdI9+OknLogs/MMWm/RJXUfnmSRImXHMe
         Z2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUD+JU3sh12HbxPvg0PU+dbPP4XUA8c1QcNH1gNANIH+6UZWlXQV0249AlZqzacouT1iiHkRUer9uKZ74uwGL3NjJz//dm57B/xDwHF
X-Gm-Message-State: AOJu0YyFuRu5BKELZrIyQEnfCz8HuuNOY1P5qKyU1uH1voXnnYJRL4MG
	r6j0MQfKewz5Ki3Jx7/H4KENvqfCrxJDyGzuxHS2E0+dZTs7xzv+RCG+Zj8zas8WJz/mj33sNT8
	=
X-Google-Smtp-Source: AGHT+IEbnNrcJN3dPaTPs2deYMvkwO0OWb7tA3jg8ohV363g8XNn3F3LoAH4nE5ORoZf9BpcL0I8aA==
X-Received: by 2002:a05:6214:c23:b0:6b0:90b4:1cb3 with SMTP id 6a1803df08f44-6b9610a697bmr76940596d6.32.1721663118622;
        Mon, 22 Jul 2024 08:45:18 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b97389cab4sm12017486d6.1.2024.07.22.08.45.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 08:45:17 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447df43324fso891311cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:45:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt7QEhJK61WR3BbzjMdde1lcYX6xSVlV1rwjhGOzzn/mahtCj+BgnVQ0FFpDeuKv+CJtFOY+NdWAG7ohzQL6UjBu1oNjvZi2x8xVK8
X-Received: by 2002:ac8:5f46:0:b0:447:f44d:d0ed with SMTP id
 d75a77b69052e-44faa973763mr4370471cf.1.1721663116858; Mon, 22 Jul 2024
 08:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-1-31b7f2f658a3@linaro.org>
 <20240715-scorn-canning-a7f23b9e2039@spud> <CAD=FV=U-nOMu-JDQ3T=ZRJ-rZ0BTtyzFVfnzbtCJdbRzAq3YMg@mail.gmail.com>
 <e017259b-bc62-4b57-9276-b834237225e1@kernel.org> <CAD=FV=VY5Ug3TfUo1RctiVQrHUjuod15HA8BxAyWdd_0bK8_Dw@mail.gmail.com>
 <20240718-frightful-naturist-a049ea7c0548@spud> <CAD=FV=VaGXMf6Srix6v=Me35BUN4B6ZHwebycka4Dbavqa5Vbw@mail.gmail.com>
 <CAD=FV=WyDF8LkPeHXTgsyDA74n+AjuHPQ1896ECDE17aYB9rtg@mail.gmail.com>
In-Reply-To: <CAD=FV=WyDF8LkPeHXTgsyDA74n+AjuHPQ1896ECDE17aYB9rtg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2024 08:45:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQRt2yVL4KZ0W3LWL2wybvL89NDb64fizMe42_vu=+7w@mail.gmail.com>
Message-ID: <CAD=FV=WQRt2yVL4KZ0W3LWL2wybvL89NDb64fizMe42_vu=+7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA45AF01
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 19, 2024 at 10:07=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Thu, Jul 18, 2024 at 7:59=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Thu, Jul 18, 2024 at 7:56=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Thu, Jul 18, 2024 at 07:45:57AM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Wed, Jul 17, 2024 at 11:19=E2=80=AFPM Krzysztof Kozlowski <krzk@=
kernel.org> wrote:
> > > > >
> > > > > On 18/07/2024 02:21, Doug Anderson wrote:
> > > > > > Conor (and/or) Krzysztof and Rob,
> > > > > >
> > > > > > On Mon, Jul 15, 2024 at 8:31=E2=80=AFAM Conor Dooley <conor@ker=
nel.org> wrote:
> > > > > >>
> > > > > >> On Mon, Jul 15, 2024 at 02:15:37PM +0200, Stephan Gerhold wrot=
e:
> > > > > >>> The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has =
backlight
> > > > > >>> control over the DP AUX channel. While it works almost correc=
tly with the
> > > > > >>> generic "edp-panel" compatible, the backlight needs special h=
andling to
> > > > > >>> work correctly. It is similar to the existing ATNA33XC20 pane=
l, just with
> > > > > >>> a larger resolution and size.
> > > > > >>>
> > > > > >>> Add a new "samsung,atna45af01" compatible to describe this pa=
nel in the DT.
> > > > > >>> Use the existing "samsung,atna33xc20" as fallback compatible =
since existing
> > > > > >>> drivers should work as-is, given that resolution and size are=
 discoverable
> > > > > >>> through the eDP link.
> > > > > >>>
> > > > > >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > > >>
> > > > > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > >
> > > > > > Can you comment on whether you would consider this bindings a "=
Fix"
> > > > > > since it's a dependency for later patches in this series (which=
 are
> > > > > > "Fix"es) to pass dtbs_check? See:
> > > > > >
> > > > > > https://lore.kernel.org/r/4bca316a-2334-425b-87a6-e1bb241d26b5@=
linaro.org
> > > > >
> > > > > The patch itself is not a fix, for sure, but it might be a depend=
ency of
> > > > > a fix (which you wrote above), thus could be pulled to stable as =
a
> > > > > dependency.
> > > > >
> > > > > I do not care about dtbs_check warnings in stable kernels, mostly
> > > > > because dtbs_check warnings depend heavily on dtschema and dtsche=
ma
> > > > > follows mainline kernel. Basically if you had warnings-free v6.8 =
but try
> > > > > to run dtbs_check now with latest dtschema, your results will dif=
fer.
> > > > >
> > > > > At some point in the future, I could imagine "no new dtbs_check w=
arnings
> > > > > in stable kernels" requirement or at least preference, but so far=
 I
> > > > > don't think there is any benefit.
> > > >
> > > > In this case it's not about whether it makes it to the stable kerne=
l
> > > > but about which main kernel it goes through.
> > > >
> > > > If we land the bindings in drm-misc-next right now then it'll be a
> > > > long time before it makes it into Linus's tree because of the way t=
hat
> > > > drm-misc-next merges. It will make it to Linus's tree at 6.12. You =
can
> > > > see the drm-misc merging strategy at:
> > > >
> > > > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> > > >
> > > > If we land the dts change (a fix) through the Qualcomm tree as a fi=
x
> > > > then it should target 6.11.
> > > >
> > > > This means that the 6.11 tree will have a dtbs_check error because =
it
> > > > has the dts change (a fix) but not the bindings change (not a fix).
> > > >
> > > > One way to resolve this would be to treat this bindings as a "fix" =
and
> > > > land it through "drm-misc-fixes". That would make the bindings and
> > > > device tree change meet up in Linux 6.11.
> > > >
> > > > Did I get that all correct?
> > >
> > > Is not not fairly established that a dependency for a fix can go onto=
 a
> > > fixes branch even if it is not a fix in and of itself?
> >
> > That would certainly be my take on it, but DT folks confirmation was
> > requested by Neil in:
> >
> > https://lore.kernel.org/all/4bca316a-2334-425b-87a6-e1bb241d26b5@linaro=
.org/
>
> FWIW, I'd rather not let this stagnate too long. I'm fairly confident
> in my assertion that this should go into drm-misc-fixes. I'll give it
> until Monday and then I'm just going to land this bindings change in
> drm-misc-fixes. Shout soon if you feel strongly that I shouldn't do
> this. If someone wants to flame me after the fact then so be it.

Landed in drm-misc-next fixes as per the flow chart [1] since the
"samsung,atna33xc20.yaml" split from "panel-simple.yaml" is in
mainline linux but not in any "rc" candidates yet.

[1/4] dt-bindings: display: panel: samsung,atna33xc20: Document ATNA45AF01
      commit: b6f7d984ebf826069d3dc6fa187b4d1cfb90f965

[1] https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.h=
tml#where-do-i-apply-my-patch

-Doug

