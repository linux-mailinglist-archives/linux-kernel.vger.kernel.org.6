Return-Path: <linux-kernel+bounces-361337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BCE99A6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F061C2131D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327831411C7;
	Fri, 11 Oct 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwSlHYx1"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF88172D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658425; cv=none; b=HhwQg73oxJPfwkhN0Whr9QCpSavQN461wPkJq9O7TwJAPEOwMKzayCoxQp3zntxszn/AaAQ6D5FTdbgMJb2s0XdKS77sW/Q16XFFgBH88cTy3Gd2t+YCuf3Zf8mbef5Tb28+VXq+A2EsJ86me9C4fbOMfvyWDeeE+0VERj/iucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658425; c=relaxed/simple;
	bh=7QRZYjUBQ+96Ygj5xRkUM1nxecEvwSbvArMzWPoyTes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z38tM9FwOFEwZcYwXyUp6h6DkLLIFzfMAs8YJQ1JOcgLeilFyFObEkrM5yMn3Kp8iHMpIIY1Wet0gS40FoA+DztEuHAbaLtod6JRxVbgFbuPl94HPiV7GDHn2IAWjPqbfaEzbjHFIoTq4Ok9t+wiSEtdCYabgqo95YETWdfrWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CwSlHYx1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac60ab585so20818671fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728658422; x=1729263222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WilxIEbfSQXrWwCv2V/AYzlWOc3cI7NOnhWdHqs7NlU=;
        b=CwSlHYx1fMpjWY7ETpQvULqOM9DumwVU2i9Gtq5M9u9J9u5+73S+6ug4JpG5HFVM8G
         UgWZdXWUUuGOn2aFebKZqLPU4HetcY06COwbwth/A4zHOK8eBO+nCDqZmOdqn+zKyBvc
         PhdHl+4d7Pnc/ZJISI4JHagNKSmZce6BJNTaWNei+izjr6Ci7lxqWwNzQ7O2lx280AT/
         AoDuPq5E+kXUVAebdkFgEIGtCgTDTrUyiYMyQXXQ+AXSTTvW6Cpf/A7m347yxu649eci
         20/IwwJ20/DN796v3UDjCkBiEhbmr/xE4DPgp8hvBgpGIp/i6aZlNG3Hre67ZUa5Fn57
         YGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658422; x=1729263222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WilxIEbfSQXrWwCv2V/AYzlWOc3cI7NOnhWdHqs7NlU=;
        b=DaWiBYNYhAdKQXTHWL0W2HSg6eu6tNZBxV2Q0oAQf+kMtH4tyxw95dArNM8EXOT3s2
         yMhyDbI9YL/2J3iWIPn/mMsZvWmlNtH+jP4KAcheYqff+F8zUzw3mdFwo7/iypIoC3H9
         YCVoP5dNEv4qk3FbxtxuYydoHd8PCKMzg9yyXX3kS4MHGi+aSSyzf5nuvQSwgd1JhYgo
         mLQsyA4MF/UIx0of6gHNh093Hp25Pqk68ScVs3p3CS6+6eVEuZILJYWOl3DIhFG973Ku
         rMKobwCO/2c49UgchA35eb1+0gmGnxbMA2s9WPOa/b2DJbjnqcmArra2OCD+tICqleZn
         AlPg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3u2jBQkIymuBKjw5l6yzPRTe/UllQt/ct53sG7906Cu6/E7yEWInhFRd3rXigCB1ZBJCYhG1BlGezhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNlum+1aEPW+ExQ6ZLoA3zL3dqhN7M1QrwIhR4fPqQrOasm3s
	mtUAx/4z8dyYggVPaoVDFm97gRC6+my3tSN/fD++6YwwjxUn2UFs5McGhF5u1z4=
X-Google-Smtp-Source: AGHT+IHpf8cGOi0GcvL3UceMJRHebz12f6bF9cgghtjSOyLiDpwIfu/xKtaMCZelIh0/N5fHBXfWGQ==
X-Received: by 2002:a2e:b794:0:b0:2f3:f8d7:d556 with SMTP id 38308e7fff4ca-2fb3274097fmr13491161fa.18.1728658421847;
        Fri, 11 Oct 2024 07:53:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d445sm76950695e9.44.2024.10.11.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:53:41 -0700 (PDT)
Date: Fri, 11 Oct 2024 17:53:37 +0300
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
Subject: Re: [PATCH v2 4/6] staging: vchiq_core: Refactor notify_bulks()
Message-ID: <e366d563-3560-45f5-aff1-5291a5407c15@stanley.mountain>
References: <20241011120910.74045-1-umang.jain@ideasonboard.com>
 <20241011120910.74045-5-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011120910.74045-5-umang.jain@ideasonboard.com>

On Fri, Oct 11, 2024 at 05:39:08PM +0530, Umang Jain wrote:
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index e9cd012e2b5f..5509f8b1061a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -1309,6 +1309,48 @@ get_bulk_reason(struct vchiq_bulk *bulk)
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

Just return a literal here.  s/return status/return -EINVAL/.
This condition is impossible and the caller doesn't handle the error correctly.

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
> +	} else {
> +		VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
> +	}
> +
> +	if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
> +		struct bulk_waiter *waiter;
> +
> +		spin_lock(&service->state->bulk_waiter_spinlock);
> +		waiter = bulk->userdata;
> +		if (waiter) {
> +			waiter->actual = bulk->actual;
> +			complete(&waiter->event);
> +		}
> +
> +		spin_unlock(&service->state->bulk_waiter_spinlock);

We always return -EINVAL for VCHIQ_BULK_MODE_BLOCKING.

regards,
dan carpenter

> +	} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
> +		enum vchiq_reason reason = get_bulk_reason(bulk);
> +		status = make_service_callback(service, reason,	NULL,
> +					       bulk->userdata);
> +	}
> +
> +	return status;
> +}


