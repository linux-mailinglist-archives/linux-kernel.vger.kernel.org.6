Return-Path: <linux-kernel+bounces-566015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44357A67220
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059A23BFF06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669020969D;
	Tue, 18 Mar 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KCHl1uMi"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A56208989
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295844; cv=none; b=aqbgeRVsv+dOCClV6EYkkf7H29Vx5xvDPiNYdxxmLM9bUXORFR08u8um3NZ3/L4lglZ6dJa84+zKJA50maNnNwO4Jf0ciwAS7FwL3m/uJL3Bd7ifiMt8e1277bvUdVwrbPydqhyHLlnb7OLjklhhLfl3p1ql5OC6828qPCd2lTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295844; c=relaxed/simple;
	bh=4v+Fsi08Fwv3zu1k13Ka+W1n8gTUPuWDc5vnbr4NK+k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3oWMGlFvw4JnDIn/e9ZWlSTitnnAIWaPCtod07TpksASmXp6JIvRM6D/gxQJ8s+3Is6tKEore3ZTvJZVWB9NhxafWeSZjS4uRT22Tfl96ZAwyAUo7QRTMaH8zCtbT6hwPIKjnTmr+8UbAyzcv2jNI5tuPrs7jweOaI0fct1jjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KCHl1uMi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac298c8fa50so1021269766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742295840; x=1742900640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=is8WhR9m8WQE+4k9i/DT+FdMHQKk7RaZk/UQmejRp3g=;
        b=KCHl1uMi40c8cwKLuGWZ5TZVwXh8ppfgC3SmGQWDrjap53sf3ZBnVC7f9rd8KPckIC
         VXg/JL7lXs/3ABH+E+t5ZkN9vwCq/lAmp7CJnRfLWws2n9Ud49DkDEmn/tghKpc2pEc4
         WFdgcMO1JBzddJVqsFNKpmvNhqpY1YmzN3gbs76ZujwSGV6/4E9omSKS0/svpJhjygxd
         t/YUmPNytteNxWUN9GPBg5nzRkL+xemTGfjUvR/lUgMMnwCHpVciN6xSmNJOApA5FGp3
         CzykRdcrEFeBMsPjjsGlYwLC3/KjJgQ/ho+hYdT86w/CWynWved48KD0lrsXDibYWvu4
         9siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295840; x=1742900640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is8WhR9m8WQE+4k9i/DT+FdMHQKk7RaZk/UQmejRp3g=;
        b=wGjAbS1fB/vP18EYeVaUhYhZGA4KTTY4pjrjQ1VaKFLkpKuNguGLw48Xxoj3GjhyPH
         g27i7qXiiZ4XkY3gnAL8WH7twxS8mK67B8jzaWqUu2BwB1OPKkRqtih/yavAH/2/x7HE
         DRTse8h/twvm4d+Av32zbfvm7e4zyzNs2tqPmmt1qpVYsjB/zqyWeYDs3W0C/F7Mat9k
         pOtKzRigNiEjW7GH1Hmj6FYtmHYTXDrzb2uWyt3kXuL3UL1avKldv6UsoFn5fd1HCRBs
         oXLD2Fkp9Xeli9b/Pf9guHaZk49jw7niW7ySIlf+0wA+qKNxdWG/BSg3o3Soq06Wk6IX
         gjAg==
X-Forwarded-Encrypted: i=1; AJvYcCX2hXz8r0gdNAZG2coyUgoqMWp3WhcgPzqjXwkCi4FR1cxYUtTsD4immwD5LzUaVDCDJiNY7cKcKDYRDk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVdnG+lrSjkrVXBmx9EU0sqIuhwqTAkwasLRej01bS0/eKWbM
	3m4w3/7j/CsaO9Tnr2lHDeaBthvbRBlw/ve0+aoxZkbuVr7Qv2vZGfBYyOUm9AY=
X-Gm-Gg: ASbGnctoWbicZ960j7KMmg2a4O9oLBl6axc3BrTTBruZjUcu+DlEWFxcbOZWkbH6BC0
	XfOhONWrWxKcel2wt2Ikv27Z0VTIYMXQVPA22c9Vt68L27ejhCcf5/GuvpTFd0vtT6RPCEWs4pn
	GApRnoiPz4bBQKwRQijcuR3E42iurDyJukHpufVENxYLbrQCjT408/PUfgFdJi4OMNgeLjBUR8P
	f58cTDLGE8TN2F9ScxlnSD/DEpSTnOOIXgyRJl9FeohGMWXV47MszF10Nh2Q7Va/IbvRi3iIh7s
	TYtGgt9cj5yTwzB+LYDuebTGAdZrSSpCzcUl8P8bNLpQ1xH+pjei0VY++L9UUmJ3XBT9ADJbweD
	Us148cN82+/wA8Ro=
X-Google-Smtp-Source: AGHT+IHSFIas9nSr0GTvP8XDNoyPypRdkL0u01Zf6bNvQk2jQCXUoByUBqIy6f605R78yLU5u1JN+Q==
X-Received: by 2002:a17:907:3e0d:b0:ac1:de84:dec0 with SMTP id a640c23a62f3a-ac3302d3694mr1426644966b.26.1742295840401;
        Tue, 18 Mar 2025 04:04:00 -0700 (PDT)
Received: from localhost (host-80-117-53-131.retail.telecomitalia.it. [80.117.53.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aea4csm828388566b.33.2025.03.18.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:03:59 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 18 Mar 2025 12:05:12 +0100
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Stefan Wahren <wahrenst@gmx.net>,
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
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z9lTaKsbLND4i3Ir@apocalypse>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
 <87525350-b432-40b3-927c-60cd74228ea4@gmx.net>
 <Z7dnnW4npJmfOVE0@apocalypse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dnnW4npJmfOVE0@apocalypse>

Hi Stefan,

On 18:34 Thu 20 Feb     , Andrea della Porta wrote:
> Hi Stefan,
> 
> On 15:21 Sat 08 Feb     , Stefan Wahren wrote:
> > Hi Andrea,
> > 
> > Am 07.02.25 um 22:31 schrieb Andrea della Porta:
> > > +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> > > +		rp1->level_triggered_irq[hwirq] = true;
> > > +	break;
> > > +	case IRQ_TYPE_EDGE_RISING:
> > > +		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
> > > +		rp1->level_triggered_irq[hwirq] = false;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > It would be nice to document why only IRQ_TYPE_LEVEL_HIGH and
> > IRQ_TYPE_EDGE_RISING are supported. In case it's a software limitation,
> > this function would be a good place. In case this is a hardware
> > limitation this should be in the binding.
> 
> All ints are level-triggered. I guess I should add a short comment in
> the bindings.
> 

Quick errata: s/level-triggered/active high/

Thanks,
Andrea

