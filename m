Return-Path: <linux-kernel+bounces-306543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6F96404A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D77FB253DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1502A189F58;
	Thu, 29 Aug 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x91onVNV"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70CD18C93E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924193; cv=none; b=mYdoWzVeR6LFYNeVuab26YhPbCh6Ud06Nl0ZZrRiwFj0CVgKrBp/gFzUxjd6DSEFing5tIx0s33Fapoe+ba9y2q5YTMTvtEqN64eWf+hAx+zlxbK7XxidGxsE2DlcqLh/Q7HIHeb7IR2r9OXyLyyTs5anYIs/EaGAshJlFJy45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924193; c=relaxed/simple;
	bh=OdebDuPQOqyUSdwo9L6QAINi3eIPyAO8PkAC9Mve2c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4dYeO8WOGkU8wbtHASoh0BZwrn7PK5A5H2TjTep9pwz5LzAi7/Upz8s74dsH5xx3v+sUJlJNHSTypMsRCFyLg46YddICJfTxdT9tSpMdgKRdIlO+5DkwJ7zAd0SmL6YDzuAMSxW5+s319rHr8YCN3324CPH75FKTQ+fHOjbgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x91onVNV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so3839565e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724924190; x=1725528990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJlINwL4Wf3pK+iotBJLCyDenaMFyH3DfD8vme55AUY=;
        b=x91onVNVGuzwg9874Z98NtXeDfeV7vlB4H4kxs1NvgYfv/PtiLZrdvS6m0jw8oLKlQ
         TGQdl/vGcESvry7zNR7NDTcmoS8gV8L7VXPG1n9574EVPZLz9Zklm4NHcSGTfuyhxKh7
         HJI98yMXkGVQ/2g/yu57TH+zOikNgxIE6hgdE8P2i5l9ujn0ejhkUcdeIh6i689F75Fh
         s/6zTerVzu1br71qotrLvJLkNTWhL6l0hLkJK1sW2IncF5+Trj9M7dWMSz4BHwLfIFlG
         KZizNbA8ESZTm+QpJ0YBsoe2QrlBACrnMo7nNJz3ERsG4uQKd2airZOooJlDpTk0KnBl
         Gy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924190; x=1725528990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJlINwL4Wf3pK+iotBJLCyDenaMFyH3DfD8vme55AUY=;
        b=D8rKll735Agq4W/sUmVKlDEp16Fwuxl5d4RtzX9IcuW1q0448fJl2zFrO5apLauXm4
         /T/lwFDju5xBJUN78qIS+Fucbr6IxoBhU8CRyOHHFcxaTHI2Wn2z0vg2RVfvtKvXmJq4
         8iW/xEehL711FG7JpzeXr/baDQWuNHb/26/iNgahI3WrUmhihxWwRPzKrHiO8w4C/Xpq
         gja9V+xEOTTGGxWEKeA7XLNnGdS3I2FHMELk4P0Eacj91zuG56nu6rt/1AdFBGydVZV0
         BP6Girq+kdeH6cBJsOI06jfYKwCAQJFRGcXQNdpzsTytXO9u73ojmIPhRSrQPpXAG3RY
         7/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXr5CAVAojpCwsLH9r/6SeTV1G43BEWhaqlUZ4u4W9dOFwtFABnw6ZouwklzopvjD0tHJSxU65feJQX4YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qiunJoyTkgXhYemTB2Df4L+GBsgRR91ZGTHgh2uZHQlNq5mq
	Qv8wUitiQ5SHCsqtBxycnAN2u5OebAUZtygJav0v5h0Ax7O4NBP0pqbUAgnX54Y=
X-Google-Smtp-Source: AGHT+IE7qHvZQxiSgfO84hLqZwHWJv06PT+glwCYHz0VtH1NqDTym+WIBEgpem7s5zZ6uZ6KJAhe2Q==
X-Received: by 2002:a05:600c:5110:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-42bb0263389mr16217335e9.22.1724924190011;
        Thu, 29 Aug 2024 02:36:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d300csm20901905e9.15.2024.08.29.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:36:29 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:36:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Manisha Singh <masingh.linux@gmail.com>,
	florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
Message-ID: <daecc634-4faf-4dcb-b03b-f57f24673a88@stanley.mountain>
References: <20240828204552.26790-2-masingh.linux@gmail.com>
 <607b86cd-d89a-4072-af36-ce2ce5c1f7fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607b86cd-d89a-4072-af36-ce2ce5c1f7fe@gmail.com>

On Wed, Aug 28, 2024 at 11:08:31PM +0200, Philipp Hortmann wrote:
> > diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
> > index 6789a4c98564..6311ac15c581 100644
> > --- a/drivers/staging/rtl8712/rtl871x_io.c
> > +++ b/drivers/staging/rtl8712/rtl871x_io.c
> > @@ -48,10 +48,10 @@ static uint _init_intf_hdl(struct _adapter *padapter,
> >   	set_intf_funs = &(r8712_usb_set_intf_funs);
> >   	set_intf_ops = &r8712_usb_set_intf_ops;
> >   	init_intf_priv = &r8712_usb_init_intf_priv;
> > -	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),
> > -						    GFP_ATOMIC);
> > +	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
> >   	if (!pintf_priv)
> >   		goto _init_intf_hdl_fail;
> 
> By pushing the below statement after the "if (!pintf_priv)" you change the
> logic. Is this really wanted? Why do you think it is better? I would avoid
> this and it would be a separate patch anyhow.
> 
> > +	pintf_hdl->pintfpriv = pintf_priv;

I liked moving it.  And I feel like it should be done in this patch, not as a
separate patch.  But it should have some justification as you say.  The commit
message could say something like:

    Checkpatch complains that we should avoid multiple assignments on the same
    line for readability purposes.  Generally, we would allocate, check and then
    assign.  It doesn't matter what is assigned to "pintf_hdl->pintfpriv" on the
    error path.  For example, on subsequent error paths "pintf_hdl->pintfpriv"
    is a freed pointer.  So this code is okay as-is and it's also okay to move
    the pintf_hdl->pintfpriv = pintf_priv assignment after the NULL check.

(Notice how I sold this as one thing, moving the "pintf_hdl->pintfpriv"
assignment, not silencing checkpatch and then moving it.  Notice how I avoided
using the word "also".)

regards,
dan carpenter


