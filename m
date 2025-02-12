Return-Path: <linux-kernel+bounces-510779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B587A321D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642107A28FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03430205AD9;
	Wed, 12 Feb 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn8UbfdO"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F6205E09;
	Wed, 12 Feb 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351599; cv=none; b=G/CO4cNpTM8j8eeeNj0dcw5B1BdsUvGsGU9ercNEf2Cv2c1XAetc5WQlo4b/wlLzFqDMEE6ffSidyXFhtZCiwv2rImNYi5qnEP3XjlkNA72fp68uok25pYEVMf4XPFXyWdvszVeDj0wsZwxsQRmxPFQAfF6pm6YgWoG5hyY5MZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351599; c=relaxed/simple;
	bh=aPD5rYa5UTZEA5lzkKURim7OANCmr8pHXI0PnX7mAMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0Bj9YGCseDffP9iJWtqT8XLgI4IB8jM8n82wot4Idmov6b5T/RfcSVOYt/fdpby1mG7Jd8gv0Zbvs1VVQVMHB5q9L5r2br5Ft0kyScyk+M/7p3LF4eVn7FVCSYzIS7mPr9hzE04rbjjT76r0wD+Ftt2CHIJ47d1e6iXMAISrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn8UbfdO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so820325a91.2;
        Wed, 12 Feb 2025 01:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739351597; x=1739956397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPD5rYa5UTZEA5lzkKURim7OANCmr8pHXI0PnX7mAMw=;
        b=dn8UbfdOzVE2ypJaIIDYg+PZiVeAe0Fwuh3Vijr3wfTlPEFdeLYoMbiHlbNTNxWarB
         qVcP5gi9TbsoTQUB6o8u1sg8XUTQZqgZ6X5trfCKsHO7BrEDeEL2Pslo5j42FLq37i3T
         UIo75aNVSBGXbuWRy9XV0E5mqplu6sWhcyDP46mJDxXE28B0/I2sPQXtVWSmYGrfOrzu
         chNmFn2I5jiqn9CYpir/grZwNARgXl5TvRIWG6Xjz016N/0I5ub21FBtGiMUANbopsMJ
         ekwCNDw3dm99XG6tuR0FqqxCWin1WLuuwLkXz5Jr3eqKtSstze8Ya/8v6vDSyTQToskV
         BE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739351597; x=1739956397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPD5rYa5UTZEA5lzkKURim7OANCmr8pHXI0PnX7mAMw=;
        b=A141BeSl+0O1YbHJa1ppAnGEeSIDLrh8SMXxL/9ZgDpKzy8i1iZUwYh/iaGomxloqE
         DystODs8ZsHhSnbXi/6j300l4r7BAHDkoP4+CWv4QjLEP1UcHuytGczfRzV+dGreJ8mv
         uR30eJ59SbauzuczaYKfioLRjRmCnZCkSi11/VWHVtRrTYFp3aFWKDYTWivntjrwn4uG
         5n31U4QSd1WiAcmZQUmVl4lTxQQ+9Gkah5I3ML8LrREjdf3sT2LrxzUhy6jtaNPzxV9i
         s63L6V2L9Z+RHRMO2NWEbdUAM8dDxNgVKHSWY32hongKrEDqmCQGp15gJ4DNvBTXyNer
         psQA==
X-Forwarded-Encrypted: i=1; AJvYcCWZEeKE1rCbWaOogwAyPo7BJy8qy9GekcmBoudmfNtKCcY89tz5tyP4303JT275WLxpZm7Jl5t+b6Kns/RN@vger.kernel.org, AJvYcCX2FK5Y+3vHnX9/3qANJlGlL1ftQWxgVA445XHAe0p4jCzYs5DEe1jogjqdKjd6fxGIZQ9jevvxIn+2@vger.kernel.org
X-Gm-Message-State: AOJu0YxKElanAQ2qxDwx+gypkRqOuYuN04rBoBVxAXyBQdJ37cYCEiAm
	HfbYxnpMDR9DXoSznkhw6HQw3x6+UmF6V0x4WuEwHv8rUkwdiF6XUognv2mb6GGPs9rV9xv00Ii
	QKPhKS8vN1Vk3ZaDzhozwn/VggZU=
X-Gm-Gg: ASbGncs8XYOUCYnOQJr9UaQG6cP7VBNQWOd/oY/Nscu4ktmBV4Q0z+L7QRp6D6fss8P
	h9ysgtoaL0eGPAwJqbfruCTP8dOGO7WLe0y0P2EzoQ8fgqH4+rwsT+EXoJkKhxfh8y4v3HA==
X-Google-Smtp-Source: AGHT+IHT+ZeidzgbuFPK1T7nat9jcZS+nvvNOTSUNTmWCKgY4f8d3bPZ9z+vTH8FvkV4Hugvz68ajXpWP20x9T9YFVQ=
X-Received: by 2002:a17:90b:2c84:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-2fbf5c71362mr3494611a91.32.1739351596956; Wed, 12 Feb 2025
 01:13:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
 <20241210125338.104959-6-daniel.baluta@nxp.com> <l3z3mu5inmfc23v4mymtcb4gnzic5zupqfpcuk7vqeweluy5jn@c2b5ex4lkdgc>
In-Reply-To: <l3z3mu5inmfc23v4mymtcb4gnzic5zupqfpcuk7vqeweluy5jn@c2b5ex4lkdgc>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 12 Feb 2025 11:14:50 +0200
X-Gm-Features: AWEUYZlmAF9HL7F1Di0jk-WkuyiQ4SgROYkfG9zP3ZC-TaPsUodPXn0I9h7DQYQ
Message-ID: <CAEnQRZDZSj2tkMzaqZfaO0e8drO3U2j_qxoZSNocAS1Qaq1Q-Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, festevam@gmail.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, frank.li@nxp.com, aisheng.dong@nxp.com, 
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com, iuliana.prodan@nxp.com, 
	a.fatoum@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Dec 10, 2024 at 02:53:37PM +0200, Daniel Baluta wrote:
> > Audio block control contains a set of registers some of them used for
> > DSP configuration.
> >
> > Drivers (rproc, SOF) are using fsl,dsp-ctrl property to access those
> > registers in order to control the operations of the DSP (e.g for
> > start, reset, etc).
>
> This should have been implemented as reset controller, not syscon. It's
> really poor choice to call everything syscon. It does not scale, does
> not provide you runtime PM or probe ordering (device links). Quick look
> at your drivers suggest that you have exacvtly that problems.

Hi Krzysztof,

The bits we are using from audio-blck-ctrl for controlling the DSP are
not for reset!
They are only for Run/Stall the DSP.

The reset is done via DAP interface. I will sent a separate patch to abstra=
ct
the reset interaction using a reset controller. But for Run/Stall bits we n=
eed
to use a syscon.

thanks,
Daniel.

