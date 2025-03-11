Return-Path: <linux-kernel+bounces-555988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB770A5BF27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED45517597E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22E2254843;
	Tue, 11 Mar 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FlYvAtbW"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F8241682
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692954; cv=none; b=j4KDZG3LqogWJY5dFnP+fRLwfIR54neJ2XuxGUQXFHH2hAfrp1pssolklqoHlbk4dzl2bN8ufAVTbuIfCWwty7fuf99rUKamqIDW7h5yA7Ql9WuNDU/wAb/Wry0Fu0iR3d4YNa5rABEckcS+Tysx/bCQi9sjuflHOgAa0T818YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692954; c=relaxed/simple;
	bh=H8WHtwt8NwohMFMSJyOYCpjReRpfvizxw55BJZSel9E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLmoPQLQ0JDTz1HLU6jTtu/xY5w+zAFe3fslwVyoA4GLS4AcyGXt6OsLeqJNFfdBVXGaAwkhgsL/+dTB4Vit8bGvNzgINsbfdVF103oZ9zU7Jw02Gd7qGfsIO4mGLOMtHUMc46afLrXZlbeKXtm6E1oBcn1DMDnq8UTmUQ5H+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FlYvAtbW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac25520a289so700882166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741692950; x=1742297750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRhhFOV50S8nkiKWbxOQjhnR/D7pnJ4RjNLNNRoG574=;
        b=FlYvAtbWUQ783/BLA7JdmBN+i3taWgiMQfwzZ3MEwXpGQr5NXq59uc5Lys34D6Xqd2
         KgFi0rEeyRNHRWcHVedFgHoLfiDJB+yYrlvS88+uMh8x5je/gnuyUBdUF14wybfr46Gg
         lo5jWxagxDkLNH19pX/MyWbrFCBSwbMkj4soo1HKlN/6NmoKbp1vo0PBps4bC4WwQucA
         gdyLsrnJVokl1sU+7ZwSaGnImjSMFDat3BNRpBdf7BpDq3SjxQsnDlJWTCTLgWObUTcR
         PzhHG0vz+Feq6HFnQvARiEmpqNcCwzUSGSkYmsPQBQcncT4QF6FZAzSrkL0yJZ8pESs+
         iGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741692950; x=1742297750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRhhFOV50S8nkiKWbxOQjhnR/D7pnJ4RjNLNNRoG574=;
        b=ee8+nnqYHGyuXO5p4TVS/f+ZbeQ2srm4ZGrFkQbh768LQgwRIqcTwMHq9kkg5Jyuvc
         zav7g5lMvgGCOEQ2uQJGFdZdZPm+BvePHAgc7mxjw0uz7qD5dCfpZeJbFxHmjvFaMD1L
         0mjD9LFkAuac6f4CYBwyLO9xrvYeuvYvnZwY/FDrr8BCMHK0pGfhiulPzHnE5n0pCT9R
         nBsawJpy+4mi0u0jDZgXI2BYq9rotBVoblaHy2AW60zGZFKZ3KwXjEiWH9qqqlFckeQ6
         6VZGPbxPjh81WQoPVqoQKWQnyj4bbStP6q3cYHGKJjbr4TxYjV7BGtFi7/LVJPvNDu9o
         CNuw==
X-Forwarded-Encrypted: i=1; AJvYcCX707YcTsfFPCljlEDATbed1ZLOX3m3hRatYgS9ZrnGcHEGFNOhxaUAAHcdutVe/E1pHFo7s8dTGiiAVFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0PY+TjfkD9Dg70TD+xEJQ9KtO0U5MtOtQj0PbqZu8KHEaGIJ
	nA4nrWGLrIi9VRooloRsIC1dsyQBXH/nrFY0LcRphJQxDQk3XG3geuHWIpwE+NM=
X-Gm-Gg: ASbGncsaBpOnQCBKCdHXnYHHdlqFKV9mnwDcEuQcj9GgMTL5YZpqfiZPieHWDvCCe8r
	5f0zV6hMNlhL5WAoJDPsQ5qUn7NaKvtAKZSCiGw73dvQpPl5zhl3aWNskvQdZi61xm0OQcxOrwD
	KrQpPgn7Q81XlBUVYCmMUV7U1hZspf/WCkaxTK8kPPsIM4mFJw8gSHJy3ROZHoEHKSQj1mUnnad
	Ag8//aSWgjRqbBj1FLUpg8xbWGK1m47xfzzEB29WdNgqtglXBVhckS8c2gYRjFzIDvlnsmF6TFc
	orb/zux1fV1YRsRJjR8cELRapblFp2HAL9iZw0AEWGmZ9H9tkHCTlGKOATGh/+0FvKfTdCs3OZt
	SBOhYM7RDlubl
X-Google-Smtp-Source: AGHT+IGVJsJ/tQDtRk3D58VsHDhx/tt/Tli65otubVC+55JrPtE5bG4yX5BvCZyT6vnF2dPKlEKCgA==
X-Received: by 2002:a17:907:3e16:b0:abf:fb78:6743 with SMTP id a640c23a62f3a-ac252fa0fedmr2145428366b.35.1741692949753;
        Tue, 11 Mar 2025 04:35:49 -0700 (PDT)
Received: from localhost (host-87-14-236-98.retail.telecomitalia.it. [87.14.236.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a65c7f7esm277405266b.117.2025.03.11.04.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:35:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 11 Mar 2025 12:36:59 +0100
To: Krzysztof Wilczynski <kw@linux.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 03/11] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <Z9AgW1TEiJ3G9dvh@apocalypse>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <c0acc51a7210fb30cae7b26f4ad1f0449beed95e.1738963156.git.andrea.porta@suse.com>
 <20250310212125.GB2377483@rocinante>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310212125.GB2377483@rocinante>

Hi Krzysztof,

On 06:21 Tue 11 Mar     , Krzysztof Wilczynski wrote:
> Hello,
> 
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d45c88955072..af2e4652bf3b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19752,6 +19752,7 @@ RASPBERRY PI RP1 PCI DRIVER
> >  M:	Andrea della Porta <andrea.porta@suse.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > +F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >  F:	include/dt-bindings/clock/rp1.h
> >  F:	include/dt-bindings/misc/rp1.h
> 
> I would be happy to pick this via the PCI tree as per the standard
> operating procedure.  However, the MAINTAINERS changes do not exist
> for us yet, and are added in the first patch of the series, which is
> not ideal.
> 
> I can add the missing dependency manually, but that would cause issues
> for linux-next tree, which is also not ideal.
> 
> I saw some review feedback, as such, when you are going to be sending
> another version, can you make MAINTAINERS changes to be the last patch,
> perhaps.  Basically, something standalone that perhaps whoever will pick
> the misc patch could also pick and apply at the same time.

Sure, I will split the changes for MAINTAINERS file to its own separate
patch in the next revision.

Many thanks,
Andrea

> 
> Alternatively, someone else picking up the PCI dt-bindings would work, too.
> 
> Your thoughts?
> 
> Thank you!
> 
> 	Krzysztof

