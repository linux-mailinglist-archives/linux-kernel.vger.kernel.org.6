Return-Path: <linux-kernel+bounces-545190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3DCA4EA9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84348E4348
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844727FE61;
	Tue,  4 Mar 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s//inOZT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF42900A0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109538; cv=none; b=bo1Jx+xiERTW+8hJB6H2eZg1tWTOp/sl04rT7uNwDbXxW0bxJ2axr3A5IjrnZB/P5XauT0EbePLkz1FnmAc6H4MRDkXgjbtUueP1B0ZaL6e+BOpDJEvxrB+Cbgj8vNKn2ogAwJqRFtusEw2RT2DDqy8/ar1U6b6dzNBosy0dmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109538; c=relaxed/simple;
	bh=GfRaN3GMHCOGJJtYN1aMtMnR1ziLLUOWvjFRsYfDsy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eunEDlH6GTkL16bNLpHR+ARJM+AkvN4zxpYx+TVVbnY2vAYBs8sE2bHK9I/Z6bGYCmwd4OGAEBw0p8qTTL5ju/62UJNXcxXg65YHBBekGgGK089Ny5WgvhW8KvaqMLgqqu+PirUqisMDwQAdMIxU/BFhtofLJ0EvwDGM4weFTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s//inOZT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223cc017ef5so34230945ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741109536; x=1741714336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13UO/bBBmk74lWYurj0NLoL8MAPIZRHSkEPYSBsPdwc=;
        b=s//inOZTk0BbUWYPsZu5oFPfCzjL9+hYz1y+mlAOupyeWg/nWx8ZcFszFYtaHY8YxJ
         pr2c6T5MVio9qzD9khzKyNAPs3DWSLLgM7ChMyoNCGE45vAl8PyEJ6pk0NUYZGiVCb14
         Bf0FiH635tL7+F6JIZvv49hcozQAokxF3qMvMGiFh3vScZ1gU1Ey6oKi9Yy8FlsiEZtt
         JRIw+lVE4YwpS3pJCrNIMDzhoV3z43xCtanAY0suFq6pX+76r5UC9q6fqaLB1SuPeSNP
         S4fqdCRyqXzVxlmVx0eWVUwkOXXuUqQ8DI5nVlQqJlF1Jbsuv9R21GxjSOMX6xrru4zv
         uRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109536; x=1741714336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13UO/bBBmk74lWYurj0NLoL8MAPIZRHSkEPYSBsPdwc=;
        b=HdmRuwR0kRMQDwdhDLWuaDxAL/gkIupq0dmuaZaUY6uSspFm4wO9ZWgQ3/wzCVcV6A
         30wevbT0EYbj7XivTjeO2ivUm3ojFq+RPpP1e8PybrSpjbOtitC3GvxDj5949Bs/UU7A
         IH3retIDru+uhBGzV0/W1fSoE4L+ggdZ52MgyCeItTd1vfZvl9co7uqMGxpXD9W5iqPA
         8fkyNDndErg3ZzynNeNyEVoj69nqXtE8ftqDvuO9pehD9GWT1llsMgJcGITlaP/S1MR+
         S4p0pi24wcXUsELQiJw/nd6vEao59ZxWxseacQ1CSH2PlsFgj6KcWaX9SxUjpvflBbXs
         01+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQbPE0eEzbeJXT0LpMRT7tOBASqA5Kzjvx9DjzAWMIkM4a/uaC53J0eojGCZg6GogVWYO3qf37naW6tsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8JzWYQ9raEGspPrUyu7C+CkxBIRalrsvKR0xSdxgdwF9OALnR
	gn06mfpaXyMjmicT+PAxnofUrg9NRNnoFuT3ANlXs7MXO123lTT4dHx2xHI206frEYHZRWb4MvY
	=
X-Gm-Gg: ASbGncsC+woDHJyhKKKelikkIrJhuNEHE2raj3X8CYoDkhiBrFTXavaGQnB6dpkACo9
	RwMYisjLLoeu91fJ9pWYTx4B1l4udag9FADZcgOGvbzvPBtNTzlRwsJKvre8rpQzus/njgSAnnv
	6Tos4XYxVQAfcyfxKZU711QPHCCpswPE6uQs1zNtirQxHyvNxSHXAVdkUpkXpP0Ni13c2A9124z
	bv9THLE8UCxjg5EG3M7L/M7wnWjq3LuZMh/kaeU/Ei/L7pi0VTYeCsapiMVqqfeTq4HgxgvZwTR
	hJXWT8lSxsx5rqiNZqC4dqU9KGyWUpG0hPJ+fkFz0yzM5DxHxZVxZNw=
X-Google-Smtp-Source: AGHT+IENsKkUhuv8gc8RI2eXokbdYucKOSdaT4IfgbHgCVm5rtH9K7HDvp2i58wnfep6Wo8pLoIlBg==
X-Received: by 2002:a05:6a00:ad0:b0:732:5611:cbb5 with SMTP id d2e1a72fcca58-734ac372044mr29269358b3a.11.1741109536419;
        Tue, 04 Mar 2025 09:32:16 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736387b2c1dsm7106697b3a.64.2025.03.04.09.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:32:15 -0800 (PST)
Date: Tue, 4 Mar 2025 23:02:09 +0530
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
Message-ID: <20250304173209.bq2lpijsea7aufpu@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-5-james.quinlan@broadcom.com>
 <20250304150313.ey4fky35bu6dbtxd@thinkpad>
 <CA+-6iNyuQskVNjAuX1QcLTPetbfhogGYUTOA01QwNw9YcwAdNQ@mail.gmail.com>
 <20250304170735.x25c65azfpd7xmwv@thinkpad>
 <CA+-6iNzvqnZB=7kRqUm5ie6245AM5ObeVmMNQ_S4AtMLD0jKQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzvqnZB=7kRqUm5ie6245AM5ObeVmMNQ_S4AtMLD0jKQw@mail.gmail.com>

On Tue, Mar 04, 2025 at 12:24:56PM -0500, Jim Quinlan wrote:
> On Tue, Mar 4, 2025 at 12:07 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Mar 04, 2025 at 11:55:05AM -0500, Jim Quinlan wrote:
> > > On Tue, Mar 4, 2025 at 10:03 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Fri, Feb 14, 2025 at 12:39:32PM -0500, Jim Quinlan wrote:
> > > > > If regulator_bulk_get() returns an error, no regulators are created and we
> > > > > need to set their number to zero.  If we do not do this and the PCIe
> > > > > link-up fails, regulator_bulk_free() will be invoked and effect a panic.
> > > > >
> > > > > Also print out the error value, as we cannot return an error upwards as
> > > > > Linux will WARN on an error from add_bus().
> > > > >
> > > > > Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > ---
> > > > >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > > > index e0b20f58c604..56b49d3cae19 100644
> > > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > > @@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
> > > > >
> > > > >               ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > > > >               if (ret) {
> > > > > -                     dev_info(dev, "No regulators for downstream device\n");
> > > > > +                     dev_info(dev, "Did not get regulators; err=%d\n", ret);
> > > >
> > > > Why is this dev_info() instead of dev_err()?
> > >
> > > I will change this.
> > > >
> > > > > +                     pcie->sr = NULL;
> > > >
> > > > Why can't you set 'pcie->sr' after successfull regulator_bulk_get()?
> > >
> > > Not sure I understand -- it is already set before a  successful
> > > regulator_bulk_get() call.
> >
> > Didn't I say 'after'?
> 
> Sorry, I misinterpreted your question.  I can change it but it would
> just be churn because a new commit is going to refactor this function.
> However,
> I can set  pcie->num_regulators "after" in the new commit.
> 

If a new patch is going to change the beahvior, then I'm fine with it for now.
After all, this series is already merged.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

