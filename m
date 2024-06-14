Return-Path: <linux-kernel+bounces-214408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5919083FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B791C23050
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86DF1487CE;
	Fri, 14 Jun 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1y8s+XD"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2138C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347707; cv=none; b=c6WtG+JaxPumfbaM0CuIr9v/lbL3p3uVb7pURYC4mtaSEfQXYCc85jSGvqaosYE/hG1rQZZweGerrSyYOa6pdNSt8ETRAAsp/LK3XJoR2/4j/Ln88/yt+Zlz4GsECIGXQZjLg8covsB3TXNYCD3GctSfidJMyCV7m3litvz7C5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347707; c=relaxed/simple;
	bh=yTvhl2IUS1cbZ8FmnJISCj1I5etRv6Wb4WLy/6guEdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPjiPd/EA8mKj1QAZ+5/7jZsAOeyWwLPPaVhaF06kKSp6soke4CCkko3SE3SHHcKnNbaJJKKTVGW8Mn1feF1VrkJYaqgJeeBXX/piO2kqP5HwfL9Z7FhETMT9VY23ocPbWZliaT7UWah/6A3PRb00UoV9djMk1VhaLohzURnvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n1y8s+XD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso2147348e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718347703; x=1718952503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n21AcI7ZyImS+JT8RLtnfNQgbRDZVCrUU5GE4hIUqKY=;
        b=n1y8s+XDYtXG7fhpqsr/Me/aaLsHqM6L7BmzH0OsoEn/Nmw5qJC2s4uHEZjc5gUpZ5
         QshZY44hT5xxhdSXKoLc59MLQU3bWoeA2K4DJk74kcxPEfdr/bbJC4amNLX4ZrK5cS8r
         7ILM158FnUCF2fZskwUGKtCg4Cdt+Ex6cCeGdGaGZKGsBsEJ3FI3lkuE/PwWTKy008fA
         xeCBRFDVLj/jDIgvZVqZ3T/RgvD7ob0EsqDD0VGYxrpT5PR6ksLu/HMjD/88rNhapTVe
         5kAS8qrwb5WolEJ7G1J+DopwNdf1f1jYNmauHLJkWlususNfRHFQgpXpIHesIJrHAZNH
         U90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718347703; x=1718952503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n21AcI7ZyImS+JT8RLtnfNQgbRDZVCrUU5GE4hIUqKY=;
        b=Nz9OB8DblS8H72Hu0Dl2BzNBmYLSdNojqNA12fJj7Wm0K0wTFHmkTR1u0buCO8OV1m
         txPv4DYjfLl8ti8VdIK888ex3DIeokzbgdTj/DZeREAQD53Wdt5ovw4MuKRq9wowVZIx
         ZqNA+mvksLzY8YiQwsCgPw2Sf5MVF472bFDfCqkABHCXrmg1J8nBSwID/OrDOe+uzx31
         wbE0hCw+kWCHM8oOq+tHKejBHshY/2kpPy5uKSjhppSGskMiXwotlD3i06ttk9F6RA5O
         VqwrxRPU/aobxUW03tG8njpp8GOHyci6jpMlTc3o0wjeWFV1mz5B44dMak7PxiHO5KCQ
         iMPw==
X-Forwarded-Encrypted: i=1; AJvYcCUOV3Nvxrd7YCwTTGCkOgqAYvJi/vEk8c9/jNfhS5OtxsBjA48Igmu/oCZDD1kcFOQ1Cs91KsIAEw4+ApbLy4/Zjq/8ISsq7bZ+X6bI
X-Gm-Message-State: AOJu0YwgcbC+6weQ92Srsd0h5zWde4XzPhSA13rWDfyKcHwA7MWlaxqg
	Go5XsPhJPgHtpdin8KpuPjt4D49nlJvtrBEqfX+eDm9TQ08fI2v4+V5YesUbt99GNCQKBPhSLUl
	pcgHXBb0qDuhHHP9QTvJ2GZU8zwvi2ywkbzj2HQ==
X-Google-Smtp-Source: AGHT+IFrZm9K+8bcFC036pMlD/5EnYhtWdAcFipBud3JNlaPiInNyeWH7o20nlajvM9PGHxsP2H2vqWpmnHG0VfjOAY=
X-Received: by 2002:ac2:43d6:0:b0:52b:bdfe:e0c9 with SMTP id
 2adb3069b0e04-52ca6e562camr1241037e87.9.1718347703314; Thu, 13 Jun 2024
 23:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
In-Reply-To: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Jun 2024 08:48:11 +0200
Message-ID: <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
Subject: Re: net: dsa: Realtek switch drivers
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	"ericwouds@gmail.com" <ericwouds@gmail.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"luizluca@gmail.com" <luizluca@gmail.com>, "justinstitt@google.com" <justinstitt@google.com>, 
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:49=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:

> I'm starting to look at some L2/L3 switches with Realtek silicon. I see
> in the upstream kernel there are dsa drivers for a couple of simple L2
> switches. While openwrt has support for a lot of the more advanced
> silicon. I'm just wondering if there is a particular reason no-one has
> attempted to upstream support for these switches?

It began with the RTL8366RB ("RTL8366 revision B") which I think is
equivalent to RTL8366S as well, but have not been able to test.

Then Luiz and Alvin jumped in and fixed up the RTL8365MB family.

So the support is pretty much what is stated in the DT bindings
in Documentation/devicetree/bindings/net/dsa/realtek.yaml:

properties:
  compatible:
    enum:
      - realtek,rtl8365mb
      - realtek,rtl8366rb
    description: |
      realtek,rtl8365mb:
        Use with models RTL8363NB, RTL8363NB-VB, RTL8363SC, RTL8363SC-VB,
        RTL8364NB, RTL8364NB-VB, RTL8365MB, RTL8366SC, RTL8367RB-VB, RTL836=
7S,
        RTL8367SB, RTL8370MB, RTL8310SR
      realtek,rtl8366rb:
        Use with models RTL8366RB, RTL8366S

It may look like just RTL8365 and RTL8366 on the surface but the sub-versio=
n
is detected at runtime.

> If I were to start
> grabbing drivers from openwrt and trying to get them landed would that
> be a problem?

I think the base is there, when I started with RTL8366RB it was pretty
uphill but the kernel DSA experts (Vladimir & Andrew especially) are super
helpful so eventually we have arrived at something that works reasonably.

The RTL8356MB-family driver is more advanced and has a lot more features,
notably it supports all known RTL8367 variants.

The upstream OpenWrt in target/linux/generic/files/drivers/net/phy
has the following drivers for the old switchdev:
-rw-r--r--. 1 linus linus 25382 Jun  7 21:44 rtl8306.c
-rw-r--r--. 1 linus linus 40268 Jun  7 21:44 rtl8366rb.c
-rw-r--r--. 1 linus linus 33681 Jun  7 21:44 rtl8366s.c
-rw-r--r--. 1 linus linus 36324 Jun  7 21:44 rtl8366_smi.c
-rw-r--r--. 1 linus linus  4838 Jun  7 21:44 rtl8366_smi.h
-rw-r--r--. 1 linus linus 58021 Jun 12 18:50 rtl8367b.c
-rw-r--r--. 1 linus linus 59612 Jun 12 18:50 rtl8367.c

As far as I can tell we cover all but RTL8306 with the current in-tree
drivers, the only reason these are still in OpenWrt would be that some
boards are not migrated to DSA.

But maybe I missed something?

Yours,
Linus Walleij

