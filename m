Return-Path: <linux-kernel+bounces-383565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2169B1D69
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB16B2108D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8C152E02;
	Sun, 27 Oct 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BeYUpPqv"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45813D51E
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730028715; cv=none; b=jSNk0qqKeoJpya3bWIXNcGFoVMyJ+VHWgki+2F3la0nY8Tkqpoc0osY7egpGlN27Xv1G7K+Ejh7vuzW/R4/qIM9iltEQENt73imiQVg5XDR7WJdpr390W2yQ51eV6y5y3mMt9vGkAES3RVxoQqYUo2JQd03yAy3LB7hEwWQWbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730028715; c=relaxed/simple;
	bh=DUouMkMPwYUhhB5hED3nqhrzsDLSLxK8Lc6msZq7Nzg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0eqO4PoevYWGZ0ETVaa02WNzUGOrzgzSVnKIkeehHHyFFJBxdE0V5jdnQK/qY228yAGmM8xq85fFEtl0c5YCdELbyb08O+DBsBC2AzTSibwgTappYsQjoEENJZOvIU8hosTyELniKOO+RACaKPv5Y5nKebT/6CI23TBbfgAxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BeYUpPqv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a850270e2so562558666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730028712; x=1730633512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zAAzwkbywlzLeMZLJye29I/uk/b0SdAyD/UYaZSIBHA=;
        b=BeYUpPqvrVOuv6Xdg/R2sUE3NKi/OOJnJrJyBag3wR3o7SxO/BwV094pkgdWPs99tX
         HlY9ExKswQDhH3EOn9Co4o5r7bY8NfKJP22bx0qZwiu8gXWR7kV2B16P02zPGGaWqAbd
         7TjkBEUK2rW1Z8gpHJOTY/b/BtCli5pEvUTlP9s8AKpxRkmLd/SZBOAXfJxZ1ADHQ7H1
         5t/iHUIazM19B7bRd7fBfTRSAh62MbMGcOubGRAB2HVq2feD6QIX6VpvQG0ZgIm22Jbs
         kvNkCZEWwEoT44YxyAnWixjNYd9UT1QXC9usei+6eLzE18mLw4J79b0ESKVdv/eBcEv5
         ODqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730028712; x=1730633512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAAzwkbywlzLeMZLJye29I/uk/b0SdAyD/UYaZSIBHA=;
        b=sbRpRP5JZwikmg+zJt5KO94sXF7bcgWs+4hC1qCiZDDUvNohrjUGahA2MDjcrqPc6n
         P//bDLDae2LDvXWtt0cJQTVmDX0xweKMTVDsU7PpvWKVPWu56z40IUhfXUp2WUvz4U3D
         4C8wgPyWvtMVDKRjNsN3IQUWcTfGFkqTbvkn4dAqqMQHfsn0gEi/tyoHkWRStklehgqS
         n7sB864JCfxK8WNFcBF9hFLVl8yNWCLM0SYfbbTw/gZls1EeC4kqgh+MIo/zEvQ6KHcO
         U6bhrgZUpYkJ4gfNmnJPhrB0JFDHycXCgz2KyWFj1ppr72BQh4PcZBe2GKYDxCASwtwO
         ApuA==
X-Forwarded-Encrypted: i=1; AJvYcCWrkgDATyt4QsBMv7l4gaWzImw8GJLGemklqzag3UXfo/jYQI8BlR+2UcbTva+sI3nTuX2hV9rfemn8p7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+fzxPL2iAPIZ2eAs14i7N6MuVFMiFz+3wjUym7Z3LCQRWLUp
	IglfcaGF++v8cJzgV2mGErVIXmR/MuK8oL2MrflUZW6S5CohN03L3+RxYtcAoT0=
X-Google-Smtp-Source: AGHT+IGcb2nHqx14PUMkCNT0X9V9WO/5lNGB1I27TxVk6SwkaaRS/wDbac5hShyQwMya3guhAU4zFg==
X-Received: by 2002:a17:907:1c88:b0:a99:e1a1:473f with SMTP id a640c23a62f3a-a9de619406cmr494261466b.57.1730028711767;
        Sun, 27 Oct 2024 04:31:51 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6347f20sm2238951a12.86.2024.10.27.04.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 04:31:51 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sun, 27 Oct 2024 12:32:14 +0100
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v2 09/14] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
Message-ID: <Zx4kvoKpni9oqPi0@apocalypse>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <199a4994312b120c73c95fa368954ad5a2a8aee6.1728300190.git.andrea.porta@suse.com>
 <CACRpkdb1muovPmKoUw=Q5sNXj3bsCt84LcKVDSLY09_5_1rXZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb1muovPmKoUw=Q5sNXj3bsCt84LcKVDSLY09_5_1rXZQ@mail.gmail.com>

Hi Linux,

On 11:03 Fri 11 Oct     , Linus Walleij wrote:
> On Mon, Oct 7, 2024 at 2:39 PM Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> > Add minimum support for the gpio only portion. The driver is in
> > pinctrl folder since upcoming patches will add the pinmux/pinctrl
> > support where the gpio part can be seen as an addition.
> >
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> This is a nice driver and I find no issues with it, what causes
> an issue is gpiochip_set_names() as pointed out by Bartosz.
> If you can live without the names you can remove that part for
> now and we can merge the driver, then you can add the names
> later when we sorted out how to share that function.

Sure, I'll drop the gpio-line-names patch for now.

Many thanks,
Andrea

> 
> Yours,
> Linus Walleij

