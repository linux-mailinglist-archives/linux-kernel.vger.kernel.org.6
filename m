Return-Path: <linux-kernel+bounces-545124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215CBA4EADA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AECD8E4854
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49398292FBB;
	Tue,  4 Mar 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abSM0goa"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C88292FA2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108064; cv=none; b=YPsI4p9Kv2/chl5Zr2kD958FWdHHiwyJ92BuFBl6ATpw4VwAR+NjFhYqpqGYqrksnzL95Qe67eqa2TYlK5gwugabdbHevZB2KuLOPxfXhumds2BnDb4zVcRWqUBAGCb2yhxED8jmBveEbhtXcEWRusvhWX4qNK4d55Ea9HwOj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108064; c=relaxed/simple;
	bh=QHv5JCwHtgDm/Ul5VHa++1ruQ4G4MsndKdh1G1m7pDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiM8InTtl1IQop8BjrZxhWRue1/Upw2uG8rfFtLBe9XnrDnNeWCEGd1dxzAKZo2+vY3EIA++44vOgxGrXm5ZTw3gch2EwsFJlFoKmoXJ0QTu6IfCdx7TnInPEW5JsioJjuQvx1+ILplijXKsw/ZN7L8ki87i3oI9bB8/dYwSqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abSM0goa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a7065ff8so67817785ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741108062; x=1741712862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LA/gKQoFR6dHj4YM+SZIs58tGSpb3MhpX5oaTo2PxFg=;
        b=abSM0goanpsDmjrSzBLrQkIyUFXrKBoZCvyIlTeWoanmxO69DjIO3u/ev3mL63S4J3
         1OkzZFAwZsU0ZghEFuWZD+9WR8yjBlwWKQJQnNhZYisoqCfta5fHxbkKTE89v5kgfJMB
         moYR3Aw+CHbMW0AM8tg76pk8kNsHHnXSH6aIPJuuubElJz7e14H5iDD59wKCIF87cF3Q
         LeDAUiFSamt+x8V34CtpflIZTihuXlf437Eus+ZQQ3N8mhYoJ//bx9kx+anrGQA5hvpB
         lwIY3XNJzKLif1t4IMaQQIWrjDctmj0PDKBdWQsiRxEfMyy47hN8QT3FvmEZA4zx7M7/
         dV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108062; x=1741712862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA/gKQoFR6dHj4YM+SZIs58tGSpb3MhpX5oaTo2PxFg=;
        b=bDyGTx1Fwube6pL5ECn2T7Zs8Oz5NcYRC6AY6guO1Jii1g/jRY/zFhOehxcY/oPSJ+
         MVtPBHVn4bOVgNyxmfk27T7wSUAuo8PZzkfHqyXSW10iQ93R/spYwXbyxooHWh0n/xpw
         t+brmwJWXzDx0yPeSTVEXNYQPCtHY6wf1jK3BwJ7/Cvv2hOypH/FHAh2EeJrShoNTIg8
         EwZM6yhStCrbhkFi6MCH35xajAl2EFfy9tQq5X3TVutz3/S6WOkckNBmHpScyWOznBDi
         Bci8y+3mPGlC8/gVzoPYCTzIPwbGqohTPoAq+CkOGj7RW7IwK9NsjJGjpJEgROnyridk
         0QxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUZhgbyC9zzDxldFUaDz+54POFmSAeFbpFjlQDgrtjpATPfJd/Z1kl2uOCi9wmdDL/uokx2Auv4ytzM40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKn9tjiDvqmmHx+RvGfMTnsldmViSpVRRhy9wpTIfgoyOip2v
	wMnZea4Ld7A1zDGa0wTQu2tAAZ9AJTCqws69co1+Z41osBnsbS/WREPLtfjUCg==
X-Gm-Gg: ASbGncsnU89B8xDzpBBoq9+ktHrDNTsmq68JNfL2Y6IfY6iydvAenkbH98WnuV9iycO
	ukXbaFV88rdDpVZroxWAXQf+4tGSAHDJOojdt9FDwYaePmXFgFXK3nNK0qxZgzDG3AAOPrTbR3H
	a8NK/KwPvueEqixN759u3bcUmRIqBq8JrBBNl6/EHN8MWFr6apHwFRMQB60CLctUboAbVhzjrYO
	wm+2bVamgReuiu/DP9JCqhFJDvUiIkvqckjKdO0LakXnUer5Bqm1cXiYBYKlcRtaprftwWB4qhf
	OPhgVu6whWSIGkxvAB5SVaiE04Q/gf/zHHTbxev1WAHMBfsxle7btDM=
X-Google-Smtp-Source: AGHT+IG9lPytOJ+a9BnKqGkMxxZf/h6DwbYyJiWJ/Q5mVWVtyO5FnvNkcSD22Lz3G7gAfZDKnHhRPQ==
X-Received: by 2002:a05:6a00:1250:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-73656645c9cmr11645970b3a.15.1741108062382;
        Tue, 04 Mar 2025 09:07:42 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003fa5csm11529695b3a.145.2025.03.04.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:07:41 -0800 (PST)
Date: Tue, 4 Mar 2025 22:37:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250304170735.x25c65azfpd7xmwv@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-5-james.quinlan@broadcom.com>
 <20250304150313.ey4fky35bu6dbtxd@thinkpad>
 <CA+-6iNyuQskVNjAuX1QcLTPetbfhogGYUTOA01QwNw9YcwAdNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNyuQskVNjAuX1QcLTPetbfhogGYUTOA01QwNw9YcwAdNQ@mail.gmail.com>

On Tue, Mar 04, 2025 at 11:55:05AM -0500, Jim Quinlan wrote:
> On Tue, Mar 4, 2025 at 10:03 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Feb 14, 2025 at 12:39:32PM -0500, Jim Quinlan wrote:
> > > If regulator_bulk_get() returns an error, no regulators are created and we
> > > need to set their number to zero.  If we do not do this and the PCIe
> > > link-up fails, regulator_bulk_free() will be invoked and effect a panic.
> > >
> > > Also print out the error value, as we cannot return an error upwards as
> > > Linux will WARN on an error from add_bus().
> > >
> > > Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index e0b20f58c604..56b49d3cae19 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
> > >
> > >               ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > >               if (ret) {
> > > -                     dev_info(dev, "No regulators for downstream device\n");
> > > +                     dev_info(dev, "Did not get regulators; err=%d\n", ret);
> >
> > Why is this dev_info() instead of dev_err()?
> 
> I will change this.
> >
> > > +                     pcie->sr = NULL;
> >
> > Why can't you set 'pcie->sr' after successfull regulator_bulk_get()?
> 
> Not sure I understand -- it is already set before a  successful
> regulator_bulk_get() call.

Didn't I say 'after'?

> I set it to NULL after an unsuccessful result so the structure will
> not be passed to subsequent calls.
> 

If you set the pointer after a successful regulator_bulk_get(), you do not need
to set it to NULL for a failure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

