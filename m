Return-Path: <linux-kernel+bounces-347629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38598D843
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9781C22D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FB1D0B8A;
	Wed,  2 Oct 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKo4IlOo"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187791C9B91;
	Wed,  2 Oct 2024 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877462; cv=none; b=SOS55RXDIm0YPvvZDCrkDPMCwVvryHgVkxTa3ZaCtbd5eWvlivd6pmKCXiJmUdNEse++/rJ+n5uD+3gDFGsdrFhUOFnss0LR0Yw4t4O1pY7Xa3+9ZOL78WCp7mwc78+z2F40fVl8P5nFOMQ3j8OJtpUwP2WO/7Kxx17CkhxGUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877462; c=relaxed/simple;
	bh=LH6L94GEEqvIdAa0vGUH12i4JosRRP033hd+BtGrnXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtEPhWVBsAicSChhxa4qnu54XD3ZLvSrWvoIK/yB2Ihr9H7APahogqOfWF1Muiju4kg9MOZHkPAe7LvBOK+qp3qyBU6+tnvnqVTsFV1XGQs5drBkN8V2N/GtogIodC7VjdNNnIr4bPLyCeAXegUIsMcqvHbetJEk48zATWg0S5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKo4IlOo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d50a42ce97so2874199a12.0;
        Wed, 02 Oct 2024 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877460; x=1728482260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AX2Itf3reAHHEzU1UbsGkk9MlAO/ZiiY+T2pczEHW4=;
        b=cKo4IlOowIv4UhvOd2bVVCRuZWsEdCJwgTnC2n5ezZdyi80BK8nvJVYT9jG7rkCmHs
         UGb7refVPvbR4KpbftPWhvol/iyRZWEcG+KJtgBfFJj+vfnzJDj7Gfg8vUK7fZBXa4k2
         dkQ0hHNnoWszVpmPPBPZoE+xubPD9AqSDsL33AvGyFYHsACC1mHwxDLyBPib4uLpC58b
         MSeOBdKuUd0DddOyNaTLoMu40rFWtcyGLqtnqqJ7eJ3r1G1aBz4aZLlAEEGEcUxf7F3f
         NOR4+AJY95xTKXVt5WZ0EQyrNxhQIIC60xS0D9MBiDAJqdWmT9IpVf53o5mxBhvGM5nD
         oYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877460; x=1728482260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AX2Itf3reAHHEzU1UbsGkk9MlAO/ZiiY+T2pczEHW4=;
        b=CI5p8OBr8YZJvJ5jIoPZf580pG7DY8eBdbWONhYTJFjvSzcKwE47U9mMFBJkM8DouC
         QJXO2Llptv9TXXba5gnfd4JpFWvNytzh2632/CK94z7/SPflXdyVTi41R/0pY5BDEZ9/
         +5weCjwNt4/Dy1t7mH5/CfT23kG2AEHwB3AozZzhfHmG+mHYEWpcoMP+9vrzsz7es+8G
         cFA9CLNLgeXcE3izz9aOKi2G5y6PPHOLt/GFjDkCrVD/xmILpN+8JjxA3dQXPNKMQtvL
         Z3nCKl/la2rL1GiTiN4X7XBh4pELM/GIb0asN2U0vvJ87sJb1KKzPmXqB6pCQMaGh2Dk
         yBBw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Uya6d+LwV/48okYKyk3kb1EpGpfeKnfqcgtZNdmxjcrQUA/OO+upBssZmUT1ZJPF/lNEd2sgKlTjk2D9@vger.kernel.org, AJvYcCVYMZu2zLX834fSF8JBaGmgbUXEaSAkboHV5jLD/BhJxYA7wMUngQ8WYo8cNpjyfAN9RqISnEuxlLce2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIo+gYO1CHdQKfyIBOnL2NRRdxIXXE2ojp6DjdnhbEpsHSf1+D
	ZFIEmG1LrN6Yxj3X9FzF2Cg+UzHyiy4w2xo07j5MePJ4d3Ihl76lmX2i0Q==
X-Google-Smtp-Source: AGHT+IGXoUX6IT9ewxC9B/jhKNAM2qJ+4DhiiduyaEZJl3v6YMo9acYUAEwcHNwBDwB/E9K/RQgjHw==
X-Received: by 2002:a05:6a20:c781:b0:1cc:e43e:3a01 with SMTP id adf61e73a8af0-1d5e2cb391emr4735243637.33.1727877460367;
        Wed, 02 Oct 2024 06:57:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dcd2ee4f0sm1140177b3a.205.2024.10.02.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:57:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 2 Oct 2024 06:57:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] hwmon: (max1668) Add missing dependency on REGMAP_I2C
Message-ID: <34644c25-0582-48c3-898e-e77b231275ee@roeck-us.net>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
 <20241002-hwmon-select-regmap-v1-4-548d03268934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-hwmon-select-regmap-v1-4-548d03268934@gmail.com>

On Wed, Oct 02, 2024 at 03:08:11AM +0200, Javier Carrasco wrote:
> This driver requires REGMAP_I2C to be selected in order to get access to
> regmap_config, regmap_bus, and devm_regmap_init_i2c.
> Add the missing dependency.
> 
> Fixes: 021730acbca6 ("hwmon: (max1668) Convert to use regmap")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

