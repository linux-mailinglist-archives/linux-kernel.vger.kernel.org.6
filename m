Return-Path: <linux-kernel+bounces-342379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF50988E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7561F21AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512419DFA4;
	Sat, 28 Sep 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4LG0Zmv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A491494CC;
	Sat, 28 Sep 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727509212; cv=none; b=pQvWlXbMsfkRKcAsWgvPsRIyYk1SekqpYd/SMEHCgK1WIR7V2q0qF6rsubk+24OZAGRospkiPfHdEA6k88YRFWSEKkookWcmql7878X5e3IzfDWSNTwHjQcoMW6gwZN6t4tcPmRR9f8yvj6ftxO025xgewoKMzB2/1v6vLe087M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727509212; c=relaxed/simple;
	bh=/UWJOTsRZemcTUIr83ftWwyv8s9cpMDc8tBEv1rZNl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoIlVbNjfUTxOSq2SlB7uLkQVYHtud801hU5qQD+2BvMXrAIsoxolTsljGNbHOJoBVkKEmgPxN1wHMlobJfBTA74ihhAnF9UensuvTZqGEurFBbipiU1D9Cq0MXNizfoUhT5GB8vHdTlme92shZ5wEWyUYs+14aOYSwKQ3wDWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4LG0Zmv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71c63a43146so510792b3a.3;
        Sat, 28 Sep 2024 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727509209; x=1728114009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vIk5qHEBeiHNYaEjsxp0VwqnS+Dln2niDGd+PmLgkWE=;
        b=D4LG0ZmvCmoXbvCQ5C9+DrrPgtctjFSGOSuhkTpVWgRhptLp8aJ/lCZZYD++HU/ZMf
         gDZNvHdG4a1A5OeYMy8KozdtAte3wND8UFi4gcEToeFDMPtTnBU4kMPNuCevijckWrE8
         70PmP3zmHhRA6R0lYo2Y9hg5P+mHOL9BSny2OjkF95aNIWaomYedfuWMNa4n/NgB8iEn
         lY0567NIrH74XNMo2I2JbRajGFYWuQGTmTheqJFvOuYwYw6/tSYmPWJ2cO1sIGTAeYOC
         adR0aJVLZSKFFb+GDJyIBvqjKXPw1UhEAbC3M4OGX5dWy6UgpKmC7uYz1zY+0ZKl/+Jk
         Eo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727509209; x=1728114009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIk5qHEBeiHNYaEjsxp0VwqnS+Dln2niDGd+PmLgkWE=;
        b=tBvLBH7ShoWFDLomHREFjNCARGSGGLypHKF+mow8VlK5Y8Tl3n1Y+3nSnvV/gTHFvS
         FSwnKq5t8ouOgd0PsRGXhWD3sRetWLvHnGRRy9NMYTlCbZj4mwJTVwCbWGo6S2LO4cCk
         H5MSAto6V/7EYTQtU70q00C2ptXXXQgAE7221qF5/lAI76pMLQqfuZWyPtFlmhGNJPsT
         lFDvpfGssj+Kc6W0ABVOGHHvgVUWJ/GOTcmGa747LeDPwtY9FFE+qsDHznTa1fTMTk0o
         /48yqovCVfyURc6sG8z5Hyn1RifdFN8eVRSH4AHucy9uEjkvDPAOZjCRIUaWC8yNGh4b
         ZCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPQdsbW9sXOCoSlwJJDyYOPgPDaBHpEiQrrmdCRP1pEV2/QS0LElMhHXxQAoBzTqX7opIyPQLTLeDENmf4@vger.kernel.org, AJvYcCUlxEUEz4Nwof0nblW0x2S1zkpsx3eAij7BbVqNkEtRsC/lfWOCri2c4lOyS8DCTC4hYI30lTuYo8TX@vger.kernel.org, AJvYcCXSg29Oc+YCCJwtu5qhYMTSnNWDIduzhZyua1dzkYrgCjInHSxUQr9JHMptsegV+1iZirjOrgeB2eYX@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLyVhw6QP3/aq8SpnnEUxCQxQpsUGoz+ARqI3VtA7iwW9zb5S
	+No0LP+ozmibBK9+qQgYhJYu2yspOMhP1yr3FxzPOM1aSABtIFnlB/AlQ5lT0RXmGZNrHGimIGI
	SOYc7d3UIuaPtfwO5nIMXF7k//W4jRfvexrAbxA==
X-Google-Smtp-Source: AGHT+IFRckPeGI3mK4TJy2Ans1VBN719sE90BUID/5AeSMpimloz0bUHIVjYsGfDx0ihK02KRAinHGQFEM/ysc/uGF0=
X-Received: by 2002:a05:6a00:2d9b:b0:70e:9907:ef75 with SMTP id
 d2e1a72fcca58-71b25f014bcmr10074551b3a.4.1727509209060; Sat, 28 Sep 2024
 00:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvBNLRc8xnAoGvoc@Emma> <a02e472c-f206-44d3-9a6b-d921e73110fd@kernel.org>
In-Reply-To: <a02e472c-f206-44d3-9a6b-d921e73110fd@kernel.org>
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Sat, 28 Sep 2024 13:09:57 +0530
Message-ID: <CAEDjzLK1juaOCogWgyDudOn9B1EqbE-vMuGYPxnR9B35y+uAOQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: add missing compatible arraylist
To: Roger Quadros <rogerq@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 17:23, Roger Quadros <rogerq@kernel.org> wrote:
>
> On 22/09/2024 20:00, Karan Sanghavi wrote:
> > Added the vice versa order for compatible property in the yaml file so
> > that the dtb can parse for the order mentioned in the dts file
> > k3-am642-sk.dts for ti,j721e-usb.yaml
>
> k3-am642-sk.dts does not introduce any nodes with the said compatibles.
>
> "ti,am64-usb" compatible is introduced by k3-am642-main.dtsi.
> There is only one compatible introduced so there is nothing to do about
> order here.
>
> i.e.
>         usbss0: cdns-usb@f900000 {
>                 compatible = "ti,am64-usb";
>                 reg = <0x00 0xf900000 0x00 0x100>;
>
> What is the functional problem you are facing? Maybe then someone
> can point you in the right direction.
>

Sorry for mentioning the wrong file name; yes,
the problem is in k3-am64-main.dtsi file as mentioned below

 usbss0: cdns-usb@f900000 {
 766                 compatible = "ti,am64-usb", "ti,j721e-usb";
 767                 reg = <0x00 0xf900000 0x00 0x100>;

Due to this, it gives an error as in the YAML file the order is in
reverse order.
Also, I cloned the repo yesterday and still found the same error in
the dtsi file.
So have I done something wrong? as I see I might be out of sync with
latest changes

Thank you.
> >
> > This is highly ambiguous to me as where exactly the changes needs to be
> > added is it in the dts file or is the yaml where we have to reverse the
> > order already mentioned or do we have to add the another order as I have
> > done ?
> >
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > index 95ff9791baea..822653217c43 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > @@ -17,6 +17,9 @@ properties:
> >        - items:
> >            - const: ti,j721e-usb
> >            - const: ti,am64-usb
> > +      - items:
> > +          - const: ti,am64-usb
> > +          - const: ti,j721e-usb
> >
> >    reg:
> >      maxItems: 1
>
> --
> cheers,
> -roger

