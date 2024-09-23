Return-Path: <linux-kernel+bounces-336037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0697EE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7271C210FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EDA194C8B;
	Mon, 23 Sep 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ocd5RcnG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C228F6E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106064; cv=none; b=FQijeN8DoEbf+1HReQFoVTcNLvNEcERFiUFhJN4YBRKjTph9GuauIPQGLf+t9nBcxOG8bcAEsGP5Sc5Bs+8gWVmmWuBnYYumY85SLgYqdnXix6WiMszJCpQNnIjCuOUc0KMwxozDQF0VKDX/zx3H2x28FQdy5zbwN5VH7RFxzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106064; c=relaxed/simple;
	bh=iFXJARjuQ6GuRR2ReXhrm38YPabUlZm4bgLRdENxQxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWFPdHn4EdIHvGtcgsyHnmR4AlhufhLb7L5WrXMl25zLcV6v59z8fPmeV1vfad8qEVs3lh4k711bZLpGvWRyR5/4OGKWQbWiDTcFt7X09KovY/BOwblsVXpjv+VqPmXBlYjArlVIH5Dwf1fVyZjVFqGZQgJAvvffTc2+svyvb/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ocd5RcnG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so38607345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727106060; x=1727710860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hEMgT+V6RKCGsVH4avWyT+AgGGovhzaXz1iZrgskY0=;
        b=Ocd5RcnGAezLzJ6Cz230QRZCoXGZXQrcnjaF9J5qnmLUayNfSAz/WmDox4yxTmRwVJ
         PHgFou5xiy/KMKINg6ARKyUxPG0ZdfCH1DiIfFE0wUYRas/A4NfFeqL/I3rD+O6YkbHv
         kJqfD6pcv1Yh7Rqzf4/19Jw148qwVt+G4V8YwV1M2e6Rr59MABLeg3s1IynWs61W7JL3
         M3voNr5wwQm3fpad2ioHBZnthtrOr0apYEyJBRaTGvbKsG+LeIra0Ih4PU/RDPd46TYn
         EbYQsTZ4Z1q11M9JZBUADEhwB9wI8K+oQ0Z/pg89NFH75UmFCC1xEoDI3ZsiVKWjhSVL
         nBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106060; x=1727710860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hEMgT+V6RKCGsVH4avWyT+AgGGovhzaXz1iZrgskY0=;
        b=NhY4tJoNOgHRjrH7aohU2GxEncYrcAEp1CYhRJwNitScvE3AtnwqUdwlX3orz5xhFk
         BRIsAxbySCZkiThz9pER45kddXhXsJgwYbPoWrdFW+dUFLPao44gzPBrPU7BLXxyXvUc
         f9g1hk1/JqpKwjVN32T8e0udr+vnuYeTNY1oHFSWg9/1VpCn0dCt3lbyuTWZkZ+v9531
         O22L/vU0eKXxlPjB2lPjuJEhvwUx2J9Ryhq6TTkhN9QAHWTPCs0cmk8EtJRqjZYiSKlW
         uxYsphlaRkNpSdCCDXzeMYfSxRNLmd0qcYC6Qfs/MHdBTrRo1SQHXxN3RQ+gW3QsjqJB
         qdmA==
X-Forwarded-Encrypted: i=1; AJvYcCXeiGPtV+tX8PFmkDL8jO6lRJyUcJh/6Jm9M8oQd/VXqxVi4CYmtD/rBJ8qw0REgFHm0B0k/7Py7Cc4DFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw380yfjSuv+bzKTgddOHLxl8ekrrHYLBMpnZTa3RTHxArvZYLg
	ZXdzkZNDiqqjATeWVEvrgi+ynjJ+3OJaJoAbxPeWtgiMNkggfYn2waZJQvPsCIU=
X-Google-Smtp-Source: AGHT+IHsWmcr4eW+BaYfL8CYsAvdo+Szk8fAimdTZxi5lZN//5fbIfWXxSrhfFtn/GBv/D99t5gVmA==
X-Received: by 2002:a05:600c:154b:b0:42c:cd88:d0f7 with SMTP id 5b1f17b1804b1-42e7abedd22mr85419165e9.10.1727106060023;
        Mon, 23 Sep 2024 08:41:00 -0700 (PDT)
Received: from linaro.org ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3790802b2d7sm12741225f8f.0.2024.09.23.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:40:59 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:40:57 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <ZvGMCTPqBR0VuHd3@linaro.org>
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>
 <Zta6cBq881Ju7r7H@hovoldconsulting.com>
 <Zthet0QqChgGWJAe@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zthet0QqChgGWJAe@hovoldconsulting.com>

On 24-09-04 15:20:55, Johan Hovold wrote:
> On Tue, Sep 03, 2024 at 09:27:45AM +0200, Johan Hovold wrote:
> > On Thu, Aug 29, 2024 at 09:44:26PM +0300, Abel Vesa wrote:
> > > The Parade PS8830 is a Type-C muti-protocol retimer controlled over I2C.
> > > It provides both altmode and orientation handling.
> > > 
> > > Add a driver with support for the following modes:
> > >  - DP 4lanes
> > >  - USB3
> > >  - DP 2lanes + USB3
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> > > +	retimer->supplies[0].supply = "vdd33";
> > > +	retimer->supplies[1].supply = "vdd18";
> > > +	retimer->supplies[2].supply = "vdd15";
> > 
> > vdd115?
> > 
> > > +	retimer->supplies[3].supply = "vcc";
> 
> I took a look at the schematics and it seems like all but one of the
> above supply names are wrong and that some are missing. "vcc" also does
> not exist in either the binding or dt patches you sent separately.
> 
> From what I can tell the supplies are:
> 
> 	vdd		1.15 V
> 	vdd33		3.3 V
> 	vdd33_cap	3.3 V
> 	vddat		1.15 V
> 	vddar		1.15 V
> 	vddio		1.8 V

The schematics seem to suggest that vdd, vddat and vddar are all
supplied by the 1.15V supply. As for the vdd33 and vdd33_cap, their
seem to be supplied by the 3.3V supply.

> 
> Also, have you checked that there are no ordering constraints between
> the supplies?

The documentation seems to suggest that there are some timing as well as
ordering contrains, yes. I can't tell for sure if that is really needed
or not.

Thanks for reviewing.

> 
> Johan
> 

Abel

