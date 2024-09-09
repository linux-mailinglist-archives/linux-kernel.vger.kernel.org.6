Return-Path: <linux-kernel+bounces-321070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0597140C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC8F1F23D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10D1B2EE8;
	Mon,  9 Sep 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecEvKZXu"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F8161916;
	Mon,  9 Sep 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874986; cv=none; b=s58E5ruLV89B1mPnBmq4qc1ETmzyZvHKZTfybTCKG9TDeT03gA0dCwE5D1GiMGfJC0BMCWal4nR8UNnEKfwJpXb04262IQTJfEJZsYmdzP+r7VmjbvnfKA3E/SWycusvwuu3HVOfwqxPwB5ICAPspF2J3MNit2UPrpupvlKdyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874986; c=relaxed/simple;
	bh=DhIoIebUv4PD3LizG5RpptLQUIEStidCV5UBA3Ms/Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/JVI6vEzKaBQ773a+roYTeveEAuOIURLi1CPHdmRe2+kHhP9pg4V0Vvign8UGQr31Oc8z6eVyRuEhqhnKYgkPfoHEKH7cltqUSYb49so437S0fscE0fCtoZE9I5umEu2Uhz928oy7m4ke0VY4sbCxc2HLakcFdH5Rb4K4QehpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecEvKZXu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26852aff1so4533717a12.3;
        Mon, 09 Sep 2024 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874983; x=1726479783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji0IvUtxVUfOYtXesPSGRkrVGhlLL5hSJeqIOnfvC5o=;
        b=ecEvKZXuj+mWwnAsKVAlFSfuBgum+pqdLLrDXLMCvEUe6UH+vGcrpOXdXMKgxe++Ak
         GBw0nyvTVmZ0wHAs2ioNMxgBXqiwfriM8laXogJtsWIdb1tqIzdMi9+8r7ztM94Z+SXI
         BJ9A9r2zzQaDpGgKTdTpK1M7g6dDmh7mvqvOS6JaXEo9FYrRg4148IvNQHB/KsUvtL1w
         V9BB7Op0M0GCbY3MB+E5SVa1ZFCt634GudSPlKs8Xt7IfgJm3lk/QbTOS7apHuf36jqB
         YfNnjAgB1K4AwKSvQMYU2XZH6cM+3wWNvELthBeqgHO9doGK4fUfbzQ5phZ7425kBYoa
         JPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874983; x=1726479783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji0IvUtxVUfOYtXesPSGRkrVGhlLL5hSJeqIOnfvC5o=;
        b=fxrOgBP7GJ0Y4CRjMFRHSJgAC1/ZBxT5huy8da/WBC7SwiCyMV+RXj9SNzFo7yS5iM
         s6KMTesHR9t3W/Su50fU/r9AxoeYiqopz6bgfU75Cn8CzaXoZ/KqeUfSEuyMcvn2y/vk
         PakvJxqBI+iVYWadnVErgQBTD/H6d5fSg/qX0qyMa4LckV7oJ0Y/Z5ebo6YDw+gUSzwm
         dkKPr5ktcOScD8Sdch2M2OHropl1wLqAqrdDPSduvR58bVi9dqWFZiv+JU403XMAPo6o
         usMU9PVmVMhlyD1pOjub0/oxNtZkFd0yftSOvBDj77p2pcvEsJYpoe1F2/j4zYoayHRs
         w8FA==
X-Forwarded-Encrypted: i=1; AJvYcCVSV3R4efUnLaBgMLqVMJZJQFzIT9uSFiIo3BUTqh2C0fcE0iaazOA+QnMHyGbEQOLxIvmIs2e1UnbH@vger.kernel.org, AJvYcCWgVulYlezsys/tSe5iPnygXn7hsNZ8gjJ3wAGyRWVzYj8XM10VFLV9fVxCxWE6j0Di/6l7k+TH1udfJGAY@vger.kernel.org
X-Gm-Message-State: AOJu0YwLUKRRmpvqwDTeTUU6DAMcARdnmlAZdWq1bATaTncGU+5E+VGF
	a0qSjvKLSn6lgxA8VwQN7XIl8GButkRSwiwQMCgzK2u04QqIthy/
X-Google-Smtp-Source: AGHT+IHsut9MezX+RTKRlovYO1s+sRZbsf5akjJcSm8/w0bQW6T6B9e2Pa66ERuitPaxaEK8jwSRAA==
X-Received: by 2002:a05:6402:34d6:b0:5c3:1089:ff3c with SMTP id 4fb4d7f45d1cf-5c3e974d9f6mr3460080a12.35.1725874983126;
        Mon, 09 Sep 2024 02:43:03 -0700 (PDT)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd4693fsm2812530a12.37.2024.09.09.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:43:02 -0700 (PDT)
Date: Mon, 9 Sep 2024 11:43:00 +0200
From: Max Krummenacher <max.oss.09@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Aradhya Bhatia <a-bhatia1@ti.com>, max.krummenacher@toradex.com,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v3 0/4] drm/tidss: Add OLDI bridge support
Message-ID: <Zt7DJFM_xxOkhDwX@toolbox>
References: <20240716084248.1393666-1-a-bhatia1@ti.com>
 <20240906114311.GA32916@francesco-nb>
 <c60d518b-ace4-48a8-87e5-35de13bc426a@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60d518b-ace4-48a8-87e5-35de13bc426a@ideasonboard.com>

On Mon, Sep 09, 2024 at 11:15:28AM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 06/09/2024 14:43, Francesco Dolcini wrote:
> > +Max
> > 
> > Hello Aradhya,
> > 
> > On Tue, Jul 16, 2024 at 02:12:44PM +0530, Aradhya Bhatia wrote:
> > > The addition of the 2nd OLDI TX (and a 2nd DSS in AM62Px) creates a need
> > > for some major changes for a full feature experience.
> > > 
> > > 1. The OF graph needs to be updated to accurately show the data flow.
> > > 2. The tidss and OLDI drivers now need to support the dual-link and the
> > >     cloned single-link OLDI video signals.
> > > 3. The drivers also need to support the case where 2 OLDI TXes are
> > >     connected to 2 different VPs - thereby creating 2 independent streams
> > >     of single-link OLDI outputs.
> > 
> > Have you considered/tested the use case in which only single link is used?
> > You do not mention it here and to me this is a relevant use case.
> > 
> > There is a workaround for this (use option 2, cloned, even if nothing is
> > connected to the second link), but this seems not correct.
> > 
> > We (Max in Cc here) noticed that this specific use case is broken on
> > your downstream v6.6 TI branch.
> 
> What if you set "fw_devlink=off" kernel boot parameter?

Hi Tomi

My overlay specifing a single link which did not work by default
results in a working panel with "fw_devlink=off" on the cmdline.

Max
> 
>  Tomi
> 

