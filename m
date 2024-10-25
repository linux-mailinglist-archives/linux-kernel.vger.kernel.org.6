Return-Path: <linux-kernel+bounces-381502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A29B0022
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3DD1F20596
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1C1F818C;
	Fri, 25 Oct 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZ+TIgAT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC11F76D7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852175; cv=none; b=sx02+9cmtjEXDvzwinM9/lSmChWJWerg0r8sdrbJBjrhLpxDYp6GhBYjPjWQ8csyEFcvWEpkv2wwD9VIztxSSCIimvYrd9eTnWhQ+gA14G1HWeGgOwOpkY0+i37bgQ3iBjjGWpV3DP96XxVGCJsMPytRqC0tOXQsHcgjR9AhUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852175; c=relaxed/simple;
	bh=JrhgYyCLZPRkzVtp6DPiijk9umn+b9KZQOEJa44TuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqwHljYUrGfYhg+mfE517Rwnnd51kZY1bZKG4+au+qOkVf942nP2lrgN6/9BIOjIUt+aiMl5QBNnJgbQ3Ue5ZLm5j2TcvbXgosgeNl1nV4LeHqkPVciZVBCNyY2ndCaN0iCLqnAuG2ly4aWmvDDZUtgX15Lz7lJ+rC7FbUcrxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZ+TIgAT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f7606199so2361767e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729852171; x=1730456971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34AFLX+8EUxNZJyoQVRqIR0gBUDLnEgGQ40+m4GQ6vk=;
        b=xZ+TIgATcpuW+Q511gtpS0Vi97laUIoQOBFWQeAcMFaW9MWmD4l5PA5NMgZX4xSRB7
         q1teHHasmzVjm8u8BnyVnrqPgdZ5yJylIUI+L55sAHLw82riItdDXNSjcVkck0Qo7ty2
         A2GZr6A3vvzjg69ZzJO36U+HiIfmDrKsOQpSrX5o9MhKq2YY6l8q0uN1/ixybryVnF89
         MYzoRWs18JCVdceu9h50zYa4vdc3dJ4/paI1T2ZLPllOc4Y4TF/XaISS8992QQ0zEPJz
         89k2WL1UodykKMel3d7/LfENjE57Unzdn9LMjR5Urtf8fsbCYsVRoGmLEMezo/c1dvV2
         5hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729852171; x=1730456971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34AFLX+8EUxNZJyoQVRqIR0gBUDLnEgGQ40+m4GQ6vk=;
        b=ILKXIsDiIQPdCUW17SQJat8r6MBRBVemMfbGd+ELajXUqJckv5IURPhsytPn2ni8Xa
         aAaBr3mL0CQwIYKFhU/mwuSS36iVcKU3K678FHJF/UkKWu7jcZqWe/YDFRfc2Gmk3u9F
         5vnHiTeph5QoF5GUoXKdIOiN6x42CUC6aypJNWAEnvzxI4wWfsvhSI+YyagY7he5kYjp
         VXNABl6VJlGYBTihKA3HKpqxPXciW6c8FTcOf5JEH7uN+3ACoDCyFY18J5snfh0CKQCz
         MMyyaJ1x+UjFhDZxlOfRF+pHY95wqE1QGBTPzSPmzTmJRstksJLNFnj9bzyOCX3UyYJI
         kUkg==
X-Forwarded-Encrypted: i=1; AJvYcCW7NmJZszhq6UVt1p59+kN5k8xSOhGTHEBEEBx9E9Wit/MX8gwQQ52BcZlqKzUtT8QMfCEqr7rGZWLkiX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ex+bo9i7DcEh/acedxV8QwK5JR/ptUGlFQm4hqQgkOeGQ8Xf
	rvGGJdmk+bnchVK6WvYgKM9u8oXmtrI+y2AWWQImWrin0w9gMwQB7yp2nOgzvwk=
X-Google-Smtp-Source: AGHT+IHiOOHVRpO8y8qGLFlmzCh/E8Yp3SeJuucuj4wXFVOr7ySKWOU7EQg0Jo4Lql2r7Oi1J5Wv8g==
X-Received: by 2002:a05:6512:e89:b0:539:da76:4832 with SMTP id 2adb3069b0e04-53b1a36c4b4mr5705398e87.37.1729852171435;
        Fri, 25 Oct 2024 03:29:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1f4315sm127924e87.300.2024.10.25.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:29:30 -0700 (PDT)
Date: Fri, 25 Oct 2024 13:29:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: mux: Add support for the TUSB1046
 crosspoint switch
Message-ID: <5cpa5e4mqq55gdkom3ug6ieocmbi2qaguwiaype6jijgzpuoij@ttukpn6mfsab>
References: <20241024-tusb1046-v2-0-d031b1a43e6d@bootlin.com>
 <20241024-tusb1046-v2-2-d031b1a43e6d@bootlin.com>
 <bgqmq4kehejgud2eymcwusbu6ks4jnaeasr6ad735czxxazyht@ppzrbmce5mog>
 <1945710.vURJNgTSzn@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1945710.vURJNgTSzn@fw-rgant>

On Fri, Oct 25, 2024 at 09:09:11AM +0200, Romain Gantois wrote:
> Hello Dmitry,
> 
> On vendredi 25 octobre 2024 08:39:54 UTC+2 Dmitry Baryshkov wrote:
> > On Thu, Oct 24, 2024 at 10:54:17AM +0200, Romain Gantois wrote:
> ...
> > > +
> > > +static int tusb1046_mux_set(struct typec_mux_dev *mux,
> > > +			    struct typec_mux_state *state)
> > > +{
> > > +	struct tusb1046_priv *priv = typec_mux_get_drvdata(mux);
> > > +	struct i2c_client *client = priv->client;
> > > +	struct device *dev = &client->dev;
> > > +	int mode, val, ret = 0;
> > > +
> > > +	if (state->mode >= TYPEC_STATE_MODAL &&
> > > +	    state->alt->svid != USB_TYPEC_DP_SID)
> > > +		return -EINVAL;
> > > +
> > > +	dev_dbg(dev, "mux mode requested: %lu\n", state->mode);
> > > +
> > > +	mutex_lock(&priv->general_reg_lock);
> > > +
> > > +	val = i2c_smbus_read_byte_data(client, TUSB1046_REG_GENERAL);
> > > +	if (val < 0) {
> > > +		dev_err(dev, "failed to read ctlsel status, err %d\n", val);
> > > +		ret = val;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	switch (state->mode) {
> > > +	case TYPEC_STATE_USB:
> > > +		mode = TUSB1046_CTLSEL_USB3;
> > > +		break;
> > 
> > > +	case TYPEC_DP_STATE_C:
> > These are only valid if you have checked that altmode SVID is a
> > DisplayPort SVID.
> 
> I did check it near the beginning of the function didn't I?
> 
> > > +	if (state->mode >= TYPEC_STATE_MODAL &&
> > > +	    state->alt->svid != USB_TYPEC_DP_SID)
> > > +		return -EINVAL;
> 
> Or is there something I'm missing?

Indeed, excuse me. I missed it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Thanks for the review,
> 
> -- 
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> 
> 

-- 
With best wishes
Dmitry

