Return-Path: <linux-kernel+bounces-255797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AAE93455B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC931F22353
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D4186A;
	Thu, 18 Jul 2024 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cEx7Qrvh"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597363A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262090; cv=none; b=ZIvWAFOIfI7eEMRK4Isv2GEhPgoUnq2tGq5W48io0HNI72skyT+wyhHC1WuVXSET3IyFPxEvG0AHtL78bJioZ/bSAXA+MJ/nmtKF/G8HzCpEMmD6RPLUVkmstFxidIrhy5Rlv91csIB6jldEGYfZZQNn4RzbcKWP9B8W5Yq9o+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262090; c=relaxed/simple;
	bh=qfZaM8VI9ijVSJOyXMtAz+GFmiwxmMVRmm55/KX47Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeaKVWt3Mpyxg9DvQ7w/yccrOETvANn4h+F9+61LobS4fMokXxzWHJ8DMpVuw3+JHPTgZM68q5Qe+2p41wP9d9W0uOxVb444YWEoTNTR+ifWHgleG6tI4muscm1J3OhZUaA520BK3+ogHE9MYfSbwPVWocJl9iAmsgsfNVJIQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cEx7Qrvh; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d934cb84b6so198283b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721262084; x=1721866884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfZaM8VI9ijVSJOyXMtAz+GFmiwxmMVRmm55/KX47Cw=;
        b=cEx7Qrvh7A9UcogLFB1sr2kaSwUKz4vhRKoSLZtTj0YZBEF2rXkD0T4/BdemFQpzn6
         6WGqapL94VD2irpl4l5ziunqxFovAFSht/ZjVCU+y5jHQNq4tJqS3mtidr1WXi7nvoJL
         wBsxtTEMVvN063yDnq4o85JGsQb1hY7xMF8DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262084; x=1721866884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfZaM8VI9ijVSJOyXMtAz+GFmiwxmMVRmm55/KX47Cw=;
        b=s+4xnPPDHiEFac1ho7Sh05+wCU1UdX6ekDhng/fj0cR1g9fTr4BTcdNnkK9mcn5sFD
         H7oetMdEFSrYfuU0LCDu5uTCGEE2sPKrpc9VQdHzd8mVOqEl3VyV/5xe1I/LXoFt5WEu
         F80RB8QkIdnTSmoPLLby526Xw7W3F+IGSEAP/Q46Hi3lHUli3aQ+XEBb68TnyZrFu6Mq
         msxSJ4mVOupeCvD+Uh/K89F7iqOMknZgSUfjapqjxyjIiBMDeRJ+H+Xy2SFaRAsuM3rB
         IOPt34OoxEbsQA/GmAh9ukRIHceBauLJJrUKocyQvE3+PerVbMlkh+HFeHsjLFgCoZR0
         QtZw==
X-Forwarded-Encrypted: i=1; AJvYcCUHPQWER6OOEO3FLR6F8rTHVrilmaAMuyRKPT3BQ85MY1eCqMMoJJgTyE/eIjCxYWMP50FvpNCShihLOF/ppykdPGiByE/35BLwmoDY
X-Gm-Message-State: AOJu0YzyOUj7GH5GwQbOiFOWoxBmuqkv+iNkkvkniacuySbAXSpwCEtr
	ZAh3zgkLHKI7r6CipzHd3V2GGULhMuRDwpOvdAMbTr/N87cH9sJoJKe6UtSNrj/LuVcU6Z0NwyU
	=
X-Google-Smtp-Source: AGHT+IGhri/G/5wRsMiKoRYj5lhGToShwlC/U40yzH7FjV8m0Ea+6VkfVQnGiiKiAH9feAu6DPCnbg==
X-Received: by 2002:a05:6808:1a07:b0:3d6:3149:62ca with SMTP id 5614622812f47-3dad9a2d440mr288008b6e.37.1721262084020;
        Wed, 17 Jul 2024 17:21:24 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbf073sm458983885a.46.2024.07.17.17.21.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 17:21:23 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447df43324fso69151cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:21:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAVV4ES6i5umL/xD8Mbi6mw8kCcr4KheisgTh5iW3vLr9H5TnnOHBaQmU+9Iq/Pqn9t8Lu+O9X3Kz2d2qSC7kGPBIj92eiegWdL0Yw
X-Received: by 2002:a05:622a:a70c:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-44f92572a39mr538891cf.29.1721262082740; Wed, 17 Jul 2024
 17:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-1-31b7f2f658a3@linaro.org> <20240715-scorn-canning-a7f23b9e2039@spud>
In-Reply-To: <20240715-scorn-canning-a7f23b9e2039@spud>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jul 2024 17:21:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-nOMu-JDQ3T=ZRJ-rZ0BTtyzFVfnzbtCJdbRzAq3YMg@mail.gmail.com>
Message-ID: <CAD=FV=U-nOMu-JDQ3T=ZRJ-rZ0BTtyzFVfnzbtCJdbRzAq3YMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA45AF01
To: Conor Dooley <conor@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Conor (and/or) Krzysztof and Rob,

On Mon, Jul 15, 2024 at 8:31=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jul 15, 2024 at 02:15:37PM +0200, Stephan Gerhold wrote:
> > The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has backlight
> > control over the DP AUX channel. While it works almost correctly with t=
he
> > generic "edp-panel" compatible, the backlight needs special handling to
> > work correctly. It is similar to the existing ATNA33XC20 panel, just wi=
th
> > a larger resolution and size.
> >
> > Add a new "samsung,atna45af01" compatible to describe this panel in the=
 DT.
> > Use the existing "samsung,atna33xc20" as fallback compatible since exis=
ting
> > drivers should work as-is, given that resolution and size are discovera=
ble
> > through the eDP link.
> >
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Can you comment on whether you would consider this bindings a "Fix"
since it's a dependency for later patches in this series (which are
"Fix"es) to pass dtbs_check? See:

https://lore.kernel.org/r/4bca316a-2334-425b-87a6-e1bb241d26b5@linaro.org

-Doug

