Return-Path: <linux-kernel+bounces-447841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152069F37B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958F5188DCA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB1161302;
	Mon, 16 Dec 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qD98ZbA/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE22206281
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370793; cv=none; b=uDL41J4ryLA4aK+tNtOomd6YHy3ybPSn8pzMDkq60NO/SnAHu7JHgkAv32wHY4uPk7+Uomq/hp70A0PII8cmEl6o0PY6eOZSdOFiNXKToszNZPOeg2mn2RbOaEbl1IepAyAY80NXSDQKpHLBT7heZd/17sKRuXeDqwD9SEyQ8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370793; c=relaxed/simple;
	bh=sZagQfOkP/6cpyqYRongDqTCVNDMffmQq9AdjQIl0Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQTjvougKIxDScgukrYSMkGifDWl50UCIZwrSpMumpu0KUtEKsbx1NJCfRg+ym+zdnDYB4VoAOBaWcelKNKtVVAfCGBH/rpAdIPXZnKgUcf4HGkQcNpen7liAG3GiCvX+8qPnpLMtZF9TU3N9/7/fLocR7bN1h1AUSsSInEhJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qD98ZbA/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso32815885ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734370791; x=1734975591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JtZZYgUYoOwyubJGQdNNWpZEzlkbDlyszV0/xNC2FM0=;
        b=qD98ZbA/6vu+pKV6qNjIZVvVVZzrTIk4lryK+JWKBQ3uiuJC95OesT6yunc1FqT1uh
         VvJ8aiTCJFNpfS7KKR0iFPNQ5H/t9cJDin4VZb9jYpatL7K7cRSDSZU9UGVC7fAeTSHv
         lL61WMTevIlvsNJ8rpl8shczhZWO6CokUaPH8xLIrXbi0vpkSyJZbzvLt7TP2Ihvv46m
         p9su6kYaEtVJlvycwkY8LeDfpQ0amuKgavcGOR0NMh2C8zy5Dw1KKl/KRBLMOUuJAQEI
         x8sXmA5O50YKSl5h8hBw4Sxa6tsU5hKJwFF8Qm61eEf1T0qzGYY22eCt90WhHo8IJ5gW
         wPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370791; x=1734975591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtZZYgUYoOwyubJGQdNNWpZEzlkbDlyszV0/xNC2FM0=;
        b=FivmszBxMbm7pHkiUgKKrNW+c6/0oolniqK3fFHDaGiCq7x5y6+6Cm5FGL95gMr6Wc
         y7KncR9N7qVp0MD77RCB+0pEnF2htnA5Topjg6BVEAT52zYoizrrIK1RCD09TqHzX15a
         CSeI+yMFddqMBF1VR+Qhyy6AnG4BdjyYMLnytVsQF23nFpNALAZXUWg81HF6+EAaW02h
         +mlnNMw1KPLgsjRW8DCzzbM8KCxpTWg1XmFvTVlH0BOA4b3SFdTuDuor33ofOs3mMx3N
         x2SjkE3NG+w2J+IjA789yDzvikPuFS249ROqO6Y1djs29hetsTLiQQc+kVKP/0LKCQKR
         44hg==
X-Forwarded-Encrypted: i=1; AJvYcCV9V9+Tb0Zo4O07tbskg+aMS/QxQJvMUx6w6oe2rqOR6AarkahWQJ8fUMRSJ/BRd2raZjhLYh6pGyQPdcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwunhO2iQYxjvt5hrmpaf2ZmlTOZKPea0z+wIwjZ/8EQYpwY3dr
	0zmxdGYQXG1r5US4K8r2TsZjmCnmNGbOVhm24j8BuBqq2AaIrYgKBaQZ052oSg==
X-Gm-Gg: ASbGnctAW7Md2OlKS6D65FDEj8hUxfgwRHKlNtKNuKT2zkeBoZ3e8YhmqAvmxbLPFJ5
	ctNnRy5j+PmAQ/J1p6cC908rXXNb58qlALN9kgWNo3Jit2hhUppVwZtbKFiWWfRd9ynPZmYMpWv
	r8oRFmm2IFfEeZrFSnFBAjgkeLwNJkazmklCFP4iPB8LQmwEAQI4t6h3v8LJUlsULfTBg26YzEa
	yECKOkrZKylGIb82A41IxIUvq0cth1qecj4Vd4w43EuxsOK61vKFjwAhk5rFRWytJk2
X-Google-Smtp-Source: AGHT+IFQcMcDVID0W/UMwjtnX+YPifcFR9pDYG5iFdtJCREYhFobz06S5WtCY8l9lvzCnul9WOa+xQ==
X-Received: by 2002:a17:902:d4ca:b0:215:6b4c:89fa with SMTP id d9443c01a7336-2189298266fmr161242345ad.8.1734370791170;
        Mon, 16 Dec 2024 09:39:51 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5f3f1sm44322435ad.209.2024.12.16.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:39:50 -0800 (PST)
Date: Mon, 16 Dec 2024 23:09:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241216173945.s5y4dsyzhi5fo4ey@thinkpad>
References: <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <20241216164830.36lpu6gfnapsdar4@thinkpad>
 <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>

On Mon, Dec 16, 2024 at 06:28:55PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:48 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> > > > > We need a PM core API that tells the device drivers when it is safe to powerdown
> > > > > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > > > > applicable to other devices as well.
> > > >
> > > > Maybe I'm misunderstanding things, but I think the important part is
> > > > to indicate when a suspend actually MUST put the device into D3.  Because
> > > > doing that should always be safe, but not always optimal.
> > >
> > > I'm not aware of any cases when a device must be put into D3cold
> > > (which I think is what you mean) during system-wide suspend.
> > >
> > > Suspend-to-idle on x86 doesn't require this, at least not for
> > > correctness.  I don't think any platforms using DT require it either.
> > >
> >
> > On suspend-to-idle, yes D3Cold doesn't make sense,
> 
> Why?
> 

Because there is no requirement to remove power during S2Idle, isn't it?

From Documentation/admin-guide/pm/sleep-states.rst:

'This is a generic, pure software, light-weight variant of system suspend'.

> > but on suspend-to-ram it is pretty much required.
> 
> Well, I know for a fact that on x86 platforms ACPI S3 does not require
> putting devices into D3cold in general.
> 
> Why is it required for NVMe?
> 

But ACPI code currently calls pm_set_suspend_via_firmware() for S3 suspend. And
that causes NVMe to be powered down because of pm_suspend_via_firmware() check.

> > That applies to DT as well.
> 
> Again, why?

On DT systems if firmware supports both S2Idle and S2R, devices can be kept in
low power state during S2Idle and powered down during S2R.

The problem comes if the firmware only supports the former state.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

