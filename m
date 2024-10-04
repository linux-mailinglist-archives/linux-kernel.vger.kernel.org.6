Return-Path: <linux-kernel+bounces-350055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8198FF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9156F2825DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAA13D53A;
	Fri,  4 Oct 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdOJlfG7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526612D20D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032473; cv=none; b=tgyM19dZn2X3TQm7fezZJR85ucHlhRdHfHzZ0Q8hB0KjXWcLXqKehzRLbf7sdFq9SYE12EPFP7pdZcdzE0/8oVduxasWMt5dHCTTB74ZqOOrF9vBem2o74cXP23YP5HaVTHz0mym63z3QNd3BnQZ1sc0biI7CsD2wT5/VKmHiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032473; c=relaxed/simple;
	bh=dXkff5X4f2aO5FSQf7DH2ZEj+n5WLcizAHNEHDT0LpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhMCWXxMImvYjw7L04Qu64Hgk3jyA/Sdu39oFQcnamK6SilzgbIMdnswRgP5v1b5KZvc7ck11FvL6wVB9aANehDJTNePvhuKqquqntMzstmeDz7VR1hlSum023rRs79tzUDl8pUSW2rdgkBnvBJJo/B26uw7j1E+X+SnssCv4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FdOJlfG7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso17357935e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728032469; x=1728637269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LcemWjXMW7EZND3msCXeV1BDAvqAABSJZyGqgZUq/M=;
        b=FdOJlfG75NRUFcpPj51gQLAok1TTbjoUAdQcOPF/6829eqpB5n8y2MNOuiVCspaOpU
         eDsnXF22HnvhPFVD7zNFircFDjDTTPCPNCZXezP+u6Wa/e8Dpftezq1GvYZDOXUyfV/c
         rYeGMq+34e3f74sw19s01k1FO7VS0lubmZHyT6lzUR4zO2b4WADwaae2vn/w7xzDF3ZY
         9R6P+zhB6s8dzvNbqoEUvURXod8Za4NR04Bpt0A4QSrv18vQ618tqcuttlJCug+IUCHO
         wcwfzkVClNdVrvzsSljlj9fvehGtcz81sPgYpWr2NR+51Vuyrt4K66FNGkBY4xNViEsX
         50qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032469; x=1728637269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LcemWjXMW7EZND3msCXeV1BDAvqAABSJZyGqgZUq/M=;
        b=bUlrRIRy/k+yCJB0vgANP+f5Dp2z95xpqJH0C6+3mHw6ipzqgKvAvNjn0HjBD2HqHt
         t4Ib14GFh5bHeY9lZefDDXX0YXXziTibRTAmj+1XKSi5fXaiXIVLe09K4S22SOyjQaGi
         PcoMsibGR7jTvao9Y8BLVBsAn+uVCA3p6oENYtOz0n/14A17zCeejjkGNUvb66WiVZOa
         HU7pvUxAtZ4ypnYcm2/ZobswCOEgDjovHnldUR7PZSnlcERExVctiHpzMtGL1zC1K9Iz
         JEMEfF2dC5ta7zO704uGo0+0ISQ5jjRD0wefkT/jd3SuexIOdRO/7RfhyEMl1t+m4hTb
         t11A==
X-Forwarded-Encrypted: i=1; AJvYcCWrVGDD7VeFOkPmfComcRtBFURJ2BpcTiLjtHyfMX9DCUZ2LbFZOG7OJeksfYkVBYuWiw8cU9+//5arrSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHw1uJ5Bhd6NRdgPjPABmqyCK+ypScs3+uK1tS+vQJVlMyTDuI
	yAbr45Zh75bIphRMOvkfGhwBw7hHe9VADrGqtAhTYLvOi3fZL7t2qlX5qIcRxRo=
X-Google-Smtp-Source: AGHT+IH2F097a9rbFrai1UAcOgCa03oAlZmgpU9uxn3bVQHoFviJk2Zrku/H1KBvh8/iLOntHx6elw==
X-Received: by 2002:a05:600c:3c92:b0:42c:b73b:fb43 with SMTP id 5b1f17b1804b1-42f7df9fe14mr39717125e9.12.1728032469047;
        Fri, 04 Oct 2024 02:01:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a201fesm10354345e9.1.2024.10.04.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:01:07 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:00:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jonathankim@gctsemi.com, deanahn@gctsemi.com,
	gregkh@linuxfoundation.org, ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: fix returning -1 with return
 equivalent errors
Message-ID: <47723ac6-9131-49f2-8746-1bc8845187cf@stanley.mountain>
References: <20241004022025.7015-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004022025.7015-1-rodrigo.gobbi.7@gmail.com>

On Thu, Oct 03, 2024 at 11:20:25PM -0300, Rodrigo Gobbi wrote:
> As in the TODO file, use proper error codes from PM callbacks and init.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Only one reference was left, regarding the packet_type_to_tty_index() but
> I think it's reasonable to keep it that way since it's for tty index purpose.

Better to return an error code there as well.  It doesn't change runtime
behavior at all, we're just having a discussoin about cleanliness.  I think
error codes are more clean.

> 
> There is a RFC to delete this driver at [1], so I'm not 
> sure if this change is worth it. Anyway, I'm submitting 
> it and I'll be waiting for an opinion about this.
> Tks.
> 
> [1] https://lore.kernel.org/lkml/50020db0-3bad-41f5-8da3-c66bc0a90fe6@gmail.com/

Most likely Greg will keep merging patches until the driver is removed.  It's
up to you to decide if it's worth your time to keeps sending the patches.

> @@ -991,7 +991,7 @@ static int __init gdm_usb_lte_init(void)
>  {
>  	if (gdm_lte_event_init() < 0) {
>  		pr_err("error creating event\n");
> -		return -1;
> +		return -ENODEV;
>  	}

This should be:

	ret = gdm_lte_event_init();
	if (ret < 0) {
		pr_err("error creating event\n");
		return ret;
	}

regards,
dan carpenter

