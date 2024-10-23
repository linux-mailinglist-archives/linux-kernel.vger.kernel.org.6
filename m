Return-Path: <linux-kernel+bounces-377770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988449AC67A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C773F1C21608
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D1174EFC;
	Wed, 23 Oct 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+2tWqv/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27B43AB9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675756; cv=none; b=MWNTckIyfs7iy4itqGbqqW77k5tdnJPhLGJfCFH1DYDsUbeUXI0PD5UXsHSExzE0SOk9OEznW2oQUMcZkXPIZj9lc2JCD/elrg6j5+gTNfyTbffGt2rAL+RGqEJn5HfR/mq9Tba31tpsK/0+sNQZiVOT0frcG5AWVXoQOzR4YwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675756; c=relaxed/simple;
	bh=RZf12H2o/sY73e0RDlhxosyDuYApkbS+ggXv/wNI3O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5STsLQZlHu1psyGJcOL2oZbHzu8UIvE5Cs2kQUs0QNjIgOg/FcSgYvlkQtM9jFCd0V/55ISQqkhjo/99Pi7R13fW0237EG2i97QLnAuxzP3ypRAzKC9n+2DyPTTDpk2WTTxGLd+LXZFzX5A730Sb+9PDYIbhvFmxdNao9+ZsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+2tWqv/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431616c23b5so4667155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729675753; x=1730280553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txXwR3se570zRf+hEWGqzG78Ye7IOjvfOQHVjV1bt/g=;
        b=p+2tWqv/eAGq+l+Wi3dQ7XNOY1XX74Qir7Qna2rbU0UXu/BQTV1uccntICRYj8Te2T
         hB1OwbgRVMiux+dYBo1K3kip3Aylmh9Mms2OWdmOWYlxafLy1lGVaGREgv27QLGNrD06
         HTeSE9L++7OmFfDwn/jto+1iO3eHvwV2pxc79wpTgsuQG+bFPk7XJ4COgaUb9InKS3xY
         HiszbhkU+aunq4uA8cfjsm8nZDkwQwhCGOsiIjYqmL9vCM0ThliQ8cTe6BgkoFoxUxoa
         XKP3mVklrdET9fb9q8itAaUyZWXuOABOHCTnM0wrPrcvAhVz2jRRA84DuHcsex1xWpo0
         7EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675753; x=1730280553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txXwR3se570zRf+hEWGqzG78Ye7IOjvfOQHVjV1bt/g=;
        b=HkYKhYhpXu9ph9dkQxTjxVaB0sy2dKwaEa9VtrJyjpeF1Jr4/UKqzYPgPfQj27S04O
         9j29pXe4ur5RpDFkrzqOCAybi9KvCt2Fp8m62vOrM00fQLVCh3D6AaYjRsEkKcLru4Ei
         4oQGdCvRz2zNt8QQcn+x9O6TG2SQkF3yjt/pXEdolXZbu0T+mWl/oKZC/M3fJFWRckSg
         dnLXsPex39/5fol7JNqle+6nmxAQf04ooFVhQpZGGQjwThsXFYN5D1Z7/df4tPUPLLyI
         IkIdX92meEG0zsMiho0A7OeJ5YJkCbSwAw7L/X6SZgOweCzn2LC1uACFSCLSbNY1RoC2
         bVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKH6pKDeAOPkiPRQW9AHhLChd1mrXF9aGv3Vs4WziRZx626y/h8yPwXPYitzDjGHaiOzmNY5rcWknXUz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSCCggGheQHi62yrxZEMCRTDRVK2YKn22l0NtwMI4/KFlWjpz
	azrrSVE/+z/Plao+n8mEmeoZro+SbeJ2OjxXQGWfWHtVyf9I94aQYKSZ4zcfkfM=
X-Google-Smtp-Source: AGHT+IEhdM6tcEM23cb4YWRGrqt3E1XVDsYAXGiHBS/B+oXGVOdN+Y4Kvk8JCgnDW1hf3IvPVf1arg==
X-Received: by 2002:a05:600c:1d96:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-4318445a03emr11567045e9.11.1729675753310;
        Wed, 23 Oct 2024 02:29:13 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bdb76esm10955965e9.14.2024.10.23.02.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:29:12 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:29:11 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: ucsi: Set orientation as none when
 connector is unplugged
Message-ID: <ZxjB59urzPAxKLUQ@linaro.org>
References: <20241017-usb-typec-ucsi-glink-add-orientation-none-v1-1-0fdc7e49a7e7@linaro.org>
 <ZxfTzrEpCG7NITq4@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxfTzrEpCG7NITq4@hovoldconsulting.com>

On 24-10-22 18:33:18, Johan Hovold wrote:
> On Thu, Oct 17, 2024 at 07:01:01PM +0300, Abel Vesa wrote:
> > Currently, the ucsi glink client is only reporting orientation normal or
> > reversed, based on the level of the gpio. On unplug, it defaults to
> > orientation normal instead of none. This confuses some of the orientation
> > switches drivers as they might rely on orientation none in order to
> > configure the HW in some sort of safe mode.
> 
> Can you be more specific here (e.g. so that reviewers and backporter can
> determine whether this is a fix that should be backported to stable)?

I didn't add a fixes tag here on purpose as I see this as an
improvement. Nothing wrong with just setting the orientation to normal
when cable is unplugged. But makes more sense to set it to none.

> 
> Which driver is confused? How does this manifest itself?
> 
> Is this an issue today? Or something you need for future work, etc?

None of the upstream orientation switches drivers currently need
the orientation as none on unplug.

The new Parade PS8830 driver that is on the list for review is indeed helped by
this changed. But we can circumvent it there as well, if necessary.

My reason for this change was basically like: Since we can use the
connector status flags to figure out if the cable is plugged, we can
take this a step further and propagate orientation none on unplug.

Therefore, improvement rather than fix.

Anyway, if you still think that there should be a Fixes tag, please let
me know and I'll add it.

> 
> > So propagate the orientation
> > none instead when the connector status flags says cable is disconnected.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/usb/typec/ucsi/ucsi_glink.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> > index 3e4d88ab338e50d4265df15fc960907c36675282..b3bc02e4b0427a894c5b5df470af47433145243e 100644
> > --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> > +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> > @@ -185,6 +185,11 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
> >  	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
> >  	int orientation;
> >  
> > +	if (!(con->status.flags & UCSI_CONSTAT_CONNECTED)) {
> > +		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
> > +		return;
> > +	}
> > +
> >  	if (con->num >= PMIC_GLINK_MAX_PORTS ||
> >  	    !ucsi->port_orientation[con->num - 1])
> >  		return;
> 
> Johan

