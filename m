Return-Path: <linux-kernel+bounces-256513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A0E934F87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01919B23FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F6144307;
	Thu, 18 Jul 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IyNVlFh6"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4A1442FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314790; cv=none; b=q3d2gIJ+5ZHw62YEy44X3wNIVo9cfDLcMXWBDAragCJ+Wjda9LJNiW2y44WcsqVGxUWGDGWUCjSTziAf/RJ15fs0doPXyPXZauNOhQZiiDPU5CONz7tbgzkmEwev0VDNb4oDiazns60qypopTJeSRNMBJU51Z99At2JC/aylaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314790; c=relaxed/simple;
	bh=e3SitwwNRxOezNxrVf7ltI49ObqvXDJq0gyT1yrldMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VA6kZemgDhE+SkyGUXuuIrdK2CKM4i+jB4MGxAtwK1pBPKUTivnos6bFDiI9Y0wJAxeLqj/+UO4CzzNJIqS+cIEzzI9BwdNddHUObFayk8iz1bCTiWsPB75wO78Gm8Jj1JvjQ5gBno9UKWItRvYQWfHvBacApcTnprXjxh/spM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IyNVlFh6; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e05f2adab8bso914842276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721314786; x=1721919586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3SitwwNRxOezNxrVf7ltI49ObqvXDJq0gyT1yrldMw=;
        b=IyNVlFh6WVlm4CJANTeN4QYuMVSJotgPnddGLfyzIhovgU8E2MVhcaYcbsSrr/Yes3
         H8k71X7olXOTCVrrVUgI/vQRc3enP50rktjLmdi0sX7I2RCUUihzKKdfHAuvjgSh3oL5
         dwBBASADhkLXEjOKKCEmhSdGh29QLzoRWMut0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314786; x=1721919586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3SitwwNRxOezNxrVf7ltI49ObqvXDJq0gyT1yrldMw=;
        b=tdz5qsjSG+9rZHCDkn2z2u4wAlqE3FOTRYynw5m+uTV8TQcgrFnbQhZyy9srvhxjwn
         6efpgBwgdcpBkuxsw8DtGWhi33hUst8dayerWvyX7iJuZhsxpGEujQkzBphybO56r58J
         fixnQdZzksLD8+OuTZsukXKKA043VBERnqP68Mrp9qe/weA4T3LjaUqEdCnZndmnKgfz
         yPzXqIpHnYw3j57npX4ceQfYwoBjygTnH7nTKpnVdBq9nr0A8nDmaLPhsaGZyF+ZORdm
         hC7BnRub2KmtbGjasvXzuUUuQ+Dq0JdNuWtqpbOSAoZ9nD75paNIphlQKQjOjDnJCAzo
         cyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiNIOBHJBiAn54bnRTDKSwOoBGje9EOLBbw0XvlW4fRzIUs38wEQegVVPbbdoo+6JD5APKSN6aLvWAo/d0ZESUjkpj9gW9FRqDc6rm
X-Gm-Message-State: AOJu0YwKXhjOwn0XVVsvRj4SRJ5sngGnLrtw+m5D1flt8CdyiVg8G74G
	ABD76tecAJ1d3nbl/QfX8DuC2RruG+09Jb8k/1BLwCg7V706yAp3MzukDe+8HKZxMAoaQvCmYNA
	=
X-Google-Smtp-Source: AGHT+IFsSsL09Dzje4ADgiEGkIYTX8VZlcpCgtM9WIWWbL2OS9/VLjQ/bWoiF2aCgoM6m7bABHM0MQ==
X-Received: by 2002:a05:6902:2689:b0:e05:d905:63f with SMTP id 3f1490d57ef6-e05ed719537mr6228176276.28.1721314785648;
        Thu, 18 Jul 2024 07:59:45 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c667795sm8715536d6.128.2024.07.18.07.59.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:59:44 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44a8b140a1bso111831cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:59:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGrZhryo5h0MJ7YSp4KbLkx1zqD5asweeJt5UnOYxoeUmftJdWSt/CfTehv07QsDjehu7afgUgfc65N1dFMcPCFXyQIT6zzjxIo9YC
X-Received: by 2002:a05:622a:1f88:b0:447:e423:a463 with SMTP id
 d75a77b69052e-44f969881c0mr1553511cf.3.1721314784304; Thu, 18 Jul 2024
 07:59:44 -0700 (PDT)
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
 <20240718-frightful-naturist-a049ea7c0548@spud>
In-Reply-To: <20240718-frightful-naturist-a049ea7c0548@spud>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jul 2024 07:59:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaGXMf6Srix6v=Me35BUN4B6ZHwebycka4Dbavqa5Vbw@mail.gmail.com>
Message-ID: <CAD=FV=VaGXMf6Srix6v=Me35BUN4B6ZHwebycka4Dbavqa5Vbw@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 7:56=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Jul 18, 2024 at 07:45:57AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Jul 17, 2024 at 11:19=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> > >
> > > On 18/07/2024 02:21, Doug Anderson wrote:
> > > > Conor (and/or) Krzysztof and Rob,
> > > >
> > > > On Mon, Jul 15, 2024 at 8:31=E2=80=AFAM Conor Dooley <conor@kernel.=
org> wrote:
> > > >>
> > > >> On Mon, Jul 15, 2024 at 02:15:37PM +0200, Stephan Gerhold wrote:
> > > >>> The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has back=
light
> > > >>> control over the DP AUX channel. While it works almost correctly =
with the
> > > >>> generic "edp-panel" compatible, the backlight needs special handl=
ing to
> > > >>> work correctly. It is similar to the existing ATNA33XC20 panel, j=
ust with
> > > >>> a larger resolution and size.
> > > >>>
> > > >>> Add a new "samsung,atna45af01" compatible to describe this panel =
in the DT.
> > > >>> Use the existing "samsung,atna33xc20" as fallback compatible sinc=
e existing
> > > >>> drivers should work as-is, given that resolution and size are dis=
coverable
> > > >>> through the eDP link.
> > > >>>
> > > >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > >>
> > > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > >
> > > > Can you comment on whether you would consider this bindings a "Fix"
> > > > since it's a dependency for later patches in this series (which are
> > > > "Fix"es) to pass dtbs_check? See:
> > > >
> > > > https://lore.kernel.org/r/4bca316a-2334-425b-87a6-e1bb241d26b5@lina=
ro.org
> > >
> > > The patch itself is not a fix, for sure, but it might be a dependency=
 of
> > > a fix (which you wrote above), thus could be pulled to stable as a
> > > dependency.
> > >
> > > I do not care about dtbs_check warnings in stable kernels, mostly
> > > because dtbs_check warnings depend heavily on dtschema and dtschema
> > > follows mainline kernel. Basically if you had warnings-free v6.8 but =
try
> > > to run dtbs_check now with latest dtschema, your results will differ.
> > >
> > > At some point in the future, I could imagine "no new dtbs_check warni=
ngs
> > > in stable kernels" requirement or at least preference, but so far I
> > > don't think there is any benefit.
> >
> > In this case it's not about whether it makes it to the stable kernel
> > but about which main kernel it goes through.
> >
> > If we land the bindings in drm-misc-next right now then it'll be a
> > long time before it makes it into Linus's tree because of the way that
> > drm-misc-next merges. It will make it to Linus's tree at 6.12. You can
> > see the drm-misc merging strategy at:
> >
> > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> >
> > If we land the dts change (a fix) through the Qualcomm tree as a fix
> > then it should target 6.11.
> >
> > This means that the 6.11 tree will have a dtbs_check error because it
> > has the dts change (a fix) but not the bindings change (not a fix).
> >
> > One way to resolve this would be to treat this bindings as a "fix" and
> > land it through "drm-misc-fixes". That would make the bindings and
> > device tree change meet up in Linux 6.11.
> >
> > Did I get that all correct?
>
> Is not not fairly established that a dependency for a fix can go onto a
> fixes branch even if it is not a fix in and of itself?

That would certainly be my take on it, but DT folks confirmation was
requested by Neil in:

https://lore.kernel.org/all/4bca316a-2334-425b-87a6-e1bb241d26b5@linaro.org=
/

-Doug

