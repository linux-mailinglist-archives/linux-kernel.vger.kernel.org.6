Return-Path: <linux-kernel+bounces-347632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B26298D862
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0AAB22DCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8381D07BC;
	Wed,  2 Oct 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJNUnUY2"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D51E52C;
	Wed,  2 Oct 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877509; cv=none; b=O76XhvVxhfZIG8UT3nQYvllP9yd/Vcr8FPZ8EM2C6shGTxJx2Nk622XBNjl05yp/+z7m2PB7v8Z6zUUuaMt8H+VR/eoJCbhlI5ppxQ6Qyx2fWYSZoDMbCQAEBwir5Ty1ZzNnUTzx4RWEbyKw2jtlk19WbcwBDeNrP4xTU6Ryo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877509; c=relaxed/simple;
	bh=EJNP89px1zjsAleC4L47Viq3XiP8moZtLyBuzzIUGB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmZmRqeYfPtem2h/sdvjaIN2mBWB5yt7X5jEKCk5VdsGJITy1tLBG3wRJduSf5IXTt9n4GCwxIkM1pX5xALMeJAb4oAvFbE9wFHGNPfCdx2eJm7dwe3aJfj4+jXWEyQnvvKQXk+vJ7zzWT2FYB+DwKO9bMLvUDXBfxcamPoI6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJNUnUY2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0af6e5da9so4453731a91.2;
        Wed, 02 Oct 2024 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877508; x=1728482308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN9PV+s+3cEgwu4eEUqyhCUsMLskrQvrEOYkp+sv850=;
        b=fJNUnUY2vHnwGGYeHX8EGPoLKP57E37sDO6k39UcUWt6W1eEVRIOu+k5ZvY2nDuFXs
         1K3l8uhF3peUYnullOm0/55hEJuO2vA9DxVfQBfTpB+/Kwq2NwFMIvsS8S4SGzdDL+wf
         +MMMhW0pNJ9g8LYsKtrVwrokYT5jsxkHqYbs/CHlz/dlH5qxK+IXGrQbNu3pH23JthVB
         FGV9SWGttMTqxou17/AdtDBpL9ZaMBKEo7vch3CxX4fykqhATrZZNHAOyOK/bfOwH0TQ
         fXl5b3Dgh3d/xgiHJ1GKo7o798ME8cvxZb1uyBfnp4Qt+pFLY8baffAXdmAhmthKdDjP
         iAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877508; x=1728482308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN9PV+s+3cEgwu4eEUqyhCUsMLskrQvrEOYkp+sv850=;
        b=wINJAJa0bbkfGuiuYzW9BiD7yGFcItwu+KRYJgAN9emYmx3JS2uMAuxxSVopHo9C88
         FpRyRuAMHnRF1jUbnUjXJ4YmX5OZs/k10VnxVeiUP/XzmRNXO/4XSfxTgqq+TnDP6eDN
         YYXGcF1JuPHVF3VA3Gxv+waGKym4wvxrQKLnPlhUtGDCW8WRoulAD3tCqo4G6zRGo5y3
         asiXzxzhPIgPJZhvVv2pdsdgB5WXQmIfi7T9enRiSIqRZ4xdelSyJlJO0JTlkn54m9x7
         EKK0hsk6e9xx/R2r8Stm9CvobUUbY4B4SvxxcHdBhn2vXTtkHFqEl6DXVCIsUxqFMfp5
         X8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCLhTOnE1xI2ZYeSDGqRvwOcjz3PlTPa3LKo+ThJW2G3uaITRq1wWtTnWCSR0KsDFV4EzKXl/DlsTlFyQ=@vger.kernel.org, AJvYcCWGwsDB6F1c88cxbwIumFyshV8jkJ/DctpDLBR+LKuG0ZGno7c8ccomHcTi1M6pv5qMgZ2hR9yxdQo=@vger.kernel.org, AJvYcCWrUc8puguIlA/Kb3TklqBBXtVno1y+gfEeA0kROwCtTbOmwlGOPoAf7KCTLZfazdQEBc7pWn86sZtM5/zl@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvP9WiTUWbSpa26eQwydn8yPm4/cR3TN20SE+M4frNIb/Ti6Z
	rAzb7kOKaV9NwPH674U9EzBRhFCq6ZdtNnlxSP0fAleZ8TVHqaKZ
X-Google-Smtp-Source: AGHT+IFcxSts6X+Wo3tYB2PTC0qtpQIfpybH1i4hQboxUVZDjxBhYx+oi5M7rC0CAD8dthOtPlRsDA==
X-Received: by 2002:a17:90b:4f43:b0:2e0:7560:9338 with SMTP id 98e67ed59e1d1-2e184901f61mr4036661a91.25.1727877507965;
        Wed, 02 Oct 2024 06:58:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f7501cfsm1572160a91.8.2024.10.02.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:58:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 2 Oct 2024 06:58:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: jdelvare@suse.com, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max31827) Fix spelling errors reported by
 codespell
Message-ID: <4c12538a-7393-444b-b898-7c38a4f5751f@roeck-us.net>
References: <20241001011521.80982-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001011521.80982-1-everestkc@everestkc.com.np>

On Mon, Sep 30, 2024 at 07:15:17PM -0600, Everest K.C. wrote:
> Below mentioned spelling errors reported by codesepll
> were fixed:
> 	respresents ==> represents
> 	signifcant ==> significant
> 	bandwitdh ==> bandwidth
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>

Applied.

Thanks,
Guenter

