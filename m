Return-Path: <linux-kernel+bounces-310456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FDC967D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08E41F2191D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF536182C5;
	Mon,  2 Sep 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxSDHSyO"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCF8F6C;
	Mon,  2 Sep 2024 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240203; cv=none; b=LYj13obtpVytFcBSejx3kgT8BE3MaNEt2rV75sky/bYDhoG5nfHzDR+oneu8fis1aIlAQM2hxrKCQURPj+eSAkuKle6/RRPYxw0sMAlOsEDaa19Wct/3cXEsOeHNOyi3YQkgze0yUSj7nh7ffZ69K+SOM4dKoSaSSfe4Y0yt4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240203; c=relaxed/simple;
	bh=rcY86Xh8hmdWc/GwfHJUqqLAtLfP8/R+o7Jjb71rsCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uld3dL40a4fB/o615I7pOk7Jfp2dmgt5TE6CP5HMtVJgoeqItA/lk+wKanieFEfYuZF8YW0wY/ZLtwxph2E8ymFKOH2eWS7+A2JUR7I7moraHRJ0dzXg1VKd78q2A/ArLsz4U/sZCguLUcCJ7OUm3BanArLF7BkVVWoLdHI8C1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxSDHSyO; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3df07fe03acso2347062b6e.3;
        Sun, 01 Sep 2024 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725240200; x=1725845000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/xe9QZ+gYCeSq3BZh2r9ujizGNk/decUAVyH1Yg/YA=;
        b=LxSDHSyO5pc0OffgDnnK+B2TJglcpQNi/N+q09Xjctle93q4GMG/Jita6yMFoNIPMT
         TIh688VvQZ0+PnhPbno3IubG9/RkzneU3GHgdj9arA0KZPuGADV98Q1E4H8kDKFzF/ca
         4WB/4r/XLnjpUXRv/LOqV/L3ZIl0CidQHAd9RV3lpwrSxvWvx9hTRRoGZDDrUEnaLius
         nJlLuI9qG/VASr7WCQ/55qWIqV4zzk/Un4KMV6O4in/7bcbSnY572SD1/+klEXC1MVc2
         ptF9pbO9eIzRM/BNmkPygjYVAzOvtWr4EKYXK3ZisEEdFt2M9Mh2azfNOdPuAhMMMYO6
         W6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725240200; x=1725845000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/xe9QZ+gYCeSq3BZh2r9ujizGNk/decUAVyH1Yg/YA=;
        b=xPqoa7Ev7mZZvVsOJxjAMRDPJIer8TVOe+h9L8bx/FA7u2S7RCUKR+JqMSmcA7VrQT
         D9GTz/Q0J4wbhlZYnJcv6a0y/yg8Ljt5ICCjSM3zoi6DMv0SoPwr+er6ajFjsMZEBnGS
         wjgHRNRAfnESVXoDXerAX7BFiX5bhXWs4ii3A4wEjQoVvwBxF7UH+7/s9xX9F1UyPnAL
         OYY4BK7W+vfgG8k+5GOj54/NL+Ya9/AAdscYmLJgBcRYKR1HK9jB75yEPt8VSwLs5zvc
         ANEZSYMcd3bGvbjjwYidgYqXAm0themEpul/3W+xdccyf7j8BgoqNAcTKR4G7KIK+7OV
         Nz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWpY8tqfjEuNKTtNx6A9P+Rdq7nwVIqSAQPWgKjxLSqV6sDaFKzh45ux0z4mMkEDn9MVODZxTUxh+Uvjmz@vger.kernel.org, AJvYcCXb4UFtxjufyt9B8suy4O8KG05IuzL9XoGayvArygHIGyFHIbuEPOGQrfjNtuTp60qce4VkAr9C47S9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JH28JSKS0iMYiyBsxBctZ+Y6hSA3RxxQpDLC32RMM1OTS2pQ
	uSv1R35vH/DB2Bwd8a6Hx3cybivwWaeAPMoB+jFXu90GhtumJ+pc
X-Google-Smtp-Source: AGHT+IH6KvwfF320D8xw/jut+hpZ9VMsVm9fprd9ay7D3ASB+9t79VFPwlYZxN0fUjpgiNxSLJSNJg==
X-Received: by 2002:a05:6870:9e98:b0:254:affe:5a05 with SMTP id 586e51a60fabf-277d044346cmr6761684fac.21.1725240200505;
        Sun, 01 Sep 2024 18:23:20 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d9716sm6038692b3a.174.2024.09.01.18.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 18:23:19 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:23:15 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Cc: Yu-Chun Lin <eleanor15x@gmail.com>, thierry.reding@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: devicetree: Fix typo in lvds.yaml
Message-ID: <ZtUTg0C81FwChfDh@visitorckw-System-Product-Name>
References: <20240901133046.962263-1-eleanor15x@gmail.com>
 <20240901151745.GB6713@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901151745.GB6713@pendragon.ideasonboard.com>

On Sun, Sep 01, 2024 at 06:17:45PM +0300, Laurent Pinchart wrote:
> Hi Yu-Chun,
> 
> Thank you for the patch.
> 
> On Sun, Sep 01, 2024 at 09:30:46PM +0800, Yu-Chun Lin wrote:
> > Corrected the spelling in the description of LVDS Display Common
> > Properties.
> > 
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
LGTM. Feel free to add:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> > ---
> >  Documentation/devicetree/bindings/display/lvds.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/lvds.yaml b/Documentation/devicetree/bindings/display/lvds.yaml
> > index 224db4932011..b74efbea3be2 100644
> > --- a/Documentation/devicetree/bindings/display/lvds.yaml
> > +++ b/Documentation/devicetree/bindings/display/lvds.yaml
> > @@ -16,7 +16,7 @@ maintainers:
> >  description:
> >    This binding extends the data mapping defined in lvds-data-mapping.yaml.
> >    It supports reversing the bit order on the formats defined there in order
> > -  to accomodate for even more specialized data formats, since a variety of
> > +  to accommodate for even more specialized data formats, since a variety of
> >    data formats and layouts is used to drive LVDS displays.
> >  
> >  properties:
> 
> -- 
> Regards,
> 
> Laurent Pinchart

