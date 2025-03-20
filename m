Return-Path: <linux-kernel+bounces-569908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344FFA6A961
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047F21888E04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E71E47A6;
	Thu, 20 Mar 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lquIPGPn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9683C2F;
	Thu, 20 Mar 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482754; cv=none; b=ce628IwdBlwuaDMGuqAe2BzkpQJesX7rALx7tCJ8KYd01nqpsQUlqMKF8R/Ta9lVCqYdebsB2xpbwIrsMaEjPwy5nV8xadgehh4/NrLmBxztyUDBxVC4z7gtNnaCTjN0NUa87bT567HfQYtjkOJaPk29EpTOlVe0QBD0Pe0TDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482754; c=relaxed/simple;
	bh=gvvve4bfA2xN7CqM1D0GuF35FojJxC50q/W6Ep0Q37Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nowkeJ0uMqb6KgwCwhWHym14otzUtATGJTcJe77AnKDmK1dOEJnuFzRsXQQ2Ac2xqr8LejwaN9p9pPYQkpT2hMHYHBZav6ex6IjYOzkup2N0I9Lh5HWdXoSKAKMHDfV1kIZG2HV8X6tC2g9JZOOkUrfOJ4yi8mIspGwIlF2mD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lquIPGPn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so13832675e9.1;
        Thu, 20 Mar 2025 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742482751; x=1743087551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9MXWVPiHsl/ybfeX0fVWWFkRY/xYzUHOKzudQkSQFpg=;
        b=lquIPGPnXBWgHdFe147D9WAdZXoPrrDtO6qzwdY7Y21oNbiTX2KyDscgaHSP/1k6p5
         F3p2srZ7kaViz7/fR9PLw8F2zEtsLseaDx2hVpfrpFH8EPGeypztdl9SfpibPFnbkuKV
         DRxkHk4MfyDkQcjPoRgsPtPPxd4pbAclbjOjTscw/en1CaO3h8KFrW8SgJQUjbdY3DEW
         tGdCTHFcVGq5ONMKhl8eUHL3QohTD1HEZO9w+6QXLZdsdZ4qr3mUlLEn09o5UyKqLH1R
         vkuf5kDc5hOqUJA9OFRQuoLs32b+z05WZn93WDGkf5ychbezCuvQGIxj2SYXGT2urwWA
         P+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742482751; x=1743087551;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MXWVPiHsl/ybfeX0fVWWFkRY/xYzUHOKzudQkSQFpg=;
        b=PM89XItoHs6OZeXybrmfR2aCHHNNr0WG+uajCj2AtBdMFA/NFlyVW+eyoK2w6Jb1QH
         Wxk+eJIUKJZh/Ubq6VQ2Oe/pKlxDNQ9GBmikefvMR3TOQEFrUfsTvXKug8xnSSZ3gaf8
         D4vmcNIMcOB/Wmg0k0d+I0lcfY4a8YOzrcOT4/Vl0bCw/QEuCDpQ5c+QLQpNyoZ5IqsL
         2wDMAKIpr98EjqAssQIR3t8iomvzjAr7McJu3XVdK2wGUtFXQ5977zuXnH1R1UZb4wHf
         uNTBibg3S3WgO331tKtme3PUyP83+XwJEozpQYmHqIv6QBY9E9E/a7/IXGjZecizE/Jz
         6TjA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcVicuJU7hVd2F4QqvqxpA9T8uJaDNSHweGelYKcdU/1iJj4fQ3JkFqXSyyJLLP793vpdsBnZcAk8@vger.kernel.org, AJvYcCULsoB8P8BYNWyGANJtryZWO/Iwj2Em3zFuwgYPTfhZTXSzK9bHdcfi2vxHAu5N99PUN6Z3GKKsWN7OEqaB@vger.kernel.org, AJvYcCUwj+y6qDVYQ08fdS8wyRx4Wl8GlUV+sfBKejcsOnKp/46i+VvX04FTwa9A0QB9WMn71b1CM2+dDqhs@vger.kernel.org, AJvYcCWJpVSZp7RnY37oIN92NhVU8/6j/GEKcH4apVgAVsmmG5uWoO53d6GE6nc4r+2fo0uKKZHWJ0ANAk07@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaJMzheb7FsAbCBjR1idPViZiqx8eKTi8s8wIMbdNMJ9Fd8bv
	nz0cJx6ElKuLwONxyQYTR+H+8d4GNmOKhUKRFLi8limErM3ded1+
X-Gm-Gg: ASbGnct9J0LOLl60xg+1FlqL5hyVAmeuOYxRuKQubdCd1su9Od9BbD9DdKhNvtMmeuS
	RvWk4qTi3UzKTl2Wyz2ySXcW+igwc4OycTFzWuefrIm5q8DpgFLetnUV4HPqJesMRaJ8zj+A0mX
	YWhMu19XVkFqEqd+7oT6E73jSIXBgTfcGh2jcbDB672NMYAeZ+jkKQMqq9wek9w7At3M9iGQkEM
	iv48HzaoaHGdIStG2dcaCFDDq1/4ynmz3HZaPKQLLSeak7QGAX30qP7mAD2Pjtjp2HtQ7jRvvCJ
	0olN4KYeOETP1ld6enXBgQ0QJEdRyX4x45ysdNrwwX/YJ6es+iovmLPifEGWaxU+jn5cxGZelPx
	N
X-Google-Smtp-Source: AGHT+IFSmo8fFuEqajq9aZA55RF0/kNYRGkGPQelDDCd7p8x/2z2TYhPjj6gPq4JZPeYBBnh3Gq1Ag==
X-Received: by 2002:a5d:64a8:0:b0:390:ff84:532b with SMTP id ffacd0b85a97d-3997955cc22mr2933292f8f.7.1742482750791;
        Thu, 20 Mar 2025 07:59:10 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43e35sm51134405e9.14.2025.03.20.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:59:10 -0700 (PDT)
Message-ID: <67dc2d3e.050a0220.2e39a4.c3f0@mx.google.com>
X-Google-Original-Message-ID: <Z9wtOv-ttPCY-Lpg@Ansuel-XPS.>
Date: Thu, 20 Mar 2025 15:59:06 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yangyu Chen <cyy@cyyself.name>, Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v2 04/11] soc: airoha: add support for configuring SCU
 SSR Serdes port
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
 <20250320130054.4804-5-ansuelsmth@gmail.com>
 <d6e27266-dc5b-4ef8-b708-21cedd06621e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e27266-dc5b-4ef8-b708-21cedd06621e@app.fastmail.com>

On Thu, Mar 20, 2025 at 03:49:08PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 20, 2025, at 14:00, Christian Marangi wrote:
> > Add support for configuring SCU SSR Serdes port. Airoha AN7581 SoC can
> > configure the different Serdes port by toggling bits in the SCU register
> > space.
> >
> > Port Serdes mode are mutually exclusive, force example the USB2 Serdes port
> > can either used for USB 3.0 or PCIe 2 port. Enabling USB 3.0 makes the
> > PCIe 2 to not work.
> >
> > The current supported Serdes port are:
> > - WiFi 1 and defaults to PCIe0 1 line mode
> > - Wifi 2 and defaults to PCIe1 1 line mode
> > - USB 1 and defaults to USB 3.0 mode
> > - USB 2 and defaults to USB 3.0 mode
> >
> > WiFi 1, WiFi 2 and USB 1 also support a particular Ethernet mode that
> > can toggle between USXGMII or HSGMII mode (USB 1 only to HSGMII)
> > Such mode doesn't configure bits as specific Ethernet PCS driver will
> > take care of configuring the Serdes mode based on what is required.
> >
> > This driver is to correctly setup these bits.
> > Single driver can't independently set the Serdes port mode as that
> > would cause a conflict if someone declare, for example, in DT
> > (and enable) PCIe 2 port and USB2 3.0 port.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> I think serdes drivers are usually implement in the drivers/phy
> layer, and I see there is already a drivers/phy/phy-airoha-pcie.c,
> which may or may not overlap with this one (I have not looked at
> the details).
> 
> Have you tried to use the phy subsystem interface here instead
> of creating a custom in-kernel interface?
>

These really set 1-2 bit and I think PHY can't describe PCIe in x2 mode
or in x1. Also I think PHY is used for more advanced stuff and usually
have dedicated register/maps. This is really to configure 1-2 bit and
provide the mode, nothing else... no enable, no power up.

Do you think a it's possible to implement a ""read-only"" PHY driver?

The PCIe x2 mode maybe can be modelled with
phy-cells = <2> and adding a extra entry to enforce x2 line mode?

But I feel it would be wrong to say that the SCU expose PHY as it won't
be true.

Honestly we should really consider starting to implement a generic
provider for these stuff... it's not the first time we have bit that
configure part of the entire system.

For example this is very common for QCOM with TCSR and also for Mediatek
with the TPHY. (but TPHY is at least more realistic as it can enable and
disable serdes port... here it's just 1 bit)

-- 
	Ansuel

