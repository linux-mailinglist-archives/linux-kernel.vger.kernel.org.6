Return-Path: <linux-kernel+bounces-532037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42BA447E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2065E8668EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3819DF81;
	Tue, 25 Feb 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rm+HC3RI"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5818FDB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503711; cv=none; b=YnPm2KTuKWpk8J6NszyEzaN650tMIgOB37gcUMc7y9JKVAkx1yBO/LHJRp02yR6mKywYMpqKxThNBDcb5Funyw2NISwFRfo6OMe3yIh84CqekyLQ6TtOBZPDnAwqzBJL57Thku6RiQqumQYtz8VgE0t6hhrvxjah+FxRyp+HghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503711; c=relaxed/simple;
	bh=bL79cNVobOr1HRq/LkKge12+uGo654Ifd9y3+CyTMfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxqtt8D95IE3CCwJbTVrFVi7Ln6xMaAC5+5rLQ9gxklBH57d5RMxQL0W/CyYlajSAOrOA7fZX4u355GrWYukegX9oJFnjiWTMW9JiN3POKflBEBLM/HFelH+2ABaLbfp8Ou4C+yEHCZb23NIM1LItnp4O25uNazbmcAv/GYbod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rm+HC3RI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso9061342a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503709; x=1741108509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FF54yqkuvwX1pBRnFH8QcIU5TxlTBf1rKceF/MbIVBs=;
        b=rm+HC3RIaWhCKUU89MCfoXEI2TGwnmgKO51HfnF1iTpYVF0H4GGjviL3KN7tRo1l4h
         JRJ5F8PN6ae2vnrjZwyyfGdWcg8GILEOHtjMSZsoXEzHvLESsa7SZ3rylZRVHtIseFtz
         ectkD2rkofFa05sDoG8T2lQgUznRmu76psdkObr5Wh/M7hMgtpr9bcVAjbrp9hnpuJY0
         zIpJBVGt2aTHVuy/bLk6TxgU4n2RUrAxaRqShqie0IEOn6ApSZM1kQHGj/VaYziqs/Fs
         mtv4C6C5F/BneqSc++UIB2Gn2kgMOO9affc/aT0BGRmYYwHpIygb1g/Cs5SFdYDayFfj
         0Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503709; x=1741108509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FF54yqkuvwX1pBRnFH8QcIU5TxlTBf1rKceF/MbIVBs=;
        b=ITf/VXI3tSRiLr89I0jgiRvJXRsI8yRBhuIrcvqBsJaJVE9IoVqb9IgkXqXunSXtOW
         Hi9ZmkDHiGyJgKjuXXsYRyZBZiVNBt/fXMS2IJ5ICZggiX+ViTx4ir2JqFWiK60qXBp6
         pfwRhpbhRv1PzcwfT+E6iZo67JW8CmwTap2pE9mPb5Zk92yM07LE2fr8sKKMnNZSDHGo
         GI5LSQmvAakjmihbpN0KgmjmsIBX49IzzF6N9QqDw39f7+PZLmjUGaLXH5d6AlDRfyO3
         3jU+VZ9WEkLtDfExf5mUBQ2BLjWIAOroKPAiEIsyt53q3R+10PlmN8PUAVjLSYGkkDIz
         A5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPAD/2VpZGzGHd7DmG2p8DP0Y17wosndnHTOrQFF7+5yqFtfkdgvw5+IgHICkobRUZ3iuCL2gZCX+KHCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RkNp4fT2ANMwxtnde10jhV1d3OjQp6Mx0KFFfFtbCkvYJIi5
	h1PdqyoNx8KecaZrzdtrsvC8iKi+BkiDx/MJAewLvF2REEFiK68VdomuS8fasA==
X-Gm-Gg: ASbGnctg/RvoAH3w2c2JNikhTH+UoKvz1MJq2G5/lTkMTPpsybw0tTNWqVzLwrYCjcZ
	JHZpwies4VvXV9mU78CI9OrX1/MhiNK8CsRsdLXOl+ypvjZpOWco6JxIDRpfw1ZbG04G7nJgafY
	gFNLp9zALZOKav3oYpUZd1uveRRcxCSVy6LQc6A1xCZ6wDlC4XiWLfMn4yG43xcGlViA9VAOQpM
	4x+vc+SPn0QzPO5YzA+437M/5/Fs4PcuvVSqVvV4RZ0SZduWRmsSSpifLpYKqDh/wzXZiuYasDy
	KGoOGpArO5eIUDDiXGsHjsiEi8X+BpOgQFJI
X-Google-Smtp-Source: AGHT+IFbyIk/t2FBVqbowzwmc33Cu/Xhw0HHnO9qzMEv+9/uViTPYk/jm8Aw+qCax7VxnPMgSI0asg==
X-Received: by 2002:a17:90b:3506:b0:2ee:dcf6:1c77 with SMTP id 98e67ed59e1d1-2fe7e33b210mr241444a91.16.1740503708928;
        Tue, 25 Feb 2025 09:15:08 -0800 (PST)
Received: from thinkpad ([120.60.68.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceae302e7sm8889686a91.0.2025.02.25.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:15:08 -0800 (PST)
Date: Tue, 25 Feb 2025 22:45:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <20250225171501.ahjmawunnpyc7wwa@thinkpad>
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
 <20250221131548.59616-1-shradha.t@samsung.com>
 <Z7yniizCTdBvUBI0@ryzen>
 <20250225082835.dl4yleybs3emyboq@thinkpad>
 <Z73VLYudJVPkdbGN@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z73VLYudJVPkdbGN@ryzen>

On Tue, Feb 25, 2025 at 03:35:25PM +0100, Niklas Cassel wrote:
> On Tue, Feb 25, 2025 at 01:58:35PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 24, 2025 at 06:08:26PM +0100, Niklas Cassel wrote:
> > > Hello Shradha,
> > > 
> > > On Fri, Feb 21, 2025 at 06:45:43PM +0530, Shradha Todi wrote:
> > > > DesignWare controller provides a vendor specific extended capability
> > > > called RASDES as an IP feature. This extended capability  provides
> > > > hardware information like:
> > > >  - Debug registers to know the state of the link or controller. 
> > > >  - Error injection mechanisms to inject various PCIe errors including
> > > >    sequence number, CRC
> > > >  - Statistical counters to know how many times a particular event
> > > >    occurred
> > > > 
> > > > However, in Linux we do not have any generic or custom support to be
> > > > able to use this feature in an efficient manner. This is the reason we
> > > > are proposing this framework. Debug and bring up time of high-speed IPs
> > > > are highly dependent on costlier hardware analyzers and this solution
> > > > will in some ways help to reduce the HW analyzer usage.
> > > > 
> > > > The debugfs entries can be used to get information about underlying
> > > > hardware and can be shared with user space. Separate debugfs entries has
> > > > been created to cater to all the DES hooks provided by the controller.
> > > > The debugfs entries interacts with the RASDES registers in the required
> > > > sequence and provides the meaningful data to the user. This eases the
> > > > effort to understand and use the register information for debugging.
> > > > 
> > > > This series creates a generic debugfs framework for DesignWare PCIe
> > > > controllers where other debug features apart from RASDES can also be
> > > > added as and when required.
> > > > 
> > > > v7:
> > > >     - Moved the patches to make finding VSEC IDs common from Mani's patchset [1]
> > > >       into this series to remove dependancy as discussed
> > > >     - Addressed style related change requests from v6
> > > 
> > > I tested this series, and one thing that I noticed:
> > > 
> > > # for f in /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/counter_enable; do echo 1 > $f; done
> > > 
> > > # grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/ctl_skp_os_parity_err/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/deskew_uncompleted_err/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/framing_err_in_l0/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/margin_crc_parity_err/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_1st/counter_enable:Counter Disabled
> > > /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_2nd/counter_enable:Counter Disabled
> > > 
> > > that there are some events that cannot be enabled when testing on my platform,
> > > rk3588, perhaps this is because my version of the DWC IP does not have these
> > > events.
> > > 
> > > (Because all the other events can be enabled successfully:
> > > # grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Enabled | wc -l
> > > 29
> > > )
> > > 
> > > 
> > > So the question is, how do we want to handle that?
> > >
> > 
> > This is a really good question.
> >  
> > > E.g. counter_enable_write() could theoretically read back the
> > > dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> > > register after doing the
> > > ww_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> > > 
> > > to actually check if it could enable the event.
> > > 
> > > If counter_enable_write() could not enable the specific event, should it
> > > perhaps return a failure to user space?
> > > 
> > 
> > Yes, it would be appropriate to return -EOPNOTSUPP in that case. But I'd like to
> > merge this series asap. So this patch can come on top of this series.
> 
> I agree that returning an error is probably the nicest thing.
> 
> However, this series has been picked up already :)
> 
> Is there anyone who volunteers on implementing the proposed feature?
> 

I did and submitted the fix [1].

> If you have time, it would be interesting to see if you see the same behavior
> on QCOM SoCs. (Assuming that your DWC PCIe controller does not implement all
> events that Samsung DWC PCIe controller does.)
> 

Yeah, I observed the same behavior on the Qcom platform, though only 2 counters
were not supported. But I also noticed a null ptr dereference due to refclk
dependency, so submitted a fix for that also.

- Mani

[1] https://lore.kernel.org/linux-pci/20250225171239.19574-1-manivannan.sadhasivam@linaro.org/

-- 
மணிவண்ணன் சதாசிவம்

