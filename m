Return-Path: <linux-kernel+bounces-211666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BF90551E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7F328844F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CBF17E459;
	Wed, 12 Jun 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb/TW/q5"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28297FB;
	Wed, 12 Jun 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202501; cv=none; b=rXufMtK0yu8S5lLLdZ/odRG3IhaUc4yMvKowv4tsufv/lY1xOOGfCvy/EgTh11154AVWikvbhXuR/WHbkHQFh2a7oXDiiBgptfjXGOPck3TDhZM9gaktsfnwt6VVFOz2UTlseH2j+uJszW73hjNhiUJFDkBRmLG5xHRK5M2JIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202501; c=relaxed/simple;
	bh=M5Wq5PkW+j5WBpUWNaxe35+bKituzA8SiWZVorHnflI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aChqzn+kkN2cYsueCYD4hk0wfe8zXNGel3X7swibSHAE5ZELmoSTaOZEN0WzKoJzKewxWbL4n+Qh5P9969kPrJ9ORex998ciSNvgyG5A9FAHIwjNjJESQCuqgmU1fxxh040REg3PYYNBFTJxLptU7CZfkPFbs/mFrjshl5YI0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb/TW/q5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso22171461fa.1;
        Wed, 12 Jun 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718202498; x=1718807298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBGRs/yfS5hfu0UJmUEEloYokRcE9KOZ/5P6i9N80po=;
        b=eb/TW/q5oO48KNt+Af+wQUVUoayNH3z49p2H8HIXHzUArNvBEDW7LTqdOFlZIr96Qt
         0UUr5huK4UbmmzOs7cQgm6uhtFugC7x5pspeRSJkLUSHt1Fwhpq3WiY/blgSmCtc85OX
         +eiB1O5GJ/rXpd59J2VQJKtF7KnwznQqoYbuQwZcp001wMpICGNO1xjUF7pYP12Zsa1U
         HhocjK7izQ/nKeYBGJAXqwzl3wiYmheU+ua6DhZ7D6aR0grGmObiRnwhWhv45uyTu+3k
         nAZty1x9Y8FnLRviUvMqRyuFJ2X/oG7Z8tkaq5bbvwACtafw24APSAjlrOm1MRD+IYBm
         OkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202498; x=1718807298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBGRs/yfS5hfu0UJmUEEloYokRcE9KOZ/5P6i9N80po=;
        b=uXn/xDOIGO5Kbecd4eTtVEXHfD/9T0POVI23Gb1JO04MBJLGzWfhVIgi+rxVQBz2hm
         Mm+3tcZwyKz06+I5AreYBbzK2uv2hb+gVE3n9tbOiL5J8m2N5i1FJMoEnxhe0tzZkRJL
         8hlfW8zL4bGQmIVL1u4B2WR2JtVa5AL9oXHvj1/6TEPQBjJjOmXVF05XaXHdRsAzrktO
         z53qpWp3EGnVXqV1gDT1E3N1C6H8WaMi+wFY+WxwaE09IsQmXANn8dgtL0WaAlKjAyRe
         4Ef/xppbMcqi8zxQH6EHfGeu2oUH3qlkjZBBc7BiWFGFeBMEGXKKc+Fx5CgScOHWjhh+
         r1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+rZgMlsu5w1wHhcuhYPlpC4eav/gizoTRANgwhKN31O9IOtYZvIKh/Hac7FUhP5QtISsVKnxskYW4b3uEcY/Nofk0syrutEUhO5dqq4IP9lvEg5JBfjB5kDdejT4+pgFwtYTiZo8CihpJebrlZhiGsHJTi5Q/xUA6kicmwdlztYuBng==
X-Gm-Message-State: AOJu0Yy4eQonk6i3bE1x1ToeQozIxj0tzsVWkZydjvurdbT63NHm+5TZ
	wN53WAh0d/hxDTg1oSY68GPqcuVWLzLFBgE1nn+FF1ctj5s7NIiFaKNaYBDxcvmFayfZTEIEMQp
	lDqwyWD/ovGuU71xzIv1k/mnpuDPJIuCOB/oju9Rh
X-Google-Smtp-Source: AGHT+IHOs3ciOviU8J52fVK6ZywQ5lGQdMISCOwO4tHH7On+5Hsi54kgd/FP+vf2ZrTO8jNLdDjnz/KhkhEElQXnm7M=
X-Received: by 2002:a2e:a0cc:0:b0:2ea:e4e9:8776 with SMTP id
 38308e7fff4ca-2ebfc9ab259mr12598771fa.46.1718202497821; Wed, 12 Jun 2024
 07:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240603130004.25662-1-joswang1221@gmail.com>
 <9c665afe-16d7-469e-ac3e-d0d7388a31b7@kernel.org>
In-Reply-To: <9c665afe-16d7-469e-ac3e-d0d7388a31b7@kernel.org>
From: joswang <joswang1221@gmail.com>
Date: Wed, 12 Jun 2024 22:28:06 +0800
Message-ID: <CAMtoTm1ojhCSRb4c+MPjuJB+JaeD2ex6B7FpCaJtLvrTj0Q8Cg@mail.gmail.com>
Subject: Re: [PATCH v2, 1/3] dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thinh.Nguyen@synopsys.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, balbi@kernel.org, devicetree@vger.kernel.org, 
	joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 2:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/06/2024 15:00, joswang wrote:
> > From: joswang <joswang@lenovo.com>
>
> Is this your full name or known identity you want to use for all kernel
> contributions? Looks like login...
>
> >
> > There is an issue with the DWC31 2.00a and earlier versions
> > where the controller link power state transition from
> > P3/P3CPM/P4 to P2 may take longer than expected, ultimately
> > resulting in the hibernation D3 entering time exceeding the
> > expected 10ms.
> >
> > Add a new 'snps,p2p3tranok-quirk' DT quirk to dwc3 core
> > for enable the controller transitions directly from phy
> > power state P2 to P3 or from state P3 to P2.
> >
> > Note that this can only be set if the USB3 PHY supports
> > direct p3 to p2 or p2 to p3 conversion.
> >
> > Signed-off-by: joswang <joswang@lenovo.com>
> > ---
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Doc=
umentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index 1cd0ca90127d..721927495887 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -242,6 +242,13 @@ properties:
> >        When set, all HighSpeed bus instances in park mode are disabled.
> >      type: boolean
> >
> > +  snps,p2p3tranok-quirk:
>
> Why this cannot be deduced from compatible? Which upstream SoCs are
> affected?
>
>
>
> Best regards,
> Krzysztof
>

Thanks for your help in reviewing the code
DWC31_USB 2.00a and earlier versions IP bug, regardless of platform.

