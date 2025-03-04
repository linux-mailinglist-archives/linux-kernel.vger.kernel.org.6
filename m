Return-Path: <linux-kernel+bounces-542996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0FA4D055
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF24C3AFB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC299522A;
	Tue,  4 Mar 2025 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX9ndzye"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609978F54;
	Tue,  4 Mar 2025 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048934; cv=none; b=n8jJK8HyUsR+yADAtcwpxUnTOGgC1jK/+QTWnBZpp8+tNDq/TxQ3qyrgUvxiRncmWBrEtl+NKiBKRtaQ/rysiMrwwoohtnodQktYr0Pm7yHt9ntUikPM7dKflwqZ/RuSDXcJuc//i1sS1Z0ZnIucUoy0DasMenjuMcRYUX5w6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048934; c=relaxed/simple;
	bh=GNfL2qC5c4jUOHJOSM6S0gz/n3qbC3I+1m4V2d8XCc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqHVzAa1fGjoH3g4LkEfepC+F8lcZvCUQsA3DRV61xPTvvMR9PHGeGitWwUDb1moNxUZCIDE/ZlTJFsrPRJB6PeKIsgh1w0yhtSpsIHwPdg2zDSY+Qd4RoEvEqa8swkXvhXVxwyGoHGnfw0OA7LV/K13XbVZ6BIM6HAbfp1qED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX9ndzye; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c07b65efeeso460274185a.2;
        Mon, 03 Mar 2025 16:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741048931; x=1741653731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxNe4AxjqQpAaoybhGjdA9/tvpgF72J/S4MlsUJ3y90=;
        b=SX9ndzyetUJBqpcEuJAItYSHyBoBTO+t+R5luhHFrWpsr/RltofL1QnMdlVQhXeG45
         xA9r7esbLer7+SiW/63kOfD9/0HRatJFPOPpUR794J7eYvq5yhiDYW0KwvMN2P7TYZvZ
         +4u/rVBX/idZ2z1K4kldhco9QhmUq9GYqJVzgyndYvSoyQbdDxhh9dH6VrObQLP8Cu7Z
         je10++2rkMD9Ez0bTzY3NWpsJlfFUzZRPFw4G5TyyHMjw9YTjj0Jif+/BahRHmMtAYuc
         Jsw+fap4KsrCuaaaHrMgkpv5CmI1yRQC4/Em71TJZS1lcAfPebrzCz/e2dwLKPN7+LGq
         phPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048931; x=1741653731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxNe4AxjqQpAaoybhGjdA9/tvpgF72J/S4MlsUJ3y90=;
        b=qlFo1OZXZ5uYCa8Ma0QyTezhp4sXZzc5wd2S2O4GaXDNhaWkxcgj51AiwEiA2kOLR5
         gQd+TgzFUjbPrnWM5xZKTlcbyKhGN7gB72EG1hUyfSAXuE56QAbV6hvFn7fC4BJsbaTZ
         jx1xBhwiwKyGErdfxQ71PRK27P6WY5vbwhI0Wmm5nHAYvAMC7uQko2iqUTCAoxU7rOwJ
         vq3HEq8gL4XkgW26Nt0sRUEjfnucOCJWu78LjktfQk3fP7UXYcFuWVyGIWCTF4UTTfMa
         pnieKq68adSYxMJItCLESqgBli/BP0iWGWl+VkiiIFB9agUfXdMybqQrDZU0Q9i5AnKl
         ZvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi6SWTsfJJZUsfvjGTXNdjQmZlUWEq/95uRXTyP5OHhSwoapuV6bORcAtPOBcMaQ8zO4XXMXTg3C15@vger.kernel.org
X-Gm-Message-State: AOJu0YzXK9MkKyCsyIdz/NpdK4Z2HAdsBVKvDkL+N0U2suZr7Zp7P3bo
	vUOuvamVdxQt8SSKz1mzx5oJftU5vYfBzssR2xUeocNsu0RGupOb
X-Gm-Gg: ASbGncugfxs8ruBiygYdDo8ls3mw99GrRQo0lv+4H49Xp3CG587Hdo5hLTYWM2ynhQb
	dLBzYvhZQEkwPNGgRwt+MKbsehfmD0GmyhjHbVxYhnsukkQxZBMEK0blSQRUmmCEsamKs7MJSRI
	IGS3A40Yoy+FaClWdDqtIOB0gQ9pXbK6rJ+vDwlL+EPsbniYwErY5dP7GeRikCXKXPVed0lf3PQ
	kLSZZs+apfri0BuHrdQNF+d/nPPvBgIv5F31EuNbqav36qNFpozS6eMMcC8InK/wMhdKwBULwAY
	v85sbYJ5kgjsJntD4+Uf
X-Google-Smtp-Source: AGHT+IHEle02VkkTCUKA++q4iryvBoKPXpR9o6rZ7Y0oiuWfh62nccflHOETM6sqmAhK1Bt/TseLOA==
X-Received: by 2002:a05:620a:8903:b0:7c3:cd78:df38 with SMTP id af79cd13be357-7c3cd78e308mr127164285a.10.1741048931148;
        Mon, 03 Mar 2025 16:42:11 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36fee8abasm669532785a.7.2025.03.03.16.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:42:10 -0800 (PST)
Date: Tue, 4 Mar 2025 08:41:44 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI
 interrupt controller
Message-ID: <757rsspeayo5yzfrlzd7pe7aqzkhiycjsow6rfgo75sqkaow5t@b3eahj6dclmb>
References: <20250303111648.1337543-1-inochiama@gmail.com>
 <20250303111648.1337543-3-inochiama@gmail.com>
 <87y0xlc3mz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0xlc3mz.ffs@tglx>

On Mon, Mar 03, 2025 at 08:31:32PM +0100, Thomas Gleixner wrote:
> On Mon, Mar 03 2025 at 19:16, Inochi Amaoto wrote:
> > Add support for Sophgo SG2044 MSI interrupt controller.
> 
> This patch fails to apply on top of:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
> 
> Please always ensure that your patches apply against the tree/branch
> into which they are supposed to be merged. Grabbing random patches from
> the mailing list as base is not sufficient. It's clearly documented
> against what you should work.
>      

Thanks for pointing that, I will check the tip tree and see what
is conflicted. I forgot there will be something changed when
merging patch.

> > +struct sg2042_msi_of_data {
> 
> There is nothing specific to OF in this data structure. This structure
> contains the chip and the MSI parent ops of each variant. So something
> like sg204x_chip_info is way more descriptive.
> 

Yeah, chip_info it more clear than of_data. I have forgotten this
driver is not just for dtb but also UEFI fdt.

> > +	const struct irq_chip		*irqchip;
> > +	const struct msi_parent_ops	*parent_ops;
> > +};
> > +
> >  struct sg2042_msi_chipdata {
> 
> and rename that one to sg204x_... as it is not longer sg2042 specific.
> 

This is OK for me.

> >  	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
> >  
> > @@ -29,8 +34,10 @@ struct sg2042_msi_chipdata {
> >  	u32		irq_first;	// The vector number that MSIs starts
> >  	u32		num_irqs;	// The number of vectors for MSIs
> >  
> > -	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
> > +	unsigned long	*msi_map;
> >  	struct mutex	msi_map_lock;	// lock for msi_map
> > +
> > +	const struct sg2042_msi_of_data	*data;
> 
> Please keep the tabular formatting of this struct. See:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#coding-style-notes
> 
> >  };
> >  
> >  static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
> > @@ -81,6 +88,37 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
> >  	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
> >  };
> >  
> > +static void sg2044_msi_irq_ack(struct irq_data *d)
> > +{
> > +	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> > +
> > +	writel(0, (unsigned int *)data->reg_clr + d->hwirq);
> > +
> 
> Pointless newline
> 
> > +	irq_chip_ack_parent(d);
> > +}
> > +
> > +static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d,
> > +					   struct msi_msg *msg)
> 
> No line break required. Please use up to 100 characters.
> 
> >  static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain,
> >  					  unsigned int virq, int hwirq)
> >  {
> > @@ -119,7 +157,7 @@ static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain,
> >  			goto err_hwirq;
> >  
> >  		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> > -					      &sg2042_msi_middle_irq_chip, data);
> > +					      data->data->irqchip, data);
> 
> The conversion of the existing code to this should be a preparatory patch
> for ease of review and the support for the new chip built on top.
> 
> Also please come up with a sensible name for this new 'data' pointer.
> 
>      data->data->
> 
> is horribly unintuitive. It's not the same data type. 
> 
>      data->chip_info
> 
> or such makes it clear what this is about.
> 

Good, I will take care of that.

Regards,
Inochi

