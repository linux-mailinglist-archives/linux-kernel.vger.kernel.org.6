Return-Path: <linux-kernel+bounces-390637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8A9B7CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249881C20A00
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E11A0732;
	Thu, 31 Oct 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PWs9TC7W"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF741A0718
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384390; cv=none; b=iBsGX2CGkOMg8roLzWjjvqlST6GA29JZR5Zgu07ZYOqm0sBlEimZuwW4WbVfzKB9JqnowtcTGDMK8W5ErG1lgH9ku3li87a/z2etjLHOkKTVpznPDpQSfHJbrXTO8n8Cv+awy7uK+jOTNbBn5QGbDKPO+jwZaRXWpKIJrn1blHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384390; c=relaxed/simple;
	bh=PWQX7SnfjbZidOlrXf4jY4+SlsOeBgBtUEt8Ddtd0jg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjIcubudhlIgR6lqb5vAHbR5rzCqY4JX0E2E+dfBl4eAF/8OyW7BL8UF0eSNMciqa1mXXfmcJM1UaMDU177/5LV2mxlUM5hwGmaN8BKronGI9w2mcfEe914Wm7IV0+q93iuCmVkZMLeAKV6jD5Wn0CVKis8SI9E21ztjiPgjJK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PWs9TC7W; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so614290a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730384386; x=1730989186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVUmTxmFHTbxuLXdUJhPx7kX3ILoUiW3IeTmfpkoY6o=;
        b=PWs9TC7W258qgA7r2mOpVUFUNwAFjm4i3dxxATRXQbbiBW1++MEMpazUw+9ZCf2xKi
         eAB+wO5fGKu+mhRO2gxTbELc8o+t0FEh34rAkU7Znd0Zo1oJvtk8enu+nGFPg8uOYACW
         UWoHG/7QcnBn6eJU6fNCHoUhyAG0DB1wG6OY/dI8TzfE9XagEzJ+YNtLSIS7udOYyjZC
         zhVPx8Q6dgjDyHstru6HNuCk6Jpo53glBlas8AOsMakwpWCDIQ0mv+olK89J8sHSmZ70
         uw1WFPynGqB8/e+qooW/g9cu+slA4tw8r8y1APUkYwQ088NUPAqM3RVYwg9FXIxBnFpb
         90Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384386; x=1730989186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVUmTxmFHTbxuLXdUJhPx7kX3ILoUiW3IeTmfpkoY6o=;
        b=A3/yn0BtDvigZNi2axpFh5b5ccuMgC6DTufyFtqNdHQomAAeuhkDhY7YbQPrAnXOvq
         DmphJ+xavCgr0Xo1PbkAczQebD+nqaLBesnUW6q4+nOjqq9DPrtuuEUXO5uwDRqld72x
         GNPfks/GsjdV+Ttn625DwALIoKThJAGcVbe3EZihG3LrF0rTO3suqVHOe8EtRUQGjRTq
         qhogu05ImFpI7DhFgnRb1Ir7v60C+FD/Zp54sq/JhY3gzRXLdGAmcC09bggP+M2yJ6XT
         lAXtY2uPZFEIG83VeHunhKdlXgNyZt2WY1kr0VjtNUe/dSAlRljVtBYfe2BzabUkUNvM
         S1kg==
X-Forwarded-Encrypted: i=1; AJvYcCXAHTWnsNEAFXmPMY4U3e+jnljZxM71Po/xqbLGo6tUF/52qsgeJsUMWivf2XPjN6ZCVMILOPOJfCQcq9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5g3VvTR6kCdAUPOST6pZSYfrr2dPB3nQMPU/58g6H5Bvffa4k
	MEe5PPdBFhl4NPovMLErq44+C32AK9TUuRLGuKSrGncxXs+9L0tsWbo0VxVwVXs=
X-Google-Smtp-Source: AGHT+IFBlmMQ8BF9VGOE8p6eOCCFYLNGVsY0KuYK2zU9xVixT1ZKB8UzaLusANFsmSbOvc8av3xycg==
X-Received: by 2002:a05:6402:278e:b0:5c9:5745:de9a with SMTP id 4fb4d7f45d1cf-5cbbf8a40c4mr17455994a12.9.1730384386255;
        Thu, 31 Oct 2024 07:19:46 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7700dbsm627152a12.34.2024.10.31.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:19:45 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 31 Oct 2024 15:20:10 +0100
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
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
Subject: Re: [PATCH v3 03/12] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <ZyOSGgJ4zb31Posb@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <2948fdf8ccf8d83f59814d0b2a85ce8dac938764.1730123575.git.andrea.porta@suse.com>
 <fwqcbnub36fk4abmhbtuwsoxdlf64mx4v65mxahsxmiv2sz6er@bfjddapvb75v>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fwqcbnub36fk4abmhbtuwsoxdlf64mx4v65mxahsxmiv2sz6er@bfjddapvb75v>

Hi Krzysztof,

On 08:28 Tue 29 Oct     , Krzysztof Kozlowski wrote:
> On Mon, Oct 28, 2024 at 03:07:20PM +0100, Andrea della Porta wrote:
> > Common YAML schema for devices that exports internal peripherals through
> > PCI BARs. The BARs are exposed as simple-buses through which the
> > peripherals can be accessed.
> > 
> > This is not intended to be used as a standalone binding, but should be
> > included by device specific bindings.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../devicetree/bindings/pci/pci-ep-bus.yaml   | 58 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> > new file mode 100644
> > index 000000000000..e532621f226b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/pci-ep-bus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common Properties for PCI MFD Endpoints with Peripherals Addressable from BARs
> > +
> > +maintainers:
> > +  - Andrea della Porta  <andrea.porta@suse.com>
> > +
> > +description:
> > +  Define a generic node representing a PCI endpoint which contains several sub-
> > +  peripherals. The peripherals can be accessed through one or more BARs.
> > +  This common schema is intended to be referenced from device tree bindings, and
> 
> Please wrap code according to coding style (checkpatch is not a coding
> style description but only a tool).
> 
> Above applies to all places here and other bindings.

Are you referring to the title being longer than 80 column here, right?
Because the description seems correctly wrapped... or should I add a
newline for each paragraph?

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

