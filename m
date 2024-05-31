Return-Path: <linux-kernel+bounces-197386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C08D69ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969461F2840C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043B17D341;
	Fri, 31 May 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEjD+wln"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BD20DCB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184523; cv=none; b=JCpF6WpktRORE0n/Fq0hflW7ZvYYlBL4wna9sG9QjMQXa9p0Ag6Af2sHd8AF8dU6ShTqcQUADn/D/SyERM/RIQxtG2P0MJwsFd6dARXYREjKbhcGxLCdK+b8NwFgKfOJu8TVnqMZQqbEJj6LG6s0WafqQDT2Tgx/sE1nE5RiQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184523; c=relaxed/simple;
	bh=tNZXFB+HzysXCL3SMJvzwkWGT1EYNKCv4E1TAW2tYXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpOvRbZtk1Yn9fhEORGrwMK4PmqNhI8aBE7V7Jg0qZzuFtFoLoZ4936MjSzd9oZ98B3pM1x3uzl7GvIeMktw15k16o9gVtJxzU5QMalV4pntb20KkXl0MXJYkTJE2fQl6b66jQzru12UYj7kmdJLK+VCScO9tczfgd2MM81ISjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aEjD+wln; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so30873451fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717184520; x=1717789320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ0301p+dghmUaCnTpXNdQ1J5YZlPh76f8+4DGjY0+Q=;
        b=aEjD+wlnaursSteHIgesXjt1SzJamqzKfdVbd6BuKqrSbbNdsmfNCadRNLD5NEMIGx
         Ksj7/ucilsv3OgTfjGIKN4NBORy71U0knIxzEmSb+xldoX5vk7EiGyCpu8ohCdpQEuLq
         5lVbNL6DgKIR2fooEWhLMZUPNNw3opzQ9cKzGNocQumfo3gm1Z578xlSR6Po3jFN0mgS
         vIjVeYkhEBMErdhuOdld4eSUEL3gHDKVG5iS5edHMu2JHh//mImDS8WD7c4K4Q7Kz5S5
         uoD+ZEvqZ1iM9C1eUnHrl93OpuSV+DvImYMjY2ajszGLhJPUtOKdNTV00dMMVf04rxDx
         3cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717184520; x=1717789320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ0301p+dghmUaCnTpXNdQ1J5YZlPh76f8+4DGjY0+Q=;
        b=QVSABxOba/SPNwI4FbGoOZSEB/sOnscFPi0XQ+NLO824j6Ae1g89DNc4KXMwOzFMat
         KOTSbYq5JFpnT5vsCVk5Lspj4wq2TDU+p8NCct1Ti9NOKHznSyV+3ZZ9jhEgzosu0fwA
         2CK2NxWa+jVUEOtYVW+JNWeXCawzxC9aveKeLH9k0uUX2f6h68LWuo0KCg01SNBRyEFy
         TR8JCK1UV7Kw9pmYzXTCq8ioxXHwCTJWskYb7AHlExCV8APrn/eXHdGlpViMW9dR2jpU
         HtTsqht9K8hqYOhX9CSGsZJg14prbWaqIKLdGzgNo7n2YA2OP4i4SD5mlrzVc1YbvLBx
         A/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4k+UoKZz25MrHecKKl+YEiGPyGVDUx/9XNkCb5DHnePIOkYWKrgoaScksP4N1/48p7+rBw0dx3Y0fHKTiLCWv7VDz41PKWpMpjuba
X-Gm-Message-State: AOJu0Yxx+yRWRHuRAN3AUJcZyL9oAbQou75JFxNvDbC2+5Sh/zAacf4R
	vH3PinAORBhqEuSYhJfhWCkIAUMZO3+XMWgieuP7NcxuPZlPSskg2cIfGsHKJS8=
X-Google-Smtp-Source: AGHT+IF4pO0JCQm2es2gv8MurHgCDQYtjCA/ts7nYsSQCEEAQtgW1TUMv3lIPinW0+x0qwguCCjMKg==
X-Received: by 2002:a2e:8756:0:b0:2e1:ba1c:efea with SMTP id 38308e7fff4ca-2ea950f8729mr20314681fa.19.1717184519743;
        Fri, 31 May 2024 12:41:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91b9d999sm3753471fa.16.2024.05.31.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:41:58 -0700 (PDT)
Date: Fri, 31 May 2024 22:41:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v5 2/4] usb: typec: Update sysfs when setting ops
Message-ID: <g4a5cfodzudb2eqgvvcot7kmentahfqs7m5ibchx3tdszikp45@p6c5xgyyaixq>
References: <20240510201244.2968152-1-jthies@google.com>
 <20240510201244.2968152-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510201244.2968152-3-jthies@google.com>

On Fri, May 10, 2024 at 08:12:42PM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> When adding altmode ops, update the sysfs group so that visibility is
> also recalculated.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

