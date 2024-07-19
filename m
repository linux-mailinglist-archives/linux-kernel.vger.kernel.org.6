Return-Path: <linux-kernel+bounces-257529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E73F937B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D03281A83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986092C697;
	Fri, 19 Jul 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IuMfD/oS"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844D2BB0D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408868; cv=none; b=N7l8GTs4CChiKfSQ/hNWvf1EUKF3mnryqXPnwFRw6xb1bK1C0L6mXEE8QulNwEL7ieBAVrZumZYGJBRxq9HQ6TVCJqxvcDCNvoVWyR/UR3AORNbOAG6oPwUXJPG8YyUluyX9vWHu8XSwPctQjVRPVLPh3YSPBwbh7mXeA94+Zyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408868; c=relaxed/simple;
	bh=aWJBW7qSepD09tUcrnlrHVc592+V670R8bG1ncdQIrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzjf3I3TEZwXEi0FQufTEVsg0uKPfQWh/7GEsuTLPrUaw3s5UbjGbu8hZtm78v5A5Rqg6Tcx341M+9RnHrur5IkPE0L0ctj9yTeazT6enePMOVYyGTJZwOkhll3EeMiwLhrpxIJDFQzzSSRZGfGNg1UybIXYyxXuli0owRDD9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IuMfD/oS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7a4668f1fso10878536d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721408864; x=1722013664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWJBW7qSepD09tUcrnlrHVc592+V670R8bG1ncdQIrM=;
        b=IuMfD/oSX+ZZTNrShSJvhHrtFKQSOa8lTtiMU/71YMnAlmVq0bXtmAN70k4BJSaRhQ
         5lT81Od350D98U1kpxinFsPhRJYmvtHvr3zEC0hEBSLTZmORyFfQPiurDTN9zktsWtH2
         gWmsMY4RwAxDJtbrud6UfZvfZs4qElM4bVi3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721408864; x=1722013664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWJBW7qSepD09tUcrnlrHVc592+V670R8bG1ncdQIrM=;
        b=ojdiCd1RXUvfGQNBTHjBmKVlxRHf7CerRlIrzzk1E+Lz3T6CbRKM34/O+vkl2Su7vA
         og2z9N1GRit6S7fEFCspWcyaoTZcvoGKS/1h1tfn7/1c0Ael0itGdJZfdKZjkraf+nWD
         8gEcbQHZT2W6GSf9l5blUHBjkmNE5sKaqJP4wNCM86Pda3vZFFXRRHMZmJ8tqE3kdK8s
         n9m548LLelciuQtnRhXeKl6tJqfXt2nHMoSZUZFuiptWNKVIMhhMyMbmV0CgJ7UO5E2G
         TDUBbl3G4wY85mAPzAPARhlEymxGAo0OvjZMjgMhhxEv2o8wW8QvHHKqElzM+glhRa7C
         8kiw==
X-Forwarded-Encrypted: i=1; AJvYcCVeGXaXyNt8jINHQZSMvqGdRNBYGhCCcdJ/BEogAP+1Thh+oMFJVUhFXsSk4rumpGpoOVCSrusizBfMoWNrEQ1hl2k2DMYwsPxobLCM
X-Gm-Message-State: AOJu0YzotBYGXSXd3OnenurXPynP+VKy0Fzdl+8tw5HQnnHb0sHg5gdX
	7jh6OMvbR64EEv0g2fNZbTMmd0b5BIcRZp1k4Ll4zKySxdZp1hUCnm0Vt/Z91qHfa1lQLCkO+wE
	=
X-Google-Smtp-Source: AGHT+IE2EfaAsHJirMYvZu1E60AfFpcWUscI3sK4SqG3d0byzkNXmXm3vU2iYQ8bJ2Wb2aq79ecYeQ==
X-Received: by 2002:a05:6214:ca1:b0:6b7:431c:1b19 with SMTP id 6a1803df08f44-6b78ca1ea18mr96759266d6.6.1721408863912;
        Fri, 19 Jul 2024 10:07:43 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac9c3effsm9717666d6.100.2024.07.19.10.07.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 10:07:42 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447df43324fso310421cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:07:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0bU5FjUkBwzsxBYWQ3veSh3I1SunqjGxmhXFhrhnLbWvA2olN+6xSAsKVskvgRzV6X323Ksks+QNfHdduv2tBv/+t4wBALKlhp9sC
X-Received: by 2002:a05:622a:191d:b0:447:e0e1:2a7b with SMTP id
 d75a77b69052e-44f9c83d5d8mr2695131cf.23.1721408861491; Fri, 19 Jul 2024
 10:07:41 -0700 (PDT)
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
In-Reply-To: <CAD=FV=VaGXMf6Srix6v=Me35BUN4B6ZHwebycka4Dbavqa5Vbw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 19 Jul 2024 10:07:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyDF8LkPeHXTgsyDA74n+AjuHPQ1896ECDE17aYB9rtg@mail.gmail.com>
Message-ID: <CAD=FV=WyDF8LkPeHXTgsyDA74n+AjuHPQ1896ECDE17aYB9rtg@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 7:59=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Jul 18, 2024 at 7:56=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, Jul 18, 2024 at 07:45:57AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Wed, Jul 17, 2024 at 11:19=E2=80=AFPM Krzysztof Kozlowski <krzk@ke=
rnel.org> wrote:
> > > >
> > > > On 18/07/2024 02:21, Doug Anderson wrote:
> > > > > Conor (and/or) Krzysztof and Rob,
> > > > >
> > > > > On Mon, Jul 15, 2024 at 8:31=E2=80=AFAM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > >>
> > > > >> On Mon, Jul 15, 2024 at 02:15:37PM +0200, Stephan Gerhold wrote:
> > > > >>> The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has ba=
cklight
> > > > >>> control over the DP AUX channel. While it works almost correctl=
y with the
> > > > >>> generic "edp-panel" compatible, the backlight needs special han=
dling to
> > > > >>> work correctly. It is similar to the existing ATNA33XC20 panel,=
 just with
> > > > >>> a larger resolution and size.
> > > > >>>
> > > > >>> Add a new "samsung,atna45af01" compatible to describe this pane=
l in the DT.
> > > > >>> Use the existing "samsung,atna33xc20" as fallback compatible si=
nce existing
> > > > >>> drivers should work as-is, given that resolution and size are d=
iscoverable
> > > > >>> through the eDP link.
> > > > >>>
> > > > >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > >>
> > > > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > >
> > > > > Can you comment on whether you would consider this bindings a "Fi=
x"
> > > > > since it's a dependency for later patches in this series (which a=
re
> > > > > "Fix"es) to pass dtbs_check? See:
> > > > >
> > > > > https://lore.kernel.org/r/4bca316a-2334-425b-87a6-e1bb241d26b5@li=
naro.org
> > > >
> > > > The patch itself is not a fix, for sure, but it might be a dependen=
cy of
> > > > a fix (which you wrote above), thus could be pulled to stable as a
> > > > dependency.
> > > >
> > > > I do not care about dtbs_check warnings in stable kernels, mostly
> > > > because dtbs_check warnings depend heavily on dtschema and dtschema
> > > > follows mainline kernel. Basically if you had warnings-free v6.8 bu=
t try
> > > > to run dtbs_check now with latest dtschema, your results will diffe=
r.
> > > >
> > > > At some point in the future, I could imagine "no new dtbs_check war=
nings
> > > > in stable kernels" requirement or at least preference, but so far I
> > > > don't think there is any benefit.
> > >
> > > In this case it's not about whether it makes it to the stable kernel
> > > but about which main kernel it goes through.
> > >
> > > If we land the bindings in drm-misc-next right now then it'll be a
> > > long time before it makes it into Linus's tree because of the way tha=
t
> > > drm-misc-next merges. It will make it to Linus's tree at 6.12. You ca=
n
> > > see the drm-misc merging strategy at:
> > >
> > > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> > >
> > > If we land the dts change (a fix) through the Qualcomm tree as a fix
> > > then it should target 6.11.
> > >
> > > This means that the 6.11 tree will have a dtbs_check error because it
> > > has the dts change (a fix) but not the bindings change (not a fix).
> > >
> > > One way to resolve this would be to treat this bindings as a "fix" an=
d
> > > land it through "drm-misc-fixes". That would make the bindings and
> > > device tree change meet up in Linux 6.11.
> > >
> > > Did I get that all correct?
> >
> > Is not not fairly established that a dependency for a fix can go onto a
> > fixes branch even if it is not a fix in and of itself?
>
> That would certainly be my take on it, but DT folks confirmation was
> requested by Neil in:
>
> https://lore.kernel.org/all/4bca316a-2334-425b-87a6-e1bb241d26b5@linaro.o=
rg/

FWIW, I'd rather not let this stagnate too long. I'm fairly confident
in my assertion that this should go into drm-misc-fixes. I'll give it
until Monday and then I'm just going to land this bindings change in
drm-misc-fixes. Shout soon if you feel strongly that I shouldn't do
this. If someone wants to flame me after the fact then so be it.

-Doug

