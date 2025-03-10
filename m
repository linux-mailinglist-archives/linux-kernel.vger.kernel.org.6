Return-Path: <linux-kernel+bounces-554364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCDA596D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0270F169D24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F922B595;
	Mon, 10 Mar 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AHY/c072"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BB22A818
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615115; cv=none; b=DZhTBXK5cl8uckmCZoe0PSPx0DyjnzZSGJJ++D3f/rr3OgBhyQYxFWaK9kSW0/OdNQZQi0ZuopuXnKoltgv9HvoQU8tseJ1GL7MyMUa3l0l0RaieSoWk48SKFB3TBkD5LM4frpEB7JMdfkrjzvCW5Q+5CVGKY+3qBy52GBH0zRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615115; c=relaxed/simple;
	bh=i9GxyKAVB18HnH+g2lVwQvXz5I//zOKa3JmIOEbrK94=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZbdlbybXxUS2U+RZT2WjPk9+j9w5WTaIloSxJ5yaPXDLN5ePS+qwUXP6qgUXRxwGM1dE8uU2ogjvtzrlWpmsZC8tZhE1Nj/Ys7IDHx2RaRU9Ukr+OfFMolp+D/UiyD+VPOorID/i376XN0nYNgZqTCVaosKQs8bFOQps6/h7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AHY/c072; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4140440f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741615112; x=1742219912; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6bOGmoklXRtJQxdeWHpYOOfYuKnU0zJof9I6zGwu64=;
        b=AHY/c072S/rTv5X4B7RzTjFt+WNE6wTGVRHpxbTVLrZCFV122NhUaa1ZGl1h+d3FzJ
         ravRkaFQp+F0YVLAa+VXB/q5BfrZFE81RLywDtCjHLejTadqpGDN6wajA7Wukj98+rlc
         Q5f+7l+2x1a++74psGcqjOhZS2FyRYlzK7X/tgDlXL0a3yN8SPzuax81c7QvgeLKezR2
         NI2tl2hDaLsU/nY0Yoj05y9ueF6fYS30hk+a3vbTxFzXTG1oHUM+rD454QEnSdD+iDt8
         88yfbRVK7lMVEtvq4wqc32w19TNg3yPHi56qroS2EATt25fKgrgLqjkeJIJlBe67d92r
         +m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615112; x=1742219912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6bOGmoklXRtJQxdeWHpYOOfYuKnU0zJof9I6zGwu64=;
        b=vZYiwYPz4OfvXyD80GHgQCIHfR6xsucf4j+qfakzUBzDwTvB5buk5N7+IWnoh6ndgr
         l7dK6mWPR7qRX4M6tdDVFZfez/npTe4G6RbaAFFkl45dF6Z7YpdxXTwvplst3bURnpQ/
         jx0KyZxIBpcqm2DgoeBKOyPNLc5JLvZzoWoyE3GdaFQBXaSKgyS3wnxaqeMjsu3MlN4o
         //l6q1x82bN2cnZdrQ53vR0ylktBc6Cg3LiJLw3cnYnxoCqlY87iaqgQECry4+v9LW49
         OQQT5bxs9C96PLIB8sEG1N86so0qZx4awbWhXBmTYi5PzIZbmDyYOQ7+4DKKF2sds+0/
         LsPg==
X-Forwarded-Encrypted: i=1; AJvYcCUMZ3XNPkG0XnFkC6Odc1IbcUeYvNaT1w1ZR4MD7jDv5U3n3L8OL815X0Mlo5+aziSC55y5SGc5ecC+jxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGlKt7GdAt5777AKQcaMy/+HSzlTxkWszjlyDT9m+s18vWutx
	OxYyAEheNhTkX7WAZtDkly7f1lBzaOz43KKn5DHrzaRMNVQT74VfsPnOBdLVxxg=
X-Gm-Gg: ASbGncuKUt0YLwqnynJ7USdzgTLkUrmEEituV8TbtVOiR2//AxHt5NQcPFyABFE01GO
	M29rmevcUTundIK1IofyHoUw+PVdgRKaZqrP3+6NmG6h2hpSd88P86p2I/IS+Gqh7Wf5WfWxQ8g
	rjJFVJjkn5o+weTBWj7z5RFfWqaaDxdDjoHJyOXMNjSOBctT6rsu10BsJcKZwBCk+DX19uHM7N2
	+fLYDNrvcaATkMxWxhVv2iEGBOulSsdE3WiUX5N3kIvLUydyaHWJ5ml7AHFj99ebpohH1HwqjCx
	4h2WnNcjFlEsJxhkGwg7S7W4pqzlgdmieqV7S+zFgEeZ0Wk6xYtJglkdoEneqImj7YgcppHenrx
	uqCQ6A0ZKyDT00vHe2YT0utE=
X-Google-Smtp-Source: AGHT+IGyhk5+VAMcITm5rrq0aJ90sKdh4cQmUoqGgN6Meob+XW4ZpicfvmV1X3pFEScV3weEws3UqA==
X-Received: by 2002:a05:6000:1fa4:b0:38f:577f:2f6d with SMTP id ffacd0b85a97d-39132d093demr10173742f8f.2.1741615111629;
        Mon, 10 Mar 2025 06:58:31 -0700 (PDT)
Received: from localhost (host-87-14-236-98.retail.telecomitalia.it. [87.14.236.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac299a025c7sm236754666b.51.2025.03.10.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:58:31 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 10 Mar 2025 14:59:41 +0100
To: Phil Elwell <phil@raspberrypi.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>, andrew@lunn.ch,
	Arnd Bergmann <arnd@arndb.de>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	bhelgaas@google.com, brgl@bgdev.pl,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com,
	devicetree@vger.kernel.org, dragan.cvetic@amd.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org,
	kw@linux.com, Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	lpieralisi@kernel.org, luca.ceresoli@bootlin.com,
	manivannan.sadhasivam@linaro.org, masahiroy@kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, saravanak@google.com,
	Stephen Boyd <sboyd@kernel.org>, thomas.petazzoni@bootlin.com,
	Stefan Wahren <wahrenst@gmx.net>, Will Deacon <will@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <Z87wTfChRC5Ruwc0@apocalypse>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com>
 <CAMEGJJ1++aeE7WWLVVesbujME+r2WicEkK+CQgigRRp2grYf=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMEGJJ1++aeE7WWLVVesbujME+r2WicEkK+CQgigRRp2grYf=A@mail.gmail.com>

Hi,

On 16:27 Thu 13 Feb     , Phil Elwell wrote:
> Hi Hervé,
> 
> On Thu, 13 Feb 2025 at 16:14, Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Phil,
> >
> > On Thu, 13 Feb 2025 15:18:45 +0000
> > Phil Elwell <phil@raspberrypi.com> wrote:
> >
> > > Hi Andrea,
> > >
> > > The problem with this approach (loading an overlay from the RP1 PCIe
> > > driver), and it's one that I have raised with you offline, is that
> > > (unless anyone can prove otherwise) it becomes impossible to create a
> > > Pi 5 DTS file which makes use of the RP1's resources. How do you
> > > declare something as simple as a button wired to an RP1 GPIO, or fan
> > > connected to a PWM output?
> >
> > The driver could be improved in a second step.
> > For instance, it could load the dtbo from user-space using request_firmare()
> > instead of loading the embedded dtbo.
> >
> > >
> > > If this is the preferred route to upstream adoption, I would prefer it
> > > if rp1.dtso could be split in two - an rp1.dtsi similar to what we
> > > have downstream, and an rp1.dtso that #includes it. In this way we can
> > > keep the patching and duplication to a minimum.
> >
> > Indeed, having a rp1.dtsi avoid duplication but how the rp1.dtso in
> > the the kernel sources could include user customization (button, fan, ...)
> > without being modified ?
> > At least we have to '#include <my_rp1_customizations.dtsi>'.
> >
> > Requesting the dtbo from user-space allows to let the user to create
> > its own dtso without the need to modify the one in kernel sources.
> >
> > Does it make sense ?
> 
> I think I understand what you are saying, but at this point the RP1
> overlay would no longer be an RP1 overlay - it would be an
> RP1-and-everything-connected-to-it overlay, which is inherently
> board-specific. Which user-space process do you think would be
> responsible for loading this alternative overlay, choosing carefully
> based on the platform it is running on? Doesn't that place quite a
> burden on all the OS maintainers who up to now have just needed a
> kernel and a bunch of dtb files?
> 
> If it is considered essential that the upstream Pi 5 dts file does not
> include RP1 and its children, then Raspberry Pi are going to have to
> walk a different path until we've seen how that can work. By splitting
> rp1.dtso as I suggested, and perhaps providing an alternative helper
> function that only applies the built-in overlay if the device node
> doesn't already exist, we get to stay as close to upstream as
> possible.
> 
> Phil

So, the problem is twofold: the first is due to the fact that downstream
expects the dtb to be fully declared at fw load time (I'll call that
*monolithic* dtb from now on), the second is about how to represent dependencies
between board dtb and rp1 overlay which arises only when using overlays instead
of a monolithic dtb.

The former issue must be solved first in order for the latter to even exists
(if we don't use overlay, the dependencies are fully exposed in the dtb since
the beginning), so I'll concentrate on the former for now.

There are 3 possible scenarios to be reconciled:


1 - MONOLITHIC DTB

This is the downstream case, where it's advisable to have only one dtb blob
containing everything (rp1 included) loaded by the fw. In this case the
resulting devicetree would looks like:

  axi {
    pcie@120000 {
      rp1_nexus {
        pci-ep-bus@1 {
             ...
        }
      }
    }
  }


2 - RP1 LOADED FROM OVERLAY BY THE FW

In this case the rp1 dt node is loaded from overlay directly by the fw and the 
resulting devicetree is exactly equal to the monolithic dtb scenario.
In order for that overlay to be loaded by fw, just add 'dtoverlay=rp1' in
'config.txt'.


3 - RP1 LOADED FROM OVERLAY AT RUNTIME

Here it's the rp1 driver that loads the overlay at runtime, which is the case
that this patchset originally proposed. The devicetree ends up like this:

  axi {
    pcie@120000 {
      pci@0,0 {
        dev@0,0 {
          pci-ep-bus@1 {
               ...
          }
        }
      }
    }
  }

and this is exepcially useful to cope with the case in which there's no DT
natively used, e.g. on ACPI systems.


In order for all those 3 mentioned scenatios to work, I propose the following
inclusion scheme for for the dts files (the arrow points to the includer):
                   
 
 rp1-pci.dtso         rp1.dtso
     ^                    ^
     |                    |
rp1-common.dtsi ----> rp1-nexus.dtsi ----> bcm2712-rpi-5-b-MONOLITHIC.dts
   
   
where those dts are defined as follows (omitting the internal properties for
clarity sake):


- rp1-common.dtsi ------- // definition of core rp1 and its peripherals, common
			  // for all cases

	pci_ep_bus: pci-ep-bus@1 
	{
		rp1_clocks { };

		rp1_gpio { };

		rp1_eth { };
	};

- rp1-pci.dtso ---------- // ovl linked in the rp1 driver code to be loaded at
			  // runtime from rp1 driver. Only for case 3

	/plugin/;
	fragment@0 {
                target-path="";
                __overlay__ {
			#include "rp1-common.dtsi"
		};
	}

- rp1-nexus.dtsi ------- // adapter to decouple rp1 ranges for non runtime-loaded
		         // overlay case (i.e. only for case 1 and 2)

	rp1_nexus {
		ranges = ...
		
		 #include "rp1-common.dtsi"
	};

- rp1.dtso ------------ // overlay to be loaded by fw (case 2)

	/plugin/;
	&pcie2 {
		#include "rp1-nexus.dtsi"
	};

- bcm2712-rpi-5-b-MONOLITHIC.dts --- // monolithic dtb to avoid any overlay use
				     // (case 1)

	/ {
		... all rpi5 board dts ...
		&pcie2 {
        		#include "rp1-nexus.dtsi"
		};
	};


with only minimal changes to the rp1 driver code, I can confirm that all those
scenarios can coexits and are working fine. Before processding with a new patchset
I'd like to have some thoughts about that, do you think this is a viable approach?

Many thanks,
Andrea

