Return-Path: <linux-kernel+bounces-362788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6899B94D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A39281BDD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119B13E88C;
	Sun, 13 Oct 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynVlWhdS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E413D50C
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728820796; cv=none; b=UQ2D7Ne5n+FWRFlJQduQFdMBnSERDr3JYRkbqFSHKpOzdOm3TJLPTi5eiM/gJlb25IEnDxCHza8qFrQbA1v+7nB7nrT9JtygpR+55TaZqRTsxaeqcLWi2t841IvHm52YtiWEk7KP4rVlEoGtj+jE5ocJl2X3u9/AGWoFeyX06+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728820796; c=relaxed/simple;
	bh=dBqHoJCLZRA1I6ILaOk1lEkDfPZsCfUEqNQP5Nbk14E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBF4DFodAhZ/wo8q9AqdGFL44BdI1gdNN8vIvBbn5DpAOqOYSbk4vSxBiJm4WX4BulfVSDCJUqnPLo2BZU1v6piMGAv1oLV9AeA+5ShLUuvI0Z5i9DoZ0r9OQMkg+Y5OB/SLZF8DR2x7AC0vyvkkTk6UtRqi6uGTQnUBAhIq2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynVlWhdS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43120f65540so13214725e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728820791; x=1729425591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHkkyDKC9jM/ugAi4FO1PJaa+9PRYsrHLgdKnQxGMbU=;
        b=ynVlWhdSqpmWaG8UnyFa5LXLiwBvqwIjy1ZSy0ZmkeNymVvE+7pnwoBYNiSYwJ0Ox1
         dxJ7XBGAUueNBl+rYkjsA/5Bi+oqdXK7F17CG5XRIVRppiBhWzJ0u1vWMvkRZhP6eSVO
         jEEmyyOdn8+69iMcXa1E1XfTwpaokkcjZhS/iEuAyiVE527MDW35Za3oLyworDwxoeG/
         x559MLRFesGzWsubLX07Gn61u6J2d8I04jdyxsPvi4QCDgN5FBLnOrL7TBbYSff63wlZ
         DVqiQmC7qnT0FCPvl0U6pFyvHCJ+YuIawsxlxTL/oenhy2jHv8QrtB2edWxKD+xXzVPA
         vYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728820791; x=1729425591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHkkyDKC9jM/ugAi4FO1PJaa+9PRYsrHLgdKnQxGMbU=;
        b=lJRQLwv/e4lUNRLkcjdY7F6vx+hMJDL1uI7F6rGQsIo8w6u4/6tq9BJHdXnoFJDXV8
         xpc7tTB62nKyO0bj+D9cxgwgrJXt1rqPRziCYx8uyQR3n1I/wa1QF5uGH/utUJMEl+s7
         n5kFN9+BPtgmpneiqAssdlxdvvOAUSLsso3hR2vRi0XxBBBeb+lCPRRfmL6tR+EAMFPz
         G8l4hzgPSoPo9+i5hrMnjW9nk9HxJRBg6PWZM9UWFZztCQjFxwEq5uIQDGyVgtqKFnA0
         dKoylOQYQvYXWZF488mR4HDuixVtk6FjCsjuBE1bEQZEdrMBfUiv2oUFg4OBHyCRvAnb
         /8yg==
X-Forwarded-Encrypted: i=1; AJvYcCV6tex9xaUyS629jhBEXaM7XSDelx3tesSFCqkXr/ceKQS4Txy2S95/1DFy8/UQ8VHzs/PV8W7X9zroiNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2uLcyQuN/0X+Z6n6Qq7wbnLeJOuL/P79PMVKTWQoFAlwUyNsL
	j44fzVmn8WkJUpTe3cfl5dCRIGMo7Ey6z8MnmnepgKp3vUTuN8gsiziMk88dm8Y=
X-Google-Smtp-Source: AGHT+IGTHTWoEetbHJHhk+MuiM1p3gpUVQ6kSkHyeXY9xdSvulussmgA6QK40F90KB/JXPu8nE1bCA==
X-Received: by 2002:a05:600c:1c9c:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-431255dcb1dmr48705055e9.13.1728820791285;
        Sun, 13 Oct 2024 04:59:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835696esm91419745e9.37.2024.10.13.04.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 04:59:50 -0700 (PDT)
Date: Sun, 13 Oct 2024 14:59:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 4/6] staging: vchiq_core: Refactor notify_bulks()
Message-ID: <bfe6dc7b-d34a-444b-98dd-a4b63e0bb751@stanley.mountain>
References: <20241012185652.316172-1-umang.jain@ideasonboard.com>
 <20241012185652.316172-5-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012185652.316172-5-umang.jain@ideasonboard.com>

On Sun, Oct 13, 2024 at 12:26:50AM +0530, Umang Jain wrote:
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index e9cd012e2b5f..19dfcd98dcde 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -1309,6 +1309,49 @@ get_bulk_reason(struct vchiq_bulk *bulk)
>  	return VCHIQ_BULK_RECEIVE_DONE;
>  }
>  
> +static int service_notify_bulk(struct vchiq_service *service,
> +			       struct vchiq_bulk *bulk)
> +{
> +	int status = -EINVAL;
> +
> +	if (!service || !bulk)
> +		return status;

I mean, I still wish you would return -EINVAL directly here.  :/

> +
> +	if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
> +		if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
> +			VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
> +			VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
> +						bulk->actual);
> +		} else {
> +			VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
> +			VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
> +						bulk->actual);
> +				}
                                ^
Indented too far.

regards,
dan carpenter


