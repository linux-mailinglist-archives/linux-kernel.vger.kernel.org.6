Return-Path: <linux-kernel+bounces-363455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B659199C2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E7AB20C25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D0374D1;
	Mon, 14 Oct 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywR6QiYT"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695713D537
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893536; cv=none; b=CXACCsbzK8DVZ+h4inSEvpWlqf58JiUiNJvbcasbQvOr8C5I+VphqXZ+4VuscsoMJ+8zkLMX+Kym3Yz8Y6qtdXDRcXRgcfHZu1NUza3W7SPvKVKy8vuUL9aViyqnf52W6hg3IAw5ciwPeR9MGdoqjW8pMzhZNRaLAZuijcb998g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893536; c=relaxed/simple;
	bh=N6DXl5dUodjaLdYlEnsT+YbVP0lQzc0egliZj/Wvn1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpqcX8nZyjk17xxCwve6MnMtTwoq4Jvf6N3X9AEK7VNk5okJSN/BbmrMAbbU4c6K4yFWUWT165GsfOKDpbwUDAYJI7NAWLgaIl2dhP6IxIcqlHai9cVZ8jfSnGadIKHOjWh7akeybICK+hqoX9jg9hwWLPSbiE4U/ncg9TmtquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ywR6QiYT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e690479cso1441812e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728893533; x=1729498333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aUotu0T3e6PAlRn40+hIj+iMbjMPli1mQQP9Z0ha7g=;
        b=ywR6QiYTnKNxegiFX3ZdT2HCnGLwRjGLnFOaIWohbMZJtILYAk71zGtoD67XE7235Y
         TT7441s2o1E5BwBbp6WC+7vjIrktZNgwb/Y7DBg4Z+AD8q6iC4tDho4/78wP6GtxeWaW
         clvhB7xb8vjUMkrkuoG1GnttYu6Y1bUi3tz5ODtcWLOjbYWnq6pfbNo0wKGusmB5F2Yo
         86SrzUTOb0pk2+6L615x8HcAbCjaACOcPuPqqlAr+UP3eV20G/ZmBH5UKp7rdDxFofBq
         i42nqJ26ieGxfBzmo63NmrxFbABMvGFDFMSvSMN9GTvp9rF3wFhykJywBw2ynVCEtWxf
         UsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893533; x=1729498333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aUotu0T3e6PAlRn40+hIj+iMbjMPli1mQQP9Z0ha7g=;
        b=NftaQUJGylNsWduBajRg0S/paAMAmJ0nbamkCbCQyKHMdOEWCp0f7VVx2a4rgwd4e6
         h0giyl1CZnRzTPuPHi6bZ8eaKTkJVWzd6wrsZfjQjFpqBxa1grulS/QN6VzlfCLmEgxB
         OkaGa5pKSs4Vf73fRB/hLjGFApJQApBI4y64+VlyvfJGOsTEOMA/wYo6VSzVRPI58WKw
         SO+wbbKq2z6kiHjRHWOkZvYm014CAsE5u2CbGLh6oRaxfTjwcRvx5Bn+ILj1q4S7fOgf
         oZnaF6FTRS8rw4fVu/ewmfDwF8vDbyMwZbYYG7WQtvWazecYN+J2uD9+NQ3Buaox1CYh
         vVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfMjeIRXkMFJPZj8HSGqSkQGqbOLUgL38BXRwWbRmMpPOmF6zwKe+wTaiFmm4pgtL7qKjgM4e2EiTK8VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bfVg/Qi+5ZZm65lZ9D9Kv/pXVbcToR1pMvcnT7Q16O9ejKNK
	3KBnmdW3TMmc6Bw9PkkpPWhB8gtirHZgX+Gy7XAauW6N3VE6DjAnXVTl1bAZo5U=
X-Google-Smtp-Source: AGHT+IHabo12la2Izo7lgweHkaqt7UEpu96db3u9lfxdb6EZEcpv7L6pwcbsTeO7dm1LFg5+sjT8tg==
X-Received: by 2002:a05:6512:33cd:b0:539:905c:15ab with SMTP id 2adb3069b0e04-539e55187aemr2575627e87.32.1728893533118;
        Mon, 14 Oct 2024 01:12:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf43da8sm146036375e9.11.2024.10.14.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:12:12 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:12:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
Message-ID: <767f08b7-be82-4b5e-bf82-3aa012a2ca5a@stanley.mountain>
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
 <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>

On Mon, Oct 14, 2024 at 09:59:49AM +0200, Javier Carrasco wrote:
> This approach is great as long as the maintainer accepts mid-scope
> variable declaration and the goto instructions get refactored, as stated
> in cleanup.h.
> 
> The first point is not being that problematic so far, but the second one
> is trickier, and we all have to take special care to avoid such issues,
> even if they don't look dangerous in the current code, because adding a
> goto where there cleanup attribute is already used can be overlooked as
> well.
> 

To be honest, I don't really understand this paragraph.  I think maybe you're
talking about if we declare the variable at the top and forget to initialize it
to NULL?  It leads to an uninitialized variable if we exit the function before
it is initialized.

> Actually there are goto instructions in the function, but at least in
> their current form they are as harmless as useless.

Yep.  Feel free to delete them.

regards,
dan carpenter


