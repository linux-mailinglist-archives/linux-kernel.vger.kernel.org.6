Return-Path: <linux-kernel+bounces-234002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8091C0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635BF1C21F35
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650B1BF329;
	Fri, 28 Jun 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BZJNQnO0"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AE155747;
	Fri, 28 Jun 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584189; cv=none; b=BGopKwHSBDWLfMpDgrE+VYx4JBN5yMIHO34yGGKUt/3X57mlEFPndOSshly9LeynLDl1ROZ4c6ErmECMVyZVajNsK/TzfdDogr2Cn5BlZuROvzziYleeEokE5MuMnTKkxHSmiP5d+q0itoc4SAAEpkt+Xmk9PRW81xibO0u7H/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584189; c=relaxed/simple;
	bh=MDismG/dTlveonUJX95mSDTM3qVtjeX9xPGjEEAaTWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvm7cbovmShjumf7EKpufxp64XynpmVxnBOk0O3kwD9ZOjX7Jx4NX57nfiQXkI3Ekf6XSgBU+hHTCQltLJStFFuXiLTZPp7NYK7X/WeMIiNyVonBV1RBp7GK8dHGYloNHM4Vn3L/pB/dI2X+RrGR7oT4jUDnNNBBTqSGIfjvKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BZJNQnO0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1E0920007;
	Fri, 28 Jun 2024 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719584179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnJ6ux2mqzbGIMAIiaH2qnutd8jMPLZABsQY/zaXnog=;
	b=BZJNQnO0QaK6H17/09imC21hMX6bX04voc6jt6FWB1Sq/YDtGgX5NdrXjdRDcd3VhwEmT0
	IiHbRD5d/eFQ9MfeQKovP08fBIoaYjLtEfJJbqu/CarEZLKjoIU3UIWYtLlISNv0MW8EzB
	A+EQqFT51jS/v2rzlCDOXpAHcPpiS8gJEGjhgyJx4lZhzydvRixR8IcSGhQD8yaCy+aE0u
	kVLT9RMRydAwHHHPoUZLuhxaHWXsH8CkfCy4lGPUWZpncXrvDFpFWxPyBya9QiI8ZKuKHR
	rWn7hruHk2QmF9OeiaoujKJWpe0FS8wVRn7fzcg1C0ZQoxnxDRKRxR/xmsd97Q==
Date: Fri, 28 Jun 2024 16:16:17 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Saravana Kannan <saravanak@google.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 1/2] of: property: add of_property_for_each_u64
Message-ID: <20240628161617.6bc9ca3c@booty>
In-Reply-To: <AM6PR04MB5941D30C26F2CB818FEC082C88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
	<20240621-clk-u64-v1-1-d28a611b2621@nxp.com>
	<20240627214355.GA601888-robh@kernel.org>
	<AM6PR04MB59416E3C8FFC904450F3B02D88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
	<AM6PR04MB5941D30C26F2CB818FEC082C88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Peng,

On Fri, 28 Jun 2024 13:10:34 +0000
Peng Fan <peng.fan@nxp.com> wrote:

> > Subject: RE: [PATCH 1/2] of: property: add of_property_for_each_u64
> >   
> > > Subject: Re: [PATCH 1/2] of: property: add of_property_for_each_u64
> > >
> > > +Luca
> > >
> > > On Fri, Jun 21, 2024 at 08:36:39PM +0800, Peng Fan (OSS) wrote:  
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Preparing for assigned-clock-rates-u64 support, add function
> > > > of_property_for_each_u64 to iterate each u64 value
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/of/property.c | 23 +++++++++++++++++++++++
> > > >  include/linux/of.h    | 24 ++++++++++++++++++++++++
> > > >  2 files changed, 47 insertions(+)
> > > >
> > > > diff --git a/drivers/of/property.c b/drivers/of/property.c index
> > > > 164d77cb9445..b89c3ab01d44 100644
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct  
> > > property  
> > > > *prop, const __be32 *cur,  }  
> > > EXPORT_SYMBOL_GPL(of_prop_next_u32);  
> > > >
> > > > +const __be32 *of_prop_next_u64(struct property *prop, const  
> > > __be32 *cur,  
> > > > +			       u64 *pu)  
> > >
> > > struct property can be const  
> > 
> > Fix in v2. BTW, I am thinking something as below:
> > 
> > const __be64 *of_prop_next_u64(const struct property *prop, const
> > __be64 *cur,
> >                                u64 *pu)
> > {
> >         const void *curv = cur;
> > 
> >         if (!prop)
> >                 return NULL;
> > 
> >         if (!cur) {
> >                 curv = prop->value;
> >                 goto out_val;
> >         }
> > 
> >         curv += sizeof(*cur);
> >         if (curv >= prop->value + prop->length)
> >                 return NULL;
> > 
> > out_val:
> >         *pu = be64_to_cpup(curv);
> >         return curv;
> > }
> > EXPORT_SYMBOL_GPL(of_prop_next_u64);
> >   
> > >  
> > > > +{
> > > > +	const void *curv = cur;
> > > > +
> > > > +	if (!prop)
> > > > +		return NULL;
> > > > +
> > > > +	if (!cur) {
> > > > +		curv = prop->value;
> > > > +		goto out_val;
> > > > +	}
> > > > +
> > > > +	curv += sizeof(*cur) * 2;
> > > > +	if (curv >= prop->value + prop->length)
> > > > +		return NULL;
> > > > +
> > > > +out_val:
> > > > +	*pu = of_read_number(curv, 2);
> > > > +	return curv;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(of_prop_next_u64);
> > > > +
> > > >  const char *of_prop_next_string(struct property *prop, const char
> > > > *cur)  {
> > > >  	const void *curv = cur;
> > > > diff --git a/include/linux/of.h b/include/linux/of.h index
> > > > 13cf7a43b473..464eca6a4636 100644
> > > > --- a/include/linux/of.h
> > > > +++ b/include/linux/of.h
> > > > @@ -439,6 +439,18 @@ extern int of_detach_node(struct  
> > > device_node *);  
> > > >   */
> > > >  const __be32 *of_prop_next_u32(struct property *prop, const  
> > > __be32 *cur,  
> > > >  			       u32 *pu);
> > > > +
> > > > +/*
> > > > + * struct property *prop;
> > > > + * const __be32 *p;
> > > > + * u64 u;
> > > > + *
> > > > + * of_property_for_each_u64(np, "propname", prop, p, u)
> > > > + *         printk("U64 value: %llx\n", u);
> > > > + */
> > > > +const __be32 *of_prop_next_u64(struct property *prop, const  
> > > __be32 *cur,  
> > > > +			       u64 *pu);
> > > > +
> > > >  /*
> > > >   * struct property *prop;
> > > >   * const char *s;
> > > > @@ -834,6 +846,12 @@ static inline const __be32  
> > > *of_prop_next_u32(struct property *prop,  
> > > >  	return NULL;
> > > >  }
> > > >
> > > > +static inline const __be32 *of_prop_next_u64(struct property  
> > *prop,  
> > > > +		const __be32 *cur, u64 *pu)
> > > > +{
> > > > +	return NULL;
> > > > +}
> > > > +
> > > >  static inline const char *of_prop_next_string(struct property *prop,
> > > >  		const char *cur)
> > > >  {
> > > > @@ -1437,6 +1455,12 @@ static inline int  
> > > of_property_read_s32(const struct device_node *np,  
> > > >  		p;						\
> > > >  		p = of_prop_next_u32(prop, p, &u))
> > > >
> > > > +#define of_property_for_each_u64(np, propname, prop, p, u)	\
> > > > +	for (prop = of_find_property(np, propname, NULL),	\
> > > > +		p = of_prop_next_u64(prop, NULL, &u);		\
> > > > +		p;						\
> > > > +		p = of_prop_next_u64(prop, p, &u))  
> > >
> > > I think we want to define this differently to avoid exposing struct
> > > property and the property data directly. Like this:
> > >
> > > #define of_property_for_each_u64(np, propname, u) \
> > >   for (struct property *_prop = of_find_property(np, propname, NULL),
> > >          const __be32 *_p = of_prop_next_u64(_prop, NULL, &u);
> > >          _p;
> > >          _p = of_prop_next_u64(_prop, _p, &u))  
> 
> This will trigger a compilation error, because C not allow
> declare two variables with different types as for loop expression 1.
> Need to think about other methods.

I have a working draft here where I solved it somehow, let me just find
the proper branch and send it. Perhaps next week, but I'm striving to do
that by Mon-Tue.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

