Return-Path: <linux-kernel+bounces-533433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F245FA45A26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5677A260F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A975215189;
	Wed, 26 Feb 2025 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOt7FKBy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16A20F079
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562296; cv=none; b=kvAWH47SeuN0emt/7FiQmQq2vq+VCJgIORSnAfu5QocGLWVuT8tN8P2M7Sgh2/Ws5+SNWvVB1gbnm9aXFVH+KbXp7PxN0NGi7XppQESgSG5DHWfufQTdKG5zRNCy7E6hw2IPWxp0NGPrJ6RUi0QnvO/VY9BOD4SPUthXCJWG4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562296; c=relaxed/simple;
	bh=zSnFh/V954vG228E4AT3oDsfE5dsUPzc5tASUg1o6qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7eci1kx2ypUV47v82+UhKUAZPi6gbCrPTWMM2Xyn9Xd7Bqc4/htsAMg8411xCDai8FhnMmjEq0wkUpIEM4BARt7MH6yMPcKSeVD/MHFyNWy0TQDNZaYZvrns5VRce5WOwD22xxCMCmr8ghOZb5avtgreQoXlvDV/NPaOumGGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOt7FKBy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb75200275so1042612366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740562292; x=1741167092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7HLSyA6mw5885Yw/vt1qQCOh4p9cGkmIlOUNwXfUDY=;
        b=tOt7FKByCkKf0E0aQ3zW4McoHvqK9QDVsUSGhNSwoiRGn5tHKPumTAZBZjyTZfb5g/
         XgTFuCjg2n7MGaVHxvU7gxTimaxoTeKqqyoFWFilYhA9DCunUZnUkm4kxkVATnkjpqEl
         hd+ctLup1C2RyIvvGGsVbVdHxSnMwcYqzfSnSatynApeeNBSAfX5WKv1vAvXTmDZbBa6
         EfzRuGxYOONBjQLvsPi8Isxy5ebkLGmG94bIF3hH8WbdE9p90vXfqLpS9xWNQutEv4tF
         uJVRlk9zakZuebFx7oYRhgvHkhrTiGRaOk7wSeAj7qZ+8sZQwLWNxYK50/SPiqC+KWPT
         F0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562292; x=1741167092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7HLSyA6mw5885Yw/vt1qQCOh4p9cGkmIlOUNwXfUDY=;
        b=UHR0QQeXzUSE2peYpbKF8XjJ2d6DxzugmZ3kqx2rb6gmSmGdPr7cyvOfwt5PvJ9ozN
         uL8qphpEk0smV7qhMnMO28cdyBS+P7Y5RBozgWHpuBgKzulI3prMBYW7x60NTi89Y7op
         NZQP+mddWM0Gebim5mCqqCt6ij2pQ8cQNfeAY5lFQrdkHQD9RBVB28Tcox8g4RwvgyGi
         cYhAnjMbQpYW1iidDBGZlYvwevUAxf9M9B33/7InfQrcR0baC3m98J+Ogq1kkQYewRc8
         WXnovEj56vodLR8qmidV7hkXMXKnMwKrwda9Wg2R2ub4zm7kwLbwpL7tI22lXET3GSZh
         HgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7yUGkjXzHshrB9Bl6StfqzmbK6NuskwYFeXmV1UzeNt3BtJDxboRO8KIq/321/snPQquv3NHglLD0vrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGfXQnsHpVGdl1MPIvDFhrpnNOmUy7u3DAd5s9mVorPsxC35E
	QQLDXIBEMISHDLt46226lB5JiqW/+QlKPyL8AU+zUbZfjujEQpjVsOwR3cQaJhw=
X-Gm-Gg: ASbGnctXUJ6uHK06Gg52FUQ45TD4l0WiV4tL11BhG4L0BPGS1kjkTbjPXFsv6IpIsZU
	Dz7QVu+K634wT6cWu4N/w0pN0pnhT+bEbno70LX2DLbctqVE9HDYOGPbgqIr5a6S51Zxy1mOJlI
	FtxoJw+0jDTJfTxTVAXrSmNmGjH/rh32HWDTFwmJWtrZcLFR5/mvsSp+rGDL3Tw268bb4mmKiVh
	1vCBvp1qnVSgyorZAY1g6JuA7KH+ABhLC4Yjpg36NAYrcgHfqx3lqJVjm/4TgzsKqrWM1E4NzyO
	le1c87Nw+b5Djju0CSnCW5rVFE92Ofc=
X-Google-Smtp-Source: AGHT+IHOlwVgMQ+XjHmskbWK3r145DW/sQyZFjaekImQ2FOuF7PWx//irvpWADdBWiQERIVywycnfQ==
X-Received: by 2002:a17:906:f58d:b0:abb:6259:477e with SMTP id a640c23a62f3a-abc09e37f41mr2064332066b.55.1740562292322;
        Wed, 26 Feb 2025 01:31:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed2010f74sm288418966b.121.2025.02.26.01.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:31:31 -0800 (PST)
Date: Wed, 26 Feb 2025 12:31:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, dmitry.baryshkov@linaro.org,
	maz@kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org
Subject: Re: [RFC V6 2/2] firmware: arm_scmi: Add quirk to bypass SCP fw bug
Message-ID: <759226e1-05aa-4ca2-b2f5-7f1a84dc427f@stanley.mountain>
References: <20250226024338.3994701-1-quic_sibis@quicinc.com>
 <20250226024338.3994701-3-quic_sibis@quicinc.com>
 <Z77M5iXHQsdMptWm@hovoldconsulting.com>
 <Z77W-fKBUqAALZKJ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z77W-fKBUqAALZKJ@hovoldconsulting.com>

On Wed, Feb 26, 2025 at 09:55:21AM +0100, Johan Hovold wrote:
> On Wed, Feb 26, 2025 at 09:12:23AM +0100, Johan Hovold wrote:
> > On Wed, Feb 26, 2025 at 08:13:38AM +0530, Sibi Sankar wrote:
> 
> > >  scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
> > >  			     u8 describe_id, u32 message_id, u32 valid_size,
> > >  			     u32 domain, void __iomem **p_addr,
> > > -			     struct scmi_fc_db_info **p_db, u32 *rate_limit)
> > > +			     struct scmi_fc_db_info **p_db, u32 *rate_limit,
> > > +			     bool skip_check)
> > 
> > This does not look like it will scale.
> 
> After taking a closer look, perhaps it needs to be done along these
> lines.
> 
> But calling the parameter 'force' or similar as Dan suggested should
> make it more readable.
> 
> > 
> > >  {
> > >  	int ret;
> > >  	u32 flags;
> > > @@ -1919,7 +1920,7 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
> > >  
> > >  	/* Check if the MSG_ID supports fastchannel */
> > >  	ret = scmi_protocol_msg_check(ph, message_id, &attributes);
> > > -	if (!ret && !MSG_SUPPORTS_FASTCHANNEL(attributes))
> > > +	if (!ret && !MSG_SUPPORTS_FASTCHANNEL(attributes) && !skip_check)
> > 
> > Why can't you just make sure that the bit is set in attributes as I
> > suggested? That seems like it should allow for a minimal implementation
> > of this.
> 
> My idea here was that you could come up with some way of abstracting
> this so that you did not have to update every call site. Not sure how
> feasible that is.
> 

I'm having a hard time finding your email.

Why does the scmi_proto_helpers_ops struct even exist?  We could just
call all these functions directly.  Do we have plans to actually create
different implementations?

If we got rid of the scmi_proto_helpers_ops struct then we could just
rename scmi_common_fastchannel_init() to __scmi_common_fastchannel_init()
and create a default wrapper around it and a _forced() wrapper.

Some other potentially stupid ideas in the spirit of brainstorming are
that we could add a quirks parameter which takes a flag instead of a
bool.  Or we could add a quirks flag to the scmi_protocol_handle struct.

regards,
dan carpenter


