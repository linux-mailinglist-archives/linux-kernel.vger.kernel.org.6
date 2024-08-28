Return-Path: <linux-kernel+bounces-305622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B321A963154
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85BA1C22D58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBC5181328;
	Wed, 28 Aug 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q+Trqz0Z"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BA1A76CE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874865; cv=none; b=GlMLaMQjYyl1xURDxMjrpO2DpRsxObQqtR0/V+D+yAAGnnVVE1Wpi0eShIh2lWvQ6+7P7KXcGYI9MTn4ih2FJPp90ED3K7YpQ8ascu8OLVVEsnbhK92SFn3h1uD620YK7DZlJlh/Pu4q/nYao/8MDOpWFM+fAakS3HjlGjpKRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874865; c=relaxed/simple;
	bh=OlVYLa1UbIb0kHWp6yk4VDup1t+yU73ExqxE/RYp2N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC42I290D+gkZ/XcMdvA9xQwHvxjiUUlLKCy/cIvtdv2Qf4atJyPzuFwAMgfrRdMCJRx5t/NhQdd4b0aQvyA8cKy9Ws0udAjKJYlsFf0le663toAL6vKwQTOvqAKYQPjEOVnZA7E9bVZECUtmVzpLNAJYPK98Lu+RVvMNBkVYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q+Trqz0Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428141be2ddso60998425e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724874861; x=1725479661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFhwlKmM3/255SEl9QHRpe7J0MogpDsMiqVpBwi3BFM=;
        b=q+Trqz0ZCLi/yHons2L8V7AsMkrMy7l2I9TJGfrJ95NcU7BPqWV0ZecFbd0QZ668ve
         ASHxW7toR7vFATxls24M/h2nfbujBgf9y2fsKe/uz+3jdJj7C+qQHzVuBXYfqFdHMmsS
         etbdD/0MkkPip8zhbWqIgQgyGsIAd/+dr3gg3vrago2nTD+waEsGALG4H4iLuCRg/RZQ
         T9NcOtszOxFVxox/f5sDt+origwrQTfVGhAvdeZK60er6Ew5JXrpg/Oewyt7BUZGDV3H
         oGkWedr0OFlz2i99EUzvfKLd0v/wXe1sdqhtdsK9QAbNobInScNpeiVZepOYndRdjOSC
         SzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874861; x=1725479661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFhwlKmM3/255SEl9QHRpe7J0MogpDsMiqVpBwi3BFM=;
        b=eUE76YiyaDUdAUZy76UWAigqZ80K8Lo2/3F/KnGQw5WNlMFzhda5W7F78Gco9JCw9z
         RkDaz2SlG7t2HQzRgMSWC6msiZQ50L6YENdFat87ktxArT59GY5UIzAE9WtxJ/Va3Kxb
         ILhPj/Avh25F2Gd8/q6KsR9nnw/a5GvWPFsu71RwCVEIRB9T+w+JQ4oBx+4lrHnF347U
         nGYZuGVg+BjxaIdHcRAxpJcrEc/4XDxafxl20k+umsW3fX5rTAf/SF9VtRXRpqUhGQ9r
         JEaurGM+/RkYCXVHpaBG/eXK2KdgQsXLrrjB8Nxt3QmundyLbwalKdjGd/xA9IpBCLPa
         A5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo9VDnhhlLnjJXxRg/ke5TdgsHLQ9OtcoiwOGy6gDQlfWdB+OBdNs5gLP7ZxxU4/308YKzOg+ZLYQcN0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/M5KxJ56PrO/fPfPHG+JOERRZFxZzV0xj6ol9IQbTbSpRyuS
	Ylr0t+wA8Jtzy6evfiZG6H74QIK0DJ/399YAUUEuY1LUu9qa+SbibCb/e8FJvps=
X-Google-Smtp-Source: AGHT+IEaPWc1tWWnBrO3K3WK07ywohVQnKOcvioEVX0K3TwyDdyiY38mfpQhks1KbPNP3iAnkvNTGw==
X-Received: by 2002:a05:600c:4585:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42bb01bfbdemr5914595e9.18.1724874860633;
        Wed, 28 Aug 2024 12:54:20 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:802f:3a47:b29:5530:28a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639d458sm30145905e9.14.2024.08.28.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:54:20 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:54:19 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
	Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v10 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <56kmiba5cr7re6rdzak5g72pprwfgvme5v4tq6rovrxrd6kefe@5mx5xxdfs7dp>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
 <20240826164346.e73vfvd4jzezlbc7@cherisher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826164346.e73vfvd4jzezlbc7@cherisher>

Hi Nishanth,

thanks for your review. I will integrate fixes for all your comments
into the next version.

On Mon, Aug 26, 2024 at 11:43:46AM GMT, Nishanth Menon wrote:
> On 08:39-20240814, Kevin Hilman wrote:
> [...]
> > diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> > index 1f1871e23f76..4ba9e520a28f 100644
> > --- a/include/linux/soc/ti/ti_sci_protocol.h
> > +++ b/include/linux/soc/ti/ti_sci_protocol.h
> > @@ -199,6 +199,47 @@ struct ti_sci_clk_ops {
> >  #define TISCI_MSG_VALUE_IO_ENABLE			1
> >  #define TISCI_MSG_VALUE_IO_DISABLE			0
> >  
> > +/* TISCI LPM wake up sources */
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81
> 
> ^^ I assume these are daisy chain sources. - will these remain OR do we
> have to consider the wake sources SoC dependent? If so, the
> sci_protocol.h will be SoC agnostic..

These are all wakeup sources from LPM for the AM62 family of SoCs, not
only daisy chain sources. The currently defined wakeup sources are
relevant for am62x/a/p but will also be reused for others where
possible. Otherwise these can be extended in the future for other wakeup
sources.

Best
Markus

> 
> 
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_CAN_IO		0x82
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_INVALID		0xFF
> > +
> > +/* TISCI LPM constraint state values */
> > +#define TISCI_MSG_CONSTRAINT_SET			1
> > +#define TISCI_MSG_CONSTRAINT_CLR			0
> > +
> 
> [...]
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

