Return-Path: <linux-kernel+bounces-382117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167629B09AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58944284E52
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5014185B46;
	Fri, 25 Oct 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFXMV6hG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9017622F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873178; cv=none; b=Jvnly84Mw9TujTY99FJZZbY6s1TDcccXXB/601ZJ/ZfDg8rHVKbGjJ3d6QSmmtSX4LbBTaPHY2HJLy15DvZg1Br7VDNysomT0KFF5ODo01FggcoP6CdoeoxTcGOLy3PyQAVLfgjFWyQp11DpGeFfUkhYJIlba/Dgx8gOQI/EXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873178; c=relaxed/simple;
	bh=20kvON+allBWG+dOYdEwydFA2kFbEWyepoiWZBEaUn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z11WuG00H82fKUDe8lDAHKHRtPONPL2digj466tokoOY9DLLxJDY5imhLn132a8/3vnNkkhenNXiguItXd6oKRw9XIrTob4OZheEOP4LfG9tCciBZ+igZXORIK/dSc7lvaShIdwEHZDJaBlMVOjuUJN7dqagiZ6UygH3FAFr4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oFXMV6hG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso2153516e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729873172; x=1730477972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvhVvwnQMETeLbhAdwS48ux8c3HSfVAk89SUO2m7NmQ=;
        b=oFXMV6hG9ypjLVDNbGL0rc1B4OeRXvg0UnUM8GCIwQm3tuibYP0T/17ucARnNgiV8G
         MFk+KdGh+vdisizgfA7dyz1wdUZypF51cVekHN1P9tOtdifuhRh5AuPS1sC07duDOI0D
         PwnuM5kWzh/xpzVukjsC5FkMO3XaUuoTB32HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873172; x=1730477972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvhVvwnQMETeLbhAdwS48ux8c3HSfVAk89SUO2m7NmQ=;
        b=MrR1Fmk0RyK9UL29qyDUGY0vc2Gax+vDp6wcM8iP8jjGI77FJZSRjabDf6qoLQCwYT
         Ag4Kbry4O8Y4Fkc8vYTH0S/rcsA02N/n1UqwX80dnCf4QpD2sM3TXlm/TqN7529I+kvM
         yFs7Jnsa+Eu7ly8zwX1gqGmAupKd1JtwHc3CFhLosk8gDEnH8wyg6fhKwhg831xDocu6
         13x3mNV8BNDeDHQBT/xd0LA3NMqyTE7Jabki1RhMjJTOFjuQYvsJvycMr7JFP7ALTJFL
         bfRC3cfThAjNrtZnrRhTx33/rGTNuJIVHfTN+P2VFjLF8Pf23M7gjFMTjb5B+4tgsCOz
         t2mg==
X-Forwarded-Encrypted: i=1; AJvYcCXDB43dAh2WcqUbuvVlA5PF2nailUniHpmV9mwnCPlMGs11kRXXEF//IGE/7tOa7eYF/9QkBVFQvDSA25U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywo5aNUGRR/GusHSrKYYTYPJoeoJNdGhNUTVod7mrdSIDRYEIh
	CfzwWAQoURcvx/YbmIR3Kj+6C3TnMgJvke1C0kawQzabeGpjTOlReOILPcnpHJyHhc9GPyiadLg
	JgWiJ
X-Google-Smtp-Source: AGHT+IFnDk7GKEuQ8cWWMw0Vew9/4hqSeysVEpuw+9T6ad+F4/+F62Dpk+1y1xZaxqURc8/iDafIXA==
X-Received: by 2002:a05:6512:3d0e:b0:539:f035:e158 with SMTP id 2adb3069b0e04-53b1a30824fmr5075194e87.18.1729873171662;
        Fri, 25 Oct 2024 09:19:31 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e128957sm227399e87.101.2024.10.25.09.19.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:19:30 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so23340271fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:19:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzlfliLu/ZzNmuOXLfZMG37J+dnh/8SqGIR1EIg+2a/f0mVxOSl7E81GKF/XZAZCHootXhZeZzXCaKiEo=@vger.kernel.org
X-Received: by 2002:a2e:802:0:b0:2fb:587d:310 with SMTP id 38308e7fff4ca-2fc9d59ef65mr49259721fa.30.1729873169955;
 Fri, 25 Oct 2024 09:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025114642.40793-2-charles.goodix@gmail.com>
 <3ypn62dsgarvmxkmdglugcinxmvpmhdqub2zvkygaonn54odf6@amfgijfcd3l3>
 <CAD=FV=X1F3QC=eSXcCn-78iQBzHMzT3z9Sis3yXKW_Bzun3+EA@mail.gmail.com> <CAL_JsqLwOekE1mz+3g8NTE3o4GhE9PWwR1Jfk_tL0RYKQmCg-A@mail.gmail.com>
In-Reply-To: <CAL_JsqLwOekE1mz+3g8NTE3o4GhE9PWwR1Jfk_tL0RYKQmCg-A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 09:19:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHMfc2kJo2N3jkB9BR0H7SN2g9JqoDkZuZOOuq0OV6gw@mail.gmail.com>
Message-ID: <CAD=FV=VHMfc2kJo2N3jkB9BR0H7SN2g9JqoDkZuZOOuq0OV6gw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: Goodix SPI HID Touchscreen
To: Rob Herring <robh@kernel.org>
Cc: Charles Wang <charles.goodix@gmail.com>, dmitry.torokhov@gmail.com, 
	hbarnor@chromium.org, conor.dooley@microchip.com, jikos@kernel.org, 
	bentiss@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 25, 2024 at 8:59=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Oct 25, 2024 at 10:29=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> >
> > Charles,
> >
> > On Fri, Oct 25, 2024 at 5:03=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> > >
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - goodix,gt7986u-spi
> > >
> > > Compatible is already documented and nothing here explains why we sho=
uld
> > > spi variant.
> > >
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  reset-gpios:
> > > > +    maxItems: 1
> > > > +
> > > > +  goodix,hid-report-addr:
> > >
> > > I do not see this patch addressing previous review. Sending something
> > > like this as v1 after long discussions also does not help.
> >
> > Krzysztof is right that it's better to wait until we get consensus on
> > the previous discussion before sending a new patch. I know you were
> > just trying to help move things forward, but because of the way the
> > email workflow works, sending a new version tends to fork the
> > discussion into two threads and adds confusion.
> >
> > I know Krzysztof and Rob have been silent during our recent
> > discussion, but it's also a long discussion. I've been assuming that
> > they will take some time to digest and reply in a little bit. If they
> > didn't, IMO it would have been reasonable to explicitly ask them for
> > feedback in the other thread after giving a bit of time.
>
> If the firmware creates fundamentally different interfaces, then
> different compatibles makes sense. If the same driver handles both bus
> interfaces, then 1 compatible should be fine. The addition of '-spi'
> to the compatible doesn't give any indication of a different
> programming model. I wouldn't care except for folks who will see it
> and just copy it when their only difference is the bus interface and
> we get to have the same discussion all over again. So if appending
> '-spi' is the only thing you can come up with, make it abundantly
> clear so that others don't blindly copy it. The commit msg is useful
> for convincing us, but not for that purpose.

OK, makes sense. Charles: Can you think of any better description for
this interface than "goodix,gt7986u-spi"? I suppose you could make it
super obvious that it's running different firmware with
"goodix,gt7986u-spifw" and maybe that would be a little better.

I think what Rob is asking for to make it super obvious is that in the
"description" of the binding you mention that in this case we're
running a substantially different firmware than GT7986U touchscreens
represented by the "goodix,gt7986u" binding and thus is considered a
distinct device.

At this point, IMO you could wait until Monday in case Krzysztof wants
to add his $0.02 worth and then you could send a "v2" patch addressing
the comments so far, though of course you could continue to reply to
this thread if you have further questions / comments.

-Doug

