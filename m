Return-Path: <linux-kernel+bounces-363780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D299C6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A8C1F217AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90E2176FA2;
	Mon, 14 Oct 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUT0dEgs"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4E15B551
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900683; cv=none; b=n9alyD20AOxaz789jlvJ9aBL6iXzv3eFm2/vAnL/kSpBHh/DaSUQu9pk16nKeqr2tuXA1zPq1zhlFgv08K39708q9uWpDOtCVoQeB3zg4ZXF+aNeXDn+d60VyX+QLEYU0x5doBq7lo+/0GL2OpiYumthTbjG3/KTh3ObR8Ab2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900683; c=relaxed/simple;
	bh=45f5JP3bQWFt0F2u2LUbZ1L8HR/D6tqr+/MlO0jRbGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFRNPoUSJ16i3+O5c/a74/A+aOlq0AlILIBO544MHGPUAg/FNYmJtuu4yOHyXW4zNu0rhiPUvdbTusamG+falNOLQRMWA+kZzOjcThNvXRkdZ0RaV34yo5YKYWOlI3y2dgSv5Fm7Ixl141OzhlfhDfdADeYWKUtxnl61BaVlG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wUT0dEgs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99543ab209so613142566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728900679; x=1729505479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/LXd4VHO1p1BbKAcgczo+qxpSILM19q0yd+EHjEU8Q=;
        b=wUT0dEgsmBR3GlzZd17yP/ZDQQ9mI4Zz6mzvHTRlw7bTfyIMNPGBgxEOAL2+9lfwUt
         95Rj339sw5EJ7KhBuFCFh02eMlG47bwKM9nfFkTKuQA8CARscriehXSws0DicgWpU5Wj
         xjaz3EV8uW1zE4A4EUu6P63iconSvjU2ZfWRDM3JzJFhLeP9gpuWhIVwhPCWUbOntSNq
         pqvsQhhh3IvtQQ+3Jmuz4VEGBj/r0UeeCsbuqK115ZkXEXv6yOtQpkckGeHIQ6FkBhQC
         GVWruolIZPqsVUF6ePjiVAxQyKN6XPacYpjEwuDdRyBHht7ae5Nk5zDBqV88Z5XgIHKu
         6vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900679; x=1729505479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/LXd4VHO1p1BbKAcgczo+qxpSILM19q0yd+EHjEU8Q=;
        b=sEsxE5r/QBFwOORdov/IDv9C7sPY5LEpqELagjsYLWP3g/KZ/jNbvt/Js0A0h6agcq
         MUrS/FGVs7/dRij/r2gx5NC+XXuYusqwp7Le4lAZrwvgCR/Lbv8KeZPKqXZr0pYkzWYi
         smtSDgZbXux8yPj6b12wMdPNntuCIbw1bN2I4XQ41HNSP+PMdz/K05j6DmPkJlPRX7l5
         LBVJCxjDdQVnKWRa7aIQ31RxysAajrh1UcLJbEKSu0kf5w2Qg42CbdkiBAi6tNsqzOBu
         d6WY4myemt9wpCdaKxfgaCvItLaf2/xbsISTT7YIZNOGGqu84MRFeCerhD8Az/K0JmXe
         FSlA==
X-Forwarded-Encrypted: i=1; AJvYcCWjGSgXWm1myGisg4HYdqNbqaS0jGTrgUuBSWLRjhL5KKm0s0yAjM9KFwsJCOaBENoXuOpo8Fzth/0mYTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmV4PYoc0rsIYS8NQnGxApdD0KyH+Im4h+75dvxB+2oFS4yQI
	VdqvPhw9IPJhO94NaYyDjm5226qXffAl3ok1UCMbDH8qz5aLUvfQC2brkc5or9E=
X-Google-Smtp-Source: AGHT+IETPBBETQDag5kjsGc5Ue8CZM6ASCuWmb5sR/j8wYmAJr0+kZOnRg/kDq19oUGmuUzvrlzu2A==
X-Received: by 2002:a17:907:60d3:b0:a9a:1796:30d0 with SMTP id a640c23a62f3a-a9a179635dfmr119185266b.62.1728900679059;
        Mon, 14 Oct 2024 03:11:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99e57f763bsm337884566b.85.2024.10.14.03.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:11:18 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:11:15 +0300
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
Subject: Re: [PATCH v3 0/2] staging: staging: vchiq_arm: Two memory leak fixes
Message-ID: <3ec84f12-15b5-40c4-ba6d-137371d755d8@stanley.mountain>
References: <20241014100624.104987-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014100624.104987-1-umang.jain@ideasonboard.com>

On Mon, Oct 14, 2024 at 03:36:22PM +0530, Umang Jain wrote:
> Two memory leaks were identified and this series addresses those leaks.
> 
> Changes in v3:
> - Add Fixes tag to 1/2 as well.
>   (Suggestion by Dan Carpenter)

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


